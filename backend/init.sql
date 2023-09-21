-- MySQL dump 10.13  Distrib 5.7.42, for Linux (x86_64)
--
-- Host: 10.112.0.9    Database: opsplatform
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',17,'add_permission'),(2,'Can change permission',17,'change_permission'),(3,'Can delete permission',17,'delete_permission'),(4,'Can view permission',17,'view_permission'),(5,'Can add group',18,'add_group'),(6,'Can change group',18,'change_group'),(7,'Can delete group',18,'delete_group'),(8,'Can view group',18,'view_group'),(9,'Can add user',19,'add_user'),(10,'Can change user',19,'change_user'),(11,'Can delete user',19,'delete_user'),(12,'Can view user',19,'view_user'),(13,'Can add content type',1,'add_contenttype'),(14,'Can change content type',1,'change_contenttype'),(15,'Can delete content type',1,'delete_contenttype'),(16,'Can view content type',1,'view_contenttype'),(17,'Can add user',2,'add_user'),(18,'Can change user',2,'change_user'),(19,'Can delete user',2,'delete_user'),(20,'Can view user',2,'view_user'),(21,'Can add host',3,'add_host'),(22,'Can change host',3,'change_host'),(23,'Can delete host',3,'delete_host'),(24,'Can view host',3,'view_host'),(25,'Can add service',4,'add_service'),(26,'Can change service',4,'change_service'),(27,'Can delete service',4,'delete_service'),(28,'Can view service',4,'view_service'),(29,'Can add service env',5,'add_serviceenv'),(30,'Can change service env',5,'change_serviceenv'),(31,'Can delete service env',5,'delete_serviceenv'),(32,'Can view service env',5,'view_serviceenv'),(33,'Can add tree node',6,'add_treenode'),(34,'Can change tree node',6,'change_treenode'),(35,'Can delete tree node',6,'delete_treenode'),(36,'Can view tree node',6,'view_treenode'),(37,'Can add tree role',7,'add_treerole'),(38,'Can change tree role',7,'change_treerole'),(39,'Can delete tree role',7,'delete_treerole'),(40,'Can view tree role',7,'view_treerole'),(41,'Can add tree user role',8,'add_treeuserrole'),(42,'Can change tree user role',8,'change_treeuserrole'),(43,'Can delete tree user role',8,'delete_treeuserrole'),(44,'Can view tree user role',8,'view_treeuserrole'),(45,'Can add service env host',9,'add_serviceenvhost'),(46,'Can change service env host',9,'change_serviceenvhost'),(47,'Can delete service env host',9,'delete_serviceenvhost'),(48,'Can view service env host',9,'view_serviceenvhost'),(49,'Can add service conf',10,'add_serviceconf'),(50,'Can change service conf',10,'change_serviceconf'),(51,'Can delete service conf',10,'delete_serviceconf'),(52,'Can view service conf',10,'view_serviceconf'),(53,'Can add resource',11,'add_resource'),(54,'Can change resource',11,'change_resource'),(55,'Can delete resource',11,'delete_resource'),(56,'Can view resource',11,'view_resource'),(57,'Can add role',12,'add_role'),(58,'Can change role',12,'change_role'),(59,'Can delete role',12,'delete_role'),(60,'Can view role',12,'view_role'),(61,'Can add verb',13,'add_verb'),(62,'Can change verb',13,'change_verb'),(63,'Can delete verb',13,'delete_verb'),(64,'Can view verb',13,'view_verb'),(65,'Can add user role binding',14,'add_userrolebinding'),(66,'Can change user role binding',14,'change_userrolebinding'),(67,'Can delete user role binding',14,'delete_userrolebinding'),(68,'Can view user role binding',14,'view_userrolebinding'),(69,'Can add role rule verb',15,'add_roleruleverb'),(70,'Can change role rule verb',15,'change_roleruleverb'),(71,'Can delete role rule verb',15,'delete_roleruleverb'),(72,'Can view role rule verb',15,'view_roleruleverb'),(73,'Can add role rule',16,'add_rolerule'),(74,'Can change role rule',16,'change_rolerule'),(75,'Can delete role rule',16,'delete_rolerule'),(76,'Can view role rule',16,'view_rolerule'),(77,'Can add pub history',20,'add_pubhistory'),(78,'Can change pub history',20,'change_pubhistory'),(79,'Can delete pub history',20,'delete_pubhistory'),(80,'Can view pub history',20,'view_pubhistory'),(81,'Can add build history',21,'add_buildhistory'),(82,'Can change build history',21,'change_buildhistory'),(83,'Can delete build history',21,'delete_buildhistory'),(84,'Can view build history',21,'view_buildhistory');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (18,'auth','group'),(17,'auth','permission'),(19,'auth','user'),(1,'contenttypes','contenttype'),(3,'hosts','host'),(11,'permissions','resource'),(12,'permissions','role'),(16,'permissions','rolerule'),(15,'permissions','roleruleverb'),(14,'permissions','userrolebinding'),(13,'permissions','verb'),(21,'stree','buildhistory'),(20,'stree','pubhistory'),(4,'stree','service'),(10,'stree','serviceconf'),(5,'stree','serviceenv'),(9,'stree','serviceenvhost'),(6,'stree','treenode'),(7,'stree','treerole'),(8,'stree','treeuserrole'),(2,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-09-11 07:52:09.823474'),(2,'contenttypes','0002_remove_content_type_name','2023-09-11 07:52:10.107565'),(3,'hosts','0001_initial','2023-09-11 07:52:10.169680'),(4,'users','0001_initial','2023-09-11 07:52:10.266357'),(5,'permissions','0001_initial','2023-09-11 07:52:10.922270'),(6,'stree','0001_initial','2023-09-11 07:52:11.758311'),(7,'auth','0001_initial','2023-09-11 10:12:08.700590'),(8,'auth','0002_alter_permission_name_max_length','2023-09-11 10:12:08.893514'),(9,'auth','0003_alter_user_email_max_length','2023-09-11 10:12:08.944926'),(10,'auth','0004_alter_user_username_opts','2023-09-11 10:12:08.961227'),(11,'auth','0005_alter_user_last_login_null','2023-09-11 10:12:09.079323'),(12,'auth','0006_require_contenttypes_0002','2023-09-11 10:12:09.091863'),(13,'auth','0007_alter_validators_add_error_messages','2023-09-11 10:12:09.107978'),(14,'auth','0008_alter_user_username_max_length','2023-09-11 10:12:09.236878'),(15,'auth','0009_alter_user_last_name_max_length','2023-09-11 10:12:09.381186'),(16,'auth','0010_alter_group_name_max_length','2023-09-11 10:12:09.427007'),(17,'auth','0011_update_proxy_permissions','2023-09-11 10:12:09.455887'),(18,'auth','0012_alter_user_first_name_max_length','2023-09-11 10:12:09.607702'),(19,'permissions','0002_remove_roleruleverb_role_roleruleverb_rolerule','2023-09-12 14:20:20.712498'),(20,'stree','0002_treerole_description','2023-09-14 15:27:36.203605'),(21,'stree','0003_serviceenv_service_alter_serviceenv_tree_node','2023-09-15 10:45:44.935981'),(22,'stree','0004_alter_serviceenv_service','2023-09-15 10:50:23.625064'),(23,'stree','0005_remove_serviceconf_command_serviceconf_build_command_and_more','2023-09-15 14:11:31.536535'),(24,'hosts','0002_rename_permission_host_position','2023-09-15 23:33:31.573856'),(25,'stree','0006_pubhistory_buildhistory','2023-09-16 09:02:43.844931'),(26,'stree','0007_alter_buildhistory_stop_time_and_more','2023-09-16 09:02:44.059632'),(27,'stree','0008_buildhistory_build_log_alter_pubhistory_pub_log','2023-09-16 09:10:13.279728');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_host`
--

DROP TABLE IF EXISTS `hosts_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_host` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hostname` varchar(256) NOT NULL,
  `ip` varchar(128) NOT NULL,
  `cpu` varchar(128) NOT NULL,
  `memory` varchar(128) NOT NULL,
  `os` varchar(128) NOT NULL,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `position` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_host`
--

LOCK TABLES `hosts_host` WRITE;
/*!40000 ALTER TABLE `hosts_host` DISABLE KEYS */;
INSERT INTO `hosts_host` VALUES (3,'service-47.96.126.178','47.96.126.178','2','8G','linux','root','Wo15311433731.','电信机房'),(4,'service-10-112-0-13','10.112.0.13','4','8G','centos','root','........','电信机房');
/*!40000 ALTER TABLE `hosts_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_resource`
--

DROP TABLE IF EXISTS `permissions_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_resource` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `ref` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_resource`
--

