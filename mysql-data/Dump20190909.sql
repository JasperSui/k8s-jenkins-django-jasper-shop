-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: jaspershop
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activation_email`
--

DROP TABLE IF EXISTS `activation_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activation_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_user_id` int(11) NOT NULL,
  `random_string` varchar(70) NOT NULL,
  `is_expired` bit(1) NOT NULL DEFAULT b'0',
  `send_time` datetime NOT NULL,
  `expire_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id_idx` (`to_user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`to_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activation_email`
--

LOCK TABLES `activation_email` WRITE;
/*!40000 ALTER TABLE `activation_email` DISABLE KEYS */;
INSERT INTO `activation_email` VALUES (3,15,'CqNqFXNnbD09WC3l26b6W6DtfrG3KsrdOGdeWJmKoSUBcxTGiCmrbs6VEZtdzwwkxarphN',_binary '','2019-07-15 02:29:08','2019-07-15 08:19:31'),(4,15,'CDu3IDAdTnQZpWpu2YycAnb3HYAN2e3yYdDHmsVtHeByImx4E1WTiSkewx2TW5shAoQiHW',_binary '','2019-07-15 08:19:31','2019-07-15 08:19:44');
/*!40000 ALTER TABLE `activation_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carousel`
--

DROP TABLE IF EXISTS `carousel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `carousel` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `img_path` varchar(255) NOT NULL,
  `is_enabled` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carousel`
--

LOCK TABLES `carousel` WRITE;
/*!40000 ALTER TABLE `carousel` DISABLE KEYS */;
INSERT INTO `carousel` VALUES (1,'蝦皮1','images/carousel/FotoJet (1).jpg',_binary ''),(2,'蝦皮2','images/carousel/FotoJet (2).jpg',_binary ''),(3,'蝦皮3','images/carousel/FotoJet.jpg',_binary '');
/*!40000 ALTER TABLE `carousel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-07-07 16:15:00.284666'),(2,'auth','0001_initial','2019-07-07 16:15:01.296779'),(3,'admin','0001_initial','2019-07-07 16:15:01.511312'),(4,'admin','0002_logentry_remove_auto_add','2019-07-07 16:15:01.523291'),(5,'admin','0003_logentry_add_action_flag_choices','2019-07-07 16:15:01.536284'),(6,'contenttypes','0002_remove_content_type_name','2019-07-07 16:15:01.690187'),(7,'auth','0002_alter_permission_name_max_length','2019-07-07 16:15:01.782133'),(8,'auth','0003_alter_user_email_max_length','2019-07-07 16:15:01.815111'),(9,'auth','0004_alter_user_username_opts','2019-07-07 16:15:01.828103'),(10,'auth','0005_alter_user_last_login_null','2019-07-07 16:15:01.907054'),(11,'auth','0006_require_contenttypes_0002','2019-07-07 16:15:01.913051'),(12,'auth','0007_alter_validators_add_error_messages','2019-07-07 16:15:01.925044'),(13,'auth','0008_alter_user_username_max_length','2019-07-07 16:15:02.099934'),(14,'auth','0009_alter_user_last_name_max_length','2019-07-07 16:15:02.235851'),(15,'sessions','0001_initial','2019-07-07 16:15:02.294814');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3ymy4t5q00t44n8tc8nz6r11wgi62e8v','MDZlNjhlODZkMWEwY2M0YjliZDJmNjZjZGNlMTQzNjAyYTY5YWYyZDp7InVzZXJfaWQiOjE1LCJjYXJ0X2xpc3QiOltbMiwiMSJdXX0=','2019-08-03 14:56:46.728604'),('bmrw6r0x15ojoma8vwjrj9vu5rm8vu6z','MzUwNmFlYTRjMmZiOWMyNDA4MTFmMDQwMzhmNmRmMjU1ZjcxNDYwZDp7InVzZXJfaWQiOjE1fQ==','2019-09-15 19:40:25.890024'),('g2gwyq1uwxwuep2hzdhc6b7nqnmshw54','NTk1NzBiMWZlMGVjZDI4MDIzNzUwMzU4MmE3ZmNkZWY4Yjc3OWJkMDp7InVzZXJfaWQiOjE1LCJjYXJ0X2xpc3QiOltdfQ==','2019-09-01 03:31:21.955244'),('j3ozseljpmz17fvzehulw3e8x3b5aesm','MzUwNmFlYTRjMmZiOWMyNDA4MTFmMDQwMzhmNmRmMjU1ZjcxNDYwZDp7InVzZXJfaWQiOjE1fQ==','2019-09-10 17:41:18.742724'),('ptau4l1upzndj8cb6hxf9humok1gcbx7','MzUwNmFlYTRjMmZiOWMyNDA4MTFmMDQwMzhmNmRmMjU1ZjcxNDYwZDp7InVzZXJfaWQiOjE1fQ==','2019-09-15 19:40:25.839055'),('tadniz7liazoz2urqwz1g8csfiab7a3o','NjZhYzQ1ZmRlYjUxYzI2ZDdjZjgzNjRiYTRhOWMzNWFjMGY1NDI3Njp7ImNhcnRfbGlzdCI6W1szLDFdLFs1LCI0Il1dLCJ1c2VyX2lkIjoxNX0=','2019-08-23 06:20:09.467449');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `limited_time_product`
--

DROP TABLE IF EXISTS `limited_time_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `limited_time_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `special_price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  `is_enabled` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_limited_time_product_id_idx` (`product_id`),
  CONSTRAINT `fk_limited_time_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `limited_time_product`
--

LOCK TABLES `limited_time_product` WRITE;
/*!40000 ALTER TABLE `limited_time_product` DISABLE KEYS */;
INSERT INTO `limited_time_product` VALUES (1,1,500,29,'2019-08-27 00:00:00','2019-09-29 00:00:00','2019-08-27 00:00:00',_binary ''),(2,2,600,10,'2019-08-29 00:00:00','2019-09-30 00:00:00','2019-08-27 00:00:00',_binary ''),(3,3,600,50,'2019-09-05 00:00:00','2019-09-30 00:00:00','2019-09-03 00:00:00',_binary '\0');
/*!40000 ALTER TABLE `limited_time_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `order_status_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `buy_time` datetime DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `transport_time` datetime DEFAULT NULL,
  `receive_time` datetime DEFAULT NULL,
  `cancel_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_order_status_id_idx` (`order_status_id`),
  KEY `fk_product_id_idx` (`product_id`),
  CONSTRAINT `fk_ordertable_order_status_id` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`id`),
  CONSTRAINT `fk_ordertable_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ordertable_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100000019 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (100000009,15,7,1,1,2880,2880,'2019-07-29 12:50:19',NULL,NULL,NULL,NULL),(100000010,15,3,4,1,1980,1980,'2019-07-29 12:53:05',NULL,NULL,NULL,NULL),(100000011,15,3,4,1,1980,1980,'2019-07-29 13:40:16',NULL,NULL,NULL,NULL),(100000012,15,3,4,1,1980,1980,'2019-07-29 15:17:59',NULL,NULL,NULL,NULL),(100000016,15,3,4,3,1980,5940,'2019-08-09 06:22:37',NULL,NULL,NULL,NULL),(100000017,15,2,4,1,790,790,'2019-08-18 03:31:22',NULL,NULL,NULL,NULL),(100000018,15,1,1,1,500,500,'2019-09-01 19:44:33',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'待付款'),(2,'待出貨'),(3,'待收貨'),(4,'完成'),(5,'取消');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `img_path` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `sold_number` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `is_enabled` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'DR. MARTENS 男女 1460 1461 3989 3孔 8孔 馬丁 馬汀大夫 黑【A-KAY0】','images/product/shoes1.jfif',890,100,85,NULL,_binary ''),(2,'【adidas正品】男女段情侶款 運動拖鞋 三條線 愛迪達 防水止滑 一體成型 黑白/紅白/藍白/深藍白 公司貨實圖拍攝','images/product/shoes2.jfif',790,100,1472,NULL,_binary ''),(3,'[A&M SHOP]韓國 EXCELSIOR餅乾鞋 基本款','images/product/shoes3.jfif',1980,100,652,NULL,_binary ''),(4,'??現貨 熱賣 男士休閒板鞋 男鞋帆布休閒鞋 塗鴉學生帆布鞋 板鞋情侶低幫 白鞋 潮流 百搭 舒適透氣帆布鞋','images/product/shoes4.jfif',2500,100,147,NULL,_binary ''),(5,'預購+現貨✨FILA CENTER COURT B 和 CENTER COURT S 跑馬燈 帆布鞋 Fila帆布鞋','images/product/shoes5.jfif',3440,100,850,NULL,_binary ''),(6,'LCW?超特價 NEW BALANCE 247 粉 孔孝真 黑白 白 MRL247WB 黑','images/product/shoes6.jfif',1990,100,492,NULL,_binary ''),(7,'Xin Store?Converse Chuck Taylor All Star 1970 Low 帆布鞋 低筒 黑白','images/product/shoes7.jfif',2880,100,165,NULL,_binary ''),(8,'FILA DISRUPTOR 2 鋸齒 鋸齒鞋 韓國 厚底 白色 黑色 焦糖底 白粉 粉色 五色現貨','images/product/shoes8.jfif',1680,100,327,NULL,_binary ''),(9,'現貨免運 Vans板鞋 帆布鞋 Supreme Vans Authentic pro 棋盤格 黑白格 懶人鞋 範斯男女鞋','images/product/shoes9.jfif',2200,100,447,NULL,_binary ''),(10,'The Ordinary 精華液 ✨南瓜派美妝✨ 乳液 角鯊 杜鵑花酸 菸鹼胺 玻尿酸 果酸 咖啡因','images/product/beauty1.jfif',1988,100,168,NULL,_binary ''),(11,'【梨大小姐】PIEU Wonder Tension W 氣墊粉餅 粉餅 遮瑕 粉底液 APIEU 氣墊 柯基 粉底','images/product/beauty2.jfif',550,100,942,NULL,_binary ''),(12,'【DDT】 蘭芝 唇膜 假一賠十 100%正品 晚安唇膜 睡美人極萃滋養晚安唇膜 正品 現貨 Laneige 韓國 官方','images/product/beauty3.jfif',490,100,342,NULL,_binary ''),(13,'Disney 迪士尼 室內香氛 夜燈 小豬 維尼 雪寶 屹耳 大眼仔 三眼怪 史迪奇 ❤️milicent','images/product/beauty4.jfif',1700,100,148,NULL,_binary ''),(14,'正品迪邦 SGS檢驗合格 附發票 水的魔法師 水的魔術師 水的魔塑師 彈跳水壺 太空瓶 運動水壺 兒童水壺','images/product/other1.jfif',650,100,512,NULL,_binary ''),(15,'【台灣現貨】卡通圓形地墊 地毯 客廳地毯 臥房地毯','images/product/other2.jfif',290,100,645,NULL,_binary ''),(16,'Uncle-Way威叔叔 日式風茶几置物矮桌 茶几 和式矮桌 收納桌 書桌 木紋書桌','images/product/other3.jfif',890,100,215,NULL,_binary ''),(17,'H-D-東稻家居-Reira-芮拉典藏沙發-L型沙發-3人-凳-布沙發-3色','images/product/other4.jfif',14500,100,1888,NULL,_binary ''),(18,'【彬彬小舖】現貨供應-『-超值實木轉角書桌櫃-多種尺寸.顏色-』促銷中','images/product/other5.jfif',399,100,7521,NULL,_binary ''),(19,'【宜家家居~】專櫃品質-無印MUJI懶人沙發豆袋榻榻米舒適布藝客廳沙發臥室單人懶骨頭豆包袋','images/product/other6.jfif',1499,100,1572,NULL,_binary ''),(20,'北歐風素色線條小清新田園IG爆款任選台灣製雙人床包三件組','images/product/other7.jfif',2500,100,1385,NULL,_binary '');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_tag`
--

DROP TABLE IF EXISTS `product_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_tag_tag_id_idx` (`tag_id`),
  KEY `fk_product_tag_product_id_idx` (`product_id`),
  CONSTRAINT `fk_product_tag_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_tag_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_tag`
--

LOCK TABLES `product_tag` WRITE;
/*!40000 ALTER TABLE `product_tag` DISABLE KEYS */;
INSERT INTO `product_tag` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,2,1),(13,2,12),(14,2,13),(15,2,14),(16,2,15),(17,2,16),(18,2,17),(19,2,18),(20,2,19),(21,3,1),(22,3,20),(23,3,21),(24,3,22),(25,3,23),(26,4,1),(27,4,4),(28,4,5),(29,4,24),(30,4,25),(31,4,26),(32,5,1),(33,5,27),(34,5,28),(35,5,29),(36,6,1),(37,6,30),(38,6,31),(39,6,32),(40,7,1),(41,7,4),(42,7,5),(43,7,33),(44,7,34),(45,7,35),(46,7,36),(47,8,1),(48,8,37),(49,8,38),(50,8,39),(51,8,40),(52,9,1),(53,9,24),(54,9,41),(55,9,42),(56,9,43),(57,9,44),(58,9,45),(59,10,46),(60,10,47),(61,10,48),(62,10,49),(63,10,50),(64,10,51),(65,11,46),(66,11,52),(67,11,53),(68,11,54),(69,11,55),(70,11,56),(71,12,46),(72,12,57),(73,12,58),(74,12,59),(75,13,60),(76,13,61),(77,13,62),(78,13,63),(79,13,64),(80,13,65),(81,13,66),(82,13,67),(83,13,68),(84,13,69),(85,13,70),(86,13,71),(87,13,72),(88,13,73),(89,13,86),(90,13,61),(91,13,62),(92,13,63),(93,13,64),(94,13,74),(95,13,75),(96,13,76),(97,13,77),(98,13,78),(99,13,79),(100,13,80),(101,13,81),(102,15,61),(103,15,62),(104,15,63),(105,15,64),(106,15,78),(107,15,79),(108,15,80),(109,15,82),(110,15,83),(111,15,84),(112,15,85),(113,15,86),(114,15,87),(115,15,88),(116,16,61),(117,16,62),(118,16,63),(119,16,64),(120,16,78),(121,16,79),(122,16,80),(123,16,87),(124,16,88),(125,16,89),(126,16,90),(127,16,91),(128,16,92),(129,16,94),(130,16,95),(131,16,96),(132,16,97),(133,16,98),(134,17,87),(135,17,88),(136,17,99),(137,17,100),(138,17,101),(139,17,61),(140,17,62),(141,17,63),(142,17,64),(143,18,91),(144,18,92),(145,18,87),(146,18,88),(147,18,90),(148,18,102),(149,18,103),(150,18,104),(151,18,61),(152,18,62),(153,18,63),(154,18,64),(155,19,87),(156,19,88),(157,19,105),(158,19,106),(159,19,107),(160,19,108),(161,19,109),(162,19,110),(163,19,111),(164,19,112),(165,19,84),(166,19,85),(167,19,61),(168,19,62),(169,19,63),(170,19,64),(171,20,87),(172,20,88),(173,20,61),(174,20,62),(175,20,63),(176,20,64),(177,20,112),(178,20,113),(179,20,114),(180,20,115),(181,20,116),(182,20,117),(183,20,118),(184,20,119),(185,20,120);
/*!40000 ALTER TABLE `product_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_config`
--

DROP TABLE IF EXISTS `system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `system_config` (
  `name` varchar(100) NOT NULL,
  `key1` varchar(200) DEFAULT NULL,
  `value1` varchar(200) DEFAULT NULL,
  `key2` varchar(200) DEFAULT NULL,
  `value2` varchar(200) DEFAULT NULL,
  `key3` varchar(200) DEFAULT NULL,
  `value3` varchar(200) DEFAULT NULL,
  `key4` varchar(200) DEFAULT NULL,
  `value4` varchar(200) DEFAULT NULL,
  `key5` varchar(200) DEFAULT NULL,
  `value5` varchar(200) DEFAULT NULL,
  `key6` varchar(200) DEFAULT NULL,
  `value6` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_config`
--

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'鞋子'),(2,'布鞋'),(3,'不鞋'),(4,'帆布'),(5,'帆布鞋'),(6,'3孔'),(7,'DR.'),(8,'DR. MARTINS'),(9,'男女'),(10,'馬汀'),(11,'馬丁'),(12,'adidas'),(13,'愛迪達'),(14,'拖鞋'),(15,'運動'),(16,'三條線'),(17,'防水'),(18,'止滑'),(19,'葉子'),(20,'餅乾'),(21,'餅乾鞋'),(22,'韓國'),(23,'excelsior'),(24,'板鞋'),(25,'休閒鞋'),(26,'白鞋'),(27,'Fila'),(28,'fila court'),(29,'跑馬燈'),(30,'孔孝真'),(31,'nb'),(32,'new balance'),(33,'低筒'),(34,'黑白'),(35,'converse'),(36,'taylor'),(37,'鋸齒'),(38,'鋸齒鞋'),(39,'厚底'),(40,'disruptor'),(41,'vans'),(42,'supreme'),(43,'pro'),(44,'棋盤格'),(45,'範斯'),(46,'美妝'),(47,'乳液'),(48,'酸'),(49,'果酸'),(50,'咖啡因'),(51,'ordinary'),(52,'粉餅'),(53,'氣墊'),(54,'氣墊粉餅'),(55,'遮瑕'),(56,'粉底液'),(57,'唇膜'),(58,'蘭芝'),(59,'晚安唇膜'),(60,'香氛'),(61,'家居'),(62,'居家'),(63,'用品'),(64,'居家用品'),(65,'夜燈'),(66,'Disney'),(67,'夜燈'),(68,'小豬'),(69,'維尼'),(70,'雪寶'),(71,'大眼仔'),(72,'三眼怪'),(73,'史迪奇'),(74,'水壺'),(75,'膳魔師'),(76,'魔法師'),(77,'迪邦'),(78,'日常'),(79,'用品'),(80,'日常用品'),(81,'太空瓶'),(82,'地墊'),(83,'地毯'),(84,'客廳'),(85,'臥房'),(86,'卡通'),(87,'家具'),(88,'家俱'),(89,'茶几'),(90,'書桌'),(91,'木頭'),(92,'實木'),(94,'收納'),(95,'收納桌'),(96,'置物桌'),(97,'日式'),(98,'矮桌'),(99,'沙發'),(100,'L型'),(101,'3人沙發'),(102,'書桌櫃'),(103,'櫃子'),(104,'轉角櫃'),(105,'專櫃'),(106,'無印'),(107,'MUJI'),(108,'懶人'),(109,'懶人沙發'),(110,'懶骨頭'),(111,'榻榻米'),(112,'臥室'),(113,'北歐風'),(114,'北歐'),(115,'素色'),(116,'線條'),(117,'小清新'),(118,'田園'),(119,'床包'),(120,'台灣製');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `account` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT '1900-01-01 00:00:00',
  `is_enabled` bit(1) NOT NULL DEFAULT b'0',
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `account_UNIQUE` (`account`),
  UNIQUE KEY `telephone_UNIQUE` (`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (15,'suiyang03@gmail.com','0988713919','b10509018','pbkdf2_sha256$120000$7BISBN9NLsTT$yT2oGA7uS/FlwPIAVc5bFba54x7MlhQXbGVmoCKUFUw=','睢洋',NULL,NULL,_binary '','2019-07-15 02:29:08','2019-07-15 08:19:44');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'jaspershop'
--

--
-- Dumping routines for database 'jaspershop'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-09  5:35:26
