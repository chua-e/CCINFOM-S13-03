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
                
                System.out.print("login player function reached");
        String query = "SELECT COUNT(*) FROM player_record WHERE player_name = ?";

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
            //change the last param in getConnection() to your MySQL password 🙂
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "pass");
            System.out.print("Connection Successful!");
            PreparedStatement pstmt = conn.prepareStatement(query); 
            pstmt.setString(1, v_player_name);
            
            ResultSet rst = pstmt.executeQuery();
            if (rst.next() && rst.getInt(1) > 0){
                System.out.println("There is a line");
                pstmt.close();
                conn.close();
                status= 1;
            }
            else {
                System.out.println("There is no line");
                pstmt.close();
                conn.close();
                status= 0;
            }
        }catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            status= -1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            status= -1;
        }
        
                out.println("Status: "+ status);
                
            if (status == 1) {
            %>
                <h1>Account Login Successful!</h1>
            <%
                } else {
            %>
                <h1>login: Account Does not Exist</h1>
            <%
                }
            %>
            <input type="submit" value="Return to Player Menu">
        </form>
    </body>
</html>
