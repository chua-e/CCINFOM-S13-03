<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, playermanagement.*,  java.sql.*" %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account processing</title>
    </head>
    <body>
        <jsp:useBean id="rec" class="playermanagement.player_record" scope="session" />
        <form action="player.html">
            <%
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
                
            if (status == 1) {
            %>
                <h1>Account Creation Successful!</h1>
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
