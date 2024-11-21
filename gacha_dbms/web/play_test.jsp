<%-- 
    Document   : play_test
    Created on : Nov 21, 2024, 7:23:02 PM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" session="true" %>
<%@page import="java.util.*, java.sql.*" %>
<%
    Integer player_id = (Integer) session.getAttribute("player_id");
    Integer acc_bal = (Integer) session.getAttribute("acc_bal");

    int balance = acc_bal;

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

            PreparedStatement charStmt = conn.prepareStatement("SELECT * FROM character_record ORDER BY RAND() LIMIT 1");
            ResultSet charResult = charStmt.executeQuery();

            if (charResult.next()) {
                gachaResult = String.format(
                    "Character: %s\n, Rarity: %s\n, Ability Type: %s\n, Class: %s\n",
                    charResult.getString("char_name"),
                    charResult.getString("rarity"),
                    charResult.getString("ability_type"),
                    charResult.getString("class")
                );
            } else {
                gachaResult = "No characters found!";
            }

            updateStmt.close();
            charStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            gachaResult = "Error during gacha roll.";
        }
    } else if (request.getParameter("rollGacha") != null) {
        gachaResult = "Insufficient balance!";
    }
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

