<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Character</title>
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
                String char_id = request.getParameter("char_id");
                String char_name = request.getParameter("char_name");
                String rarity = request.getParameter("rarity");
                String base_probability = request.getParameter("base_probability");
                String ability_type = request.getParameter("ability_type");
                String char_class = request.getParameter("char_class");

                // Check if char_id is provided
                if (char_id == null || char_id.isEmpty()) {
                    //out.println("char id error");
                    status = -1;  // Invalid submission
                } else {
                    // SQL query to check if the character exists by char_id
                    String query = "SELECT COUNT(*) FROM character_record WHERE char_id = ?";

                    try {
                        // Establish MySQL connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        //out.println("connecting to sql");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "pass");

                        // Prepare statement to check if the character exists by char_id
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, char_id);
                        //out.println("checking if exist");
                        ResultSet rst = pstmt.executeQuery();

                        if (rst.next() && rst.getInt(1) > 0) {
                            // Character exists, now update the character's information
                            StringBuilder updateQuery = new StringBuilder("UPDATE character_record SET ");
                            List<String> updates = new ArrayList<>();
                            
                            // Allow character_name to be updated
                            //out.println("adding edited variables");
                            if (char_name != null && !char_name.isEmpty()) {
                                updates.add("char_name = ?");
                            }
                            if (rarity != null && !rarity.isEmpty()) {
                                updates.add("rarity = ?");
                            }
                            if (base_probability != null && !base_probability.isEmpty()) {
                                updates.add("base_probability = ?");
                            }
                            if (ability_type != null && !ability_type.isEmpty()) {
                                updates.add("ability_type = ?");
                            }
                            if (char_class != null && !char_class.isEmpty()) {
                                updates.add("class = ?");
                            }

                            // Append updates to query
                            updateQuery.append(String.join(", ", updates));
                            updateQuery.append(" WHERE char_id = ?");
                            
                            //out.println("adding edited variables");
                            // Prepare the update statement
                            PreparedStatement updatePstmt = conn.prepareStatement(updateQuery.toString());
                            //out.println("adding edited variables");

                            int paramIndex = 1;
                            // Set parameters for the update
                            if (char_name != null && !char_name.isEmpty()) {
                                updatePstmt.setString(paramIndex++, char_name);
                            }
                            if (rarity != null && !rarity.isEmpty()) {
                                updatePstmt.setString(paramIndex++, rarity);
                            }
                            if (base_probability != null && !base_probability.isEmpty()) {
                                updatePstmt.setDouble(paramIndex++, Double.parseDouble(base_probability));
                            }
                            if (ability_type != null && !ability_type.isEmpty()) {
                                updatePstmt.setString(paramIndex++, ability_type);
                            }
                            if (char_class != null && !char_class.isEmpty()) {
                                updatePstmt.setString(paramIndex++, char_class);
                            }

                            // Set char_id for the WHERE clause
                            updatePstmt.setString(paramIndex, char_id);
                            //out.println(updatePstmt);
                            // Execute the update
                            int rowsUpdated = updatePstmt.executeUpdate();
                            updatePstmt.close();

                            if (rowsUpdated > 0) {
                                status = 1;  // Character updated successfully
                            } else {
                                status = 2;  // No changes made to the character's details
                            }
                        } else {
                            // Character not found
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
                <h1>Character Updated Successfully</h1>
            <%
                } else if (status == 3) { 
            %>
                <h1>Character Not Found</h1>
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
