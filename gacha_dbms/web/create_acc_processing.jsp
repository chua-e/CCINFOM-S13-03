<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, playermanagement.*, java.sql.*, java.time.LocalDate" %>
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
        <form action="player.html">
            <%
<<<<<<< HEAD
//                //out.println() lines are for debugging
//                String v_player_name = request.getParameter("player_name");
//                //out.println("Received player_name: " + v_player_name + ", ");
//                rec.player_name = v_player_name;
//                //out.println("Assigning player name as: " + rec.player_name + ", ");
//                int status = rec.register_player();
//                //out.println("Status: "+status);
                int player_id = 10000000;
    String player_name;
    java.sql.Date player_join_date;
    int account_bal;
    int status;
    
    
    //arrays
    ArrayList<Integer> playerID_list = new ArrayList<> ();
    ArrayList<String> playerName_list = new ArrayList<> ();
    ArrayList<java.sql.Date> playerJoinDate_list = new ArrayList<> ();
    ArrayList<Integer> accBal_list = new ArrayList<> ();

                    try{
                    
                    Class.forName("com.mysql.cj.jdbc.Driver");
            
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "Geometry@14");
            System.out.print("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(player_id)+1 AS newID FROM player_record");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                player_id = rst.getInt("newID");
            }
            
            String v_player_name = request.getParameter("player_name");
            player_name = v_player_name;
            request.setAttribute("player_name", player_name);
            
            pstmt = conn.prepareStatement("INSERT INTO player_record (player_id, player_name, player_join_date, account_bal) "
                    + "VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, player_id);
            pstmt.setString(2, player_name);
            
            player_join_date = java.sql.Date.valueOf(LocalDate.now());
            pstmt.setDate(3, player_join_date);
            
            account_bal = 0;
            pstmt.setInt(4, account_bal);
            
            pstmt.executeUpdate();
            
            rst.close();
            pstmt.close();
            conn.close();
            status = 1;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            status = 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            status = 0;
    }
    
=======
                //out.println() lines are for debugging
                String v_player_name = request.getParameter("player_name");
                out.println("Received player_name: " + v_player_name + ", ");
                rec.player_name = v_player_name;
                out.println("Assigning player name as: " + rec.player_name + ", ");
                int status = 0;
            
                try {
            
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn;
                    //change the last param in getConnection() to your MySQL password 🙂
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "pass");
                    System.out.print("Connection Successful!");
            
                    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM player_record");
                    ResultSet rst = pstmt.executeQuery();
            
                    conn.close();
            
                    status = 1;
            
                } catch (Exception e){
                    System.out.println(e.getMessage());
                    e.printStackTrace();
            
                    status = 2;
                }
                out.println("Status: "+ status);
                
>>>>>>> d02d1e69294a2fa23fca9d02748cb8174ebe7f83
            if (status == 1) {
            %>
                <h1>Account Creation Successful!</h1>
                <h2>Welcome, ${player_name}!</h2>
            <%
                } else {
            %>
                <h1>create: Account Creation Failed</h1>
            <%
                }
            %>
            <input type="submit" value="Return to Player Menu">
        </form>
    </body>
</html>