LOCK TABLES `permissions_resource` WRITE;
/*!40000 ALTER TABLE `permissions_resource` DISABLE KEYS */;
INSERT INTO `permissions_resource` VALUES (3,'服务树','module.stree','module'),(4,'权限管理','module.permissions','module'),(5,'用户管理','module.users','module'),(6,'主机管理','module.hosts','module'),(9,'用户列表接口','api.users','api'),(11,'服务树节点权限接口','api.stree.perm','api');
/*!40000 ALTER TABLE `permissions_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_role`
--

DROP TABLE IF EXISTS `permissions_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_role`
--

LOCK TABLES `permissions_role` WRITE;
/*!40000 ALTER TABLE `permissions_role` DISABLE KEYS */;
INSERT INTO `permissions_role` VALUES (4,'stree_admin'),(5,'users_admin'),(6,'perm_admin'),(7,'host_admin'),(8,'stree_user'),(9,'users_api_read'),(10,'tree_node_perm_api_read_write');
/*!40000 ALTER TABLE `permissions_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_rolerule`
--

DROP TABLE IF EXISTS `permissions_rolerule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_rolerule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Resource_id` bigint NOT NULL,
  `Role_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_rolerule_Resource_id_dab9104d_fk_permissio` (`Resource_id`),
  KEY `permissions_rolerule_Role_id_ee6bccde_fk_permissions_role_id` (`Role_id`),
  CONSTRAINT `permissions_rolerule_Resource_id_dab9104d_fk_permissio` FOREIGN KEY (`Resource_id`) REFERENCES `permissions_resource` (`id`),
  CONSTRAINT `permissions_rolerule_Role_id_ee6bccde_fk_permissions_role_id` FOREIGN KEY (`Role_id`) REFERENCES `permissions_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_rolerule`
--

LOCK TABLES `permissions_rolerule` WRITE;
/*!40000 ALTER TABLE `permissions_rolerule` DISABLE KEYS */;
INSERT INTO `permissions_rolerule` VALUES (5,5,5),(9,3,4),(11,4,6),(12,6,7),(13,3,8),(14,9,9),(15,11,10);
/*!40000 ALTER TABLE `permissions_rolerule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_roleruleverb`
--

DROP TABLE IF EXISTS `permissions_roleruleverb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_roleruleverb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Verb_id` bigint NOT NULL,
  `RoleRule_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_roleruleverb_Verb_id_d106befe_fk_permissions_verb_id` (`Verb_id`),
  KEY `permissions_rolerule_RoleRule_id_ba6094e7_fk_permissio` (`RoleRule_id`),
  CONSTRAINT `permissions_rolerule_RoleRule_id_ba6094e7_fk_permissio` FOREIGN KEY (`RoleRule_id`) REFERENCES `permissions_rolerule` (`id`),
  CONSTRAINT `permissions_roleruleverb_Verb_id_d106befe_fk_permissions_verb_id` FOREIGN KEY (`Verb_id`) REFERENCES `permissions_verb` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_roleruleverb`
--

LOCK TABLES `permissions_roleruleverb` WRITE;
/*!40000 ALTER TABLE `permissions_roleruleverb` DISABLE KEYS */;
INSERT INTO `permissions_roleruleverb` VALUES (18,8,5),(19,7,5),(26,7,9),(27,8,9),(30,7,11),(31,8,11),(32,7,12),(33,8,12),(34,7,13),(35,2,14),(36,3,15),(37,6,15);
/*!40000 ALTER TABLE `permissions_roleruleverb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_userrolebinding`
--

DROP TABLE IF EXISTS `permissions_userrolebinding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_userrolebinding` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Role_id` bigint NOT NULL,
  `User_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_userrole_Role_id_557f6d40_fk_permissio` (`Role_id`),
  KEY `permissions_userrolebinding_User_id_f4f11d13_fk_users_user_id` (`User_id`),
  CONSTRAINT `permissions_userrole_Role_id_557f6d40_fk_permissio` FOREIGN KEY (`Role_id`) REFERENCES `permissions_role` (`id`),
  CONSTRAINT `permissions_userrolebinding_User_id_f4f11d13_fk_users_user_id` FOREIGN KEY (`User_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_userrolebinding`
--

LOCK TABLES `permissions_userrolebinding` WRITE;
/*!40000 ALTER TABLE `permissions_userrolebinding` DISABLE KEYS */;
INSERT INTO `permissions_userrolebinding` VALUES (6,5,2),(7,4,2),(11,6,2),(12,7,2),(13,8,6),(14,9,6),(15,10,6);
/*!40000 ALTER TABLE `permissions_userrolebinding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_verb`
--

DROP TABLE IF EXISTS `permissions_verb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_verb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_verb`
--

LOCK TABLES `permissions_verb` WRITE;
/*!40000 ALTER TABLE `permissions_verb` DISABLE KEYS */;
INSERT INTO `permissions_verb` VALUES (2,'get'),(3,'delete'),(4,'put'),(5,'show'),(6,'post'),(7,'read'),(8,'write');
/*!40000 ALTER TABLE `permissions_verb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_buildhistory`
--

DROP TABLE IF EXISTS `stree_buildhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_buildhistory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` varchar(128) NOT NULL,
  `build_cmd` longtext NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `stop_time` datetime(6) DEFAULT NULL,
  `status` varchar(128) NOT NULL,
  `operator` varchar(128) NOT NULL,
  `service_env_id` bigint NOT NULL,
  `build_log` longtext,
  PRIMARY KEY (`id`),
  KEY `stree_buildhistory_service_env_id_f1e2d8e2_fk_stree_ser` (`service_env_id`),
  CONSTRAINT `stree_buildhistory_service_env_id_f1e2d8e2_fk_stree_ser` FOREIGN KEY (`service_env_id`) REFERENCES `stree_serviceenv` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_buildhistory`
--

LOCK TABLES `stree_buildhistory` WRITE;
/*!40000 ALTER TABLE `stree_buildhistory` DISABLE KEYS */;
INSERT INTO `stree_buildhistory` VALUES (1,'2023%m16090415','sss','2023-09-16 09:04:15.511431','2023-09-16 15:26:12.810856','FAIL','lixingxing',3,'+ sss\n'),(2,'2023%m16090539','sss','2023-09-16 09:05:39.866671','2023-09-16 15:28:59.403300','FAIL','lixingxing',3,'+ sss\n'),(3,'2023%m16090628','sss','2023-09-16 09:06:28.079154',NULL,'ING','lixingxing',3,NULL),(4,'2023%m16090706','sss','2023-09-16 09:07:06.116956',NULL,'ING','lixingxing',3,NULL),(5,'2023%m16091018','sss','2023-09-16 09:10:18.468304',NULL,'ING','lixingxing',3,NULL),(6,'2023%m16091119','sss','2023-09-16 09:11:19.233342',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/6.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(7,'2023%m16091200','sss','2023-09-16 09:12:00.468835',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/7.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(8,'2023%m16091449','sss','2023-09-16 09:14:49.649803',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/8.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(9,'2023%m16091547','sss','2023-09-16 09:15:47.880111',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/9.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(10,'2023%m16091729','sss','2023-09-16 09:17:29.449282',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/10.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(11,'2023%m16092027','sss','2023-09-16 09:20:27.128182',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/11.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(12,'2023%m16092135','sss','2023-09-16 09:21:35.881801',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/12.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(13,'2023%m16092201','sss','2023-09-16 09:22:01.489365',NULL,'ING','lixingxing',3,'b\'+ sss\\n\'b\'/tmp/13.sh: line 1: sss: command not found\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(14,'2023%m16092219','sss','2023-09-16 09:22:19.397788','2023-09-16 09:22:19.928283','FAIL','lixingxing',3,'b\'+ sss\\n\''),(15,'2023%m16092326','time 10\necho 111','2023-09-16 09:23:26.784120',NULL,'ING','lixingxing',3,'b\'111\\n+ 10\\n\'b\'/tmp/15.sh: line 1: 10: command not found\\n\'b\'\\n\'b\'real\\t0m0.005s\\n\'b\'user\\t0m0.000s\\n\'b\'sys\\t0m0.001s\\n\'b\'+ echo 111\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(16,'2023%m16092513','time 10\necho 111','2023-09-16 09:25:13.828991',NULL,'ING','lixingxing',3,'b\'111\\n+ 10\\n\'b\'/tmp/16.sh: line 1: 10: command not found\\n\'b\'\\n\'b\'real\\t0m0.001s\\n\'b\'user\\t0m0.000s\\n\'b\'sys\\t0m0.001s\\n\'b\'+ echo 111\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(17,'2023%m16092641','time 10\necho 111','2023-09-16 09:26:41.670017',NULL,'ING','lixingxing',3,'b\'111\\n+ 10\\n\''),(18,'2023%m16092701','time 10\necho 111','2023-09-16 09:27:01.203983',NULL,'ING','lixingxing',3,'b\'111\\n+ 10\\n\'b\'/tmp/18.sh: line 1: 10: command not found\\n\'b\'\\n\'b\'real\\t0m0.001s\\n\'b\'user\\t0m0.001s\\n\'b\'sys\\t0m0.000s\\n\'b\'+ echo 111\\n\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\'b\'\''),(19,'2023%m16092810','time 10\necho 111','2023-09-16 09:28:10.279181','2023-09-16 09:28:10.829312','SUCCESS','lixingxing',3,'b\'111\\n+ 10\\n\''),(20,'2023%m16093224','set -x\nsleep 10\necho 111','2023-09-16 09:32:24.740785','2023-09-16 09:32:35.273395','SUCCESS','lixingxing',3,'b\'111\\n+ set -x\\n\''),(21,'2023%m16093226','set -x\nsleep 10\necho 111','2023-09-16 09:32:26.755070','2023-09-16 09:32:37.285362','SUCCESS','lixingxing',3,'b\'111\\n+ set -x\\n\''),(22,'2023%m16093346','set -x\nsleep 10\necho 111','2023-09-16 09:33:46.586175','2023-09-16 09:33:57.117067','SUCCESS','lixingxing',3,'b\'111\\n+ set -x\\n\''),(23,'2023%m16093445','set -x\nsleep 10\necho 111','2023-09-16 09:34:45.815062',NULL,'ING','lixingxing',3,NULL),(24,'2023%m16093559','set -x\nsleep 10\necho 111','2023-09-16 09:35:59.960596','2023-09-16 09:36:10.502749','SUCCESS','lixingxing',3,'b\'111\\n+ set -x\\n\''),(25,'2023%m16093724','set -x\nsleep 10\necho 111','2023-09-16 09:37:24.455439','2023-09-16 09:37:35.002608','SUCCESS','lixingxing',3,'b\'111\\n+ set -x\\n\''),(26,'2023%m16093938','set -x\nsleep 10\necho 111','2023-09-16 09:39:38.519253','2023-09-16 09:39:49.090362','SUCCESS','lixingxing',3,'b\'111\\n+ set -x\\n\''),(27,'2023%m16095050','set -x\nsleep 10\necho 111','2023-09-16 09:50:50.051280',NULL,'ING','lixingxing',3,NULL),(28,'2023%m16095121','set -x\nsleep 10\necho 111','2023-09-16 09:51:21.828003','2023-09-16 09:51:32.369034','SUCCESS','lixingxing',3,'b\'+ set -x\\n111\\n\''),(29,'20230916095949','set -x\nsleep 10\necho 111','2023-09-16 09:59:49.344975','2023-09-16 09:59:59.902764','SUCCESS','lixingxing',3,'b\'+ set -x\\n111\\n\''),(30,'20230916100013','set -x\nsleep 10\necho 111','2023-09-16 10:00:13.515523','2023-09-16 10:00:24.070802','SUCCESS','lixingxing',3,'b\'+ set -x\\n111\\n\''),(31,'20230916101725','set -x\nsleep 10\necho 111','2023-09-16 10:17:25.751955','2023-09-16 10:17:36.295717','SUCCESS','lixingxing',3,'b\'+ set -x\\n111\\n\''),(32,'20230916135754','set -x\nsleep 10\necho 111','2023-09-16 13:57:54.203438','2023-09-16 13:58:04.785480','SUCCESS','lixingxing',3,'+ set -x\n111\n'),(33,'20230916135837','set -x\nsleep 10\necho 111','2023-09-16 13:58:37.016159','2023-09-16 13:58:47.558872','SUCCESS','lixingxing',3,'+ set -x\n111\n'),(34,'20230916140230','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:02:30.691723','2023-09-16 14:02:53.254516','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(35,'20230916141045','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:10:45.478962','2023-09-16 14:11:08.025854','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(36,'20230916142329','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:23:29.606998','2023-09-16 14:23:52.156626','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(37,'20230916142509','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:25:09.854439','2023-09-16 14:25:32.415651','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(38,'20230916142617','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:26:17.049044','2023-09-16 14:26:39.583492','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(39,'20230916142722','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:27:22.057462','2023-09-16 14:27:44.591985','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(40,'20230916142948','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:29:48.306723','2023-09-16 14:30:10.841251','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(41,'20230916143046','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:30:46.455791','2023-09-16 14:31:08.999807','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(42,'20230916143250','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:32:50.675419','2023-09-16 14:33:13.209332','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(43,'20230916143329','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:33:29.840463','2023-09-16 14:33:52.376585','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(44,'20230916143626','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:36:26.801414','2023-09-16 14:36:49.343273','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(45,'20230916143806','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:38:06.229102','2023-09-16 14:38:28.799226','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(46,'20230916144002','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:40:02.545825','2023-09-16 14:40:25.112623','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(47,'20230916144037','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:40:37.413962','2023-09-16 14:40:59.951922','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(48,'20230916145441','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 14:54:41.716302','2023-09-16 14:55:04.278405','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(49,'20230916150315','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 15:03:15.191275','2023-09-16 15:03:37.724940','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(50,'20230916155412','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 15:54:12.702202','2023-09-16 15:54:35.239775','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(51,'20230916155741','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 15:57:41.725048','2023-09-16 15:58:04.258165','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(52,'20230916160621','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 16:06:21.747016','2023-09-16 16:06:44.289018','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(53,'20230916160818','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 16:08:18.992259','2023-09-16 16:08:41.553761','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(54,'20230916233435','set -x\nsleep 10\necho 111\nsleep 12\necho 22','2023-09-16 23:34:35.041782','2023-09-16 23:34:57.624595','SUCCESS','lixingxing',3,'+ set -x\n111\n+ sleep 10\n22\n'),(55,'20230918085725','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-18 08:57:25.749923','2023-09-18 08:57:48.292644','SUCCESS','lixingxing',3,'+ set -x\nstart build\n+ echo \'start build\'\nbuilding\n+ sleep 10\nbuild finish\n'),(56,'20230918085823','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-18 08:58:23.644997','2023-09-18 08:58:46.186238','SUCCESS','lixingxing',3,'+ set -x\nstart build\n+ echo \'start build\'\nbuilding\n+ sleep 10\nbuild finish\n'),(57,'20230918144037','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-18 14:40:37.516895','2023-09-18 14:41:00.053009','SUCCESS','lixingxing',3,'+ set -x\nstart build\n+ echo \'start build\'\nbuilding\n+ sleep 10\nbuild finish\n'),(58,'20230918152827','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-18 15:28:27.611988','2023-09-18 15:28:50.150241','SUCCESS','lixingxing',3,'+ set -x\nstart build\n+ echo \'start build\'\nbuilding\n+ sleep 10\nbuild finish\n'),(59,'20230919051509','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 05:15:09.678171',NULL,'FAIL','lixingxing',3,NULL),(60,'20230919051619','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 05:16:19.610075',NULL,'FAIL','lixingxing',3,NULL),(61,'20230919051705','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 05:17:05.420450','2023-09-19 05:17:16.154189','FAIL','lixingxing',3,'开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n'),(62,'20230919051823','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 05:18:23.998964','2023-09-19 05:18:34.674984','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n2\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n'),(63,'20230919054011','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 05:40:11.387843','2023-09-19 05:40:22.123768','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n8\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n'),(64,'20230919075711','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 07:57:11.032676',NULL,'FAIL','lixingxing',3,NULL),(65,'20230919075836','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 07:58:36.794061',NULL,'FAIL','lixingxing',3,NULL),(66,'20230919081336','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:13:36.940149',NULL,'FAIL','lixingxing',3,NULL),(67,'20230919081601','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:16:01.217965',NULL,'FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n'),(68,'20230919081928','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:19:28.739832','2023-09-19 08:19:39.423755','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n'),(69,'20230919082128','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:21:28.970005','2023-09-19 08:21:39.741528','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n2\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n9\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n'),(70,'20230919082842','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:28:42.324560','2023-09-19 08:28:53.056838','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n4\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n结束在服务器[47.96.126.178@service-47.96.126.178]上的构建操作\n'),(71,'20230919082934','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:29:34.030582',NULL,'FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n2\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n'),(72,'20230919083351','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:33:51.837475','2023-09-19 08:34:02.482653','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n8\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n结束在服务器[47.96.126.178@service-47.96.126.178]上的构建操作\n结束时间: 2023-09-19 08:34:02Z\n'),(73,'20230919084811','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:48:11.449535','2023-09-19 08:48:23.071600','FAIL','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\niZbp14cnv93l9ln9haf5ohZ\n+ hostname\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n5\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n结束在服务器[47.96.126.178@service-47.96.126.178]上的构建操作\n结束时间: 2023-09-19 08:48:23Z\n'),(74,'20230919084922','set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','2023-09-19 08:49:22.493810','2023-09-19 08:49:45.206290','SUCCESS','lixingxing',3,'开始在服务器[47.96.126.178@service-47.96.126.178]上执行构建操作\nstart build\n+ echo \'start build\'\n+ sleep 10\nbuilding\n+ echo building\n+ sleep 12\nbuild finish\n+ echo \'build finish\'\n结束在服务器[47.96.126.178@service-47.96.126.178]上的构建操作\n结束时间: 2023-09-19 08:49:45Z\n');
/*!40000 ALTER TABLE `stree_buildhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_pubhistory`
--

DROP TABLE IF EXISTS `stree_pubhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_pubhistory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` varchar(128) NOT NULL,
  `pub_log` longtext,
  `pub_cmd` longtext NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `stop_time` datetime(6) DEFAULT NULL,
  `status` varchar(128) NOT NULL,
  `operator` varchar(128) NOT NULL,
  `service_env_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stree_pubhistory_service_env_id_5c7a3d84_fk_stree_serviceenv_id` (`service_env_id`),
  CONSTRAINT `stree_pubhistory_service_env_id_5c7a3d84_fk_stree_serviceenv_id` FOREIGN KEY (`service_env_id`) REFERENCES `stree_serviceenv` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_pubhistory`
--

LOCK TABLES `stree_pubhistory` WRITE;
/*!40000 ALTER TABLE `stree_pubhistory` DISABLE KEYS */;
INSERT INTO `stree_pubhistory` VALUES (1,'20230916152612',NULL,'echo \"sss\"','2023-09-16 15:26:12.275751',NULL,'FAIL','lixingxing',3),(2,'20230916152858',NULL,'echo \"sss\"','2023-09-16 15:28:58.866852',NULL,'FAIL','lixingxing',3),(3,'20230916153721',NULL,'echo \"sss\"','2023-09-16 15:37:21.591343',NULL,'FAIL','lixingxing',3),(4,'20230916153952',NULL,'echo \"sss\"','2023-09-16 15:39:52.071984',NULL,'FAIL','lixingxing',3),(5,'20230916154121',NULL,'echo \"sss\"','2023-09-16 15:41:21.032700',NULL,'FAIL','lixingxing',3),(6,'20230916154257',NULL,'echo \"sss\"','2023-09-16 15:42:57.414926',NULL,'FAIL','lixingxing',3),(7,'20230916154652','+ echo sss\nsss\n','echo \"sss\"','2023-09-16 15:46:52.795711','2023-09-16 15:46:53.346692','SUCCESS','lixingxing',3),(8,'20230916155331','+ echo sss\nsss\n','echo \"sss\"','2023-09-16 15:53:31.154403','2023-09-16 15:53:31.687486','SUCCESS','lixingxing',3),(9,'20230916155425','+ echo sss\nsss\n','echo \"sss\"','2023-09-16 15:54:25.793554','2023-09-16 15:54:26.322252','SUCCESS','lixingxing',3),(10,'20230916160516','+ echo sss\nsss\n','echo \"sss\"','2023-09-16 16:05:16.465254','2023-09-16 16:05:16.996427','SUCCESS','lixingxing',3),(11,'20230916160613','+ echo sss\nsss\n','echo \"sss\"','2023-09-16 16:06:13.706360','2023-09-16 16:06:14.243814','SUCCESS','lixingxing',3),(12,'20230918085847',NULL,'echo \"start server\"','2023-09-18 08:58:47.892229',NULL,'FAIL','lixingxing',3),(13,'20230918090119',NULL,'echo \"start server\"','2023-09-18 09:01:19.439462',NULL,'FAIL','lixingxing',3),(14,'20230918091047',NULL,'echo \"start server\"','2023-09-18 09:10:47.604395',NULL,'FAIL','lixingxing',3),(15,'20230918091220',NULL,'echo \"start server\"','2023-09-18 09:12:20.445697',NULL,'FAIL','lixingxing',3),(16,'20230918091351',NULL,'echo \"start server\"','2023-09-18 09:13:51.058030',NULL,'FAIL','lixingxing',3),(17,'20230918091451',NULL,'echo \"start server\"','2023-09-18 09:14:51.519728',NULL,'FAIL','lixingxing',3),(18,'20230918091532',NULL,'echo \"start server\"','2023-09-18 09:15:32.136319',NULL,'FAIL','lixingxing',3),(19,'20230918092403',NULL,'echo \"start server\"','2023-09-18 09:24:03.449977',NULL,'FAIL','lixingxing',3),(20,'20230918092524',NULL,'echo \"start server\"','2023-09-18 09:25:24.957428',NULL,'FAIL','lixingxing',3),(21,'20230918092553','+ echo \'start server\'\nstart server\n','echo \"start server\"','2023-09-18 09:25:53.990020','2023-09-18 09:25:54.528481','SUCCESS','lixingxing',3),(22,'20230918142216','+ echo \'start server\'\nstart server\n','echo \"start server\"','2023-09-18 14:22:16.208384','2023-09-18 14:22:16.745060','SUCCESS','lixingxing',3),(23,'20230918143708','+ echo 10.112.0.9\n10.112.0.9\n','echo $hosts','2023-09-18 14:37:08.775646','2023-09-18 14:37:09.313991','SUCCESS','lixingxing',3),(24,'20230918143903','+ echo 10.112.0.9 10.112.0.13\n10.112.0.9 10.112.0.13\n','echo $hosts','2023-09-18 14:39:03.491772','2023-09-18 14:39:04.032984','SUCCESS','lixingxing',3),(25,'20230918144044','+ for host in \'$hosts\'\nmaster02\n','for host in $hosts\ndo\n     ssh $host hostname\ndone','2023-09-18 14:40:44.097685','2023-09-18 14:40:44.784777','SUCCESS','lixingxing',3),(26,'20230918144143','+ for host in \'$hosts\'\nmaster02\n','for host in $hosts\ndo\n     ssh -vvv $host hostname\ndone','2023-09-18 14:41:43.288497','2023-09-18 14:41:43.965223','SUCCESS','lixingxing',3),(27,'20230918144236','+ for host in \'$hosts\'\nmaster02\n','for host in $hosts\ndo\n     ehco $host\n     ssh -vvv $host hostname\ndone','2023-09-18 14:42:36.963502','2023-09-18 14:42:37.637640','SUCCESS','lixingxing',3),(28,'20230918144339','+ echo 10.112.0.9 10.112.0.13\n10.112.0.9 10.112.0.13\n','echo $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh -vvv $host hostname\ndone','2023-09-18 14:43:39.391777','2023-09-18 14:43:39.933208','SUCCESS','lixingxing',3),(29,'20230918144431','+ set -x\n10.112.0.9 10.112.0.13\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh -vvv $host hostname\ndone','2023-09-18 14:44:31.130790','2023-09-18 14:44:31.668648','SUCCESS','lixingxing',3),(30,'20230918144730','+ set -x\n10.112.0.9 10.112.0.13\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 14:47:30.076254','2023-09-18 14:47:30.614540','SUCCESS','lixingxing',3),(31,'20230918144850','+ set -x\n10.112.0.9\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 14:48:50.922390','2023-09-18 14:48:51.467958','SUCCESS','lixingxing',3),(32,'20230918145503',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 14:55:03.014355','2023-09-18 14:55:03.215979','FAIL','lixingxing',3),(33,'20230918145855',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 14:58:55.284617','2023-09-18 15:00:35.706176','SUCCESS','lixingxing',3),(34,'20230918150609',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:06:09.716390',NULL,'FAIL','lixingxing',3),(35,'20230918151302','1\r\n2\r\n3\r\n4\r\n5\r\n6\r\n7\r\n8\r\n9\r\n10\r\n11\r\n12\r\n13\r\n14\r\n15\r\n16\r\n17\r\n18\r\n19\r\n20\r\n21\r\n22\r\n23\r\n24\r\n25\r\n26\r\n27\r\n28\r\n29\r\n30\r\n31\r\n32\r\n33\r\n34\r\n35\r\n36\r\n37\r\n38\r\n39\r\n40\r\n41\r\n42\r\n43\r\n44\r\n45\r\n46\r\n47\r\n48\r\n49\r\n50\r\n51\r\n52\r\n53\r\n54\r\n55\r\n56\r\n57\r\n58\r\n59\r\n60\r\n61\r\n62\r\n63\r\n64\r\n65\r\n66\r\n67\r\n68\r\n69\r\n70\r\n71\r\n72\r\n73\r\n74\r\n75\r\n76\r\n77\r\n78\r\n79\r\n80\r\n81\r\n82\r\n83\r\n84\r\n85\r\n86\r\n87\r\n88\r\n89\r\n90\r\n91\r\n92\r\n93\r\n94\r\n95\r\n96\r\n97\r\n98\r\n99\r\n100\r\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:13:02.376538','2023-09-18 15:14:44.988465','SUCCESS','lixingxing',3),(36,'20230918151917',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:19:17.482078','2023-09-18 15:19:27.664612','FAIL','lixingxing',3),(37,'20230918152030',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:20:30.521849','2023-09-18 15:20:40.721121','FAIL','lixingxing',3),(38,'20230918152101',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:21:01.650588',NULL,'FAIL','lixingxing',3),(39,'20230918152150','1\r\n2\r\n3\r\n4\r\n5\r\n6\r\n7\r\n8\r\n9\r\n10\r\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:21:50.318006','2023-09-18 15:22:02.540431','FAIL','lixingxing',3),(40,'20230918152235',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:22:35.119382','2023-09-18 15:22:45.300862','FAIL','lixingxing',3),(41,'20230918152629','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:26:29.032031',NULL,'FAIL','lixingxing',3),(42,'20230918152731','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:27:31.742188','2023-09-18 15:27:43.985825','SUCCESS','lixingxing',3),(43,'20230918152838','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:28:38.572336','2023-09-18 15:28:50.794956','FAIL','lixingxing',3),(44,'20230918152932','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:29:32.131266','2023-09-18 15:29:42.405232','FAIL','lixingxing',3),(45,'20230918153254','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:32:54.689739','2023-09-18 15:33:04.997148','FAIL','lixingxing',3),(46,'20230918153340','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:33:40.812908','2023-09-18 15:33:51.101828','FAIL','lixingxing',3),(47,'20230918153444','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:34:44.879515','2023-09-18 15:34:55.154262','FAIL','lixingxing',3),(48,'20230918153951',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:39:51.019225','2023-09-18 15:40:01.231469','FAIL','lixingxing',3),(49,'20230918154029',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:40:29.134984','2023-09-18 15:40:29.335929','FAIL','lixingxing',3),(50,'20230918154300','1\n2\n3\n4\n5\n6\n7\n8\n9\n10\nzsh:1: command not found: ddd\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:43:00.338188','2023-09-18 15:43:10.548645','FAIL','lixingxing',3),(51,'20230918154550',NULL,'set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:45:50.175777',NULL,'FAIL','lixingxing',3),(52,'20230918154738','\'ServiceEnvHost\' object has no attribute \'hosts\'','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:47:38.537644',NULL,'FAIl','lixingxing',3),(53,'20230918155046','Bad authentication type; allowed types: [\'publickey\', \'gssapi-keyex\', \'gssapi-with-mic\']','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:50:46.362998','2023-09-18 15:50:46.504474','FAIL','lixingxing',3),(54,'20230918155115','Authentication failed.','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:51:15.853536','2023-09-18 15:51:16.007319','FAIL','lixingxing',3),(55,'20230918155448','开始发布服务器[10.112.0.9@service-10-112-0-9]上的服务Authentication failed.','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:54:48.545133','2023-09-18 15:54:48.670402','FAIL','lixingxing',3),(56,'20230918155500','开始发布服务器[10.112.0.9@service-10-112-0-9]上的服务\nAuthentication failed.','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:55:00.773334','2023-09-18 15:55:00.885485','FAIL','lixingxing',3),(57,'20230918155504','开始发布服务器[10.112.0.9@service-10-112-0-9]上的服务\nAuthentication failed.','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 15:55:04.232899','2023-09-18 15:55:04.353161','FAIL','lixingxing',3),(58,'20230918160114','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n\n+ echo\n','set -x\necho $hosts\nfor host in $hosts\ndo\n     ehco $host\n     ssh  -o StrictHostKeyChecking=no  $host hostname\ndone','2023-09-18 16:01:14.447288','2023-09-18 16:01:15.162893','SUCCESS','lixingxing',3),(59,'20230918160246','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n++ seq 1 10\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ dddd\nbash: line 6: dddd: command not found\n','set -x \nfor i in `seq 1 10`\ndo\n    echo $i\ndone\n\ndddd','2023-09-18 16:02:46.897920','2023-09-18 16:02:47.569507','FAIL','lixingxing',3),(60,'20230919040754','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n++ seq 1 10\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ dddd\nbash: line 6: dddd: command not found\n','set -x \nfor i in `seq 1 10`\ndo\n    echo $i\ndone\n\ndddd','2023-09-19 04:07:54.026643','2023-09-19 04:07:54.741536','FAIL','lixingxing',3),(61,'20230919040808','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n++ seq 1 10\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ dddd\nbash: line 6: dddd: command not found\n','set -x \nfor i in `seq 1 10`\ndo\n    echo $i\ndone\n\ndddd','2023-09-19 04:08:08.129828','2023-09-19 04:08:08.907102','FAIL','lixingxing',3),(62,'20230919040913','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n3\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n','set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 04:09:13.168691','2023-09-19 04:09:23.863698','FAIL','lixingxing',3),(63,'20230919075941',NULL,'set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 07:59:41.148709',NULL,'FAIL','lixingxing',3),(64,'20230919080054',NULL,'set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:00:54.631984',NULL,'FAIL','lixingxing',3),(65,'20230919080301',NULL,'set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:03:01.768306',NULL,'FAIL','lixingxing',3),(66,'20230919081316',NULL,'set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:13:16.904821',NULL,'FAIL','lixingxing',3),(67,'20230919081506',NULL,'set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:15:06.598149',NULL,'FAIL','lixingxing',3),(68,'20230919082024',NULL,'set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:20:24.516302',NULL,'FAIL','lixingxing',3),(69,'20230919082053','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n2\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n6\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n10\n+ dddd\nbash: line 8: dddd: command not found\n','set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:20:53.211693','2023-09-19 08:21:03.948205','FAIL','lixingxing',3),(70,'20230919083412','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n9\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n','set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:34:12.858977','2023-09-19 08:34:23.489173','FAIL','lixingxing',3),(71,'20230919083517','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n','set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:35:17.159827','2023-09-19 08:35:27.932669','FAIL','lixingxing',3),(72,'20230919083617','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\n+ hostname\niZbp14cnv93l9ln9haf5ohZ\n1\n++ seq 1 10\n+ for i in \'`seq 1 10`\'\n+ echo 1\n+ sleep 1\n2\n+ for i in \'`seq 1 10`\'\n+ echo 2\n+ sleep 1\n3\n+ for i in \'`seq 1 10`\'\n+ echo 3\n+ sleep 1\n4\n+ for i in \'`seq 1 10`\'\n+ echo 4\n+ sleep 1\n5\n+ for i in \'`seq 1 10`\'\n+ echo 5\n+ sleep 1\n6\n+ for i in \'`seq 1 10`\'\n+ echo 6\n+ sleep 1\n7\n+ for i in \'`seq 1 10`\'\n+ echo 7\n+ sleep 1\n8\n+ for i in \'`seq 1 10`\'\n+ echo 8\n+ sleep 1\n9\n+ for i in \'`seq 1 10`\'\n+ echo 9\n+ sleep 1\n10\n+ for i in \'`seq 1 10`\'\n+ echo 10\n+ sleep 1\n+ dddd\nbash: line 8: dddd: command not found\n结束在服务器[47.96.126.178@service-47.96.126.178]的发布操作\n结束时间:  2023-09-19 08:36:28Z\n','set -x \nhostname \nfor i in `seq 1 10`\ndo\n    echo $i\n    sleep 1\ndone\n\ndddd','2023-09-19 08:36:17.787487','2023-09-19 08:36:28.555388','FAIL','lixingxing',3),(73,'20230919091413','开始发布服务器[47.96.126.178@service-47.96.126.178]上的服务\nstart pub\n+ echo \'start pub\'\n+ sleep 10\npubing\n+ echo pubing\n+ sleep 12\npub finish\n+ echo \'pub finish\'\n结束在服务器[47.96.126.178@service-47.96.126.178]的发布操作\n结束时间:  2023-09-19 09:14:36Z\n','set -x\necho \"start pub\"\nsleep 10\necho \"pubing\"\nsleep 12\necho \"pub finish\"\n','2023-09-19 09:14:13.397138','2023-09-19 09:14:36.045201','SUCCESS','lixingxing',3);
/*!40000 ALTER TABLE `stree_pubhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_service`
--

DROP TABLE IF EXISTS `stree_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `tree_node_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tree_node_id` (`tree_node_id`),
  CONSTRAINT `stree_service_tree_node_id_99d359a9_fk_stree_treenode_id` FOREIGN KEY (`tree_node_id`) REFERENCES `stree_treenode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_service`
--

LOCK TABLES `stree_service` WRITE;
/*!40000 ALTER TABLE `stree_service` DISABLE KEYS */;
INSERT INTO `stree_service` VALUES (1,'service1',33),(2,'svc2',42);
/*!40000 ALTER TABLE `stree_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_serviceconf`
--

DROP TABLE IF EXISTS `stree_serviceconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_serviceconf` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `git` varchar(255) NOT NULL,
  `opadmin` varchar(255) NOT NULL,
  `rdadmin` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `service_id` bigint NOT NULL,
  `build_command` longtext,
  `start_command` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_id` (`service_id`),
  CONSTRAINT `stree_serviceconf_service_id_71e1f77d_fk_stree_service_id` FOREIGN KEY (`service_id`) REFERENCES `stree_service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_serviceconf`
--

LOCK TABLES `stree_serviceconf` WRITE;
/*!40000 ALTER TABLE `stree_serviceconf` DISABLE KEYS */;
INSERT INTO `stree_serviceconf` VALUES (1,'https://github.com/movekj/lw-svc1','李星星','李星星','www.test.com',1,'set -x\necho \"start build\"\nsleep 10\necho \"building\"\nsleep 12\necho \"build finish\"\n','set -x\necho \"start pub\"\nsleep 10\necho \"pubing\"\nsleep 12\necho \"pub finish\"\n');
/*!40000 ALTER TABLE `stree_serviceconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_serviceenv`
--

DROP TABLE IF EXISTS `stree_serviceenv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_serviceenv` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `tree_node_id` bigint NOT NULL,
  `service_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tree_node_id` (`tree_node_id`),
  KEY `stree_serviceenv_service_id_fb31c9f9` (`service_id`),
  CONSTRAINT `stree_serviceenv_service_id_fb31c9f9_fk_stree_service_id` FOREIGN KEY (`service_id`) REFERENCES `stree_service` (`id`),
  CONSTRAINT `stree_serviceenv_tree_node_id_c9868fd4_fk_stree_treenode_id` FOREIGN KEY (`tree_node_id`) REFERENCES `stree_treenode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_serviceenv`
--

LOCK TABLES `stree_serviceenv` WRITE;
/*!40000 ALTER TABLE `stree_serviceenv` DISABLE KEYS */;
INSERT INTO `stree_serviceenv` VALUES (3,'test',41,1),(4,'online',43,2),(8,'test',47,2),(10,'dev',49,2);
/*!40000 ALTER TABLE `stree_serviceenv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_serviceenvhost`
--

DROP TABLE IF EXISTS `stree_serviceenvhost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_serviceenvhost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host_id` bigint NOT NULL,
  `service_env_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stree_serviceenvhost_host_id_20a853dd_fk_hosts_host_id` (`host_id`),
  KEY `stree_serviceenvhost_service_env_id_e66eb6c0_fk_stree_ser` (`service_env_id`),
  CONSTRAINT `stree_serviceenvhost_host_id_20a853dd_fk_hosts_host_id` FOREIGN KEY (`host_id`) REFERENCES `hosts_host` (`id`),
  CONSTRAINT `stree_serviceenvhost_service_env_id_e66eb6c0_fk_stree_ser` FOREIGN KEY (`service_env_id`) REFERENCES `stree_serviceenv` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_serviceenvhost`
--

LOCK TABLES `stree_serviceenvhost` WRITE;
/*!40000 ALTER TABLE `stree_serviceenvhost` DISABLE KEYS */;
INSERT INTO `stree_serviceenvhost` VALUES (4,3,4),(5,3,3);
/*!40000 ALTER TABLE `stree_serviceenvhost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_treenode`
--

DROP TABLE IF EXISTS `stree_treenode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_treenode` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `path` varchar(1024) NOT NULL,
  `name` varchar(255) NOT NULL,
  `typ` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_treenode`
--

LOCK TABLES `stree_treenode` WRITE;
/*!40000 ALTER TABLE `stree_treenode` DISABLE KEYS */;
INSERT INTO `stree_treenode` VALUES (1,'group','group','group'),(2,'group.company','company','company'),(3,'group.company3','company3','company'),(4,'group.company.bu1','bu1','bu'),(5,'group.company.bu2','bu2','bu'),(6,'group.company.bu7','bu7','bu'),(7,'group.company.bu4','bu4','bu'),(8,'group.company.bu5','bu5','bu'),(9,'group.company.bu8','bu8','bu'),(16,'group.company.bu2.appgroup1','appgroup1','app_group'),(23,'group.company.bu2.appgroup1.dir1','dir1','dir'),(26,'group.company3.bu1','bu1','bu'),(27,'group.company3.bu1.ag','ag','app_group'),(28,'group.company3.bu1.ag.dir','dir','dir'),(33,'group.company.bu2.appgroup1.dir1.service1','service1','service'),(41,'group.company.bu2.appgroup1.dir1.service1.dev','dev','service_env'),(42,'group.company.bu2.appgroup1.dir1.service2','service2','service'),(43,'group.company.bu2.appgroup1.dir1.service2.online','online','service_env'),(47,'group.company.bu2.appgroup1.dir1.service2.de ','de ','service_env'),(49,'group.company.bu2.appgroup1.dir1.service2.dev','dev','service_env');
/*!40000 ALTER TABLE `stree_treenode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_treerole`
--

DROP TABLE IF EXISTS `stree_treerole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_treerole` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_treerole`
--

LOCK TABLES `stree_treerole` WRITE;
/*!40000 ALTER TABLE `stree_treerole` DISABLE KEYS */;
INSERT INTO `stree_treerole` VALUES (1,'rd','rd'),(2,'rd_admin','rd_admin'),(3,'op','op');
/*!40000 ALTER TABLE `stree_treerole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stree_treeuserrole`
--

DROP TABLE IF EXISTS `stree_treeuserrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stree_treeuserrole` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `tree_node_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stree_treeuserrole_role_id_0792b9fb_fk_stree_treerole_id` (`role_id`),
  KEY `stree_treeuserrole_tree_node_id_8c475346_fk_stree_treenode_id` (`tree_node_id`),
  KEY `stree_treeuserrole_user_id_1318fda5_fk_users_user_id` (`user_id`),
  CONSTRAINT `stree_treeuserrole_role_id_0792b9fb_fk_stree_treerole_id` FOREIGN KEY (`role_id`) REFERENCES `stree_treerole` (`id`),
  CONSTRAINT `stree_treeuserrole_tree_node_id_8c475346_fk_stree_treenode_id` FOREIGN KEY (`tree_node_id`) REFERENCES `stree_treenode` (`id`),
  CONSTRAINT `stree_treeuserrole_user_id_1318fda5_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stree_treeuserrole`
--

LOCK TABLES `stree_treeuserrole` WRITE;
/*!40000 ALTER TABLE `stree_treeuserrole` DISABLE KEYS */;
INSERT INTO `stree_treeuserrole` VALUES (4,1,16,2),(12,1,7,2),(15,1,2,2),(17,1,1,2),(18,1,1,6),(19,2,1,6);
/*!40000 ALTER TABLE `stree_treeuserrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(256) NOT NULL,
  `password` varchar(512) NOT NULL,
  `salt` varchar(128) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `cname` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES (2,'admin','a469e2e9596152dad6579a36d0e129dc83f9ffe9b47886bac40ac039','ipj3Q6J7ZC2BH8s5wq','16311433631','movekj@gmail.com','系统管理'),(6,'test','306a6e199366d1050b6e701a3f5a9f1fb27df7305e969ecb7163d515','n7aO9tcw7O4vjED4Ta','1111111111','movekj@gmail.com','test');
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-21 22:28:35
