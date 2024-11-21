<%-- 
    Document   : play_page
    Created on : Nov 20, 2024, 10:02:19 AM
    Author     : etchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" session="true" %>
<%@page import="java.util.*,java.sql.*, java.time.LocalDate" %>
<%
    Integer player_id = (Integer) session.getAttribute("player_id");
    Integer acc_bal = (Integer) session.getAttribute("acc_bal");
    
    System.out.println("player_id in play_page: " + player_id);
    
    //player 
    int status = 0;
    int balance = acc_bal;
    
    //characters
    String char_name;
    int char_id;
    String rarity;
    String ability_type;
    String char_class;
    
    ArrayList<Integer> charID_list = new ArrayList<> ();
    ArrayList<String> charName_list = new ArrayList<> ();
    ArrayList<String> rarity_list = new ArrayList<> ();
    ArrayList<String> abilityType_list = new ArrayList<> ();
    ArrayList<String> class_list = new ArrayList<> ();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn;
        // add pw here
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gacha", "root", "root");
        System.out.println("Connection Successful!");

        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM character_record");
        ResultSet rst = pstmt.executeQuery();
        
        charID_list.clear();
        charName_list.clear();
        rarity_list.clear();
        abilityType_list.clear();
        class_list.clear();
        
        while(rst.next()){
            charID_list.add(rst.getInt("char_id"));
            charName_list.add(rst.getString("char_name"));
            rarity_list.add(rst.getString("rarity"));
            abilityType_list.add(rst.getString("ability_type"));
            class_list.add(rst.getString("class"));
        }
        
//        ArrayList<Map<String, String>> characters = new ArrayList<>();
//        for (int i = 0; i < charID_list.size(); i++) {
//            Map<String, String> character = new HashMap<>();
//            character.put("name", charName_list.get(i));
//            character.put("rarity", rarity_list.get(i));
//            character.put("abilityType", abilityType_list.get(i));
//            character.put("class", class_list.get(i));
//            characters.add(character);
//        }
        
        rst.close();
        pstmt.close();
        conn.close();
        
        status = 1;
        
        } catch (Exception e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
        status = 0;
    }
%>


<!DOCTYPE html>
<html>
    <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        width: 100%; /* Adjust to fit the container's layout */
        height: 180px; /* Reserve enough space for the GIF */
    margin-top: 20px;
    visibility: hidden; /* Keeps the space but hides the GIF */
    overflow: hidden; /* Prevent content overflow */
  display: flex; /* Center the iframe */
  align-items: center;
  justify-content: center;
    }

    #loadingGif.active {
        visibility: visible; /* Show the GIF when active */
       }
    
      .tenor-gif-embed {
  max-width: 100%; /* Prevent it from exceeding container width */
  max-height: 100%; /* Prevent it from exceeding container height */
  object-fit: contain; /* Maintain aspect ratio */
  
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
  <h2>Player ID: <%= player_id %>, Balance: <%= acc_bal %></h2>
  <a href="inventory.html" class="button">Inventory</a>
  <button id="gachaButton">Roll!</button>
    
  <div class="gachapon-container">
    <div id="result" class="result-container"></div>

    <div id="loadingGif">
      <div class="tenor-gif-embed" data-postid="15587798242701274863" data-share-method="host" data-aspect-ratio="0.707395" data-width="100%">
        <a href="https://tenor.com/view/explosion-gif-15587798242701274863">Explosion</a> 
        from <a href="https://tenor.com/search/explosion-stickers">Explosion</a>
      </div>
      <script type="text/javascript" async src="https://tenor.com/embed.js"></script>
    </div>

  </div>

  <script>
    document.getElementById("gachaButton").addEventListener("click", rollGacha);
    
    let accBal = <%= acc_bal %>;
    const characters = [
        <% for (int i = 0; i < charID_list.size(); i++) { %>
        {
            name: "<%= charName_list.get(i) %>".trim(),
            rarity: "<%= rarity_list.get(i) %>".trim(),
            abilityType: "<%= abilityType_list.get(i) %>".trim(),
            classType: "<%= class_list.get(i) %>".trim()
        }<%= (i < charID_list.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const rarityProbabilities = {
        "B-tier": 0.6,
        "A-tier": 0.3,
        "S-tier": 0.1
    };


    function rollGacha() {
    const resultContainer = document.getElementById("result");
    const loadingGif = document.getElementById("loadingGif");

    if (accBal < 100) {
        alert("Insufficient balance! You need at least 100 to roll.");
        return;
    }
    
    accBal -= 100;
    resultContainer.innerHTML = "";
    loadingGif.classList.add("active");

    
    setTimeout(() => {
        loadingGif.classList.remove("active");

        const randomValue = Math.random();
        let cumulativeProbability = 0;

        let selectedCharacter = null;

        for (const character of characters) {
            cumulativeProbability += rarityProbabilities[character.rarity] || 0;

            if (randomValue <= cumulativeProbability) {
                selectedCharacter = character;
                break;
            }
        }

        if (selectedCharacter) {
            resultContainer.innerHTML = `
                <div>
                    <p>Character: ${selectedCharacter.name}</p>
                    <p>Rarity: ${selectedCharacter.rarity}</p>
                    <p>Ability Type: ${selectedCharacter.abilityType}</p>
                    <p>Class: ${selectedCharacter.classType}</p>
                </div>
            `;
        } else {
            resultContainer.innerHTML = `<p>No character rolled. Try again!</p>`;
        }
    }, 1000); // Adjust the delay as necessary
}
  </script>
</body>
</html>
