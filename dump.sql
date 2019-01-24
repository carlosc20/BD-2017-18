-- MySQL dump 10.13  Distrib 8.0.13, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mydb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mydb`;

--
-- Table structure for table `Aviao`
--

DROP TABLE IF EXISTS `Aviao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Aviao` (
  `marcas_da_aeronave` char(6) NOT NULL,
  `tipo` tinyint(4) NOT NULL,
  `lugar_local` tinyint(4) DEFAULT NULL,
  `proprietario` varchar(255) NOT NULL,
  `modelo` varchar(45) NOT NULL,
  `numero_max_passageiros` int(11) NOT NULL,
  `disponivel` tinyint(4) NOT NULL,
  `data_proxima_revisao` date NOT NULL,
  PRIMARY KEY (`marcas_da_aeronave`),
  KEY `lugar_local_aviao_idx` (`lugar_local`),
  KEY `tipo_aviao_idx` (`tipo`),
  CONSTRAINT `lugar_local_aviao` FOREIGN KEY (`lugar_local`) REFERENCES `Lugar_local` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipo_aviao` FOREIGN KEY (`tipo`) REFERENCES `Tipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aviao`
--

LOCK TABLES `Aviao` WRITE;
/*!40000 ALTER TABLE `Aviao` DISABLE KEYS */;
INSERT INTO `Aviao` VALUES ('CS-AVC',3,1,'Aerodromo da feira','Fantasy Air Allegro 2000',2,1,'2020-10-30'),('CS-IPZ',6,2,'Aerodromo da feira','Cessna Citation CJ2',2,0,'2019-06-12'),('CS-MDQ',2,4,'Aerodromo da feira','Piper PA-28R-200 Arrow III',4,1,'2019-02-06'),('CS-MRQ',1,3,'Aerodromo da feira','Piper PA-28-140 Cherokee 160 hp',4,1,'2019-08-02'),('CS-SBP',7,NULL,'Gabriel Souto','Beechcraft Baron G58',2,1,'2019-01-07'),('CS-XYW',5,2,'Aerodromo da feira','Cessna Citation PO2',2,1,'2019-06-12');
/*!40000 ALTER TABLE `Aviao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ciclo`
--

DROP TABLE IF EXISTS `Ciclo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Ciclo` (
  `id_servico` int(11) NOT NULL,
  `marcas_da_aeronave` varchar(6) NOT NULL,
  `hora_partida_prevista` datetime NOT NULL,
  `hora_chegada_prevista` datetime NOT NULL,
  `hora_partida` datetime DEFAULT NULL,
  `hora_chegada` datetime DEFAULT NULL,
  PRIMARY KEY (`id_servico`),
  KEY `marcas_da_aeronave_idx` (`marcas_da_aeronave`),
  CONSTRAINT `id_servico_servico_aviao` FOREIGN KEY (`id_servico`) REFERENCES `Servico_ao_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `marcas_da_aeronave_servico_aviao` FOREIGN KEY (`marcas_da_aeronave`) REFERENCES `Aviao` (`marcas_da_aeronave`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ciclo`
--

LOCK TABLES `Ciclo` WRITE;
/*!40000 ALTER TABLE `Ciclo` DISABLE KEYS */;
INSERT INTO `Ciclo` VALUES (1,'CS-IPZ','2018-11-20 08:10:00','2018-11-20 09:40:00','2018-11-20 08:11:00','2018-11-20 09:40:00'),(3,'CS-IPZ','2018-11-20 10:10:00','2018-11-20 11:40:00','2018-11-20 10:11:00','2018-11-20 11:38:00'),(6,'CS-MDQ','2018-11-20 14:10:00','2018-11-20 15:40:00','2018-11-20 14:10:00','2018-11-20 15:40:00'),(7,'CS-MDQ','2018-11-20 16:10:00','2018-11-20 17:40:00','2018-11-20 16:11:00','2018-11-20 17:40:00'),(8,'CS-MRQ','2018-11-20 18:10:00','2018-11-20 19:40:00','2018-11-20 18:15:00','2018-11-20 19:47:00'),(11,'CS-IPZ','2018-11-20 12:10:00','2018-11-20 13:40:00','2018-11-20 12:10:00','2018-11-20 13:36:00'),(23,'CS-AVC','2018-11-20 20:10:00','2018-11-20 21:40:00','2018-11-20 20:10:00','2018-11-20 21:42:00');
/*!40000 ALTER TABLE `Ciclo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Ciclo_BEFORE_INSERT` BEFORE INSERT ON `Ciclo` FOR EACH ROW BEGIN
    IF NEW.hora_partida IS NULL AND NEW.hora_chegada IS NOT NULL
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A hora_partida não pode ser null quando hora_chegada é não null';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Ciclo_BEFORE_UPDATE` BEFORE UPDATE ON `Ciclo` FOR EACH ROW BEGIN
    IF NEW.hora_partida IS NULL AND NEW.hora_chegada IS NOT NULL
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'hora_partida não pode ser null quando hora_chegada é não null';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Cliente` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `data_nascimento` date NOT NULL,
  `genero` char(1) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `brevete` tinyint(4) NOT NULL,
  `formacao_paraquedismo` tinyint(4) NOT NULL,
  `numero_de_telefone` varchar(45) NOT NULL,
  `morada` varchar(75) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'Daniel Apelido','1980-12-31','M','2017-05-15 15:00:00',0,1,'+351 213 659 204','Rua Augusta 55, Coimbra, Coimbra 3045-079'),(2,'Benedita Machado','1964-06-10','F','2017-05-15 15:00:00',0,0,'+351 254 154 860','Avenida Marquês Tomar 63, Famões, Lisboa 1685-906'),(3,'Martim Venâncio','1957-02-11','M','2017-05-15 15:00:00',0,0,'+351 215 356 802','Avenida Júlio São Dias 17, Maia, Porto 4475-810'),(4,'Constança Ferreira','1991-06-18','F','2017-05-15 15:00:00',0,0,'+351 222 404 805','Rua Afonso Albuquerque 51, Conqueiros, Leiria 2425-831'),(5,'Nuno Martins','1952-06-11','M','2017-05-15 15:00:00',0,0,'+351 288 203 625','Rua São Salvador 101, Assento, Braga 4730-360'),(6,'Carlota  Pires','1989-08-10','F','2017-05-15 15:00:00',0,0,'+351 215 990 674','Rua Riamar 32, Sanfins, Aveiro 4520-523'),(7,'Manuel  Neves','1962-03-26','M','2017-05-15 15:00:00',0,0,'+351 209 956 073','Rua Projectada 58, Setúbal, Setúbal 2900-570'),(8,'Júlia  Magalhães','1954-09-13','F','2017-05-15 15:00:00',0,0,'+351 297 481 565','Rua São Salvador 36, Igreja, Braga 4730-190'),(9,'Ivan  Vasconcelos','1981-09-11','M','2017-05-15 15:00:00',0,0,'+351 270 512 329','Rua Caldeirão 14, Pedra da Adega, Leiria 3240-601'),(10,'João  Vasconcelos','1983-01-13','M','2017-05-15 15:00:00',0,0,'+351 240 522 339','Rua Caldeirão 16, Pedra da Adega, Leiria'),(11,'Mario Gotze','1993-01-20','M','2017-05-15 15:00:00',0,0,'+355 570 542 200','Rua Azinhaga de Tempães, Lavradas, Viana do Castelo 4980-403'),(12,'Joana Bombom','1983-08-11','F','2017-05-15 15:00:00',0,0,'+351 923 438 234','Rua Inverno nº5, Palmeira, Braga 4700-478'),(13,'Mário Madeira','1995-09-11','M','2017-05-15 15:00:00',0,1,'+351 984 235 635','Rua dos Cães 12, Cabreiros, Vila Real 4400-341'),(14,'Gabriel Souto','1969-09-21','M','2017-05-15 15:00:00',1,1,'+351 250 234 223','Rua Feliz 1, Santa Maria da Feira, Porto 4480-123'),(15,'Ricardo Pão','1980-01-30','M','2017-05-15 15:00:00',0,0,'+351 918 778 923','Rua Engenheiro Marco Dantas, Amadora, Lisboa 1300-456');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Cliente_BEFORE_INSERT` BEFORE INSERT ON `Cliente` FOR EACH ROW BEGIN
    IF (TIMESTAMPDIFF(YEAR, NEW.data_nascimento, NOW()) < 17 AND (NEW.brevete = TRUE OR NEW.formacao_paraquedismo = TRUE))
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O Cliente deve ter 17 ou mais anos para ter brevete ou formação em paraquedismo';
    END IF;
    IF NEW.genero NOT IN ('M','F')
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O genero deve ser M ou F';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Cliente_servico`
--

DROP TABLE IF EXISTS `Cliente_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Cliente_servico` (
  `id_cliente` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `pagamento` decimal(10,2) NOT NULL,
  `presenca` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cliente`,`id_servico`),
  KEY `id_cliente_idx` (`id_cliente`),
  KEY `id_servico_servico_cliente_idx` (`id_servico`),
  CONSTRAINT `id_cliente_cliente_servico` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_servico_cliente_servico` FOREIGN KEY (`id_servico`) REFERENCES `Servico_ao_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente_servico`
--

LOCK TABLES `Cliente_servico` WRITE;
/*!40000 ALTER TABLE `Cliente_servico` DISABLE KEYS */;
INSERT INTO `Cliente_servico` VALUES (1,1,40.50,0),(1,8,103.50,0),(1,15,18.00,0),(2,3,40.50,0),(2,15,18.00,0),(2,17,9.50,0),(3,6,57.00,0),(3,11,40.50,0),(3,15,18.00,0),(3,17,9.50,0),(4,6,57.00,0),(4,15,18.00,0),(4,17,9.50,0),(5,6,60.00,0),(5,15,20.00,0),(5,17,10.00,0),(6,6,60.00,0),(6,16,20.00,0),(6,17,10.00,0),(7,7,60.00,0),(7,16,20.00,0),(7,19,10.00,0),(8,7,60.00,0),(8,16,20.00,0),(8,19,10.00,0),(9,7,60.00,0),(9,16,20.00,0),(9,19,10.00,0),(10,7,57.00,0),(10,19,9.50,0),(11,14,20.00,0),(11,22,10.00,0),(12,14,18.00,0),(12,22,9.50,0),(13,8,103.50,0),(13,14,18.00,0),(14,8,103.50,0),(14,18,85.50,0),(14,23,160.00,0),(15,22,10.00,0);
/*!40000 ALTER TABLE `Cliente_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dias_da_semana`
--

DROP TABLE IF EXISTS `Dias_da_semana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Dias_da_semana` (
  `id` int(11) NOT NULL,
  `dia` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`,`dia`),
  CONSTRAINT `id_dias_da_semana` FOREIGN KEY (`id`) REFERENCES `Horario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dias_da_semana`
--

LOCK TABLES `Dias_da_semana` WRITE;
/*!40000 ALTER TABLE `Dias_da_semana` DISABLE KEYS */;
INSERT INTO `Dias_da_semana` VALUES (1,2),(1,3),(1,4),(1,5),(1,6),(2,2),(2,3),(2,4),(2,5),(2,6),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(4,2),(4,3),(4,4),(4,5),(4,6),(5,2),(5,3),(5,4),(5,5),(5,6);
/*!40000 ALTER TABLE `Dias_da_semana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estado`
--

DROP TABLE IF EXISTS `Estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Estado` (
  `id` tinyint(4) NOT NULL,
  `designacao` varchar(63) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `designacao_UNIQUE` (`designacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estado`
--

LOCK TABLES `Estado` WRITE;
/*!40000 ALTER TABLE `Estado` DISABLE KEYS */;
INSERT INTO `Estado` VALUES (3,'Adiado'),(2,'Cancelado'),(1,'Finalizado'),(4,'Por finalizar');
/*!40000 ALTER TABLE `Estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcao`
--

DROP TABLE IF EXISTS `Funcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Funcao` (
  `id` tinyint(4) NOT NULL,
  `designacao` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `designacao_UNIQUE` (`designacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcao`
--

LOCK TABLES `Funcao` WRITE;
/*!40000 ALTER TABLE `Funcao` DISABLE KEYS */;
INSERT INTO `Funcao` VALUES (1,'Administrador'),(4,'Auxiliar'),(3,'Controlador'),(6,'Instrutor'),(5,'Piloto'),(2,'Rececionista'),(7,'Revisor');
/*!40000 ALTER TABLE `Funcao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcao_funcionario`
--

DROP TABLE IF EXISTS `Funcao_funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Funcao_funcionario` (
  `numero` int(11) NOT NULL,
  `funcao` tinyint(4) NOT NULL,
  PRIMARY KEY (`numero`,`funcao`),
  KEY `funcao_funcao_funcionario_idx` (`funcao`),
  CONSTRAINT `funcao_funcao_funcionario` FOREIGN KEY (`funcao`) REFERENCES `Funcao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `numero_funcao_funcionario` FOREIGN KEY (`numero`) REFERENCES `Funcionario` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcao_funcionario`
--

LOCK TABLES `Funcao_funcionario` WRITE;
/*!40000 ALTER TABLE `Funcao_funcionario` DISABLE KEYS */;
INSERT INTO `Funcao_funcionario` VALUES (1,1),(2,2),(3,2),(9,2),(4,3),(10,3),(5,4),(6,5),(8,5),(12,5),(13,5),(6,6),(7,6),(8,6),(11,6),(12,6),(13,6),(7,7),(8,7),(14,7);
/*!40000 ALTER TABLE `Funcao_funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcionario`
--

DROP TABLE IF EXISTS `Funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Funcionario` (
  `numero` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `data_de_nascimento` date NOT NULL,
  `genero` char(1) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `empregado` tinyint(4) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcionario`
--

LOCK TABLES `Funcionario` WRITE;
/*!40000 ALTER TABLE `Funcionario` DISABLE KEYS */;
INSERT INTO `Funcionario` VALUES (1,'José Aerodromo','1969-05-24','M','2018-10-20 09:00:00',1,1100.87),(2,'Sílvia Despedida','1981-01-14','F','2018-10-20 09:00:00',0,676.67),(3,'Maria Rececionista','1972-10-02','F','2018-10-20 09:00:00',1,676.67),(4,'Joaquim Controlador','1977-05-15','M','2018-10-20 09:00:00',1,714.33),(5,'Matilde Auxiliar','1994-03-13','F','2018-10-20 09:00:00',1,598.44),(6,'Selestina Piloto In','1952-08-07','F','2018-10-20 09:00:00',1,850.07),(7,'Eduarda Revisor In','1979-04-02','M','2018-10-20 09:00:00',1,800.57),(8,'Luís Faztudo','1979-10-01','M','2018-10-20 09:00:00',1,900.56),(9,'Catarina Castro','1977-03-06','F','2018-10-20 09:00:00',1,676.67),(10,'Luís Viterbo','1982-06-29','M','2018-10-20 09:00:00',1,713.33),(11,'Luisa Maria','1992-07-22','F','2018-10-20 09:00:00',1,676.67),(12,'Luís Viterbo','1982-06-29','M','2018-10-20 09:00:00',1,750.70),(13,'Luisa Maria','1992-07-22','F','2018-10-20 09:00:00',1,750.70),(14,'Luisa Maria','1992-07-22','F','2018-10-20 09:00:00',0,676.67);
/*!40000 ALTER TABLE `Funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Horario`
--

DROP TABLE IF EXISTS `Horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Horario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Horario`
--

LOCK TABLES `Horario` WRITE;
/*!40000 ALTER TABLE `Horario` DISABLE KEYS */;
INSERT INTO `Horario` VALUES (1,'2018-09-01','2019-07-30','06:00:00','14:00:00'),(2,'2018-09-01','2019-07-30','14:00:00','22:00:00'),(3,'2018-09-01','2019-07-30','09:30:00','16:00:00'),(4,'2018-09-01','2019-07-30','15:00:00','23:00:00'),(5,'2018-09-01','2019-07-30','15:00:00','09:00:00');
/*!40000 ALTER TABLE `Horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Horario_funcionario`
--

DROP TABLE IF EXISTS `Horario_funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Horario_funcionario` (
  `id_horario` int(11) NOT NULL,
  `id_funcionario` int(11) NOT NULL,
  PRIMARY KEY (`id_horario`,`id_funcionario`),
  KEY `funcionario_id_idx` (`id_funcionario`),
  CONSTRAINT `id_funcionario_horario_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `Funcionario` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_horario_horario_funcionario` FOREIGN KEY (`id_horario`) REFERENCES `Horario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Horario_funcionario`
--

LOCK TABLES `Horario_funcionario` WRITE;
/*!40000 ALTER TABLE `Horario_funcionario` DISABLE KEYS */;
INSERT INTO `Horario_funcionario` VALUES (3,1),(1,2),(1,3),(1,4),(4,5),(2,6),(3,7),(4,8),(2,9),(2,10),(2,11),(1,12),(2,13),(4,14);
/*!40000 ALTER TABLE `Horario_funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lugar_local`
--

DROP TABLE IF EXISTS `Lugar_local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Lugar_local` (
  `id` tinyint(4) NOT NULL,
  `designacao` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `designacao_UNIQUE` (`designacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lugar_local`
--

LOCK TABLES `Lugar_local` WRITE;
/*!40000 ALTER TABLE `Lugar_local` DISABLE KEYS */;
INSERT INTO `Lugar_local` VALUES (1,'Hangar A'),(2,'Hangar B'),(3,'Hangar C'),(4,'Hangar D'),(5,'Hangar E');
/*!40000 ALTER TABLE `Lugar_local` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manutencao`
--

DROP TABLE IF EXISTS `Manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Manutencao` (
  `id` int(11) NOT NULL,
  `marcas_da_aeronave` varchar(6) NOT NULL,
  `despesas` decimal(10,2) DEFAULT NULL,
  `fatura` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `marcas_da_aeronave_servico_interno_idx` (`marcas_da_aeronave`),
  CONSTRAINT `id_manutencao` FOREIGN KEY (`id`) REFERENCES `Servico` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `marcas_da_aeronave_manutencao` FOREIGN KEY (`marcas_da_aeronave`) REFERENCES `Aviao` (`marcas_da_aeronave`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manutencao`
--

LOCK TABLES `Manutencao` WRITE;
/*!40000 ALTER TABLE `Manutencao` DISABLE KEYS */;
INSERT INTO `Manutencao` VALUES (2,'CS-AVC',NULL,NULL),(4,'CS-MRQ',150.00,55555784),(5,'CS-MDQ',NULL,NULL),(10,'CS-MRQ',NULL,NULL),(12,'CS-AVC',300.00,87418921),(13,'CS-MDQ',NULL,NULL),(20,'CS-AVC',20.00,87712345);
/*!40000 ALTER TABLE `Manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quotas`
--

DROP TABLE IF EXISTS `Quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Quotas` (
  `id` int(11) NOT NULL,
  `ano` year(4) NOT NULL,
  PRIMARY KEY (`id`,`ano`),
  CONSTRAINT `id_quotas` FOREIGN KEY (`id`) REFERENCES `Socio` (`numero_socio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quotas`
--

LOCK TABLES `Quotas` WRITE;
/*!40000 ALTER TABLE `Quotas` DISABLE KEYS */;
INSERT INTO `Quotas` VALUES (1,2016),(1,2017),(2,2016),(2,2018),(3,2016),(3,2017),(3,2018),(4,2016),(4,2017),(4,2018),(5,2018),(6,2017),(7,2017),(7,2018),(8,2018),(9,2016),(9,2017),(9,2018);
/*!40000 ALTER TABLE `Quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servico`
--

DROP TABLE IF EXISTS `Servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Servico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` tinyint(4) NOT NULL,
  `data_de_inicio` datetime NOT NULL,
  `duracao` time NOT NULL,
  `observacao` text,
  PRIMARY KEY (`id`),
  KEY `estado_idx` (`estado`) /*!80000 INVISIBLE */,
  CONSTRAINT `estado_servico` FOREIGN KEY (`estado`) REFERENCES `Estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servico`
