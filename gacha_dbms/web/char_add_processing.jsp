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
    </head>
    <body>
        
        <form action="admin.html">
            <%
                String char_name;
                int char_id = 1;
                String rarity;
                double base_probability;
                String ability_type;
                String char_class;
                int status;
    
                ArrayList<Integer> charID_list = new ArrayList<> ();
                ArrayList<String> charName_list = new ArrayList<> ();
                ArrayList<String> rarity_list = new ArrayList<> ();
                ArrayList<String> abilityType_list = new ArrayList<> ();
                ArrayList<String> class_list = new ArrayList<> ();
                
                
                try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "Geometry@14");
            System.out.print("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(char_id)+1 AS newID FROM character_record");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                char_id = rst.getInt("newID");
            }
            
            String v_char_name = request.getParameter("char_name");
                char_name = v_char_name;
                
                String v_rarity = request.getParameter("rarity");
                rarity = v_rarity;
                
                String v_ability_type = request.getParameter("ability_type");
                ability_type = v_ability_type;
                
                String v_class = request.getParameter("class");
                char_class = v_class;
            
            pstmt = conn.prepareStatement("INSERT INTO character_record (char_name, char_id, rarity, base_probability, ability_type, class) " +
                    "VALUES (?, ?, ?, ?, ?, ?)");
            
            pstmt.setString(1, char_name);
            pstmt.setInt(2, char_id);
            pstmt.setString(3, rarity);
            
            if (rarity.equals("S-tier")){
                base_probability = 0.1;
            }
            else if (rarity.equals("A-tier")){
                base_probability = 0.3;
            }
            else {
                base_probability = 0.6;
            }
            
            pstmt.setDouble(4, base_probability);
            pstmt.setString(5, ability_type);
            pstmt.setString(6, char_class);
            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
           status = 1; 
        } catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            status = 0;
        }
                
               
                
                if(status == 1){
            %>
                <h1>Adding Character Successful!</h1>
            <% } 
                else { %>
                <h1>Adding Character Unsuccessful</h1>
            <%}
            %>
        
        <input type="submit" value="Return to Admin Menu">
        </form>
    </body>
</html>
