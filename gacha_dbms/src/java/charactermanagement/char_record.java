/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package charactermanagement;

import java.util.*;
import java.sql.*;
/**
 *
 * @author etchu
 */
public class char_record {
    
    public String char_name;
    public int char_id;
    public String rarity;
    public double base_probability;
    public String ability_type;
    public String char_class;
    
    public ArrayList<Integer> charID_list = new ArrayList<> ();
    //public ArrayList<Float> probability_list = new ArrayList<> ();
    public ArrayList<String> charName_list = new ArrayList<> ();
    public ArrayList<String> rarity_list = new ArrayList<> ();
    public ArrayList<String> abilityType_list = new ArrayList<> ();
    public ArrayList<String> class_list = new ArrayList<> ();
    
    public char_record(){}
    
    public int register_char(){
        try {
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "Geometry@14");
            System.out.print("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(char_id)+1 AS newID FROM character_record");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                char_id = rst.getInt("newID");
            }
            
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
            
           return 1; 
        } catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace(); 
            return 0;
        }
    }
    
    public static void main (String args[]){
        char_record rec = new char_record();
//        rec.char_name = "test";
//        rec.rarity = "A-tier";
//        rec.ability_type = "Water";
//        rec.char_class = "Archer";
        rec.register_char();
    }
    
}
