CREATE DATABASE  IF NOT EXISTS `super_shock_solutions_database` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `super_shock_solutions_database`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: super_shock_solutions_database
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargos` (
  `id_cargo` int NOT NULL AUTO_INCREMENT,
  `nome_cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_cargo`),
  UNIQUE KEY `nome_cargo` (`nome_cargo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,'administrator'),(2,'gerente'),(3,'operador');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome_funcionario` varchar(50) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `rg` varchar(9) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `id_cargo` int NOT NULL,
  `id_local` int NOT NULL,
  `senha` varchar(255) NOT NULL DEFAULT '12345',
  PRIMARY KEY (`id_funcionario`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `rg` (`rg`),
  UNIQUE KEY `email` (`email`),
  KEY `id_cargo` (`id_cargo`),
  KEY `id_local` (`id_local`),
  CONSTRAINT `funcionarios_ibfk_1` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`),
  CONSTRAINT `funcionarios_ibfk_2` FOREIGN KEY (`id_local`) REFERENCES `localizacao` (`id_local`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (21,'João Silva','12345678901','987654321','joao.silva@super.com',1,1,'12345'),(22,'Maria Oliveira','23456789012','876543219','maria.oliveira@super.com',2,2,'12345'),(23,'Carlos Souza','34567890123','765432198','carlos.souza@super.com',2,3,'12345'),(24,'Ana Costa','45678901234','654321987','ana.costa@super.com',3,1,'12345'),(25,'Pedro Rocha','56789012345','543219876','pedro.rocha@super.com',3,2,'12345'),(26,'Fernanda Lima','67890123456','432198765','fernanda.lima@super.com',3,3,'12345'),(27,'Ricardo Santos','78901234567','321987654','ricardo.santos@super.com',3,1,'12345'),(28,'Juliana Pereira','89012345678','219876543','juliana.pereira@super.com',3,2,'12345'),(29,'Luiz Almeida','90123456789','198765432','luiz.almeida@super.com',3,3,'12345'),(30,'Patrícia Gomes','01234567890','987650321','patricia.gomes@super.com',3,1,'12345');
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens`
--

DROP TABLE IF EXISTS `itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `nome_item` varchar(50) NOT NULL,
  `quantidade_item` int NOT NULL,
  `codigo_de_barras` varchar(13) NOT NULL,
  `categoria` enum('alimentos','bebidas','limpeza','higiene','eletronicos','roupas','farmacia','infantil','papelaria','construcao') DEFAULT NULL,
  `valor_de_venda` decimal(10,2) NOT NULL,
  `id_local` int NOT NULL,
  `data_de_entrada` date NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `id_local` (`id_local`),
  CONSTRAINT `itens_ibfk_1` FOREIGN KEY (`id_local`) REFERENCES `localizacao` (`id_local`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens`
--

LOCK TABLES `itens` WRITE;
/*!40000 ALTER TABLE `itens` DISABLE KEYS */;
INSERT INTO `itens` VALUES (1,'Arroz Integral 5kg',50,'7891234567890','alimentos',24.90,1,'2024-03-01'),(2,'Feijão Carioca 1kg',120,'7892345678901','alimentos',8.99,2,'2024-03-05'),(3,'Azeite de Oliva 500ml',30,'7893456789012','alimentos',32.50,1,'2024-02-28'),(4,'Refrigerante Cola 2L',80,'7894567890123','bebidas',7.49,2,'2024-03-10'),(5,'Suco de Laranja 1L',45,'7895678901234','bebidas',9.90,3,'2024-03-12'),(6,'Água Mineral 500ml',200,'7896789012345','bebidas',2.20,2,'2024-03-15'),(7,'Detergente Neutro 500ml',60,'7897890123456','limpeza',3.99,1,'2024-03-03'),(8,'Amaciante 2L',40,'7898901234567','limpeza',18.90,3,'2024-03-08'),(9,'Desinfetante Pinho 1L',75,'7899012345678','limpeza',6.75,2,'2024-03-14'),(10,'Sabonete Líquido 300ml',90,'7890123456789','higiene',12.40,2,'2024-03-02'),(11,'Pasta de Dente 90g',110,'7891122334455','higiene',4.80,3,'2024-03-07'),(12,'Papel Higiênico 30m',65,'7892233445566','higiene',15.99,1,'2024-03-11'),(13,'Fone Bluetooth',25,'7893344556677','eletronicos',89.90,3,'2024-03-04'),(14,'Carregador USB-C',50,'7894455667788','eletronicos',29.90,2,'2024-03-09'),(15,'Pilhas Alcalinas AA',150,'7895566778899','eletronicos',12.50,1,'2024-03-13'),(16,'Camiseta Básica M',70,'7896677889900','roupas',39.90,2,'2024-03-06'),(17,'Calça Jeans Masculina',35,'7897788990011','roupas',129.90,3,'2024-03-10'),(18,'Moletom Capuz',20,'7898899001122','roupas',79.90,1,'2024-03-14'),(19,'Analgésico 10 comp',100,'7899900112233','farmacia',9.99,2,'2024-03-01'),(20,'Termômetro Digital',15,'7890011223344','farmacia',45.00,3,'2024-03-05'),(21,'Curativo Adesivo',200,'7891122334456','farmacia',3.20,1,'2024-03-12'),(22,'Fralda P 48un',40,'7892233445567','infantil',54.90,3,'2024-03-07'),(23,'Mamadeira 250ml',25,'7893344556678','infantil',29.90,2,'2024-03-11'),(24,'Brinquedo Educativo',18,'7894455667789','infantil',89.90,1,'2024-03-15'),(25,'Caderno 200 folhas',60,'7895566778890','papelaria',22.90,1,'2024-03-04'),(26,'Caneta Esferográfica',300,'7896677889901','papelaria',1.99,2,'2024-03-08'),(27,'Mochila Escolar',15,'7897788990012','papelaria',149.90,3,'2024-03-13'),(28,'Cimento 50kg',80,'7898899001123','construcao',34.90,1,'2024-03-03'),(29,'Tijolo Cerâmico',1000,'7899900112234','construcao',0.89,3,'2024-03-09'),(30,'Tinta Látex 3,6L',30,'7890011223345','construcao',129.90,2,'2024-03-14');
/*!40000 ALTER TABLE `itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localizacao`
--

DROP TABLE IF EXISTS `localizacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localizacao` (
  `id_local` int NOT NULL AUTO_INCREMENT,
  `nome_local` varchar(150) NOT NULL,
  `endereco` varchar(150) NOT NULL,
  `capacidade_max` int NOT NULL,
  `responsavel` int NOT NULL,
  PRIMARY KEY (`id_local`),
  UNIQUE KEY `endereco` (`endereco`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localizacao`
--

LOCK TABLES `localizacao` WRITE;
/*!40000 ALTER TABLE `localizacao` DISABLE KEYS */;
INSERT INTO `localizacao` VALUES (1,'Depósito Central','Rua das Indústrias, 1000',5000,1),(2,'Loja Centro','Avenida Principal, 123',1500,2),(3,'Armazém Norte','Rodovia BR-101, Km 89',3000,3);
/*!40000 ALTER TABLE `localizacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_auditoria`
--

DROP TABLE IF EXISTS `logs_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_auditoria` (
  `id_registro` int NOT NULL AUTO_INCREMENT,
  `id_transacao` int NOT NULL,
  `id_local_origem` int NOT NULL,
  `id_local_destino` int NOT NULL,
  `data_registro` datetime NOT NULL,
  `status_transacao` enum('completo','em andamento') NOT NULL,
  `id_funcionario_autorizador` int NOT NULL,
  PRIMARY KEY (`id_registro`),
  KEY `id_transacao` (`id_transacao`),
  KEY `id_local_origem` (`id_local_origem`),
  KEY `id_local_destino` (`id_local_destino`),
  KEY `id_funcionario_autorizador` (`id_funcionario_autorizador`),
  CONSTRAINT `logs_auditoria_ibfk_1` FOREIGN KEY (`id_transacao`) REFERENCES `transacao` (`id_transacao`),
  CONSTRAINT `logs_auditoria_ibfk_2` FOREIGN KEY (`id_local_origem`) REFERENCES `localizacao` (`id_local`),
  CONSTRAINT `logs_auditoria_ibfk_3` FOREIGN KEY (`id_local_destino`) REFERENCES `localizacao` (`id_local`),
  CONSTRAINT `logs_auditoria_ibfk_4` FOREIGN KEY (`id_funcionario_autorizador`) REFERENCES `funcionarios` (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_auditoria`
--

LOCK TABLES `logs_auditoria` WRITE;
/*!40000 ALTER TABLE `logs_auditoria` DISABLE KEYS */;
INSERT INTO `logs_auditoria` VALUES (129,101,1,2,'2024-03-05 14:30:00','completo',22),(130,102,2,3,'2024-03-06 10:15:00','completo',23),(131,103,3,1,'2024-03-07 16:45:00','completo',21),(132,104,2,2,'2024-03-10 09:00:00','completo',22),(133,105,1,3,'2024-03-11 11:20:00','completo',21),(134,106,3,2,'2024-03-12 15:10:00','completo',23),(135,107,1,1,'2024-03-01 08:00:00','completo',21),(136,108,3,3,'2024-03-03 13:45:00','completo',23);
/*!40000 ALTER TABLE `logs_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacao`
--

DROP TABLE IF EXISTS `transacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacao` (
  `id_transacao` int NOT NULL AUTO_INCREMENT,
  `id_item` int NOT NULL,
  `quantidade_transacionada` int NOT NULL,
  `data_transacao` date DEFAULT NULL,
  `id_funcionario` int NOT NULL,
  `id_local_origem` int NOT NULL,
  `id_local_destino` int DEFAULT NULL,
  `tipo_transacao` enum('entrada','saida') NOT NULL,
  PRIMARY KEY (`id_transacao`),
  KEY `id_item` (`id_item`),
  KEY `id_funcionario` (`id_funcionario`),
  KEY `id_local_origem` (`id_local_origem`),
  KEY `id_local_destino` (`id_local_destino`),
  CONSTRAINT `transacao_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `itens` (`id_item`),
  CONSTRAINT `transacao_ibfk_2` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_funcionario`),
  CONSTRAINT `transacao_ibfk_3` FOREIGN KEY (`id_local_origem`) REFERENCES `localizacao` (`id_local`),
  CONSTRAINT `transacao_ibfk_4` FOREIGN KEY (`id_local_destino`) REFERENCES `localizacao` (`id_local`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacao`
--

LOCK TABLES `transacao` WRITE;
/*!40000 ALTER TABLE `transacao` DISABLE KEYS */;
INSERT INTO `transacao` VALUES (99,1,20,'2024-03-05',24,1,2,'saida'),(100,3,15,'2024-03-06',22,2,3,'entrada'),(101,5,30,'2024-03-07',29,3,1,'saida'),(102,4,50,'2024-03-10',25,2,NULL,'saida'),(103,7,25,'2024-03-11',27,1,NULL,'saida'),(104,10,40,'2024-03-12',26,3,NULL,'saida'),(105,2,100,'2024-03-01',21,1,1,'entrada'),(106,9,60,'2024-03-03',23,3,3,'entrada'),(107,15,80,'2024-03-08',28,1,1,'entrada'),(108,12,30,'2024-03-14',28,2,2,'entrada'),(109,20,15,'2024-03-15',29,3,3,'saida'),(110,25,10,'2024-03-16',24,1,1,'entrada'),(111,18,5,'2024-03-17',25,2,3,'saida'),(112,22,8,'2024-03-18',26,3,2,'entrada'),(113,28,12,'2024-03-19',27,1,2,'saida'),(114,1,20,'2024-03-05',24,1,2,'saida'),(115,3,15,'2024-03-06',22,2,3,'entrada'),(116,5,30,'2024-03-07',29,3,1,'saida'),(117,4,50,'2024-03-10',25,2,NULL,'saida'),(118,7,25,'2024-03-11',27,1,NULL,'saida'),(119,10,40,'2024-03-12',26,3,NULL,'saida'),(120,2,100,'2024-03-01',21,1,1,'entrada'),(121,9,60,'2024-03-03',23,3,3,'entrada'),(122,15,80,'2024-03-08',28,1,1,'entrada'),(123,12,30,'2024-03-14',28,2,2,'entrada'),(124,20,15,'2024-03-15',29,3,3,'saida'),(125,25,10,'2024-03-16',24,1,1,'entrada'),(126,18,5,'2024-03-17',25,2,3,'saida'),(127,22,8,'2024-03-18',26,3,2,'entrada'),(128,28,12,'2024-03-19',27,1,2,'saida');
/*!40000 ALTER TABLE `transacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-25 19:23:50
