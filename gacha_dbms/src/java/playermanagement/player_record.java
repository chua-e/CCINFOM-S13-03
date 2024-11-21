/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package playermanagement;

/**
 *
 * @author etchu
 */
import java.util.*;
import java.time.LocalDate;
import java.sql.*;


public class player_record {
    //variables
    public int player_id;
    public String player_name;
    public java.sql.Date player_join_date;
    public int account_bal; 
    
    //arrays
    public ArrayList<Integer> playerID_list = new ArrayList<> ();
    public ArrayList<String> playerName_list = new ArrayList<> ();
    public ArrayList<java.sql.Date> playerJoinDate_list = new ArrayList<> ();
    public ArrayList<Integer> accBal_list = new ArrayList<> ();
    
    public player_record(){
        
    }
    
    public void loadPlayers() {
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
        System.out.println("Connection Successful!");

        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM player_record");
        ResultSet rst = pstmt.executeQuery();

        playerID_list.clear();
        playerName_list.clear();
        playerJoinDate_list.clear();
        accBal_list.clear();

        while (rst.next()) {
            playerID_list.add(rst.getInt("player_id"));
            playerName_list.add(rst.getString("player_name"));
            playerJoinDate_list.add(rst.getDate("player_join_date"));
            accBal_list.add(rst.getInt("account_bal"));
        }

        rst.close();
        pstmt.close();
        conn.close();

        System.out.println("Data loaded successfully!");
    } catch (SQLException e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
    }
}
    
    public int register_player(){
        System.out.print("register player fucntion reached");
        try{
            
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "Geometry@14");
            System.out.print("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(player_id)+1 AS newID FROM player_record");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                player_id = rst.getInt("newID");
            }
            
            pstmt = conn.prepareStatement("INSERT INTO player_record (player_id, player_name, player_join_date, account_bal) "
                    + "VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, player_id);
            pstmt.setString(2, player_name);
            
            player_join_date = java.sql.Date.valueOf(LocalDate.now());
            pstmt.setDate(3, player_join_date);
            
            account_bal = 1000;
            pstmt.setInt(4, account_bal);
            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            return 1;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            return 0;
    }
    }
    
    public int getPlayerID(String name){
        
        for(int i = 0; i < playerName_list.size(); i++){
            if(name.equals(playerName_list.get(i))){
                return playerID_list.get(i);
            }
        }
        
        return 0;
    }
    
    public int getAccBal(String name){
        
        for(int i = 0; i < playerName_list.size(); i++){
            if(name.equals(playerName_list.get(i))){
                return accBal_list.get(i);
            }
        }
        
        return 0;
    }
    
    public static void main (String args[]){
        player_record rec = new player_record();
        //rec.loadPlayers();       
        rec.register_player();
    }
    
}