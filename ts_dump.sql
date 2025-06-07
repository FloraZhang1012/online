-- MySQL dump 10.13  Distrib 8.4.5, for macos13.7 (arm64)
--
-- Host: localhost    Database: ts
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_uniq` (`group_id`,`permission_id`) USING BTREE,
  KEY `auth_group_permissions_permission_id_fk` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissions_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_permission_id_fk` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_permission_codename_content_type_id_uniq` (`codename`,`content_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add chushou',7,'add_chushou'),(26,'Can change chushou',7,'change_chushou'),(27,'Can delete chushou',7,'delete_chushou'),(28,'Can view chushou',7,'view_chushou'),(29,'Can add goumai',8,'add_goumai'),(30,'Can change goumai',8,'change_goumai'),(31,'Can delete goumai',8,'delete_goumai'),(32,'Can view goumai',8,'view_goumai'),(33,'Can add guanli',9,'add_guanli'),(34,'Can change guanli',9,'change_guanli'),(35,'Can delete guanli',9,'delete_guanli'),(36,'Can view guanli',9,'view_guanli'),(37,'Can add fenlei',10,'add_fenlei'),(38,'Can change fenlei',10,'change_fenlei'),(39,'Can delete fenlei',10,'delete_fenlei'),(40,'Can view fenlei',10,'view_fenlei'),(41,'Can add diqu',11,'add_diqu'),(42,'Can change diqu',11,'change_diqu'),(43,'Can delete diqu',11,'delete_diqu'),(44,'Can view diqu',11,'view_diqu'),(45,'Can add jingqu',12,'add_jingqu'),(46,'Can change jingqu',12,'change_jingqu'),(47,'Can delete jingqu',12,'delete_jingqu'),(48,'Can view jingqu',12,'view_jingqu'),(49,'Can add ershouaddr',13,'add_ershouaddr'),(50,'Can change ershouaddr',13,'change_ershouaddr'),(51,'Can delete ershouaddr',13,'delete_ershouaddr'),(52,'Can view ershouaddr',13,'view_ershouaddr'),(53,'Can add addr',13,'add_addr'),(54,'Can change addr',13,'change_addr'),(55,'Can delete addr',13,'delete_addr'),(56,'Can view addr',13,'view_addr'),(57,'Can add shousc',14,'add_shousc'),(58,'Can change shousc',14,'change_shousc'),(59,'Can delete shousc',14,'delete_shousc'),(60,'Can view shousc',14,'view_shousc'),(61,'Can add shoupl',15,'add_shoupl'),(62,'Can change shoupl',15,'change_shoupl'),(63,'Can delete shoupl',15,'delete_shoupl'),(64,'Can view shoupl',15,'view_shoupl'),(65,'Can add sc',14,'add_sc'),(66,'Can change sc',14,'change_sc'),(67,'Can delete sc',14,'delete_sc'),(68,'Can view sc',14,'view_sc'),(69,'Can add pl',15,'add_pl'),(70,'Can change pl',15,'change_pl'),(71,'Can delete pl',15,'delete_pl'),(72,'Can view pl',15,'view_pl'),(73,'Can add dingdan',16,'add_dingdan'),(74,'Can change dingdan',16,'change_dingdan'),(75,'Can delete dingdan',16,'delete_dingdan'),(76,'Can view dingdan',16,'view_dingdan'),(77,'Can add lb',17,'add_lb'),(78,'Can change lb',17,'change_lb'),(79,'Can delete lb',17,'delete_lb'),(80,'Can view lb',17,'view_lb'),(81,'Can add session',18,'add_session'),(82,'Can change session',18,'change_session'),(83,'Can delete session',18,'delete_session'),(84,'Can view session',18,'view_session'),(85,'Can add chushou',19,'add_chushou'),(86,'Can change chushou',19,'change_chushou'),(87,'Can delete chushou',19,'delete_chushou'),(88,'Can view chushou',19,'view_chushou'),(89,'Can add goumai',20,'add_goumai'),(90,'Can change goumai',20,'change_goumai'),(91,'Can delete goumai',20,'delete_goumai'),(92,'Can view goumai',20,'view_goumai'),(93,'Can add guanli',21,'add_guanli'),(94,'Can change guanli',21,'change_guanli'),(95,'Can delete guanli',21,'delete_guanli'),(96,'Can view guanli',21,'view_guanli'),(97,'Can add diqu',23,'add_diqu'),(98,'Can change diqu',23,'change_diqu'),(99,'Can delete diqu',23,'delete_diqu'),(100,'Can view diqu',23,'view_diqu'),(101,'Can add fenlei',24,'add_fenlei'),(102,'Can change fenlei',24,'change_fenlei'),(103,'Can delete fenlei',24,'delete_fenlei'),(104,'Can view fenlei',24,'view_fenlei'),(105,'Can add jingqu',25,'add_jingqu'),(106,'Can change jingqu',25,'change_jingqu'),(107,'Can delete jingqu',25,'delete_jingqu'),(108,'Can view jingqu',25,'view_jingqu'),(109,'Can add lb',22,'add_lb'),(110,'Can change lb',22,'change_lb'),(111,'Can delete lb',22,'delete_lb'),(112,'Can view lb',22,'view_lb'),(113,'Can add sc',26,'add_sc'),(114,'Can change sc',26,'change_sc'),(115,'Can delete sc',26,'delete_sc'),(116,'Can view sc',26,'view_sc'),(117,'Can add pl',27,'add_pl'),(118,'Can change pl',27,'change_pl'),(119,'Can delete pl',27,'delete_pl'),(120,'Can view pl',27,'view_pl'),(121,'Can add dingdan',28,'add_dingdan'),(122,'Can change dingdan',28,'change_dingdan'),(123,'Can delete dingdan',28,'delete_dingdan'),(124,'Can view dingdan',28,'view_dingdan'),(125,'Can add addr',29,'add_addr'),(126,'Can change addr',29,'change_addr'),(127,'Can delete addr',29,'delete_addr'),(128,'Can view addr',29,'view_addr'),(129,'Can add notify',30,'add_notify'),(130,'Can change notify',30,'change_notify'),(131,'Can delete notify',30,'delete_notify'),(132,'Can view notify',30,'view_notify'),(133,'Can add message',31,'add_message'),(134,'Can change message',31,'change_message'),(135,'Can delete message',31,'delete_message'),(136,'Can view message',31,'view_message');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint NOT NULL,
  `is_active` tinyint NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$6sM2cBDCkHGgylal6fqpVD$nVMw2g3LZmgxgQkq/j4MbOvjKHxNRwxF6ndD751fM0g=',NULL,1,'florazhang','','','',1,1,'2025-03-16 04:44:18.868696'),(2,'pbkdf2_sha256$600000$mDUqEmLQm1AHserY5X3MQS$9R53W45G1/7R/f3jH6NI9O6ijMw6rt2/teuobZFiLhk=','2025-03-30 03:05:06.867266',1,'kkk','','','123456@qq.com',1,1,'2025-03-30 03:04:46.514903');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`) USING BTREE,
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`) USING BTREE,
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-03-30 03:05:37.894648','1','Lb object (1)',1,'[{\"added\": {}}]',22,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(29,'hello','addr'),(19,'hello','chushou'),(28,'hello','dingdan'),(23,'hello','diqu'),(24,'hello','fenlei'),(20,'hello','goumai'),(21,'hello','guanli'),(25,'hello','jingqu'),(22,'hello','lb'),(31,'hello','message'),(30,'hello','notify'),(27,'hello','pl'),(26,'hello','sc'),(18,'sessions','session'),(13,'ts','addr'),(7,'ts','chushou'),(16,'ts','dingdan'),(11,'ts','diqu'),(10,'ts','fenlei'),(8,'ts','goumai'),(9,'ts','guanli'),(12,'ts','jingqu'),(17,'ts','lb'),(15,'ts','pl'),(14,'ts','sc'),(6,'ts','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-03-19 03:03:24.126803'),(2,'auth','0001_initial','2025-03-19 03:03:24.790044'),(3,'admin','0001_initial','2025-03-19 03:03:25.023968'),(4,'admin','0002_logentry_remove_auto_add','2025-03-19 03:03:25.036965'),(5,'admin','0003_logentry_add_action_flag_choices','2025-03-19 03:03:25.045962'),(6,'contenttypes','0002_remove_content_type_name','2025-03-19 03:03:25.183917'),(7,'auth','0002_alter_permission_name_max_length','2025-03-19 03:03:25.291893'),(8,'auth','0003_alter_user_email_max_length','2025-03-19 03:03:25.365870'),(9,'auth','0004_alter_user_username_opts','2025-03-19 03:03:25.373881'),(10,'auth','0005_alter_user_last_login_null','2025-03-19 03:03:25.444866'),(11,'auth','0006_require_contenttypes_0002','2025-03-19 03:03:25.447866'),(12,'auth','0007_alter_validators_add_error_messages','2025-03-19 03:03:25.455862'),(13,'auth','0008_alter_user_username_max_length','2025-03-19 03:03:25.584930'),(14,'auth','0009_alter_user_last_name_max_length','2025-03-19 03:03:25.651897'),(15,'auth','0010_alter_group_name_max_length','2025-03-19 03:03:25.729889'),(16,'auth','0011_update_proxy_permissions','2025-03-19 03:03:25.737868'),(17,'auth','0012_alter_user_first_name_max_length','2025-03-19 03:03:25.803854'),(18,'ts','0001_initial','2025-03-19 03:03:25.912097'),(19,'sessions','0001_initial','2025-03-19 03:03:25.986127'),(20,'ts','0002_fenlei','2025-03-19 04:03:11.407838'),(21,'ts','0003_diqu','2025-03-19 04:13:40.567450'),(22,'ts','0004_jingqu','2025-03-19 05:55:51.978158'),(23,'ts','0005_alter_jingqu_dengji','2025-03-19 06:13:49.357552'),(24,'ts','0006_alter_jingqu_jianjie','2025-03-19 06:14:31.507707'),(25,'ts','0007_auto_20240319_1457','2025-03-19 06:57:39.740015'),(26,'ts','0008_ershouaddr','2025-03-19 07:01:34.978254'),(27,'ts','0009_auto_20240319_1518','2025-03-19 07:18:29.224254'),(28,'ts','0010_auto_20240319_1528','2025-03-19 07:28:17.956031'),(29,'ts','0011_rename_shousc_sc','2025-03-19 07:37:38.735875'),(30,'ts','0012_rename_shoupl_pl','2025-03-19 07:41:35.562070'),(31,'ts','0013_dingdan','2025-03-19 08:04:55.361407'),(32,'ts','0014_jingqu_collect_num','2025-03-28 03:50:15.608274'),(34,'ts','0015_lb','2025-03-29 02:17:50.028289'),(35,'hello','0001_initial','2025-03-16 12:15:57.065124'),(36,'hello','0002_diqu_fenlei_jingqu_lb_alter_chushou_table_and_more','2025-03-29 11:27:15.019026'),(37,'hello','0002_chushou_img_url_chushou_jianjie_goumai_img_url_and_more','2025-05-11 19:46:49.658750'),(38,'hello','0003_alter_dingdan_maijia_alter_addr_table_and_more','2025-05-25 10:18:46.528140'),(39,'hello','0004_pl_reply','2025-05-25 21:59:51.174306'),(40,'hello','0005_notify','2025-05-25 23:30:55.801396'),(41,'hello','0006_lb_created_at_lb_title_alter_lb_img_url','2025-05-26 01:21:09.028329'),(42,'hello','0007_message','2025-05-26 01:56:46.875823'),(43,'hello','0008_alter_message_created_at','2025-05-26 01:59:58.514429');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  KEY `django_session_expire_date_a5c62663` (`expire_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('vd5d5iau3wvhz46sj8bvpd9xvk877w46','.eJxVjMsOwiAQRf-FtSHDo9C6dO83kJkBpGogKe3K-O_apAvd3nPOfYmA21rC1tMS5ijOQovT70bIj1R3EO9Yb01yq-syk9wVedAury2m5-Vw_w4K9vKtLRhrkjYMkdNoSWXPZGEix5SRXVQ4ErBV7Nw0pIGsz6BYR-XBIGnx_gDyejg8:1tyiyw:5qLnMwQvY5tA6VELH7wh9x5wHcofNwOpUeL_fpgHp-M','2025-04-13 03:05:06.869439');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_addr`
--

DROP TABLE IF EXISTS `ts_addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_addr` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shouji` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shui_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ts_ershouaddr_shui_id_6b375960_fk_ts_goumai_id` (`shui_id`) USING BTREE,
  CONSTRAINT `ts_ershouaddr_shui_id_6b375960_fk_ts_goumai_id` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_addr`
