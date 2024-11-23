<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account processing</title>
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
                h1 {
                    font-family: "Roboto", sans-serif;
                    font-weight: 700;
                    font-style: italic;
                    font-size: 20px;
                }
                
                h1:first-of-type {
                    margin-bottom: 5px;
                }
                background-color: #ffffff;
                padding: 20px;
                border: 2px solid #000000;
                border-radius: 10px;
                width: 300px;
                text-align: center;
                z-index: 2;
            }

            input[type="text"] {
                font-family: "Roboto", sans-serif;
                font-weight: 300;
                font-style: normal;
                text-align: center;
                width: calc(100% - 20px);
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
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
    String v_pull_id = request.getParameter("pull_id");

    // Query to check if record with the given pull_id exists
    String query = "SELECT COUNT(*) FROM ingame_transaction_record WHERE pull_id = ?";

    try {
        // Establish MySQL connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
        System.out.print("Connection Successful!");

        // Prepare statement to check if the pull_id exists
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, v_pull_id);

        ResultSet rst = pstmt.executeQuery();

        if (rst.next() && rst.getInt(1) > 0) {
            // If pull_id exists, proceed with deletion
            pstmt.close();

            // Prepare DELETE statement to remove the record with the given pull_id
            pstmt = conn.prepareStatement("DELETE FROM ingame_transaction_record WHERE pull_id = ?");
            pstmt.setString(1, v_pull_id);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            status = 1; // Record deleted successfully
        } else {
            // If pull_id doesn't exist, set status to 2
            pstmt.close();
            conn.close();
            status = 2; // Record not found
        }
    } catch (SQLException e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
        status = -1; // Error during deletion process
    } catch (Exception e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
        status = -1; // General error
    }

    // Output result based on the status

    if (status == 1) {
%>
        <h1>Record Deletion Successful!</h1>
<% 
    } else if (status == 2) { 
%>
        <h1>Record Not Found</h1>
<% 
    } else { 
%>
        <h1>Record Deletion Failed</h1>
<% 
    }
%>
            <input type="submit" value="Return to Admin Menu">
        </form>
    </body>
</html>     