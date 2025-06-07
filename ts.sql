use ts;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
drop table if exists `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
   `id` int NOT NULL AUTO_INCREMENT,
   `group_id` int NOT NULL,
   `permission_id` int NOT NULL,  -- Change this to BIGINT
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE INDEX `auth_group_permissions_group_id_permission_id_uniq`(`group_id`, `permission_id`) USING BTREE,
   INDEX `auth_group_permissions_permission_id_fk`(`permission_id`) USING BTREE,
   CONSTRAINT `auth_group_permissions_permission_id_fk` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
   CONSTRAINT `auth_group_permissions_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1
CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;




-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
drop table if exists auth_permission;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_codename_content_type_id_uniq` (`codename`, `content_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 
  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;





USE ts;




-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add chushou', 7, 'add_chushou'),
(26, 'Can change chushou', 7, 'change_chushou'),
(27, 'Can delete chushou', 7, 'delete_chushou'),
(28, 'Can view chushou', 7, 'view_chushou'),
(29, 'Can add goumai', 8, 'add_goumai'),
(30, 'Can change goumai', 8, 'change_goumai'),
(31, 'Can delete goumai', 8, 'delete_goumai'),
(32, 'Can view goumai', 8, 'view_goumai'),
(33, 'Can add guanli', 9, 'add_guanli'),
(34, 'Can change guanli', 9, 'change_guanli'),
(35, 'Can delete guanli', 9, 'delete_guanli'),
(36, 'Can view guanli', 9, 'view_guanli'),
(37, 'Can add fenlei', 10, 'add_fenlei'),
(38, 'Can change fenlei', 10, 'change_fenlei'),
(39, 'Can delete fenlei', 10, 'delete_fenlei'),
(40, 'Can view fenlei', 10, 'view_fenlei'),
(41, 'Can add diqu', 11, 'add_diqu'),
(42, 'Can change diqu', 11, 'change_diqu'),
(43, 'Can delete diqu', 11, 'delete_diqu'),
(44, 'Can view diqu', 11, 'view_diqu'),
(45, 'Can add jingqu', 12, 'add_jingqu'),
(46, 'Can change jingqu', 12, 'change_jingqu'),
(47, 'Can delete jingqu', 12, 'delete_jingqu'),
(48, 'Can view jingqu', 12, 'view_jingqu'),
(49, 'Can add ershouaddr', 13, 'add_ershouaddr'),
(50, 'Can change ershouaddr', 13, 'change_ershouaddr'),
(51, 'Can delete ershouaddr', 13, 'delete_ershouaddr'),
(52, 'Can view ershouaddr', 13, 'view_ershouaddr'),
(53, 'Can add addr', 13, 'add_addr'),
(54, 'Can change addr', 13, 'change_addr'),
(55, 'Can delete addr', 13, 'delete_addr'),
(56, 'Can view addr', 13, 'view_addr'),
(57, 'Can add shousc', 14, 'add_shousc'),
(58, 'Can change shousc', 14, 'change_shousc'),
(59, 'Can delete shousc', 14, 'delete_shousc'),
(60, 'Can view shousc', 14, 'view_shousc'),
(61, 'Can add shoupl', 15, 'add_shoupl'),
(62, 'Can change shoupl', 15, 'change_shoupl'),
(63, 'Can delete shoupl', 15, 'delete_shoupl'),
(64, 'Can view shoupl', 15, 'view_shoupl'),
(65, 'Can add sc', 14, 'add_sc'),
(66, 'Can change sc', 14, 'change_sc'),
(67, 'Can delete sc', 14, 'delete_sc'),
(68, 'Can view sc', 14, 'view_sc'),
(69, 'Can add pl', 15, 'add_pl'),
(70, 'Can change pl', 15, 'change_pl'),
(71, 'Can delete pl', 15, 'delete_pl'),
(72, 'Can view pl', 15, 'view_pl'),
(73, 'Can add dingdan', 16, 'add_dingdan'),
(74, 'Can change dingdan', 16, 'change_dingdan'),
(75, 'Can delete dingdan', 16, 'delete_dingdan'),
(76, 'Can view dingdan', 16, 'view_dingdan'),
(77, 'Can add lb', 17, 'add_lb'),
(78, 'Can change lb', 17, 'change_lb'),
(79, 'Can delete lb', 17, 'delete_lb'),
(80, 'Can view lb', 17, 'view_lb');

