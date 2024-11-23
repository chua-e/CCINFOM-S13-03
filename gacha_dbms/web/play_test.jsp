<%-- 
    Document   : play_test
    Created on : Nov 21, 2024, 7:23:02 PM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" session="true" %>
<%@page import="java.util.*, java.sql.*, java.time.LocalDate, playermanagement.*, charactermanagement.*" %>
<%
    Integer player_id = (Integer) session.getAttribute("player_id");
    Integer acc_bal = (Integer) session.getAttribute("acc_bal");

    int balance = acc_bal;
    int char_id = 0;
    int status = -1;
    
    int pull_id = 1;
    java.sql.Date pull_date;
    int pitycounter = 1;
    int pullcost = 100;
    
    int char_dupli = 0;
    
    String gachaResult = "";
    if (request.getParameter("rollGacha") != null && balance >= 100) {
        balance -= 100;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");

            PreparedStatement updateStmt = conn.prepareStatement("UPDATE player_record SET account_bal = ? WHERE player_id = ?");
            updateStmt.setInt(1, balance);
            updateStmt.setInt(2, player_id);
            int rowsUpdated = updateStmt.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("acc_bal", balance);
            }

            PreparedStatement charStmt = conn.prepareStatement("SELECT * FROM character_record ORDER BY RAND()*base_probability DESC LIMIT 1");
            ResultSet charResult = charStmt.executeQuery();

            if (charResult.next()) {
                char_id = charResult.getInt("char_id");
                gachaResult = String.format(
                    "Character: %s\n, Rarity: %s-tier\n, Ability Type: %s\n, Class: %s\n",
                    charResult.getString("char_name"),
                    charResult.getString("rarity"),
                    charResult.getString("ability_type"),
                    charResult.getString("class")
                );
            
            
            } else {
                gachaResult = "No characters found!";
            }
            
           
            
            PreparedStatement  histStmt = conn.prepareStatement("SELECT MAX(pity_counter)+1 AS newPull FROM ingame_transaction_record"
            + " WHERE player_id = ?");
            histStmt.setInt(1, player_id);
            ResultSet histResult = histStmt.executeQuery();
            if (histResult.next()) {
                pitycounter = histResult.getInt("newPull");
                 if (histResult.wasNull()) { 
                    pitycounter = 1;
                }
            } else {
                pitycounter = 1; 
            }
            
            histStmt = conn.prepareStatement("SELECT MAX(pull_id)+1 AS newID FROM ingame_transaction_record");
            histResult = histStmt.executeQuery();
            while(histResult.next()){
                pull_id = histResult.getInt("newID");
            }
            
            pull_date = java.sql.Date.valueOf(LocalDate.now());
            
            out.println("player id: " + player_id);
            out.println("pull id: " + pull_id);
            out.println("char id: " + char_id);
            out.println("date: " + pull_date);
            out.println("pity ctr: " + pitycounter);
            out.println("cost: " + pullcost);
            
            histStmt = conn.prepareStatement("INSERT INTO ingame_transaction_record (player_id, pull_id, char_id, pulltime, pity_counter, pull_cost) "
                            + "VALUES (?, ?, ?, ?, ?, ?)");
            histStmt.setInt(1, player_id);
            histStmt.setInt(2, pull_id);
            histStmt.setInt(3, char_id);
            histStmt.setDate(4, pull_date);
            histStmt.setInt(5, pitycounter);
            histStmt.setInt(6, pullcost);
            
            histStmt.executeUpdate();
            
            PreparedStatement invenStmt = conn.prepareStatement("SELECT MAX(char_duplicates)+1 AS newCount FROM player_items_record WHERE player_id = ? AND char_id = ?;");
            invenStmt.setInt(1, player_id);
            invenStmt.setInt(2, char_id);
            ResultSet invenResult = invenStmt.executeQuery();
            if (invenResult.next()) {
                char_dupli = invenResult.getInt("newCount");
                if (invenResult.wasNull()) {
                    char_dupli = 1; // Handle null case explicitly
                }
            }
            
            PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM player_items_record WHERE player_id = ? AND char_id = ?");
            checkStmt.setInt(1, player_id);
            checkStmt.setInt(2, char_id);
            ResultSet checkResult = checkStmt.executeQuery();
            boolean recordExists = false;

            if (checkResult.next()) {
            recordExists = checkResult.getInt(1) > 0;
            }

            if (!recordExists) {
                invenStmt = conn.prepareStatement("INSERT INTO player_items_record (player_id, char_id, char_duplicates) "
                + "VALUES (?, ?, ?)");
                invenStmt.setInt(1, player_id);
                invenStmt.setInt(2, char_id);
                invenStmt.setInt(3, char_dupli);
            } else {
                invenStmt = conn.prepareStatement("UPDATE player_items_record SET char_duplicates = ? WHERE player_id = ? AND char_id = ?");
                invenStmt.setInt(1, char_dupli);
                invenStmt.setInt(2, player_id);
                invenStmt.setInt(3, char_id);
            }

            invenStmt.executeUpdate();
                           
            invenStmt.close();
            checkStmt.close();
            histStmt.close();
            updateStmt.close();
            charStmt.close();
            conn.close();
            
            status = 1;

        } catch (Exception e) {
            status = 0;
            e.printStackTrace();
            gachaResult = "Error during gacha roll.";
        }
    } else if (request.getParameter("rollGacha") != null) {
        gachaResult = "Insufficient balance!";
    }
    
    //out.println("status: " + status);
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        
  <title>Gacha</title>
  <style>
      h1 {
          font-family: "Roboto", sans-serif;
          font-weight: 700;
          font-style: italic;
          text-align: left;
          font-size: 50px;
          margin-bottom: 0px;
      }
      
      h2 {
         font-family: "Roboto", sans-serif;
          font-weight: 300;
          font-style: normal;
          text-align: left;
          font-size: 20px;
          margin-bottom: 0px; 
      }
      
    body {
                font-family: "Roboto", sans-serif;
                font-weight: 700;
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

    .gachapon-container {
      margin: 50px auto;
      width: 1080px;
      height: 200px;
      border: 2px solid #ccc;
      border-radius: 10px;
      background-color: #fff;
      outline: 2px #000000 solid;
    }

    button {
        font-family: "Roboto", sans-serif;
          font-weight: 300;
          font-style: normal;
        display: inline-block;
        margin: 10px;
        padding: 10px 120px;
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
            }

            button:hover {
                background-color: #e8e8e8; 
                transform: scale(1.05); 
                outline: 2px solid #000000;
            }

            button:active {
                background-color: #d1d1d1; 
                box-shadow: 0 2px #d1d1d1; 
                transform: translateY(2px); 
            }
            
            .button {
        font-family: "Roboto", sans-serif;
          font-weight: 300;
          font-style: normal;
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

    .result-container {
      margin-top: 20px;
      font-size: 24px;
    }

    .hidden {
      display: none;
    }

    #loadingGif {
        width: 100%; 
        height: 180px; 
    margin-top: 20px;
    visibility: hidden; 
    overflow: hidden; 
  display: flex; 
  align-items: center;
  justify-content: center;
    }

    #loadingGif.active {
        visibility: visible; 
       }
    
      .tenor-gif-embed {
  max-width: 100%; 
  max-height: 100%; 
  object-fit: contain; 
  
  .result-character {
      font-family: "Roboto", sans-serif;
          font-weight: 300;
          font-style: normal;
          font-size: 20px;
          margin-bottom: 0px;
  }
  
}

  </style>
</head>
<body>
    <h1>Gacha System</h1>
    <h2>Player ID: <%= player_id %>, Balance: <%= balance %></h2>
    <form method="POST">
        <button id="gachaButton" name="rollGacha">Roll!</button>
        <% 
            session.setAttribute("player_id", player_id);
        %>
        <a href="inventory.jsp" class="button"> Inventory</a>
        <a href="player.html" class="button"> Back</a>
    </form>
    
    <div class="gachapon-container">
        <div id="result" class="result-container">
            <%= gachaResult %>
        </div>
    </div>
    <script>
        document.getElementById("gachaButton").addEventListener("click", () => {
            document.getElementById("result").innerHTML = "Rolling...";
        });
    </script>
</body>
</html>

