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
                border: 1px solid black;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
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

                
                invenStmt = conn.prepareStatement(
                    "SELECT p.char_id AS ID, c.char_name AS Name, p.char_duplicates AS Count " +
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
    </body>
</html>
