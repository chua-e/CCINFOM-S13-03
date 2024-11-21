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
  `char_name` varchar(50) DEFAULT NULL,
  `char_id` int DEFAULT NULL,
  `rarity` varchar(50) DEFAULT NULL,
  `base_probability` decimal(5,4) DEFAULT NULL,
  `ability_type` enum('Fire', 'Water', 'Air', 'Earth', 'Electric') DEFAULT NULL,
  `class` enum('Sword', 'Archer', 'Healer', 'Catalyst', 'Shield') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_record`
--

INSERT INTO character_record(char_name, char_id, rarity, base_probability, ability_type, class) values 
('char1', 001, 'S-tier', 0.1, 'Fire', 'Archer'), 
('char2', 002, 'S-tier', 0.1, 'Water', 'Healer'), 
('char3', 003, 'A-tier', 0.3, 'Earth', 'Catalyst'),
('char4', 004, 'A-tier', 0.3, 'Fire', 'Healer'), 
('char5', 005, 'A-tier', 0.3, 'Water', 'Sword'), 
('char6', 006, 'A-tier', 0.3, 'Electric', 'Shield'), 
('char7', 007, 'B-tier', 0.6, 'Fire', 'Sword'), 
('char8', 008, 'B-tier', 0.6, 'Water', 'Archer'), 
('char9', 009, 'B-tier', 0.6, 'Earth', 'Healer'), 
('char10', 010, 'B-tier', 0.6, 'Electric', 'Archer'), 
('char11', 011, 'B-tier', 0.6, 'Electric', 'Sword'), 
('char12', 012, 'B-tier', 0.6, 'Fire', 'Catalyst'),
('char13', 013, 'A-tier', 0.3, 'Earth', 'Archer'),
('char14', 014, 'S-tier', 0.1, 'Earth', 'Shield'), 
('char15', 015, 'B-tier', 0.6, 'Water', 'Catalyst'),
('char16', 016, 'S-tier', 0.1, 'Electric', 'Catalyst'), 
('char17', 017, 'B-tier', 0.6, 'Fire', 'Shield');

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
  `pulltime` date DEFAULT NULL,
  `pity_counter` int DEFAULT NULL,
  `pull_cost` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingame_transaction_record`
--

INSERT INTO ingame_transaction_record (player_id, pull_id, pulltime, pity_counter, pull_cost) values
(12306428, 1, current_date(), 20, 100),
(12345678, 4, DATE'2024/10/09', 19, 100), 
(12399999, 16, DATE'2024-04-22', 13, 100),
(12306428, 74, DATE'2024-06-04', 15, 100), 
(12478234, 200, DATE'2024-07-09', 16, 100), 
(12312123, 23, DATE'2024-09-28', 18, 100), 
(11902304, 22, DATE'2024-11-03', 19, 100), 
(12482349, 29, DATE'2024-03-30', 12, 100), 
(12309247, 12, DATE'2024-05-11', 14, 100), 
(12039405, 7, DATE'2024-08-19', 17, 100), 
(12111123, 62, DATE'2024-08-15', 17, 100);

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
(12345678, 1, 0), 
(12399999, 3, 5),
(12306428, 4, 2), 
(12478234, 5, 2), 
(12312123, 3, 2), 
(11902304, 7, 4), 
(12482349, 0, 1), 
(12309247, 3, 2), 
(12039405, 9, 3), 
(12111123, 2, 10);

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
(10000001, 'Chua', '2022-02-03', 1000), 
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