SHOW CREATE TABLE `auth_permission`;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` INT NOT NULL AUTO_INCREMENT,  -- ✅ 这里去掉 (11)
  `password` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` DATETIME(6) NULL DEFAULT NULL,
  `is_superuser` TINYINT NOT NULL,  -- ✅ 这里去掉 (1)
  `username` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` VARCHAR(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` TINYINT NOT NULL,  -- ✅ 这里去掉 (1)
  `is_active` TINYINT NOT NULL,  -- ✅ 这里去掉 (1)
  `date_joined` DATETIME(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username` (`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;



-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

SHOW CREATE TABLE auth_permission;


-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
   `id` INT NOT NULL AUTO_INCREMENT,  -- ✅ 去掉 (11)
   `action_time` DATETIME(6) NOT NULL,
   `object_id` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,  
   `object_repr` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,  
   `action_flag` SMALLINT UNSIGNED NOT NULL,
   `change_message` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,  
   `content_type_id` INT NULL DEFAULT NULL,
   `user_id` INT NOT NULL,
   PRIMARY KEY (`id`) USING BTREE,
   INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
   INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
   CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co`
       FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
   CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id`
       FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET  utf8mb4 COLLATE  utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(13, 'ts', 'addr'),
(7, 'ts', 'chushou'),
(16, 'ts', 'dingdan'),
(11, 'ts', 'diqu'),
(10, 'ts', 'fenlei'),
(8, 'ts', 'goumai'),
(9, 'ts', 'guanli'),
(12, 'ts', 'jingqu'),
(17, 'ts', 'lb'),
(15, 'ts', 'pl'),
(14, 'ts', 'sc'),
(6, 'ts', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-03-19 03:03:24.126803'),
(2, 'auth', '0001_initial', '2025-03-19 03:03:24.790044'),
(3, 'admin', '0001_initial', '2025-03-19 03:03:25.023968'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-03-19 03:03:25.036965'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-19 03:03:25.045962'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-03-19 03:03:25.183917'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-03-19 03:03:25.291893'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-03-19 03:03:25.365870'),
(9, 'auth', '0004_alter_user_username_opts', '2025-03-19 03:03:25.373881'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-03-19 03:03:25.444866'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-03-19 03:03:25.447866'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-03-19 03:03:25.455862'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-03-19 03:03:25.584930'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-03-19 03:03:25.651897'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-03-19 03:03:25.729889'),
(16, 'auth', '0011_update_proxy_permissions', '2025-03-19 03:03:25.737868'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-03-19 03:03:25.803854'),
(18, 'ts', '0001_initial', '2025-03-19 03:03:25.912097'),
(19, 'sessions', '0001_initial', '2025-03-19 03:03:25.986127'),
(20, 'ts', '0002_fenlei', '2025-03-19 04:03:11.407838'),
(21, 'ts', '0003_diqu', '2025-03-19 04:13:40.567450'),
(22, 'ts', '0004_jingqu', '2025-03-19 05:55:51.978158'),
(23, 'ts', '0005_alter_jingqu_dengji', '2025-03-19 06:13:49.357552'),
(24, 'ts', '0006_alter_jingqu_jianjie', '2025-03-19 06:14:31.507707'),
(25, 'ts', '0007_auto_20240319_1457', '2025-03-19 06:57:39.740015'),
(26, 'ts', '0008_ershouaddr', '2025-03-19 07:01:34.978254'),
(27, 'ts', '0009_auto_20240319_1518', '2025-03-19 07:18:29.224254'),
(28, 'ts', '0010_auto_20240319_1528', '2025-03-19 07:28:17.956031'),
(29, 'ts', '0011_rename_shousc_sc', '2025-03-19 07:37:38.735875'),
(30, 'ts', '0012_rename_shoupl_pl', '2025-03-19 07:41:35.562070'),
(31, 'ts', '0013_dingdan', '2025-03-19 08:04:55.361407'),
(32, 'ts', '0014_jingqu_collect_num', '2025-03-28 03:50:15.608274'),
(34, 'ts', '0015_lb', '2025-03-29 02:17:50.028289');
-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for ts_addr
-- ----------------------------
DROP TABLE IF EXISTS `ts_addr`;
CREATE TABLE `ts_addr`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shouji` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `addr` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shui_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ts_ershouaddr_shui_id_6b375960_fk_ts_goumai_id`(`shui_id`) USING BTREE,
  CONSTRAINT `ts_ershouaddr_shui_id_6b375960_fk_ts_goumai_id` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_addr
-- ----------------------------
INSERT INTO `ts_addr` (`id`, `username`, `shouji`, `addr`, `shui_id`) VALUES
(2, 'ts1', '0210583685', '21 Queen St, Auckland', 1),
(3, 'ts2', '02105836234', '213 Queen St, Auckland', 2),
(4, 'ts3', '02105829358', '221 Queen St, Auckland', 2),
(5, 'ts4', '02105836853', '201 Queen St, Auckland', 1);



-- ----------------------------
-- Table structure for ts_chushou
-- ----------------------------
DROP TABLE IF EXISTS `ts_chushou`;
CREATE TABLE `ts_chushou`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `jianjie` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_chushou
-- ----------------------------
INSERT INTO `ts_chushou` VALUES (1, 'lb1', 'lb1', '1.jpg', 'I am Admin1');
INSERT INTO `ts_chushou` VALUES (2, 'lb2', 'lb2', '2.jpg', 'I am Admin2');
INSERT INTO `ts_chushou` VALUES (3, 'lb3', 'lb3', '3.jpg', 'I am Admin3');
INSERT INTO `ts_chushou` VALUES (4, 'lb4', 'lb4', '4.jpg', 'I am Admin4');
INSERT INTO `ts_chushou` VALUES (6, 'lblb', 'lblb', 'denglu.png', 'lblb');

-- ----------------------------
-- Table structure for dts_dingdan
-- ----------------------------
DROP TABLE IF EXISTS `ts_dingdan`;
CREATE TABLE `ts_dingdan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `gmsj` date NULL DEFAULT NULL,
  `maijia` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` double NOT NULL,
  `zfzt` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `addr` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shui_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ts_dingdan_shui_id_d6904bc8_fk_ts_goumai_id`(`shui_id`) USING BTREE,
  CONSTRAINT `ts_dingdan_shui_id_d6904bc8_fk_ts_goumai_id` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_dingdan
-- ----------------------------
INSERT INTO `ts_dingdan` VALUES (8, '2024-03-27', 'James Smith', 'Milford Sound', 'milford_sound.jpg', 250, 'Pending Payment', '0211234567', 'Fiordland National Park, South Island, New Zealand', 2);
INSERT INTO `ts_dingdan` VALUES (9, '2024-03-27', 'Maria Garcia', 'Waitomo Glowworm Caves', 'waitomo_caves.jpg', 100, 'Pending Payment', '0219876543', 'Waikato, North Island, New Zealand', 2);
INSERT INTO `ts_dingdan` VALUES (10, '2024-03-27', 'David Smith', 'Hobbiton Movie Set', 'hobbiton.jpg', 150, 'Pending Payment', '0214567890', 'Matamata, North Island, New Zealand', 2);
INSERT INTO `ts_dingdan` VALUES (11, '2024-03-27', 'Michael Smith', 'Rotorua Geothermal Park', 'rotorua_geothermal.jpg', 80, 'Pending Payment', '0215678901', 'Rotorua, North Island, New Zealand', 2);
INSERT INTO `ts_dingdan` VALUES (12, '2024-03-28', 'Mary Smith', 'Queenstown Skyline Gondola', 'queenstown_gondola.jpg', 90, 'Pending Payment', '0216789012', 'Queenstown, South Island, New Zealand', 1);
INSERT INTO `ts_dingdan` VALUES (13, '2024-03-28', 'Maria Hernandez', 'Mount Cook National Park', 'mt_cook.jpg', 200, 'Pending Payment', '0217890123', 'Aoraki/Mount Cook National Park, South Island, New Zealand', 2);
INSERT INTO `ts_dingdan` VALUES (14, '2024-03-28', 'Maria Martinez', 'Tasman Glacier Boat Tour', 'tasman_glacier.jpg', 180, 'Pending Payment', '0218901234', 'Mount Cook, South Island, New Zealand', 2);
INSERT INTO `ts_dingdan` VALUES (15, '2024-03-28', 'James Johnson', 'Kaikoura Whale Watching', 'kaikoura_whale.jpg', 250, 'Pending Payment', '0219012345', 'Kaikoura, South Island, New Zealand', 1);
INSERT INTO `ts_dingdan` VALUES (16, '2024-03-28', 'Maria Rodriguez', 'Piha Beach Black Sand', 'piha_beach.jpg', 50, 'Pending Payment', '0210123456', 'West Auckland, North Island, New Zealand', 1);
INSERT INTO `ts_dingdan` VALUES (17, '2024-03-28', 'Robert Smith', 'Tongariro Alpine Crossing', 'tongariro_alpine.jpg', 120, 'Pending Payment', '0211122334', 'Tongariro National Park, North Island, New Zealand', 1);
INSERT INTO `ts_dingdan` VALUES (18, '2024-03-28', 'James Smith', 'Fiordland National Park Tour', 'fiordland.jpg', 300, 'Pending Payment', '0212233445', 'Fiordland National Park, South Island, New Zealand', 1);
INSERT INTO `ts_dingdan` VALUES (19, '2024-03-29', 'Michael Smith', 'Waipapa Bay Penguin Watching', 'waipapa_penguins.jpg', 70, 'Pending Payment', '0213344556', 'Otago, South Island, New Zealand', 1);
-- ----------------------------
-- Table structure for ts_diqu
-- ----------------------------
DROP TABLE IF EXISTS `ts_diqu`;
CREATE TABLE `ts_diqu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `mingcheng` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_diqu
-- ----------------------------
INSERT INTO `ts_diqu` (`id`, `mingcheng`) VALUES
(1, 'Auckland'),
(2, 'Wellington'),
(3, 'Christchurch'),
(4, 'Queenstown'),
(5, 'Rotorua'),
(6, 'Dunedin'),
(7, 'Nelson'),
(8, 'Hamilton'),
(9, 'Tauranga'),
(10, 'Napier'),
(11, 'New Plymouth'),
(12, 'Invercargill');

-- ----------------------------
-- Table structure for ts_fenlei
-- ----------------------------
DROP TABLE IF EXISTS `ts_fenlei`;
CREATE TABLE `ts_fenlei`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `mingcheng` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;
INSERT INTO `ts_fenlei` (`id`, `mingcheng`) VALUES
(1, 'Sightseeing'),
(2, 'Historical Sites'),
(3, 'Local Culture'),
(4, 'Literature & Art'),
(5, 'Scientific Exploration');

-- ----------------------------
-- Table structure for dvlvyou_goumai
-- ----------------------------
DROP TABLE IF EXISTS `ts_goumai`;
CREATE TABLE `ts_goumai`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `jianjie` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;
-- ----------------------------
-- Records of ts_fenlei
INSERT INTO `ts_goumai` VALUES (1, 'yk1', 'yk1', '1.jpg', 'Exploring New Zealand');
INSERT INTO `ts_goumai` VALUES (2, 'yk2', 'yk2', '2.jpg', 'Lover of NZ landscapes');
INSERT INTO `ts_goumai` VALUES (3, 'yk3', 'yk3', '3.jpg', 'Adventure seeker in NZ');
INSERT INTO `ts_goumai` VALUES (4, 'yk4', 'yk4', '4.jpg', 'NZ hiking enthusiast');
INSERT INTO `ts_goumai` VALUES (5, 'yk5', 'yk5', NULL, 'Enjoys Māori culture and history');
INSERT INTO `ts_goumai` VALUES (6, 'traveler6', 'traveler6', NULL, 'Passionate about NZ wildlife');
INSERT INTO `ts_goumai` VALUES (7, 'traveler7', 'traveler7', NULL, 'Food and wine lover in NZ');

-- ----------------------------
-- Table structure for ts_guanli
-- ----------------------------
DROP TABLE IF EXISTS `ts_guanli`;
CREATE TABLE `ts_guanli`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` longtext CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_guanli
-- ----------------------------
INSERT INTO `ts_guanli` VALUES (1, 'admin', 'admin');

-- ----------------------------
-- Table structure for ts_jingqu
-- ----------------------------
DROP TABLE IF EXISTS `ts_jingqu`;
CREATE TABLE `ts_jingqu`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `dizhi` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `dengji` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `jianjie` longtext CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zhuangtai` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_kaifang` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_shenhe` varchar(255) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `diqu_id` int NOT NULL,
  `fenlei_id` int NOT NULL,
  `maijia_id` int NOT NULL,
  `collect_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ts_jingqu_diqu_id_12ef2b96_fk_ts_diqu_id`(`diqu_id`) USING BTREE,
  INDEX `ts_jingqu_fenlei_id_e403b0fd_fk_ts_fenlei_id`(`fenlei_id`) USING BTREE,
  INDEX `ts_jingqu_maijia_id_d5ae039e_fk_ts_chushou_id`(`maijia_id`) USING BTREE,
  CONSTRAINT `ts_jingqu_diqu_id_12ef2b96_fk_ts_diqu_id` FOREIGN KEY (`diqu_id`) REFERENCES `ts_diqu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ts_jingqu_fenlei_id_e403b0fd_fk_ts_fenlei_id` FOREIGN KEY (`fenlei_id`) REFERENCES `ts_fenlei` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ts_jingqu_maijia_id_d5ae039e_fk_ts_chushou_id` FOREIGN KEY (`maijia_id`) REFERENCES `ts_chushou` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_jingqu
-- ----------------------------
INSERT INTO `ts_jingqu` VALUES 
(1, 'Milford Sound', 150, 'Fiordland National Park', '5A', 'milford_sound.jpg', 
 'A breathtaking fjord known for towering cliffs, cascading waterfalls, and diverse wildlife including dolphins and penguins.', 
 'Available', 'Open', 'Approved', 1, 1, 1, '50'),

(2, 'Hobbiton Movie Set', 120, 'Matamata, Waikato', '5A', 'hobbiton.jpg', 
 'The famous movie set from The Lord of the Rings and The Hobbit films, offering guided tours through picturesque hobbit holes.', 
 'Available', 'Open', 'Approved', 2, 2, 2, '80'),

(3, 'Tongariro Alpine Crossing', 50, 'Tongariro National Park', '5A', 'tongariro.jpg', 
 'One of the world’s best day hikes, featuring volcanic landscapes, emerald lakes, and breathtaking alpine scenery.', 
 'Available', 'Open', 'Approved', 3, 3, 3, '60'),

(4, 'Rotorua Geothermal Parks', 100, 'Rotorua', '4A', 'rotorua.jpg', 
 'Experience geysers, hot springs, and bubbling mud pools while learning about Māori culture and traditions.', 
 'Available', 'Open', 'Approved', 4, 1, 4, '45'),

(5, 'Mount Cook National Park', 80, 'South Island', '5A', 'mount_cook.jpg', 
 'Home to New Zealand’s highest mountain, offering scenic hikes, glacier views, and stargazing in a Dark Sky Reserve.', 
 'Available', 'Open', 'Approved', 5, 2, 5, '70'),

(6, 'Franz Josef Glacier', 90, 'West Coast, South Island', '5A', 'franz_josef.jpg', 
 'A stunning glacier that descends into a lush rainforest, with options for guided ice walks and helicopter tours.', 
 'Available', 'Open', 'Approved', 6, 3, 6, '55'),

(7, 'Waitomo Glowworm Caves', 75, 'Waitomo, North Island', '5A', 'waitomo.jpg', 
 'A magical underground cave system illuminated by thousands of bioluminescent glowworms, best explored by boat.', 
 'Available', 'Open', 'Approved', 7, 1, 7, '90'),

(8, 'Queenstown Adventure Hub', 200, 'Queenstown', '5A', 'queenstown.jpg', 
 'The adventure capital of New Zealand, offering bungee jumping, skydiving, jet boating, and stunning lake views.', 
 'Available', 'Open', 'Approved', 8, 1, 8, '100');
-- ----------------------------
-- Table structure for ts_lb
-- ----------------------------
DROP TABLE IF EXISTS `ts_lb`;
CREATE TABLE `ts_lb`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_lb
-- ----------------------------
INSERT INTO `ts_lb` VALUES (2, '66.jpg');
INSERT INTO `ts_lb` VALUES (3, '67.jpg');
INSERT INTO `ts_lb` VALUES (4, '68.jpg');
INSERT INTO `ts_lb` VALUES (5, '65.jpg');

-- ----------------------------
INSERT INTO `ts_pl` VALUES 
(1, '2024-03-19', 'Absolutely stunning! The boat cruise through Milford Sound was magical.', 'Approved', 1, 1),
(2, '2024-03-20', 'Loved the Hobbiton tour! It felt like stepping into the movies.', 'Approved', 2, 2),
(3, '2024-03-21', 'A challenging but rewarding hike! The views from Tongariro were breathtaking.', 'Approved', 3, 3),
(4, '2024-03-22', 'Rotorua’s geothermal parks were fascinating. The Māori cultural performances were a highlight.', 'Approved', 4, 4),
(5, '2024-03-23', 'Mount Cook’s landscapes were surreal. Great spot for hiking and stargazing.', 'Approved', 5, 5),
(6, '2024-03-24', 'The Franz Josef Glacier helicopter tour was worth every dollar!', 'Approved', 6, 6),
(7, '2024-03-25', 'Waitomo Caves were like a fairy tale. The glowworms were mesmerizing.', 'Approved', 7, 7),
(8, '2024-03-26', 'If you love adventure, Queenstown is the place to be! So many activities.', 'Approved', 8, 8),
(9, '2024-03-27', 'Couldn’t get enough of Milford Sound’s waterfalls. Must-visit!', 'Approved', 1, 3),
(10, '2024-03-28', 'Would visit Hobbiton again! Perfect for LOTR fans.', 'Approved', 2, 1),
(11, '2024-03-29', 'The trek at Tongariro was long but the emerald lakes made it worthwhile.', 'Approved', 3, 4),
(12, '2024-03-30', 'Rotorua’s hot springs were so relaxing! Highly recommend.', 'Approved', 4, 5),
(13, '2024-03-31', 'Aoraki/Mount Cook was beautiful, especially at sunrise.', 'Pending Review', 5, 2),
(14, '2024-04-01', 'Walking on the Franz Josef Glacier was a once-in-a-lifetime experience.', 'Pending Review', 6, 3),
(15, '2024-04-02', 'Waitomo’s glowworms were magical, but the boat ride was too short.', 'Pending Review', 7, 6),
(16, '2024-04-03', 'Queenstown exceeded expectations! Bungee jumping was incredible.', 'Pending Review', 8, 7);
-- ----------------------------
-- Table structure for ts_sc
-- ----------------------------
DROP TABLE IF EXISTS `ts_sc`;
CREATE TABLE `ts_sc`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sc_date` date NULL DEFAULT NULL,
  `jingqu_id` bigint NOT NULL,
  `shui_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ts_shousc_shui_id_fc4d29ea_fk_ts_goumai_id`(`shui_id`) USING BTREE,
  INDEX `ts_shousc_jingqu_id_4451932c_fk_ts_jingqu_id`(`jingqu_id`) USING BTREE,
  CONSTRAINT `ts_shousc_jingqu_id_4451932c_fk_ts_jingqu_id` FOREIGN KEY (`jingqu_id`) REFERENCES `ts_jingqu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ts_shousc_shui_id_fc4d29ea_fk_ts_goumai_id` FOREIGN KEY (`shui_id`) REFERENCES `ts_goumai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ts_sc
-- ----------------------------
INSERT INTO `ts_sc` (`id`, `sc_date`, `jingqu_id`, `shui_id`) VALUES
(8, '2024-03-26', 3, 1),
(58, '2024-03-28', 1, 3),
(59, '2024-03-28', 2, 3),
(60, '2024-03-28', 5, 1),
(61, '2024-03-28', 1, 2),
(62, '2024-03-28', 2, 2),
(63, '2024-03-28', 3, 2),
(64, '2024-03-28', 4, 2),
(65, '2024-03-28', 5, 2),
(66, '2024-03-28', 6, 2),
(67, '2024-03-28', 1, 4),
(68, '2024-03-28', 2, 4),
(69, '2024-03-28', 3, 4),
(70, '2024-03-28', 8, 4),
(71, '2024-03-28', 9, 4),
(72, '2024-03-28', 3, 3),
(73, '2024-03-30', 2, 1),
(75, '2024-03-30', 4, 1),
(77, '2024-03-31', 1, 1);
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE hello_pl (
    id INT AUTO_INCREMENT PRIMARY KEY
);
