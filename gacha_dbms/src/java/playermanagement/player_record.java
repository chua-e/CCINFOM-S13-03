
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author etchu
 */
package playermanagement;

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
        System.out.print("player rec constructor");
    }
    
    public int login_player(){
        System.out.print("login player function reached");
        String query = "SELECT COUNT(*) FROM player_record WHERE player_name = ?";

        try(Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "pass");
            PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, player_name);
            
            ResultSet rst = pstmt.executeQuery();
            if (rst.next() && rst.getInt(1) > 0){
                System.out.println("There is a line");
                pstmt.close();
                conn.close();
                return 1;
            }
            else {
                System.out.println("There is no line");
                pstmt.close();
                conn.close();
                return 0;
            }
        }catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return -1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            return -1;
        }
    }
    
    public int register_player(){
        System.out.print("register player fucntion reached");
        try{
            
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "pass");
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
            
            account_bal = 0;
            pstmt.setInt(4, account_bal);
            
            pstmt.executeUpdate();
            
            rst.close();
            pstmt.close();
            conn.close();
            
            return 1;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return -1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            return -1;
    }
    }
    
    public int login_player(){
        return 0;
    }
    
    public static void main (String args[]){
        player_record rec = new player_record();
        rec.player_name = "test";
        rec.register_player();
    }
    
}
