/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : icloud_spp

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-10-21 08:56:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for erp_account_settings
-- ----------------------------
DROP TABLE IF EXISTS `erp_account_settings`;
CREATE TABLE `erp_account_settings` (
  `id` int(1) NOT NULL,
  `biller_id` int(11) NOT NULL DEFAULT '0',
  `default_open_balance` varchar(20) DEFAULT NULL,
  `default_sale` varchar(20) DEFAULT 'yes',
  `default_sale_discount` varchar(20) DEFAULT NULL,
  `default_sale_tax` varchar(20) DEFAULT NULL,
  `default_sale_freight` varchar(20) DEFAULT NULL,
  `default_sale_deposit` varchar(20) DEFAULT NULL,
  `default_receivable` varchar(20) DEFAULT NULL,
  `default_purchase` varchar(20) DEFAULT NULL,
  `default_purchase_discount` varchar(20) DEFAULT NULL,
  `default_purchase_tax` varchar(20) DEFAULT NULL,
  `default_purchase_freight` varchar(20) DEFAULT NULL,
  `default_purchase_deposit` varchar(20) DEFAULT NULL,
  `default_payable` varchar(20) DEFAULT NULL,
  `default_stock` varchar(20) DEFAULT NULL,
  `default_stock_adjust` varchar(20) DEFAULT NULL,
  `default_cost` varchar(20) DEFAULT NULL,
  `default_payroll` varchar(20) DEFAULT NULL,
  `default_cash` varchar(20) DEFAULT NULL,
  `default_credit_card` varchar(20) DEFAULT NULL,
  `default_gift_card` varchar(20) DEFAULT NULL,
  `default_cheque` varchar(20) DEFAULT NULL,
  `default_loan` varchar(20) DEFAULT NULL,
  `default_retained_earnings` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`biller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_account_settings
-- ----------------------------
INSERT INTO `erp_account_settings` VALUES ('1', '3', '300300', '410101', '410102', '201407', '410107', '201208', '100200', '100430', '500106', '100441', '100430', '100420', '201100', '100430', '500107', '500101', '201201', '100102', '100105', '201208', '100104', '100501', '300200');

-- ----------------------------
-- Table structure for erp_adjustments
-- ----------------------------
DROP TABLE IF EXISTS `erp_adjustments`;
CREATE TABLE `erp_adjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(55) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `cost` decimal(19,4) DEFAULT '0.0000',
  `total_cost` decimal(19,4) DEFAULT '0.0000',
  `biller_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_adjustments
-- ----------------------------
INSERT INTO `erp_adjustments` VALUES ('1', null, '2016-07-09 11:21:00', '147', null, '3.0000', '1', '&lt;p&gt;ខ្វះស្តុក&lt;&sol;p&gt;', '1', null, 'addition', '0.0000', '0.0000', '3');

-- ----------------------------
-- Table structure for erp_bom
-- ----------------------------
DROP TABLE IF EXISTS `erp_bom`;
CREATE TABLE `erp_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `noted` varchar(200) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_bom
-- ----------------------------

-- ----------------------------
-- Table structure for erp_bom_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_bom_items`;
CREATE TABLE `erp_bom_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bom_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` decimal(25,4) NOT NULL,
  `cost` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transfer_id` (`bom_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_bom_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_brands
-- ----------------------------
DROP TABLE IF EXISTS `erp_brands`;
CREATE TABLE `erp_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_brands
-- ----------------------------

-- ----------------------------
-- Table structure for erp_calendar
-- ----------------------------
DROP TABLE IF EXISTS `erp_calendar`;
CREATE TABLE `erp_calendar` (
  `start` datetime NOT NULL,
  `title` varchar(55) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `end` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_calendar
-- ----------------------------

-- ----------------------------
-- Table structure for erp_captcha
-- ----------------------------
DROP TABLE IF EXISTS `erp_captcha`;
CREATE TABLE `erp_captcha` (
  `captcha_id` bigint(13) unsigned NOT NULL AUTO_INCREMENT,
  `captcha_time` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `word` varchar(20) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`captcha_id`),
  KEY `word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_captcha
-- ----------------------------
INSERT INTO `erp_captcha` VALUES ('1', '1451963466', '192.168.1.122', 'N9ocX');

-- ----------------------------
-- Table structure for erp_categories
-- ----------------------------
DROP TABLE IF EXISTS `erp_categories`;
CREATE TABLE `erp_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) DEFAULT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL,
  `jobs` tinyint(1) unsigned DEFAULT '1',
  `auto_delivery` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_categories
-- ----------------------------
INSERT INTO `erp_categories` VALUES ('1', null, 'preform001', 'ប្រភេទឡត(Preform)', '', '1', null);
INSERT INTO `erp_categories` VALUES ('2', null, 'bottle001', 'ប្រភេទដប(Bottles)', '', '1', null);
INSERT INTO `erp_categories` VALUES ('3', null, 'cap001', 'ប្រភេទគំរប(Caps)', '', '1', null);
INSERT INTO `erp_categories` VALUES ('4', null, 'bottle002', 'ប្រភេទទឹកស៊ីអ៊ីវ នឹង ទឹកត្រី', '', '1', null);
INSERT INTO `erp_categories` VALUES ('5', null, 'lo001', 'ថង់អ៊ុតឡូ', '', '1', null);
INSERT INTO `erp_categories` VALUES ('6', null, 'stamp001', 'តែម', '', '1', null);
INSERT INTO `erp_categories` VALUES ('7', null, 'bag001', 'កាដុង', '', '1', null);
INSERT INTO `erp_categories` VALUES ('8', null, 'av001', 'អាវ', '', '1', null);
INSERT INTO `erp_categories` VALUES ('9', null, 'user_stock001', 'Use stock', '', '1', null);

-- ----------------------------
-- Table structure for erp_combine_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_combine_items`;
CREATE TABLE `erp_combine_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sale_deliveries_id` bigint(20) NOT NULL,
  `sale_deliveries_id_combine` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_combine_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_combo_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_combo_items`;
CREATE TABLE `erp_combo_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_combo_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_companies
-- ----------------------------
DROP TABLE IF EXISTS `erp_companies`;
CREATE TABLE `erp_companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned DEFAULT NULL,
  `group_name` varchar(20) NOT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `customer_group_name` varchar(100) DEFAULT NULL,
  `name` varchar(55) NOT NULL,
  `company` varchar(255) NOT NULL,
  `vat_no` varchar(100) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(55) NOT NULL,
  `state` varchar(55) DEFAULT NULL,
  `postal_code` varchar(8) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `cf1` varchar(100) DEFAULT NULL,
  `cf2` varchar(100) DEFAULT NULL,
  `cf3` varchar(100) DEFAULT NULL,
  `cf4` varchar(100) DEFAULT NULL,
  `cf5` varchar(100) DEFAULT NULL,
  `cf6` varchar(100) DEFAULT NULL,
  `invoice_footer` text,
  `payment_term` int(11) DEFAULT '0',
  `logo` varchar(255) DEFAULT 'logo.png',
  `award_points` int(11) DEFAULT '0',
  `deposit_amount` decimal(25,4) DEFAULT NULL,
  `status` char(20) DEFAULT NULL,
  `posta_card` char(50) DEFAULT NULL,
  `gender` char(10) DEFAULT NULL,
  `attachment` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `credit_limited` decimal(25,4) DEFAULT NULL,
  `business_activity` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT NULL,
  `village` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `sangkat` varchar(255) DEFAULT NULL,
  `district` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `price_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `group_id_2` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_companies
-- ----------------------------
INSERT INTO `erp_companies` VALUES ('1', '3', 'customer', '4', 'New Customer (+10)', 'Walk-in Customer', 'Walk-in Customer', '', 'Customer Address', 'Phnom Penh', 'Kondal', '12345', 'Cambodia', '012345678', 'demo@cloudnet.com.kh', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '2016-04-27', '0000-00-00', '2016-05-10', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('2', '4', 'supplier', null, '', 'General Supplier', 'Supplier Company Name', '', 'Supplier Address', 'Phnom Penh', 'Kondal', '12345', 'Cambodia', '016282825', 'laykiry@yahoo.com', '-', '-', '-', '-', '-', '-', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '1990-06-14', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('3', null, 'biller', null, '', 'SPP សែនសុខ', 'SPP សែនសុខ', '5555', '273st1011 ', 'Phnom Penh', '', '', '', '077727228/016978886/', 'spp.chhang@gmail.com', '', '', '', '', '1,2', '20%', ' Thank you for shopping with us. Please come again', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('4', '3', 'customer', '1', 'General', 'General', 'General', '20001001', '#23C st.17 kan.Toulkork', 'Phnom Penh', 'Kondal', '', 'Cambodia', '023 634 6666', 'demo@cloudnet.com.kh', '', '', '', '', '', '', '', '0', 'logo.png', '134', '0.0000', '', '', '', 'c3bf934c459c5550a90d76f8d4fbcd65.xlsx', '1970-01-01', '2016-05-01', '2016-06-04', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('5', '3', 'customer', '1', 'General', 'ចឹកកី', 'ចឹកកី', '', 'ភ្នំពេញ', '', '', '', '', '098667967', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('6', '3', 'customer', '1', 'General', 'ថ្នល់កែងកំពង់ចាម', 'ថ្នល់កែងកំពង់ចាម', '', 'កំពង់ចាម', '', '', '', '', '017724050', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('7', '3', 'customer', '1', 'General', 'ហ៊ាផាក្បាលថ្នល់', 'ហ៊ាផាក្បាលថ្នល់', '', 'ភ្នំពេញ', '', '', '', '', '077668440', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('8', '3', 'customer', '1', 'General', 'ពារាំង', 'ពារាំង', '', 'ព្រៃវែង', '', '', '', '', '070345399/016664404', '', '', '', '', '', '', '', '', '0', 'logo.png', '150', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('9', '3', 'customer', '1', 'General', 'ម្លប់ស្វាយធំ', 'ម្លប់ស្វាយធំ', '', 'ភ្នំពេញ', '', '', '', '', '0888215188', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('10', '3', 'customer', '1', 'General', 'ផ្សារទឹកថ្លា', 'ផ្សារទឹកថ្លា', '', 'ភ្នំពេញ', '', '', '', '', '092904122', '', '', '', '', '', '', '', '', '0', 'logo.png', '32', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('11', '3', 'customer', '1', 'General', 'កំពង់ស្ពឺ', 'កំពង់ស្ពឺ', '', 'កំពង់ស្ពឺ', '', '', '', '', '017239800/016949730', '', '', '', '', '', '', '', '', '0', 'logo.png', '363', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('12', '3', 'customer', '1', 'General', 'បងណាវី(អ្នកគ្រូ)', 'បងណាវី(អ្នកគ្រូ)', '', 'ភ្នំពេញ', '', '', '', '', '012784919', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('13', '3', 'customer', '1', 'General', 'ចែ ជិនជូវី', 'ចែ ជិនជួវី', '', 'ភ្នំពេញ', '', '', '', '', '010908887/092677268', '', '', '', '', '', '', '', '', '0', 'logo.png', '30', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('14', '3', 'customer', '1', 'General', 'ព្រែកតាម៉ាក់', 'ព្រែកតាម៉ាក់', '', 'ភ្នំពេញ', '', '', '', '', '011370137/016994993', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('15', '3', 'customer', '1', 'General', 'ប្អូនចែ 77(បឹងសាឡាង)', 'ប្អូនចែ 77(បឹងសាឡាង)', '', 'ភ្នំពេញ', '', '', '', '', '089763008', '', '', '', '', '', '', '', '', '0', 'logo.png', '58', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('16', '3', 'customer', '1', 'General', 'សំណាងអូឡាំពិក', 'សំណាងអូឡាំពិក', '', 'ភ្នំពេញ', '', '', '', '', '099820333/015225333', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('17', '3', 'customer', '1', 'General', 'ទឹកសុទ្ធដាណាធិច', 'ទឹកសុទ្ធដាណាធិច', '', 'ភ្នំពេញ', '', '', '', '', '012697919/016327776', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('18', '3', 'customer', '1', 'General', 'ចែហេងឈូកមាស', 'ចែហេងឈូកមាស', '', 'ភ្នំពេញ', '', '', '', '', '012331703', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('19', '3', 'customer', '1', 'General', 'កោះកុង', 'កោះកុង', '', 'កោះកុង', '', '', '', '', '0889619629', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('20', '3', 'customer', '1', 'General', 'លោកគ្រូហេង', 'លោកគ្រូហេង', '', 'ជម្ពូវ័ន', 'ភ្នំពេញ', '', '', '', '077412576', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('21', '3', 'customer', '1', 'General', 'ទឹកសណ្តែកអូឌឹម', 'ទឹកសណ្តែកអូឌឹម', '', 'ភ្នំពេញ', '', '', '', '', '093447', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('22', '3', 'customer', '1', 'General', 'ចែឈូកវ៉ា', 'ចែឈូកវ៉ា', '', 'ភ្នំពេញ', '', '', '', '', '016818135', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('23', '3', 'customer', '1', 'General', 'មុខពេទ្យរុស្សី', 'មុខពេទ្យរុស្សី', '', 'ភ្នំពេញ', '', '', '', '', '012344904', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('24', '4', 'supplier', null, '', 'Chau', 'DT Company', '', 'Vietnam', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('25', '4', 'supplier', null, '', 'វៀតណាម', 'វៀតណាម', '', 'វៀតណាម', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('26', '3', 'customer', '1', 'General', 'ឈូកវ៉ា', 'ឈូកវ៉ា', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('27', '4', 'supplier', null, '', 'DT', 'ចែជូ', '', 'Vietnam', 'Hochiminh ', '', '', '', '', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('28', '4', 'supplier', null, '', 'ចែជូ', 'ចែជូ', '', 'Vietnam', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', 'logo.png', '0', '0.0000', '', '', '', '', '0000-00-00', '0000-00-00', '0000-00-00', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('29', '3', 'customer', '1', 'General', 'ចែណា', 'ចែណា', '', 'អង្គតាមុិញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('30', '3', 'customer', '1', 'General', 'អុំប្រុុស', 'អុំប្រុុស', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('31', '3', 'customer', '1', 'General', 'គឹមហេង', 'គឹមហេង', '', 'ទួលគោក', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('32', '3', 'customer', '1', 'General', 'ប្តីប្រពន្', 'ប្តីប្រពន្ធ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('33', '3', 'customer', '1', 'General', 'អុីចាន់ថន', 'អុីចាន់ថន', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('34', '3', 'customer', '1', 'General', 'មុខវត្តស្ទឹងមានជ័យ', 'មុខវត្តស្ទឹងមានជ័យ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('35', '3', 'customer', '1', 'General', 'អាមួយបឺងសាឡាង', 'អាមួយបឺងសាឡាង', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '48', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('36', '3', 'customer', '1', 'General', 'សុីដនី', 'សុីដនី', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('37', '3', 'customer', '1', 'General', 'OKកាហ្វេ', 'OKកាហ្វេ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '4', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('38', '3', 'customer', '1', 'General', 'អុំប្រុុស 1', 'អុំប្រុុស 1', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('39', '3', 'customer', '1', 'General', 'បងកាំកូ', 'បងទួលគោក', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('40', '3', 'customer', '1', 'General', 'បងគន្ធាផ្សាដេប៉ូ', 'បងគន្ធាផ្សាដេប៉ូ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('41', '3', 'customer', '1', 'General', 'គ្រិះស្នា', 'អាហារដ្ឋាន', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('42', '3', 'customer', '1', 'General', 'ចែធីតាទួលគោក', 'ចែធីតាទួលគោក', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '3', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('43', '3', 'customer', '1', 'General', 'ចឹកគឺkm6', 'ចឹកគឺkm6', '', 'ឬស្សីកែវ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '166', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('44', '3', 'customer', '1', 'General', 'សឡា', 'សឡា', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('45', '3', 'customer', '1', 'General', 'បងអាមួយស្ទឹងមានជ័យ', 'បងអាមួយស្ទឹងមានជ័យ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('46', '3', 'customer', '1', 'General', 'អុីបឺងសាឡាង', 'អុីបឺងសាឡាង', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('47', '3', 'customer', '1', 'General', 'បងពោធិ៍ចិនតុង', 'បងពោធិ៍ចិនតុង', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('48', '3', 'customer', '1', 'General', 'ចែHello', 'ចែHello', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('49', '3', 'customer', '1', 'General', 'អុីពៅ', 'អុីពៅ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('50', '4', 'supplier', null, null, 'NHAK HENG', 'NHAK HENG', '', 'Phnom Penh', '', '', '', '', '', '', '', '', '', '', '', '', null, '0', 'logo.png', '0', '0.0000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('51', '3', 'customer', '1', 'General', 'ចែមួយបឹងសាឡាង', 'ចែមួយបឹងសាឡាង', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('52', '3', 'customer', '1', 'General', 'ជិតផ្ទះអីុម៉ាច', 'អង្គតាមិុញ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('53', '3', 'customer', '1', 'General', 'អីុម៉ាច', 'អង្គតាមិុញ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '6', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('54', '3', 'customer', '1', 'General', 'សាមគ្គី', 'កោសដូង', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '18', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('55', '3', 'customer', '1', 'General', 'កូនប៉ាឈី', 'អូរឡាំពិច', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('56', '3', 'customer', '1', 'General', 'ម៉ាផ្សាដីហ៊ុយ', 'ម៉ាផ្សាដីហ៊ុយ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('57', '3', 'customer', '1', 'General', 'សែនសុខ', 'បោកអ៊ុត', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('58', '3', 'customer', '1', 'General', 'អំុសន្ធមុខ', 'អំុសន្ធមុខ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('59', '3', 'customer', '1', 'General', 'គ្រូូឆេន', 'គ្រូូឆេន', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('60', '3', 'customer', '1', 'General', 'អូរឬស្សី', 'អូរឬស្សី', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('61', '3', 'customer', '1', 'General', 'បុប្ផា', 'ហាងបាយជំវន្ត័', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('62', '3', 'customer', '1', 'General', 'ឈាងហេង គីរីរម្', 'ឈាងហេង គីរីរម្យ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('63', '3', 'customer', '1', 'General', 'ក្បែរម្លប់ស្វាយធំ', 'ក្បែរម្លប់ស្វាយធំ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('64', '3', 'customer', '1', 'General', 'មុខរ៉ា', 'មុខរ៉ា', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('65', '3', 'customer', '1', 'General', 'ភូមិខ្ញុំ', 'ទឺកសុទ្ធភូមិខ្ញុំ', '', 'ទួលសង្កែ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '151', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('66', '3', 'customer', '1', 'General', 'សុីដនី', 'សុីដនី', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('67', '3', 'customer', '1', 'General', 'ពូវណ្ណាស្ពានទី10', 'ពូវណ្ណាស្ពានទី10', '', 'កណ្តាល', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '50', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('68', '3', 'customer', '1', 'General', 'អូឌឺម', 'ទឹកសណ្តែក', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('69', '3', 'customer', '1', 'General', 'ចែវីងឈូកមាស', 'ចែវីងឈូកមាស', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('70', '3', 'customer', '1', 'General', 'អាសីុអាគ្នេយ៍', 'អាសីុអាគ្នេយ៍', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('71', '3', 'customer', '1', 'General', 'អីុសា ពោធិ៍សាត់', 'អីុសា ពោធិ៍សាត់', '', 'ពោធិ៍សាត់', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('72', '3', 'customer', '1', 'General', 'ក្រោយវត្តសន្សំកុសល', 'ក្រោយវត្តសន្សំកុសល', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('73', '3', 'customer', '1', 'General', 'ចែលាងឈូកមាស', 'ចែលាងឈូកមាស', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('74', '3', 'customer', '1', 'General', 'សំណង់12', 'សំណង់12', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '75', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('75', '3', 'customer', '1', 'General', 'ទឹកល្អក់', 'ទឹកល្អក់', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('76', '3', 'customer', '1', 'General', 'បងឌីkm4', 'បងឌីkm4', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '1', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('77', '3', 'customer', '1', 'General', 'ទឹកសុទ្ធព្រៃសរ', 'ទឹកសុទ្ធព្រៃសរ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('78', '3', 'customer', '1', 'General', 'ចោមចៅ', 'ចោមចៅ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('79', '3', 'customer', '1', 'General', 'ហ៊ា ហ៊ាង ព្រែកប្រា', 'ហ៊ា ហ៊ាង ព្រែកប្រា', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('80', '3', 'customer', '1', 'General', 'ទួលសង្កែ', 'ទួលសង្កែ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('81', '3', 'customer', '1', 'General', 'ឥន្ទ្រទេេវី', 'ឥន្ទ្រទេេវី', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('82', '3', 'customer', '1', 'General', 'ពូសុកហុក', 'ពូសុកហុក', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('83', '3', 'customer', '1', 'General', 'លីនីបឹងសឡាង', 'លីនីបឹងសឡាង', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('84', '3', 'customer', '1', 'General', 'អាហារបួស', 'អាហារបួស', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('85', '3', 'customer', '1', 'General', 'ផ្សារដើមគរ', 'ផ្សារដើមគរ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '6', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('86', '3', 'customer', '1', 'General', 'អាហារបួសមេត្រី', '', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('87', '3', 'customer', '1', 'General', 'ស្រីអូន', '', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('88', '3', 'customer', '1', 'General', 'ជំពូវ័ន', '', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('89', '3', 'customer', '1', 'General', 'បង​ ផល្លី តាខ្មៅ', 'បង​ ផល្លី តាខ្មៅ', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('90', '3', 'customer', '1', 'General', 'ធានីបាក់ទូក', 'ធានីបាក់ទូក', '', 'ភ្នំពេញ', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('91', '3', 'customer', '1', 'General', 'ក្បែរអនុវិ. ឬស្សីកែវ', '', '', '', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('92', '3', 'customer', '1', 'General', 'ផ្សាដើមថ្កូវ', '', '', '', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('93', '3', 'customer', '1', 'General', 'ហ៊ាហួប៉ៃលិន', '', '', '', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('94', '3', 'customer', '1', 'General', 'បងកំពង់ត្រាំ', '', '', 'កំពង់ស្ពឺ', '', '', '', '', '015505085', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('95', '3', 'customer', '1', 'General', 'ផ្សាដើមគរ', '', '', '', '', '', '', '', '011821599', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('96', '3', 'customer', '1', 'General', 'ទឹកសុទ្ធសុខភាព', '', '', '', '', '', '', '', '018000000', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('97', '3', 'customer', '1', 'General', 'ទឹកសុទ្ធORAL', '', '', '', '', '', '', '', '019000000', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('98', '3', 'customer', '1', 'General', 'លូប្រាំ', '', '', '', '', '', '', '', '0978288761', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('99', '3', 'customer', '1', 'General', 'ទួលសង្កែ', '', '', '', '', '', '', '', '077988184', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('100', '3', 'customer', '1', 'General', 'ទួលសង្កែ', '', '', '', '', '', '', '', '012258838', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('101', '3', 'customer', '1', 'General', 'បឹងសាឡាងដូង', '', '', '', '', '', '', '', '014000000', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('102', '3', 'customer', '1', 'General', 'កែងសំណង់12', '', '', '', '', '', '', '', '013000000', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('103', '3', 'customer', '1', 'General', 'ផ្សារឈូកមាស', '', '', '', '', '', '', '', '011751966', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('104', '3', 'customer', '1', 'General', 'អូរឬស្សី', '', '', '', '', '', '', '', '012709013', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('105', '3', 'customer', '1', 'General', 'ផ្សារតាំងក្រសាំងថ្មី', '', '', '', '', '', '', '', '093732973', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('106', '3', 'customer', '1', 'General', 'អន្លង់ក្ងាន', '', '', '', '', '', '', '', '093618888', '', '', null, null, null, null, null, null, '0', 'logo.png', '0', '0.0000', '', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);
INSERT INTO `erp_companies` VALUES ('107', '3', 'customer', '1', 'General', 'កាំកូរ', '', '', '', '', '', '', '', '', '', '', null, null, null, null, null, null, '0', 'logo.png', '5', null, 'single', null, '', null, '0000-00-00', '0000-00-00', '0000-00-00', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for erp_condition_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_condition_tax`;
CREATE TABLE `erp_condition_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(55) NOT NULL,
  `rate` decimal(12,4) NOT NULL,
  `min_salary` double(19,0) DEFAULT NULL,
  `max_salary` double(19,0) DEFAULT NULL,
  `reduct_tax` double(19,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_condition_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_convert
-- ----------------------------
DROP TABLE IF EXISTS `erp_convert`;
CREATE TABLE `erp_convert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(55) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `noted` varchar(200) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `bom_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_convert
-- ----------------------------
INSERT INTO `erp_convert` VALUES ('1', 'CON/1610/00001', '2016-10-04 15:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('2', 'CON/1610/00002', '2016-10-05 15:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('3', 'CON/1610/00003', '2016-10-05 15:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('4', 'CON/1610/00004', '2016-10-06 15:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('5', 'CON/1610/00005', '2016-10-06 15:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('6', 'CON/1610/00006', '2016-10-07 17:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('7', 'CON/1610/00007', '2016-10-07 17:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('8', 'CON/1610/00008', '2016-10-08 17:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('9', 'CON/1610/00009', '2016-10-08 17:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('10', 'CON/1610/00010', '2016-10-09 17:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('11', 'CON/1610/00011', '2016-10-09 17:11:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('12', 'CON/1610/00012', '2016-10-12 16:07:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('13', 'CON/1610/00013', '2016-10-12 16:28:00', '', '1', '1', null, '0');
INSERT INTO `erp_convert` VALUES ('14', 'CON/1610/00013', '2016-10-12 16:24:00', '', '1', '1', null, '0');

-- ----------------------------
-- Table structure for erp_convert_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_convert_items`;
CREATE TABLE `erp_convert_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `convert_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` decimal(25,4) NOT NULL,
  `cost` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transfer_id` (`convert_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_convert_items
-- ----------------------------
INSERT INTO `erp_convert_items` VALUES ('1', '1', '266', 'HVP12.5-W', 'ឡតលេខកូដ HVP ទំងន់12.5​ ក្រាមពណ៌ស(W)(30kg)', '9.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('2', '1', '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('3', '1', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '6.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('4', '1', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', '71.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('5', '1', '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', '102.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('6', '1', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '11.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('7', '2', '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('8', '2', '261', 'TN32-W', 'ឡតលេខកូដ TN ទំងន់32​ ក្រាមពណ៌ស(W)(25kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('9', '2', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('10', '2', '56', 'Caps-010-GISO', 'គំរបបៃតងស្តង់ដា(10000)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('11', '2', '205', 'TAT14.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)', '25.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('12', '2', '262', 'TN32-W-KG', 'ឡតលេខកូដ TN ទំងន់32ក្រាមពណ៌ស(W).', '25.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('13', '2', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', '10000.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('14', '2', '59', 'Caps-010-GISO-UNIT', 'គំរបបៃតងស្តង់ដា', '10000.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('15', '3', '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', '3.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('16', '3', '205', 'TAT14.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)', '9.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('17', '3', '261', 'TN32-W', 'ឡតលេខកូដ TN ទំងន់32​ ក្រាមពណ៌ស(W)(25kg)', '11.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('18', '3', '262', 'TN32-W-KG', 'ឡតលេខកូដ TN ទំងន់32ក្រាមពណ៌ស(W).', '12.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('19', '3', '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '8.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('20', '3', '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', '5.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('21', '3', '126', 'DT13-W-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W).', '17.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('22', '3', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '16.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('23', '3', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', '186.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('24', '3', '253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', '51.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('25', '3', '117', 'DT13-450-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', '53.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('26', '3', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '66.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('27', '3', '277', 'TAT-14.5-350-V', 'ដបលេខកូដ​ TATទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '29.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('28', '4', '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('29', '4', '126', 'DT13-W-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W).', '30.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('30', '5', '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', '5.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('31', '5', '205', 'TAT14.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)', '8.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('32', '5', '261', 'TN32-W', 'ឡតលេខកូដ TN ទំងន់32​ ក្រាមពណ៌ស(W)(25kg)', '19.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('33', '5', '262', 'TN32-W-KG', 'ឡតលេខកូដ TN ទំងន់32ក្រាមពណ៌ស(W).', '13.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('34', '5', '156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '6.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('35', '5', '157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', '3.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('36', '5', '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '3.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('37', '5', '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', '6.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('38', '5', '126', 'DT13-W-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W).', '11.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('39', '5', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '16.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('40', '5', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', '186.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('41', '5', '253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', '87.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('42', '5', '117', 'DT13-450-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', '69.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('43', '5', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '22.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('44', '5', '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '31.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('45', '5', '277', 'TAT-14.5-350-V', 'ដបលេខកូដ​ TATទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '46.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('46', '6', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('47', '6', '102', 'DT12.5-B-KG', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)', '30.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('48', '7', '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', '4.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('49', '7', '205', 'TAT14.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)', '8.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('50', '7', '261', 'TN32-W', 'ឡតលេខកូដ TN ទំងន់32​ ក្រាមពណ៌ស(W)(25kg)', '7.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('51', '7', '156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '7.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('52', '7', '157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', '7.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('53', '7', '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '2.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('54', '7', '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', '6.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('55', '7', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '13.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('56', '7', '102', 'DT12.5-B-KG', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)', '19.0000', '19.6080', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('57', '7', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', '155.0000', '3.2680', 'add');
INSERT INTO `erp_convert_items` VALUES ('58', '7', '253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', '36.0000', '3.2680', 'add');
INSERT INTO `erp_convert_items` VALUES ('59', '7', '117', 'DT13-450-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', '63.0000', '3.2680', 'add');
INSERT INTO `erp_convert_items` VALUES ('60', '7', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '15.0000', '3.2680', 'add');
INSERT INTO `erp_convert_items` VALUES ('61', '7', '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '80.0000', '3.2680', 'add');
INSERT INTO `erp_convert_items` VALUES ('62', '7', '277', 'TAT-14.5-350-V', 'ដបលេខកូដ​ TATទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '37.0000', '3.2680', 'add');
INSERT INTO `erp_convert_items` VALUES ('63', '8', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('64', '8', '102', 'DT12.5-B-KG', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)', '30.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('65', '9', '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', '14.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('66', '9', '156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '10.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('67', '9', '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '9.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('68', '9', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '11.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('69', '9', '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '15.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('70', '9', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', '138.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('71', '9', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '76.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('72', '9', '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '84.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('73', '9', '277', 'TAT-14.5-350-V', 'ដបលេខកូដ​ TATទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '118.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('74', '10', '44', 'Caps-007-PUST', 'គំរបផ្កាឈូកលាតUST(10000)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('75', '10', '156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('76', '10', '47', 'Caps-007-PUST-UNIT', 'គំរបផ្កាឈូកលាតUST', '10000.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('77', '10', '157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', '30.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('78', '11', '156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '8.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('79', '11', '157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', '8.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('80', '11', '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '7.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('81', '11', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '60.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('82', '11', '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', '72.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('83', '12', '9', 'BAGE-002', 'កាដុងមាត់ធំ 20L', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('84', '12', '8', 'BAGE-001', 'កាដុងមាត់តូច 20L', '10.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('85', '13', '9', 'BAGE-002', 'កាដុងមាត់ធំ 20L', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('86', '13', '8', 'BAGE-001', 'កាដុងមាត់តូច 20L', '10.0000', '0.0000', 'add');
INSERT INTO `erp_convert_items` VALUES ('87', '14', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', '1.0000', '0.0000', 'deduct');
INSERT INTO `erp_convert_items` VALUES ('88', '14', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', '10.0000', '0.0000', 'add');

-- ----------------------------
-- Table structure for erp_costing
-- ----------------------------
DROP TABLE IF EXISTS `erp_costing`;
CREATE TABLE `erp_costing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sale_item_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `purchase_item_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `purchase_net_unit_cost` decimal(25,4) DEFAULT NULL,
  `purchase_unit_cost` decimal(25,4) DEFAULT NULL,
  `sale_net_unit_price` decimal(25,4) NOT NULL,
  `sale_unit_price` decimal(25,4) NOT NULL,
  `quantity_balance` decimal(15,4) DEFAULT NULL,
  `inventory` tinyint(1) DEFAULT '0',
  `overselling` tinyint(1) DEFAULT '0',
  `option_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_costing
-- ----------------------------
INSERT INTO `erp_costing` VALUES ('1', '2016-10-03', '122', '1', '1', '2', '5.0000', '0.0000', '0.0000', '7.0000', '7.0000', '432.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('2', '2016-10-03', '23', '2', '1', '17', '1000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '12800.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('3', '2016-10-03', '263', '3', '1', '65', '2.0000', '0.0000', '0.0000', '7.0000', '7.0000', '658.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('4', '2016-10-03', '265', '4', '1', '67', '400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '8600.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('5', '2016-10-03', '263', '5', '1', '65', '1.0000', '0.0000', '0.0000', '8.5000', '8.5000', '659.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('6', '2016-10-03', '265', '6', '1', '67', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '8800.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('7', '2016-10-03', '122', '7', '2', '2', '0.0000', '0.0000', '0.0000', '7.0000', '7.0000', '432.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('8', '2016-10-03', '23', '8', '2', '17', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '12800.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('9', '2016-10-03', '263', '9', '2', '65', '0.0000', '0.0000', '0.0000', '7.0000', '7.0000', '657.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('10', '2016-10-03', '265', '10', '2', '67', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '8400.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('11', '2016-10-03', '263', '11', '2', '65', '0.0000', '0.0000', '0.0000', '8.5000', '8.5000', '657.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('12', '2016-10-03', '265', '12', '2', '67', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '8400.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('13', '2016-10-05', '263', '13', '3', '65', '20.0000', '0.0000', '0.0000', '7.5000', '7.5000', '637.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('14', '2016-10-05', '59', '14', '3', '19', '4000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '14200.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('15', '2016-10-05', '122', '15', '4', '2', '7.0000', '0.0000', '0.0000', '7.0000', '7.0000', '425.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('16', '2016-10-05', '23', '16', '4', '17', '1000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '11800.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('17', '2016-10-05', '27', '17', '4', '21', '400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '4600.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('18', '2016-10-05', '92', '18', '4', '9', '2.0000', '0.0000', '0.0000', '8.0000', '8.0000', '229.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('19', '2016-10-05', '23', '19', '4', '17', '400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '12400.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('20', '2016-10-05', '58', '20', '4', null, '1.0000', null, null, '1.2500', '1.2500', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('21', '2016-10-05', '92', '21', '4', '9', '1.0000', '0.0000', '0.0000', '7.5000', '7.5000', '230.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('22', '2016-10-05', '23', '22', '4', '17', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '12600.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('23', '2016-10-05', '122', '23', '4', '2', '1.0000', '0.0000', '0.0000', '9.0000', '9.0000', '431.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('24', '2016-10-05', '23', '24', '4', '17', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '12600.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('25', '2016-10-05', '92', '25', '5', '9', '4.0000', '0.0000', '0.0000', '6.5000', '6.5000', '224.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('26', '2016-10-05', '86', '26', '5', '1', '1.0000', '0.0000', '0.0000', '6.5000', '6.5000', '191.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('27', '2016-10-05', '23', '27', '5', '17', '1000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '10000.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('28', '2016-10-05', '263', '28', '5', '65', '1.0000', '0.0000', '0.0000', '7.0000', '7.0000', '636.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('29', '2016-10-05', '265', '29', '5', '67', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '8200.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('30', '2016-10-05', '92', '30', '6', '9', '4.0000', '0.0000', '0.0000', '6.5000', '6.5000', '220.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('31', '2016-10-05', '122', '31', '6', '2', '3.0000', '0.0000', '0.0000', '6.5000', '6.5000', '421.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('32', '2016-10-05', '23', '32', '6', '17', '1400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '8600.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('33', '2016-10-05', '92', '33', '7', '9', '30.0000', '0.0000', '0.0000', '6.0000', '6.0000', '190.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('34', '2016-10-05', '23', '34', '7', '17', '6000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2600.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('35', '2016-10-05', '92', '35', '8', '9', '5.0000', '0.0000', '0.0000', '7.0000', '7.0000', '185.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('36', '2016-10-05', '23', '36', '8', '17', '1000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1600.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('37', '2016-10-05', '275', '37', '9', '86', '2.0000', '0.0000', '0.0000', '48.0000', '48.0000', '18.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('38', '2016-10-05', '122', '38', '10', '2', '5.0000', '0.0000', '0.0000', '6.5000', '6.5000', '416.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('39', '2016-10-05', '92', '39', '10', '9', '5.0000', '0.0000', '0.0000', '6.5000', '6.5000', '180.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('40', '2016-10-05', '23', '40', '10', '17', '1000.0000', '0.0000', '0.0000', '0.0000', '0.0000', '600.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('41', '2016-10-05', '177', '41', '11', '55', '30.0000', '0.0000', '0.0000', '3.5000', '3.5000', '90970.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('42', '2016-10-05', '92', '42', '12', '9', '2.0000', '0.0000', '0.0000', '8.5000', '8.5000', '178.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('43', '2016-10-05', '23', '43', '12', '17', '400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '200.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('44', '2016-10-05', '122', '44', '13', '2', '10.0000', '0.0000', '0.0000', '6.5000', '6.5000', '406.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('45', '2016-10-05', '23', '45', '13', '17', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('46', '2016-10-05', '23', '45', '13', null, '2000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('47', '2016-10-05', '92', '46', '13', '9', '2.0000', '0.0000', '0.0000', '7.0000', '7.0000', '176.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('48', '2016-10-05', '23', '47', '13', '17', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('49', '2016-10-05', '23', '47', '13', null, '400.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('50', '2016-10-05', '92', '48', '13', '9', '5.0000', '0.0000', '0.0000', '7.0000', '7.0000', '173.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('51', '2016-10-05', '23', '49', '13', '17', '200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('52', '2016-10-05', '23', '49', '13', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('53', '2016-10-05', '253', '50', '14', '5', '70.0000', '0.0000', '0.0000', '11.7600', '11.7600', '221.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('54', '2016-10-05', '89', '51', '15', '3', '150.0000', '0.0000', '0.0000', '5.0000', '5.0000', '933.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('55', '2016-10-05', '264', '52', '15', '66', '3.0000', '0.0000', '0.0000', '0.0000', '0.0000', '42.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('56', '2016-10-06', '92', '53', '16', null, '1.0000', null, null, '7.5000', '7.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('57', '2016-10-06', '23', '54', '16', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('58', '2016-10-06', '92', '55', '16', null, '1.0000', null, null, '7.5000', '7.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('59', '2016-10-06', '23', '56', '16', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('60', '2016-10-06', '92', '57', '16', null, '2.0000', null, null, '8.0000', '8.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('61', '2016-10-06', '23', '58', '16', null, '400.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('62', '2016-10-06', '147', '59', '17', '14', '22.0000', '0.0000', '0.0000', '8.0000', '8.0000', '267.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('63', '2016-10-06', '153', '60', '17', '13', '70.0000', '0.0000', '0.0000', '6.8000', '6.8000', '260.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('64', '2016-10-06', '122', '61', '18', '2', '5.0000', '0.0000', '0.0000', '7.5000', '7.5000', '401.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('65', '2016-10-06', '23', '62', '18', '17', '-3200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('66', '2016-10-06', '23', '62', '18', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('67', '2016-10-06', '92', '63', '19', '9', '5.0000', '0.0000', '0.0000', '7.0000', '7.0000', '166.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('68', '2016-10-06', '23', '64', '19', '17', '-4200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('69', '2016-10-06', '23', '64', '19', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('70', '2016-10-06', '92', '65', '19', '9', '1.0000', '0.0000', '0.0000', '7.0000', '7.0000', '170.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('71', '2016-10-06', '23', '66', '19', '17', '-4200.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('72', '2016-10-06', '23', '66', '19', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('73', '2016-10-07', '92', '67', '20', '9', '5.0000', '0.0000', '0.0000', '6.5000', '6.5000', '160.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('74', '2016-10-07', '23', '68', '20', '17', '-5400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('75', '2016-10-07', '23', '68', '20', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('76', '2016-10-07', '122', '69', '21', '2', '10.0000', '0.0000', '0.0000', '6.5000', '6.5000', '391.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('77', '2016-10-07', '23', '70', '21', '17', '-6400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('78', '2016-10-07', '23', '70', '21', null, '2000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('79', '2016-10-07', '53', '71', '21', null, '1.0000', null, null, '6.5000', '6.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('80', '2016-10-11', '89', '72', '22', '3', '0.0000', '0.0000', '0.0000', '5.0000', '5.0000', '933.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('81', '2016-10-11', '24', '73', '22', '20', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '36.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('82', '2016-10-07', '86', '74', '23', '1', '10.0000', '0.0000', '0.0000', '7.0000', '7.0000', '181.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('83', '2016-10-07', '23', '75', '23', '17', '-8400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('84', '2016-10-07', '23', '75', '23', null, '2000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('85', '2016-10-07', '92', '76', '24', null, '1.0000', null, null, '8.0000', '8.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('86', '2016-10-07', '23', '77', '24', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('87', '2016-10-07', '122', '78', '24', null, '1.0000', null, null, '8.0000', '8.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('88', '2016-10-07', '23', '79', '24', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('89', '2016-10-07', '92', '80', '24', null, '1.0000', null, null, '7.5000', '7.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('90', '2016-10-07', '23', '81', '24', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('91', '2016-10-07', '92', '82', '25', '9', '30.0000', '0.0000', '0.0000', '6.0000', '6.0000', '130.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('92', '2016-10-07', '122', '83', '25', '2', '20.0000', '0.0000', '0.0000', '6.2000', '6.2000', '371.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('93', '2016-10-07', '20', '84', '25', '16', '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', '39.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('94', '2016-10-11', '77', '85', '26', '8', '0.0000', '0.0000', '0.0000', '5.4000', '5.4000', '342.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('96', '2016-10-11', '23', '86', '26', null, '16400.0000', null, null, '0.0000', '0.0000', '-10400.0000', '1', '1', null);
INSERT INTO `erp_costing` VALUES ('97', '2016-10-07', '92', '87', '27', '9', '5.0000', '0.0000', '0.0000', '6.5000', '6.5000', '125.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('98', '2016-10-07', '23', '88', '27', '17', '-16400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('99', '2016-10-07', '23', '88', '27', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('100', '2016-10-07', '92', '89', '28', '9', '50.0000', '0.0000', '0.0000', '6.0000', '6.0000', '75.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('101', '2016-10-07', '20', '90', '28', '16', '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', '38.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('102', '2016-10-07', '86', '91', '28', '1', '10.0000', '0.0000', '0.0000', '6.3000', '6.3000', '171.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('103', '2016-10-07', '23', '92', '28', '17', '-17400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('104', '2016-10-07', '23', '92', '28', null, '2000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('105', '2016-10-07', '253', '93', '29', '5', '47.0000', '0.0000', '0.0000', '11.7600', '11.7600', '174.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('106', '2016-10-07', '263', '94', '29', '65', '50.0000', '0.0000', '0.0000', '5.9000', '5.9000', '586.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('107', '2016-10-07', '264', '95', '29', '66', '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', '41.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('108', '2016-10-08', '89', '96', '30', '3', '300.0000', '0.0000', '0.0000', '5.0000', '5.0000', '533.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('109', '2016-10-08', '264', '97', '30', '66', '6.0000', '0.0000', '0.0000', '0.0000', '0.0000', '35.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('110', '2016-10-08', '92', '98', '31', '9', '65.0000', '0.0000', '0.0000', '5.8000', '5.8000', '10.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('111', '2016-10-08', '122', '99', '31', '2', '20.0000', '0.0000', '0.0000', '6.0000', '6.0000', '351.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('112', '2016-10-08', '86', '100', '31', '1', '15.0000', '0.0000', '0.0000', '6.0000', '6.0000', '156.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('113', '2016-10-08', '20', '101', '31', '16', '2.0000', '0.0000', '0.0000', '0.0000', '0.0000', '36.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('114', '2016-10-08', '122', '102', '32', '2', '5.0000', '0.0000', '0.0000', '6.5000', '6.5000', '346.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('115', '2016-10-08', '23', '103', '32', '17', '-19400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('116', '2016-10-08', '23', '103', '32', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('117', '2016-10-08', '122', '104', '33', '2', '5.0000', '0.0000', '0.0000', '6.5000', '6.5000', '341.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('118', '2016-10-08', '23', '105', '33', '17', '-20400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('119', '2016-10-08', '23', '105', '33', null, '1000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('120', '2016-10-08', '92', '106', '34', null, '3.0000', null, null, '7.0000', '7.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('121', '2016-10-08', '23', '107', '34', null, '600.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('122', '2016-10-08', '92', '108', '34', null, '1.0000', null, null, '9.0000', '9.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('123', '2016-10-08', '23', '109', '34', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('124', '2016-10-08', '92', '110', '34', null, '1.0000', null, null, '8.0000', '8.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('125', '2016-10-08', '23', '111', '34', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('126', '2016-10-08', '92', '112', '34', null, '1.0000', null, null, '7.5000', '7.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('127', '2016-10-08', '23', '113', '34', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('128', '2016-10-11', '77', '114', '26', null, '30.0000', null, null, '5.4000', '5.4000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('129', '2016-10-11', '23', '115', '26', '17', '-15400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('130', '2016-10-11', '23', '115', '26', null, '6000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('131', '2016-10-11', '89', '116', '22', null, '100.0000', null, null, '5.0000', '5.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('132', '2016-10-11', '24', '117', '22', null, '2.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('133', '2016-10-08', '125', '118', '35', '95', '50.0000', '0.0000', '0.0000', '37.5000', '37.5000', '73.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('134', '2016-10-08', '20', '119', '35', '16', '12.0000', '0.0000', '0.0000', '45.0000', '45.0000', '24.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('135', '2016-10-08', '144', '120', '35', null, '100.0000', null, null, '8.6000', '8.6000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('136', '2016-10-08', '48', '121', '35', '22', '2.0000', '0.0000', '0.0000', '0.0000', '0.0000', '28.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('137', '2016-10-08', '274', '122', '35', null, '3.0000', null, null, '51.0000', '51.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('138', '2016-10-08', '162', '123', '35', '53', '1.0000', '0.0000', '0.0000', '51.0000', '51.0000', '0.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('139', '2016-10-08', '160', '124', '35', '52', '1.0000', '0.0000', '0.0000', '51.0000', '51.0000', '4.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('140', '2016-10-08', '147', '125', '36', '14', '85.0000', '0.0000', '0.0000', '8.0000', '8.0000', '182.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('141', '2016-10-09', '122', '126', '37', '2', '30.0000', '0.0000', '0.0000', '6.5000', '6.5000', '311.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('142', '2016-10-09', '92', '127', '37', '9', '10.0000', '0.0000', '0.0000', '6.5000', '6.5000', '0.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('143', '2016-10-09', '92', '127', '37', null, '20.0000', null, null, '6.5000', '6.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('144', '2016-10-09', '20', '128', '37', '16', '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', '23.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('145', '2016-10-09', '117', '129', '38', '6', '10.0000', '0.0000', '0.0000', '6.0000', '6.0000', '345.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('146', '2016-10-09', '47', '130', '38', null, '2000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('147', '2016-10-09', '92', '131', '38', '9', '-10.0000', '0.0000', '0.0000', '7.0000', '7.0000', '0.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('148', '2016-10-09', '92', '131', '38', null, '2.0000', null, null, '7.0000', '7.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('149', '2016-10-09', '23', '132', '38', '17', '-21400.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '1', '0', null);
INSERT INTO `erp_costing` VALUES ('150', '2016-10-09', '23', '132', '38', null, '400.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('151', '2016-10-09', '92', '133', '39', '9', '-12.0000', '0.0000', '0.0000', '6.0000', '6.0000', '0.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('152', '2016-10-09', '92', '133', '39', null, '35.0000', null, null, '6.0000', '6.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('153', '2016-10-09', '86', '134', '39', '1', '15.0000', '0.0000', '0.0000', '6.0000', '6.0000', '141.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('154', '2016-10-09', '20', '135', '39', '16', '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', '22.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('155', '2016-10-09', '48', '136', '40', '22', '3.0000', '0.0000', '0.0000', '63.0000', '63.0000', '25.0000', '1', '0', '0');
INSERT INTO `erp_costing` VALUES ('156', '2016-10-09', '92', '137', '41', null, '1.0000', null, null, '8.0000', '8.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('157', '2016-10-09', '59', '138', '41', null, '200.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('158', '2016-10-09', '92', '139', '41', null, '10.0000', null, null, '6.5000', '6.5000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('159', '2016-10-09', '23', '140', '41', null, '2000.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('160', '2016-10-09', '122', '141', '41', null, '6.0000', null, null, '7.0000', '7.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('161', '2016-10-09', '23', '142', '41', null, '600.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);
INSERT INTO `erp_costing` VALUES ('162', '2016-10-09', '59', '143', '41', null, '600.0000', null, null, '0.0000', '0.0000', null, '1', '1', null);

-- ----------------------------
-- Table structure for erp_currencies
-- ----------------------------
DROP TABLE IF EXISTS `erp_currencies`;
CREATE TABLE `erp_currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  `name` varchar(55) NOT NULL,
  `in_out` tinyint(1) DEFAULT NULL,
  `rate` decimal(12,4) NOT NULL,
  `auto_update` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_currencies
-- ----------------------------
INSERT INTO `erp_currencies` VALUES ('1', 'USD', 'US Dollar', null, '1.0000', '0');
INSERT INTO `erp_currencies` VALUES ('2', 'KHM', 'RIAL', null, '4000.0000', '0');

-- ----------------------------
-- Table structure for erp_customer_groups
-- ----------------------------
DROP TABLE IF EXISTS `erp_customer_groups`;
CREATE TABLE `erp_customer_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `percent` int(11) NOT NULL,
  `makeup_cost` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_customer_groups
-- ----------------------------
INSERT INTO `erp_customer_groups` VALUES ('1', 'General', '0', '0');
INSERT INTO `erp_customer_groups` VALUES ('2', 'Reseller', '-5', '0');
INSERT INTO `erp_customer_groups` VALUES ('3', 'Distributor', '-15', '0');
INSERT INTO `erp_customer_groups` VALUES ('4', 'New Customer (+10)', '10', '0');
INSERT INTO `erp_customer_groups` VALUES ('5', 'Makeup (+10)', '10', '1');

-- ----------------------------
-- Table structure for erp_date_format
-- ----------------------------
DROP TABLE IF EXISTS `erp_date_format`;
CREATE TABLE `erp_date_format` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `js` varchar(20) NOT NULL,
  `php` varchar(20) NOT NULL,
  `sql` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_date_format
-- ----------------------------
INSERT INTO `erp_date_format` VALUES ('1', 'mm-dd-yyyy', 'm-d-Y', '%m-%d-%Y');
INSERT INTO `erp_date_format` VALUES ('2', 'mm/dd/yyyy', 'm/d/Y', '%m/%d/%Y');
INSERT INTO `erp_date_format` VALUES ('3', 'mm.dd.yyyy', 'm.d.Y', '%m.%d.%Y');
INSERT INTO `erp_date_format` VALUES ('4', 'dd-mm-yyyy', 'd-m-Y', '%d-%m-%Y');
INSERT INTO `erp_date_format` VALUES ('5', 'dd/mm/yyyy', 'd/m/Y', '%d/%m/%Y');
INSERT INTO `erp_date_format` VALUES ('6', 'dd.mm.yyyy', 'd.m.Y', '%d.%m.%Y');
INSERT INTO `erp_date_format` VALUES ('7', 'yyyy-mm-dd', 'Y-m-d', '%Y-%m-%d');

-- ----------------------------
-- Table structure for erp_deliveries
-- ----------------------------
DROP TABLE IF EXISTS `erp_deliveries`;
CREATE TABLE `erp_deliveries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) NOT NULL,
  `do_reference_no` varchar(50) NOT NULL,
  `sale_reference_no` varchar(50) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `address` varchar(1000) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_status` varchar(20) DEFAULT NULL,
  `delivery_by` int(11) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_deliveries
-- ----------------------------
INSERT INTO `erp_deliveries` VALUES ('1', '2016-10-03 02:00:00', '1', 'DO/1610/00001', 'SALE/1610/00001', 'កាំកូរ', '    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('3', '2016-10-05 06:25:00', '3', 'DO/1610/00003', 'SALE/1610/00003', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('4', '2016-10-05 15:25:00', '4', 'DO/1610/00004', 'SALE/1610/00004', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('5', '2016-10-05 10:25:00', '5', 'DO/1610/00005', 'SALE/1610/00005', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('6', '2016-10-05 10:25:00', '6', 'DO/1610/00006', 'SALE/1610/00006', 'OKកាហ្វេ', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('7', '2016-10-05 09:25:00', '7', 'DO/1610/00007', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('8', '2016-10-05 09:25:00', '8', 'DO/1610/00008', 'SALE/1610/00008', 'ចែធីតាទួលគោក', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('9', '2016-10-05 09:45:00', '9', 'DO/1610/00009', 'SALE/1610/00009', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('10', '2016-10-05 10:25:00', '10', 'DO/1610/00010', 'SALE/1610/00010', 'អីុម៉ាច', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('11', '2016-10-05 09:25:00', '11', 'DO/1610/00011', 'SALE/1610/00011', 'កំពង់ស្ពឺ', 'កំពង់ស្ពឺ    <br>Tel: 017239800/016949730 Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('12', '2016-10-05 10:30:00', '12', 'DO/1610/00012', 'SALE/1610/00012', 'បងឌីkm4', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('13', '2016-10-05 09:25:00', '13', 'DO/1610/00013', 'SALE/1610/00013', 'សាមគ្គី', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('14', '2016-10-05 05:25:00', '14', 'DO/1610/00014', 'SALE/1610/00014', 'ចឹកគឺkm6', 'ឬស្សីកែវ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('15', '2016-10-05 10:45:00', '15', 'DO/1610/00015', 'SALE/1610/00015', 'សំណង់12', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('16', '2016-10-06 10:30:00', '16', 'DO/1610/00016', 'SALE/1610/00016', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('17', '2016-10-06 10:30:00', '17', 'DO/1610/00017', 'SALE/1610/00017', 'ភូមិខ្ញុំ', 'ទួលសង្កែ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('18', '2016-10-06 06:30:00', '18', 'DO/1610/00018', 'SALE/1610/00018', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('19', '2016-10-06 10:45:00', '19', 'DO/1610/00019', 'SALE/1610/00019', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('20', '2016-10-07 10:30:00', '20', 'DO/1610/00020', 'SALE/1610/00020', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('21', '2016-10-07 10:30:00', '21', 'DO/1610/00021', 'SALE/1610/00021', 'សាមគ្គី', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('22', '2016-10-08 06:30:00', '22', 'DO/1610/00022', 'SALE/1610/00022', 'ពូវណ្ណាស្ពានទី10', 'កណ្តាល    <br>Tel:  Email: ', null, '1', null, null, 'pending', '1', null);
INSERT INTO `erp_deliveries` VALUES ('23', '2016-10-07 06:25:00', '23', 'DO/1610/00023', 'SALE/1610/00023', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('24', '2016-10-07 06:30:00', '24', 'DO/1610/00024', 'SALE/1610/00024', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('25', '2016-10-07 10:25:00', '25', 'DO/1610/00025', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('26', '2016-10-08 09:25:00', '26', 'DO/1610/00026', 'SALE/1610/00026', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '1', null);
INSERT INTO `erp_deliveries` VALUES ('27', '2016-10-07 10:25:00', '27', 'DO/1610/00027', 'SALE/1610/00027', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('28', '2016-10-07 10:30:00', '28', 'DO/1610/00028', 'SALE/1610/00028', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('29', '2016-10-07 10:30:00', '29', 'DO/1610/00029', 'SALE/1610/00029', 'ចឹកគឺkm6', 'ឬស្សីកែវ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('30', '2016-10-08 10:30:00', '30', 'DO/1610/00030', 'SALE/1610/00030', 'ពារាំង', 'ព្រៃវែង    <br>Tel: 070345399/016664404 Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('31', '2016-10-08 10:30:00', '31', 'DO/1610/00031', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', 'ភ្នំពេញ    <br>Tel: 089763008 Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('32', '2016-10-08 10:30:00', '32', 'DO/1610/00032', 'SALE/1610/00032', 'ផ្សារដើមគរ', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('33', '2016-10-08 11:30:00', '33', 'DO/1610/00033', 'SALE/1610/00033', 'ផ្សារដើមគរ', 'ភ្នំពេញ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('34', '2016-10-08 10:25:00', '34', 'DO/1610/00034', 'SALE/1610/00034', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('35', '2016-10-08 10:30:00', '35', 'DO/1610/00035', 'SALE/1610/00035', 'កំពង់ស្ពឺ', 'កំពង់ស្ពឺ    <br>Tel: 017239800/016949730 Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('36', '2016-10-08 06:30:00', '36', 'DO/1610/00036', 'SALE/1610/00036', 'ភូមិខ្ញុំ', 'ទួលសង្កែ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('37', '2016-10-09 10:30:00', '37', 'DO/1610/00037', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', 'ភ្នំពេញ    <br>Tel: 092904122 Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('38', '2016-10-09 10:30:00', '38', 'DO/1610/00038', 'SALE/1610/00038', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('39', '2016-10-09 09:25:00', '39', 'DO/1610/00039', 'SALE/1610/00039', 'ចែ ជិនជូវី', 'ភ្នំពេញ    <br>Tel: 010908887/092677268 Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('40', '2016-10-09 09:25:00', '40', 'DO/1610/00040', 'SALE/1610/00040', 'ភូមិខ្ញុំ', 'ទួលសង្កែ    <br>Tel:  Email: ', null, '1', null, null, 'pending', '0', null);
INSERT INTO `erp_deliveries` VALUES ('41', '2016-10-09 09:20:00', '41', 'DO/1610/00041', 'SALE/1610/00041', 'General', '#23C st.17 kan.Toulkork Phnom Penh Kondal  Cambodia<br>Tel: 023 634 6666 Email: demo@cloudnet.com.kh', null, '1', null, null, 'pending', '0', null);

-- ----------------------------
-- Table structure for erp_delivery_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_delivery_items`;
CREATE TABLE `erp_delivery_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `do_reference_no` varchar(50) NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `category_name` varchar(255) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_id` (`do_reference_no`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`,`do_reference_no`),
  KEY `sale_id_2` (`do_reference_no`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_delivery_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_deposits
-- ----------------------------
DROP TABLE IF EXISTS `erp_deposits`;
CREATE TABLE `erp_deposits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `company_id` int(11) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `paid_by` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_code` varchar(20) DEFAULT NULL,
  `bank_code` varchar(20) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_deposits
-- ----------------------------

-- ----------------------------
-- Table structure for erp_documents
-- ----------------------------
DROP TABLE IF EXISTS `erp_documents`;
CREATE TABLE `erp_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `description` text,
  `brand_id` varchar(50) DEFAULT NULL,
  `category_id` varchar(50) DEFAULT NULL,
  `subcategory_id` varchar(50) DEFAULT NULL,
  `cost` decimal(50,0) DEFAULT NULL,
  `price` decimal(8,4) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `image` varchar(150) DEFAULT NULL,
  `serial` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_documents
-- ----------------------------

-- ----------------------------
-- Table structure for erp_document_photos
-- ----------------------------
DROP TABLE IF EXISTS `erp_document_photos`;
CREATE TABLE `erp_document_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_document_photos
-- ----------------------------

-- ----------------------------
-- Table structure for erp_expenses
-- ----------------------------
DROP TABLE IF EXISTS `erp_expenses`;
CREATE TABLE `erp_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference` varchar(55) NOT NULL,
  `amount` decimal(25,6) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `account_code` varchar(20) DEFAULT NULL,
  `bank_code` varchar(20) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tax` tinyint(3) DEFAULT '0',
  `status` varchar(55) DEFAULT '',
  `warehouse_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_expenses
-- ----------------------------
INSERT INTO `erp_expenses` VALUES ('1', '2016-10-06 09:25:00', 'EX/1610/00001', '2.250000', '<p>ចំនាយថ្លៃប្រេងសាំង</p>', '1', null, '601235', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('2', '2016-10-06 10:25:00', 'EX/1610/00002', '1.250000', '<p>ចំណាយថ្លៃប៉ូលីសផាកពិន័យ</p>', '1', null, '601220', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('3', '2016-10-06 09:05:00', 'EX/1610/00003', '40.000000', '<p>ចំណាយថ្លទិញសម្ភារះម៉ាស៊ីន</p>', '1', null, '601204', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('4', '2016-10-07 09:25:00', 'EX/1610/00004', '697.000000', '<p>ចំណាយថ្លៃដឹកឡត</p>', '1', null, '500102', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('5', '2016-10-07 10:25:00', 'EX/1610/00005', '50.000000', '<p>ចំណាយថ្លៃរត់ការឯកសារពន្ធដារ</p>', '1', null, '801303', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('6', '2016-10-08 10:45:00', 'EX/1610/00006', '330.000000', '<p>ចំណាយថ្លៃដឹកឡត</p>', '1', null, '500102', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('7', '2016-10-08 11:50:00', 'EX/1610/00007', '2856.580000', '<p>ចំណាយថ្លៃប្រាក់បៀវត្សរ៍ប្រចាំខែ 09/2016</p>', '1', null, '500103', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('8', '2016-10-10 13:45:00', 'EX/1610/00008', '80.375000', '<p>ចំណាថ្លៃថែមម៉ោង</p>', '1', null, '601102', '100102', '3', null, null, '0', '', null);
INSERT INTO `erp_expenses` VALUES ('9', '2016-10-10 08:20:00', 'EX/1610/00009', '2921.475000', '<p>ចំណាយថ្លៃភ្លើងប្រចាំខែ 09/2016</p>', '1', null, '400001', '100102', '3', null, null, '0', '', null);

-- ----------------------------
-- Table structure for erp_expense_categories
-- ----------------------------
DROP TABLE IF EXISTS `erp_expense_categories`;
CREATE TABLE `erp_expense_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_expense_categories
-- ----------------------------

-- ----------------------------
-- Table structure for erp_gift_cards
-- ----------------------------
DROP TABLE IF EXISTS `erp_gift_cards`;
CREATE TABLE `erp_gift_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `card_no` varchar(20) NOT NULL,
  `value` decimal(25,4) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `balance` decimal(25,4) NOT NULL,
  `expiry` date DEFAULT NULL,
  `created_by` varchar(55) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_no` (`card_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_gift_cards
-- ----------------------------

-- ----------------------------
-- Table structure for erp_gl_charts
-- ----------------------------
DROP TABLE IF EXISTS `erp_gl_charts`;
CREATE TABLE `erp_gl_charts` (
  `accountcode` int(11) NOT NULL DEFAULT '0',
  `accountname` varchar(200) DEFAULT '',
  `parent_acc` int(11) DEFAULT '0',
  `sectionid` int(11) DEFAULT '0',
  `account_tax_id` int(11) DEFAULT '0',
  `acc_level` int(11) DEFAULT '0',
  `lineage` varchar(500) NOT NULL,
  `bank` tinyint(1) DEFAULT NULL,
  `value` decimal(55,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`accountcode`),
  KEY `AccountCode` (`accountcode`) USING BTREE,
  KEY `AccountName` (`accountname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_gl_charts
-- ----------------------------
INSERT INTO `erp_gl_charts` VALUES ('100100', 'Cash', '0', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100101', 'Petty Cash', '100100', '10', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100102', 'Cash on Hand', '100100', '10', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100103', 'ANZ Bank', '100100', '10', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100104', 'CAMPU Bank', '100100', '10', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100105', 'Visa', '100100', '10', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100106', 'Chequing Bank Account', '100100', '10', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100200', 'Account Receivable', '0', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100400', 'Other Current Assets', '0', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100410', 'Prepaid Expense', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100420', 'Supplier Deposit', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100430', 'Inventory', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100440', 'Deferred Tax Asset', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100441', 'VAT Input', '100440', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100442', 'VAT Credit Carried Forward', '100440', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100500', 'Cash Advance', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100501', 'Loan to Related Parties', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('100502', 'Staff Advance Cash', '100400', '10', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('101005', 'Own Invest', '0', '80', '0', '0', '', '1', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110200', 'Property, Plant and Equipment', '0', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110201', 'Furniture', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110202', 'Office Equipment', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110203', 'Machineries', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110204', 'Leasehold Improvement', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110205', 'IT Equipment & Computer', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110206', 'Vehicle', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110250', 'Less Total Accumulated Depreciation', '110200', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110251', 'Less Acc. Dep. of Furniture', '110250', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110252', 'Less Acc. Dep. of Office Equipment', '110250', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110253', 'Less Acc. Dep. of Machineries', '110250', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110254', 'Less Acc. Dep. of Leasehold Improvement', '110250', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110255', 'Less Acc. Dep. of IT Equipment & Computer', '110250', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('110256', 'Less Acc. Dep of Vehicle', '110250', '11', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201100', 'Accounts Payable', '0', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201200', 'Other Current Liabilities', '0', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201201', 'Salary Payable', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201202', 'OT Payable', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201203', 'Allowance Payable', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201204', 'Bonus Payable', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201205', 'Commission Payable', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201206', 'Interest Payable', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201207', 'Loan from Related Parties', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201208', 'Customer Deposit', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201209', 'Accrued Expense', '201200', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201400', 'Deferred Tax Liabilities', '0', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201401', 'Salary Tax Payable', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201402', 'Withholding Tax Payable', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201403', 'VAT Payable', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201404', 'Profit Tax Payable', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201405', 'Prepayment Profit Tax Payable', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201406', 'Fringe Benefit Tax Payable', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('201407', 'VAT Output', '201400', '20', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('300000', 'Capital Stock', '0', '30', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('300100', 'Paid-in Capital', '300000', '30', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('300101', 'Additional Paid-in Capital', '300000', '30', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('300200', 'Retained Earnings', '0', '30', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('300300', 'Opening Balance', '0', '30', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('400000', 'Sale Revenue', '0', '40', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('400001', 'Utilities', '0', '60', '0', '0', '6790', '0', '0.00');
INSERT INTO `erp_gl_charts` VALUES ('410101', 'Products', '400000', '40', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('410102', 'Sale Discount', '400000', '40', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('410107', 'Other Income', '400000', '40', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500000', 'Cost of Goods Sold', '0', '50', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500101', 'Products', '500000', '50', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500102', 'Freight Expense', '500000', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500103', 'Wages & Salaries', '500000', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500106', 'Purchase Discount', '500000', '50', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500107', 'Inventory Adjustment', '500000', '50', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('500108', 'Cost of Variance', '500000', '50', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('600000', 'Expenses', '0', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601100', 'Staff Cost', '600000', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601101', 'Salary Expense', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601102', 'OT', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601103', 'Allowance ', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601104', 'Bonus', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601105', 'Commission', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601106', 'Training/Education', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601107', 'Compensation', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601108', 'Other Staff Relation', '601100', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601200', 'Administration Cost', '600000', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601201', 'Rental Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601202', 'Utilities', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601203', 'Marketing & Advertising', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601204', 'Repair & Maintenance', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601205', 'Customer Relation', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601206', 'Transportation', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601207', 'Communication', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601208', 'Insurance Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601209', 'Professional Fee', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601210', 'Depreciation Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601211', 'Amortization Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601212', 'Stationery', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601213', 'Office Supplies', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601214', 'Donation', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601215', 'Entertainment Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601216', 'Travelling & Accomodation', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601217', 'Service Computer Expenses', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601218', 'Interest Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601219', 'Bank Charge', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601220', 'Miscellaneous Expense', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601221', 'Canteen Supplies', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601222', 'Registration Expenses', '601200', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601235', 'Gasoline and Oil Expense', '600000', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601236', 'Medical Care Expense', '801300', '80', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('601237', 'Vehicle and Car Service/Spare Part Expense', '600000', '60', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('710300', 'Other Income', '0', '70', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('710301', 'Interest Income', '710300', '70', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('710302', 'Other Revenue & Gain', '710300', '70', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('801300', 'Other Expenses', '0', '80', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('801301', 'Other Expense & Loss', '801300', '80', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('801302', 'Bad Dept Expense', '801300', '80', '0', '0', '', null, '0.00');
INSERT INTO `erp_gl_charts` VALUES ('801303', 'Tax & Duties Expense', '801300', '80', '0', '0', '', null, '0.00');

-- ----------------------------
-- Table structure for erp_gl_charts_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_gl_charts_tax`;
CREATE TABLE `erp_gl_charts_tax` (
  `account_tax_id` int(11) NOT NULL AUTO_INCREMENT,
  `accountcode` varchar(19) DEFAULT '0',
  `accountname` varchar(200) DEFAULT '',
  `accountname_kh` varchar(250) DEFAULT '0',
  `sectionid` int(11) DEFAULT '0',
  PRIMARY KEY (`account_tax_id`),
  KEY `AccountCode` (`accountcode`) USING BTREE,
  KEY `AccountName` (`accountname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of erp_gl_charts_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_gl_sections
-- ----------------------------
DROP TABLE IF EXISTS `erp_gl_sections`;
CREATE TABLE `erp_gl_sections` (
  `sectionid` int(11) NOT NULL DEFAULT '0',
  `sectionname` text,
  `sectionname_kh` text,
  `AccountType` char(2) DEFAULT NULL,
  `description` text,
  `pandl` int(11) DEFAULT '0',
  `order_stat` int(11) DEFAULT '0',
  PRIMARY KEY (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_gl_sections
-- ----------------------------
INSERT INTO `erp_gl_sections` VALUES ('10', 'CURRENT ASSETS', 'ទ្រព្យសកម្មរយះពេលខ្លី', 'AS', 'CURRENT ASSETS', '0', '10');
INSERT INTO `erp_gl_sections` VALUES ('11', 'FIXED ASSETS', 'ទ្រព្យសកម្មរយះពេលវែង', 'AS', 'FIXED ASSETS', '0', '11');
INSERT INTO `erp_gl_sections` VALUES ('20', 'CURRENT LIABILITIES', 'បំណុលរយះពេលខ្លី', 'LI', 'CURRENT LIABILITIES', '0', '20');
INSERT INTO `erp_gl_sections` VALUES ('21', 'NON-CURRENT LIABILITIES', 'បំណុលរយះពេលវែង', 'LI', 'NON-CURRENT LIABILITIES', '0', '21');
INSERT INTO `erp_gl_sections` VALUES ('30', 'EQUITY AND RETAINED EARNING', 'មូលនិធិ/ទុនម្ចាស់ទ្រព្យ', 'EQ', 'EQUITY AND RETAINED EARNING', '0', '30');
INSERT INTO `erp_gl_sections` VALUES ('40', 'INCOME', 'ចំណូលប្រតិបត្តិការ', 'RE', 'INCOME', '1', '40');
INSERT INTO `erp_gl_sections` VALUES ('50', 'COST OF GOODS SOLD', null, 'CO', 'COST OF GOODS SOLD', '1', '50');
INSERT INTO `erp_gl_sections` VALUES ('60', 'OPERATING EXPENSES', 'ចំណាយប្រតិបត្តិការ', 'EX', 'OPERATING EXPENSES', '1', '60');
INSERT INTO `erp_gl_sections` VALUES ('70', 'OTHER INCOME', 'ចំណូលផ្សេងៗ', 'OI', 'OTHER INCOME', '1', '70');
INSERT INTO `erp_gl_sections` VALUES ('80', 'OTHER EXPENSE', null, 'OX', 'OTHER EXPENSE', '1', '80');
INSERT INTO `erp_gl_sections` VALUES ('90', 'GAIN & LOSS', null, 'GL', 'GAIN & LOSS', '1', '90');

-- ----------------------------
-- Table structure for erp_gl_trans
-- ----------------------------
DROP TABLE IF EXISTS `erp_gl_trans`;
CREATE TABLE `erp_gl_trans` (
  `tran_id` int(11) NOT NULL AUTO_INCREMENT,
  `tran_type` varchar(20) DEFAULT '0',
  `tran_no` bigint(20) NOT NULL DEFAULT '1',
  `tran_date` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `sectionid` int(11) DEFAULT '0',
  `account_code` int(19) DEFAULT '0',
  `narrative` varchar(100) DEFAULT '',
  `amount` decimal(25,2) DEFAULT '0.00',
  `reference_no` varchar(55) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `biller_id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `bank` tinyint(3) DEFAULT '0',
  `gov_tax` tinyint(3) DEFAULT '0',
  `reference_gov_tax` varchar(55) DEFAULT '',
  `people_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`tran_id`),
  KEY `Account` (`account_code`) USING BTREE,
  KEY `TranDate` (`tran_date`) USING BTREE,
  KEY `TypeNo` (`tran_no`) USING BTREE,
  KEY `Type_and_Number` (`tran_type`,`tran_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_gl_trans
-- ----------------------------
INSERT INTO `erp_gl_trans` VALUES ('1', 'JOURNAL', '1', '2016-10-05 01:10:00', '60', '601235', 'Gasoline and Oil Expense', '4.13', 'J/1610/00001', '<p>ចំណាយថ្លៃប្រេងសាំង</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('2', 'JOURNAL', '1', '2016-10-05 01:10:00', '10', '100102', 'Cash on Hand', '-4.13', 'J/1610/00001', '<p>ចំណាយថ្លៃប្រេងសាំង</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('3', 'JOURNAL', '2', '2016-10-05 09:10:00', '60', '601212', 'Stationery', '99.00', 'J/1610/00002', '<p>ចំណាយថ្លៃសម្ភារះការិយាល័យ</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('4', 'JOURNAL', '2', '2016-10-05 09:10:00', '10', '100102', 'Cash on Hand', '-99.00', 'J/1610/00002', '<p>ចំណាយថ្លៃសម្ភារះការិយាល័យ</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('5', 'JOURNAL', '3', '2016-10-05 05:10:00', '60', '601204', 'Repair & Maintenance', '4.00', 'J/1610/00003', '<p xss=removed>ចំណាយថ្លៃសម្ភារះម៉ាស៊ីន</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('6', 'JOURNAL', '3', '2016-10-05 05:10:00', '10', '100102', 'Cash on Hand', '-4.00', 'J/1610/00003', '<p xss=removed>ចំណាយថ្លៃសម្ភារះម៉ាស៊ីន</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('7', 'JOURNAL', '4', '2016-10-05 09:10:00', '10', '100502', 'Staff Advance Cash', '30.00', 'J/1610/00004', '<p>បុរេប្រទានបុគ្គលិកខ្ចីប្រាក់</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('8', 'JOURNAL', '4', '2016-10-05 09:10:00', '10', '100102', 'Cash on Hand', '-30.00', 'J/1610/00004', '<p>បុរេប្រទានបុគ្គលិកខ្ចីប្រាក់</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('9', 'JOURNAL', '5', '2016-10-06 05:10:00', '11', '110203', 'Machineries', '750.00', 'J/1610/00005', '<p xss=removed>ចំណាយថ្លៃកក់ម៉ាស៊ីន</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('10', 'JOURNAL', '5', '2016-10-06 05:10:00', '10', '100102', 'Cash on Hand', '-750.00', 'J/1610/00005', '<p xss=removed>ចំណាយថ្លៃកក់ម៉ាស៊ីន</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('11', 'SALES', '6', '2016-10-03 02:00:00', '10', '100200', 'Account Receivable', '57.50', 'SALE/1610/00001', 'កាំកូរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('12', 'SALES', '6', '2016-10-03 02:00:00', '40', '410101', 'Products', '-57.50', 'SALE/1610/00001', 'កាំកូរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('13', 'SALES', '6', '2016-10-03 02:00:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00001', 'កាំកូរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('14', 'SALES', '6', '2016-10-03 02:00:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00001', 'កាំកូរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('15', 'SALES', '6', '2016-10-03 02:00:00', '10', '100200', 'Account Receivable', '-57.50', 'SALE/1610/00001', 'កាំកូរ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('16', 'SALES', '6', '2016-10-03 02:00:00', '10', '100102', 'Cash on Hand', '57.50', 'SALE/1610/00001', 'កាំកូរ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('17', 'SALES', '7', '2016-10-03 02:10:00', '10', '100200', 'Account Receivable', '0.00', 'SALE/1610/00002', '<p>កាំកូរ</p> (Cancelled)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('18', 'SALES', '7', '2016-10-03 02:10:00', '40', '410101', 'Products', '0.00', 'SALE/1610/00002', '<p>កាំកូរ</p> (Cancelled)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('19', 'SALES', '7', '2016-10-03 02:10:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00002', '<p>កាំកូរ</p> (Cancelled)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('20', 'SALES', '7', '2016-10-03 02:10:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00002', '<p>កាំកូរ</p> (Cancelled)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('21', 'SALES', '7', '2016-10-03 02:10:00', '10', '100200', 'Account Receivable', '0.00', 'SALE/1610/00002', '<p>កាំកូរ</p> (Cancelled)', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('22', 'SALES', '7', '2016-10-03 02:10:00', '10', '100102', 'Cash on Hand', '0.00', 'SALE/1610/00002', '<p>កាំកូរ</p> (Cancelled)', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('23', 'JOURNAL', '8', '2016-10-06 09:25:00', '60', '601235', 'Gasoline and Oil Expense', '2.25', 'EX/1610/00001', '<p>ចំនាយថ្លៃប្រេងសាំង</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('24', 'JOURNAL', '8', '2016-10-06 09:25:00', '10', '100102', 'Cash on Hand', '-2.25', 'EX/1610/00001', '<p>ចំនាយថ្លៃប្រេងសាំង</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('25', 'JOURNAL', '9', '2016-10-06 10:25:00', '60', '601220', 'Miscellaneous Expense', '1.25', 'EX/1610/00002', '<p>ចំណាយថ្លៃប៉ូលីសផាកពិន័យ</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('26', 'JOURNAL', '9', '2016-10-06 10:25:00', '10', '100102', 'Cash on Hand', '-1.25', 'EX/1610/00002', '<p>ចំណាយថ្លៃប៉ូលីសផាកពិន័យ</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('27', 'JOURNAL', '10', '2016-10-06 09:05:00', '60', '601204', 'Repair & Maintenance', '40.00', 'EX/1610/00003', '<p>ចំណាយថ្លទិញសម្ភារះម៉ាស៊ីន</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('28', 'JOURNAL', '10', '2016-10-06 09:05:00', '10', '100102', 'Cash on Hand', '-40.00', 'EX/1610/00003', '<p>ចំណាយថ្លទិញសម្ភារះម៉ាស៊ីន</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('29', 'JOURNAL', '11', '2016-10-07 09:25:00', '60', '500102', 'Freight Expense', '697.00', 'EX/1610/00004', '<p>ចំណាយថ្លៃដឹកឡត</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('30', 'JOURNAL', '11', '2016-10-07 09:25:00', '10', '100102', 'Cash on Hand', '-697.00', 'EX/1610/00004', '<p>ចំណាយថ្លៃដឹកឡត</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('31', 'JOURNAL', '12', '2016-10-07 10:25:00', '80', '801303', 'Tax & Duties Expense', '50.00', 'EX/1610/00005', '<p>ចំណាយថ្លៃរត់ការឯកសារពន្ធដារ</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('32', 'JOURNAL', '12', '2016-10-07 10:25:00', '10', '100102', 'Cash on Hand', '-50.00', 'EX/1610/00005', '<p>ចំណាយថ្លៃរត់ការឯកសារពន្ធដារ</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('33', 'JOURNAL', '13', '2016-10-08 09:10:00', '10', '100502', 'Staff Advance Cash', '110.00', 'J/1610/00013', '<p>បុរេប្រទានបុគ្គលិកខ្ចីប្រាក់</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('34', 'JOURNAL', '13', '2016-10-08 09:10:00', '10', '100102', 'Cash on Hand', '-110.00', 'J/1610/00013', '<p>បុរេប្រទានបុគ្គលិកខ្ចីប្រាក់</p>', '0', null, null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('35', 'JOURNAL', '14', '2016-10-08 10:45:00', '60', '500102', 'Freight Expense', '330.00', 'EX/1610/00006', '<p>ចំណាយថ្លៃដឹកឡត</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('36', 'JOURNAL', '14', '2016-10-08 10:45:00', '10', '100102', 'Cash on Hand', '-330.00', 'EX/1610/00006', '<p>ចំណាយថ្លៃដឹកឡត</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('37', 'JOURNAL', '15', '2016-10-08 11:50:00', '60', '500103', 'Wages & Salaries', '2856.58', 'EX/1610/00007', '<p>ចំណាយថ្លៃប្រាក់បៀវត្សរ៍ប្រចាំខែ 09/2016</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('38', 'JOURNAL', '15', '2016-10-08 11:50:00', '10', '100102', 'Cash on Hand', '-2856.58', 'EX/1610/00007', '<p>ចំណាយថ្លៃប្រាក់បៀវត្សរ៍ប្រចាំខែ 09/2016</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('39', 'JOURNAL', '16', '2016-10-10 13:45:00', '60', '601102', 'OT', '80.38', 'EX/1610/00008', '<p>ចំណាថ្លៃថែមម៉ោង</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('40', 'JOURNAL', '16', '2016-10-10 13:45:00', '10', '100102', 'Cash on Hand', '-80.38', 'EX/1610/00008', '<p>ចំណាថ្លៃថែមម៉ោង</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('41', 'JOURNAL', '17', '2016-10-10 08:20:00', '60', '400001', 'Utilities', '2921.48', 'EX/1610/00009', '<p>ចំណាយថ្លៃភ្លើងប្រចាំខែ 09/2016</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('42', 'JOURNAL', '17', '2016-10-10 08:20:00', '10', '100102', 'Cash on Hand', '-2921.48', 'EX/1610/00009', '<p>ចំណាយថ្លៃភ្លើងប្រចាំខែ 09/2016</p>', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('43', 'PURCHASES', '0', '2016-10-06 15:46:00', '10', '100430', 'Inventory', '1550.00', 'PO/1610/00006', 'Supplier Company Name', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('44', 'PURCHASES', '0', '2016-10-06 15:46:00', '20', '201100', 'Accounts Payable', '-1550.00', 'PO/1610/00006', 'Supplier Company Name', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('45', 'SALES', '18', '2016-10-05 06:25:00', '10', '100200', 'Account Receivable', '150.00', 'SALE/1610/00003', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('46', 'SALES', '18', '2016-10-05 06:25:00', '40', '410101', 'Products', '-150.00', 'SALE/1610/00003', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('47', 'SALES', '18', '2016-10-05 06:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00003', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('48', 'SALES', '18', '2016-10-05 06:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00003', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('49', 'SALES', '19', '2016-10-05 15:25:00', '10', '100200', 'Account Receivable', '82.75', 'SALE/1610/00004', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('50', 'SALES', '19', '2016-10-05 15:25:00', '40', '410101', 'Products', '-82.75', 'SALE/1610/00004', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('51', 'SALES', '19', '2016-10-05 15:25:00', '50', '500101', 'Products', '0.98', 'SALE/1610/00004', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('52', 'SALES', '19', '2016-10-05 15:25:00', '10', '100430', 'Inventory', '-0.98', 'SALE/1610/00004', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('53', 'SALES', '19', '2016-10-05 15:25:00', '10', '100200', 'Account Receivable', '-82.75', 'SALE/1610/00004', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('54', 'SALES', '19', '2016-10-05 15:25:00', '10', '100102', 'Cash on Hand', '82.75', 'SALE/1610/00004', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('55', 'SALES', '20', '2016-10-05 10:25:00', '10', '100200', 'Account Receivable', '39.50', 'SALE/1610/00005', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('56', 'SALES', '20', '2016-10-05 10:25:00', '40', '410101', 'Products', '-39.50', 'SALE/1610/00005', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('57', 'SALES', '20', '2016-10-05 10:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00005', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('58', 'SALES', '20', '2016-10-05 10:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00005', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('59', 'SALES', '20', '2016-10-05 10:25:00', '10', '100200', 'Account Receivable', '-39.50', 'SALE/1610/00005', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('60', 'SALES', '20', '2016-10-05 10:25:00', '10', '100102', 'Cash on Hand', '39.50', 'SALE/1610/00005', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('61', 'SALES', '21', '2016-10-05 10:25:00', '10', '100200', 'Account Receivable', '45.50', 'SALE/1610/00006', 'OKកាហ្វេ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('62', 'SALES', '21', '2016-10-05 10:25:00', '40', '410101', 'Products', '-45.50', 'SALE/1610/00006', 'OKកាហ្វេ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('63', 'SALES', '21', '2016-10-05 10:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00006', 'OKកាហ្វេ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('64', 'SALES', '21', '2016-10-05 10:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00006', 'OKកាហ្វេ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('65', 'SALES', '21', '2016-10-05 10:25:00', '10', '100200', 'Account Receivable', '-45.50', 'SALE/1610/00006', 'OKកាហ្វេ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('66', 'SALES', '21', '2016-10-05 10:25:00', '10', '100102', 'Cash on Hand', '45.50', 'SALE/1610/00006', 'OKកាហ្វេ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('67', 'SALES', '22', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '180.00', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('68', 'SALES', '22', '2016-10-05 09:25:00', '40', '410101', 'Products', '-180.00', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('69', 'SALES', '22', '2016-10-05 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('70', 'SALES', '22', '2016-10-05 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('71', 'SALES', '22', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '-180.00', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('72', 'SALES', '22', '2016-10-05 09:25:00', '10', '100102', 'Cash on Hand', '180.00', 'SALE/1610/00007', 'អាមួយបឺងសាឡាង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('73', 'SALES', '23', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '35.00', 'SALE/1610/00008', 'ចែធីតាទួលគោក', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('74', 'SALES', '23', '2016-10-05 09:25:00', '40', '410101', 'Products', '-35.00', 'SALE/1610/00008', 'ចែធីតាទួលគោក', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('75', 'SALES', '23', '2016-10-05 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00008', 'ចែធីតាទួលគោក', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('76', 'SALES', '23', '2016-10-05 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00008', 'ចែធីតាទួលគោក', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('77', 'SALES', '23', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '-35.00', 'SALE/1610/00008', 'ចែធីតាទួលគោក', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('78', 'SALES', '23', '2016-10-05 09:25:00', '10', '100102', 'Cash on Hand', '35.00', 'SALE/1610/00008', 'ចែធីតាទួលគោក', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('79', 'SALES', '24', '2016-10-05 09:45:00', '10', '100200', 'Account Receivable', '96.00', 'SALE/1610/00009', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('80', 'SALES', '24', '2016-10-05 09:45:00', '40', '410101', 'Products', '-96.00', 'SALE/1610/00009', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('81', 'SALES', '24', '2016-10-05 09:45:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00009', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('82', 'SALES', '24', '2016-10-05 09:45:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00009', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('83', 'SALES', '24', '2016-10-05 09:45:00', '10', '100200', 'Account Receivable', '-96.00', 'SALE/1610/00009', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('84', 'SALES', '24', '2016-10-05 09:45:00', '10', '100102', 'Cash on Hand', '96.00', 'SALE/1610/00009', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('85', 'SALES', '25', '2016-10-05 10:25:00', '10', '100200', 'Account Receivable', '65.00', 'SALE/1610/00010', 'អង្គតាមិុញ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('86', 'SALES', '25', '2016-10-05 10:25:00', '40', '410101', 'Products', '-65.00', 'SALE/1610/00010', 'អង្គតាមិុញ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('87', 'SALES', '25', '2016-10-05 10:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00010', 'អង្គតាមិុញ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('88', 'SALES', '25', '2016-10-05 10:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00010', 'អង្គតាមិុញ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('89', 'SALES', '25', '2016-10-05 10:25:00', '10', '100200', 'Account Receivable', '-65.00', 'SALE/1610/00010', 'អង្គតាមិុញ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('90', 'SALES', '25', '2016-10-05 10:25:00', '10', '100102', 'Cash on Hand', '65.00', 'SALE/1610/00010', 'អង្គតាមិុញ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('91', 'SALES', '26', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '105.00', 'SALE/1610/00011', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('92', 'SALES', '26', '2016-10-05 09:25:00', '40', '410101', 'Products', '-105.00', 'SALE/1610/00011', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('93', 'SALES', '26', '2016-10-05 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00011', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('94', 'SALES', '26', '2016-10-05 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00011', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('95', 'SALES', '26', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '-105.00', 'SALE/1610/00011', 'កំពង់ស្ពឺ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('96', 'SALES', '26', '2016-10-05 09:25:00', '10', '100102', 'Cash on Hand', '105.00', 'SALE/1610/00011', 'កំពង់ស្ពឺ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('97', 'SALES', '27', '2016-10-05 10:30:00', '10', '100200', 'Account Receivable', '17.00', 'SALE/1610/00012', 'បងឌីkm4', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('98', 'SALES', '27', '2016-10-05 10:30:00', '40', '410101', 'Products', '-17.00', 'SALE/1610/00012', 'បងឌីkm4', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('99', 'SALES', '27', '2016-10-05 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00012', 'បងឌីkm4', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('100', 'SALES', '27', '2016-10-05 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00012', 'បងឌីkm4', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('101', 'SALES', '28', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '114.00', 'SALE/1610/00013', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('102', 'SALES', '28', '2016-10-05 09:25:00', '40', '410101', 'Products', '-114.00', 'SALE/1610/00013', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('103', 'SALES', '28', '2016-10-05 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00013', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('104', 'SALES', '28', '2016-10-05 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00013', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('105', 'SALES', '28', '2016-10-05 09:25:00', '10', '100200', 'Account Receivable', '-114.00', 'SALE/1610/00013', 'កោសដូង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('106', 'SALES', '28', '2016-10-05 09:25:00', '10', '100102', 'Cash on Hand', '114.00', 'SALE/1610/00013', 'កោសដូង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('107', 'SALES', '29', '2016-10-05 05:25:00', '10', '100200', 'Account Receivable', '823.20', 'SALE/1610/00014', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('108', 'SALES', '29', '2016-10-05 05:25:00', '40', '410101', 'Products', '-823.20', 'SALE/1610/00014', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('109', 'SALES', '29', '2016-10-05 05:25:00', '50', '500101', 'Products', '72.24', 'SALE/1610/00014', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('110', 'SALES', '29', '2016-10-05 05:25:00', '10', '100430', 'Inventory', '-72.24', 'SALE/1610/00014', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('111', 'SALES', '30', '2016-10-05 10:45:00', '10', '100200', 'Account Receivable', '750.00', 'SALE/1610/00015', 'សំណង់12', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('112', 'SALES', '30', '2016-10-05 10:45:00', '40', '410101', 'Products', '-750.00', 'SALE/1610/00015', 'សំណង់12', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('113', 'SALES', '30', '2016-10-05 10:45:00', '50', '500101', 'Products', '154.80', 'SALE/1610/00015', 'សំណង់12', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('114', 'SALES', '30', '2016-10-05 10:45:00', '10', '100430', 'Inventory', '-154.80', 'SALE/1610/00015', 'សំណង់12', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('115', 'SALES', '31', '2016-10-06 09:25:00', '10', '100200', 'Account Receivable', '-750.00', 'SALE/1610/00015', 'សំណង់12', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('116', 'SALES', '31', '2016-10-06 09:25:00', '10', '100102', 'Cash on Hand', '750.00', 'SALE/1610/00015', 'សំណង់12', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('117', 'SALES', '32', '2016-10-06 10:30:00', '10', '100200', 'Account Receivable', '31.00', 'SALE/1610/00016', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('118', 'SALES', '32', '2016-10-06 10:30:00', '40', '410101', 'Products', '-31.00', 'SALE/1610/00016', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('119', 'SALES', '32', '2016-10-06 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00016', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('120', 'SALES', '32', '2016-10-06 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00016', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('121', 'SALES', '32', '2016-10-06 10:30:00', '10', '100200', 'Account Receivable', '-31.00', 'SALE/1610/00016', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('122', 'SALES', '32', '2016-10-06 10:30:00', '10', '100102', 'Cash on Hand', '31.00', 'SALE/1610/00016', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('123', 'SALES', '33', '2016-10-06 10:30:00', '10', '100200', 'Account Receivable', '652.00', 'SALE/1610/00017', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('124', 'SALES', '33', '2016-10-06 10:30:00', '40', '410101', 'Products', '-652.00', 'SALE/1610/00017', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('125', 'SALES', '33', '2016-10-06 10:30:00', '50', '500101', 'Products', '94.94', 'SALE/1610/00017', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('126', 'SALES', '33', '2016-10-06 10:30:00', '10', '100430', 'Inventory', '-94.94', 'SALE/1610/00017', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('127', 'SALES', '34', '2016-10-06 06:30:00', '10', '100200', 'Account Receivable', '37.50', 'SALE/1610/00018', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('128', 'SALES', '34', '2016-10-06 06:30:00', '40', '410101', 'Products', '-37.50', 'SALE/1610/00018', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('129', 'SALES', '34', '2016-10-06 06:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00018', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('130', 'SALES', '34', '2016-10-06 06:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00018', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('131', 'SALES', '34', '2016-10-06 06:30:00', '10', '100200', 'Account Receivable', '-37.50', 'SALE/1610/00018', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('132', 'SALES', '34', '2016-10-06 06:30:00', '10', '100102', 'Cash on Hand', '37.50', 'SALE/1610/00018', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('133', 'SALES', '35', '2016-10-06 10:45:00', '10', '100200', 'Account Receivable', '42.00', 'SALE/1610/00019', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('134', 'SALES', '35', '2016-10-06 10:45:00', '40', '410101', 'Products', '-42.00', 'SALE/1610/00019', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('135', 'SALES', '35', '2016-10-06 10:45:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00019', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('136', 'SALES', '35', '2016-10-06 10:45:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00019', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('137', 'SALES', '35', '2016-10-06 10:45:00', '10', '100200', 'Account Receivable', '-42.00', 'SALE/1610/00019', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('138', 'SALES', '35', '2016-10-06 10:45:00', '10', '100102', 'Cash on Hand', '42.00', 'SALE/1610/00019', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('139', 'SALES', '36', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '32.50', 'SALE/1610/00020', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('140', 'SALES', '36', '2016-10-07 10:30:00', '40', '410101', 'Products', '-32.50', 'SALE/1610/00020', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('141', 'SALES', '36', '2016-10-07 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00020', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('142', 'SALES', '36', '2016-10-07 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00020', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('143', 'SALES', '36', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '-32.50', 'SALE/1610/00020', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('144', 'SALES', '36', '2016-10-07 10:30:00', '10', '100102', 'Cash on Hand', '32.50', 'SALE/1610/00020', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('145', 'SALES', '37', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '71.50', 'SALE/1610/00021', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('146', 'SALES', '37', '2016-10-07 10:30:00', '40', '410101', 'Products', '-71.50', 'SALE/1610/00021', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('147', 'SALES', '37', '2016-10-07 10:30:00', '50', '500101', 'Products', '1.03', 'SALE/1610/00021', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('148', 'SALES', '37', '2016-10-07 10:30:00', '10', '100430', 'Inventory', '-1.03', 'SALE/1610/00021', 'កោសដូង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('149', 'SALES', '37', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '-71.50', 'SALE/1610/00021', 'កោសដូង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('150', 'SALES', '37', '2016-10-07 10:30:00', '10', '100102', 'Cash on Hand', '71.50', 'SALE/1610/00021', 'កោសដូង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('156', 'SALES', '39', '2016-10-07 06:25:00', '10', '100200', 'Account Receivable', '70.00', 'SALE/1610/00023', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('157', 'SALES', '39', '2016-10-07 06:25:00', '40', '410101', 'Products', '-70.00', 'SALE/1610/00023', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('158', 'SALES', '39', '2016-10-07 06:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00023', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('159', 'SALES', '39', '2016-10-07 06:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00023', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('160', 'SALES', '40', '2016-10-07 06:30:00', '10', '100200', 'Account Receivable', '23.50', 'SALE/1610/00024', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('161', 'SALES', '40', '2016-10-07 06:30:00', '40', '410101', 'Products', '-23.50', 'SALE/1610/00024', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('162', 'SALES', '40', '2016-10-07 06:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00024', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('163', 'SALES', '40', '2016-10-07 06:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00024', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('164', 'SALES', '40', '2016-10-07 06:30:00', '10', '100200', 'Account Receivable', '-23.50', 'SALE/1610/00024', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('165', 'SALES', '40', '2016-10-07 06:30:00', '10', '100102', 'Cash on Hand', '23.50', 'SALE/1610/00024', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('166', 'SALES', '41', '2016-10-07 10:25:00', '10', '100200', 'Account Receivable', '304.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('167', 'SALES', '41', '2016-10-07 10:25:00', '40', '410101', 'Products', '-349.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('168', 'SALES', '41', '2016-10-07 10:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('169', 'SALES', '41', '2016-10-07 10:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('170', 'SALES', '41', '2016-10-07 10:25:00', '40', '410102', 'Sale Discount', '45.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('171', 'SALES', '41', '2016-10-07 10:25:00', '10', '100200', 'Account Receivable', '-304.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('172', 'SALES', '41', '2016-10-07 10:25:00', '10', '100102', 'Cash on Hand', '304.00', 'SALE/1610/00025', 'អាមួយបឺងសាឡាង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('177', 'SALES', '42', '2016-10-11 16:04:00', '10', '100200', 'Account Receivable', '-162.00', 'SALE/1610/00026', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('178', 'SALES', '42', '2016-10-11 16:04:00', '10', '100102', 'Cash on Hand', '162.00', 'SALE/1610/00026', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('179', 'SALES', '43', '2016-10-07 10:25:00', '10', '100200', 'Account Receivable', '32.50', 'SALE/1610/00027', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('180', 'SALES', '43', '2016-10-07 10:25:00', '40', '410101', 'Products', '-32.50', 'SALE/1610/00027', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('181', 'SALES', '43', '2016-10-07 10:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00027', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('182', 'SALES', '43', '2016-10-07 10:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00027', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('183', 'SALES', '43', '2016-10-07 10:25:00', '10', '100200', 'Account Receivable', '-32.50', 'SALE/1610/00027', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('184', 'SALES', '43', '2016-10-07 10:25:00', '10', '100102', 'Cash on Hand', '32.50', 'SALE/1610/00027', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('185', 'SALES', '44', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '363.00', 'SALE/1610/00028', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('186', 'SALES', '44', '2016-10-07 10:30:00', '40', '410101', 'Products', '-408.00', 'SALE/1610/00028', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('187', 'SALES', '44', '2016-10-07 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00028', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('188', 'SALES', '44', '2016-10-07 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00028', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('189', 'SALES', '44', '2016-10-07 10:30:00', '40', '410102', 'Sale Discount', '45.00', 'SALE/1610/00028', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('190', 'SALES', '44', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '-363.00', 'SALE/1610/00028', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('191', 'SALES', '44', '2016-10-07 10:30:00', '10', '100102', 'Cash on Hand', '363.00', 'SALE/1610/00028', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('192', 'SALES', '45', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '847.72', 'SALE/1610/00029', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('193', 'SALES', '45', '2016-10-07 10:30:00', '40', '410101', 'Products', '-847.72', 'SALE/1610/00029', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('194', 'SALES', '45', '2016-10-07 10:30:00', '50', '500101', 'Products', '48.50', 'SALE/1610/00029', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('195', 'SALES', '45', '2016-10-07 10:30:00', '10', '100430', 'Inventory', '-48.50', 'SALE/1610/00029', 'ចឹកគឺkm6', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('196', 'SALES', '45', '2016-10-07 10:30:00', '10', '100200', 'Account Receivable', '-847.72', 'SALE/1610/00029', 'ចឹកគឺkm6', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('197', 'SALES', '45', '2016-10-07 10:30:00', '10', '100102', 'Cash on Hand', '847.72', 'SALE/1610/00029', 'ចឹកគឺkm6', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('198', 'SALES', '46', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '1500.00', 'SALE/1610/00030', 'ពារាំង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('199', 'SALES', '46', '2016-10-08 10:30:00', '40', '410101', 'Products', '-1500.00', 'SALE/1610/00030', 'ពារាំង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('200', 'SALES', '46', '2016-10-08 10:30:00', '50', '500101', 'Products', '309.60', 'SALE/1610/00030', 'ពារាំង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('201', 'SALES', '46', '2016-10-08 10:30:00', '10', '100430', 'Inventory', '-309.60', 'SALE/1610/00030', 'ពារាំង', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('202', 'SALES', '46', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '-1500.00', 'SALE/1610/00030', 'ពារាំង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('203', 'SALES', '46', '2016-10-08 10:30:00', '10', '100102', 'Cash on Hand', '1500.00', 'SALE/1610/00030', 'ពារាំង', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('204', 'SALES', '47', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '587.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('205', 'SALES', '47', '2016-10-08 10:30:00', '40', '410101', 'Products', '-677.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('206', 'SALES', '47', '2016-10-08 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('207', 'SALES', '47', '2016-10-08 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('208', 'SALES', '47', '2016-10-08 10:30:00', '40', '410102', 'Sale Discount', '90.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('209', 'SALES', '47', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '-587.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('210', 'SALES', '47', '2016-10-08 10:30:00', '10', '100102', 'Cash on Hand', '587.00', 'SALE/1610/00031', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('211', 'SALES', '48', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '32.50', 'SALE/1610/00032', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('212', 'SALES', '48', '2016-10-08 10:30:00', '40', '410101', 'Products', '-32.50', 'SALE/1610/00032', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('213', 'SALES', '48', '2016-10-08 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00032', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('214', 'SALES', '48', '2016-10-08 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00032', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('215', 'SALES', '48', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '-32.50', 'SALE/1610/00032', 'ផ្សារដើមគរ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('216', 'SALES', '48', '2016-10-08 10:30:00', '10', '100102', 'Cash on Hand', '32.50', 'SALE/1610/00032', 'ផ្សារដើមគរ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('217', 'SALES', '49', '2016-10-08 11:30:00', '10', '100200', 'Account Receivable', '32.50', 'SALE/1610/00033', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('218', 'SALES', '49', '2016-10-08 11:30:00', '40', '410101', 'Products', '-32.50', 'SALE/1610/00033', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('219', 'SALES', '49', '2016-10-08 11:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00033', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('220', 'SALES', '49', '2016-10-08 11:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00033', 'ផ្សារដើមគរ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('221', 'SALES', '49', '2016-10-08 11:30:00', '10', '100200', 'Account Receivable', '-32.50', 'SALE/1610/00033', 'ផ្សារដើមគរ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('222', 'SALES', '49', '2016-10-08 11:30:00', '10', '100102', 'Cash on Hand', '32.50', 'SALE/1610/00033', 'ផ្សារដើមគរ', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('223', 'SALES', '50', '2016-10-08 10:25:00', '10', '100200', 'Account Receivable', '45.50', 'SALE/1610/00034', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('224', 'SALES', '50', '2016-10-08 10:25:00', '40', '410101', 'Products', '-45.50', 'SALE/1610/00034', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('225', 'SALES', '50', '2016-10-08 10:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00034', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('226', 'SALES', '50', '2016-10-08 10:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00034', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('227', 'SALES', '50', '2016-10-08 10:25:00', '10', '100200', 'Account Receivable', '-45.50', 'SALE/1610/00034', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('228', 'SALES', '50', '2016-10-08 10:25:00', '10', '100102', 'Cash on Hand', '45.50', 'SALE/1610/00034', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('233', 'SALES', '42', '2016-10-08 09:25:00', '40', '410101', 'Products', '-162.00', 'SALE/1610/00026', 'General', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('234', 'SALES', '42', '2016-10-08 09:25:00', '10', '100200', 'Account Receivable', '162.00', 'SALE/1610/00026', 'General', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('235', 'SALES', '42', '2016-10-08 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00026', 'General', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('236', 'SALES', '42', '2016-10-08 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00026', 'General', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('237', 'SALES', '38', '2016-10-08 06:30:00', '40', '410101', 'Products', '-590.00', 'SALE/1610/00022', 'ពូវណ្ណាស្ពានទី10', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('238', 'SALES', '38', '2016-10-08 06:30:00', '10', '100200', 'Account Receivable', '500.00', 'SALE/1610/00022', 'ពូវណ្ណាស្ពានទី10', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('239', 'SALES', '38', '2016-10-08 06:30:00', '50', '500101', 'Products', '103.20', 'SALE/1610/00022', 'ពូវណ្ណាស្ពានទី10', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('240', 'SALES', '38', '2016-10-08 06:30:00', '10', '100430', 'Inventory', '-103.20', 'SALE/1610/00022', 'ពូវណ្ណាស្ពានទី10', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('241', 'SALES', '38', '2016-10-08 06:30:00', '40', '410102', 'Sale Discount', '90.00', 'SALE/1610/00022', 'ពូវណ្ណាស្ពានទី10', '3', '1', '1', '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('242', 'SALES', '51', '2016-10-08 10:30:00', '10', '100200', 'Account Receivable', '3530.00', 'SALE/1610/00035', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('243', 'SALES', '51', '2016-10-08 10:30:00', '40', '410101', 'Products', '-3660.00', 'SALE/1610/00035', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('244', 'SALES', '51', '2016-10-08 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00035', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('245', 'SALES', '51', '2016-10-08 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00035', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('246', 'SALES', '51', '2016-10-08 10:30:00', '40', '410102', 'Sale Discount', '130.00', 'SALE/1610/00035', 'កំពង់ស្ពឺ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('247', 'SALES', '52', '2016-10-08 06:30:00', '10', '100200', 'Account Receivable', '680.00', 'SALE/1610/00036', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('248', 'SALES', '52', '2016-10-08 06:30:00', '40', '410101', 'Products', '-680.00', 'SALE/1610/00036', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('249', 'SALES', '52', '2016-10-08 06:30:00', '50', '500101', 'Products', '87.72', 'SALE/1610/00036', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('250', 'SALES', '52', '2016-10-08 06:30:00', '10', '100430', 'Inventory', '-87.72', 'SALE/1610/00036', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('251', 'SALES', '53', '2016-10-09 10:30:00', '10', '100200', 'Account Receivable', '325.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('252', 'SALES', '53', '2016-10-09 10:30:00', '40', '410101', 'Products', '-370.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('253', 'SALES', '53', '2016-10-09 10:30:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('254', 'SALES', '53', '2016-10-09 10:30:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('255', 'SALES', '53', '2016-10-09 10:30:00', '40', '410102', 'Sale Discount', '45.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('256', 'SALES', '53', '2016-10-09 10:30:00', '10', '100200', 'Account Receivable', '-325.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('257', 'SALES', '53', '2016-10-09 10:30:00', '10', '100102', 'Cash on Hand', '325.00', 'SALE/1610/00037', 'ផ្សារទឹកថ្លា', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('258', 'SALES', '54', '2016-10-09 10:30:00', '10', '100200', 'Account Receivable', '74.00', 'SALE/1610/00038', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('259', 'SALES', '54', '2016-10-09 10:30:00', '40', '410101', 'Products', '-74.00', 'SALE/1610/00038', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('260', 'SALES', '54', '2016-10-09 10:30:00', '50', '500101', 'Products', '10.32', 'SALE/1610/00038', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('261', 'SALES', '54', '2016-10-09 10:30:00', '10', '100430', 'Inventory', '-10.32', 'SALE/1610/00038', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('262', 'SALES', '54', '2016-10-09 10:30:00', '10', '100200', 'Account Receivable', '-74.00', 'SALE/1610/00038', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('263', 'SALES', '54', '2016-10-09 10:30:00', '10', '100102', 'Cash on Hand', '74.00', 'SALE/1610/00038', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('264', 'SALES', '55', '2016-10-09 09:25:00', '10', '100200', 'Account Receivable', '300.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('265', 'SALES', '55', '2016-10-09 09:25:00', '40', '410101', 'Products', '-345.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('266', 'SALES', '55', '2016-10-09 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('267', 'SALES', '55', '2016-10-09 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('268', 'SALES', '55', '2016-10-09 09:25:00', '40', '410102', 'Sale Discount', '45.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('269', 'SALES', '55', '2016-10-09 09:25:00', '10', '100200', 'Account Receivable', '-300.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('270', 'SALES', '55', '2016-10-09 09:25:00', '10', '100102', 'Cash on Hand', '300.00', 'SALE/1610/00039', 'ចែ ជិនជួវី', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('271', 'SALES', '56', '2016-10-09 09:25:00', '10', '100200', 'Account Receivable', '189.00', 'SALE/1610/00040', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('272', 'SALES', '56', '2016-10-09 09:25:00', '40', '410101', 'Products', '-189.00', 'SALE/1610/00040', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('273', 'SALES', '56', '2016-10-09 09:25:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00040', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('274', 'SALES', '56', '2016-10-09 09:25:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00040', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('275', 'SALES', '57', '2016-10-09 09:20:00', '10', '100200', 'Account Receivable', '115.00', 'SALE/1610/00041', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('276', 'SALES', '57', '2016-10-09 09:20:00', '40', '410101', 'Products', '-115.00', 'SALE/1610/00041', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('277', 'SALES', '57', '2016-10-09 09:20:00', '50', '500101', 'Products', '0.00', 'SALE/1610/00041', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('278', 'SALES', '57', '2016-10-09 09:20:00', '10', '100430', 'Inventory', '0.00', 'SALE/1610/00041', 'General', '3', '1', null, '0', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('279', 'SALES', '57', '2016-10-09 09:20:00', '10', '100200', 'Account Receivable', '-115.00', 'SALE/1610/00041', 'General', '3', '1', null, '1', '0', '', null);
INSERT INTO `erp_gl_trans` VALUES ('280', 'SALES', '57', '2016-10-09 09:20:00', '10', '100102', 'Cash on Hand', '115.00', 'SALE/1610/00041', 'General', '3', '1', null, '1', '0', '', null);

-- ----------------------------
-- Table structure for erp_groups
-- ----------------------------
DROP TABLE IF EXISTS `erp_groups`;
CREATE TABLE `erp_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_groups
-- ----------------------------
INSERT INTO `erp_groups` VALUES ('1', 'owner', 'Owner');
INSERT INTO `erp_groups` VALUES ('2', 'admin', 'Administrator');
INSERT INTO `erp_groups` VALUES ('3', 'sales', 'Saller');
INSERT INTO `erp_groups` VALUES ('4', 'stock', 'Stock Manager');
INSERT INTO `erp_groups` VALUES ('5', 'cashier', 'Cashier');
INSERT INTO `erp_groups` VALUES ('6', 'accounting', 'Accoiunting');

-- ----------------------------
-- Table structure for erp_loans
-- ----------------------------
DROP TABLE IF EXISTS `erp_loans`;
CREATE TABLE `erp_loans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `period` smallint(6) NOT NULL,
  `dateline` date NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `reference_no` varchar(50) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `rated` varchar(255) DEFAULT NULL,
  `payment` decimal(25,10) NOT NULL,
  `principle` decimal(25,10) NOT NULL,
  `interest` decimal(25,10) NOT NULL,
  `balance` decimal(25,10) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `paid_by` varchar(50) DEFAULT NULL,
  `paid_amount` decimal(25,4) NOT NULL,
  `paid_date` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `account_code` varchar(20) DEFAULT NULL,
  `bank_code` varchar(20) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `updated_by` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_loans
-- ----------------------------

-- ----------------------------
-- Table structure for erp_login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `erp_login_attempts`;
CREATE TABLE `erp_login_attempts` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_login_attempts
-- ----------------------------

-- ----------------------------
-- Table structure for erp_marchine
-- ----------------------------
DROP TABLE IF EXISTS `erp_marchine`;
CREATE TABLE `erp_marchine` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `type` varchar(20) DEFAULT '0',
  `biller_id` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `13` int(11) DEFAULT '0',
  `15` int(11) DEFAULT '0',
  `25` int(11) DEFAULT '0',
  `30` int(11) DEFAULT '0',
  `50` int(11) DEFAULT '0',
  `60` int(11) DEFAULT '0',
  `76` int(11) DEFAULT '0',
  `80` int(11) DEFAULT '0',
  `100` int(11) DEFAULT '0',
  `120` int(11) DEFAULT '0',
  `150` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_marchine
-- ----------------------------

-- ----------------------------
-- Table structure for erp_marchine_logs
-- ----------------------------
DROP TABLE IF EXISTS `erp_marchine_logs`;
CREATE TABLE `erp_marchine_logs` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `marchine_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `old_number` int(11) DEFAULT NULL,
  `new_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_marchine_logs
-- ----------------------------

-- ----------------------------
-- Table structure for erp_migrations
-- ----------------------------
DROP TABLE IF EXISTS `erp_migrations`;
CREATE TABLE `erp_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_migrations
-- ----------------------------
INSERT INTO `erp_migrations` VALUES ('312');

-- ----------------------------
-- Table structure for erp_notifications
-- ----------------------------
DROP TABLE IF EXISTS `erp_notifications`;
CREATE TABLE `erp_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_date` datetime DEFAULT NULL,
  `till_date` datetime DEFAULT NULL,
  `scope` tinyint(1) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_notifications
-- ----------------------------
INSERT INTO `erp_notifications` VALUES ('1', '<p>Thank you for using iCloudERP - POS. If you find any error/bug, please email to support@cloudnet.com.kh with details. You can send us your valued suggestions/feedback too.</p>', '2014-08-15 06:00:57', '2015-01-01 00:00:00', '2017-01-01 00:00:00', '3');

-- ----------------------------
-- Table structure for erp_order_ref
-- ----------------------------
DROP TABLE IF EXISTS `erp_order_ref`;
CREATE TABLE `erp_order_ref` (
  `ref_id` int(11) NOT NULL AUTO_INCREMENT,
  `biller_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `so` int(11) NOT NULL DEFAULT '1' COMMENT 'sale order',
  `qu` int(11) NOT NULL DEFAULT '1' COMMENT 'quote',
  `po` int(11) NOT NULL DEFAULT '1' COMMENT 'purchase order',
  `to` int(11) NOT NULL DEFAULT '1' COMMENT 'transfer to',
  `pos` int(11) NOT NULL DEFAULT '1' COMMENT 'pos',
  `do` int(11) NOT NULL DEFAULT '1' COMMENT 'delivery order',
  `pay` int(11) NOT NULL DEFAULT '1' COMMENT 'expense payment',
  `re` int(11) NOT NULL DEFAULT '1' COMMENT 'sale return',
  `ex` int(11) NOT NULL DEFAULT '1' COMMENT 'expense',
  `sp` int(11) NOT NULL DEFAULT '1' COMMENT 'sale payement',
  `pp` int(11) NOT NULL DEFAULT '1' COMMENT 'purchase payment',
  `sl` int(11) NOT NULL DEFAULT '1' COMMENT 'sale loan',
  `tr` int(11) NOT NULL DEFAULT '1' COMMENT 'transfer',
  `rep` int(11) NOT NULL DEFAULT '1' COMMENT 'purchase return',
  `con` int(11) NOT NULL DEFAULT '1' COMMENT 'convert product',
  `pj` int(11) NOT NULL DEFAULT '1' COMMENT 'prouduct job',
  `qa` int(11) NOT NULL,
  PRIMARY KEY (`ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_order_ref
-- ----------------------------
INSERT INTO `erp_order_ref` VALUES ('1', '1', '2016-01-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('2', '1', '2016-02-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('3', '1', '2016-03-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('4', '1', '2016-04-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('5', '1', '2016-05-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('6', '1', '2016-06-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('7', '1', '2016-07-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('8', '1', '2016-08-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('9', '1', '2016-09-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('10', '1', '2016-10-01', '42', '1', '10', '1', '1', '42', '10', '1', '10', '33', '1', '1', '57', '1', '14', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('11', '1', '2016-11-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('12', '1', '2016-12-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('13', '1', '2017-01-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('14', '1', '2017-02-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('15', '1', '2017-03-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('16', '1', '2017-04-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('17', '1', '2017-05-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('18', '1', '2017-06-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('19', '1', '2017-07-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('21', '1', '2017-08-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('22', '1', '2017-09-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('23', '1', '2017-10-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('24', '1', '2017-11-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('25', '1', '2017-12-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('26', '1', '2018-01-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('27', '1', '2018-02-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('28', '1', '2018-03-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('29', '1', '2018-04-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('30', '1', '2018-05-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('31', '1', '2018-06-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('32', '1', '2018-07-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('33', '1', '2018-08-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('34', '1', '2018-09-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('35', '2', '2016-01-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('36', '2', '2016-02-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('37', '2', '2016-03-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('38', '2', '2016-04-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('39', '2', '2016-05-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('40', '2', '2016-06-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('41', '2', '2016-07-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('42', '2', '2016-08-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('43', '2', '2016-09-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('44', '2', '2016-10-01', '42', '1', '10', '1', '1', '42', '10', '1', '10', '33', '1', '1', '57', '1', '14', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('45', '2', '2016-11-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('46', '2', '2016-12-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('47', '2', '2017-01-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('48', '2', '2017-02-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('49', '2', '2017-03-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('50', '2', '2017-04-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('51', '2', '2017-05-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('52', '2', '2017-06-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('53', '2', '2017-07-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('54', '2', '2017-08-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('55', '2', '2017-09-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('56', '2', '2017-10-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('57', '2', '2017-11-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('58', '2', '2017-12-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('59', '2', '2018-01-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('60', '2', '2018-02-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('61', '2', '2018-03-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('62', '2', '2018-04-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('63', '2', '2018-05-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('64', '2', '2018-06-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('65', '2', '2018-07-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('66', '2', '2018-08-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `erp_order_ref` VALUES ('67', '2', '2018-09-01', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for erp_pack_lists
-- ----------------------------
DROP TABLE IF EXISTS `erp_pack_lists`;
CREATE TABLE `erp_pack_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pack_code` varchar(20) DEFAULT NULL,
  `name` varchar(55) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `parent` int(11) DEFAULT '0',
  `level` int(11) DEFAULT '0',
  `status` tinyint(3) DEFAULT '0',
  `cf1` varchar(255) DEFAULT NULL,
  `cf2` varchar(255) DEFAULT NULL,
  `cf3` varchar(255) DEFAULT NULL,
  `cf4` varchar(255) DEFAULT NULL,
  `cf5` varchar(255) DEFAULT NULL,
  `cf6` varchar(255) DEFAULT NULL,
  `cf7` varchar(255) DEFAULT NULL,
  `cf8` varchar(255) DEFAULT NULL,
  `cf9` varchar(255) DEFAULT NULL,
  `cf10` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_pack_lists
-- ----------------------------

-- ----------------------------
-- Table structure for erp_payments
-- ----------------------------
DROP TABLE IF EXISTS `erp_payments`;
CREATE TABLE `erp_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biller_id` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) DEFAULT NULL,
  `return_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `deposit_id` int(11) DEFAULT NULL,
  `purchase_deposit_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `expense_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `reference_no` varchar(50) NOT NULL,
  `paid_by` varchar(20) NOT NULL,
  `cheque_no` varchar(20) DEFAULT NULL,
  `cc_no` varchar(20) DEFAULT NULL,
  `cc_holder` varchar(25) DEFAULT NULL,
  `cc_month` varchar(2) DEFAULT NULL,
  `cc_year` varchar(4) DEFAULT NULL,
  `cc_type` varchar(20) DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL,
  `pos_paid` decimal(25,4) DEFAULT '0.0000',
  `currency` varchar(3) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `pos_balance` decimal(25,4) DEFAULT '0.0000',
  `pos_paid_other` decimal(25,4) DEFAULT NULL,
  `pos_paid_other_rate` decimal(25,4) DEFAULT NULL,
  `approval_code` varchar(50) DEFAULT NULL,
  `purchase_return_id` int(11) DEFAULT NULL,
  `return_deposit_id` int(11) DEFAULT NULL,
  `extra_paid` decimal(25,4) DEFAULT NULL,
  `deposit_quote_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_payments
-- ----------------------------
INSERT INTO `erp_payments` VALUES ('1', null, '2016-10-05 01:10:00', null, null, null, null, null, null, null, '1', 'J/1610/00001', 'Cash on Hand', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('2', null, '2016-10-05 09:10:00', null, null, null, null, null, null, null, '2', 'J/1610/00002', 'Cash on Hand', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('3', null, '2016-10-05 05:10:00', null, null, null, null, null, null, null, '3', 'J/1610/00003', 'Cash on Hand', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('4', null, '2016-10-05 09:10:00', null, null, null, null, null, null, null, '4', 'J/1610/00004', 'Cash on Hand', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('5', null, '2016-10-06 05:10:00', null, null, null, null, null, null, null, '5', 'J/1610/00005', 'Cash on Hand', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('6', '3', '2016-10-03 02:00:00', '1', null, null, null, null, null, null, null, 'RV/1610/00001', 'cash', '', '', '', '', '', 'Visa', '57.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('8', null, '2016-10-06 09:25:00', null, null, null, null, null, null, '1', null, 'IPAY/1610/00001', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំនាយថ្លៃប្រេងសាំង</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('9', null, '2016-10-06 10:25:00', null, null, null, null, null, null, '2', null, 'IPAY/1610/00002', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លៃប៉ូលីសផាកពិន័យ</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('10', null, '2016-10-06 09:05:00', null, null, null, null, null, null, '3', null, 'IPAY/1610/00003', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លទិញសម្ភារះម៉ាស៊ីន</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('11', null, '2016-10-07 09:25:00', null, null, null, null, null, null, '4', null, 'IPAY/1610/00004', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លៃដឹកឡត</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('12', null, '2016-10-07 10:25:00', null, null, null, null, null, null, '5', null, 'IPAY/1610/00005', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លៃរត់ការឯកសារពន្ធដារ</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('13', null, '2016-10-08 09:10:00', null, null, null, null, null, null, null, '13', 'J/1610/00013', 'Cash on Hand', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('14', null, '2016-10-08 10:45:00', null, null, null, null, null, null, '6', null, 'IPAY/1610/00006', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លៃដឹកឡត</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('15', null, '2016-10-08 11:50:00', null, null, null, null, null, null, '7', null, 'IPAY/1610/00007', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លៃប្រាក់បៀវត្សរ៍ប្រចាំខែ 09/2016</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('16', null, '2016-10-10 13:45:00', null, null, null, null, null, null, '8', null, 'IPAY/1610/00008', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាថ្លៃថែមម៉ោង</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('17', null, '2016-10-10 08:20:00', null, null, null, null, null, null, '9', null, 'IPAY/1610/00009', 'cash', null, null, null, null, null, null, '-49.1250', '0.0000', null, '1', null, 'sent', '<p>ចំណាយថ្លៃភ្លើងប្រចាំខែ 09/2016</p>', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('18', '3', '2016-10-05 15:25:00', '4', null, null, null, null, null, null, null, 'RV/1610/00003', 'cash', '', '', '', '', '', 'Visa', '82.7500', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('19', '3', '2016-10-05 10:25:00', '5', null, null, null, null, null, null, null, 'RV/1610/00004', 'cash', '', '', '', '', '', 'Visa', '39.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('20', '3', '2016-10-05 10:25:00', '6', null, null, null, null, null, null, null, 'RV/1610/00005', 'cash', '', '', '', '', '', 'Visa', '45.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('21', '3', '2016-10-05 09:25:00', '7', null, null, null, null, null, null, null, 'RV/1610/00006', 'cash', '', '', '', '', '', 'Visa', '180.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('22', '3', '2016-10-05 09:25:00', '8', null, null, null, null, null, null, null, 'RV/1610/00007', 'cash', '', '', '', '', '', 'Visa', '35.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('23', '3', '2016-10-05 09:45:00', '9', null, null, null, null, null, null, null, 'RV/1610/00008', 'cash', '', '', '', '', '', 'Visa', '96.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('24', '3', '2016-10-05 10:25:00', '10', null, null, null, null, null, null, null, 'RV/1610/00009', 'cash', '', '', '', '', '', 'Visa', '65.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('25', '3', '2016-10-05 09:25:00', '11', null, null, null, null, null, null, null, 'RV/1610/00010', 'cash', '', '', '', '', '', 'Visa', '105.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('26', '3', '2016-10-05 09:25:00', '13', null, null, null, null, null, null, null, 'RV/1610/00011', 'cash', '', '', '', '', '', 'Visa', '114.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('27', '3', '2016-10-06 09:25:00', '15', null, null, null, null, null, null, null, 'RV/1610/00012', 'cash', '', '', '', '', '', 'Visa', '750.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('28', '3', '2016-10-06 10:30:00', '16', null, null, null, null, null, null, null, 'RV/1610/00013', 'cash', '', '', '', '', '', 'Visa', '31.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('29', '3', '2016-10-06 06:30:00', '18', null, null, null, null, null, null, null, 'RV/1610/00014', 'cash', '', '', '', '', '', 'Visa', '37.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('30', '3', '2016-10-06 10:45:00', '19', null, null, null, null, null, null, null, 'RV/1610/00015', 'cash', '', '', '', '', '', 'Visa', '42.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('31', '3', '2016-10-07 10:30:00', '20', null, null, null, null, null, null, null, 'RV/1610/00016', 'cash', '', '', '', '', '', 'Visa', '32.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('32', '3', '2016-10-07 10:30:00', '21', null, null, null, null, null, null, null, 'RV/1610/00017', 'cash', '', '', '', '', '', 'Visa', '71.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('33', '3', '2016-10-07 06:30:00', '24', null, null, null, null, null, null, null, 'RV/1610/00018', 'cash', '', '', '', '', '', 'Visa', '23.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('34', '3', '2016-10-07 10:25:00', '25', null, null, null, null, null, null, null, 'RV/1610/00019', 'cash', '', '', '', '', '', 'Visa', '304.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('35', '3', '2016-10-11 16:04:00', '26', null, null, null, null, null, null, null, 'RV/1610/00020', 'cash', '', '', '', '', '', 'Visa', '162.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('36', '3', '2016-10-07 10:25:00', '27', null, null, null, null, null, null, null, 'RV/1610/00021', 'cash', '', '', '', '', '', 'Visa', '32.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('37', '3', '2016-10-07 10:30:00', '28', null, null, null, null, null, null, null, 'RV/1610/00022', 'cash', '', '', '', '', '', 'Visa', '363.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('38', '3', '2016-10-07 10:30:00', '29', null, null, null, null, null, null, null, 'RV/1610/00023', 'cash', '', '', '', '', '', 'Visa', '847.7200', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('39', '3', '2016-10-08 10:30:00', '30', null, null, null, null, null, null, null, 'RV/1610/00024', 'cash', '', '', '', '', '', 'Visa', '1500.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('40', '3', '2016-10-08 10:30:00', '31', null, null, null, null, null, null, null, 'RV/1610/00025', 'cash', '', '', '', '', '', 'Visa', '587.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('41', '3', '2016-10-08 10:30:00', '32', null, null, null, null, null, null, null, 'RV/1610/00026', 'cash', '', '', '', '', '', 'Visa', '32.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('42', '3', '2016-10-08 11:30:00', '33', null, null, null, null, null, null, null, 'RV/1610/00027', 'cash', '', '', '', '', '', 'Visa', '32.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('43', '3', '2016-10-08 10:25:00', '34', null, null, null, null, null, null, null, 'RV/1610/00028', 'cash', '', '', '', '', '', 'Visa', '45.5000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('44', '3', '2016-10-09 10:30:00', '37', null, null, null, null, null, null, null, 'RV/1610/00029', 'cash', '', '', '', '', '', 'Visa', '325.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('45', '3', '2016-10-09 10:30:00', '38', null, null, null, null, null, null, null, 'RV/1610/00030', 'cash', '', '', '', '', '', 'Visa', '74.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('46', '3', '2016-10-09 09:25:00', '39', null, null, null, null, null, null, null, 'RV/1610/00031', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);
INSERT INTO `erp_payments` VALUES ('47', '3', '2016-10-09 09:20:00', '41', null, null, null, null, null, null, null, 'RV/1610/00032', 'cash', '', '', '', '', '', 'Visa', '115.0000', '0.0000', null, '1', null, 'received', '', '0.0000', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for erp_payment_term
-- ----------------------------
DROP TABLE IF EXISTS `erp_payment_term`;
CREATE TABLE `erp_payment_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(55) DEFAULT NULL,
  `payment_days` int(11) DEFAULT '0',
  `over_due_days` int(11) DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `discount` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_payment_term
-- ----------------------------

-- ----------------------------
-- Table structure for erp_paypal
-- ----------------------------
DROP TABLE IF EXISTS `erp_paypal`;
CREATE TABLE `erp_paypal` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL,
  `paypal_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '2.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '3.9000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '4.4000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_paypal
-- ----------------------------
INSERT INTO `erp_paypal` VALUES ('1', '0', 'mypaypal@paypal.com', 'USD', '0.0000', '0.0000', '0.0000');

-- ----------------------------
-- Table structure for erp_permissions
-- ----------------------------
DROP TABLE IF EXISTS `erp_permissions`;
CREATE TABLE `erp_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `products-index` tinyint(1) DEFAULT '0',
  `products-add` tinyint(1) DEFAULT '0',
  `products-edit` tinyint(1) DEFAULT '0',
  `products-delete` tinyint(1) DEFAULT '0',
  `products-cost` tinyint(1) DEFAULT '0',
  `products-price` tinyint(1) DEFAULT '0',
  `products-import` tinyint(1) DEFAULT '0',
  `products-export` tinyint(1) DEFAULT '0',
  `quotes-index` tinyint(1) DEFAULT '0',
  `quotes-add` tinyint(1) DEFAULT '0',
  `quotes-edit` tinyint(1) DEFAULT '0',
  `quotes-email` tinyint(1) DEFAULT '0',
  `quotes-delete` tinyint(1) DEFAULT '0',
  `quotes-pdf` tinyint(1) DEFAULT '0',
  `quotes-export` tinyint(1) DEFAULT '0',
  `quotes-import` tinyint(1) DEFAULT '0',
  `sales-index` tinyint(1) DEFAULT '0',
  `sales-add` tinyint(1) DEFAULT '0',
  `sales-edit` tinyint(1) DEFAULT '0',
  `sales-email` tinyint(1) DEFAULT '0',
  `sales-pdf` tinyint(1) DEFAULT '0',
  `sales-delete` tinyint(1) DEFAULT '0',
  `sales-export` tinyint(1) DEFAULT '0',
  `sales-import` tinyint(1) DEFAULT '0',
  `purchases-index` tinyint(1) DEFAULT '0',
  `purchases-add` tinyint(1) DEFAULT '0',
  `purchases-edit` tinyint(1) DEFAULT '0',
  `purchases-email` tinyint(1) DEFAULT '0',
  `purchases-pdf` tinyint(1) DEFAULT '0',
  `purchases-delete` tinyint(1) DEFAULT '0',
  `purchases-export` tinyint(1) DEFAULT '0',
  `purchases-import` tinyint(1) DEFAULT '0',
  `transfers-index` tinyint(1) DEFAULT '0',
  `transfers-add` tinyint(1) DEFAULT '0',
  `transfers-edit` tinyint(1) DEFAULT '0',
  `transfers-email` tinyint(1) DEFAULT '0',
  `transfers-delete` tinyint(1) DEFAULT '0',
  `transfers-pdf` tinyint(1) DEFAULT '0',
  `transfers-export` tinyint(1) DEFAULT '0',
  `transfers-import` tinyint(1) DEFAULT '0',
  `customers-index` tinyint(1) DEFAULT '0',
  `customers-add` tinyint(1) DEFAULT '0',
  `customers-edit` tinyint(1) DEFAULT '0',
  `customers-delete` tinyint(1) DEFAULT '0',
  `customers-export` tinyint(1) DEFAULT '0',
  `customers-import` tinyint(1) DEFAULT '0',
  `suppliers-index` tinyint(1) DEFAULT '0',
  `suppliers-add` tinyint(1) DEFAULT '0',
  `suppliers-edit` tinyint(1) DEFAULT '0',
  `suppliers-delete` tinyint(1) DEFAULT '0',
  `suppliers-import` tinyint(1) DEFAULT '0',
  `suppliers-export` tinyint(1) DEFAULT '0',
  `sales-deliveries` tinyint(1) DEFAULT '0',
  `sales-add_delivery` tinyint(1) DEFAULT '0',
  `sales-edit_delivery` tinyint(1) DEFAULT '0',
  `sales-delete_delivery` tinyint(1) DEFAULT '0',
  `sales-pdf_delivery` tinyint(1) DEFAULT '0',
  `sales-email_delivery` tinyint(1) DEFAULT '0',
  `sales-export_delivery` tinyint(1) DEFAULT '0',
  `sales-import_delivery` tinyint(1) DEFAULT '0',
  `sales-gift_cards` tinyint(1) DEFAULT '0',
  `sales-add_gift_card` tinyint(1) DEFAULT '0',
  `sales-edit_gift_card` tinyint(1) DEFAULT '0',
  `sales-delete_gift_card` tinyint(1) DEFAULT '0',
  `sales-import_gift_card` tinyint(1) DEFAULT '0',
  `sales-export_gift_card` tinyint(1) DEFAULT '0',
  `pos-index` tinyint(1) DEFAULT '0',
  `sales-return_sales` tinyint(1) DEFAULT '0',
  `reports-index` tinyint(1) DEFAULT '0',
  `reports-warehouse_stock` tinyint(1) DEFAULT '0',
  `reports-quantity_alerts` tinyint(1) DEFAULT '0',
  `reports-expiry_alerts` tinyint(1) DEFAULT '0',
  `reports-products` tinyint(1) DEFAULT '0',
  `reports-daily_sales` tinyint(1) DEFAULT '0',
  `reports-monthly_sales` tinyint(1) DEFAULT '0',
  `reports-sales` tinyint(1) DEFAULT '0',
  `reports-payments` tinyint(1) DEFAULT '0',
  `reports-purchases` tinyint(1) DEFAULT '0',
  `reports-profit_loss` tinyint(1) DEFAULT '0',
  `reports-customers` tinyint(1) DEFAULT '0',
  `reports-suppliers` tinyint(1) DEFAULT '0',
  `reports-staff` tinyint(1) DEFAULT '0',
  `reports-register` tinyint(1) DEFAULT '0',
  `reports-account` tinyint(1) DEFAULT '0',
  `sales-payments` tinyint(1) DEFAULT '0',
  `purchases-payments` tinyint(1) DEFAULT '0',
  `purchases-expenses` tinyint(1) DEFAULT '0',
  `bulk_actions` tinyint(1) DEFAULT '0',
  `customers-deposits` tinyint(1) DEFAULT '0',
  `customers-delete_deposit` tinyint(1) DEFAULT '0',
  `products-adjustments` tinyint(1) DEFAULT '0',
  `accounts-index` tinyint(1) DEFAULT '0',
  `accounts-add` tinyint(1) DEFAULT '0',
  `accounts-edit` tinyint(1) DEFAULT '0',
  `accounts-delete` tinyint(1) DEFAULT '0',
  `accounts-import` tinyint(1) DEFAULT '0',
  `accounts-export` tinyint(1) DEFAULT '0',
  `sales-discount` tinyint(1) DEFAULT '0',
  `sales-price` tinyint(1) DEFAULT '0',
  `sales-loan` tinyint(1) DEFAULT '0',
  `reports-daily_purchases` tinyint(1) DEFAULT '0',
  `reports-monthly_purchases` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_permissions
-- ----------------------------
INSERT INTO `erp_permissions` VALUES ('1', '5', '1', '1', '1', '1', '1', '1', null, null, '1', '1', '1', '1', '1', null, null, null, '1', '1', '1', '1', null, '1', null, null, '1', '1', '1', '1', null, '1', null, null, '1', '1', '1', '1', '1', null, null, null, '1', '1', '1', '1', null, null, '1', '1', '1', '1', null, null, '1', '1', '1', '1', null, null, null, null, '1', '1', '1', '1', null, null, '1', '1', null, '0', null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, '1', '1', '1', null, null, null, '1', '1', '1', '1', '1', null, null, '0', '0', '1', '0', '0');
INSERT INTO `erp_permissions` VALUES ('2', '6', '1', null, null, null, '1', '1', null, null, '1', '1', '1', '1', '1', null, null, '0', '1', '1', '1', '1', null, '1', '0', null, '1', '1', '1', '1', null, '1', '0', null, '1', '1', '1', '1', '1', null, '0', '0', '1', '1', '1', '1', '0', null, '1', '1', '1', '1', '0', null, '1', '1', '1', '1', null, null, '0', null, '1', '1', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '1', '1', '1', '1', null, null, null, '1', '1', '1', '1', '1', null, null, '0', '0', '1', '0', '0');
INSERT INTO `erp_permissions` VALUES ('3', '7', '1', '1', '1', '1', '1', '1', null, null, '1', '1', '1', '1', '1', null, null, '0', '1', '1', '1', '1', null, '1', '0', null, '1', '1', '1', '1', null, '1', '0', null, '1', '1', '1', '1', '1', null, '0', '0', '1', '1', '1', '1', '0', null, '1', '1', '1', '1', '0', null, '1', '1', '1', '1', null, null, '0', null, '1', '1', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '1', '1', '1', '0', '1', '1', '0', '1', '1', '0', '0', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('4', '8', '1', '1', null, null, null, null, null, null, '1', null, null, null, null, null, null, '0', '1', null, null, null, null, null, '0', null, '1', null, null, null, null, null, '0', null, '1', null, null, null, null, null, '0', '0', '1', null, null, null, '0', null, null, null, null, null, '0', null, '1', null, null, null, null, null, '0', null, '1', null, null, null, '0', '0', null, null, '0', '0', null, null, null, null, null, '0', null, null, '0', null, null, '0', '0', '0', null, null, null, '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('5', '9', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('6', '10', '1', null, null, null, null, null, null, null, '1', null, null, null, null, null, null, '0', '1', null, null, null, null, null, '0', null, '1', null, null, null, null, null, '0', null, '1', null, null, null, null, null, '0', '0', '1', null, null, null, '0', null, '1', null, null, null, '0', null, '1', null, null, null, null, null, '0', null, '1', null, null, null, '0', '0', null, null, '0', '0', null, null, null, null, null, '0', null, null, '0', null, null, '0', '0', '0', null, null, null, '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('7', '11', '1', '1', '1', '1', null, '1', null, '1', '1', '1', '1', '1', '1', null, null, '1', '1', '1', '1', '1', null, '1', '1', '1', '1', '1', '1', '1', null, '1', '1', null, '1', '1', '1', '1', '1', null, '1', null, '1', '1', '1', '1', null, null, '1', '1', '1', '1', null, null, '1', '1', '1', '1', null, null, '1', null, '1', '1', '1', '1', '1', '1', '1', '1', null, '0', null, null, null, null, null, null, null, null, null, null, null, '0', '0', '1', '1', '1', '1', null, null, null, '1', '1', '1', '1', '1', '1', '1', '0', '0', null, '0', '0');
INSERT INTO `erp_permissions` VALUES ('8', '11', '1', '1', '1', '1', null, '1', null, '1', '1', '1', '1', '1', '1', null, null, '1', '1', '1', '1', '1', null, '1', '1', '1', '1', '1', '1', '1', null, '1', '1', null, '1', '1', '1', '1', '1', null, '1', null, '1', '1', '1', '1', null, null, '1', '1', '1', '1', null, null, '1', '1', '1', '1', null, null, '1', null, '1', '1', '1', '1', '1', '1', '1', '1', null, '0', null, null, null, null, null, null, null, null, null, null, null, '0', '0', '1', '1', '1', '1', null, null, null, '1', '1', '1', '1', '1', '1', '1', '0', '0', null, '0', '0');
INSERT INTO `erp_permissions` VALUES ('9', '12', '1', '1', '1', '1', '1', '1', null, null, '1', '1', '1', null, '1', null, null, '0', '1', '1', '1', null, null, '1', '0', null, '1', '1', '1', null, null, '1', '0', null, '1', '1', '1', null, '1', null, '0', '0', '1', '1', '1', '1', '0', null, '1', '1', '1', '1', '0', null, '1', '1', '1', '1', null, null, '0', null, '1', '1', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '0', '1', '1', '1', null, null, null, '1', '1', '1', '1', '1', null, null, '0', '0', null, '0', '0');
INSERT INTO `erp_permissions` VALUES ('10', '13', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('11', '14', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('12', '15', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('13', '16', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('14', '17', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('15', '18', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');
INSERT INTO `erp_permissions` VALUES ('16', '19', '1', '1', '1', '1', '1', null, null, null, null, null, null, null, null, null, null, '0', null, null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', '0', null, null, null, null, '0', null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', null, null, null, null, null, '0', '0', null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, '0', '0');
INSERT INTO `erp_permissions` VALUES ('17', '19', '1', '1', '1', '1', '1', null, null, null, null, null, null, null, null, null, null, '0', null, null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', '0', null, null, null, null, '0', null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', null, null, null, null, null, '0', '0', null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, '0', '0');
INSERT INTO `erp_permissions` VALUES ('18', '20', '1', '1', '1', '1', '1', '1', null, null, null, null, null, null, null, null, null, '0', null, null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', '0', null, null, null, null, '0', null, null, null, null, null, '0', null, null, null, null, null, null, null, '0', null, null, null, null, null, '0', '0', null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', '0', null, '0', '0');
INSERT INTO `erp_permissions` VALUES ('19', '21', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, '0', '0', '0', '0', null, '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for erp_pos_register
-- ----------------------------
DROP TABLE IF EXISTS `erp_pos_register`;
CREATE TABLE `erp_pos_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `cash_in_hand` decimal(25,4) NOT NULL,
  `status` varchar(10) NOT NULL,
  `total_cash` decimal(25,4) DEFAULT NULL,
  `total_cheques` int(11) DEFAULT NULL,
  `total_cc_slips` int(11) DEFAULT NULL,
  `total_cash_submitted` decimal(25,4) DEFAULT NULL,
  `total_cheques_submitted` int(11) DEFAULT NULL,
  `total_cc_slips_submitted` int(11) DEFAULT NULL,
  `note` text,
  `closed_at` timestamp NULL DEFAULT NULL,
  `transfer_opened_bills` varchar(50) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_pos_register
-- ----------------------------
INSERT INTO `erp_pos_register` VALUES ('1', '2016-07-22 09:31:11', '1', '0.0000', 'open', null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for erp_pos_settings
-- ----------------------------
DROP TABLE IF EXISTS `erp_pos_settings`;
CREATE TABLE `erp_pos_settings` (
  `pos_id` int(1) NOT NULL,
  `cat_limit` int(11) NOT NULL,
  `pro_limit` int(11) NOT NULL,
  `default_category` int(11) NOT NULL,
  `default_customer` int(11) NOT NULL,
  `default_biller` int(11) NOT NULL,
  `display_time` varchar(3) NOT NULL DEFAULT 'yes',
  `cf_title1` varchar(255) DEFAULT NULL,
  `cf_title2` varchar(255) DEFAULT NULL,
  `cf_value1` varchar(255) DEFAULT NULL,
  `cf_value2` varchar(255) DEFAULT NULL,
  `receipt_printer` varchar(55) DEFAULT NULL,
  `cash_drawer_codes` varchar(55) DEFAULT NULL,
  `focus_add_item` varchar(55) DEFAULT NULL,
  `add_manual_product` varchar(55) DEFAULT NULL,
  `customer_selection` varchar(55) DEFAULT NULL,
  `add_customer` varchar(55) DEFAULT NULL,
  `toggle_category_slider` varchar(55) DEFAULT NULL,
  `toggle_subcategory_slider` varchar(55) DEFAULT NULL,
  `show_search_item` varchar(55) DEFAULT NULL,
  `product_unit` varchar(55) DEFAULT NULL,
  `cancel_sale` varchar(55) DEFAULT NULL,
  `suspend_sale` varchar(55) DEFAULT NULL,
  `print_items_list` varchar(55) DEFAULT NULL,
  `finalize_sale` varchar(55) DEFAULT NULL,
  `today_sale` varchar(55) DEFAULT NULL,
  `open_hold_bills` varchar(55) DEFAULT NULL,
  `close_register` varchar(55) DEFAULT NULL,
  `keyboard` tinyint(1) NOT NULL,
  `pos_printers` varchar(255) DEFAULT NULL,
  `java_applet` tinyint(1) NOT NULL,
  `product_button_color` varchar(20) NOT NULL DEFAULT 'default',
  `tooltips` tinyint(1) DEFAULT '1',
  `paypal_pro` tinyint(1) DEFAULT '0',
  `stripe` tinyint(1) DEFAULT '0',
  `rounding` tinyint(1) DEFAULT '0',
  `char_per_line` tinyint(4) DEFAULT '42',
  `pin_code` varchar(20) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT 'purchase_code',
  `envato_username` varchar(50) DEFAULT 'envato_username',
  `version` varchar(10) DEFAULT '3.0.1.21',
  `show_item_img` tinyint(1) DEFAULT NULL,
  `pos_layout` tinyint(1) DEFAULT NULL,
  `display_qrcode` tinyint(1) DEFAULT NULL,
  `show_suspend_bar` tinyint(1) DEFAULT NULL,
  `show_payment_noted` tinyint(1) DEFAULT NULL,
  `payment_balance` tinyint(1) DEFAULT NULL,
  `authorize` tinyint(1) DEFAULT '0',
  `show_product_code` tinyint(1) unsigned DEFAULT '1',
  `auto_delivery` tinyint(1) unsigned DEFAULT '1',
  `in_out_rate` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_pos_settings
-- ----------------------------
INSERT INTO `erp_pos_settings` VALUES ('1', '22', '18', '1', '4', '3', '1', 'GST Reg', 'VAT Reg', '123456789', '987654321', 'BIXOLON SRP-350II', 'x1C', 'Ctrl+F3', 'Ctrl+Shift+M', 'Ctrl+Shift+C', 'Ctrl+Shift+A', 'Ctrl+F11', 'Ctrl+F12', 'F1', 'F2', 'F4', 'F7', 'F9', 'F8', 'Ctrl+F1', 'Ctrl+F2', 'Ctrl+F10', '0', 'BIXOLON SRP-350II, BIXOLON SRP-350II', '0', 'warning', '0', '0', '0', '0', '42', null, 'purchase_code', 'envato_username', '3.0.1.21', '1', '0', '0', '40', '1', '1', '0', '1', '1', '0');

-- ----------------------------
-- Table structure for erp_price_groups
-- ----------------------------
DROP TABLE IF EXISTS `erp_price_groups`;
CREATE TABLE `erp_price_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_price_groups
-- ----------------------------

-- ----------------------------
-- Table structure for erp_products
-- ----------------------------
DROP TABLE IF EXISTS `erp_products`;
CREATE TABLE `erp_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` char(255) NOT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) NOT NULL,
  `alert_quantity` decimal(15,4) DEFAULT '20.0000',
  `image` varchar(255) DEFAULT 'no_image.png',
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `cf1` varchar(255) DEFAULT NULL,
  `cf2` varchar(255) DEFAULT NULL,
  `cf3` varchar(255) DEFAULT NULL,
  `cf4` varchar(255) DEFAULT NULL,
  `cf5` varchar(255) DEFAULT NULL,
  `cf6` varchar(255) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `tax_rate` int(11) DEFAULT NULL,
  `track_quantity` tinyint(1) DEFAULT '1',
  `details` varchar(1000) DEFAULT NULL,
  `warehouse` int(11) DEFAULT NULL,
  `barcode_symbology` varchar(55) NOT NULL DEFAULT 'code128',
  `file` varchar(100) DEFAULT NULL,
  `product_details` text,
  `tax_method` tinyint(1) DEFAULT '0',
  `type` varchar(55) NOT NULL DEFAULT 'standard',
  `supplier1` int(11) DEFAULT NULL,
  `supplier1price` decimal(25,4) DEFAULT NULL,
  `supplier2` int(11) DEFAULT NULL,
  `supplier2price` decimal(25,4) DEFAULT NULL,
  `supplier3` int(11) DEFAULT NULL,
  `supplier3price` decimal(25,4) DEFAULT NULL,
  `supplier4` int(11) DEFAULT NULL,
  `supplier4price` decimal(25,4) DEFAULT NULL,
  `supplier5` int(11) DEFAULT NULL,
  `supplier5price` decimal(25,4) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `promotion` tinyint(1) DEFAULT '0',
  `promo_price` decimal(25,4) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `supplier1_part_no` varchar(50) DEFAULT NULL,
  `supplier2_part_no` varchar(50) DEFAULT NULL,
  `supplier3_part_no` varchar(50) DEFAULT NULL,
  `supplier4_part_no` varchar(50) DEFAULT NULL,
  `supplier5_part_no` varchar(50) DEFAULT NULL,
  `currentcy_code` varchar(10) DEFAULT NULL,
  `inactived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `brand_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `category_id` (`category_id`),
  KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `category_id_2` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_products
-- ----------------------------
INSERT INTO `erp_products` VALUES ('1', 'AS-EV0-003', 'All Season(AS)(ទឹកស៊ីអ៊ីវ​ អលស៊ីសិន)(12)', 'កេះ', '0.0000', '9.5000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '41.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('2', 'AS-EV0-003-D', 'All Season(AS)(ទឹកស៊ីអ៊ីវ​ អលស៊ីសិន)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('3', 'AS-EV0-003-G', 'All Season(AS)(ទឹកស៊ីអ៊ីវ​ អលស៊ីសិន)', 'ដប', '0.0000', '1.2500', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '2.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('4', 'AV-001', 'អាវ20L​ កខ្លី(50kg)', 'បាវ', '0.0000', '150.0000', '5.0000', 'no_image.png', '8', null, '', '', '', '', '', '', '4.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('5', 'AV-001-kg', 'អាវ20L​ កខ្លី', 'គីឡូ', '2.7000', '3.0000', '5.0000', 'no_image.png', '8', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('6', 'AV-002', 'អាវ20L​ កវែង(50kg)', 'បាវ', '0.0000', '150.0000', '5.0000', 'no_image.png', '8', null, '', '', '', '', '', '', '1.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('7', 'AV-002-Kg', 'អាវ20L​ កវែង', 'គីឡូ', '0.0000', '3.0000', '5.0000', 'no_image.png', '8', null, '', '', '', '', '', '', '9.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('8', 'BAGE-001', 'កាដុងមាត់តូច 20L', 'កាដុង', '0.0000', '2.7000', '5.0000', 'no_image.png', '7', null, '', '', '', '', '', '', '40.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('9', 'BAGE-002', 'កាដុងមាត់ធំ 20L', 'កាដុង', '0.0000', '2.0000', '5.0000', 'no_image.png', '7', null, '', '', '', '', '', '', '133.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('10', 'BS-EV0-005', 'Blue Swimmer(BS)(ទឹកត្រីរូបក្តាមសេះ)(12)', 'កេះ', '0.0000', '5.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('11', 'BS-EV0-005-D', 'Blue Swimmer(BS)(ទឹកត្រីរូបក្តាមសេះ)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('12', 'BS-EV0-005-G', 'Blue Swimmer(BS)(ទឹកត្រីរូបក្តាមសេះ)', 'ដប', '0.0000', '0.5000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('13', 'BV-15.2-320-W', 'ដបលេខកូដ​ BV ទំងន់ 15.2 ក្រាម​ ចំណុះ 320 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('14', 'BV-15.2-320-W-D', 'ដបលេខកូដ​ BV ទំងន់ 15.2 ក្រាម​ ចំណុះ 320 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('15', 'BV-15.2-320-W-G', 'ដបលេខកូដ​ BV ទំងន់ 15.2 ក្រាម​ ចំណុះ 320 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('16', 'BV15.2-W', 'ឡតលេខកូដ BV ទំងន់15.2 ក្រាមពណស(W)(30kg)', 'បាវ', '45.8750', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('17', 'BV15.2-W-KG', 'ឡតលេខកូដ BV ទំងន់15.2 ក្រាមពណស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('18', 'BV16-V', 'ឡតលេខកូដ BV ទំងន់16​ ក្រាមពណវីតាល់(V)(25kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '99.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('19', 'BV16-V-KG', 'ឡតលេខកូដ BV ទំងន់16​ ក្រាមពណវីតាល់(V).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '18.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'បាវ', '0.0000', '45.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '1421.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('21', 'Caps-001-WDT-Big', 'គំរបសលាតDT(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('22', 'Caps-001-WDT-Small', 'គំរបសលាតDT(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '-26390.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('24', 'Caps-002-BDT', 'គំរបខៀវលាតDT(10000)', 'បាវ', '0.0000', '45.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '34.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('25', 'Caps-002-BDT-big', 'គំរបខៀវលាតDT(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('26', 'Caps-002-BDT-small', 'គំរបខៀវលាតDT(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('27', 'Caps-002-BDT-UNIT', 'គំរបខៀវលាតDT', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '4601.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('28', 'Caps-003-W', 'គំរបសក្រញាំឬសធម្មតា(10000)', 'បាវ', '0.0000', '55.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '2.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('29', 'Caps-003-W-big', 'គំរបសក្រញាំឬសធម្មតា(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('30', 'Caps-003-W-small', 'គំរបសក្រញាំឬសធម្មតា(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('31', 'Caps-003-W-UNIT', 'គំរបសក្រញាំឬសធម្មតា', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '9000.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('32', 'Caps-004-V', 'គំរបវីតាល់ធម្មតា(10000)', 'បាវ', '0.0000', '55.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '15.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('33', 'Caps-004-V-big', 'គំរបវីតាល់ធម្មតា(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('34', 'Caps-004-V-small', 'គំរបវីតាល់ធម្មតា(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('35', 'Caps-004-V-UNIT', 'គំរបវីតាល់ធម្មតា', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '5000.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('36', 'Caps-005-WUST', 'គំរបសលាតUST(10000)', 'បាវ', '42.0000', '45.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('37', 'Caps-005-WUST-big', 'គំរបសលាតUST(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('38', 'Caps-005-WUST-small', 'គំរបសលាតUST(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('39', 'Caps-005-WUST-UNIT', 'គំរបសលាតust', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('40', 'Caps-006-BUST', 'គំរបខៀវលាតUST(10000)', 'បាវ', '0.0000', '45.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '6.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('41', 'Caps-006-BUST-big', 'គំរបខៀវលាតUST(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('42', 'Caps-006-BUST-small', 'គំរបខៀវលាតUST(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('43', 'Caps-006-BUST-UNIT', 'គំរបខៀវលាតUST', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '5000.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('44', 'Caps-007-PUST', 'គំរបផ្កាឈូកលាតUST(10000)', 'បាវ', '0.0000', '45.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '2.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('45', 'Caps-007-PUST-big', 'គំរបផ្កាឈូកលាតUST(1000)', 'ថង់ធំ', '0.0000', '6.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('46', 'Caps-007-PUST-small', 'គំរបផ្កាឈូកលាតUST(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('47', 'Caps-007-PUST-UNIT', 'គំរបផ្កាឈូកលាតUST', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '8000.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('48', 'Caps-008-VISO', 'គំរបវីតាល់ស្តង់ដា(10000)', 'បាវ', '0.0000', '65.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '25.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('49', 'Caps-008-VISO-big', 'គំរបវីតាល់ស្តង់ដា(1000)', 'ថង់ធំ', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('50', 'Caps-008-VISO-small', 'គំរបវីតាល់ស្តង់ដា(200)', 'ថង់តូច', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('51', 'Caps-008-VISO-UNIT', 'គំរបវីតាល់ស្តង់ដា', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '3200.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('52', 'Caps-009-OISO', 'គំរបទឹកក្រូចស្តង់ដា(10000)', 'បាវ', '0.0000', '67.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '13.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('53', 'Caps-009-OISO-big', 'គំរបទឹកក្រូចស្តង់ដា(1000)', 'ថង់ធំ', '1.0320', '7.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '-1.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('54', 'Caps-009-OISO-small', 'គំរបទឹកក្រូចស្តង់ដា(200)', 'ថង់តូច', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('55', 'Caps-009-OISO-UNIT', 'គំរបទឹកក្រូចស្តង់ដា', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '5600.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('56', 'Caps-010-GISO', 'គំរបបៃតងស្តង់ដា(10000)', 'បាវ', '0.0000', '60.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '50.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('57', 'Caps-010-GISO-big', 'គំរបបៃតងស្តង់ដា(1000)', 'ថង់ធំ', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('58', 'Caps-010-GISO-Small', 'គំរបបៃតងស្តង់ដា(200)', 'ថង់តូច', '0.9800', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '-1.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('59', 'Caps-010-GISO-UNIT', 'គំរបបៃតងស្តង់ដា', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '13401.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('60', 'Caps-011-RISO', 'គំរបក្រហមស្តង់ដា(10000)', 'បាវ', '0.0000', '62.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '7.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('61', 'Caps-011-RISO-big', 'គំរបក្រហមស្តង់ដា(1000)', 'ថង់ធំ', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('62', 'Caps-011-RISO-small', 'គំរបក្រហមស្តង់ដា(200)', 'ថង់តូច', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('63', 'Caps-011-RISO-UNIT', 'គំរបក្រហមស្តង់ដា', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '6000.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('64', 'Caps-012-WTTH', 'គំរបសលាតTTH(10000)', 'បាវ', '42.0000', '45.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('65', 'Caps-012-WTTH-big', 'គំរបសលាតTTH(1000)', 'ថង់ធំ', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('66', 'Caps-012-WTTH-small', 'គំរបសលាតTTH(200)', 'ថង់តូច', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('67', 'Caps-012-WTTH-UNIT', 'គំរបសលាតtth', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('68', 'Caps-013-PurpleLMS', 'គំរបស្វាយលាតLMS(6000)', 'បាវ', '0.0000', '57.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '1.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('69', 'Caps-013-PurpleLMS-big', 'គំរបស្វាយលាតLMS(1000)', 'ថង់ធំ', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('70', 'Caps-013-PurpleLMS-small', 'គំរបស្វាយលាតLMS(200)', 'ថង់តូច', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('71', 'Caps-013-PurpleLMS-UNIT', 'គំរបស្វាយលាតLMS', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '5000.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('72', 'Caps-014BL', 'គំរបទឹកប៊ិចសំរាប់គ្របដបទឹកក្រូច(10000)', 'បាវ', '65.0000', '75.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('73', 'Caps-014BL-big', 'គំរបទឹកប៊ិចសំរាប់គ្របដបទឹកក្រូច(1000)', 'ថង់ធំ', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('74', 'Caps-014BL-small', 'គំរបទឹកប៊ិចសំរាប់គ្របដបទឹកក្រូច(200)', 'ថង់តូច', '0.0000', '1.5000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('75', 'Caps-014BL-UNIT', 'គំរបទឹកប៊ិចសំរាប់គ្របដបទឹកក្រូច', 'គំរប', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('76', 'DO-5L', 'ប្រេងខ្យងនាគចំណុះ5L', 'កេស', '3.6667', '12.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('77', 'DT-PW12.5-330-B', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '312.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('78', 'DT-PW12.5-330-B-D', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('79', 'DT-PW12.5-330-B-G', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('80', 'DT-PW12.5-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('81', 'DT-PW12.5-330-W-D', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('82', 'DT-PW12.5-330-W-G', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('84', 'DT-PW13-330-B-D', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('85', 'DT-PW13-330-B-G', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B)', 'ដប', '0.0000', '9.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '141.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('87', 'DT-PW13-330-W-D', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('88', 'DT-PW13-330-W-G', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', 'ថង់', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '533.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('90', 'DT12.5-435-B-D', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('91', 'DT12.5-435-B-G', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '1.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '-70.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('93', 'DT12.5-435-W-D', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('94', 'DT12.5-435-W-G', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('95', 'DT12.5-450-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('96', 'DT12.5-450-W-D', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('97', 'DT12.5-450-W-G', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('98', 'DT12.5-450B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B)(200)', 'ថង់', '40.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('99', 'DT12.5-450B-D', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('100', 'DT12.5-450B-G', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', 'បាវ', '14.3519', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '108.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('102', 'DT12.5-B-KG', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)', 'គីឡូ', '1.0320', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '41.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('103', 'DT12.5-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'ថង់', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('104', 'DT12.5-SPP-300-W-D', 'ដបSPPលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('105', 'DT12.5-SPP-300-W-G', 'ដបSPPលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('106', 'DT12.5-W', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ស(W)(30kg)', 'បាវ', '15.2621', '38.4000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('107', 'DT12.5-W-KG', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ស(W)', 'គីឡូ', '1.0783', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('108', 'DT13-435-B', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', 'ថង់', '1.0333', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('109', 'DT13-435-B-D', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('110', 'DT13-435-B-G', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('111', 'DT13-435-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'ថង់', '1.0320', '9.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('112', 'DT13-435-W-D', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('113', 'DT13-435-W-G', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('114', 'DT13-450-B', 'ដបជ្រុងលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '189.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('115', 'DT13-450-B-D', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('116', 'DT13-450-B-G', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('117', 'DT13-450-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', 'ថង់', '1.0320', '9.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '345.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('118', 'DT13-450-W-D', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('119', 'DT13-450-W-G', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('120', 'DT13-B', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ខៀវ(B)(30kg)', 'បាវ', '33.2500', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('121', 'DT13-B-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ខៀវ(B)', 'គីឡូ', '1.0333', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '304.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('123', 'DT13-SPP-300-W-D', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('124', 'DT13-SPP-300-W-G', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', 'បាវ', '0.0000', '38.4000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '73.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('126', 'DT13-W-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '19.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('127', 'DT13.5-B', 'ឡតលេខកូដ DT ទំងន់13.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', 'បាវ', '0.0000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '34.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('128', 'DT13.5-B-KG', 'ឡតលេខកូដ DT ទំងន់13.5​ ក្រាមពណ៌ខៀវ(B)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('129', 'DT13.5-W', 'ឡតលេខកូដ DT ទំងន់13.5​ ក្រាមពណ៌ស(W)(30kg)', 'បាវ', '32.3500', '38.4000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('130', 'DT13.5-W-KG', 'ឡតលេខកូដ DT ទំងន់13.5​ ក្រាមពណ៌ស(W)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('131', 'DTT-19-600-W', 'ដបលេខកូដ​ DTTទំងន់ 19 ក្រាម​ ចំណុះ 600 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('132', 'DTT-19-600-W-D', 'ដបលេខកូដ​ DTTទំងន់ 19 ក្រាម​ ចំណុះ 600 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('133', 'DTT-19-600-W-G', 'ដបលេខកូដ​ DTTទំងន់ 19 ក្រាម​ ចំណុះ 600 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('134', 'DTT-35-1500-W', 'ដបលេខកូដ​ DTTទំងន់ 35 ក្រាម​ ចំណុះ 1500 ml ពណ៌ស(W)(90)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('135', 'DTT-35-1500-W-D', 'ដបលេខកូដ​ DTTទំងន់ 35 ក្រាម​ ចំណុះ 1500 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('136', 'DTT-35-1500-W-G', 'ដបលេខកូដ​ DTTទំងន់ 35 ក្រាម​ ចំណុះ 1500 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('137', 'DTT19-W', 'ឡតលេខកូដ DTT ទំងន់19​ ក្រាមពណស(W)(30kg)', 'បាវ', '41.3750', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('138', 'DTT19-W-KG', 'ឡតលេខកូដ DTT ទំងន់19​ ក្រាមពណស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('139', 'DTT35-W', 'ឡតលេខកូដ DTT ទំងន់35​ ក្រាមពណស(W)(30kg)', 'បាវ', '41.3750', '43.7500', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('140', 'DTT35-W-KG', 'ឡតលេខកូដ DTT ទំងន់35​ ក្រាមពណស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('141', 'KY-EV0-002', 'Khmer Yoeung(KY)(ទឹកស៊ីអ៊ីវ​ ខ្មែរយើង)(12)', 'កេះ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '3.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('142', 'KY-EV0-002-D', 'Khmer Yoeung(KY)(ទឹកស៊ីអ៊ីវ​ ខ្មែរយើង)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('143', 'KY-EV0-002-G', 'Khmer Yoeung(KY)(ទឹកស៊ីអ៊ីវ​ ខ្មែរយើង)', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '5.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('144', 'LMS-15-350-V', 'ដបលេខកូដ​ LMSឈ្មោះ ទំងន់ 15 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '-100.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('145', 'LMS-15-350-V-D', 'ដបលេខកូដ​ LMSឈ្មោះ ទំងន់ 15 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('146', 'LMS-15-350-V-G', 'ដបលេខកូដ​ LMSឈ្មោះ ទំងន់ 15 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', 'ថង់', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '182.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('148', 'LMS-F17-500-V-D', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('149', 'LMS-F17-500-V-G', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('150', 'LMS-G15-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបGrand(G) ទំងន់ 15 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('151', 'LMS-G15-500-V-D', 'ដបលេខកូដ​ LMSឈ្មោះដបGrand(G) ទំងន់ 15 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('152', 'LMS-G15-500-V-G', 'ដបលេខកូដ​ LMSឈ្មោះដបGrand(G) ទំងន់ 15 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', 'ថង់', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '260.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('154', 'LMS-MV17-500-V-D', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('155', 'LMS-MV17-500-V-G', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '1.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', '', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '22.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('158', 'LO-001', 'ថង់អ៊ុតឡូ(13x14.5)(30kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '3.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('159', 'LO-001-KG', 'ថង់អ៊ុតឡូ(13x14.5)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '9.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('160', 'LO-002', 'ថង់អ៊ុតឡូ(14.5x15)(30kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '4.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('161', 'LO-002-KG', 'ថង់អ៊ុតឡូ(14.5x15)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('162', 'LO-003', 'ថង់អ៊ុតឡូ(15x15.5)(30kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('163', 'LO-003-KG', 'ថង់អ៊ុតឡូ(15x15.5)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('164', 'LO-004', 'ថង់អ៊ុតឡូ(15.5x16)(30kg)', 'បាវ', '46.5000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('165', 'LO-004-KG', 'ថង់អ៊ុតឡូ(15.5x16)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('166', 'MA-EV0-004', 'Match All(MA)(ទឹកស៊ីអ៊ីវ​ ម៉ាច់អល)(12)', 'កេះ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '39.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('167', 'MA-EV0-004-D', 'Match All(MA)(ទឹកស៊ីអ៊ីវ​ ម៉ាច់អល)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('168', 'MA-EV0-004-G', 'Match All(MA)(ទឹកស៊ីអ៊ីវ​ ម៉ាច់អល)', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '7.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('169', 'MT-DNT17.5-500-W', 'ដបលេខកូដ​ MTឈ្មោះដបDanatech(DNT) ទំងន់ 17.5 ក្រាម​ ចំណុះ 500 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '110.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('170', 'MT-DNT17.5-500-W-D', 'ដបលេខកូដ​ MTឈ្មោះដបDanatech(DNT) ទំងន់ 17.5 ក្រាម​ ចំណុះ 500 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('171', 'MT-DNT17.5-500-W-G', 'ដបលេខកូដ​ MTឈ្មោះដបDanatech(DNT) ទំងន់ 17.5 ក្រាម​ ចំណុះ 500 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('172', 'MT17.5-W', 'ឡតលេខកូដ TM ទំងន់17.5​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '41.3750', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('173', 'MT20-W', 'ឡតលេខកូដ MT ទំងន់20​ ក្រាមពណស(W)(30kg)', 'បាវ', '41.3750', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('174', 'MT20-W-KG', 'ឡតលេខកូដ MT ទំងន់20​ ក្រាមពណស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('175', 'STEMP-001', 'តែមហ្រ្គេនGrand', 'សន្លឹក', '0.0025', '0.0000', '5.0000', 'no_image.png', '6', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('176', 'STEMP-002', 'តែមរ៉េនធិច', 'សន្លឹក', '0.0025', '0.0000', '5.0000', 'no_image.png', '6', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('177', 'STEMP-003', 'តែមកំពង់ត្រាំ', 'សន្លឹក', '0.0000', '0.0000', '5.0000', 'no_image.png', '6', null, '', '', '', '', '', '', '90970.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('178', 'STEMP-004', 'តែមខូវលីហ័រ', 'សន្លឹក', '0.0025', '0.0000', '5.0000', 'no_image.png', '6', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('179', 'SY-EV0-001', 'Srok Yoeung(SY)(ទឹកស៊ីអ៊ីវ​ ស្រុកយើង)(12)', 'កេះ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '294.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('180', 'SY-EV0-001-D', 'Srok Yoeung(SY)(ទឹកស៊ីអ៊ីវ​ ស្រុកយើង)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('181', 'SY-EV0-001-G', 'Srok Yoeung(SY)(ទឹកស៊ីអ៊ីវ​ ស្រុកយើង)', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '3.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('182', 'TAT-CM13.5-450-W', 'ដបលេខកូដ​ TATឈ្មោះដបCoolMind(CM) ទំងន់ 13.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('183', 'TAT-CM13.5-450-W-D', 'ដបលេខកូដ​ TATឈ្មោះដបCoolMind(CM) ទំងន់ 13.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('184', 'TAT-CM13.5-450-W-G', 'ដបលេខកូដ​ TATឈ្មោះដបCoolMind(CM) ទំងន់ 13.5 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('185', 'TAT-DNT14.5-350-W', 'ដបលេខកូដ​ TATឈ្មោះដបDanatech(DNT) ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '56.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('186', 'TAT-DNT14.5-350-W-D', 'ដបលេខកូដ​ TATឈ្មោះដបDanatech(DNT) ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('187', 'TAT-DNT14.5-350-W-G', 'ដបលេខកូដ​ TATឈ្មោះដបDanatech(DNT) ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('188', 'TAT-G13.5-350-V', 'ដបលេខកូដ​ TATឈ្មោះដបGrand ទំងន់ 13.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('189', 'TAT-G13.5-350-V-D', 'ដបលេខកូដ​ TATឈ្មោះដបGrand ទំងន់ 13.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('190', 'TAT-G13.5-350-V-G', 'ដបលេខកូដ​ TATឈ្មោះដបGrand ទំងន់ 13.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('191', 'TAT-G14.5-350-V', 'ដបលេខកូដ​ TATឈ្មោះដបGrand ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', 'ថង់', '1.0783', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('192', 'TAT-G14.5-350-V-D', 'ដបលេខកូដ​ TATឈ្មោះដបGrand ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(ខូច)', 'KG', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('193', 'TAT-G14.5-350-V-G', 'ដបលេខកូដ​ TATឈ្មោះដបGrand ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('194', 'TAT-PW13.5-330-W', 'ដបលេខកូដ​ TATឈ្មោះដបPure Water(PW) ទំងន់ 13.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '59.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('195', 'TAT-PW13.5-330-W-D', 'ដបលេខកូដ​ TATឈ្មោះដបPure Water(PW) ទំងន់ 13.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(ខូច)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('196', 'TAT-PW13.5-330-W-G', 'ដបលេខកូដ​ TATឈ្មោះដបPure Water(PW) ទំងន់ 13.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('197', 'TAT13.5-435-W', 'ដបលេខកូដ​ TAT ទំងន់ 13.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('198', 'TAT13.5-435-W-D', 'ដបលេខកូដ​ TAT ទំងន់ 13.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(ខូច)', 'KG', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('199', 'TAT13.5-435-W-G', 'ដបលេខកូដ​ TAT ទំងន់ 13.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('200', 'TAT13.5-V', 'ឡតលេខកូដ TAT ទំងន់13.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', 'បាវ', '33.7000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('201', 'TAT13.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់13.5​ ក្រាមពណ៌វីតាល់(V).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('202', 'TAT13.5-W', 'ឡតលេខកូដ TAT ទំងន់13.5​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '33.7000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('203', 'TAT13.5-W-KG', 'ឡតលេខកូដ TAT ទំងន់13.5​ ក្រាមពណ៌ស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', 'បាវ', '0.0000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '120.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '1970-01-01', '1970-01-01', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('205', 'TAT14.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('206', 'TAT14.5-W', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '21.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('207', 'TAT14.5-W-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌ស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '15.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('208', 'TM17.5-W-KG', 'ឡតលេខកូដ TM ទំងន់17.5​ ក្រាមពណ៌ស(W).', 'KG', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('209', 'TN13.5-V', 'ឡតលេខកូដ TN ទំងន់13.5​ ក្រាមពណ៌វីតា(V)(25kg)', 'បាវ', '33.7000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('210', 'TN13.5-V-KG', 'ឡតលេខកូដ TN ទំងន់13.5​ ក្រាមពណ៌វីតា(V).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('211', 'TN13.5-W', 'ឡតលេខកូដ TN ទំងន់13.5​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '33.7000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('212', 'TN13.5-W-KG', 'ឡតលេខកូដ TN ទំងន់13.5​ ក្រាមពណ៌ស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('213', 'TN15-V', 'ឡតលេខកូដ TN ទំងន់15​ ក្រាមពណវីតាល់(V)(25kg)', 'បាវ', '33.7000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('214', 'TN15-V-KG', 'ឡតលេខកូដ TN ទំងន់15​ ក្រាមពណវីតាល់(V).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('215', 'TN15-W', 'ឡតលេខកូដ TN ទំងន់15​ ក្រាមពណស(W)(25kg)', 'បាវ', '33.7000', '40.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '0', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('216', 'TN15-W-KG', 'ឡតលេខកូដ TN ទំងន់15​ ក្រាមពណស(W).', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('217', 'TPT12.5-435-W', 'ដបលេខកូដ​ TPT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'ថង់', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('218', 'TPT12.5-435-W-D', 'ដបលេខកូដ​ TPT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(ខូច)', 'KG', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('219', 'TPT12.5-435-W-G', 'ដបលេខកូដ​ TPT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W).', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('220', 'TPT12.5-W', 'ឡតលេខកូដ TPT ទំងន់12.5​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '32.3500', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('221', 'TPT12.5-W-KG', 'ឡតលេខកូដ TPT ទំងន់12.5​ ក្រាមពណ៌ស(W)', 'KG', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('222', 'TPT13-W', 'ឡតលេខកូដ TPT ទំងន់13​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '32.3500', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('223', 'TPT13-W-KG', 'ឡតលេខកូដ TPT ទំងន់13​ ក្រាមពណ៌ស(W).', 'KG', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('224', 'USESTOCK-001', 'Tape OPP(ស្គត់)', 'ដុំ', '0.5000', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('225', 'USESTOCK-002', 'ថង់ច្រកដប25kg', 'គីឡូ', '41.2500', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('226', 'YT-EV0-006', 'Yellow Tail(YT)(ទឹកត្រីរូបត្រីកាម៉ុង)(12)', 'កេះ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('227', 'YT-EV0-006-D', 'Yellow Tail(YT)(ទឹកត្រីរូបត្រីកាម៉ុង)', 'គីឡូ', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('228', 'YT-EV0-006-G', 'Yellow Tail(YT)(ទឹកត្រីរូបត្រីកាម៉ុង)', 'ដប', '0.0000', '0.0000', '5.0000', 'no_image.png', '4', null, '', '', '', '', '', '', '0.0000', null, '1', null, null, 'code128', null, null, '0', 'standard', '0', null, '0', null, '0', null, '0', null, '0', null, null, '0', null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `erp_products` VALUES ('229', 'MT15-W', 'ឡតទឹកក្រូូចលេខកូដ MT ទំងន់15​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('230', 'MT22-W', 'ឡតទឹកក្រូូចលេខកូដ MT ទំងន់22​ ក្រាមពណ៌ស(W)(25kg)', 'បាវ', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('231', 'DT13-450-B-m', 'ដបមូលលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B)(200)', 'ថង់', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('232', 'dt13-450-w-m', 'ដបមូលលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W).', '1', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '1.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('233', 'Chhnok', 'ឆ្នុកកន្ទុមរុយ', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '5.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('234', 'VAN 20L(100)', 'វ៉ាន 20 លីត្រ(១០០)', '1', '0.0000', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('235', 'VAN 20L-UNIT', 'វ៉ាន 20 លីត្រ', '5', '0.0000', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '228.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('236', 'STEMP-005', 'តែម A1', '4', '0.0000', '0.0000', '5.0000', 'no_image.png', '6', null, '', '', '', '', '', '', '303000.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('237', 'Son tak', 'សន្ទះលើ', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '6.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('238', 'KAK', 'កាក់', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '4.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('239', 'PLA12.5-W', 'ឡតលេខកូដPLAទំងន់12.5​ ក្រាមពណ៌ស(W)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('240', 'PLA12.5-W-KG', 'ឡតលេខកូដ PLA ទំងន់12.5​ ក្រាមពណ៌ស(W)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('241', 'STEMP-006', 'តែម ក', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '6', null, '', '', '', '', '', '', '90.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('242', 'TN-15-350-V', 'ដបលេខកូដ​ TNឈ្មោះ ទំងន់ 15 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '1', '1.0783', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('243', 'DT33-W', 'ឡតលេខកូដ DT ទំងន់33​ ក្រាមពណ៌ស(W)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('244', 'DT33-W-KG', 'ឡតលេខកូដ DT ទំងន់33​ ក្រាមពណ៌ស(W).', '2', '1.0783', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('245', 'DT13-480-B', 'ដបមូលលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 480 ml ពណ៌ខៀវ(B)(200)', '1', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '10.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('246', 'DT13-480-B-D', 'ដបមូលលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 480 ml ពណ៌ខៀវ(B)(ខូច)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('247', 'TN17-V', 'ឡតលេខកូដ TN ទំងន់17​ ក្រាមពណ៌វិតាល់(V)(25kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('248', 'TN17-V-KG', 'ឡតលេខកូដ TN ទំងន់17 ក្រាមពណ៌វិតាល់(V).', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('249', 'TN17-500-V', 'ដបលេខកូដ​ TN ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(200)', '1', '1.0333', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('250', 'TN17-500-V-D', 'ដបលេខកូដ​ TN ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(ខូច)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('251', 'Caps-20L', 'គំរបធុង ២០លីត្រ', '3', '0.0000', '0.0000', '0.0000', 'no_image.png', '0', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('252', 'Stocks-20L', 'ឆ្នុកធុង 20លីត្រ', '2', '0.0000', '0.0000', '0.0000', 'no_image.png', '9', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', '1', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '174.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('254', 'DT33-750-W-D', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(ខូច)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('255', 'Caps-015-W-WIKA', 'គំរបស WIKA (10000)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('256', 'Caps-015-W-WIKA-UNIT', 'គំរបស WIKA', '3', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('257', 'LMS-SA-17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះSA ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(200)', '1', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '176.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('258', 'LMS-SA-17-500-V-D', 'ដបលេខកូដ​ LMSឈ្មោះSA ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(ខូច)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '20.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('260', '06LMS17-V-KG', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('261', 'TN32-W', 'ឡតលេខកូដ TN ទំងន់32​ ក្រាមពណ៌ស(W)(25kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('262', 'TN32-W-KG', 'ឡតលេខកូដ TN ទំងន់32ក្រាមពណ៌ស(W).', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', '0');
INSERT INTO `erp_products` VALUES ('263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', '1', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '586.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('264', 'Caps-016-WPL', 'គំរបសលាតPL(10000)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '35.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('265', 'Caps-016-WPL-UNIT', 'គំរបសលាតPL(10000)', '3', '0.0000', '0.0000', '5.0000', 'no_image.png', '3', null, '', '', '', '', '', '', '8200.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('266', 'HVP12.5-W', 'ឡតលេខកូដ HVP ទំងន់12.5​ ក្រាមពណ៌ស(W)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '122.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('267', 'HVP12.5-W-KG', 'ឡតលេខកូដ HVP ទំងន់12.5​ ក្រាមពណ៌ស(W)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('268', 'LMS32-W', 'ឡតលេខកូដ LMS ទំងន់32​ ក្រាមពណស(W)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('269', 'LMS32-V-KG', 'ឡតលេខកូដ LMS ទំងន់32​ ក្រាមពណ៏ស(W).', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('270', '34-W', 'ឡតលេខកូដ គ្មាន ទំងន់34 ក្រាមពណទឺកដោះគោ(W)(25kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '25.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('271', '34-W-KG', 'ឡតលេខកូដ គ្មាន ទំងន់34 ក្រាមពណទឺកដោះគោ(W).', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '1', null, '', '', '', '', '', '', '10.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('272', 'LMS-14-350-V', 'ដបលេខកូដ​ LMSទំងន់ 14ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '1', '0.0000', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '110.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('273', 'LO-005', 'ថង់អ៊ុតឡូ(14x14.5)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '8.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('274', 'LO-005-KG', 'ថង់អ៊ុតឡូ(14x14.5)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '-3.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('275', 'LO-006', 'ថង់អ៊ុតឡូ(37x37)(30kg)', '6', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '18.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('276', 'LO-006-KG', 'ថង់អ៊ុតឡូ(37x37)', '2', '0.0000', '0.0000', '5.0000', 'no_image.png', '5', null, '', '', '', '', '', '', '0.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);
INSERT INTO `erp_products` VALUES ('277', 'TAT-14.5-350-V', 'ដបលេខកូដ​ TATទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', '1', '1.0320', '0.0000', '5.0000', 'no_image.png', '2', null, '', '', '', '', '', '', '230.0000', '1', '1', '', null, 'code128', null, '', '0', 'standard', '0', null, null, null, null, null, null, null, null, null, null, null, null, '0000-00-00', '0000-00-00', null, null, null, null, null, 'USD', '0', null);

-- ----------------------------
-- Table structure for erp_product_photos
-- ----------------------------
DROP TABLE IF EXISTS `erp_product_photos`;
CREATE TABLE `erp_product_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_product_photos
-- ----------------------------

-- ----------------------------
-- Table structure for erp_product_prices
-- ----------------------------
DROP TABLE IF EXISTS `erp_product_prices`;
CREATE TABLE `erp_product_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `price_group_id` int(11) NOT NULL,
  `price` decimal(25,4) NOT NULL,
  `currency_code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `price_group_id` (`price_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_product_prices
-- ----------------------------

-- ----------------------------
-- Table structure for erp_product_variants
-- ----------------------------
DROP TABLE IF EXISTS `erp_product_variants`;
CREATE TABLE `erp_product_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `qty_unit` decimal(15,4) DEFAULT NULL,
  `currentcy_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_product_variants
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchases
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchases`;
CREATE TABLE `erp_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biller_id` int(11) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(11) NOT NULL,
  `supplier` varchar(55) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `product_discount` decimal(25,4) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_discount` decimal(25,4) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT NULL,
  `product_tax` decimal(25,4) DEFAULT NULL,
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `paid` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(55) DEFAULT '',
  `payment_status` varchar(20) DEFAULT 'pending',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `return_id` int(11) DEFAULT NULL,
  `surcharge` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `suspend_note` varchar(100) DEFAULT NULL,
  `reference_no_tax` varchar(100) NOT NULL,
  `tax_status` varchar(100) DEFAULT NULL,
  `purchase_type` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_purchases
-- ----------------------------
INSERT INTO `erp_purchases` VALUES ('1', '3', 'PO/1610/00001', '2016-10-04 14:44:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', '1', '2016-10-10 14:52:34', null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('2', '3', 'PO/1610/00002', '2016-10-04 15:53:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', '1', '2016-10-10 14:58:19', null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('3', '3', 'PO/1610/00003', '2016-10-04 14:58:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', '1', '2016-10-10 15:11:14', null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('4', '3', 'PO/1610/00004', '2016-10-05 15:19:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', null, null, null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('5', '3', 'PO/1610/00005', '2016-10-06 15:45:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', null, null, null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('6', '3', 'PO/1610/00006', '2016-10-06 15:46:00', '2', 'Supplier Company Name', '1', '', '1550.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '1550.0000', '0.0000', 'received', 'pending', '1', '1', '2016-10-11 14:36:02', null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('7', '3', 'PO/1610/00007', '2016-10-07 16:00:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', null, null, null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('8', '3', 'PO/1610/00008', '2016-10-07 15:01:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', null, null, null, '0', null, null, '0.0000', null, '', null, '1');
INSERT INTO `erp_purchases` VALUES ('9', '3', 'PO/1610/00009', '2016-10-08 15:05:00', '2', 'Supplier Company Name', '1', '', '0.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', '1', '1', '2016-10-11 14:24:13', null, '0', null, null, '0.0000', null, '', null, '1');

-- ----------------------------
-- Table structure for erp_purchase_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_items`;
CREATE TABLE `erp_purchase_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) DEFAULT NULL,
  `transfer_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(20) DEFAULT NULL,
  `discount` varchar(20) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `quantity_balance` decimal(15,4) DEFAULT '0.0000',
  `date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `unit_cost` decimal(25,4) DEFAULT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `supplier_part_no` varchar(50) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_purchase_items
-- ----------------------------
INSERT INTO `erp_purchase_items` VALUES ('1', null, null, '86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', null, '0.0000', '192.0000', '1', null, null, null, null, null, null, '0.0000', '141.0000', '2016-10-07', 'received', '0.0000', '0.0000', '192.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('2', null, null, '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', null, '0.0000', '437.0000', '1', null, null, null, null, null, null, '0.0000', '311.0000', '2016-10-07', 'received', '0.0000', '0.0000', '437.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('3', null, null, '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', null, '0.0000', '347.0000', '1', null, null, null, null, null, null, '0.0000', '533.0000', '2016-10-07', 'received', '0.0000', '0.0000', '347.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('4', null, null, '245', 'DT13-480-B', 'ដបមូលលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 480 ml ពណ៌ខៀវ(B)(200)', null, '0.0000', '10.0000', '1', null, null, null, null, null, null, '0.0000', '10.0000', '2016-10-07', 'received', '0.0000', '0.0000', '10.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('5', null, null, '253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', null, '0.0000', '117.0000', '1', null, null, null, null, null, null, '0.0000', '174.0000', '2016-10-07', 'received', '0.0000', '0.0000', '117.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('6', null, null, '117', 'DT13-450-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', null, '0.0000', '170.0000', '1', null, null, null, null, null, null, '0.0000', '345.0000', '2016-10-07', 'received', '0.0000', '0.0000', '170.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('7', null, null, '114', 'DT13-450-B', 'ដបជ្រុងលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ខៀវ(B)(200)', null, '0.0000', '189.0000', '1', null, null, null, null, null, null, '0.0000', '189.0000', '2016-10-07', 'received', '0.0000', '0.0000', '189.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('8', null, null, '77', 'DT-PW12.5-330-B', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B)(200)', null, '0.0000', '342.0000', '1', null, null, null, null, null, null, '0.0000', '312.0000', '2016-10-07', 'received', '0.0000', '0.0000', '342.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('9', null, null, '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', null, '0.0000', '231.0000', '1', null, null, null, null, null, null, '0.0000', '-47.0000', '2016-10-07', 'received', '0.0000', '0.0000', '231.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('10', null, null, '194', 'TAT-PW13.5-330-W', 'ដបលេខកូដ​ TATឈ្មោះដបPure Water(PW) ទំងន់ 13.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', null, '0.0000', '59.0000', '1', null, null, null, null, null, null, '0.0000', '59.0000', '2016-10-07', 'received', '0.0000', '0.0000', '59.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('11', null, null, '185', 'TAT-DNT14.5-350-W', 'ដបលេខកូដ​ TATឈ្មោះដបDanatech(DNT) ទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌ស(W)(200)', null, '0.0000', '56.0000', '1', null, null, null, null, null, null, '0.0000', '56.0000', '2016-10-07', 'received', '0.0000', '0.0000', '56.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('12', null, null, '169', 'MT-DNT17.5-500-W', 'ដបលេខកូដ​ MTឈ្មោះដបDanatech(DNT) ទំងន់ 17.5 ក្រាម​ ចំណុះ 500 ml ពណ៌ស(W)(200)', null, '0.0000', '110.0000', '1', null, null, null, null, null, null, '0.0000', '110.0000', '2016-10-07', 'received', '0.0000', '0.0000', '110.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('13', null, null, '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', null, '0.0000', '80.0000', '1', null, null, null, null, null, null, '0.0000', '260.0000', '2016-10-07', 'received', '0.0000', '0.0000', '80.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('14', null, null, '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', null, '0.0000', '22.0000', '1', null, null, null, null, null, null, '0.0000', '182.0000', '2016-10-07', 'received', '0.0000', '0.0000', '22.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('15', null, null, '257', 'LMS-SA-17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះSA ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(200)', null, '0.0000', '176.0000', '1', null, null, null, null, null, null, '0.0000', '176.0000', '2016-10-07', 'received', '0.0000', '0.0000', '176.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('16', null, null, '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', null, '0.0000', '41.0000', '1', null, null, null, null, null, null, '0.0000', '1421.0000', '2016-10-07', 'received', '0.0000', '0.0000', '41.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('17', null, null, '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', null, '0.0000', '3800.0000', '1', null, null, null, null, null, null, '0.0000', '-26390.0000', '2016-10-07', 'received', '0.0000', '0.0000', '3800.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('18', null, null, '56', 'Caps-010-GISO', 'គំរបបៃតងស្តង់ដា(10000)', null, '0.0000', '51.0000', '1', null, null, null, null, null, null, '0.0000', '50.0000', '2016-10-07', 'received', '0.0000', '0.0000', '51.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('19', null, null, '59', 'Caps-010-GISO-UNIT', 'គំរបបៃតងស្តង់ដា', null, '0.0000', '8200.0000', '1', null, null, null, null, null, null, '0.0000', '14200.0000', '2016-10-07', 'received', '0.0000', '0.0000', '8200.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('20', null, null, '24', 'Caps-002-BDT', 'គំរបខៀវលាតDT(10000)', null, '0.0000', '36.0000', '1', null, null, null, null, null, null, '0.0000', '34.0000', '2016-10-07', 'received', '0.0000', '0.0000', '36.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('21', null, null, '27', 'Caps-002-BDT-UNIT', 'គំរបខៀវលាតDT', null, '0.0000', '5000.0000', '1', null, null, null, null, null, null, '0.0000', '4600.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('22', null, null, '48', 'Caps-008-VISO', 'គំរបវីតាល់ស្តង់ដា(10000)', null, '0.0000', '30.0000', '1', null, null, null, null, null, null, '0.0000', '25.0000', '2016-10-07', 'received', '0.0000', '0.0000', '30.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('23', null, null, '51', 'Caps-008-VISO-UNIT', 'គំរបវីតាល់ស្តង់ដា', null, '0.0000', '3200.0000', '1', null, null, null, null, null, null, '0.0000', '3200.0000', '2016-10-07', 'received', '0.0000', '0.0000', '3200.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('24', null, null, '52', 'Caps-009-OISO', 'គំរបទឹកក្រូចស្តង់ដា(10000)', null, '0.0000', '13.0000', '1', null, null, null, null, null, null, '0.0000', '13.0000', '2016-10-07', 'received', '0.0000', '0.0000', '13.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('25', null, null, '55', 'Caps-009-OISO-UNIT', 'គំរបទឹកក្រូចស្តង់ដា', null, '0.0000', '5600.0000', '1', null, null, null, null, null, null, '0.0000', '5600.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5600.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('26', null, null, '68', 'Caps-013-PurpleLMS', 'គំរបស្វាយលាតLMS(6000)', null, '0.0000', '1.0000', '1', null, null, null, null, null, null, '0.0000', '1.0000', '2016-10-07', 'received', '0.0000', '0.0000', '1.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('27', null, null, '71', 'Caps-013-PurpleLMS-UNIT', 'គំរបស្វាយលាតLMS', null, '0.0000', '5000.0000', '1', null, null, null, null, null, null, '0.0000', '5000.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('28', null, null, '60', 'Caps-011-RISO', 'គំរបក្រហមស្តង់ដា(10000)', null, '0.0000', '7.0000', '1', null, null, null, null, null, null, '0.0000', '7.0000', '2016-10-07', 'received', '0.0000', '0.0000', '7.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('29', null, null, '63', 'Caps-011-RISO-UNIT', 'គំរបក្រហមស្តង់ដា', null, '0.0000', '6000.0000', '1', null, null, null, null, null, null, '0.0000', '6000.0000', '2016-10-07', 'received', '0.0000', '0.0000', '6000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('30', null, null, '44', 'Caps-007-PUST', 'គំរបផ្កាឈូកលាតUST(10000)', null, '0.0000', '3.0000', '1', null, null, null, null, null, null, '0.0000', '2.0000', '2016-10-07', 'received', '0.0000', '0.0000', '3.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('31', null, null, '40', 'Caps-006-BUST', 'គំរបខៀវលាតUST(10000)', null, '0.0000', '6.0000', '1', null, null, null, null, null, null, '0.0000', '6.0000', '2016-10-07', 'received', '0.0000', '0.0000', '6.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('32', null, null, '43', 'Caps-006-BUST-UNIT', 'គំរបខៀវលាតUST', null, '0.0000', '5000.0000', '1', null, null, null, null, null, null, '0.0000', '5000.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('33', null, null, '32', 'Caps-004-V', 'គំរបវីតាល់ធម្មតា(10000)', null, '0.0000', '15.0000', '1', null, null, null, null, null, null, '0.0000', '15.0000', '2016-10-07', 'received', '0.0000', '0.0000', '15.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('34', null, null, '35', 'Caps-004-V-UNIT', 'គំរបវីតាល់ធម្មតា', null, '0.0000', '5000.0000', '1', null, null, null, null, null, null, '0.0000', '5000.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('35', null, null, '28', 'Caps-003-W', 'គំរបសក្រញាំឬសធម្មតា(10000)', null, '0.0000', '2.0000', '1', null, null, null, null, null, null, '0.0000', '2.0000', '2016-10-07', 'received', '0.0000', '0.0000', '2.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('36', null, null, '31', 'Caps-003-W-UNIT', 'គំរបសក្រញាំឬសធម្មតា', null, '0.0000', '9000.0000', '1', null, null, null, null, null, null, '0.0000', '9000.0000', '2016-10-07', 'received', '0.0000', '0.0000', '9000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('37', null, null, '206', 'TAT14.5-W', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌ស(W)(25kg)', null, '0.0000', '21.0000', '1', null, null, null, null, null, null, '0.0000', '21.0000', '2016-10-07', 'received', '0.0000', '0.0000', '21.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('38', null, null, '207', 'TAT14.5-W-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌ស(W).', null, '0.0000', '15.0000', '1', null, null, null, null, null, null, '0.0000', '15.0000', '2016-10-07', 'received', '0.0000', '0.0000', '15.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('39', null, null, '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', null, '0.0000', '79.0000', '1', null, null, null, null, null, null, '0.0000', '120.0000', '2016-10-07', 'received', '0.0000', '0.0000', '79.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('40', null, null, '261', 'TN32-W', 'ឡតលេខកូដ TN ទំងន់32​ ក្រាមពណ៌ស(W)(25kg)', null, '0.0000', '38.0000', '1', null, null, null, null, null, null, '0.0000', '0.0000', '2016-10-07', 'received', '0.0000', '0.0000', '38.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('41', null, null, '156', '05LMS17-V', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', null, '0.0000', '33.0000', '1', null, null, null, null, null, null, '0.0000', '1.0000', '2016-10-07', 'received', '0.0000', '0.0000', '33.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('42', null, null, '157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', null, '0.0000', '10.0000', '1', null, null, null, null, null, null, '0.0000', '0.0000', '2016-10-07', 'received', '0.0000', '0.0000', '10.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('43', null, null, '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', null, '0.0000', '1.0000', '1', null, null, null, null, null, null, '0.0000', '20.0000', '2016-10-07', 'received', '0.0000', '0.0000', '1.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('44', null, null, '18', 'BV16-V', 'ឡតលេខកូដ BV ទំងន់16​ ក្រាមពណវីតាល់(V)(25kg)', null, '0.0000', '99.0000', '1', null, null, null, null, null, null, '0.0000', '99.0000', '2016-10-07', 'received', '0.0000', '0.0000', '99.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('45', null, null, '19', 'BV16-V-KG', 'ឡតលេខកូដ BV ទំងន់16​ ក្រាមពណវីតាល់(V).', null, '0.0000', '18.0000', '1', null, null, null, null, null, null, '0.0000', '18.0000', '2016-10-07', 'received', '0.0000', '0.0000', '18.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('46', null, null, '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', null, '0.0000', '41.0000', '1', null, null, null, null, null, null, '0.0000', '29.0000', '2016-10-07', 'received', '0.0000', '0.0000', '41.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('47', null, null, '126', 'DT13-W-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W).', null, '0.0000', '17.0000', '1', null, null, null, null, null, null, '0.0000', '0.0000', '2016-10-07', 'received', '0.0000', '0.0000', '17.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('48', null, null, '127', 'DT13.5-B', 'ឡតលេខកូដ DT ទំងន់13.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', null, '0.0000', '34.0000', '1', null, null, null, null, null, null, '0.0000', '34.0000', '2016-10-07', 'received', '0.0000', '0.0000', '34.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('49', null, null, '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', null, '0.0000', '37.0000', '1', null, null, null, null, null, null, '0.0000', '58.0000', '2016-10-07', 'received', '0.0000', '0.0000', '37.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('50', null, null, '158', 'LO-001', 'ថង់អ៊ុតឡូ(13x14.5)(30kg)', null, '0.0000', '3.0000', '1', null, null, null, null, null, null, '0.0000', '3.0000', '2016-10-07', 'received', '0.0000', '0.0000', '3.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('51', null, null, '159', 'LO-001-KG', 'ថង់អ៊ុតឡូ(13x14.5)', null, '0.0000', '9.0000', '1', null, null, null, null, null, null, '0.0000', '9.0000', '2016-10-07', 'received', '0.0000', '0.0000', '9.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('52', null, null, '160', 'LO-002', 'ថង់អ៊ុតឡូ(14.5x15)(30kg)', null, '0.0000', '5.0000', '1', null, null, null, null, null, null, '0.0000', '4.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('53', null, null, '162', 'LO-003', 'ថង់អ៊ុតឡូ(15x15.5)(30kg)', null, '0.0000', '1.0000', '1', null, null, null, null, null, null, '0.0000', '0.0000', '2016-10-07', 'received', '0.0000', '0.0000', '1.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('54', null, null, '236', 'STEMP-005', 'តែម A1', null, '0.0000', '303000.0000', '1', null, null, null, null, null, null, '0.0000', '303000.0000', '2016-10-07', 'received', '0.0000', '0.0000', '303000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('55', null, null, '177', 'STEMP-003', 'តែមកំពង់ត្រាំ', null, '0.0000', '91000.0000', '1', null, null, null, null, null, null, '0.0000', '90970.0000', '2016-10-07', 'received', '0.0000', '0.0000', '91000.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('56', null, null, '233', 'Chhnok', 'ឆ្នុកកន្ទុមរុយ', null, '0.0000', '5.0000', '1', null, null, null, null, null, null, '0.0000', '5.0000', '2016-10-07', 'received', '0.0000', '0.0000', '5.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('57', null, null, '237', 'Son tak', 'សន្ទះលើ', null, '0.0000', '6.0000', '1', null, null, null, null, null, null, '0.0000', '6.0000', '2016-10-07', 'received', '0.0000', '0.0000', '6.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('58', null, null, '238', 'KAK', 'កាក់', null, '0.0000', '4.0000', '1', null, null, null, null, null, null, '0.0000', '4.0000', '2016-10-07', 'received', '0.0000', '0.0000', '4.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('59', null, null, '235', 'VAN 20L-UNIT', 'វ៉ាន 20 លីត្រ', null, '0.0000', '228.0000', '1', null, null, null, null, null, null, '0.0000', '228.0000', '2016-10-07', 'received', '0.0000', '0.0000', '228.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('60', null, null, '8', 'BAGE-001', 'កាដុងមាត់តូច 20L', null, '0.0000', '20.0000', '1', null, null, null, null, null, null, '0.0000', '40.0000', '2016-10-07', 'received', '0.0000', '0.0000', '20.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('61', null, null, '9', 'BAGE-002', 'កាដុងមាត់ធំ 20L', null, '0.0000', '135.0000', '1', null, null, null, null, null, null, '0.0000', '133.0000', '2016-10-07', 'received', '0.0000', '0.0000', '135.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('62', null, null, '4', 'AV-001', 'អាវ20L​ កខ្លី(50kg)', null, '0.0000', '4.0000', '1', null, null, null, null, null, null, '0.0000', '4.0000', '2016-10-07', 'received', '0.0000', '0.0000', '4.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('63', null, null, '6', 'AV-002', 'អាវ20L​ កវែង(50kg)', null, '0.0000', '1.0000', '1', null, null, null, null, null, null, '0.0000', '1.0000', '2016-10-07', 'received', '0.0000', '0.0000', '1.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('64', null, null, '7', 'AV-002-Kg', 'អាវ20L​ កវែង', null, '0.0000', '9.0000', '1', null, null, null, null, null, null, '0.0000', '9.0000', '2016-10-07', 'received', '0.0000', '0.0000', '9.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('65', null, null, '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', null, '0.0000', '558.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '586.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('66', null, null, '264', 'Caps-016-WPL', 'គំរបសលាតPL(10000)', null, '0.0000', '45.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '35.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('67', null, null, '265', 'Caps-016-WPL-UNIT', 'គំរបសលាតPL(10000)', null, '0.0000', '9000.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '8200.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('68', null, null, '266', 'HVP12.5-W', 'ឡតលេខកូដ HVP ទំងន់12.5​ ក្រាមពណ៌ស(W)(30kg)', null, '0.0000', '31.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '22.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('69', null, null, '270', '34-W', 'ឡតលេខកូដ គ្មាន ទំងន់34 ក្រាមពណទឺកដោះគោ(W)(25kg)', null, '0.0000', '25.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '25.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('70', null, null, '271', '34-W-KG', 'ឡតលេខកូដ គ្មាន ទំងន់34 ក្រាមពណទឺកដោះគោ(W).', null, '0.0000', '10.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '10.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('71', null, null, '272', 'LMS-14-350-V', 'ដបលេខកូដ​ LMSទំងន់ 14ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', null, '0.0000', '110.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '110.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('72', null, null, '273', 'LO-005', 'ថង់អ៊ុតឡូ(14x14.5)(30kg)', null, '0.0000', '8.0000', '1', '0.0000', '1', '0.0000', null, null, null, '0.0000', '8.0000', '2016-10-07', 'received', '0.0000', null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('73', null, null, '179', 'SY-EV0-001', 'Srok Yoeung(SY)(ទឹកស៊ីអ៊ីវ​ ស្រុកយើង)(12)', null, '0.0000', '294.0000', '1', null, null, null, null, null, null, '0.0000', '294.0000', '2016-10-10', 'received', '0.0000', '0.0000', '294.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('74', null, null, '181', 'SY-EV0-001-G', 'Srok Yoeung(SY)(ទឹកស៊ីអ៊ីវ​ ស្រុកយើង)', null, '0.0000', '3.0000', '1', null, null, null, null, null, null, '0.0000', '3.0000', '2016-10-10', 'received', '0.0000', '0.0000', '3.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('75', null, null, '141', 'KY-EV0-002', 'Khmer Yoeung(KY)(ទឹកស៊ីអ៊ីវ​ ខ្មែរយើង)(12)', null, '0.0000', '3.0000', '1', null, null, null, null, null, null, '0.0000', '3.0000', '2016-10-10', 'received', '0.0000', '0.0000', '3.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('76', null, null, '143', 'KY-EV0-002-G', 'Khmer Yoeung(KY)(ទឹកស៊ីអ៊ីវ​ ខ្មែរយើង)', null, '0.0000', '5.0000', '1', null, null, null, null, null, null, '0.0000', '5.0000', '2016-10-10', 'received', '0.0000', '0.0000', '5.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('77', null, null, '1', 'AS-EV0-003', 'All Season(AS)(ទឹកស៊ីអ៊ីវ​ អលស៊ីសិន)(12)', null, '0.0000', '41.0000', '1', null, null, null, null, null, null, '0.0000', '41.0000', '2016-10-10', 'received', '0.0000', '0.0000', '41.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('78', null, null, '3', 'AS-EV0-003-G', 'All Season(AS)(ទឹកស៊ីអ៊ីវ​ អលស៊ីសិន)', null, '0.0000', '2.0000', '1', null, null, null, null, null, null, '0.0000', '2.0000', '2016-10-10', 'received', '0.0000', '0.0000', '2.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('79', null, null, '166', 'MA-EV0-004', 'Match All(MA)(ទឹកស៊ីអ៊ីវ​ ម៉ាច់អល)(12)', null, '0.0000', '39.0000', '1', null, null, null, null, null, null, '0.0000', '39.0000', '2016-10-10', 'received', '0.0000', '0.0000', '39.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('80', null, null, '168', 'MA-EV0-004-G', 'Match All(MA)(ទឹកស៊ីអ៊ីវ​ ម៉ាច់អល)', null, '0.0000', '7.0000', '1', null, null, null, null, null, null, '0.0000', '7.0000', '2016-10-10', 'received', '0.0000', '0.0000', '7.0000', null, null);
INSERT INTO `erp_purchase_items` VALUES ('82', '1', null, '204', 'TAT14.5-V', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)(25kg)', '0', '0.0000', '68.0000', '1', '0.0000', '0', '', '0', '0.0000', null, '0.0000', '68.0000', '2016-10-04', 'received', '0.0000', '0.0000', '68.0000', null, '0');
INSERT INTO `erp_purchase_items` VALUES ('84', '2', null, '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '0', '0.0000', '11.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', null, '0.0000', '11.0000', '2016-10-04', 'received', '0.0000', '0.0000', '11.0000', null, '0');
INSERT INTO `erp_purchase_items` VALUES ('86', '3', null, '275', 'LO-006', 'ថង់អ៊ុតឡូ(37x37)(30kg)', '0', '0.0000', '20.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', null, '0.0000', '18.0000', '2016-10-04', 'received', '0.0000', '0.0000', '20.0000', null, '0');
INSERT INTO `erp_purchase_items` VALUES ('87', '4', null, '241', 'STEMP-006', 'តែម ក', '0', '0.0000', '30.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', null, '0.0000', '30.0000', '2016-10-05', 'received', '0.0000', '0.0000', null, null, '0');
INSERT INTO `erp_purchase_items` VALUES ('88', null, null, '205', 'TAT14.5-V-KG', 'ឡតលេខកូដ TAT ទំងន់14.5​ ក្រាមពណ៌វីតាល់(V)', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '0.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('89', null, null, '262', 'TN32-W-KG', 'ឡតលេខកូដ TN ទំងន់32ក្រាមពណ៌ស(W).', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '0.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('90', null, null, '277', 'TAT-14.5-350-V', 'ដបលេខកូដ​ TATទំងន់ 14.5 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '230.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('91', '5', null, '259', '06LMS17-V', '06ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V)(30kg)', '0', '0.0000', '27.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', null, '0.0000', '27.0000', '2016-10-06', 'received', '0.0000', '0.0000', null, null, '0');
INSERT INTO `erp_purchase_items` VALUES ('93', null, null, '126', 'DT13-W-KG', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W).', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '19.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('95', '7', null, '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', '0', '0.0000', '100.0000', '1', '0.0000', '0', '', '0', '0.0000', null, '0.0000', '73.0000', '2016-10-07', 'received', '0.0000', '0.0000', null, null, '0');
INSERT INTO `erp_purchase_items` VALUES ('96', '8', null, '241', 'STEMP-006', 'តែម ក', '0', '0.0000', '60.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', null, '0.0000', '60.0000', '2016-10-07', 'received', '0.0000', '0.0000', null, null, '0');
INSERT INTO `erp_purchase_items` VALUES ('97', null, null, '102', 'DT12.5-B-KG', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '41.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('99', null, null, '47', 'Caps-007-PUST-UNIT', 'គំរបផ្កាឈូកលាតUST', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '8000.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('100', null, null, '157', '05LMS17-V-KG', '05ឡតលេខកូដ LMS ទំងន់17​ ក្រាមពណវីតាល់(V).', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '22.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('101', '9', null, '266', 'HVP12.5-W', 'ឡតលេខកូដ HVP ទំងន់12.5​ ក្រាមពណ៌ស(W)(30kg)', '0', '0.0000', '100.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', null, '0.0000', '100.0000', '2016-10-08', 'received', '0.0000', '0.0000', '100.0000', null, '0');
INSERT INTO `erp_purchase_items` VALUES ('102', '6', null, '101', 'DT12.5-B', 'ឡតលេខកូដ DT ទំងន់12.5​ ក្រាមពណ៌ខៀវ(B)(30kg)', '0', '31.0000', '50.0000', '1', '0.0000', '0', '', '0', '0.0000', null, '1550.0000', '50.0000', '2016-10-06', 'received', '31.0000', '14.3519', '50.0000', null, '0');
INSERT INTO `erp_purchase_items` VALUES ('103', null, null, '58', '', '', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '-1.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('104', null, null, '92', '', '', null, '0.0000', '0.0000', '2', '0.0000', null, null, null, null, null, '0.0000', '-20.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('105', null, null, '23', '', '', null, '0.0000', '0.0000', '2', '0.0000', null, null, null, null, null, '0.0000', '-4600.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('106', null, null, '53', '', '', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '-1.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('107', null, null, '122', '', '', null, '0.0000', '0.0000', '2', '0.0000', null, null, null, null, null, '0.0000', '-7.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('108', null, null, '144', '', '', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '-100.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('109', null, null, '274', '', '', null, '0.0000', '0.0000', '1', '0.0000', null, null, null, null, null, '0.0000', '-3.0000', '0000-00-00', '', null, null, null, null, null);
INSERT INTO `erp_purchase_items` VALUES ('110', null, null, '59', '', '', null, '0.0000', '0.0000', '2', '0.0000', null, null, null, null, null, '0.0000', '-200.0000', '0000-00-00', '', null, null, null, null, null);

-- ----------------------------
-- Table structure for erp_purchase_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_tax`;
CREATE TABLE `erp_purchase_tax` (
  `vat_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(100) DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `purchase_id` varchar(10) DEFAULT NULL,
  `purchase_ref` varchar(100) DEFAULT NULL,
  `supplier_id` varchar(100) DEFAULT NULL,
  `issuedate` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `qty` double(25,4) DEFAULT NULL,
  `vatin` varchar(100) DEFAULT NULL,
  `amount` decimal(25,4) DEFAULT NULL,
  `amount_tax` decimal(25,4) DEFAULT NULL,
  `amount_declear` decimal(25,4) DEFAULT NULL,
  `non_tax_pur` double(25,4) DEFAULT NULL,
  `tax_value` double(25,4) DEFAULT NULL,
  `vat` double(25,4) DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `journal_location` varchar(255) DEFAULT NULL,
  `journal_date` date DEFAULT NULL,
  `amount_tax_declare` decimal(25,4) DEFAULT NULL,
  `value_import` decimal(25,4) DEFAULT NULL,
  `purchase_type` int(1) DEFAULT NULL,
  PRIMARY KEY (`vat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_purchase_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_quotes
-- ----------------------------
DROP TABLE IF EXISTS `erp_quotes`;
CREATE TABLE `erp_quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `internal_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT NULL,
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `supplier` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_quotes
-- ----------------------------

-- ----------------------------
-- Table structure for erp_quote_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_quote_items`;
CREATE TABLE `erp_quote_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quote_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quote_id` (`quote_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_quote_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_related_products
-- ----------------------------
DROP TABLE IF EXISTS `erp_related_products`;
CREATE TABLE `erp_related_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(50) DEFAULT NULL,
  `related_product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_related_products
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_items`;
CREATE TABLE `erp_return_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) unsigned NOT NULL,
  `return_id` int(11) unsigned NOT NULL,
  `sale_item_id` int(11) DEFAULT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_id` (`sale_id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`,`sale_id`),
  KEY `sale_id_2` (`sale_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_purchases
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_purchases`;
CREATE TABLE `erp_return_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `supplier` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `surcharge` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_purchases
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_purchase_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_purchase_items`;
CREATE TABLE `erp_return_purchase_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) unsigned NOT NULL,
  `return_id` int(11) unsigned NOT NULL,
  `purchase_item_id` int(11) DEFAULT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`,`purchase_id`),
  KEY `purchase_id_2` (`purchase_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_purchase_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_sales
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_sales`;
CREATE TABLE `erp_return_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `surcharge` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_sales
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_tax_back
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_tax_back`;
CREATE TABLE `erp_return_tax_back` (
  `orderlineno` int(11) DEFAULT NULL,
  `tax_return_id` int(11) DEFAULT NULL,
  `itemcode` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `specific_tax` double DEFAULT NULL,
  `amount_tax` double DEFAULT NULL,
  `inv_num` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_tax_back
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_tax_front
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_tax_front`;
CREATE TABLE `erp_return_tax_front` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT '0',
  `credit_lmonth04` double DEFAULT '0',
  `precaba_month05` double DEFAULT '0',
  `premonth_rate06` double DEFAULT '0',
  `crecarry_forward07` double DEFAULT '0',
  `preprofit_taxdue08` double DEFAULT '0',
  `sptax_calbase09` double DEFAULT '0',
  `sptax_duerate10` double DEFAULT '0',
  `sptax_calbase11` double DEFAULT '0',
  `sptax_duerate12` double DEFAULT '0',
  `taxacc_calbase13` double DEFAULT '0',
  `taxacc_duerate14` double DEFAULT '0',
  `taxpuli_calbase15` double DEFAULT '0',
  `specify` varchar(100) DEFAULT '',
  `taxpuli_duerate16` double DEFAULT '0',
  `tax_calbase17` double DEFAULT '0',
  `tax_duerate18` double DEFAULT '0',
  `total_taxdue19` double DEFAULT '0',
  `covreturn_start` date DEFAULT NULL,
  `covreturn_end` date DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `year` int(11) DEFAULT '0',
  `month` int(11) DEFAULT '0',
  `filed_in_kh` varchar(100) DEFAULT NULL,
  `filed_in_en` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_tax_front
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_value_added_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_value_added_tax`;
CREATE TABLE `erp_return_value_added_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT '0',
  `pusa_act04` varchar(100) DEFAULT '',
  `tax_credit_premonth05` varchar(100) DEFAULT '',
  `ncredit_purch06` varchar(100) DEFAULT '',
  `strate_purch07` varchar(100) DEFAULT '',
  `strate_purch08` varchar(100) DEFAULT '',
  `strate_imports09` varchar(100) DEFAULT '',
  `strate_imports10` varchar(100) DEFAULT '',
  `total_intax11` varchar(100) DEFAULT '',
  `ntaxa_sales12` varchar(100) DEFAULT '',
  `exports13` varchar(100) DEFAULT '',
  `strate_sales14` varchar(100) DEFAULT '',
  `strate_sales15` varchar(100) DEFAULT '',
  `pay_difference16` varchar(100) DEFAULT '',
  `refund17` varchar(100) DEFAULT '',
  `credit_forward18` varchar(100) DEFAULT '',
  `covreturn_start` date DEFAULT NULL,
  `covreturn_end` date DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `year` int(11) DEFAULT '0',
  `month` int(11) DEFAULT '0',
  `field_in_kh` varchar(100) DEFAULT NULL,
  `field_in_en` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_value_added_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_value_added_tax_back
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_value_added_tax_back`;
CREATE TABLE `erp_return_value_added_tax_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value_id` int(11) DEFAULT '0',
  `productid` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `inv_cust_desc` varchar(255) DEFAULT NULL,
  `supp_exp_inn` varchar(255) DEFAULT NULL,
  `val_vat` varchar(255) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `val_vat_g` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_value_added_tax_back
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_withholding_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_withholding_tax`;
CREATE TABLE `erp_return_withholding_tax` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT '0',
  `covreturn_start` date DEFAULT NULL,
  `covreturn_end` date DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `month` int(11) DEFAULT '0',
  `taxref` varchar(255) DEFAULT NULL,
  `field_in_kh` varchar(255) DEFAULT NULL,
  `field_in_en` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_withholding_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_withholding_tax_back
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_withholding_tax_back`;
CREATE TABLE `erp_return_withholding_tax_back` (
  `withholding_id` varchar(10) DEFAULT NULL,
  `emp_code` varchar(100) DEFAULT NULL,
  `object_of_payment` varchar(255) DEFAULT NULL,
  `invoice_paynote` varchar(255) DEFAULT NULL,
  `amount_paid` double DEFAULT NULL,
  `tax_rate` double DEFAULT NULL,
  `withholding_tax` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_withholding_tax_back
-- ----------------------------

-- ----------------------------
-- Table structure for erp_return_withholding_tax_front
-- ----------------------------
DROP TABLE IF EXISTS `erp_return_withholding_tax_front`;
CREATE TABLE `erp_return_withholding_tax_front` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `withholding_id` int(11) DEFAULT '0',
  `amount_paid` double DEFAULT '0',
  `tax_rate` double DEFAULT '1',
  `withholding_tax` double DEFAULT '0',
  `remarks` text,
  `type` varchar(10) DEFAULT NULL,
  `type_of_oop` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_return_withholding_tax_front
-- ----------------------------

-- ----------------------------
-- Table structure for erp_salary_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_salary_tax`;
CREATE TABLE `erp_salary_tax` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT '0',
  `covreturn_start` date DEFAULT NULL,
  `covreturn_end` date DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `year` int(11) DEFAULT '0',
  `month` int(11) DEFAULT '0',
  `filed_in_kh` varchar(255) DEFAULT '0',
  `filed_in_en` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_salary_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_salary_tax_back
-- ----------------------------
DROP TABLE IF EXISTS `erp_salary_tax_back`;
CREATE TABLE `erp_salary_tax_back` (
  `orderno` int(11) NOT NULL AUTO_INCREMENT,
  `salary_tax_id` int(11) NOT NULL,
  `empcode` varchar(50) DEFAULT '0',
  `salary_paid` double(25,8) DEFAULT NULL,
  `spouse` int(10) DEFAULT NULL,
  `minor_children` int(5) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `date_insert` date DEFAULT NULL,
  `tax_type` varchar(50) NOT NULL,
  `tax_rate` double(25,8) DEFAULT NULL,
  `tax_salary` double(25,8) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_salary_tax_back
-- ----------------------------

-- ----------------------------
-- Table structure for erp_salary_tax_front
-- ----------------------------
DROP TABLE IF EXISTS `erp_salary_tax_front`;
CREATE TABLE `erp_salary_tax_front` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `salary_tax_id` int(11) DEFAULT '0',
  `emp_num` int(11) DEFAULT '0',
  `salary_paid` double DEFAULT '0',
  `spouse_num` int(11) DEFAULT '0',
  `children_num` int(11) DEFAULT '0',
  `tax_salcalbase` double DEFAULT '0',
  `tax_rate` double DEFAULT '1',
  `tax_salary` double DEFAULT '0',
  `tax_type` char(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_salary_tax_front
-- ----------------------------

-- ----------------------------
-- Table structure for erp_sales
-- ----------------------------
DROP TABLE IF EXISTS `erp_sales`;
CREATE TABLE `erp_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `staff_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `sale_status` varchar(20) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_items` tinyint(4) DEFAULT NULL,
  `total_cost` decimal(25,4) NOT NULL,
  `pos` tinyint(1) NOT NULL DEFAULT '0',
  `paid` decimal(25,4) DEFAULT '0.0000',
  `return_id` int(11) DEFAULT NULL,
  `surcharge` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL,
  `attachment1` varchar(55) DEFAULT NULL,
  `attachment2` varchar(55) DEFAULT NULL,
  `suspend_note` varchar(20) DEFAULT NULL,
  `other_cur_paid` decimal(25,0) DEFAULT NULL,
  `other_cur_paid_rate` decimal(25,0) DEFAULT '1',
  `other_cur_paid1` decimal(25,4) DEFAULT NULL,
  `other_cur_paid_rate1` decimal(25,4) DEFAULT NULL,
  `saleman_by` int(11) DEFAULT NULL,
  `reference_no_tax` varchar(55) NOT NULL,
  `tax_status` varchar(255) DEFAULT NULL,
  `opening_ar` tinyint(1) DEFAULT '0',
  `sale_type` int(1) DEFAULT NULL,
  `delivery` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_sales
-- ----------------------------
INSERT INTO `erp_sales` VALUES ('1', '2016-10-03 02:00:00', 'SALE/1610/00001', '107', 'កាំកូរ', '3', 'SPP សែនសុខ', '1', '', '', '57.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '57.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '57.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('3', '2016-10-05 06:25:00', 'SALE/1610/00003', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '150.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '150.0000', 'completed', 'pending', '0', null, '1', null, null, '127', '0.0000', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('4', '2016-10-05 15:25:00', 'SALE/1610/00004', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '82.7500', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '82.7500', 'completed', 'paid', '0', null, '1', null, null, '127', '0.9800', '0', '82.7500', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('5', '2016-10-05 10:25:00', 'SALE/1610/00005', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '39.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '39.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '39.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('6', '2016-10-05 10:25:00', 'SALE/1610/00006', '37', 'OKកាហ្វេ', '3', 'SPP សែនសុខ', '1', '', '', '45.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '45.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '45.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('7', '2016-10-05 09:25:00', 'SALE/1610/00007', '35', 'អាមួយបឺងសាឡាង', '3', 'SPP សែនសុខ', '1', '', '', '180.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '180.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '180.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('8', '2016-10-05 09:25:00', 'SALE/1610/00008', '42', 'ចែធីតាទួលគោក', '3', 'SPP សែនសុខ', '1', '', '', '35.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '35.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '35.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('9', '2016-10-05 09:45:00', 'SALE/1610/00009', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '96.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '96.0000', 'completed', 'paid', '0', null, '1', null, null, '2', '0.0000', '0', '96.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('10', '2016-10-05 10:25:00', 'SALE/1610/00010', '53', 'អង្គតាមិុញ', '3', 'SPP សែនសុខ', '1', '', '', '65.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '65.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '65.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('11', '2016-10-05 09:25:00', 'SALE/1610/00011', '11', 'កំពង់ស្ពឺ', '3', 'SPP សែនសុខ', '1', '', '', '105.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '105.0000', 'completed', 'paid', '0', null, '1', null, null, '30', '0.0000', '0', '105.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('12', '2016-10-05 10:30:00', 'SALE/1610/00012', '76', 'បងឌីkm4', '3', 'SPP សែនសុខ', '1', '', '', '17.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '17.0000', 'completed', 'pending', '0', null, '1', null, null, '127', '0.0000', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('13', '2016-10-05 09:25:00', 'SALE/1610/00013', '54', 'កោសដូង', '3', 'SPP សែនសុខ', '1', '', '', '114.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '114.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '114.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('14', '2016-10-05 05:25:00', 'SALE/1610/00014', '43', 'ចឹកគឺkm6', '3', 'SPP សែនសុខ', '1', '', '', '823.2000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '823.2000', 'completed', 'pending', '0', null, '1', null, null, '70', '72.2400', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('15', '2016-10-05 10:45:00', 'SALE/1610/00015', '74', 'សំណង់12', '3', 'SPP សែនសុខ', '1', '', '', '750.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '750.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '154.8000', '0', '750.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('16', '2016-10-06 10:30:00', 'SALE/1610/00016', '4', 'General', '3', 'SPP សែនសុខ', '2', '', '', '31.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '31.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '31.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('17', '2016-10-06 10:30:00', 'SALE/1610/00017', '65', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', 'SPP សែនសុខ', '1', '', '', '652.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '652.0000', 'completed', 'pending', '0', null, '1', null, null, '92', '94.9440', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('18', '2016-10-06 06:30:00', 'SALE/1610/00018', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '37.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '37.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '37.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('19', '2016-10-06 10:45:00', 'SALE/1610/00019', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '42.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '42.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '42.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('20', '2016-10-07 10:30:00', 'SALE/1610/00020', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '32.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '32.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '32.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('21', '2016-10-07 10:30:00', 'SALE/1610/00021', '54', 'កោសដូង', '3', 'SPP សែនសុខ', '1', '', '', '71.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '71.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '1.0320', '0', '71.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('22', '2016-10-08 06:30:00', 'SALE/1610/00022', '67', 'ពូវណ្ណាស្ពានទី10', '3', 'SPP សែនសុខ', '1', '', '', '500.0000', '90.0000', null, '90.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '500.0000', 'completed', 'pending', '0', null, '1', '1', '2016-10-11 16:24:23', '102', '103.2000', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('23', '2016-10-07 06:25:00', 'SALE/1610/00023', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '70.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '70.0000', 'completed', 'pending', '0', null, '1', null, null, '127', '0.0000', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('24', '2016-10-07 06:30:00', 'SALE/1610/00024', '4', 'General', '3', 'SPP សែនសុខ', '2', '', '', '23.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '23.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '23.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('25', '2016-10-07 10:25:00', 'SALE/1610/00025', '35', 'អាមួយបឺងសាឡាង', '3', 'SPP សែនសុខ', '1', '', '', '304.0000', '45.0000', null, '45.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '304.0000', 'completed', 'paid', '0', null, '1', null, null, '51', '0.0000', '0', '304.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('26', '2016-10-08 09:25:00', 'SALE/1610/00026', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '162.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '162.0000', 'completed', 'paid', '0', null, '1', '1', '2016-10-11 16:23:47', '127', '0.0000', '0', '162.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('27', '2016-10-07 10:25:00', 'SALE/1610/00027', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '32.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '32.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '32.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('28', '2016-10-07 10:30:00', 'SALE/1610/00028', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '363.0000', '45.0000', null, '45.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '363.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '363.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('29', '2016-10-07 10:30:00', 'SALE/1610/00029', '43', 'ចឹកគឺkm6', '3', 'SPP សែនសុខ', '1', '', '', '847.7200', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '847.7200', 'completed', 'paid', '0', null, '1', null, null, '98', '48.5040', '0', '847.7200', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('30', '2016-10-08 10:30:00', 'SALE/1610/00030', '8', 'ពារាំង', '3', 'SPP សែនសុខ', '1', '', '', '1500.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '1500.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '309.6000', '0', '1500.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('31', '2016-10-08 10:30:00', 'SALE/1610/00031', '15', 'ប្អូនចែ 77(បឹងសាឡាង)', '3', 'SPP សែនសុខ', '1', '', '', '587.0000', '90.0000', null, '90.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '587.0000', 'completed', 'paid', '0', null, '1', null, null, '102', '0.0000', '0', '587.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('32', '2016-10-08 10:30:00', 'SALE/1610/00032', '85', 'ផ្សារដើមគរ', '3', 'SPP សែនសុខ', '1', '', '', '32.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '32.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '32.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('33', '2016-10-08 11:30:00', 'SALE/1610/00033', '85', 'ផ្សារដើមគរ', '3', 'SPP សែនសុខ', '1', '', '', '32.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '32.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '32.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('34', '2016-10-08 10:25:00', 'SALE/1610/00034', '4', 'General', '3', 'SPP សែនសុខ', '2', '', '', '45.5000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '45.5000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '45.5000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('35', '2016-10-08 10:30:00', 'SALE/1610/00035', '11', 'កំពង់ស្ពឺ', '3', 'SPP សែនសុខ', '1', '', '', '3530.0000', '130.0000', null, '130.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '3530.0000', 'completed', 'pending', '0', null, '1', null, null, '127', '0.0000', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('36', '2016-10-08 06:30:00', 'SALE/1610/00036', '65', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', 'SPP សែនសុខ', '1', '', '', '680.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '680.0000', 'completed', 'pending', '0', null, '1', null, null, '85', '87.7200', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('37', '2016-10-09 10:30:00', 'SALE/1610/00037', '10', 'ផ្សារទឹកថ្លា', '3', 'SPP សែនសុខ', '1', '', '', '325.0000', '45.0000', null, '45.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '325.0000', 'completed', 'paid', '0', null, '1', null, null, '51', '0.0000', '0', '325.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('38', '2016-10-09 10:30:00', 'SALE/1610/00038', '4', 'General', '3', 'SPP សែនសុខ', '1', '', '', '74.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '74.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '10.3200', '0', '74.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('39', '2016-10-09 09:25:00', 'SALE/1610/00039', '13', 'ចែ ជិនជួវី', '3', 'SPP សែនសុខ', '1', '', '', '300.0000', '45.0000', null, '45.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', '0', null, '1', null, null, '51', '0.0000', '0', '300.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('40', '2016-10-09 09:25:00', 'SALE/1610/00040', '65', 'ទឺកសុទ្ធភូមិខ្ញុំ', '3', 'SPP សែនសុខ', '1', '', '', '189.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '189.0000', 'completed', 'pending', '0', null, '1', null, null, '3', '0.0000', '0', '0.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');
INSERT INTO `erp_sales` VALUES ('41', '2016-10-09 09:20:00', 'SALE/1610/00041', '4', 'General', '3', 'SPP សែនសុខ', '2', '', '', '115.0000', '0.0000', null, '0.0000', '0.0000', '0.0000', '1', '0.0000', '0.0000', '0.0000', '115.0000', 'completed', 'paid', '0', null, '1', null, null, '127', '0.0000', '0', '115.0000', null, '0.0000', null, null, null, null, null, '1', null, null, '1', '', null, '0', '1', '');

-- ----------------------------
-- Table structure for erp_sale_dev_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_sale_dev_items`;
CREATE TABLE `erp_sale_dev_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `category_name` varchar(255) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `machine_name` varchar(50) DEFAULT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `grand_total` decimal(25,4) DEFAULT NULL,
  `quantity_break` decimal(25,4) DEFAULT NULL,
  `quantity_index` decimal(25,4) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_1` int(11) DEFAULT NULL,
  `user_2` int(11) DEFAULT NULL,
  `user_3` int(11) DEFAULT NULL,
  `user_4` int(11) DEFAULT NULL,
  `user_5` int(11) DEFAULT NULL,
  `user_6` int(11) DEFAULT NULL,
  `user_7` int(11) DEFAULT NULL,
  `user_8` int(11) DEFAULT NULL,
  `user_9` int(11) DEFAULT NULL,
  `cf1` varchar(20) DEFAULT NULL,
  `cf2` varchar(20) DEFAULT NULL,
  `cf3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_id` (`sale_id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`,`sale_id`),
  KEY `sale_id_2` (`sale_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_sale_dev_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_sale_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_sale_items`;
CREATE TABLE `erp_sale_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  `product_noted` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_id` (`sale_id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`,`sale_id`),
  KEY `sale_id_2` (`sale_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_sale_items
-- ----------------------------
INSERT INTO `erp_sale_items` VALUES ('1', '1', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '35.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('2', '1', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('3', '1', '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '2.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '14.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('4', '1', '265', 'Caps-016-WPL-UNIT', 'គំរបសលាតPL(10000)', 'standard', '0', '0.0000', '0.0000', '400.0000', '1', '0.0000', '1', '0.0000', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('5', '1', '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.5000', '8.5000', '1.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '8.5000', '', '8.5000', '');
INSERT INTO `erp_sale_items` VALUES ('6', '1', '265', 'Caps-016-WPL-UNIT', 'គំរបសលាតPL(10000)', 'standard', '0', '0.0000', '0.0000', '200.0000', '1', '0.0000', '1', '0.0000', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('13', '3', '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '20.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '150.0000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('14', '3', '59', 'Caps-010-GISO-UNIT', 'គំរបបៃតងស្តង់ដា', 'standard', '0', '0.0000', '0.0000', '4000.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('15', '4', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '7.0000', '1', '0.0000', '0', '', '0', '0.0000', '49.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('16', '4', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('17', '4', '27', 'Caps-002-BDT-UNIT', 'គំរបខៀវលាតDT', 'standard', '0', '0.0000', '0.0000', '400.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('18', '4', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.0000', '8.0000', '2.0000', '1', '0.0000', '0', '', '0', '0.0000', '16.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('19', '4', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '400.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('20', '4', '58', 'Caps-010-GISO-Small', 'គំរបបៃតងស្តង់ដា(200)', 'standard', '0', '1.2500', '1.2500', '1.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '1.2500', '', '1.2500', '');
INSERT INTO `erp_sale_items` VALUES ('21', '4', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '7.5000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('22', '4', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '200.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('23', '4', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '9.0000', '9.0000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '9.0000', '', '9.0000', '');
INSERT INTO `erp_sale_items` VALUES ('24', '4', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '200.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('25', '5', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '4.0000', '1', '0.0000', '0', '', '0', '0.0000', '26.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('26', '5', '86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '6.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('27', '5', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('28', '5', '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '1.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '7.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('29', '5', '265', 'Caps-016-WPL-UNIT', 'គំរបសលាតPL(10000)', 'standard', null, '0.0000', '0.0000', '200.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('30', '6', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '4.0000', '1', '0.0000', '0', '', '0', '0.0000', '26.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('31', '6', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '3.0000', '1', '0.0000', '0', '', '0', '0.0000', '19.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('32', '6', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '1400.0000', '1', '0.0000', '0', '', '100%', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('33', '7', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '30.0000', '1', '0.0000', '0', '', '0', '0.0000', '180.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('34', '7', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '6000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('35', '8', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '35.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('36', '8', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('37', '9', '275', 'LO-006', 'ថង់អ៊ុតឡូ(37x37)(30kg)', 'standard', '0', '48.0000', '48.0000', '2.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '96.0000', '', '48.0000', '');
INSERT INTO `erp_sale_items` VALUES ('38', '10', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '32.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('39', '10', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '32.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('40', '10', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('41', '11', '177', 'STEMP-003', 'តែមកំពង់ត្រាំ', 'standard', '0', '3.5000', '3.5000', '30.0000', '1', '0.0000', '0', '', '0', '0.0000', '105.0000', '', '3.5000', '');
INSERT INTO `erp_sale_items` VALUES ('42', '12', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.5000', '8.5000', '2.0000', '1', '0.0000', '0', '', '0', '0.0000', '17.0000', '', '8.5000', '');
INSERT INTO `erp_sale_items` VALUES ('43', '12', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '400.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('44', '13', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '10.0000', '1', '0.0000', '0', '', '0', '0.0000', '65.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('45', '13', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '2000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('46', '13', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '2.0000', '1', '0.0000', '0', '', '0', '0.0000', '14.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('47', '13', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '400.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('48', '13', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '35.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('49', '13', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('50', '14', '253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', 'standard', '0', '11.7600', '11.7600', '70.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '823.2000', '', '11.7600', '');
INSERT INTO `erp_sale_items` VALUES ('51', '15', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', 'standard', '0', '5.0000', '5.0000', '150.0000', '1', '0.0000', '0', '', '0', '0.0000', '750.0000', '', '5.0000', '');
INSERT INTO `erp_sale_items` VALUES ('52', '15', '264', 'Caps-016-WPL', 'គំរបសលាតPL(10000)', 'standard', null, '0.0000', '0.0000', '3.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('53', '16', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '7.5000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('54', '16', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('55', '16', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '7.5000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('56', '16', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('57', '16', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.0000', '8.0000', '2.0000', '2', '0.0000', '0', '', '0', '0.0000', '16.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('58', '16', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '400.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('59', '17', '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', 'standard', '0', '8.0000', '8.0000', '22.0000', '1', '0.0000', '0', '', '0', '0.0000', '176.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('60', '17', '153', 'LMS-MV17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបMy Village(MV) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', 'standard', '0', '6.8000', '6.8000', '70.0000', '1', '0.0000', '0', '', '0', '0.0000', '476.0000', '', '6.8000', '');
INSERT INTO `erp_sale_items` VALUES ('61', '18', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '37.5000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('62', '18', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('63', '19', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '35.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('64', '19', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('65', '19', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '7.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('66', '19', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('67', '20', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '32.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('68', '20', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('69', '21', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '10.0000', '1', '0.0000', '0', '', '0', '0.0000', '65.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('70', '21', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '2000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('71', '21', '53', 'Caps-009-OISO-big', 'គំរបទឹកក្រូចស្តង់ដា(1000)', 'standard', '0', '6.5000', '6.5000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '6.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('74', '23', '86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '10.0000', '1', '0.0000', '0', '', '0', '0.0000', '70.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('75', '23', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '2000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('76', '24', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.0000', '8.0000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '8.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('77', '24', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('78', '24', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '8.0000', '8.0000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '8.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('79', '24', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('80', '24', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '7.5000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('81', '24', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('82', '25', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '30.0000', '1', '0.0000', '0', '', '0', '0.0000', '180.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('83', '25', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.2000', '6.2000', '20.0000', '1', '0.0000', '0', '', '0', '0.0000', '124.0000', '', '6.2000', '');
INSERT INTO `erp_sale_items` VALUES ('84', '25', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'standard', '0', '0.0000', '0.0000', '1.0000', '1', '0.0000', '0', '', '100%', '45.0000', '0.0000', '', '45.0000', '');
INSERT INTO `erp_sale_items` VALUES ('87', '27', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '32.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('88', '27', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('89', '28', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '50.0000', '1', '0.0000', '0', '', '0', '0.0000', '300.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('90', '28', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'standard', '0', '0.0000', '0.0000', '1.0000', '1', '0.0000', '0', '', '100%', '45.0000', '0.0000', '', '45.0000', '');
INSERT INTO `erp_sale_items` VALUES ('91', '28', '86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'standard', '0', '6.3000', '6.3000', '10.0000', '1', '0.0000', '0', '', '0', '0.0000', '63.0000', '', '6.3000', '');
INSERT INTO `erp_sale_items` VALUES ('92', '28', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '2000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('93', '29', '253', 'DT33-750-W', 'ដបមូលលេខកូដ​ DT ទំងន់ 33 ក្រាម​ ចំណុះ 750 ml ពណ៌ស(W)(168)', 'standard', '0', '11.7600', '11.7600', '47.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '552.7200', '', '11.7600', '');
INSERT INTO `erp_sale_items` VALUES ('94', '29', '263', 'HVP12.5-435-W', 'ដបលេខកូដ​ HVP ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '5.9000', '5.9000', '50.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '295.0000', '', '5.9000', '');
INSERT INTO `erp_sale_items` VALUES ('95', '29', '264', 'Caps-016-WPL', 'គំរបសលាតPL(10000)', 'standard', null, '0.0000', '0.0000', '1.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('96', '30', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', 'standard', '0', '5.0000', '5.0000', '300.0000', '1', '0.0000', '0', '', '0', '0.0000', '1500.0000', '', '5.0000', '');
INSERT INTO `erp_sale_items` VALUES ('97', '30', '264', 'Caps-016-WPL', 'គំរបសលាតPL(10000)', 'standard', null, '0.0000', '0.0000', '6.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('98', '31', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '5.8000', '5.8000', '65.0000', '1', '0.0000', '0', '', '0', '0.0000', '377.0000', '', '5.8000', '');
INSERT INTO `erp_sale_items` VALUES ('99', '31', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '20.0000', '1', '0.0000', '0', '', '0', '0.0000', '120.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('100', '31', '86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '15.0000', '1', '0.0000', '0', '', '0', '0.0000', '90.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('101', '31', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'standard', '0', '0.0000', '0.0000', '2.0000', '1', '0.0000', '0', '', '100%', '90.0000', '0.0000', '', '45.0000', '');
INSERT INTO `erp_sale_items` VALUES ('102', '32', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '32.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('103', '32', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('104', '33', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '5.0000', '1', '0.0000', '0', '', '0', '0.0000', '32.5000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('105', '33', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '1000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('106', '34', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '3.0000', '2', '0.0000', '0', '', '0', '0.0000', '21.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('107', '34', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '600.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('108', '34', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '9.0000', '9.0000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '9.0000', '', '9.0000', '');
INSERT INTO `erp_sale_items` VALUES ('109', '34', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('110', '34', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.0000', '8.0000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '8.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('111', '34', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('112', '34', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.5000', '7.5000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '7.5000', '', '7.5000', '');
INSERT INTO `erp_sale_items` VALUES ('113', '34', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('114', '26', '77', 'DT-PW12.5-330-B', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 12.5 ក្រាម​ ចំណុះ 330 ml ពណ៌ខៀវ(B)(200)', 'standard', '0', '5.4000', '5.4000', '30.0000', '1', '0.0000', '0', '', '0', '0.0000', '162.0000', '', '5.4000', null);
INSERT INTO `erp_sale_items` VALUES ('115', '26', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', '0', '0.0000', '0.0000', '6000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', null);
INSERT INTO `erp_sale_items` VALUES ('116', '22', '89', 'DT12.5-435-B', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ខៀវ(B)(200)', 'standard', '0', '5.0000', '5.0000', '100.0000', '1', '0.0000', '0', '', '0', '0.0000', '500.0000', '', '5.0000', null);
INSERT INTO `erp_sale_items` VALUES ('117', '22', '24', 'Caps-002-BDT', 'គំរបខៀវលាតDT(10000)', 'standard', '0', '0.0000', '0.0000', '2.0000', '1', '0.0000', '0', '', '100%', '90.0000', '0.0000', '', '45.0000', null);
INSERT INTO `erp_sale_items` VALUES ('118', '35', '125', 'DT13-W', 'ឡតលេខកូដ DT ទំងន់13​ ក្រាមពណ៌ស(W)(30kg)', 'standard', '0', '37.5000', '37.5000', '50.0000', '1', '0.0000', '0', '', '0', '0.0000', '1875.0000', '', '37.5000', '');
INSERT INTO `erp_sale_items` VALUES ('119', '35', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'standard', null, '45.0000', '45.0000', '12.0000', '1', '0.0000', '0', '', '0', '0.0000', '540.0000', '', '45.0000', '');
INSERT INTO `erp_sale_items` VALUES ('120', '35', '144', 'LMS-15-350-V', 'ដបលេខកូដ​ LMSឈ្មោះ ទំងន់ 15 ក្រាម​ ចំណុះ 350 ml ពណ៌វីតាល់(V)(200)', 'standard', '0', '8.6000', '8.6000', '100.0000', '1', '0.0000', '0', '', '0', '0.0000', '860.0000', '', '8.6000', '');
INSERT INTO `erp_sale_items` VALUES ('121', '35', '48', 'Caps-008-VISO', 'គំរបវីតាល់ស្តង់ដា(10000)', 'standard', '0', '0.0000', '0.0000', '2.0000', '1', '0.0000', '0', '', '100%', '130.0000', '0.0000', '', '65.0000', '');
INSERT INTO `erp_sale_items` VALUES ('122', '35', '274', 'LO-005-KG', 'ថង់អ៊ុតឡូ(14x14.5)', 'standard', '0', '51.0000', '51.0000', '3.0000', '1', '0.0000', '1', '0.0000', '0', '0.0000', '153.0000', '', '51.0000', '');
INSERT INTO `erp_sale_items` VALUES ('123', '35', '162', 'LO-003', 'ថង់អ៊ុតឡូ(15x15.5)(30kg)', 'standard', '0', '51.0000', '51.0000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '51.0000', '', '51.0000', '');
INSERT INTO `erp_sale_items` VALUES ('124', '35', '160', 'LO-002', 'ថង់អ៊ុតឡូ(14.5x15)(30kg)', 'standard', '0', '51.0000', '51.0000', '1.0000', '1', '0.0000', '0', '', '0', '0.0000', '51.0000', '', '51.0000', '');
INSERT INTO `erp_sale_items` VALUES ('125', '36', '147', 'LMS-F17-500-V', 'ដបលេខកូដ​ LMSឈ្មោះដបFeeling(F) ទំងន់ 17 ក្រាម​ ចំណុះ 500 ml ពណ៌វីតាល់(V)(224)', 'standard', '0', '8.0000', '8.0000', '85.0000', '1', '0.0000', '0', '', '0', '0.0000', '680.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('126', '37', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '30.0000', '1', '0.0000', '0', '', '0', '0.0000', '195.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('127', '37', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '20.0000', '1', '0.0000', '0', '', '0', '0.0000', '130.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('128', '37', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'standard', '0', '0.0000', '0.0000', '1.0000', '1', '0.0000', '0', '', '100%', '45.0000', '0.0000', '', '45.0000', '');
INSERT INTO `erp_sale_items` VALUES ('129', '38', '117', 'DT13-450-W', 'ដបលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 450 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '10.0000', '1', '0.0000', '0', '', '0', '0.0000', '60.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('130', '38', '47', 'Caps-007-PUST-UNIT', 'គំរបផ្កាឈូកលាតUST', 'standard', null, '0.0000', '0.0000', '2000.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('131', '38', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '2.0000', '1', '0.0000', '0', '', '0', '0.0000', '14.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('132', '38', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '400.0000', '1', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('133', '39', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '35.0000', '1', '0.0000', '0', '', '0', '0.0000', '210.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('134', '39', '86', 'DT-PW13-330-W', 'ដបលេខកូដ​ DTឈ្មោះដប Pure Water(PW) ទំងន់ 13 ក្រាម​ ចំណុះ 330 ml ពណ៌ស(W)(200)', 'standard', '0', '6.0000', '6.0000', '15.0000', '1', '0.0000', '0', '', '0', '0.0000', '90.0000', '', '6.0000', '');
INSERT INTO `erp_sale_items` VALUES ('135', '39', '20', 'Caps-001-WDT', 'គំរបសលាតDT(10000)', 'standard', '0', '0.0000', '0.0000', '1.0000', '1', '0.0000', '0', '', '100%', '45.0000', '0.0000', '', '45.0000', '');
INSERT INTO `erp_sale_items` VALUES ('136', '40', '48', 'Caps-008-VISO', 'គំរបវីតាល់ស្តង់ដា(10000)', 'standard', '0', '63.0000', '63.0000', '3.0000', '1', '0.0000', '0', '', '0', '0.0000', '189.0000', '', '63.0000', '');
INSERT INTO `erp_sale_items` VALUES ('137', '41', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '8.0000', '8.0000', '1.0000', '2', '0.0000', '0', '', '0', '0.0000', '8.0000', '', '8.0000', '');
INSERT INTO `erp_sale_items` VALUES ('138', '41', '59', 'Caps-010-GISO-UNIT', 'គំរបបៃតងស្តង់ដា', 'standard', null, '0.0000', '0.0000', '200.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('139', '41', '92', 'DT12.5-435-W', 'ដបលេខកូដ​ DT ទំងន់ 12.5 ក្រាម​ ចំណុះ 435 ml ពណ៌ស(W)(200)', 'standard', '0', '6.5000', '6.5000', '10.0000', '2', '0.0000', '0', '', '0', '0.0000', '65.0000', '', '6.5000', '');
INSERT INTO `erp_sale_items` VALUES ('140', '41', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '2000.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('141', '41', '122', 'DT13-SPP-300-W', 'ដបSPPលេខកូដ​ DT ទំងន់ 13 ក្រាម​ ចំណុះ 300 ml ពណ៌ស(W)(200)', 'standard', '0', '7.0000', '7.0000', '6.0000', '2', '0.0000', '0', '', '0', '0.0000', '42.0000', '', '7.0000', '');
INSERT INTO `erp_sale_items` VALUES ('142', '41', '23', 'Caps-001-WDT-UNIT', 'គំរបសលាតDT', 'standard', null, '0.0000', '0.0000', '600.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');
INSERT INTO `erp_sale_items` VALUES ('143', '41', '59', 'Caps-010-GISO-UNIT', 'គំរបបៃតងស្តង់ដា', 'standard', null, '0.0000', '0.0000', '600.0000', '2', '0.0000', '0', '', '0', '0.0000', '0.0000', '', '0.0000', '');

-- ----------------------------
-- Table structure for erp_sale_tax
-- ----------------------------
DROP TABLE IF EXISTS `erp_sale_tax`;
CREATE TABLE `erp_sale_tax` (
  `vat_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(100) DEFAULT '',
  `sale_id` varchar(100) DEFAULT '',
  `customer_id` varchar(100) DEFAULT '',
  `issuedate` datetime DEFAULT NULL,
  `vatin` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `qty` double(8,4) DEFAULT NULL,
  `non_tax_sale` double(8,4) DEFAULT NULL,
  `value_export` double(8,4) DEFAULT NULL,
  `amound` double DEFAULT NULL,
  `amound_tax` double DEFAULT '0',
  `amound_declare` double(8,4) DEFAULT NULL,
  `tax_value` double(8,4) DEFAULT NULL,
  `vat` double(8,4) DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `journal_date` date DEFAULT NULL,
  `journal_location` varchar(100) DEFAULT NULL,
  `referent_no` varchar(255) DEFAULT NULL,
  `amount_tax_declare` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`vat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_sale_tax
-- ----------------------------

-- ----------------------------
-- Table structure for erp_serial
-- ----------------------------
DROP TABLE IF EXISTS `erp_serial`;
CREATE TABLE `erp_serial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse` int(11) DEFAULT NULL,
  `serial_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_serial
-- ----------------------------

-- ----------------------------
-- Table structure for erp_sessions
-- ----------------------------
DROP TABLE IF EXISTS `erp_sessions`;
CREATE TABLE `erp_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_sessions
-- ----------------------------
INSERT INTO `erp_sessions` VALUES ('27fe28b3cb7198a5c4b31dbfd6bc548c8181f66d', '::1', '1476773915', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437363737303634373B7265717565737465645F706167657C733A303A22223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736323633303630223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B6C6173745F61637469766974797C693A313437363735353839323B72656769737465725F69647C733A313A2231223B636173685F696E5F68616E647C733A363A22302E30303030223B72656769737465725F6F70656E5F74696D657C733A31393A22323031362D30372D32322030393A33313A3131223B);
INSERT INTO `erp_sessions` VALUES ('3b4814c9a53dd47b55098f45884fc1bfd5a344f0', '::1', '1476785096', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437363738343935313B7265717565737465645F706167657C733A383A2270726F6475637473223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736373535303930223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B);
INSERT INTO `erp_sessions` VALUES ('4c786808dfd3902eb2c1d01e609c153589a563e2', '::1', '1477014911', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437373031343037383B7265717565737465645F706167657C733A303A22223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736373834393633223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B);
INSERT INTO `erp_sessions` VALUES ('8cbe73bd38dbdc170bfa14e40072063c4b77f247', '::1', '1476776865', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437363737333931353B7265717565737465645F706167657C733A303A22223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736323633303630223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B6C6173745F61637469766974797C693A313437363737363832353B72656769737465725F69647C733A313A2231223B636173685F696E5F68616E647C733A363A22302E30303030223B72656769737465725F6F70656E5F74696D657C733A31393A22323031362D30372D32322030393A33313A3131223B);
INSERT INTO `erp_sessions` VALUES ('be23f9276c9e43c6fd71991375da0dc6878acf0d', '::1', '1476756878', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437363735353037373B7265717565737465645F706167657C733A303A22223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736323633303630223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B6C6173745F61637469766974797C693A313437363735353839323B72656769737465725F69647C733A313A2231223B636173685F696E5F68616E647C733A363A22302E30303030223B72656769737465725F6F70656E5F74696D657C733A31393A22323031362D30372D32322030393A33313A3131223B);
INSERT INTO `erp_sessions` VALUES ('ea4c817fc323c0498bdd893b47204709128394d6', '::1', '1476763453', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437363736333435303B7265717565737465645F706167657C733A303A22223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736323633303630223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B6C6173745F61637469766974797C693A313437363735353839323B72656769737465725F69647C733A313A2231223B636173685F696E5F68616E647C733A363A22302E30303030223B72656769737465725F6F70656E5F74696D657C733A31393A22323031362D30372D32322030393A33313A3131223B);
INSERT INTO `erp_sessions` VALUES ('f8ff124bbe15bf6cf8b51bf911c2b854c2d6e9bb', '::1', '1476776968', 0x5F5F63695F6C6173745F726567656E65726174657C693A313437363737363936383B7265717565737465645F706167657C733A303A22223B6964656E746974797C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365726E616D657C733A353A226F776E6572223B656D61696C7C733A32313A226F776E657240636C6F75646E65742E636F6D2E6B68223B757365725F69647C733A313A2231223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231343736323633303630223B6C6173745F69707C733A333A223A3A31223B6176617461727C733A303A22223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B77617265686F7573655F69647C4E3B766965775F72696768747C733A313A2230223B656469745F72696768747C733A313A2230223B616C6C6F775F646973636F756E747C4E3B62696C6C65725F69647C4E3B636F6D70616E795F69647C4E3B73686F775F636F73747C733A313A2230223B73686F775F70726963657C733A313A2230223B6C6173745F61637469766974797C693A313437363737363832353B72656769737465725F69647C733A313A2231223B636173685F696E5F68616E647C733A363A22302E30303030223B72656769737465725F6F70656E5F74696D657C733A31393A22323031362D30372D32322030393A33313A3131223B);

-- ----------------------------
-- Table structure for erp_settings
-- ----------------------------
DROP TABLE IF EXISTS `erp_settings`;
CREATE TABLE `erp_settings` (
  `setting_id` int(1) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `logo2` varchar(255) NOT NULL,
  `site_name` varchar(55) NOT NULL,
  `language` varchar(20) NOT NULL,
  `default_warehouse` int(2) NOT NULL,
  `accounting_method` tinyint(4) NOT NULL DEFAULT '0',
  `default_currency` varchar(3) NOT NULL,
  `default_tax_rate` int(2) NOT NULL,
  `rows_per_page` int(2) NOT NULL,
  `version` varchar(10) NOT NULL DEFAULT '1.0',
  `default_tax_rate2` int(11) NOT NULL DEFAULT '0',
  `dateformat` int(11) NOT NULL,
  `sales_prefix` varchar(20) DEFAULT NULL,
  `quote_prefix` varchar(20) DEFAULT NULL,
  `purchase_prefix` varchar(20) DEFAULT NULL,
  `transfer_prefix` varchar(20) DEFAULT NULL,
  `delivery_prefix` varchar(20) DEFAULT NULL,
  `payment_prefix` varchar(20) DEFAULT NULL,
  `return_prefix` varchar(20) DEFAULT NULL,
  `expense_prefix` varchar(20) DEFAULT NULL,
  `adjustment_prefix` varchar(20) DEFAULT NULL,
  `transaction_prefix` varchar(10) DEFAULT NULL,
  `item_addition` tinyint(1) NOT NULL DEFAULT '0',
  `theme` varchar(20) NOT NULL,
  `product_serial` tinyint(4) NOT NULL,
  `default_discount` int(11) NOT NULL,
  `product_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_method` tinyint(4) NOT NULL,
  `tax1` tinyint(4) NOT NULL,
  `tax2` tinyint(4) NOT NULL,
  `overselling` tinyint(1) NOT NULL DEFAULT '0',
  `restrict_user` tinyint(4) NOT NULL DEFAULT '0',
  `restrict_calendar` tinyint(4) NOT NULL DEFAULT '0',
  `timezone` varchar(100) DEFAULT NULL,
  `iwidth` int(11) NOT NULL DEFAULT '0',
  `iheight` int(11) NOT NULL,
  `twidth` int(11) NOT NULL,
  `theight` int(11) NOT NULL,
  `watermark` tinyint(1) DEFAULT NULL,
  `reg_ver` tinyint(1) DEFAULT NULL,
  `allow_reg` tinyint(1) DEFAULT NULL,
  `reg_notification` tinyint(1) DEFAULT NULL,
  `auto_reg` tinyint(1) DEFAULT NULL,
  `protocol` varchar(20) NOT NULL DEFAULT 'mail',
  `mailpath` varchar(55) DEFAULT '/usr/sbin/sendmail',
  `smtp_host` varchar(100) DEFAULT NULL,
  `smtp_user` varchar(100) DEFAULT NULL,
  `smtp_pass` varchar(255) DEFAULT NULL,
  `smtp_port` varchar(10) DEFAULT '25',
  `smtp_crypto` varchar(10) DEFAULT NULL,
  `corn` datetime DEFAULT NULL,
  `customer_group` int(11) NOT NULL,
  `default_email` varchar(100) NOT NULL,
  `mmode` tinyint(1) NOT NULL,
  `bc_fix` tinyint(4) NOT NULL DEFAULT '0',
  `auto_detect_barcode` tinyint(1) NOT NULL DEFAULT '0',
  `captcha` tinyint(1) NOT NULL DEFAULT '1',
  `reference_format` tinyint(1) NOT NULL DEFAULT '1',
  `racks` tinyint(1) DEFAULT '0',
  `attributes` tinyint(1) NOT NULL DEFAULT '0',
  `product_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `purchase_decimals` tinyint(2) NOT NULL DEFAULT '2',
  `decimals` tinyint(2) NOT NULL DEFAULT '2',
  `qty_decimals` tinyint(2) NOT NULL DEFAULT '2',
  `decimals_sep` varchar(2) NOT NULL DEFAULT '.',
  `thousands_sep` varchar(2) NOT NULL DEFAULT ',',
  `invoice_view` tinyint(1) DEFAULT '0',
  `default_biller` int(11) DEFAULT NULL,
  `envato_username` varchar(50) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT NULL,
  `rtl` tinyint(1) DEFAULT '0',
  `each_spent` decimal(15,4) DEFAULT NULL,
  `ca_point` tinyint(4) DEFAULT NULL,
  `each_sale` decimal(15,4) DEFAULT NULL,
  `sa_point` tinyint(4) DEFAULT NULL,
  `update` tinyint(1) DEFAULT '0',
  `sac` tinyint(1) DEFAULT '0',
  `display_all_products` tinyint(1) DEFAULT '0',
  `display_symbol` tinyint(1) DEFAULT NULL,
  `symbol` varchar(50) DEFAULT NULL,
  `item_slideshow` tinyint(1) DEFAULT NULL,
  `barcode_separator` varchar(2) NOT NULL DEFAULT '_',
  `remove_expired` tinyint(1) DEFAULT '0',
  `sale_payment_prefix` varchar(20) DEFAULT NULL,
  `purchase_payment_prefix` varchar(20) DEFAULT NULL,
  `sale_loan_prefix` varchar(20) DEFAULT NULL,
  `auto_print` tinyint(1) DEFAULT '1',
  `returnp_prefix` varchar(20) DEFAULT NULL,
  `alert_day` tinyint(3) NOT NULL DEFAULT '0',
  `convert_prefix` varchar(20) DEFAULT NULL,
  `purchase_serial` tinyint(4) NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_settings
-- ----------------------------
INSERT INTO `erp_settings` VALUES ('1', 'logo.png', 'logo.png', 'SPP', 'english', '1', '2', 'USD', '1', '10', '3.0.2', '1', '7', 'SALE', 'QUOTE', 'PO', 'TR', 'DO', 'IPAY', 'RE', 'EX', null, 'J', '0', 'default', '0', '1', '1', '1', '1', '1', '1', '1', '0', 'Asia/Phnom_Penh', '800', '800', '60', '60', '0', '0', '0', '0', null, 'mail', '/usr/sbin/sendmail', 'pop.gmail.com', 'iclouderp@gmail.com', 'jEFTM4T63AiQ9dsidxhPKt9CIg4HQjCN58n/RW9vmdC/UDXCzRLR469ziZ0jjpFlbOg43LyoSmpJLBkcAHh0Yw==', '25', null, null, '1', 'iclouderp@gmail.com', '0', '4', '0', '0', '1', '1', '1', '0', '2', '2', '2', '.', ',', '0', '3', 'cloud-net', '53d35644-a36e-45cd-b7ee-8dde3a08f83d', '0', '10.0000', '1', '100.0000', '1', '0', '0', '0', '0', '$', '0', '_', '0', 'RV', 'PV', 'LOAN', '0', 'PRE', '7', 'CON', '0');

-- ----------------------------
-- Table structure for erp_skrill
-- ----------------------------
DROP TABLE IF EXISTS `erp_skrill`;
CREATE TABLE `erp_skrill` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL DEFAULT 'testaccount2@moneybookers.com',
  `secret_word` varchar(20) NOT NULL DEFAULT 'mbtest',
  `skrill_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_skrill
-- ----------------------------
INSERT INTO `erp_skrill` VALUES ('1', '0', 'laykiry@yahoo.com', 'mbtest', 'USD', '0.0000', '0.0000', '0.0000');

-- ----------------------------
-- Table structure for erp_subcategories
-- ----------------------------
DROP TABLE IF EXISTS `erp_subcategories`;
CREATE TABLE `erp_subcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_subcategories
-- ----------------------------

-- ----------------------------
-- Table structure for erp_suspended
-- ----------------------------
DROP TABLE IF EXISTS `erp_suspended`;
CREATE TABLE `erp_suspended` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `floor` varchar(20) DEFAULT '0',
  `ppl_number` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `inactive` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_suspended
-- ----------------------------

-- ----------------------------
-- Table structure for erp_suspended_bills
-- ----------------------------
DROP TABLE IF EXISTS `erp_suspended_bills`;
CREATE TABLE `erp_suspended_bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` datetime DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_tax_id` int(11) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `suspend_id` int(11) NOT NULL DEFAULT '0',
  `suspend_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_suspended_bills
-- ----------------------------

-- ----------------------------
-- Table structure for erp_suspended_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_suspended_items`;
CREATE TABLE `erp_suspended_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suspend_id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  `product_noted` varchar(30) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_suspended_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_suspend_layout
-- ----------------------------
DROP TABLE IF EXISTS `erp_suspend_layout`;
CREATE TABLE `erp_suspend_layout` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `suspend_id` int(20) NOT NULL,
  `order` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_suspend_layout
-- ----------------------------

-- ----------------------------
-- Table structure for erp_tax_purchase_vat
-- ----------------------------
DROP TABLE IF EXISTS `erp_tax_purchase_vat`;
CREATE TABLE `erp_tax_purchase_vat` (
  `vat_id` int(11) NOT NULL,
  `bill_num` varchar(100) DEFAULT NULL,
  `debtorno` varchar(100) DEFAULT NULL,
  `locationname` varchar(100) DEFAULT NULL,
  `issuedate` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `amount_tax` double DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `journal_location` varchar(255) DEFAULT NULL,
  `journal_date` date DEFAULT NULL,
  PRIMARY KEY (`vat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of erp_tax_purchase_vat
-- ----------------------------

-- ----------------------------
-- Table structure for erp_tax_rates
-- ----------------------------
DROP TABLE IF EXISTS `erp_tax_rates`;
CREATE TABLE `erp_tax_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `rate` decimal(12,4) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_tax_rates
-- ----------------------------
INSERT INTO `erp_tax_rates` VALUES ('1', 'No Tax', 'NT', '0.0000', '2');
INSERT INTO `erp_tax_rates` VALUES ('2', 'VAT @10%', 'VAT10', '10.0000', '1');
INSERT INTO `erp_tax_rates` VALUES ('3', 'GST @6%', 'GST', '6.0000', '1');
INSERT INTO `erp_tax_rates` VALUES ('4', 'VAT @20%', 'VT20', '20.0000', '1');
INSERT INTO `erp_tax_rates` VALUES ('5', 'TAX @10%', 'TAX', '10.0000', '1');

-- ----------------------------
-- Table structure for erp_transfers
-- ----------------------------
DROP TABLE IF EXISTS `erp_transfers`;
CREATE TABLE `erp_transfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transfer_no` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_warehouse_id` int(11) NOT NULL,
  `from_warehouse_code` varchar(55) NOT NULL,
  `from_warehouse_name` varchar(55) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `to_warehouse_code` varchar(55) NOT NULL,
  `to_warehouse_name` varchar(55) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT NULL,
  `grand_total` decimal(25,4) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `status` varchar(55) NOT NULL DEFAULT 'pending',
  `shipping` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL,
  `attachment1` varchar(55) DEFAULT NULL,
  `attachment2` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_transfers
-- ----------------------------

-- ----------------------------
-- Table structure for erp_transfer_items
-- ----------------------------
DROP TABLE IF EXISTS `erp_transfer_items`;
CREATE TABLE `erp_transfer_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `quantity_balance` decimal(15,4) NOT NULL,
  `unit_cost` decimal(25,4) DEFAULT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transfer_id` (`transfer_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_transfer_items
-- ----------------------------

-- ----------------------------
-- Table structure for erp_units
-- ----------------------------
DROP TABLE IF EXISTS `erp_units`;
CREATE TABLE `erp_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(55) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(1) DEFAULT NULL,
  `unit_value` varchar(55) DEFAULT NULL,
  `operation_value` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `base_unit` (`base_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_units
-- ----------------------------
INSERT INTO `erp_units` VALUES ('1', '110011', 'ថង់', null, null, null, null);
INSERT INTO `erp_units` VALUES ('2', '110012', 'KG', null, null, null, null);
INSERT INTO `erp_units` VALUES ('3', '110013', 'គំរប', null, null, null, null);
INSERT INTO `erp_units` VALUES ('4', '110014', 'សន្លឹក', null, null, null, null);
INSERT INTO `erp_units` VALUES ('5', '110015', 'គ្រាប់', null, null, null, null);
INSERT INTO `erp_units` VALUES ('6', '110016', 'បាវ', null, null, null, null);

-- ----------------------------
-- Table structure for erp_users
-- ----------------------------
DROP TABLE IF EXISTS `erp_users`;
CREATE TABLE `erp_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_ip_address` varbinary(45) DEFAULT NULL,
  `ip_address` varbinary(45) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `avatar` varchar(55) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  `biller_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `show_cost` tinyint(1) DEFAULT '0',
  `show_price` tinyint(1) DEFAULT '0',
  `award_points` int(11) DEFAULT '0',
  `view_right` tinyint(1) NOT NULL DEFAULT '0',
  `edit_right` tinyint(1) NOT NULL DEFAULT '0',
  `allow_discount` tinyint(1) DEFAULT '0',
  `annualLeave` int(11) DEFAULT '0',
  `sickday` int(11) DEFAULT '0',
  `speacialLeave` int(11) DEFAULT NULL,
  `othersLeave` int(11) DEFAULT NULL,
  `first_name_kh` varchar(50) DEFAULT NULL,
  `last_name_kh` varchar(50) DEFAULT NULL,
  `nationality_kh` varchar(50) DEFAULT NULL,
  `race_kh` varchar(20) NOT NULL,
  `pos_layout` tinyint(1) DEFAULT NULL,
  `pack_id` varchar(50) DEFAULT NULL,
  `sales_standard` tinyint(1) DEFAULT NULL,
  `sales_combo` tinyint(1) DEFAULT NULL,
  `sales_digital` tinyint(1) DEFAULT NULL,
  `sales_service` tinyint(1) DEFAULT NULL,
  `sales_category` varchar(150) DEFAULT NULL,
  `purchase_standard` tinyint(1) DEFAULT NULL,
  `purchase_combo` tinyint(1) DEFAULT NULL,
  `purchase_digital` tinyint(1) DEFAULT NULL,
  `purchase_service` tinyint(1) DEFAULT NULL,
  `purchase_category` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`,`warehouse_id`,`biller_id`),
  KEY `group_id_2` (`group_id`,`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_users
-- ----------------------------
INSERT INTO `erp_users` VALUES ('1', 0x3A3A31, 0x0000, 'owner', 'f536eef28fd507c1fe24273c65171af8d4299d14', '', 'owner@cloudnet.com.kh', '', '', null, '8a5d98b76e7cad45a8efc6c8c4eda7cdd1ab04a5', '1351661704', '1477014090', '1', 'Owner', 'Owner', 'ABC Shop', '012345678', '', 'male', '1', null, null, null, '0', '0', '2626', '0', '0', '0', '0', '0', null, null, '', '', '', '', null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for erp_user_logins
-- ----------------------------
DROP TABLE IF EXISTS `erp_user_logins`;
CREATE TABLE `erp_user_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_user_logins
-- ----------------------------
INSERT INTO `erp_user_logins` VALUES ('1', '1', null, 0x3139322E3136382E302E313037, 'owner@cloudnet.com.kh', '2016-10-05 14:50:51');
INSERT INTO `erp_user_logins` VALUES ('2', '1', null, 0x3139322E3136382E302E313037, 'owner@cloudnet.com.kh', '2016-10-08 11:31:11');
INSERT INTO `erp_user_logins` VALUES ('3', '1', null, 0x3139322E3136382E302E313038, 'owner@cloudnet.com.kh', '2016-10-10 14:14:06');
INSERT INTO `erp_user_logins` VALUES ('4', '1', null, 0x3139322E3136382E302E313032, 'owner@cloudnet.com.kh', '2016-10-10 15:58:46');
INSERT INTO `erp_user_logins` VALUES ('5', '1', null, 0x3139322E3136382E302E313036, 'owner@cloudnet.com.kh', '2016-10-11 09:32:29');
INSERT INTO `erp_user_logins` VALUES ('6', '1', null, 0x3139322E3136382E302E313130, 'owner@cloudnet.com.kh', '2016-10-11 11:08:07');
INSERT INTO `erp_user_logins` VALUES ('7', '1', null, 0x3139322E3136382E302E313037, 'owner@cloudnet.com.kh', '2016-10-11 11:08:45');
INSERT INTO `erp_user_logins` VALUES ('8', '1', null, 0x3139322E3136382E302E313034, 'owner@cloudnet.com.kh', '2016-10-12 14:08:42');
INSERT INTO `erp_user_logins` VALUES ('9', '1', null, 0x3139322E3136382E302E313032, 'owner@cloudnet.com.kh', '2016-10-12 14:25:35');
INSERT INTO `erp_user_logins` VALUES ('10', '1', null, 0x3A3A31, 'owner@cloudnet.com.kh', '2016-10-12 16:02:47');
INSERT INTO `erp_user_logins` VALUES ('11', '1', null, 0x3A3A31, 'owner@cloudnet.com.kh', '2016-10-12 16:04:20');
INSERT INTO `erp_user_logins` VALUES ('12', '1', null, 0x3A3A31, 'owner@cloudnet.com.kh', '2016-10-18 08:44:51');
INSERT INTO `erp_user_logins` VALUES ('13', '1', null, 0x3A3A31, 'owner@cloudnet.com.kh', '2016-10-18 17:02:43');
INSERT INTO `erp_user_logins` VALUES ('14', '1', null, 0x3A3A31, 'owner@cloudnet.com.kh', '2016-10-21 08:41:30');

-- ----------------------------
-- Table structure for erp_variants
-- ----------------------------
DROP TABLE IF EXISTS `erp_variants`;
CREATE TABLE `erp_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_variants
-- ----------------------------

-- ----------------------------
-- Table structure for erp_warehouses
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouses`;
CREATE TABLE `erp_warehouses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `map` varchar(255) DEFAULT NULL,
  `phone` varchar(55) DEFAULT NULL,
  `email` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_warehouses
-- ----------------------------
INSERT INTO `erp_warehouses` VALUES ('1', 'WH1', 'ឃ្លាំងសែនសុខ', '<p>Phnom Penh</p>', '', '077727228/016978886/012669686', 'spp.chhang@gmail.com');
INSERT INTO `erp_warehouses` VALUES ('2', 'WH2', 'ផ្ទះ 28 Eo', '<p>Phnom Penh</p>', '', '070498686/0976727228', 'spp.chhang@gmail.com');

-- ----------------------------
-- Table structure for erp_warehouses_products
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouses_products`;
CREATE TABLE `erp_warehouses_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_warehouses_products
-- ----------------------------
INSERT INTO `erp_warehouses_products` VALUES ('1', '86', '1', '141.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('2', '86', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('3', '122', '1', '311.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('4', '122', '2', '-7.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('5', '89', '1', '533.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('6', '89', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('7', '245', '1', '10.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('8', '245', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('9', '253', '1', '174.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('10', '253', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('11', '117', '1', '345.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('12', '117', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('13', '114', '1', '189.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('14', '114', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('15', '77', '1', '312.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('16', '77', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('17', '92', '1', '-47.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('18', '92', '2', '-23.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('19', '194', '1', '59.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('20', '194', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('21', '185', '1', '56.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('22', '185', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('23', '169', '1', '110.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('24', '169', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('25', '153', '1', '260.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('26', '153', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('27', '147', '1', '182.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('28', '147', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('29', '257', '1', '176.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('30', '257', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('31', '20', '1', '21.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('32', '20', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('33', '23', '1', '-21790.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('34', '23', '2', '-5200.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('35', '56', '1', '50.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('36', '56', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('37', '59', '1', '14200.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('38', '59', '2', '-800.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('39', '24', '1', '34.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('40', '24', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('41', '27', '1', '4600.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('42', '27', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('43', '48', '1', '25.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('44', '48', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('45', '51', '1', '3200.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('46', '51', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('47', '52', '1', '13.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('48', '52', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('49', '55', '1', '5600.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('50', '55', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('51', '68', '1', '1.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('52', '68', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('53', '71', '1', '5000.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('54', '71', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('55', '60', '1', '7.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('56', '60', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('57', '63', '1', '6000.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('58', '63', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('59', '44', '1', '2.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('60', '44', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('61', '40', '1', '6.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('62', '40', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('63', '43', '1', '5000.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('64', '43', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('65', '32', '1', '15.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('66', '32', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('67', '35', '1', '5000.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('68', '35', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('69', '28', '1', '2.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('70', '28', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('71', '31', '1', '9000.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('72', '31', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('73', '206', '1', '21.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('74', '206', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('75', '207', '1', '15.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('76', '207', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('77', '204', '1', '120.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('78', '204', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('79', '261', '1', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('80', '261', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('81', '156', '1', '1.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('82', '156', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('83', '157', '1', '22.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('84', '157', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('85', '259', '1', '20.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('86', '259', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('87', '18', '1', '99.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('88', '18', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('89', '19', '1', '18.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('90', '19', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('91', '125', '1', '73.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('92', '125', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('93', '126', '1', '19.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('94', '126', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('95', '127', '1', '34.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('96', '127', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('97', '101', '1', '108.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('98', '101', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('99', '158', '1', '3.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('100', '158', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('101', '159', '1', '9.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('102', '159', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('103', '160', '1', '4.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('104', '160', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('105', '162', '1', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('106', '162', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('107', '236', '1', '303000.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('108', '236', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('109', '177', '1', '90970.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('110', '177', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('111', '233', '1', '5.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('112', '233', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('113', '237', '1', '6.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('114', '237', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('115', '238', '1', '4.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('116', '238', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('117', '235', '1', '228.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('118', '235', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('119', '8', '1', '40.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('120', '8', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('121', '9', '1', '133.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('122', '9', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('123', '4', '1', '4.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('124', '4', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('125', '6', '1', '1.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('126', '6', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('127', '7', '1', '9.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('128', '7', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('129', '263', '1', '586.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('130', '264', '1', '35.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('131', '265', '1', '8200.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('132', '266', '1', '122.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('133', '270', '1', '25.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('134', '271', '1', '10.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('135', '272', '1', '110.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('136', '273', '1', '8.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('137', '179', '1', '294.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('138', '179', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('139', '181', '1', '3.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('140', '181', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('141', '141', '1', '3.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('142', '141', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('143', '143', '1', '5.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('144', '143', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('145', '1', '1', '41.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('146', '1', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('147', '3', '1', '2.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('148', '3', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('149', '166', '1', '39.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('150', '166', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('151', '168', '1', '7.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('152', '168', '2', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('153', '275', '1', '18.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('154', '241', '1', '90.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('155', '205', '1', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('156', '262', '1', '0.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('157', '277', '1', '230.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('158', '102', '1', '41.0000', null);
INSERT INTO `erp_warehouses_products` VALUES ('159', '47', '1', '8000.0000', null);

-- ----------------------------
-- Table structure for erp_warehouses_products_variants
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouses_products_variants`;
CREATE TABLE `erp_warehouses_products_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `option_id` (`option_id`),
  KEY `product_id` (`product_id`),
  KEY `warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of erp_warehouses_products_variants
-- ----------------------------

-- ----------------------------
-- View structure for d
-- ----------------------------
DROP VIEW IF EXISTS `d`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `d` AS SELECT
	date,
	reference_no,
	total,
	grand_total,
	total_cost,
	paid
FROM
	erp_sales ; ;
DROP TRIGGER IF EXISTS `gl_trans_adjustment_insert`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_adjustment_insert` AFTER INSERT ON `erp_adjustments` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;
DECLARE v_default_stock_adjust INTEGER;
DECLARE v_default_stock INTEGER;


SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);

UPDATE erp_order_ref
SET tr = v_tran_no
WHERE
DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');

/*

SET v_default_stock_adjust = (SELECT default_stock_adjust FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_stock = (SELECT default_stock FROM erp_account_settings WHERE biller_id = NEW.biller_id);

*/


SET v_default_stock_adjust = (SELECT default_stock_adjust FROM erp_account_settings);
SET v_default_stock = (SELECT default_stock FROM erp_account_settings);


/* ==== Addition =====*/

	IF NEW.type = 'addition' THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)* abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock_adjust
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock_adjust;


	ELSE

  		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock;


		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock_adjust
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock_adjust;
	END IF;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_adjustment_delete`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_adjustment_delete` AFTER DELETE ON `erp_adjustments` FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE tran_type='STOCK_ADJUST' AND reference_no = OLD.id;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_adjustment_update`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_adjustment_update` AFTER UPDATE ON `erp_adjustments` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;
DECLARE v_default_stock_adjust INTEGER;
DECLARE v_default_stock INTEGER;

SET v_tran_no = (SELECT tran_no FROM erp_gl_trans WHERE tran_type='STOCK_ADJUST' AND reference_no = NEW.id LIMIT 0,1); 


DELETE FROM erp_gl_trans WHERE tran_type='STOCK_ADJUST' AND reference_no = NEW.id;

/*

SET v_default_stock_adjust = (SELECT default_stock_adjust FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_stock = (SELECT default_stock FROM erp_account_settings WHERE biller_id = NEW.biller_id);

*/


SET v_default_stock_adjust = (SELECT default_stock_adjust FROM erp_account_settings);
SET v_default_stock = (SELECT default_stock FROM erp_account_settings);


/* ==== Addition =====*/

	IF NEW.type = 'addition' THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)* abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock_adjust
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock_adjust;


	ELSE

  		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			)
			SELECT
			'STOCK_ADJUST',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total_cost),
			NEW.id,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_stock_adjust
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_stock_adjust;
	END IF;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_expense_insert`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_expense_insert` AFTER INSERT ON `erp_expenses` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;


IF NEW.created_by THEN

	SET v_tran_date = (SELECT erp_expenses.date 
		FROM erp_payments 
		INNER JOIN erp_expenses ON erp_expenses.id = erp_payments.expense_id
		WHERE erp_expenses.id = NEW.id LIMIT 0,1);

	IF v_tran_date = NEW.date THEN
		SET v_tran_no = (SELECT MAX(tran_no) FROM erp_gl_trans);
	ELSE
		SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);
	
		UPDATE erp_order_ref
		SET tr = v_tran_no
		WHERE
		DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
	END IF;


	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'JOURNAL',
			v_tran_no,
			NEW.date,
			erp_gl_charts.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			NEW.reference,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_gl_charts
			WHERE
				erp_gl_charts.accountcode = NEW.account_code;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'JOURNAL',
			v_tran_no,
			NEW.date,
			erp_gl_charts.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*NEW.amount,
			NEW.reference,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_gl_charts
			WHERE
				erp_gl_charts.accountcode = NEW.bank_code;
	

END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_expense_update`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_expense_update` AFTER UPDATE ON `erp_expenses` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;


	SET v_tran_no = (SELECT tran_no FROM erp_gl_trans WHERE reference_no = NEW.reference LIMIT 0,1);
	IF v_tran_no < 1  THEN
		SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);
	                
		UPDATE erp_order_ref SET tr = v_tran_no WHERE DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
	ELSE
	                SET v_tran_no = (SELECT MAX(tran_no) FROM erp_gl_trans);
	END IF;

IF NEW.updated_by THEN

   	
	DELETE FROM erp_gl_trans WHERE reference_no = NEW.reference;
	
	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'JOURNAL',
			v_tran_no,
			NEW.date,
			erp_gl_charts.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			NEW.reference,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_gl_charts
			WHERE
				erp_gl_charts.accountcode = NEW.account_code;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'JOURNAL',
			v_tran_no,
			NEW.date,
			erp_gl_charts.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*NEW.amount,
			NEW.reference,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_gl_charts
			WHERE
				erp_gl_charts.accountcode = NEW.bank_code;
		

END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_expense_delete`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_expense_delete` AFTER DELETE ON `erp_expenses` FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_loan_delete`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_loan_delete` AFTER DELETE ON `erp_loans` FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference_no;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_payment_insert`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_payment_insert` AFTER INSERT ON `erp_payments` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;
DECLARE v_default_cash INTEGER;
DECLARE v_default_credit_card INTEGER;
DECLARE v_default_gift_card INTEGER;
DECLARE v_default_cheque INTEGER;
DECLARE v_default_sale_deposit INTEGER;
DECLARE v_default_purchase_deposit INTEGER;
DECLARE v_default_loan INTEGER;
DECLARE v_default_receivable INTEGER;
DECLARE v_default_payable INTEGER;
DECLARE v_bank_code INTEGER;
DECLARE v_account_code INTEGER;
DECLARE v_tran_date DATETIME;

SET v_tran_date = (SELECT erp_sales.date 
		FROM erp_payments 
		INNER JOIN erp_sales ON erp_sales.id = erp_payments.sale_id
		WHERE erp_sales.id = NEW.sale_id LIMIT 0,1);

IF v_tran_date = NEW.date THEN
	SET v_tran_no = (SELECT MAX(tran_no) FROM erp_gl_trans);
ELSE
	SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);

	UPDATE erp_order_ref
	SET tr = v_tran_no
	WHERE
	DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
END IF;

/*
SET v_default_cash = (SELECT default_cash FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_credit_card = (SELECT default_credit_card FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_gift_card = (SELECT default_gift_card FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_cheque = (SELECT default_cheque FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_sale_deposit = (SELECT default_sale_deposit FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_purchase_deposit = (SELECT default_purchase_deposit FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_loan = (SELECT default_loan FROM erp_account_settings WHERE biller_id = NEW.biller_id);

SET v_default_receivable = (SELECT default_receivable FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_payable = (SELECT default_payable FROM erp_account_settings WHERE biller_id = NEW.biller_id);
*/

SET v_default_cash = (SELECT default_cash FROM erp_account_settings);
SET v_default_credit_card = (SELECT default_credit_card FROM erp_account_settings);
SET v_default_gift_card = (SELECT default_gift_card FROM erp_account_settings);
SET v_default_cheque = (SELECT default_cheque FROM erp_account_settings);
SET v_default_sale_deposit = (SELECT default_sale_deposit FROM erp_account_settings);
SET v_default_purchase_deposit = (SELECT default_purchase_deposit FROM erp_account_settings);

SET v_default_loan = (SELECT default_loan FROM erp_account_settings);

SET v_default_receivable = (SELECT default_receivable FROM erp_account_settings);
SET v_default_payable = (SELECT default_payable FROM erp_account_settings);

IF NEW.paid_by = 'cash' THEN 
SET v_bank_code = v_default_cash;          
END IF;

IF NEW.paid_by = 'credit_card' THEN
SET v_bank_code = v_default_credit_card;
END IF;

IF NEW.paid_by = 'gift_card' THEN
SET v_bank_code = v_default_gift_card ;
END IF;

IF NEW.paid_by = 'cheque' THEN
SET v_bank_code = v_default_cheque;
END IF;

IF NEW.paid_by = 'deposit' THEN
SET v_bank_code = v_default_sale_deposit;
END IF;

IF NEW.paid_by = 'loan' THEN
SET v_bank_code = v_default_loan;
END IF;

/* ==== SALE GL =====*/
	IF NEW.sale_id>0 THEN
		IF NEW.return_id>0 AND NEW.type = 'returned' AND NEW.amount>0 THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by
			)
			SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			(
				SELECT reference_no FROM erp_sales WHERE id = NEW.sale_id
			),
			(
				SELECT customer FROM erp_sales WHERE id = NEW.sale_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_sales WHERE id = NEW.sale_id
			)
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_receivable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_receivable;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by) 
			SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*(NEW.amount),
			(
				SELECT reference_no FROM erp_sales WHERE id = NEW.sale_id
			),
			(
				SELECT customer FROM erp_sales WHERE id = NEW.sale_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_sales WHERE id = NEW.sale_id
			)
			FROM
				erp_account_settings
			INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;


  		ELSE

  		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*(NEW.amount),
			(
				SELECT reference_no FROM erp_sales WHERE id = NEW.sale_id
			),
			(
				SELECT customer FROM erp_sales WHERE id = NEW.sale_id
			),
			NEW.biller_id,
			'1',
			NEW.created_by,
			(
				SELECT updated_by FROM erp_sales WHERE id = NEW.sale_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_receivable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_receivable;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by) 
			SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			(
				SELECT reference_no FROM erp_sales WHERE id = NEW.sale_id
			),
			(
				SELECT customer FROM erp_sales WHERE id = NEW.sale_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_sales WHERE id = NEW.sale_id
			)
			FROM
			erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
		END IF;
     END IF;


/* ==== OTHER GL =====
	IF NEW.transaction_id THEN

        INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by) 
			SELECT
			'EXPENSES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			(
				SELECT reference FROM erp_expenses WHERE id = NEW.transaction_id
			),
			(
				SELECT note FROM erp_expenses WHERE id = NEW.transaction_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_expenses WHERE id = NEW.transaction_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_payable
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_payable;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'EXPENSES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(- 1) * abs(NEW.amount),
			(
				SELECT reference FROM erp_expenses WHERE id = NEW.transaction_id
			),
			(
				SELECT note FROM erp_expenses WHERE id = NEW.transaction_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_expenses WHERE id = NEW.transaction_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;
*/

/* ==== SALE DEPOSIT GL =====*/
	IF NEW.deposit_id THEN

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(- 1) * abs(NEW.amount),
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits	WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_sale_deposit
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_sale_deposit;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;

 /* ==== SALE RETURN DEPOSIT GL =====*/
				IF NEW.return_deposit_id THEN
					INSERT INTO erp_gl_trans (
						tran_type,
						tran_no,
						tran_date,
						sectionid,
						account_code,
						narrative,
						amount,
						reference_no,
						description,
						biller_id,
						created_by,
						bank,
						updated_by
					) SELECT
						'DEPOSIT-RETURN',
						v_tran_no,
						NEW.date,
						erp_gl_sections.sectionid,
						erp_gl_charts.accountcode,
						erp_gl_charts.accountname,
						NEW.amount,
						NEW.reference_no,
						NEW.note,
						NEW.biller_id,
						NEW.created_by,
						'1',
						(
							SELECT
								updated_by
							FROM
								erp_deposits
							WHERE
								id = NEW.deposit_id
						)
					FROM
						erp_account_settings
					INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_sale_deposit
					INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
					WHERE
						erp_gl_charts.accountcode = v_default_sale_deposit ; INSERT INTO erp_gl_trans (
							tran_type,
							tran_no,
							tran_date,
							sectionid,
							account_code,
							narrative,
							amount,
							reference_no,
							description,
							biller_id,
							created_by,
							bank,
							updated_by
						) SELECT
							'DEPOSITS',
							v_tran_no,
							NEW.date,
							erp_gl_sections.sectionid,
							erp_gl_charts.accountcode,
							erp_gl_charts.accountname,
							(- 1) * abs(NEW.amount),
							NEW.reference_no,
							NEW.note,
							NEW.biller_id,
							NEW.created_by,
							'1',
							(
								SELECT
									updated_by
								FROM
									erp_deposits
								WHERE
									id = NEW.deposit_id
							)
						FROM
							erp_account_settings
						INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
						INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
						WHERE
							erp_gl_charts.accountcode = v_bank_code ;
						END IF;

/* ==== PURCHASE DEPOSIT GL =====*/
	IF NEW.purchase_deposit_id THEN

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits	WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_purchase_deposit
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_purchase_deposit;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(- 1) * abs(NEW.amount),
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;
/* ==== SALE LOAN GL =====*/
	IF NEW.loan_id > 0 THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'LOANS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(- 1) * abs(NEW.amount),
			(
				SELECT reference_no FROM erp_loans WHERE id = NEW.loan_id
			),
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_loans WHERE id = NEW.loan_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_loan
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_loan;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'LOANS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			(
				SELECT reference_no FROM erp_loans WHERE id = NEW.loan_id
			),
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_loans WHERE id = NEW.loan_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;

/* ==== PURCHASE GL =====*/
	IF NEW.purchase_id>0 THEN

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			(
				SELECT reference_no FROM erp_purchases WHERE id = NEW.purchase_id
			),
			(
				SELECT supplier FROM erp_purchases WHERE id = NEW.purchase_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_purchases WHERE id = NEW.purchase_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_default_payable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_payable;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1)*abs(NEW.amount),
			(
				SELECT reference_no FROM erp_purchases WHERE id = NEW.purchase_id
			),
			(
				SELECT supplier FROM erp_purchases WHERE id = NEW.purchase_id
			),
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_purchases WHERE id = NEW.purchase_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;
     
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_payment_update`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_payment_update` AFTER UPDATE ON `erp_payments` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;
DECLARE v_default_cash INTEGER;
DECLARE v_default_credit_card INTEGER;
DECLARE v_default_gift_card INTEGER;
DECLARE v_default_cheque INTEGER;
DECLARE v_default_sale_deposit INTEGER;
DECLARE v_default_purchase_deposit INTEGER;
DECLARE v_default_loan INTEGER;
DECLARE v_default_receivable INTEGER;
DECLARE v_default_payable INTEGER;
DECLARE v_bank_code INTEGER;
DECLARE v_account_code INTEGER;
DECLARE v_tran_date DATETIME;

SET v_tran_no = (SELECT tran_no FROM erp_gl_trans WHERE tran_type='DEPOSITS' AND reference_no = NEW.reference_no LIMIT 0,1); 

DELETE FROM erp_gl_trans WHERE tran_type='DEPOSITS' AND reference_no = NEW.reference_no;

/*
SET v_default_cash = (SELECT default_cash FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_credit_card = (SELECT default_credit_card FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_gift_card = (SELECT default_gift_card FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_cheque = (SELECT default_cheque FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_sale_deposit = (SELECT default_sale_deposit FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_purchase_deposit = (SELECT default_purchase_deposit FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_loan = (SELECT default_loan FROM erp_account_settings WHERE biller_id = NEW.biller_id);

SET v_default_receivable = (SELECT default_receivable FROM erp_account_settings WHERE biller_id = NEW.biller_id);
SET v_default_payable = (SELECT default_payable FROM erp_account_settings WHERE biller_id = NEW.biller_id);
*/

SET v_default_cash = (SELECT default_cash FROM erp_account_settings);
SET v_default_credit_card = (SELECT default_credit_card FROM erp_account_settings);
SET v_default_gift_card = (SELECT default_gift_card FROM erp_account_settings);
SET v_default_cheque = (SELECT default_cheque FROM erp_account_settings);
SET v_default_sale_deposit = (SELECT default_sale_deposit FROM erp_account_settings);
SET v_default_purchase_deposit = (SELECT default_purchase_deposit FROM erp_account_settings);

SET v_default_loan = (SELECT default_loan FROM erp_account_settings);

SET v_default_receivable = (SELECT default_receivable FROM erp_account_settings);
SET v_default_payable = (SELECT default_payable FROM erp_account_settings);

IF NEW.paid_by = 'cash' THEN 
SET v_bank_code = v_default_cash;          
END IF;

IF NEW.paid_by = 'credit_card' THEN
SET v_bank_code = v_default_credit_card;
END IF;

IF NEW.paid_by = 'gift_card' THEN
SET v_bank_code = v_default_gift_card ;
END IF;

IF NEW.paid_by = 'cheque' THEN
SET v_bank_code = v_default_cheque;
END IF;

IF NEW.paid_by = 'deposit' THEN
SET v_bank_code = v_default_sale_deposit;
END IF;

IF NEW.paid_by = 'loan' THEN
SET v_bank_code = v_default_loan;
END IF;

/* ==== SALE DEPOSIT GL =====*/
	IF NEW.deposit_id THEN

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits	WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_sale_deposit
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_sale_deposit;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(- 1) * abs(NEW.amount),
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;

/* ==== PURCHASE DEPOSIT GL =====*/
	IF NEW.purchase_deposit_id THEN

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(- 1) * abs(NEW.amount),
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits	WHERE id = NEW.deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_default_purchase_deposit
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_default_purchase_deposit;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			bank,
			updated_by)
			SELECT
			'DEPOSITS',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.amount,
			NEW.reference_no,
			NEW.note,
			NEW.biller_id,
			NEW.created_by,
			'1',
			(
				SELECT updated_by FROM erp_deposits WHERE id = NEW.purchase_deposit_id
			)
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = v_bank_code
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = v_bank_code;
	END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_purchase_insert`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_purchase_insert` AFTER INSERT ON `erp_purchases` FOR EACH ROW BEGIN
DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;

IF NEW.status="received" AND NEW.total > 0 THEN

SET v_tran_date = (SELECT erp_purchases.date 
		FROM erp_payments 
		INNER JOIN erp_purchases ON erp_purchases.id = erp_payments.purchase_id
		WHERE erp_purchases.id = NEW.id LIMIT 0,1);

IF v_tran_date = NEW.date THEN
	SET v_tran_no = (SELECT MAX(tran_no) FROM erp_gl_trans);
ELSE
	SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);
	
	UPDATE erp_order_ref
	SET tr = v_tran_no
	WHERE
	DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
END IF;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
                                                NEW.total +NEW.product_discount,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_purchase
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.grand_total),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_payable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_payable;

	IF NEW.total_discount THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.total_discount),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_discount
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_discount;
	END IF;

	IF NEW.total_tax THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.total_tax,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_tax
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_tax;
	END IF;

	IF NEW.shipping THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.shipping,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_freight
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_freight;
	END IF;
	
END IF;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_purchase_update`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_purchase_update` AFTER UPDATE ON `erp_purchases` FOR EACH ROW BEGIN
DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;

IF NEW.status="returned"  AND  NEW.return_id > 0 THEN

/*
	SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);	
	UPDATE erp_order_ref SET tr = v_tran_no WHERE DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m'); 
*/

SET v_tran_date = (SELECT erp_purchases.date 
		FROM erp_payments 
		INNER JOIN erp_purchases ON erp_purchases.id = erp_payments.purchase_id
		WHERE erp_purchases.id = NEW.id LIMIT 0,1);

IF v_tran_date = NEW.date THEN
	SET v_tran_no = (SELECT MAX(tran_no) FROM erp_gl_trans);
ELSE
	SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);
	
	UPDATE erp_order_ref
	SET tr = v_tran_no
	WHERE
	DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
END IF; 

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'PURCHASES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) *(NEW.total+NEW.product_discount),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_purchase
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			 abs(NEW.grand_total),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_payable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_payable;

	IF NEW.total_discount THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			 abs(NEW.total_discount),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_discount
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_discount;
	END IF;

	IF NEW.total_tax THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) *NEW.total_tax,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_tax
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_tax;
	END IF;

	IF NEW.shipping THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) *NEW.shipping,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_freight
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_freight;
	END IF;

END IF;



IF NEW.status="received" AND NEW.total > 0 AND NEW.updated_by>0  AND NEW.return_id IS NULL THEN

SET v_tran_no = (SELECT tran_no FROM erp_gl_trans WHERE tran_type='PURCHASES' AND reference_no = NEW.reference_no LIMIT 0,1);

	IF v_tran_no < 1  THEN
		SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);	                
		UPDATE erp_order_ref SET tr = v_tran_no WHERE DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
	END IF;



DELETE FROM erp_gl_trans WHERE tran_type='PURCHASES' AND bank=0 AND reference_no = NEW.reference_no;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.total,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_purchase
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.grand_total),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_payable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_payable;

	IF NEW.total_discount THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.total_discount),
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_discount
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_discount;
	END IF;

	IF NEW.total_tax THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.total_tax,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_tax
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_tax;
	END IF;

	IF NEW.shipping THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'PURCHASES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.shipping,
			NEW.reference_no,
			NEW.supplier,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_purchase_freight
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_purchase_freight;
	END IF;

END IF;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_purchase_delete`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_purchase_delete` AFTER DELETE ON `erp_purchases` FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference_no;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_sale_insert`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_sale_insert` AFTER INSERT ON `erp_sales` FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;


DECLARE v_tran_date DATETIME;


IF NEW.sale_status = "completed"
AND NEW.total > 0 || NEW.total_discount THEN

SET v_tran_date = (
	SELECT
		erp_sales.date
	FROM
		erp_payments
	INNER JOIN erp_sales ON erp_sales.id = erp_payments.sale_id
	WHERE
		erp_sales.id = NEW.id
	LIMIT 0,
	1
);


IF v_tran_date = NEW.date THEN

SET v_tran_no = (
	SELECT
		MAX(tran_no)
	FROM
		erp_gl_trans
);


ELSE

SET v_tran_no = (
	SELECT
		COALESCE (MAX(tran_no), 0) + 1
	FROM
		erp_gl_trans
);

UPDATE erp_order_ref
SET tr = v_tran_no
WHERE
	DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');


END
IF;

INSERT INTO erp_gl_trans (
	tran_type,
	tran_no,
	tran_date,
	sectionid,
	account_code,
	narrative,
	amount,
	reference_no,
	description,
	biller_id,
	created_by,
	updated_by
) SELECT
	'SALES',
	v_tran_no,
	NEW.date,
	erp_gl_sections.sectionid,
	erp_gl_charts.accountcode,
	erp_gl_charts.accountname,
	NEW.grand_total,
	NEW.reference_no,
	NEW.customer,
	NEW.biller_id,
	NEW.created_by,
	NEW.updated_by
FROM
	erp_account_settings
INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_receivable
INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
WHERE
	erp_gl_charts.accountcode = erp_account_settings.default_receivable;

INSERT INTO erp_gl_trans (
		tran_type,
		tran_no,
		tran_date,
		sectionid,
		account_code,
		narrative,
		amount,
		reference_no,
		description,
		biller_id,
		created_by,
		updated_by
	) SELECT
		'SALES',
		v_tran_no,
		NEW.date,
		erp_gl_sections.sectionid,
		erp_gl_charts.accountcode,
		erp_gl_charts.accountname,
		(- 1) * abs(
			NEW.total + NEW.product_discount
		),
		NEW.reference_no,
		NEW.customer,
		NEW.biller_id,
		NEW.created_by,
		NEW.updated_by
	FROM
		erp_account_settings
	INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_sale
	INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
	WHERE
		erp_gl_charts.accountcode = erp_account_settings.default_sale;

	
INSERT INTO erp_gl_trans (
	tran_type,
	tran_no,
	tran_date,
	sectionid,
	account_code,
	narrative,
	amount,
	reference_no,
	description,
	biller_id,
	created_by,
	updated_by
) SELECT
	'SALES',
	v_tran_no,
	NEW.date,
	erp_gl_sections.sectionid,
	erp_gl_charts.accountcode,
	erp_gl_charts.accountname,
	NEW.total_cost,
	NEW.reference_no,
	NEW.customer,
	NEW.biller_id,
	NEW.created_by,
	NEW.updated_by
FROM
	erp_account_settings
INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_cost
INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
WHERE
	erp_gl_charts.accountcode = erp_account_settings.default_cost;



IF NEW.opening_ar = 1 THEN
	INSERT INTO erp_gl_trans (
		tran_type,
		tran_no,
		tran_date,
		sectionid,
		account_code,
		narrative,
		amount,
		reference_no,
		description,
		biller_id,
		created_by,
		updated_by
	) SELECT
		'SALES',
		v_tran_no,
		NEW.date,
		erp_gl_sections.sectionid,
		erp_gl_charts.accountcode,
		erp_gl_charts.accountname,
		(- 1) * abs(
			NEW.total + NEW.product_discount
		),
		NEW.reference_no,
		NEW.customer,
		NEW.biller_id,
		NEW.created_by,
		NEW.updated_by
	FROM
		erp_account_settings
	INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_open_balance
	INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
	WHERE
		erp_gl_charts.accountcode = erp_account_settings.default_open_balance;


ELSE

INSERT INTO erp_gl_trans (
	tran_type,
	tran_no,
	tran_date,
	sectionid,
	account_code,
	narrative,
	amount,
	reference_no,
	description,
	biller_id,
	created_by,
	updated_by
) SELECT
	'SALES',
	v_tran_no,
	NEW.date,
	erp_gl_sections.sectionid,
	erp_gl_charts.accountcode,
	erp_gl_charts.accountname,
	(- 1) * abs(NEW.total_cost),
	NEW.reference_no,
	NEW.customer,
	NEW.biller_id,
	NEW.created_by,
	NEW.updated_by
FROM
	erp_account_settings
INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_stock
INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
WHERE
	erp_gl_charts.accountcode = erp_account_settings.default_stock;


IF NEW.total_discount THEN
	INSERT INTO erp_gl_trans (
		tran_type,
		tran_no,
		tran_date,
		sectionid,
		account_code,
		narrative,
		amount,
		reference_no,
		description,
		biller_id,
		created_by,
		updated_by
	) SELECT
		'SALES',
		v_tran_no,
		NEW.date,
		erp_gl_sections.sectionid,
		erp_gl_charts.accountcode,
		erp_gl_charts.accountname,
		NEW.total_discount,
		NEW.reference_no,
		NEW.customer,
		NEW.biller_id,
		NEW.created_by,
		NEW.updated_by
	FROM
		erp_account_settings
	INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_sale_discount
	INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
	WHERE
		erp_gl_charts.accountcode = erp_account_settings.default_sale_discount;


END
IF;


IF NEW.total_tax THEN
	INSERT INTO erp_gl_trans (
		tran_type,
		tran_no,
		tran_date,
		sectionid,
		account_code,
		narrative,
		amount,
		reference_no,
		description,
		biller_id,
		created_by,
		updated_by
	) SELECT
		'SALES',
		v_tran_no,
		NEW.date,
		erp_gl_sections.sectionid,
		erp_gl_charts.accountcode,
		erp_gl_charts.accountname,
		(- 1) * abs(NEW.total_tax),
		NEW.reference_no,
		NEW.customer,
		NEW.biller_id,
		NEW.created_by,
		NEW.updated_by
	FROM
		erp_account_settings
	INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_sale_tax
	INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
	WHERE
		erp_gl_charts.accountcode = erp_account_settings.default_sale_tax;


END
IF;


IF NEW.shipping THEN
	INSERT INTO erp_gl_trans (
		tran_type,
		tran_no,
		tran_date,
		sectionid,
		account_code,
		narrative,
		amount,
		reference_no,
		description,
		biller_id,
		created_by,
		updated_by
	) SELECT
		'SALES',
		v_tran_no,
		NEW.date,
		erp_gl_sections.sectionid,
		erp_gl_charts.accountcode,
		erp_gl_charts.accountname,
		(- 1) * abs(NEW.shipping),
		NEW.reference_no,
		NEW.customer,
		NEW.biller_id,
		NEW.created_by,
		NEW.updated_by
	FROM
		erp_account_settings
	INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_sale_freight
	INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
	WHERE
		erp_gl_charts.accountcode = erp_account_settings.default_sale_freight;


END
IF;


END
IF;


END
IF;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_sale_update`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_sale_update` AFTER UPDATE ON `erp_sales` FOR EACH ROW BEGIN
DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;

IF NEW.sale_status="returned"  AND  NEW.return_id > 0 THEN
/*

	SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);
	UPDATE erp_order_ref SET tr = v_tran_no WHERE DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m'); 
*/

SET v_tran_date = (SELECT erp_sales.date 
		FROM erp_payments 
		INNER JOIN erp_sales ON erp_sales.id = erp_payments.sale_id
		WHERE erp_sales.id = NEW.id LIMIT 0,1);

IF v_tran_date = NEW.date THEN
	SET v_tran_no = (SELECT MAX(tran_no) FROM erp_gl_trans);
ELSE
	SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);
	
	UPDATE erp_order_ref
	SET tr = v_tran_no
	WHERE
	DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
END IF;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total+NEW.product_discount),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_sale
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * NEW.grand_total,
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_receivable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_receivable;
		
	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * NEW.total_cost,
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_cost
				INNER JOIN erp_gl_sections   ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_cost;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total_cost),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_stock
				INNER JOIN erp_gl_sections   ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_stock;


	IF NEW.total_discount THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * NEW.total_discount,
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_sale_discount
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale_discount;
		END IF;

	IF NEW.total_tax THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.total_tax),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_sale_tax
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale_tax;
		END IF;

	IF NEW.shipping THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES-RETURN',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			abs(NEW.shipping),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_sale_freight
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale_freight;
		END IF;
	
END IF;



IF NEW.sale_status="completed" AND NEW.total > 0 AND NEW.updated_by>0  AND NEW.return_id IS NULL THEN

SET v_tran_no = (SELECT tran_no FROM erp_gl_trans WHERE tran_type='SALES' AND reference_no = NEW.reference_no LIMIT 0,1);

	IF v_tran_no < 1  THEN
		SET v_tran_no = (SELECT COALESCE(MAX(tran_no),0) +1 FROM erp_gl_trans);	                
		UPDATE erp_order_ref SET tr = v_tran_no WHERE DATE_FORMAT(date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
	END IF;



DELETE FROM erp_gl_trans WHERE tran_type='SALES' AND bank=0 AND reference_no = NEW.reference_no;

	INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
		) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.total+NEW.product_discount),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts ON erp_gl_charts.accountcode = erp_account_settings.default_sale
				INNER JOIN erp_gl_sections ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.grand_total,
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_receivable
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_receivable;
		
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.total_cost,
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_cost
				INNER JOIN erp_gl_sections   ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_cost;

		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.total_cost),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_stock
				INNER JOIN erp_gl_sections   ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_stock;


	IF NEW.total_discount THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			NEW.total_discount,
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_sale_discount
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale_discount;
	END IF;

	IF NEW.total_tax THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.total_tax),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_sale_tax
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale_tax;
	END IF;

	IF NEW.shipping THEN
		INSERT INTO erp_gl_trans (
			tran_type,
			tran_no,
			tran_date,
			sectionid,
			account_code,
			narrative,
			amount,
			reference_no,
			description,
			biller_id,
			created_by,
			updated_by
			) SELECT
			'SALES',
			v_tran_no,
			NEW.date,
			erp_gl_sections.sectionid,
			erp_gl_charts.accountcode,
			erp_gl_charts.accountname,
			(-1) * abs(NEW.shipping),
			NEW.reference_no,
			NEW.customer,
			NEW.biller_id,
			NEW.created_by,
			NEW.updated_by
			FROM
				erp_account_settings
				INNER JOIN erp_gl_charts
				ON erp_gl_charts.accountcode = erp_account_settings.default_sale_freight
				INNER JOIN erp_gl_sections
				ON erp_gl_sections.sectionid = erp_gl_charts.sectionid
			WHERE
				erp_gl_charts.accountcode = erp_account_settings.default_sale_freight;
	END IF;
	
END IF;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `gl_trans_sale_delete`;
DELIMITER ;;
CREATE TRIGGER `gl_trans_sale_delete` AFTER DELETE ON `erp_sales` FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference_no;
END
;;
DELIMITER ;