--

LOCK TABLES `Servico` WRITE;
/*!40000 ALTER TABLE `Servico` DISABLE KEYS */;
INSERT INTO `Servico` VALUES (1,3,'2018-11-20 08:00:00','02:00:00',NULL),(2,1,'2018-11-20 09:30:00','04:00:00',NULL),(3,3,'2018-11-20 10:00:00','02:00:00',NULL),(4,1,'2018-11-20 15:00:00','04:00:00','Derrame de óleo'),(5,1,'2018-11-20 22:10:00','01:00:00',NULL),(6,1,'2018-11-20 14:00:00','02:00:00',NULL),(7,1,'2018-11-20 16:00:00','02:00:00',NULL),(8,1,'2018-11-20 18:00:00','02:00:00',NULL),(9,2,'2018-11-20 20:00:00','02:00:00',NULL),(10,1,'2018-11-20 14:00:00','02:00:00',NULL),(11,3,'2018-11-20 12:00:00','02:00:00',NULL),(12,1,'2018-11-20 16:15:00','01:00:00','Coisas mecanicas'),(13,2,'2018-11-20 14:00:00','02:00:00',NULL),(14,1,'2018-11-20 16:00:00','02:00:00',NULL),(15,1,'2018-11-20 18:00:00','02:00:00',NULL),(16,1,'2018-11-20 20:00:00','02:00:00',NULL),(17,1,'2018-11-20 15:00:00','02:00:00',NULL),(18,1,'2018-11-20 15:00:00','02:00:00',NULL),(19,3,'2018-11-20 17:00:00','02:00:00',NULL),(20,1,'2018-11-20 22:00:00','01:00:00','Coisas mecanicas'),(22,1,'2018-11-20 19:00:00','02:00:00',NULL),(23,1,'2018-11-20 20:00:00','02:00:00',NULL);
/*!40000 ALTER TABLE `Servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servico_ao_cliente`
--

DROP TABLE IF EXISTS `Servico_ao_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Servico_ao_cliente` (
  `id` int(11) NOT NULL,
  `tipo` tinyint(4) NOT NULL,
  `limite_clientes` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_servico_externo_idx` (`tipo`),
  CONSTRAINT `id_servico_ao_cliente` FOREIGN KEY (`id`) REFERENCES `Servico` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipo_servico_ao_cliente` FOREIGN KEY (`tipo`) REFERENCES `Tipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servico_ao_cliente`
--

LOCK TABLES `Servico_ao_cliente` WRITE;
/*!40000 ALTER TABLE `Servico_ao_cliente` DISABLE KEYS */;
INSERT INTO `Servico_ao_cliente` VALUES (1,6,1),(3,6,1),(6,2,4),(7,2,4),(8,1,4),(9,1,4),(11,6,1),(13,5,10),(14,5,10),(15,5,10),(16,5,10),(17,4,5),(18,7,1),(19,4,5),(22,4,5),(23,3,1);
/*!40000 ALTER TABLE `Servico_ao_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servico_funcionario`
--

DROP TABLE IF EXISTS `Servico_funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Servico_funcionario` (
  `id_servico` int(11) NOT NULL,
  `id_funcionario` int(11) NOT NULL,
  `funcao` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_servico`,`id_funcionario`),
  KEY `id_servico_idx` (`id_servico`),
  KEY `funcao_idx` (`funcao`),
  KEY `id_funcionario_idx` (`id_funcionario`),
  CONSTRAINT `funcao_servico_funcionario` FOREIGN KEY (`funcao`) REFERENCES `Funcao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_funcionario_servico_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `Funcionario` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_servico_servico_funcionario` FOREIGN KEY (`id_servico`) REFERENCES `Servico` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servico_funcionario`
--

LOCK TABLES `Servico_funcionario` WRITE;
/*!40000 ALTER TABLE `Servico_funcionario` DISABLE KEYS */;
INSERT INTO `Servico_funcionario` VALUES (6,6,5),(7,6,5),(8,6,5),(9,6,5),(23,6,5),(1,12,6),(3,12,6),(11,12,6),(13,13,6),(14,13,6),(15,13,6),(16,13,6),(17,9,6),(19,9,6),(22,8,6),(2,7,7),(4,14,7),(5,14,7),(10,7,7),(12,7,7),(20,9,7);
/*!40000 ALTER TABLE `Servico_funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Socio`
--

DROP TABLE IF EXISTS `Socio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Socio` (
  `id_cliente` int(11) NOT NULL,
  `numero_socio` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `numero_socio_UNIQUE` (`numero_socio`),
  CONSTRAINT `id_servico_socio` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Socio`
--

LOCK TABLES `Socio` WRITE;
/*!40000 ALTER TABLE `Socio` DISABLE KEYS */;
INSERT INTO `Socio` VALUES (1,1),(2,2),(3,3),(4,4),(10,5),(12,6),(13,7),(14,8),(15,9);
/*!40000 ALTER TABLE `Socio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tipo`
--

DROP TABLE IF EXISTS `Tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Tipo` (
  `id` tinyint(4) NOT NULL,
  `designacao` varchar(255) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipo`
--

LOCK TABLES `Tipo` WRITE;
/*!40000 ALTER TABLE `Tipo` DISABLE KEYS */;
INSERT INTO `Tipo` VALUES (1,'Paraquedismo',115.00,0.10),(2,'Voo panorâmico',60.00,0.05),(3,'Voo privado',200.00,0.20),(4,'Aula de paraquedismo',10.00,0.05),(5,'Aula de pilotagem teórica',20.00,0.10),(6,'Aula de pilotagem prática',45.00,0.10),(7,'Voo privado sem aluguer',90.00,0.05);
/*!40000 ALTER TABLE `Tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ciclos_planeado`
--

DROP TABLE IF EXISTS `ciclos_planeado`;
/*!50001 DROP VIEW IF EXISTS `ciclos_planeado`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `ciclos_planeado` AS SELECT 
 1 AS `id_servico`,
 1 AS `marcas_da_aeronave`,
 1 AS `hora_partida_prevista`,
 1 AS `hora_chegada_prevista`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `despesa_Funcionarios`
--

DROP TABLE IF EXISTS `despesa_Funcionarios`;
/*!50001 DROP VIEW IF EXISTS `despesa_Funcionarios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `despesa_Funcionarios` AS SELECT 
 1 AS `Nome`,
 1 AS `Número`,
 1 AS `acumulado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `despesa_Socios`
--

DROP TABLE IF EXISTS `despesa_Socios`;
/*!50001 DROP VIEW IF EXISTS `despesa_Socios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `despesa_Socios` AS SELECT 
 1 AS `id_cliente`,
 1 AS `numero_socio`,
 1 AS `nome`,
 1 AS `Perda`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `list_Clientes`
--

DROP TABLE IF EXISTS `list_Clientes`;
/*!50001 DROP VIEW IF EXISTS `list_Clientes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `list_Clientes` AS SELECT 
 1 AS `Nome`,
 1 AS `Brevete`,
 1 AS `Formação de Paraquedismo`,
 1 AS `Género`,
 1 AS `Número de Telefone`,
 1 AS `Morada`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `lucro_Avioes`
--

DROP TABLE IF EXISTS `lucro_Avioes`;
/*!50001 DROP VIEW IF EXISTS `lucro_Avioes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `lucro_Avioes` AS SELECT 
 1 AS `Marcas da aeronave`,
 1 AS `Modelo`,
 1 AS `Despesa em Manutenções`,
 1 AS `Rendimento em Serviços`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `lugares_livres`
--

DROP TABLE IF EXISTS `lugares_livres`;
/*!50001 DROP VIEW IF EXISTS `lugares_livres`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `lugares_livres` AS SELECT 
 1 AS `Designação`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `mydb`
--

USE `mydb`;

--
-- Final view structure for view `ciclos_planeado`
--

/*!50001 DROP VIEW IF EXISTS `ciclos_planeado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ciclos_planeado` AS select `C`.`id_servico` AS `id_servico`,`C`.`marcas_da_aeronave` AS `marcas_da_aeronave`,`C`.`hora_partida_prevista` AS `hora_partida_prevista`,`C`.`hora_chegada_prevista` AS `hora_chegada_prevista` from ((`Ciclo` `C` join `Servico_ao_cliente` `SC` on((`SC`.`id` = `C`.`id_servico`))) join `Servico` `S` on((`S`.`id` = `SC`.`id`))) where ((cast(`S`.`data_de_inicio` as date) >= cast(now() as date)) and isnull(`C`.`hora_partida`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `despesa_Funcionarios`
--

/*!50001 DROP VIEW IF EXISTS `despesa_Funcionarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `despesa_Funcionarios` AS select `F`.`nome` AS `Nome`,`F`.`numero` AS `Número`,((-(1) * (1 + timestampdiff(MONTH,`F`.`data_criacao`,now()))) * `F`.`salario`) AS `acumulado` from `Funcionario` `F` order by ((-(1) * (1 + timestampdiff(MONTH,`F`.`data_criacao`,now()))) * `F`.`salario`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `despesa_Socios`
--

/*!50001 DROP VIEW IF EXISTS `despesa_Socios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `despesa_Socios` AS select `CS`.`id_cliente` AS `id_cliente`,`socios`.`numero_socio` AS `numero_socio`,`socios`.`nome` AS `nome`,(-(1) * sum((`precos`.`preco` - `CS`.`pagamento`))) AS `Perda` from ((`Cliente_servico` `CS` join (select `C`.`id` AS `id`,`SO`.`numero_socio` AS `numero_socio`,`C`.`nome` AS `nome` from (`Cliente` `C` join `Socio` `SO` on((`SO`.`id_cliente` = `C`.`id`)))) `socios` on((`socios`.`id` = `CS`.`id_cliente`))) join (select `SAC`.`id` AS `id`,`T`.`preco` AS `preco`,`T`.`desconto` AS `desconto` from (`Servico_ao_cliente` `SAC` join `Tipo` `T` on((`T`.`id` = `SAC`.`tipo`)))) `precos` on((`precos`.`id` = `CS`.`id_servico`))) group by `CS`.`id_cliente` order by `Perda` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `list_Clientes`
--

/*!50001 DROP VIEW IF EXISTS `list_Clientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `list_Clientes` AS select `Cliente`.`nome` AS `Nome`,`Cliente`.`brevete` AS `Brevete`,`Cliente`.`formacao_paraquedismo` AS `Formação de Paraquedismo`,`Cliente`.`genero` AS `Género`,`Cliente`.`numero_de_telefone` AS `Número de Telefone`,`Cliente`.`morada` AS `Morada` from `Cliente` order by `Cliente`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `lucro_Avioes`
--

/*!50001 DROP VIEW IF EXISTS `lucro_Avioes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lucro_Avioes` AS select `A`.`marcas_da_aeronave` AS `Marcas da aeronave`,`A`.`modelo` AS `Modelo`,ifnull(sum(`M`.`despesas`),0) AS `Despesa em Manutenções`,ifnull(sum(`CS`.`pagamento`),0) AS `Rendimento em Serviços`,(ifnull(sum(`CS`.`pagamento`),0) - ifnull(sum(`M`.`despesas`),0)) AS `Total` from ((((`Aviao` `A` left join `Ciclo` `C` on((`C`.`marcas_da_aeronave` = `A`.`marcas_da_aeronave`))) left join `Servico_ao_cliente` `SC` on((`SC`.`id` = `C`.`id_servico`))) left join `Cliente_servico` `CS` on((`CS`.`id_servico` = `SC`.`id`))) left join `Manutencao` `M` on((`M`.`marcas_da_aeronave` = `A`.`marcas_da_aeronave`))) group by `A`.`marcas_da_aeronave` order by `Total` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `lugares_livres`
--

/*!50001 DROP VIEW IF EXISTS `lugares_livres`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lugares_livres` AS select `L`.`designacao` AS `Designação` from (`Lugar_local` `L` left join `Aviao` `A` on((`A`.`lugar_local` = `L`.`id`))) where isnull(`A`.`lugar_local`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-24 10:01:58
