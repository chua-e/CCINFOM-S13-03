<%-- 
    Document   : player_table
    Created on : Nov 23, 2024, 5:27:51 PM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" session="true" %>
<%@page import="java.util.*, java.sql.*, java.time.LocalDate, playermanagement.*, charactermanagement.*" %>
<%
    int status = -1;
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Player Table</title>
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
        <h1>Players Database</h1>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
                
                PreparedStatement pst = conn.prepareStatement("SELECT player_id AS ID, player_name AS Username, player_join_date AS JoinDate, account_bal AS Balance "
                + "FROM player_record");
                ResultSet rst = pst.executeQuery();
                
                out.println("<table>");
                out.println("<thead><tr><th>ID</th><th>Username</th><th>JoinDate</th><th>Balance</th></tr></thead>");
                out.println("<tbody>");
                
                while (rst.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rst.getInt("ID") + "</td>");
                    out.println("<td>" + rst.getString("Username") + "</td>");
                    out.println("<td>" + rst.getString("JoinDate") + "</td>");
                    out.println("<td>" + rst.getInt("Balance") + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody>");
                out.println("</table>");
                
                rst.close();
                pst.close();
                conn.close();
                
                status = 1;
                //out.println("status: " + status);
            } catch (Exception e) {
            status = 0;
            e.printStackTrace();
            //out.println("status: " + status);
        }
        
        %>
        <a href="view.html" class="button">Back to Reports Options</a>
    </body>
</html>
