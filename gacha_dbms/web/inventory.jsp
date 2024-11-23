<%-- 
    Document   : inventory
    Created on : Nov 22, 2024, 7:57:24 PM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" session="true" %>
<%@page import="java.util.*, java.sql.*, java.time.LocalDate, playermanagement.*, charactermanagement.*" %>
<% 
    Integer player_id = (Integer) session.getAttribute("player_id");
    int status = -1;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                border: 3px solid black;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #FFFFFF;
            }
            
            h1 {
                font-family: "Roboto", sans-serif;
                font-weight: 700;
                font-style: italic;
                font-size: 50px;
            }

            h1:first-of-type {
                margin-top: -30px;
                margin-bottom: 20px;
            }

            h1:last-of-type {
                margin-top: 0;
            }

            body {
                font-family: "Roboto", sans-serif;
                font-weight: 300;
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

            .button {
                display: inline-block;
                margin: 10px;
                padding: 10px 100px;
                font-size: 18px;
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
                margin-top: 20px;
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
        <h1>Player Inventory</h1>
        <% 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");

            
            PreparedStatement invenStmt = conn.prepareStatement("SELECT COUNT(*) FROM player_items_record WHERE player_id = ?");
            invenStmt.setInt(1, player_id);
            ResultSet rst = invenStmt.executeQuery();
            boolean invenExists = false;

            if (rst.next()) {
                invenExists = rst.getInt(1) > 0;
            }

            if (!invenExists) {
                out.println("<p>Inventory is empty!</p>");
            } else {
                invenStmt.close();

                
                invenStmt = conn.prepareStatement("SELECT p.char_id AS ID, c.char_name AS Name, p.char_duplicates AS Count " +
                    "FROM player_items_record p " +
                    "JOIN character_record c ON p.char_id = c.char_id " +
                    "WHERE p.player_id = ? " +
                    "ORDER BY ID"
                );
                invenStmt.setInt(1, player_id);
                rst = invenStmt.executeQuery();

                
                out.println("<table>");
                out.println("<thead><tr><th>ID</th><th>Name</th><th>Count</th></tr></thead>");
                out.println("<tbody>");
                while (rst.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rst.getInt("ID") + "</td>");
                    out.println("<td>" + rst.getString("Name") + "</td>");
                    out.println("<td>" + rst.getInt("Count") + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody>");
                out.println("</table>");
            }

            rst.close();
            invenStmt.close();
            conn.close();

        } catch (Exception e) {
            status = 0;
            e.printStackTrace();
        }
        %>
        <a href="play_test.jsp" class="button">Back to Gacha</a>
    </body>
</html>
