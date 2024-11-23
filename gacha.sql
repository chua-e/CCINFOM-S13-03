CREATE DATABASE  IF NOT EXISTS `gacha` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gacha`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gacha
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `character_record`
--

DROP TABLE IF EXISTS `character_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_record` (
  `char_id` int DEFAULT NULL,
  `char_name` varchar(50) DEFAULT NULL,
  `rarity` enum('S', 'A', 'B') DEFAULT NULL,
  `base_probability` decimal(5,4) DEFAULT NULL,
  `ability_type` enum('Fire', 'Water', 'Air', 'Earth', 'Electric') DEFAULT NULL,
  `class` enum('Sword', 'Archer', 'Healer', 'Catalyst', 'Shield') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_record`
--

INSERT INTO character_record(char_id, char_name, rarity, base_probability, ability_type, class) values 
(001,'Lebron James', 'S', 0.1, 'Fire', 'Archer'), 
(002,'DuRuo', 'S', 0.1, 'Water', 'Healer'), 
(003,'Kels', 'A', 0.3, 'Earth', 'Catalyst'),
(004, 'Jhin', 'A', 0.3, 'Fire', 'Healer'), 
(005, 'Dreya', 'A', 0.3, 'Water', 'Sword'), 
(006, 'Deren', 'A', 0.3, 'Electric', 'Shield'), 
(007, 'Plygia', 'B', 0.6, 'Fire', 'Sword'), 
(008, 'Hecate', 'B', 0.6, 'Water', 'Archer'), 
(009, 'Yao', 'B', 0.6, 'Earth', 'Healer'), 
(010, 'Zephyr', 'B', 0.6, 'Electric', 'Archer'), 
(011, 'Sage', 'B', 0.6, 'Electric', 'Sword'), 
(012, 'Omen', 'B', 0.6, 'Fire', 'Catalyst'),
(013, 'Enfer', 'A', 0.3, 'Earth', 'Archer'),
(014, 'Heimerdinger', 'S', 0.1, 'Earth', 'Shield'), 
(015, 'Cards', 'B', 0.6, 'Water', 'Catalyst'),
(016, 'Tiger Woods', 'S', 0.1, 'Electric', 'Catalyst'), 
(017, 'Mitsuki', 'B', 0.6, 'Fire', 'Shield');

LOCK TABLES `character_record` WRITE;
/*!40000 ALTER TABLE `character_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingame_transaction_record`
--

DROP TABLE IF EXISTS `ingame_transaction_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingame_transaction_record` (
  `player_id` int DEFAULT NULL,
  `pull_id` int DEFAULT NULL,
  `char_id` int DEFAULT NULL,
  `pulltime` date DEFAULT NULL,
  `pity_counter` int DEFAULT NULL,
  `pull_cost` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingame_transaction_record`
--

INSERT INTO ingame_transaction_record (player_id, pull_id, char_id, pulltime, pity_counter, pull_cost) values
(10000007, 1, 14, DATE '2022-12-25', 20, 100),
(10000001, 2, 4, DATE'2024/10/09', 19, 100), 
(10000002, 3, 10, DATE'2024-04-22', 13, 100),
(10000003, 4, 9, DATE'2024-06-04', 15, 100), 
(10000004, 5, 2, DATE'2024-07-09', 16, 100), 
(10000005, 6, 7, DATE'2024-09-28', 18, 100), 
(10000006, 7, 17, DATE'2024-11-03', 19, 100), 
(10000007, 8, 15, DATE'2024-03-30', 21, 100), 
(10000008, 9, 3, DATE'2024-05-11', 14, 100), 
(10000009, 10, 12, DATE'2024-08-19', 17, 100), 
(10000010, 11, 12, DATE'2024-08-15', 17, 100);

LOCK TABLES `ingame_transaction_record` WRITE;
/*!40000 ALTER TABLE `ingame_transaction_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingame_transaction_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_items_record`
--

DROP TABLE IF EXISTS `player_items_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_items_record` (
  `player_id` int DEFAULT NULL,
  `char_id` int DEFAULT NULL,
  `char_duplicates` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_items_record`
--

INSERT INTO player_items_record (player_id, char_id, char_duplicates) values
(10000007, 14, 1),
(10000001, 4, 1), 
(10000002, 10, 1),
(10000003, 9, 1), 
(10000004, 2, 1), 
(10000005, 7, 1), 
(10000006, 17, 1), 
(10000007, 15, 1), 
(10000008, 3, 1), 
(10000009, 12, 1), 
(10000010, 12, 1);

LOCK TABLES `player_items_record` WRITE;
/*!40000 ALTER TABLE `player_items_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_items_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_record`
--

DROP TABLE IF EXISTS `player_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_record` (
  `player_id` int DEFAULT NULL,
  `player_name` varchar(50) DEFAULT NULL,
  `player_join_date` date DEFAULT NULL,
  `account_bal` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_record`
--

INSERT INTO player_record (player_id, player_name, player_join_date, account_bal) values
(10000001, 'Chua', '2022-02-03', 10000),  
(10000002, 'Cheung', '2022-09-12', 1000), 
(10000003, 'Casem', '2022-10-08', 500), 
(10000004, 'SCP096', '2023-01-01', 2000), 
(10000005, 'Tectonic', '2021-12-12', 1050), 
(10000006, 'Voltrics', '2022-09-12', 1000), 
(10000007, 'Ayaka', '2022-10-08', 5000), 
(10000008, 'Qing', '2023-01-01', 20000), 
(10000009, 'Dsalg', '2021-12-12', 110), 
(10000010, 'Drake', '2021-11-18', 0);

LOCK TABLES `player_record` WRITE;
/*!40000 ALTER TABLE `player_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-06 20:26:24