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
                font-family: 'Roboto', sans-serif;
                background-color: #ffffff;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
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

            h1 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333;
            }

            .feedback {
                margin: 10px 0;
                color: #ff3333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Exchange Results</h1>
<% 
        Integer player_id = (Integer) session.getAttribute("player_id");
        Integer acc_bal = (Integer) session.getAttribute("acc_bal");

        out.println("Player ID: " + player_id + "<br>");
        out.println("Account Balance: " + acc_bal + "<br>");

        String charName = request.getParameter("char_name");
        String amountStr = request.getParameter("amnt");
        out.println("Character Name: " + charName + "<br>");
        out.println("Amount: " + amountStr + "<br>");

        if (charName != null && amountStr != null) {
            try {
                int deductedAmount = Integer.parseInt(amountStr);

                if (deductedAmount <= 0) {
                    out.println("<p style='color:red;'>Invalid amount entered!</p>");
                } else {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
                    out.println("Connected!");

                    PreparedStatement charStmt = conn.prepareStatement(
                        "SELECT char_id FROM character_record WHERE char_name = ?"
                    );
                    charStmt.setString(1, charName);
                    ResultSet charRs = charStmt.executeQuery();

                    if (!charRs.next()) {
                        out.println("<p style='color:red;'>Character not found!</p>");
                    } else {
                        int charId = charRs.getInt("char_id");

                        PreparedStatement invStmt = conn.prepareStatement(
                            "SELECT char_duplicates FROM player_items_record WHERE player_id = ? AND char_id = ?"
                        );
                        invStmt.setInt(1, player_id);
                        invStmt.setInt(2, charId);
                        ResultSet invRs = invStmt.executeQuery();

                        if (invRs.next()) {
                            int currentDuplicates = invRs.getInt("char_duplicates");

                            if (currentDuplicates >= deductedAmount) {
                                int newDuplicates = currentDuplicates - deductedAmount;
                                PreparedStatement updateInvStmt = conn.prepareStatement(
                                    "UPDATE player_items_record SET char_duplicates = ? WHERE player_id = ? AND char_id = ?"
                                );
                                updateInvStmt.setInt(1, newDuplicates);
                                updateInvStmt.setInt(2, player_id);
                                updateInvStmt.setInt(3, charId);
                                updateInvStmt.executeUpdate();

                                int reward = deductedAmount * 50;
                                int newBalance = acc_bal + reward;
                                PreparedStatement updateBalStmt = conn.prepareStatement(
                                    "UPDATE players SET acc_bal = ? WHERE player_id = ?"
                                );
                                updateBalStmt.setInt(1, newBalance);
                                updateBalStmt.setInt(2, player_id);
                                updateBalStmt.executeUpdate();

                                session.setAttribute("acc_bal", newBalance);

                                out.println("<p style='color:green;'>Exchange successful! New balance: " + newBalance + "</p>");
                            } else {
                                out.println("<p style='color:red;'>Insufficient duplicates!</p>");
                            }
                        } else {
                            out.println("<p style='color:red;'>Character not found in inventory!</p>");
                        }
                    }
                }
            } catch (NumberFormatException ex) {
                out.println("<p style='color:red;'>Invalid amount entered!</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>An error occurred!</p>");
            }
        }
    %>
        </div>
    </body>
</html>

