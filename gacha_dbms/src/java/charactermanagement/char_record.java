/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package charactermanagement;

/**
 *
 * @author etchu
 */
import java.util.*;
import java.sql.*;

public class char_record {
    
    public String char_name;
    public int char_id;
    public String rarity;
    public double base_probability;
    public String ability_type;
    public String char_class;
    public int status;
    
    public ArrayList<Integer> charID_list = new ArrayList<> ();
    public ArrayList<String> charName_list = new ArrayList<> ();
    public ArrayList<String> rarity_list = new ArrayList<> ();
    public ArrayList<String> abilityType_list = new ArrayList<> ();
    public ArrayList<String> class_list = new ArrayList<> ();
    
    public char_record(){}
    
    public void loadCharacters() {
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
        System.out.println("Connection Successful!");

        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM character_record");
        ResultSet rst = pstmt.executeQuery();

        charID_list.clear();
        charName_list.clear();
        rarity_list.clear();
        abilityType_list.clear();
        class_list.clear();

        while (rst.next()) {
            charID_list.add(rst.getInt("char_id"));
            charName_list.add(rst.getString("char_name"));
            rarity_list.add(rst.getString("rarity"));
            abilityType_list.add(rst.getString("ability_type"));
            class_list.add(rst.getString("char_class"));
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
    
    public int register_char(){
        System.out.print("register character fucntion reached");
        try{
            
            Connection conn;
            //change the last param in getConnection() to your MySQL password :)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
            System.out.print("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(char_id)+1 AS newID FROM character_record");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                char_id = rst.getInt("newID");
            }
            
//            char_name = name;
//            rarity = char_rarity;
//            ability_type = type;
//            char_class = temp_class;
            
            pstmt = conn.prepareStatement("INSERT INTO character_record (char_name, char_id, rarity, base_probability, ability_type, `class`) " +
                    "VALUES (?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, char_id);
            pstmt.setString(2, char_name);
            pstmt.setString(3, rarity);
            
            if(rarity.equals("S")){
                base_probability = 0.1;
            } else if(rarity.equals("A")) {
                base_probability = 0.3;
            } else {
                base_probability = 0.6;
            }
            
            pstmt.setDouble(4, base_probability);
            pstmt.setString(5, ability_type);
            pstmt.setString(6, char_class);
            
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
    
    public static void main (String args[]){
        char_record rec = new char_record();
        rec.register_char();
    }
                
}