--

LOCK TABLES `ts_addr` WRITE;
/*!40000 ALTER TABLE `ts_addr` DISABLE KEYS */;
INSERT INTO `ts_addr` VALUES (2,'ts1','0210583685','21 Queen St, Auckland',1),(3,'ts2','02105836234','213 Queen St, Auckland',2),(4,'ts3','02105829358','221 Queen St, Auckland',2),(5,'ts4','02105836853','201 Queen St, Auckland',1),(6,'flora','0239999999','123 quees street',39);
/*!40000 ALTER TABLE `ts_addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_chushou`
--

DROP TABLE IF EXISTS `ts_chushou`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_chushou` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jianjie` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_chushou`
--

LOCK TABLES `ts_chushou` WRITE;
/*!40000 ALTER TABLE `ts_chushou` DISABLE KEYS */;
INSERT INTO `ts_chushou` VALUES (1,'lb1','lb1','1.jpg','I am Admin1'),(2,'lb2','lb2','2.jpg','I am Admin2'),(3,'lb3','lb3','3.jpg','I am Admin3'),(4,'lb4','lb4','4.jpg','I am Admin4'),(6,'lblb','lblb','denglu.png','lblb'),(7,'123','pbkdf2_sha256$600000$3yqXwioqRSDohhXbkBHdG1$Gjsi6QEKPNXB6l6Bxn+c2LImdwsfWEqxXsDrZMYS5Zc=',NULL,NULL),(8,'business','pbkdf2_sha256$600000$xwRsLPed7xrAISu7fjHJfI$Hc/it8VmmWcmNdPY0FLTCScOG6oD94nlQ4EWJG6zSYw=',NULL,NULL),(9,'owner','pbkdf2_sha256$600000$AhGHB8xj6qu92cjEz3VMjk$lQWkMmJfmeGVeQ1gsLLmEWri0nOM9z4pFnqjXTSBP6w=','user.png','123');
/*!40000 ALTER TABLE `ts_chushou` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_dingdan`
--

DROP TABLE IF EXISTS `ts_dingdan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_dingdan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gmsj` date DEFAULT NULL,
  `maijia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL,
  `zfzt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shui_id` bigint NOT NULL,
  `maijia_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ts_dingdan_shui_id_d6904bc8_fk_ts_goumai_id` (`shui_id`) USING BTREE,
  CONSTRAINT `ts_dingdan_shui_id_d6904bc8_fk_ts_goumai_id` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_dingdan`
--

LOCK TABLES `ts_dingdan` WRITE;
/*!40000 ALTER TABLE `ts_dingdan` DISABLE KEYS */;
INSERT INTO `ts_dingdan` VALUES (8,'2024-03-27','James Smith','Milford Sound','milford_sound.jpg',250,'Pending Payment','0211234567','Fiordland National Park, South Island, New Zealand',2,NULL),(9,'2024-03-27','Maria Garcia','Waitomo Glowworm Caves','waitomo_caves.jpg',100,'Pending Payment','0219876543','Waikato, North Island, New Zealand',2,NULL),(10,'2024-03-27','David Smith','Hobbiton Movie Set','hobbiton.jpg',150,'Pending Payment','0214567890','Matamata, North Island, New Zealand',2,NULL),(11,'2024-03-27','Michael Smith','Rotorua Geothermal Park','rotorua_geothermal.jpg',80,'Pending Payment','0215678901','Rotorua, North Island, New Zealand',2,NULL),(12,'2024-03-28','Mary Smith','Queenstown Skyline Gondola','queenstown_gondola.jpg',90,'Pending Payment','0216789012','Queenstown, South Island, New Zealand',1,NULL),(13,'2024-03-28','Maria Hernandez','Mount Cook National Park','mt_cook.jpg',200,'Pending Payment','0217890123','Aoraki/Mount Cook National Park, South Island, New Zealand',2,NULL),(14,'2024-03-28','Maria Martinez','Tasman Glacier Boat Tour','tasman_glacier.jpg',180,'Pending Payment','0218901234','Mount Cook, South Island, New Zealand',2,NULL),(15,'2024-03-28','James Johnson','Kaikoura Whale Watching','kaikoura_whale.jpg',250,'Pending Payment','0219012345','Kaikoura, South Island, New Zealand',1,NULL),(16,'2024-03-28','Maria Rodriguez','Piha Beach Black Sand','piha_beach.jpg',50,'Pending Payment','0210123456','West Auckland, North Island, New Zealand',1,NULL),(17,'2024-03-28','Robert Smith','Tongariro Alpine Crossing','tongariro_alpine.jpg',120,'Pending Payment','0211122334','Tongariro National Park, North Island, New Zealand',1,NULL),(18,'2024-03-28','James Smith','Fiordland National Park Tour','fiordland.jpg',300,'Pending Payment','0212233445','Fiordland National Park, South Island, New Zealand',1,NULL),(19,'2024-03-29','Michael Smith','Waipapa Bay Penguin Watching','waipapa_penguins.jpg',70,'Pending Payment','0213344556','Otago, South Island, New Zealand',1,NULL),(20,'2025-05-25','{\'id\': 1, \'username\': \'lb1\', \'password\': \'lb1\', \'img_url\': \'1.jpg\', \'jianjie\': \'I am Admin1\'}','Milford Sound','milford_sound.jpg',150,'Paid','021xxxxx','New Zealand Scenic Address',39,NULL),(21,'2025-05-25','{\'id\': 3, \'username\': \'lb3\', \'password\': \'lb3\', \'img_url\': \'3.jpg\', \'jianjie\': \'I am Admin3\'}','Tongariro Alpine Crossing','tongariro.jpg',50,'Paid','021xxxxx','New Zealand Scenic Address',39,NULL),(26,'2025-05-25','{\'id\': 2, \'username\': \'lb2\', \'password\': \'lb2\', \'img_url\': \'2.jpg\', \'jianjie\': \'I am Admin2\'}','Hobbiton Movie Set','hobbiton.jpg',120,'Pending Payment','021xxxxx','New Zealand Scenic Address',39,NULL),(32,'2025-05-25','{\'id\': 3, \'username\': \'lb3\', \'password\': \'lb3\', \'img_url\': \'3.jpg\', \'jianjie\': \'I am Admin3\'}','Tongariro Alpine Crossing','tongariro.jpg',50,'Pending Payment','021xxxxx','New Zealand Scenic Address',39,NULL),(33,'2025-05-25','{\'id\': 9, \'username\': \'owner\', \'password\': \'pbkdf2_sha256$600000$GNo4N75f8nVNZF8X1kDwVu$jsa0wNUZBRNnZBF5lS74wnuk94aN3y4orirdvxOQs4U=\', \'img_url\': None, \'jianjie\': \'123\'}','123','',123,'Paid','021xxxxx','New Zealand Scenic Address',39,NULL),(34,'2025-05-25',NULL,'Milford Sound','milford_sound.jpg',150,'Pending Payment','123','12344',39,1),(35,'2025-05-25',NULL,'Tongariro Alpine Crossing','tongariro.jpg',50,'Paid','123','12344',39,3),(36,'2025-05-25',NULL,'321321','images.jpg',123,'Paid','123','12344',39,9),(37,'2025-05-26',NULL,'Milford Sound','milford_sound.jpg',150,'Paid','123','12344',39,1);
/*!40000 ALTER TABLE `ts_dingdan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_diqu`
--

DROP TABLE IF EXISTS `ts_diqu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_diqu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mingcheng` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_diqu`
--

LOCK TABLES `ts_diqu` WRITE;
/*!40000 ALTER TABLE `ts_diqu` DISABLE KEYS */;
INSERT INTO `ts_diqu` VALUES (1,'Auckland'),(2,'Wellington'),(3,'Christchurch'),(4,'Queenstown'),(5,'Rotorua'),(6,'Dunedin'),(7,'Nelson'),(8,'Hamilton'),(9,'Tauranga'),(10,'Napier'),(11,'New Plymouth'),(12,'Invercargill');
/*!40000 ALTER TABLE `ts_diqu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_fenlei`
--

DROP TABLE IF EXISTS `ts_fenlei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_fenlei` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mingcheng` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_fenlei`
--

LOCK TABLES `ts_fenlei` WRITE;
/*!40000 ALTER TABLE `ts_fenlei` DISABLE KEYS */;
INSERT INTO `ts_fenlei` VALUES (1,'Sightseeing'),(2,'Historical Sites'),(3,'Local Culture'),(4,'Literature & Art'),(5,'Scientific Exploration');
/*!40000 ALTER TABLE `ts_fenlei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_goumai`
--

DROP TABLE IF EXISTS `ts_goumai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_goumai` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jianjie` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_goumai`
--

LOCK TABLES `ts_goumai` WRITE;
/*!40000 ALTER TABLE `ts_goumai` DISABLE KEYS */;
INSERT INTO `ts_goumai` VALUES (1,'yk1','yk1','user.png','Exploring New Zealand'),(2,'yk2','yk2','tongariro.jpg','Lover of NZ landscapes'),(3,'yk3','yk3','3.jpg','Adventure seeker in NZ'),(4,'yk4','yk4','4.jpg','NZ hiking enthusiast'),(5,'yk5','yk5',NULL,'Enjoys Māori culture and history'),(6,'traveler6','traveler6',NULL,'Passionate about NZ wildlife'),(7,'traveler7','traveler7',NULL,'Food and wine lover in NZ'),(8,'test8','test8',NULL,'Tourist 8'),(19,'kkk','pbkdf2_sha256$600000$BOhcdnpvz38sR9zYKHsHk3$32xDPKdzVrmDEbzeqI6f1PKQGu6Mc+jC1U7jmpHB8zY=','hobbiton.jpg','12312312312312312312323'),(20,'test','pbkdf2_sha256$600000$One1iNnPlfHJ91FeNLDHGg$Mrb//iAJ+LzWXcXcVqAtR/JN+c5qfuHjHOIOadty+xs=','queenstown.jpg','1231231312'),(22,'flora','pbkdf2_sha256$600000$ewO3zMdZ7qWQ9HEu8Bjrm0$ophvyY/2KKE+oqxuqf5IrHs/uLhM1ftOJoSGCjCaHNU=',NULL,NULL),(23,'flora11','pbkdf2_sha256$600000$W1ALDb23zZyIBeMBVPXxip$NrS8qq+RHWxhxtieukpzoYgwOdpcWGh4QYDHTmGQVy8=',NULL,NULL),(24,'test123','pbkdf2_sha256$600000$ygOVvlKGax6t1OKdeEKSeb$lFoCgDKoXK45CdM5eDwTFRiU9IIgrGHot5lzqvxQ620=',NULL,NULL),(25,'flora123','pbkdf2_sha256$600000$N1p7Tfpav6HUiE9bqBg6lk$jfbL8+fXkYQAMxFmHgGBr3JpswMtDYoiz4fjylBtDxE=',NULL,NULL),(27,'flora1','pbkdf2_sha256$600000$9DUKtb6mdTykkZSJXV9SHx$xzoa/ql7ndhruMrD1pdeTtMkonx592sZaVUJmayqPuE=',NULL,NULL),(28,'flora00','pbkdf2_sha256$600000$ENdvrC5RcK2lGK6ssRXRfW$zrDHQ8fNhwa+SKDOe+L4xGBNoDGo6DCT4tlmDd9XPBA=',NULL,NULL),(32,'testaaa','pbkdf2_sha256$600000$lUY47L5xUKxHIijsLYsWXJ$DnqvnpAYSNiXjpFZ+XzmVn5ni9WkULSEgxQzewh9IRs=',NULL,NULL),(35,'aaa','pbkdf2_sha256$600000$6ONpGgJNoySx2nRbLnSVll$geJT2oR9TLh7opJ9FzcK1OSyNP574/wKgNEOgps7b3I=','user.png','123123123123'),(38,'test1234','pbkdf2_sha256$600000$UCZyq12DUdIdXVeumsabea$7m5o+bG8/vAkGBM/WQ+9rMBSn75zw4xqmK53hJqfFEw=','user.png',NULL),(39,'meeting','pbkdf2_sha256$600000$KA272z8W9JIgrnnaf5wjql$Ltoz0s3HeNl83qDLYoKtVZhcHH+UPlLM8dZBFeLUJBM=','waitomo.jpg',NULL);
/*!40000 ALTER TABLE `ts_goumai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_guanli`
--

DROP TABLE IF EXISTS `ts_guanli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_guanli` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_guanli`
--

LOCK TABLES `ts_guanli` WRITE;
/*!40000 ALTER TABLE `ts_guanli` DISABLE KEYS */;
INSERT INTO `ts_guanli` VALUES (1,'admin','admin'),(2,'test','pbkdf2_sha256$600000$mLCzE8FFJ5MBtD70gKdB8A$IYW39J6AQyZNF0g3aEFVLiqndx4BL/A7ixctFh9Y2y8='),(3,'admin123','pbkdf2_sha256$600000$NKEkfr8Ei8qbLZ4WSlPoRw$c8nowZs8cUH7Zgsr1z+xfS6+jpb+9K6S7ur+4el0Ywo='),(4,'admin111','pbkdf2_sha256$600000$lXZ03E23wjm7aZh6boP29Z$MmUVCYgDG39wTBRrdbJQaTcP6CdtFTLoKbGwMrfYMmQ='),(5,'jjj','pbkdf2_sha256$600000$ssnkvHKWXZOfbM1BvF593R$z19TxJ1eNQgR5Q0WQhxlgVxs+irW5xr3KGHHdo96Nxc='),(6,'jj','pbkdf2_sha256$600000$PPPKGCG9yi5ApQ3QHNnjlc$2+DKst0MLZ5reGVDrJAJ61va2+uTrgwjC8fr31dUdh4='),(7,'adminadmin','pbkdf2_sha256$600000$rdYuZBfKXSGrHJSC9LCgKp$pT4Y9kU0nsISP2QBUV6e0/yIplOZPIiQWMui70j7EF0='),(8,'admin321','pbkdf2_sha256$600000$lr7IU2Q8WR5ktmI0OqqwQL$G+vI3sq2Ba4BkUqIe7xXflVltdj0zVZPkxFdj+HAfn4='),(9,'admin1234','pbkdf2_sha256$600000$Fe4tlcvrU9V509vTE8TEHv$AebAfRF0o0jBqmYU5FVhfm/AmuckKT0EvlPqORyXkPk=');
/*!40000 ALTER TABLE `ts_guanli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_jingqu`
--

DROP TABLE IF EXISTS `ts_jingqu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_jingqu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `dizhi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dengji` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jianjie` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zhuangtai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_kaifang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_shenhe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diqu_id` int NOT NULL,
  `fenlei_id` int NOT NULL,
  `maijia_id` int NOT NULL,
  `collect_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ts_jingqu_diqu_id_12ef2b96_fk_ts_diqu_id` (`diqu_id`) USING BTREE,
  KEY `ts_jingqu_fenlei_id_e403b0fd_fk_ts_fenlei_id` (`fenlei_id`) USING BTREE,
  KEY `ts_jingqu_maijia_id_d5ae039e_fk_ts_chushou_id` (`maijia_id`) USING BTREE,
  CONSTRAINT `ts_jingqu_diqu_id_12ef2b96_fk_ts_diqu_id` FOREIGN KEY (`diqu_id`) REFERENCES `ts_diqu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ts_jingqu_fenlei_id_e403b0fd_fk_ts_fenlei_id` FOREIGN KEY (`fenlei_id`) REFERENCES `ts_fenlei` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ts_jingqu_maijia_id_d5ae039e_fk_ts_chushou_id` FOREIGN KEY (`maijia_id`) REFERENCES `ts_chushou` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_jingqu`
--

LOCK TABLES `ts_jingqu` WRITE;
/*!40000 ALTER TABLE `ts_jingqu` DISABLE KEYS */;
INSERT INTO `ts_jingqu` VALUES (1,'Milford Sound',150,'Fiordland National Park','5A','milford_sound.jpg','A breathtaking fjord known for towering cliffs, cascading waterfalls, and diverse wildlife including dolphins and penguins.','Available','Open','Approved',1,1,1,'50'),(2,'Hobbiton Movie Set',120,'Matamata, Waikato','5A','hobbiton.jpg','The famous movie set from The Lord of the Rings and The Hobbit films, offering guided tours through picturesque hobbit holes.','Available','Open','Approved',2,2,2,'81'),(3,'Tongariro Alpine Crossing',50,'Tongariro National Park','5A','tongariro.jpg','One of the world’s best day hikes, featuring volcanic landscapes, emerald lakes, and breathtaking alpine scenery.','Available','Open','Approved',3,3,3,'60'),(4,'Rotorua Geothermal Parks',100,'Rotorua','4A','rotorua.jpg','Experience geysers, hot springs, and bubbling mud pools while learning about Māori culture and traditions.','Available','Open','Approved',4,1,4,'45'),(5,'Mount Cook National Park',80,'South Island','5A','mount_cook.jpg','Home to New Zealand’s highest mountain, offering scenic hikes, glacier views, and stargazing in a Dark Sky Reserve.','Available','Open','Approved',5,2,5,'70'),(6,'Franz Josef Glacier',90,'West Coast, South Island','5A','franz_josef.jpg','A stunning glacier that descends into a lush rainforest, with options for guided ice walks and helicopter tours.','Available','Open','Approved',6,3,6,'56'),(7,'Waitomo Glowworm Caves',75,'Waitomo, North Island','5A','waitomo.jpg','A magical underground cave system illuminated by thousands of bioluminescent glowworms, best explored by boat.','Available','Open','Approved',7,1,7,'90'),(8,'Queenstown Adventure Hub',200,'Queenstown','5A','queenstown.jpg','The adventure capital of New Zealand, offering bungee jumping, skydiving, jet boating, and stunning lake views.','Available','Open','Approved',8,1,8,'100'),(17,'jjj',12,'12','12','67.jpg','12','待上架','开放中','待审核',4,1,9,'30'),(18,'23',23,'32','32','68.jpg','3','待上架','开放中','待审核',7,2,9,'30'),(19,'1231',123,'123','123','66.jpg','123','待上架','开放中','待审核',8,1,9,'30'),(20,'23',23,'32','32','68.jpg','3','待上架','开放中','待审核',8,2,9,'30'),(23,'234',234,'234','2342','','234234','Available','Open','Pending',5,2,9,'30'),(24,'123',123,'123','123','','12312','Available','Open','Approved',8,1,9,'30'),(26,'321321',123,'123','123123','images.jpg','123123','Available','Open','Approved',8,1,9,'30'),(27,'new one',50,'123 queen st','5a','67.jpeg','good','Available','Open','Approved',7,1,9,'30'),(28,'Kuirau Park',0,'1371, Pukuatua Street, Ranolf Street, Rotorua 3010','4A','kuira park.jpg','a beautiful par','Available','Open','Approved',5,1,9,'30');
/*!40000 ALTER TABLE `ts_jingqu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_lb`
--

DROP TABLE IF EXISTS `ts_lb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_lb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `img_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_lb`
--

LOCK TABLES `ts_lb` WRITE;
/*!40000 ALTER TABLE `ts_lb` DISABLE KEYS */;
INSERT INTO `ts_lb` VALUES (7,'tongariro.jpg','2025-05-26 01:48:40.079517',''),(8,'queenstown.jpg','2025-05-26 01:50:56.277837','queenstown.jpg'),(9,'new-zealand-in-pictures-beautiful-places-to-photograph-milford-sound.jpg','2025-05-26 01:53:27.775387','new-zealand-in-pictures-beautiful-places-to-photograph-milford-sound.jpg');
/*!40000 ALTER TABLE `ts_lb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_message`
--

DROP TABLE IF EXISTS `ts_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `sender_role` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_id` int NOT NULL,
  `receiver_role` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_message`
--

LOCK TABLES `ts_message` WRITE;
/*!40000 ALTER TABLE `ts_message` DISABLE KEYS */;
INSERT INTO `ts_message` VALUES (1,39,'user',8,'admin','hi',0,'2025-05-26 02:50:18.415181'),(2,39,'user',9,'owner','how are you',0,'2025-05-26 02:51:33.049105'),(3,8,'admin',8,'owner','how',0,'2025-05-26 04:08:25.328911'),(4,9,'owner',39,'user','good',0,'2025-05-26 04:36:01.349983'),(5,39,'user',9,'owner','today is good',0,'2025-05-26 05:16:27.872331'),(6,9,'owner',39,'user','thankyou',0,'2025-05-26 05:18:55.792260'),(7,9,'owner',35,'user','good',0,'2025-05-26 05:19:06.638349'),(8,8,'admin',9,'owner','good perfect',0,'2025-05-26 05:22:38.337298'),(9,8,'admin',39,'user',' hello',0,'2025-05-26 05:23:07.274111'),(10,9,'owner',8,'admin','hi',0,'2025-05-28 22:47:51.962156');
/*!40000 ALTER TABLE `ts_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_notify`
--

DROP TABLE IF EXISTS `ts_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_notify` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ts_notify_user_id_79e3f230_fk_ts_goumai_id` (`user_id`),
  CONSTRAINT `ts_notify_user_id_79e3f230_fk_ts_goumai_id` FOREIGN KEY (`user_id`) REFERENCES `ts_goumai` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_notify`
--

LOCK TABLES `ts_notify` WRITE;
/*!40000 ALTER TABLE `ts_notify` DISABLE KEYS */;
INSERT INTO `ts_notify` VALUES (1,'order','你的订单已支付成功',1,'2025-05-26 12:24:18.000000',39),(2,'comment','你的评论已被通过',0,'2025-05-26 00:56:02.385247',39),(3,'order','你的订单已支付成功',1,'2025-05-26 05:13:10.552301',39),(4,'comment','你的评论已被拒绝',0,'2025-05-26 05:20:34.886736',39),(5,'comment','你的评论已被通过',0,'2025-05-26 05:20:36.776007',39);
/*!40000 ALTER TABLE `ts_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_pl`
--

DROP TABLE IF EXISTS `ts_pl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_pl` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pl_date` date DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `is_shenhe` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '待审核',
  `jingqu_id` bigint NOT NULL,
  `shui_id` bigint NOT NULL,
  `reply` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `jingqu_id` (`jingqu_id`),
  KEY `shui_id` (`shui_id`),
  CONSTRAINT `ts_pl_ibfk_1` FOREIGN KEY (`jingqu_id`) REFERENCES `ts_jingqu` (`id`),
  CONSTRAINT `ts_pl_ibfk_2` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_pl`
--

LOCK TABLES `ts_pl` WRITE;
/*!40000 ALTER TABLE `ts_pl` DISABLE KEYS */;
INSERT INTO `ts_pl` VALUES (1,'2024-03-19','Absolutely stunning! The boat cruise through Milford Sound was magical.','Approved',1,1,NULL),(2,'2024-03-20','Loved the Hobbiton tour! It felt like stepping into the movies.','Approved',2,2,NULL),(3,'2024-03-21','A challenging but rewarding hike! The views from Tongariro were breathtaking.','Approved',3,3,NULL),(4,'2024-03-22','Rotorua’s geothermal parks were fascinating. The Māori cultural performances were a highlight.','Approved',4,4,NULL),(5,'2024-03-23','Mount Cook’s landscapes were surreal. Great spot for hiking and stargazing.','Approved',5,5,NULL),(6,'2024-03-24','The Franz Josef Glacier helicopter tour was worth every dollar!','Approved',6,6,NULL),(7,'2024-03-25','Waitomo Caves were like a fairy tale. The glowworms were mesmerizing.','Approved',7,7,NULL),(8,'2024-03-26','If you love adventure, Queenstown is the place to be! So many activities.','Approved',8,8,NULL),(9,'2024-03-27','Couldn’t get enough of Milford Sound’s waterfalls. Must-visit!','Approved',1,3,NULL),(10,'2024-03-28','Would visit Hobbiton again! Perfect for LOTR fans.','Approved',2,1,NULL),(11,'2024-03-29','The trek at Tongariro was long but the emerald lakes made it worthwhile.','Approved',3,4,NULL),(12,'2024-03-30','Rotorua’s hot springs were so relaxing! Highly recommend.','Approved',4,5,NULL),(13,'2024-03-31','Aoraki/Mount Cook was beautiful, especially at sunrise.','Pending Review',5,2,NULL),(14,'2024-04-01','Walking on the Franz Josef Glacier was a once-in-a-lifetime experience.','Pending Review',6,3,NULL),(15,'2024-04-02','Waitomo’s glowworms were magical, but the boat ride was too short.','Pending Review',7,6,NULL),(16,'2024-04-03','Queenstown exceeded expectations! Bungee jumping was incredible.','Pending Review',8,7,NULL),(18,'2025-05-17','12123','Approved',4,39,NULL),(19,'2025-05-18','123123123123','Approved',1,39,NULL),(20,'2025-05-18','perfect!','Approved',1,39,NULL),(21,'2025-05-18','good','Approved',1,39,NULL),(22,'2025-05-18','123123123123123','Approved',1,39,NULL),(23,'2025-05-26','测试评论，展示用。','Approved',1,39,NULL),(24,'2025-05-25','123123123123123','Approved',26,39,'thanks'),(25,'2025-05-26','i love it','Approved',2,39,NULL),(26,'2025-05-26','this is good!','Rejected',1,39,NULL),(27,'2025-06-01','great ','Pending',6,39,NULL),(28,'2025-06-01','great','Pending',6,39,NULL),(29,'2025-06-01','good','Pending',6,39,NULL),(30,'2025-06-01','not bad','Pending',6,39,NULL);
/*!40000 ALTER TABLE `ts_pl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ts_sc`
--

DROP TABLE IF EXISTS `ts_sc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ts_sc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sc_date` date DEFAULT NULL,
  `jingqu_id` bigint NOT NULL,
  `shui_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ts_shousc_shui_id_fc4d29ea_fk_ts_goumai_id` (`shui_id`) USING BTREE,
  KEY `ts_shousc_jingqu_id_4451932c_fk_ts_jingqu_id` (`jingqu_id`) USING BTREE,
  CONSTRAINT `ts_shousc_jingqu_id_4451932c_fk_ts_jingqu_id` FOREIGN KEY (`jingqu_id`) REFERENCES `ts_jingqu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ts_shousc_shui_id_fc4d29ea_fk_ts_goumai_id` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ts_sc`
--

LOCK TABLES `ts_sc` WRITE;
/*!40000 ALTER TABLE `ts_sc` DISABLE KEYS */;
INSERT INTO `ts_sc` VALUES (8,'2024-03-26',3,1),(58,'2024-03-28',1,3),(59,'2024-03-28',2,3),(60,'2024-03-28',5,1),(61,'2024-03-28',1,2),(62,'2024-03-28',2,2),(63,'2024-03-28',3,2),(64,'2024-03-28',4,2),(65,'2024-03-28',5,2),(66,'2024-03-28',6,2),(67,'2024-03-28',1,4),(68,'2024-03-28',2,4),(69,'2024-03-28',3,4),(70,'2024-03-28',8,4),(71,'2024-03-28',9,4),(72,'2024-03-28',3,3),(73,'2024-03-30',2,1),(75,'2024-03-30',4,1),(77,'2024-03-31',1,1),(79,'2025-05-24',2,39),(82,'2025-05-24',6,39),(84,'2025-05-26',1,39);
/*!40000 ALTER TABLE `ts_sc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-07 20:07:41
