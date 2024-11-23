<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update an Account</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: "Roboto", sans-serif;
                font-weight: 700;
                font-style: normal;
                background-color: #FFFFFF;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }

            form {
                position: relative;
                background-color: #ffffff;
                padding: 20px;
                border: 2px solid #000000;
                border-radius: 10px;
                width: 300px;
                text-align: center;
                z-index: 2;
            }

            h1 {
                font-family: "Roboto", sans-serif;
                font-weight: 700;
                font-style: italic;
                font-size: 20px;
                margin-bottom: 5px;
            }

            input[type="submit"] {
                font-family: "Roboto", sans-serif;
                font-weight: 700;
                display: inline-block;
                margin: 10px;
                padding: 5px 20px;
                font-size: 13px;
                text-decoration: none;
                color: black;
                background-color: #FFFFFF;
                border: none;
                border-radius: 5px;
                box-shadow: 0 4px #000000;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
                text-align: center;
                outline: 2px dotted #000000;
            }

            input[type="submit"]:hover {
                background-color: #e8e8e8;
                transform: scale(1.05);
                outline: 2px solid #000000;
            }

            input[type="submit"]:active {
                background-color: #d1d1d1;
                box-shadow: 0 2px #d1d1d1;
                transform: translateY(2px);
            }

            .button {
                display: inline-block;
                margin: 10px;
                padding: 5px 40px;
                font-size: 13px;
                text-decoration: none;
                color: black;
                background-color: #FFFFFF;
                border: none;
                border-radius: 5px;
                box-shadow: 0 4px #000000;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
                text-align: center;
                outline: 2px dotted #000000;
            }

            .button:hover {
                background-color: #e8e8e8;
                transform: scale(1.05);
                outline: 2px solid #000000;
            }

            .button:active {
                background-color: #d1d1d1;
                box-shadow: 0 2px #d1d1d1;
                transform: translateY(2px);
            }

        </style>
    </head>
    <body>
        <form action="admin.html">
            <%
                int status = 0;
                String v_player_id = request.getParameter("player_id");
                String v_player_name = request.getParameter("player_name");
                String v_join_date = request.getParameter("player_join_date");
                String v_account_bal = request.getParameter("account_bal");

                // Check if player_id is provided
                if (v_player_id == null || v_player_id.isEmpty()) { 
                    status = -1;  // Invalid submission
                } else {
                    // SQL query to check if the player exists by ID
                    String query = "SELECT COUNT(*) FROM player_record WHERE player_id = ?";

                    try {
                        // Establish MySQL connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");

                        // Prepare statement to check if the player exists by ID
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, v_player_id);

                        ResultSet rst = pstmt.executeQuery();

                        if (rst.next() && rst.getInt(1) > 0) {
                            // Player exists, now update the player's information
                            StringBuilder updateQuery = new StringBuilder("UPDATE player_record SET ");
                            List<String> updates = new ArrayList<>();
                            
                            // Allow player_name to be updated
                            if (v_player_name != null && !v_player_name.isEmpty()) {
                                updates.add("player_name = ?");
                            }
                            if (v_join_date != null && !v_join_date.isEmpty()) {
                                updates.add("player_join_date = ?");
                            }
                            if (v_account_bal != null && !v_account_bal.isEmpty()) {
                                updates.add("account_bal = ?");
                            }

                            // Append updates to query
                            updateQuery.append(String.join(", ", updates));
                            updateQuery.append(" WHERE player_id = ?");

                            // Prepare the update statement
                            PreparedStatement updatePstmt = conn.prepareStatement(updateQuery.toString());

                            int paramIndex = 1;
                            // Set parameters for the update
                            if (v_player_name != null && !v_player_name.isEmpty()) {
                                updatePstmt.setString(paramIndex++, v_player_name);
                            }
                            if (v_join_date != null && !v_join_date.isEmpty()) {
                                updatePstmt.setString(paramIndex++, v_join_date);
                            }
                            if (v_account_bal != null && !v_account_bal.isEmpty()) {
                                updatePstmt.setDouble(paramIndex++, Double.parseDouble(v_account_bal));
                            }

                            // Set player_id for the WHERE clause
                            updatePstmt.setString(paramIndex, v_player_id);

                            // Execute the update
                            int rowsUpdated = updatePstmt.executeUpdate();
                            updatePstmt.close();

                            if (rowsUpdated > 0) {
                                status = 1;  // Player updated successfully
                            } else {
                                status = 2;  // No changes made to the player's details
                            }
                        } else {
                            // Player not found
                            status = 3;
                        }

                        pstmt.close();
                        conn.close();
                    } catch (SQLException e) {
                        status = -1;  // Error during processing
                    } catch (Exception e) {
                        status = -1;  // General error
                    }
                }

                // Output result based on the status
                if (status == 1) { 
            %>
                <h1>Player Updated Successfully</h1>
            <%
                } else if (status == 3) { 
            %>
                <h1>Player Not Found</h1>
            <%
                } else { 
            %>
                <h1>Update Failed</h1>
            <%
                }
            %>
            <input type="submit" value="Return to Admin Menu">
        </form>
    </body>
</html>
