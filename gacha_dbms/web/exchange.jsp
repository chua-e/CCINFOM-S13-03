<%-- 
    Document   : exchange
    Created on : Nov 23, 2024, 8:06:46 PM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" session="true" %>
<%@page import="java.util.*, java.sql.*, java.time.LocalDate" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Exchange</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,500;1,300;1,500&display=swap" rel="stylesheet">
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

            .container {
                width: 100%;
                max-width: 400px;
                background: #ffffff;
                border: 3px solid #00000;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
            }

            .feedback {
                margin: 10px 0;
                color: #ff3333;
            }
        </style>
    </head>
    <body>
        <form action="play_test.jsp">
        <div class="container">
            <h1>Exchange Results</h1>
<% 
        Integer player_id = (Integer) session.getAttribute("player_id");
        Integer acc_bal = (Integer) session.getAttribute("acc_bal");

//        out.println("Player ID: " + player_id + "<br>");
//        out.println("Account Balance: " + acc_bal + "<br>");

        String charName = request.getParameter("char_name");
        String amountStr = request.getParameter("amnt");
        
//        out.println("Character Name: " + charName + "<br>");
//        out.println("Amount: " + amountStr + "<br>");

        if (charName != null && amountStr != null) {
            try {
                int deductedAmount = Integer.parseInt(amountStr);

                if (deductedAmount <= 0) {
                    out.println("<p> Invalid amount entered!</p>");
                } else {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
                    //out.println("Connected!");

                    PreparedStatement charStmt = conn.prepareStatement("SELECT char_id FROM character_record WHERE char_name = ?");
                    charStmt.setString(1, charName);
                    ResultSet charRs = charStmt.executeQuery();
                    //out.println("set char name, query 1");

                    if (!charRs.next()) {
                        out.println("<p>Character not found</p>");
                    } else {
                        int charId = 0;
                        charId = charRs.getInt("char_id");
                        //out.println("retrieved id: " + charId);

                        PreparedStatement invStmt = conn.prepareStatement("SELECT char_duplicates FROM player_items_record WHERE player_id = ? AND char_id = ?");
                        invStmt.setInt(1, player_id);
                        invStmt.setInt(2, charId);
                        ResultSet invRs = invStmt.executeQuery();
                        //out.println("query 2 set successfully");

                        if (invRs.next()) {
                            int currentDuplicates = invRs.getInt("char_duplicates");
                            //out.println("char duplicates: " + currentDuplicates);

                            if (currentDuplicates >= deductedAmount) {
                                int newDuplicates = currentDuplicates - deductedAmount;
                                PreparedStatement updateInvStmt = conn.prepareStatement("UPDATE player_items_record SET char_duplicates = ? WHERE player_id = ? AND char_id = ?");
                                updateInvStmt.setInt(1, newDuplicates);
                                updateInvStmt.setInt(2, player_id);
                                updateInvStmt.setInt(3, charId);
                                updateInvStmt.executeUpdate();
                                //out.println("updated player items success");

                                int reward = deductedAmount * 50;
                                int newBalance = acc_bal + reward;
                                PreparedStatement updateBalStmt = conn.prepareStatement("UPDATE player_record SET account_bal = ? WHERE player_id = ?");
                                updateBalStmt.setInt(1, newBalance);
                                updateBalStmt.setInt(2, player_id);
                                updateBalStmt.executeUpdate();
                                //out.println("updating account bal success");

                                session.setAttribute("acc_bal", newBalance);

                                out.println("Exchange successful! New balance: " + newBalance);
                            } else {
                                out.println("<p>Insufficient duplicates!</p>");
                            }
                        } else {
                            out.println("<p>Character not found in inventory!</p>");
                        }
                    }
                }
            } catch (NumberFormatException ex) {
                out.println("<p>Invalid amount entered!</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>An error occurred!</p>");
            }
        }
    %>
        </div>
        <input type="submit" value="Return to Gacha">
    </form>
    </body>
</html>

