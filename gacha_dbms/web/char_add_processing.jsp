<%-- 
    Document   : char_processing
    Created on : Nov 19, 2024, 4:00:48 PM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, charactermanagement.*,  java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Character Processing</title>
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
        <jsp:useBean id="rec" class="charactermanagement.char_record" scope="session" />
        <form action="admin.html">
            <%  
                      
                int v_char_id = 0;
                double v_base_probability = 0;
                
                String v_char_name = request.getParameter("char_name");
                out.println("Received player_name: " + v_char_name + ", ");
                rec.char_name = v_char_name;
                out.println("Assigning char name as: " + rec.char_name + ", ");
                
                String v_rarity = request.getParameter("rarity");
                out.println("Received rarity: " + v_rarity + ", ");
                rec.rarity = v_rarity;
                
                String v_ability_type = request.getParameter("ability_type");
                out.println("Received ability: " + v_ability_type + ", ");
                rec.ability_type = v_ability_type;
                
                String v_class = request.getParameter("char_class");
                out.println("Received class: " + v_class + ", ");
                rec.char_class = v_class;
                
                
                int status = 0;
                
                try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "pass");
            System.out.print("Connection Successful!");
            PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) FROM character_record WHERE char_name = ?"); 
            pstmt.setString(1, v_char_name);
            
            ResultSet rst = pstmt.executeQuery();
                        if (rst.next() && rst.getInt(1) > 0){
                            System.out.println("There is a line");
                            pstmt.close();
                            conn.close();
                            status= 2;
                        } else {
            
                            pstmt = conn.prepareStatement("SELECT MAX(char_id)+1 AS newID FROM character_record");
                            rst = pstmt.executeQuery();
                            while(rst.next()){
                                v_char_id = rst.getInt("newID");
                             }
            
                            pstmt = conn.prepareStatement("INSERT INTO character_record (char_id, char_name, rarity, base_probability, ability_type, `class`) " +
                                    "VALUES (?, ?, ?, ?, ?, ?)");
            
                            pstmt.setInt(1, v_char_id);
                            pstmt.setString(2, v_char_name);
                            pstmt.setString(3, v_rarity);
            
                            if (v_rarity.equals("S")){
                                v_base_probability = 0.1;
                            }
                            else if (v_rarity.equals("A")){
                                v_base_probability = 0.3;
                            }
                            else {
                                v_base_probability = 0.6;
                            }
            
                            pstmt.setDouble(4, v_base_probability);
                            pstmt.setString(5, v_ability_type);
                            pstmt.setString(6, v_class);
            
                            pstmt.executeUpdate();
            
                            pstmt.close();
                            conn.close();
                            status = 1; 
                }
            
                        
        } catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            status = 0;
        } 
                
               out.println("status: " + status);
                
                if(status == 1){
            %>
                <h1>Adding Character Successful!</h1>
            <% } 
                else if (status == 2){ %>
                <h1>Character Name Already Taken</h1>
            <%} else { %>
                <h1>Adding Character Unsuccessful</h1>
            <% }
            %>
        
        <input type="submit" value="Return to Admin Menu">
        </form>
    </body>
</html>
