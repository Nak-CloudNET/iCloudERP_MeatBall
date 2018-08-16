-- phpMyAdmin SQL Dump
-- version 4.3.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 04, 2016 at 09:03 PM
-- Server version: 5.5.42-37.1-log
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `iclouder_Kinder`
--

-- --------------------------------------------------------

--
-- Table structure for table `erp_account_settings`
--

CREATE TABLE IF NOT EXISTS `erp_account_settings` (
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
  `default_loan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_account_settings`
--

INSERT INTO `erp_account_settings` (`id`, `biller_id`, `default_open_balance`, `default_sale`, `default_sale_discount`, `default_sale_tax`, `default_sale_freight`, `default_sale_deposit`, `default_receivable`, `default_purchase`, `default_purchase_discount`, `default_purchase_tax`, `default_purchase_freight`, `default_purchase_deposit`, `default_payable`, `default_stock`, `default_stock_adjust`, `default_cost`, `default_payroll`, `default_cash`, `default_credit_card`, `default_gift_card`, `default_cheque`, `default_loan`) VALUES
(1, 3, '300300', '410101', '410102', '201407', '410107', '201208', '100200', '100430', '500106', '100441', '500102', '100420', '201100', '100430', '500107', '500101', '201201', '100102', '100105', '201208', '100104', '100501');

-- --------------------------------------------------------

--
-- Table structure for table `erp_adjustments`
--

CREATE TABLE IF NOT EXISTS `erp_adjustments` (
  `id` int(11) NOT NULL,
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
  `biller_id` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `erp_adjustments`
--
DELIMITER $$
CREATE TRIGGER `gl_trans_adjustment_delete` AFTER DELETE ON `erp_adjustments`
 FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE tran_type='STOCK_ADJUST' AND reference_no = OLD.id;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_adjustment_insert` AFTER INSERT ON `erp_adjustments`
 FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;
DECLARE v_default_stock_adjust INTEGER;
DECLARE v_default_stock INTEGER;


SET v_tran_no = (SELECT MAX(tran_no)+1 FROM erp_gl_trans);

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
			(-1)* abs(NEW.total_cost),
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
			(-1)*abs(NEW.total_cost),
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
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_adjustment_update` AFTER UPDATE ON `erp_adjustments`
 FOR EACH ROW BEGIN

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
			(-1)* abs(NEW.total_cost),
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
			(-1)*abs(NEW.total_cost),
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
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `erp_bom`
--

CREATE TABLE IF NOT EXISTS `erp_bom` (
  `id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `noted` varchar(200) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_bom_items`
--

CREATE TABLE IF NOT EXISTS `erp_bom_items` (
  `id` int(11) NOT NULL,
  `bom_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` decimal(25,4) NOT NULL,
  `cost` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_calendar`
--

CREATE TABLE IF NOT EXISTS `erp_calendar` (
  `start` datetime NOT NULL,
  `title` varchar(55) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `end` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_captcha`
--

CREATE TABLE IF NOT EXISTS `erp_captcha` (
  `captcha_id` bigint(13) unsigned NOT NULL,
  `captcha_time` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `word` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_captcha`
--

INSERT INTO `erp_captcha` (`captcha_id`, `captcha_time`, `ip_address`, `word`) VALUES
(1, 1451963466, '192.168.1.122', 'N9ocX');

-- --------------------------------------------------------

--
-- Table structure for table `erp_categories`
--

CREATE TABLE IF NOT EXISTS `erp_categories` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL,
  `jobs` tinyint(1) unsigned DEFAULT '1',
  `auto_delivery` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_categories`
--

INSERT INTO `erp_categories` (`id`, `code`, `name`, `image`, `jobs`, `auto_delivery`) VALUES
(3, 'Cate01', 'School ', NULL, 1, NULL),
(4, 'Cate02', 'snack fee', NULL, 1, NULL),
(5, 'Cate03', 'Lunch', NULL, 1, NULL),
(6, 'Cate04', 'Learning Materails', NULL, 1, NULL),
(7, 'Cate05', 'Other ', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_combine_items`
--

CREATE TABLE IF NOT EXISTS `erp_combine_items` (
  `id` bigint(20) unsigned NOT NULL,
  `sale_deliveries_id` bigint(20) NOT NULL,
  `sale_deliveries_id_combine` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_combo_items`
--

CREATE TABLE IF NOT EXISTS `erp_combo_items` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_companies`
--

CREATE TABLE IF NOT EXISTS `erp_companies` (
  `id` int(11) NOT NULL,
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
  `phone` varchar(20) NOT NULL,
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
  `end_date` date DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `credit_limited` decimal(25,2) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_companies`
--

INSERT INTO `erp_companies` (`id`, `group_id`, `group_name`, `customer_group_id`, `customer_group_name`, `name`, `company`, `vat_no`, `address`, `city`, `state`, `postal_code`, `country`, `phone`, `email`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `invoice_footer`, `payment_term`, `logo`, `award_points`, `deposit_amount`, `status`, `posta_card`, `gender`, `attachment`, `date_of_birth`, `end_date`, `start_date`, `credit_limited`) VALUES
(2, 4, 'supplier', NULL, NULL, 'General Supplier', 'Supplier Company Name', NULL, 'Supplier Address', 'Phnom Penh', 'Kondal', '12345', 'Cambodia', '016282825', 'laykiry@yahoo.com', '-', '-', '-', '-', '-', '-', NULL, 0, 'logo.png', 0, NULL, NULL, NULL, NULL, NULL, '1990-06-14', NULL, '0000-00-00 00:00:00', NULL),
(3, NULL, 'biller', NULL, NULL, 'Kinderland', 'Kinderland', '5555', '#20E0 , Street 287 _I_ 558 Sangkat Beoung Kok 1 Khan Toul Kork ', 'Phnom Penh', 'Cambodia', '', 'Cambodia', '0236666600', 'info@kinderlandcambodia.com', '', 'ឃីនឌឺលែន', '', '', '1,2', '20%', ' Thank you for shopping with us. Please come again', 0, 'IMG_7862_-_Copy_(2).JPG', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00 00:00:00', NULL),
(443, 3, 'customer', 12, 'K1(Full TIme)', 'Taing William ', 'KL-000001', '', 'PP', 'Phnom Penh', '', '', 'Cambodai ', '012 321 888', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', NULL, NULL, NULL, NULL, 'male', NULL, '1899-12-31', '2016-06-17', '2016-03-01 07:00:00', NULL),
(444, 3, 'customer', 5, 'PN1(Full Time)', 'Try Kelven', 'KL-000002', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '017 838 878', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', NULL, NULL, NULL, NULL, 'male', NULL, '2014-04-22', '2016-06-17', '2016-04-05 06:00:00', NULL),
(445, 3, 'customer', 11, 'Nursery(Part Time)', 'Hong Puthisak', 'KL-000003', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '077 260 066', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, 'male', NULL, '2012-10-05', '2016-09-30', '2016-07-18 06:00:00', NULL),
(446, 3, 'customer', 5, 'PN1(Full Time)', 'Hong Puthivattey ', 'KL-000004', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '077 260 066', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, 'female', NULL, '2014-10-05', '2016-12-16', '2016-10-03 06:00:00', NULL),
(447, 3, 'customer', 5, 'PN1(Full Time)', 'Third Child', 'KL-000005', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '077 260 066', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, '', NULL, '0000-00-00', '0000-00-00', '0000-00-00 00:00:00', NULL),
(448, 3, 'customer', 10, 'Nursery(Full Time)', 'Chau Madeleing ', 'KL-000006', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 656 779', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, 'male', NULL, '0000-00-00', '2016-09-30', '2016-07-18 06:00:00', NULL),
(449, 3, 'customer', 9, 'PN2(Part Time)', 'Soum Monyrothana', 'KL-000007', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '011 266 678', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, 'male', NULL, '0000-00-00', '2016-09-30', '2016-07-18 06:00:00', NULL),
(450, 3, 'customer', 5, 'PN1(Full Time)', 'Soum Monysethika ', 'KL-000008', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '011 266 678', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, 'female', NULL, '2014-09-26', '2016-09-30', '2016-07-18 06:00:00', NULL),
(451, 3, 'customer', 8, 'PN2 (Full Time)', 'Sambath Sakda', 'KL-000009', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 664 002', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 82, '0.0000', NULL, NULL, 'male', NULL, '2013-07-19', '2016-09-30', '2016-07-18 06:00:00', NULL),
(452, 3, 'customer', 5, 'PN1(Full Time)', 'Lay Chhorvida', 'KL-000010', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '011 867 070', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, '0.0000', NULL, NULL, 'female', NULL, '2014-11-04', '2106-09-30', '2016-07-18 06:00:00', NULL),
(453, 3, 'customer', 8, 'PN2 (Full Time)', 'Chin Sokhey', 'KL-000011', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '077 306 830 ', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 121, NULL, NULL, NULL, 'female', NULL, '2013-04-18', '2016-06-17', '2016-03-31 06:00:00', NULL),
(454, 3, 'customer', 8, 'PN2 (Full Time)', 'Chin Sokha', 'KL-000012', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '077 306 830', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 121, NULL, NULL, NULL, 'male', NULL, '2016-04-08', '2016-06-17', '2016-03-31 06:00:00', NULL),
(455, 3, 'customer', 10, 'Nursery(Full Time)', 'Tharagun', 'KL-000013', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '089 743 545', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 240, NULL, NULL, NULL, 'male', NULL, '2016-05-26', '2016-09-30', '2016-07-18 06:00:00', NULL),
(456, 3, 'customer', 8, 'PN2 (Full Time)', 'Meng Kim Chhorng', 'KL-000014', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '086 610 000', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 105, NULL, NULL, NULL, 'male', NULL, '2013-07-02', '2016-06-17', '2016-03-28 06:00:00', NULL),
(457, 3, 'customer', 8, 'PN2 (Full Time)', 'Vong Sonita', 'KL-000015', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 953 783', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 121, NULL, NULL, NULL, 'female', NULL, '2013-01-11', '2016-06-17', '2016-04-05 06:00:00', NULL),
(458, 3, 'customer', 10, 'Nursery(Full Time)', 'Sarim Vansereboth', 'KL-000016', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '017 663 865', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 95, NULL, NULL, NULL, 'male', NULL, '2012-09-21', '2016-09-30', '2016-07-18 06:00:00', NULL),
(459, 3, 'customer', 10, 'Nursery(Full Time)', 'Ay Erin', 'KL-000017', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '017 787 888', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 95, NULL, NULL, NULL, 'female', NULL, '2012-10-19', '2016-09-30', '2016-07-18 06:00:00', NULL),
(460, 3, 'customer', 9, 'PN2(Part Time)', 'Nim Vichitachhorvida', 'KL-000018', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '096 833 3339', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 90, NULL, NULL, NULL, 'female', NULL, '2013-05-25', '2016-09-30', '2016-07-18 06:00:00', NULL),
(461, 3, 'customer', 8, 'PN2 (Full Time)', 'Cheang Sambath ', 'KL-000019', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 939 959', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 136, NULL, NULL, NULL, 'male', NULL, '2013-07-08', '2016-09-30', '2016-07-18 06:00:00', NULL),
(462, 3, 'customer', 8, 'PN2 (Full Time)', 'Hun Kunnawath', 'KL-000020', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '015 890 888', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 106, NULL, NULL, NULL, 'male', NULL, '2013-03-03', '2016-06-17', '2016-04-19 06:00:00', NULL),
(463, 3, 'customer', 5, 'PN1(Full Time)', 'Sambath Norin', 'KL-000021', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 664 002', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 30, NULL, NULL, NULL, 'male', NULL, '2015-01-24', '2017-03-24', '2017-01-03 07:00:00', NULL),
(464, 3, 'customer', 5, 'PN1(Full Time)', 'Chhun Janessa', 'KL-000022', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '011 229 923', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 95, NULL, NULL, NULL, 'female', NULL, '2014-08-01', '2016-09-30', '0000-00-00 00:00:00', NULL),
(465, 3, 'customer', 5, 'PN1(Full Time)', 'Sovann Manith ', 'KL-000023', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 600 357', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 95, NULL, NULL, NULL, 'female', NULL, '2014-03-21', '2016-09-30', '2016-07-18 06:00:00', NULL),
(466, 3, 'customer', 5, 'PN1(Full Time)', 'Tema Souphearon ', 'KL-000024', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '012 216 216 ', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 139, NULL, NULL, NULL, 'male', NULL, '2014-03-21', '2106-09-30', '2016-07-18 06:00:00', NULL),
(467, 3, 'customer', 5, 'PN1(Full Time)', 'General Student', 'General Student', '', '123456789', 'Phnom Penh', '', '', 'Cambodia', '123456789', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', NULL, NULL, NULL, NULL, '', NULL, '0000-00-00', '0000-00-00', '0000-00-00 00:00:00', NULL),
(468, 3, 'customer', 5, 'PN1(Full Time)', 'Suy Chhiev Eng ', 'KL-000025', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '097 633 3556', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 7, NULL, NULL, NULL, 'female', NULL, '0000-00-00', '2016-05-01', '2016-04-26 06:00:00', NULL),
(469, 3, 'customer', 5, 'PN1(Full Time)', 'Ma Gechleng ', 'KL-000026', '', 'PP', 'Phnom Penh', '', '', 'Cambodai', '071 333 0118', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'logo.png', 7, NULL, NULL, NULL, 'female', NULL, '0000-00-00', '2016-06-12', '2016-06-06 06:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_convert`
--

CREATE TABLE IF NOT EXISTS `erp_convert` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(55) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `noted` varchar(200) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `bom_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_convert_items`
--

CREATE TABLE IF NOT EXISTS `erp_convert_items` (
  `id` int(11) NOT NULL,
  `convert_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` decimal(25,4) NOT NULL,
  `cost` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_costing`
--

CREATE TABLE IF NOT EXISTS `erp_costing` (
  `id` int(11) NOT NULL,
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
  `option_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_costing`
--

INSERT INTO `erp_costing` (`id`, `date`, `product_id`, `sale_item_id`, `sale_id`, `purchase_item_id`, `quantity`, `purchase_net_unit_cost`, `purchase_unit_cost`, `sale_net_unit_price`, `sale_unit_price`, `quantity_balance`, `inventory`, `overselling`, `option_id`) VALUES
(1, '2016-03-21', 27, 11, 3, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(2, '2016-03-21', 27, 12, 4, NULL, '0.0000', '0.0000', '0.0000', '300.0000', '300.0000', '1.0000', NULL, 0, NULL),
(3, '2016-03-21', 27, 13, 5, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(4, '2016-03-21', 27, 14, 6, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(5, '2016-03-22', 27, 15, 7, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(6, '2016-03-23', 27, 16, 8, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(7, '2016-03-23', 27, 17, 9, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(8, '2016-03-23', 27, 18, 10, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(9, '2016-03-24', 27, 19, 11, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(10, '2016-03-24', 29, 20, 12, NULL, '0.0000', '0.0000', '0.0000', '70.0000', '70.0000', '0.0000', NULL, 0, NULL),
(11, '2016-03-24', 29, 21, 13, NULL, '0.0000', '0.0000', '0.0000', '70.0000', '70.0000', '0.0000', NULL, 0, NULL),
(12, '2016-03-28', 29, 22, 14, NULL, '0.0000', '0.0000', '0.0000', '70.0000', '70.0000', '0.0000', NULL, 0, NULL),
(13, '2016-03-31', 11, 23, 15, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(14, '2016-03-31', 14, 24, 15, NULL, '1.0000', '0.0000', '0.0000', '90.0000', '90.0000', NULL, NULL, 0, NULL),
(15, '2016-03-31', 23, 25, 15, NULL, '1.0000', '0.0000', '0.0000', '110.0000', '110.0000', NULL, NULL, 0, NULL),
(16, '2016-03-31', 27, 26, 15, NULL, '1.0000', '0.0000', '0.0000', '200.0000', '200.0000', NULL, NULL, 0, NULL),
(17, '2016-03-31', 11, 27, 16, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(18, '2016-03-31', 14, 28, 16, NULL, '1.0000', '0.0000', '0.0000', '90.0000', '90.0000', NULL, NULL, 0, NULL),
(19, '2016-03-31', 23, 29, 16, NULL, '1.0000', '0.0000', '0.0000', '110.0000', '110.0000', NULL, NULL, 0, NULL),
(20, '2016-03-31', 27, 30, 16, NULL, '1.0000', '0.0000', '0.0000', '200.0000', '200.0000', NULL, NULL, 0, NULL),
(21, '2016-04-01', 13, 31, 17, NULL, '1.0000', '0.0000', '0.0000', '4798.0000', '4800.0000', NULL, NULL, 0, NULL),
(22, '2016-04-01', 26, 32, 17, NULL, '2.0000', NULL, NULL, '0.0000', '0.0000', NULL, 1, 1, NULL),
(23, '2016-04-01', 27, 33, 17, NULL, '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, 0, NULL),
(24, '2016-04-01', 28, 34, 17, NULL, '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, 0, NULL),
(25, '2016-04-01', 27, 35, 18, NULL, '1.0000', '0.0000', '0.0000', '200.0000', '200.0000', NULL, NULL, 0, NULL),
(26, '2016-04-04', 11, 36, 19, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(27, '2016-04-04', 14, 37, 19, NULL, '1.0000', '0.0000', '0.0000', '90.0000', '90.0000', NULL, NULL, 0, NULL),
(28, '2016-04-04', 20, 38, 19, NULL, '1.0000', '0.0000', '0.0000', '150.0000', '150.0000', NULL, NULL, 0, NULL),
(29, '2016-04-04', 23, 39, 19, NULL, '1.0000', '0.0000', '0.0000', '110.0000', '110.0000', NULL, NULL, 0, NULL),
(30, '2016-04-04', 26, 40, 19, NULL, '1.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(31, '2016-04-04', 27, 41, 19, NULL, '1.0000', '0.0000', '0.0000', '200.0000', '200.0000', NULL, NULL, 0, NULL),
(32, '2016-04-04', 28, 42, 19, NULL, '1.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, 0, NULL),
(33, '2016-04-05', 27, 43, 20, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(34, '2016-04-05', 20, 44, 21, NULL, '1.0000', '0.0000', '0.0000', '150.0000', '150.0000', NULL, NULL, 0, NULL),
(35, '2016-04-05', 20, 45, 22, NULL, '1.0000', '0.0000', '0.0000', '150.0000', '150.0000', NULL, NULL, 0, NULL),
(36, '2016-04-06', 11, 46, 23, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(37, '2016-04-06', 27, 47, 23, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(38, '2016-04-06', 5, 48, 24, NULL, '1.0000', '0.0000', '0.0000', '525.0000', '750.0000', NULL, NULL, 0, NULL),
(39, '2016-04-06', 27, 49, 24, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(40, '2016-04-18', 11, 50, 25, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(41, '2016-04-18', 14, 51, 25, NULL, '1.0000', '0.0000', '0.0000', '90.0000', '90.0000', NULL, NULL, 0, NULL),
(42, '2016-04-18', 23, 52, 25, NULL, '1.0000', '0.0000', '0.0000', '110.0000', '110.0000', NULL, NULL, 0, NULL),
(43, '2016-04-18', 26, 53, 25, NULL, '2.0000', NULL, NULL, '0.0000', '0.0000', NULL, 1, 1, NULL),
(44, '2016-04-19', 11, 54, 26, NULL, '1.0000', '0.0000', '0.0000', '430.0000', '430.0000', NULL, NULL, 0, NULL),
(45, '2016-04-19', 14, 55, 26, NULL, '1.0000', '0.0000', '0.0000', '68.0000', '68.0000', NULL, NULL, 0, NULL),
(46, '2016-04-19', 20, 56, 26, NULL, '1.0000', '0.0000', '0.0000', '113.0000', '113.0000', NULL, NULL, 0, NULL),
(47, '2016-04-19', 23, 57, 26, NULL, '1.0000', '0.0000', '0.0000', '83.0000', '83.0000', NULL, NULL, 0, NULL),
(48, '2016-04-19', 26, 58, 26, NULL, '1.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(49, '2016-04-19', 27, 59, 26, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(50, '2016-04-20', 5, 60, 27, NULL, '1.0000', '0.0000', '0.0000', '525.0000', '750.0000', NULL, NULL, 0, NULL),
(51, '2016-04-25', 11, 61, 28, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(52, '2016-04-27', 27, 62, 29, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(53, '2016-04-28', 11, 63, 30, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(54, '2016-04-28', 27, 64, 30, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(55, '2016-04-26', 29, 65, 31, NULL, '1.0000', '0.0000', '0.0000', '70.0000', '70.0000', NULL, NULL, 0, NULL),
(56, '2016-04-11', 27, 66, 32, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(57, '2106-05-07', 11, 67, 33, NULL, '0.0000', '0.0000', '0.0000', '650.0000', '1300.0000', '1.0000', NULL, 0, NULL),
(58, '2106-05-07', 27, 68, 33, NULL, '0.0000', '0.0000', '0.0000', '300.0000', '300.0000', '1.0000', NULL, 0, NULL),
(59, '2016-05-26', 26, 69, 34, NULL, '2.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(60, '2016-06-02', 26, 70, 35, NULL, '2.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(61, '2016-06-03', 26, 71, 36, NULL, '1.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(62, '2016-06-03', 26, 72, 37, NULL, '1.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(63, '2016-06-06', 29, 73, 38, NULL, '1.0000', '0.0000', '0.0000', '70.0000', '70.0000', NULL, NULL, 0, NULL),
(64, '2016-06-17', 17, 74, 39, NULL, '1.0000', '0.0000', '0.0000', '50.0000', '50.0000', NULL, NULL, 0, NULL),
(65, '2016-06-17', 26, 75, 39, NULL, '2.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(66, '2016-06-17', 6, 76, 40, NULL, '0.0000', '0.0000', '0.0000', '980.0000', '1400.0000', '1.0000', NULL, 0, NULL),
(67, '2016-06-17', 18, 77, 40, NULL, '0.0000', '0.0000', '0.0000', '100.0000', '100.0000', '1.0000', NULL, 0, NULL),
(68, '2016-06-17', 26, 78, 40, NULL, '0.0000', NULL, NULL, '15.0000', '15.0000', '1.0000', 1, 1, NULL),
(69, '2016-06-17', 27, 79, 40, NULL, '0.0000', '0.0000', '0.0000', '300.0000', '300.0000', '1.0000', NULL, 0, NULL),
(70, '2016-06-22', 11, 80, 41, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(71, '2016-06-22', 14, 81, 41, NULL, '1.0000', '0.0000', '0.0000', '90.0000', '90.0000', NULL, NULL, 0, NULL),
(72, '2016-06-22', 20, 82, 41, NULL, '1.0000', '0.0000', '0.0000', '150.0000', '150.0000', NULL, NULL, 0, NULL),
(73, '2016-06-22', 23, 83, 41, NULL, '1.0000', '0.0000', '0.0000', '110.0000', '110.0000', NULL, NULL, 0, NULL),
(74, '2016-06-22', 26, 84, 41, NULL, '4.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(75, '2016-06-17', 6, 85, 42, NULL, '1.0000', '0.0000', '0.0000', '980.0000', '1400.0000', NULL, NULL, 0, NULL),
(76, '2016-06-17', 18, 86, 42, NULL, '1.0000', '0.0000', '0.0000', '100.0000', '100.0000', NULL, NULL, 0, NULL),
(77, '2016-06-17', 26, 87, 42, NULL, '1.0000', NULL, NULL, '15.0000', '15.0000', NULL, 1, 1, NULL),
(78, '2016-06-17', 27, 88, 42, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL),
(79, '2016-05-07', 11, 89, 43, NULL, '1.0000', '0.0000', '0.0000', '650.0000', '1300.0000', NULL, NULL, 0, NULL),
(80, '2016-05-07', 27, 90, 43, NULL, '1.0000', '0.0000', '0.0000', '300.0000', '300.0000', NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_currencies`
--

CREATE TABLE IF NOT EXISTS `erp_currencies` (
  `id` int(11) NOT NULL,
  `code` varchar(5) NOT NULL,
  `name` varchar(55) NOT NULL,
  `rate` decimal(12,4) NOT NULL,
  `auto_update` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_currencies`
--

INSERT INTO `erp_currencies` (`id`, `code`, `name`, `rate`, `auto_update`) VALUES
(1, 'USD', 'US Dollar', '1.0000', 0),
(2, 'KHM', 'RIAL', '4050.0000', 0);

-- --------------------------------------------------------

--
-- Table structure for table `erp_customer_groups`
--

CREATE TABLE IF NOT EXISTS `erp_customer_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `percent` int(11) NOT NULL,
  `makeup_cost` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_customer_groups`
--

INSERT INTO `erp_customer_groups` (`id`, `name`, `percent`, `makeup_cost`) VALUES
(5, 'PN1(Full Time)', 0, 0),
(7, 'PN1(Part Time)', 0, 0),
(8, 'PN2 (Full Time)', 0, 0),
(9, 'PN2(Part Time)', 0, 0),
(10, 'Nursery(Full Time)', 0, 0),
(11, 'Nursery(Part Time)', 0, 0),
(12, 'K1(Full TIme)', 0, 0),
(13, 'K1(Part Time)', 0, 0),
(14, 'K2(Full Time)', 0, 0),
(15, 'K2(Part Time)', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `erp_date_format`
--

CREATE TABLE IF NOT EXISTS `erp_date_format` (
  `id` int(11) NOT NULL,
  `js` varchar(20) NOT NULL,
  `php` varchar(20) NOT NULL,
  `sql` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_date_format`
--

INSERT INTO `erp_date_format` (`id`, `js`, `php`, `sql`) VALUES
(1, 'mm-dd-yyyy', 'm-d-Y', '%m-%d-%Y'),
(2, 'mm/dd/yyyy', 'm/d/Y', '%m/%d/%Y'),
(3, 'mm.dd.yyyy', 'm.d.Y', '%m.%d.%Y'),
(4, 'dd-mm-yyyy', 'd-m-Y', '%d-%m-%Y'),
(5, 'dd/mm/yyyy', 'd/m/Y', '%d/%m/%Y'),
(6, 'dd.mm.yyyy', 'd.m.Y', '%d.%m.%Y');

-- --------------------------------------------------------

--
-- Table structure for table `erp_deliveries`
--

CREATE TABLE IF NOT EXISTS `erp_deliveries` (
  `id` int(11) NOT NULL,
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
  `delivery_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_deliveries`
--

INSERT INTO `erp_deliveries` (`id`, `date`, `sale_id`, `do_reference_no`, `sale_reference_no`, `customer`, `address`, `note`, `created_by`, `updated_by`, `updated_at`, `delivery_status`) VALUES
(1, '2016-03-21 06:00:00', 3, 'DO/1606/00001', '1603-000003', 'Hong Puthisak', 'PP Phnom Penh   Cambodai<br>Tel: 077 260 066 Email: ', NULL, 1, NULL, NULL, 'pending'),
(2, '2016-03-21 06:00:00', 4, 'DO/1606/00002', '1603-000003', 'Hong Puthisak', 'PP Phnom Penh   Cambodai<br>Tel: 077 260 066 Email: ', NULL, 1, NULL, NULL, 'pending'),
(3, '2016-03-21 06:00:00', 5, 'DO/1606/00003', '1603-000004', 'Hong Puthivattey ', 'PP Phnom Penh   Cambodai<br>Tel: 077 260 066 Email: ', NULL, 1, NULL, NULL, 'pending'),
(4, '2016-03-21 06:00:00', 6, 'DO/1606/00004', '1603-000005', 'Third Child', 'PP Phnom Penh   Cambodai<br>Tel: 077 260 066 Email: ', NULL, 1, NULL, NULL, 'pending'),
(5, '2016-03-22 06:00:00', 7, 'DO/1606/00005', '1603-000006', 'Chau Madeleing ', 'PP Phnom Penh   Cambodai<br>Tel: 012 656 779 Email: ', NULL, 1, NULL, NULL, 'pending'),
(6, '2016-03-23 06:00:00', 8, 'DO/1606/00006', '1603-000007', 'Soum Monyrothana', 'PP Phnom Penh   Cambodai<br>Tel: 011 266 678 Email: ', NULL, 1, NULL, NULL, 'pending'),
(7, '2016-03-23 06:00:00', 9, 'DO/1606/00007', '1603-000008', 'Soum Monysethika ', 'PP Phnom Penh   Cambodai<br>Tel: 011 266 678 Email: ', NULL, 1, NULL, NULL, 'pending'),
(8, '2016-03-23 06:00:00', 10, 'DO/1606/00008', '1603-000009', 'Sambath Sakda', 'PP Phnom Penh   Cambodai<br>Tel: 012 664 002 Email: ', NULL, 1, NULL, NULL, 'pending'),
(9, '2016-03-24 06:00:00', 11, 'DO/1606/00009', '1603-000010', 'Lay Chhorvida', 'PP Phnom Penh   Cambodai<br>Tel: 011 867 070 Email: ', NULL, 1, NULL, NULL, 'pending'),
(10, '2016-03-24 06:00:00', 12, 'DO/1606/00010', '1603-000011', 'Chin Sokhey', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830  Email: ', NULL, 1, NULL, NULL, 'pending'),
(11, '2016-03-24 06:00:00', 13, 'DO/1606/00011', '1603-000012', 'Chin Sokha', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830 Email: ', NULL, 1, NULL, NULL, 'pending'),
(12, '2016-03-28 06:00:00', 14, 'DO/1606/00012', '1603-000013', 'Meng Kim Chhorng', 'PP Phnom Penh   Cambodai<br>Tel: 086 610 000 Email: ', NULL, 1, NULL, NULL, 'pending'),
(13, '2016-03-31 06:00:00', 15, 'DO/1606/00013', '1603-000014', 'Chin Sokhey', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830  Email: ', NULL, 1, NULL, NULL, 'pending'),
(14, '2016-03-31 06:00:00', 16, 'DO/1606/00014', '1603-000015', 'Chin Sokha', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830 Email: ', NULL, 1, NULL, NULL, 'pending'),
(15, '2016-04-01 06:00:00', 17, 'DO/1606/00015', '1604-000016', 'Tharagun', 'PP Phnom Penh   Cambodai<br>Tel: 089 743 545 Email: ', NULL, 1, NULL, NULL, 'pending'),
(16, '2016-04-01 06:00:00', 18, 'DO/1606/00016', '1604-000017', 'Meng Kim Chhorng', 'PP Phnom Penh   Cambodai<br>Tel: 086 610 000 Email: ', NULL, 1, NULL, NULL, 'pending'),
(17, '2016-04-04 06:00:00', 19, 'DO/1606/00017', '1604-000018', 'Vong Sonita', 'PP Phnom Penh   Cambodai<br>Tel: 012 953 783 Email: ', NULL, 1, NULL, NULL, 'pending'),
(18, '2016-04-05 06:00:00', 20, 'DO/1606/00018', '1604-000020', 'Sarim Vansereboth', 'PP Phnom Penh   Cambodai<br>Tel: 017 663 865 Email: ', NULL, 1, NULL, NULL, 'pending'),
(19, '2016-04-05 06:00:00', 21, 'DO/1606/00019', '1604-000021', 'Chin Sokhey', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830  Email: ', NULL, 1, NULL, NULL, 'pending'),
(20, '2016-04-05 06:00:00', 22, 'DO/1606/00020', '1604-000022', 'Chin Sokha', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830 Email: ', NULL, 1, NULL, NULL, 'pending'),
(21, '2016-04-06 06:00:00', 23, 'DO/1606/00021', '1604-000023', 'Ay Erin', 'PP Phnom Penh   Cambodai<br>Tel: 017 787 888 Email: ', NULL, 1, NULL, NULL, 'pending'),
(22, '2016-04-06 06:00:00', 24, 'DO/1606/00022', '1604-000024', 'Nim Vichitachhorvida', 'PP Phnom Penh   Cambodai<br>Tel: 096 833 3339 Email: ', NULL, 1, NULL, NULL, 'pending'),
(23, '2016-04-18 06:00:00', 25, 'DO/1606/00023', '1604-000026', 'Meng Kim Chhorng', 'PP Phnom Penh   Cambodai<br>Tel: 086 610 000 Email: ', NULL, 1, NULL, NULL, 'pending'),
(24, '2016-04-19 06:00:00', 26, 'DO/1606/00024', '1604-000027', 'Hun Kunnawath', 'PP Phnom Penh   Cambodai<br>Tel: 015 890 888 Email: ', NULL, 1, NULL, NULL, 'pending'),
(25, '2016-04-20 06:00:00', 27, 'DO/1606/00025', '1604-000028', 'Sambath Sakda', 'PP Phnom Penh   Cambodai<br>Tel: 012 664 002 Email: ', NULL, 1, NULL, NULL, 'pending'),
(26, '2016-04-25 06:00:00', 28, 'DO/1606/00026', '1604-000029', 'Sarim Vansereboth', 'PP Phnom Penh   Cambodai<br>Tel: 017 663 865 Email: ', NULL, 1, NULL, NULL, 'pending'),
(27, '2016-04-27 06:00:00', 29, 'DO/1606/00027', '1604-000031', 'Sambath Norin', 'PP Phnom Penh   Cambodai<br>Tel: 012 664 002 Email: ', NULL, 1, NULL, NULL, 'pending'),
(28, '2016-04-28 06:00:00', 30, 'DO/1606/00028', '1604-000032', 'Chhun Janessa', 'PP Phnom Penh   Cambodai<br>Tel: 011 229 923 Email: ', NULL, 1, NULL, NULL, 'pending'),
(29, '2016-04-26 06:00:00', 31, 'DO/1606/00029', '1603-000030', 'Suy Chhiev Eng ', 'PP Phnom Penh   Cambodai<br>Tel: 097 633 3556 Email: ', NULL, 1, NULL, NULL, 'pending'),
(30, '2016-04-11 06:00:00', 32, 'DO/1606/00030', '1604-000025', 'Cheang Sambath ', 'PP Phnom Penh   Cambodai<br>Tel: 012 939 959 Email: ', NULL, 1, NULL, NULL, 'pending'),
(31, '0000-00-00 00:00:00', 33, 'DO/1606/00031', '1605-000033', 'Sovann Manith ', 'PP Phnom Penh   Cambodai<br>Tel: 012 600 357 Email: ', NULL, 1, NULL, NULL, 'pending'),
(32, '2016-05-26 06:00:00', 34, 'DO/1606/00032', '1605-000035', 'Hun Kunnawath', 'PP Phnom Penh   Cambodai<br>Tel: 015 890 888 Email: ', NULL, 1, NULL, NULL, 'pending'),
(33, '2016-06-02 06:00:00', 35, 'DO/1606/00033', '1606-000036', 'Hun Kunnawath', 'PP Phnom Penh   Cambodai<br>Tel: 015 890 888 Email: ', NULL, 1, NULL, NULL, 'pending'),
(34, '2016-06-03 06:00:00', 36, 'DO/1606/00034', '1606-000037', 'Chin Sokhey', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830  Email: ', NULL, 1, NULL, NULL, 'pending'),
(35, '2016-06-03 06:00:00', 37, 'DO/1606/00035', '1606-000038', 'Chin Sokha', 'PP Phnom Penh   Cambodai<br>Tel: 077 306 830 Email: ', NULL, 1, NULL, NULL, 'pending'),
(36, '2016-06-06 06:00:00', 38, 'DO/1606/00036', '1606-000039', 'Ma Gechleng ', 'PP Phnom Penh   Cambodai<br>Tel: 071 333 0118 Email: ', NULL, 1, NULL, NULL, 'pending'),
(37, '2016-06-17 06:00:00', 39, 'DO/1606/00037', '1606-000040', 'Nim Vichitachhorvida', 'PP Phnom Penh   Cambodai<br>Tel: 096 833 3339 Email: ', NULL, 1, NULL, NULL, 'pending'),
(38, '2016-06-17 06:00:00', 40, 'DO/1606/00038', '1606-000041', 'Tema Souphearon', 'PP Phnom Penh   Cambodai<br>Tel: 016 585 5555 Email: ', NULL, 1, NULL, NULL, 'pending'),
(39, '2016-06-22 06:00:00', 41, 'DO/1606/00039', '1606-000042', 'Cheang Sambath ', 'PP Phnom Penh   Cambodai<br>Tel: 012 939 959 Email: ', NULL, 1, NULL, NULL, 'pending'),
(40, '2016-06-17 06:00:00', 42, 'DO/1606/00040', '1606-000041', 'Tema Souphearon ', 'PP Phnom Penh   Cambodai<br>Tel: 012 216 216  Email: ', NULL, 1, NULL, NULL, 'pending'),
(41, '2016-05-07 06:00:00', 43, 'DO/1607/00001', '1605-000033', 'Sovann Manith ', 'PP Phnom Penh   Cambodai<br>Tel: 012 600 357 Email: ', NULL, 1, NULL, NULL, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `erp_deposits`
--

CREATE TABLE IF NOT EXISTS `erp_deposits` (
  `id` int(11) NOT NULL,
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
  `biller_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_expenses`
--

CREATE TABLE IF NOT EXISTS `erp_expenses` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference` varchar(55) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
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
  `warehouse_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `erp_expenses`
--
DELIMITER $$
CREATE TRIGGER `gl_trans_expense_delete` AFTER DELETE ON `erp_expenses`
 FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_expense_insert` AFTER INSERT ON `erp_expenses`
 FOR EACH ROW BEGIN

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
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_expense_update` AFTER UPDATE ON `erp_expenses`
 FOR EACH ROW BEGIN

DECLARE v_tran_no INTEGER;


	SET v_tran_no = (SELECT tran_no FROM erp_gl_trans WHERE reference_no = NEW.reference LIMIT 0,1);
	IF v_tran_no < 1  THEN

		SET v_tran_no = (SELECT MAX(tran_no)+1 FROM erp_gl_trans);
	                
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
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `erp_gift_cards`
--

CREATE TABLE IF NOT EXISTS `erp_gift_cards` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `card_no` varchar(20) NOT NULL,
  `value` decimal(25,4) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `balance` decimal(25,4) NOT NULL,
  `expiry` date DEFAULT NULL,
  `created_by` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_gl_charts`
--

CREATE TABLE IF NOT EXISTS `erp_gl_charts` (
  `accountcode` int(11) NOT NULL DEFAULT '0',
  `accountname` varchar(200) DEFAULT '',
  `parent_acc` int(11) DEFAULT '0',
  `sectionid` int(11) DEFAULT '0',
  `account_tax_id` int(11) DEFAULT '0',
  `acc_level` int(11) DEFAULT '0',
  `lineage` varchar(500) NOT NULL,
  `bank` tinyint(1) DEFAULT NULL,
  `value` decimal(55,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_gl_charts`
--

INSERT INTO `erp_gl_charts` (`accountcode`, `accountname`, `parent_acc`, `sectionid`, `account_tax_id`, `acc_level`, `lineage`, `bank`, `value`) VALUES
(100100, 'Cash', 0, 10, 0, 0, '', NULL, '0.00'),
(100101, 'Petty Cash', 100100, 10, 0, 0, '', 1, '0.00'),
(100102, 'Cash on Hand', 100100, 10, 0, 0, '', 1, '0.00'),
(100103, 'ANZ Bank', 100100, 10, 0, 0, '', 1, '0.00'),
(100104, 'ACELDA Bank', 100100, 10, 0, 0, '', 1, '0.00'),
(100105, 'Visa', 100100, 10, 0, 0, '', 1, '0.00'),
(100106, 'Chequing Bank Account', 100100, 10, 0, 0, '', 1, '0.00'),
(100200, 'Account Receivable', 0, 10, 0, 0, '', NULL, '0.00'),
(100400, 'Other Current Assets', 0, 10, 0, 0, '', NULL, '0.00'),
(100410, 'Prepaid Expense', 100400, 10, 0, 0, '', NULL, '0.00'),
(100420, 'Supplier Deposit', 100400, 10, 0, 0, '', NULL, '0.00'),
(100430, 'Inventory', 100400, 10, 0, 0, '', NULL, '0.00'),
(100440, 'Deferred Tax Asset', 100400, 10, 0, 0, '', NULL, '0.00'),
(100441, 'VAT Input', 100440, 10, 0, 0, '', NULL, '0.00'),
(100442, 'VAT Credit Carried Forward', 100440, 10, 0, 0, '', NULL, '0.00'),
(100500, 'Cash Advance', 100400, 10, 0, 0, '', NULL, '0.00'),
(100501, 'Loan to Related Parties', 100400, 10, 0, 0, '', NULL, '0.00'),
(100502, 'Staff Advance Cash', 100400, 10, 0, 0, '', NULL, '0.00'),
(101005, 'Own Invest', 0, 80, 0, 0, '', 1, '0.00'),
(110200, 'Property, Plant and Equipment', 0, 11, 0, 0, '', NULL, '0.00'),
(110201, 'Furniture', 110200, 11, 0, 0, '', NULL, '0.00'),
(110202, 'Office Equipment', 110200, 11, 0, 0, '', NULL, '0.00'),
(110203, 'Machineries', 110200, 11, 0, 0, '', NULL, '0.00'),
(110204, 'Leasehold Improvement', 110200, 11, 0, 0, '', NULL, '0.00'),
(110205, 'IT Equipment & Computer', 110200, 11, 0, 0, '', NULL, '0.00'),
(110206, 'Vehicle', 110200, 11, 0, 0, '', NULL, '0.00'),
(110250, 'Less Total Accumulated Depreciation', 110200, 11, 0, 0, '', NULL, '0.00'),
(110251, 'Less Acc. Dep. of Furniture', 110250, 11, 0, 0, '', NULL, '0.00'),
(110252, 'Less Acc. Dep. of Office Equipment', 110250, 11, 0, 0, '', NULL, '0.00'),
(110253, 'Less Acc. Dep. of Machineries', 110250, 11, 0, 0, '', NULL, '0.00'),
(110254, 'Less Acc. Dep. of Leasehold Improvement', 110250, 11, 0, 0, '', NULL, '0.00'),
(110255, 'Less Acc. Dep. of IT Equipment & Computer', 110250, 11, 0, 0, '', NULL, '0.00'),
(110256, 'Less Acc. Dep of Vehicle', 110250, 11, 0, 0, '', NULL, '0.00'),
(201100, 'Accounts Payable', 0, 20, 0, 0, '', NULL, '0.00'),
(201200, 'Other Current Liabilities', 0, 20, 0, 0, '', NULL, '0.00'),
(201201, 'Salary Payable', 201200, 20, 0, 0, '', NULL, '0.00'),
(201202, 'OT Payable', 201200, 20, 0, 0, '', NULL, '0.00'),
(201203, 'Allowance Payable', 201200, 20, 0, 0, '', NULL, '0.00'),
(201204, 'Bonus Payable', 201200, 20, 0, 0, '', NULL, '0.00'),
(201205, 'Commission Payable', 201200, 20, 0, 0, '', NULL, '0.00'),
(201206, 'Interest Payable', 201200, 20, 0, 0, '', NULL, '0.00'),
(201207, 'Loan from Related Parties', 201200, 20, 0, 0, '', NULL, '0.00'),
(201208, 'Customer Deposit', 201200, 20, 0, 0, '', NULL, '0.00'),
(201209, 'Accrued Expense', 201200, 20, 0, 0, '', NULL, '0.00'),
(201400, 'Deferred Tax Liabilities', 0, 20, 0, 0, '', NULL, '0.00'),
(201401, 'Salary Tax Payable', 201400, 20, 0, 0, '', NULL, '0.00'),
(201402, 'Withholding Tax Payable', 201400, 20, 0, 0, '', NULL, '0.00'),
(201403, 'VAT Payable', 201400, 20, 0, 0, '', NULL, '0.00'),
(201404, 'Profit Tax Payable', 201400, 20, 0, 0, '', NULL, '0.00'),
(201405, 'Prepayment Profit Tax Payable', 201400, 20, 0, 0, '', NULL, '0.00'),
(201406, 'Fringe Benefit Tax Payable', 201400, 20, 0, 0, '', NULL, '0.00'),
(201407, 'VAT Output', 201400, 20, 0, 0, '', NULL, '0.00'),
(300000, 'Capital Stock', 0, 30, 0, 0, '', NULL, '0.00'),
(300100, 'Paid-in Capital', 300000, 30, 0, 0, '', NULL, '0.00'),
(300101, 'Additional Paid-in Capital', 300000, 30, 0, 0, '', NULL, '0.00'),
(300200, 'Retained Earnings', 0, 30, 0, 0, '', NULL, '0.00'),
(300300, 'Opening Balance', 0, 30, 0, 0, '', NULL, '0.00'),
(400000, 'Sale Revenue', 0, 40, 0, 0, '', NULL, '0.00'),
(410101, 'Products', 400000, 40, 0, 0, '', NULL, '0.00'),
(410102, 'Sale Discount', 400000, 40, 0, 0, '', NULL, '0.00'),
(410107, 'Other Income', 400000, 40, 0, 0, '', NULL, '0.00'),
(500000, 'Cost of Goods Sold', 0, 50, 0, 0, '', NULL, '0.00'),
(500101, 'Cost Products', 500000, 50, 0, 0, '', NULL, '0.00'),
(500102, 'Freight Expense', 500000, 60, 0, 0, '', NULL, '0.00'),
(500103, 'Wages & Salaries', 500000, 60, 0, 0, '', NULL, '0.00'),
(500106, 'Purchase Discount', 500000, 50, 0, 0, '', NULL, '0.00'),
(500107, 'Inventory Adjustment', 500000, 50, 0, 0, '', NULL, '0.00'),
(500108, 'Cost of Variance', 500000, 50, 0, 0, '', NULL, '0.00'),
(600000, 'Expenses', 0, 60, 0, 0, '', NULL, '0.00'),
(601100, 'Staff Cost', 600000, 60, 0, 0, '', NULL, '0.00'),
(601101, 'Salary Expense', 601100, 60, 0, 0, '', NULL, '0.00'),
(601102, 'OT', 601100, 60, 0, 0, '', NULL, '0.00'),
(601103, 'Allowance ', 601100, 60, 0, 0, '', NULL, '0.00'),
(601104, 'Bonus', 601100, 60, 0, 0, '', NULL, '0.00'),
(601105, 'Commission', 601100, 60, 0, 0, '', NULL, '0.00'),
(601106, 'Training/Education', 601100, 60, 0, 0, '', NULL, '0.00'),
(601107, 'Compensation', 601100, 60, 0, 0, '', NULL, '0.00'),
(601108, 'Other Staff Relation', 601100, 60, 0, 0, '', NULL, '0.00'),
(601200, 'Administration Cost', 600000, 60, 0, 0, '', NULL, '0.00'),
(601201, 'Rental Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601202, 'Utilities', 601200, 60, 0, 0, '', NULL, '0.00'),
(601203, 'Marketing & Advertising', 601200, 60, 0, 0, '', NULL, '0.00'),
(601204, 'Repair & Maintenance', 601200, 60, 0, 0, '', NULL, '0.00'),
(601205, 'Customer Relation', 601200, 60, 0, 0, '', NULL, '0.00'),
(601206, 'Transportation', 601200, 60, 0, 0, '', NULL, '0.00'),
(601207, 'Communication', 601200, 60, 0, 0, '', NULL, '0.00'),
(601208, 'Insurance Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601209, 'Professional Fee', 601200, 60, 0, 0, '', NULL, '0.00'),
(601210, 'Depreciation Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601211, 'Amortization Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601212, 'Stationery', 601200, 60, 0, 0, '', NULL, '0.00'),
(601213, 'Office Supplies', 601200, 60, 0, 0, '', NULL, '0.00'),
(601214, 'Donation', 601200, 60, 0, 0, '', NULL, '0.00'),
(601215, 'Entertainment Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601216, 'Travelling & Accomodation', 601200, 60, 0, 0, '', NULL, '0.00'),
(601217, 'Service Computer Expenses', 601200, 60, 0, 0, '', NULL, '0.00'),
(601218, 'Interest Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601219, 'Bank Charge', 601200, 60, 0, 0, '', NULL, '0.00'),
(601220, 'Miscellaneous Expense', 601200, 60, 0, 0, '', NULL, '0.00'),
(601221, 'Canteen Supplies', 601200, 60, 0, 0, '', NULL, '0.00'),
(601222, 'Registration Expenses', 601200, 60, 0, 0, '', NULL, '0.00'),
(710300, 'Other Income', 0, 70, 0, 0, '', NULL, '0.00'),
(710301, 'Interest Income', 710300, 70, 0, 0, '', NULL, '0.00'),
(710302, 'Other Revenue & Gain', 710300, 70, 0, 0, '', NULL, '0.00'),
(801300, 'Other Expenses', 0, 80, 0, 0, '', NULL, '0.00'),
(801301, 'Other Expense & Loss', 801300, 80, 0, 0, '', NULL, '0.00'),
(801302, 'Bad Dept Expense', 801300, 80, 0, 0, '', NULL, '0.00'),
(801303, 'Tax & Duties Expense', 801300, 80, 0, 0, '', NULL, '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `erp_gl_sections`
--

CREATE TABLE IF NOT EXISTS `erp_gl_sections` (
  `sectionid` int(11) NOT NULL DEFAULT '0',
  `sectionname` text,
  `AccountType` char(2) DEFAULT NULL,
  `description` text,
  `pandl` int(11) DEFAULT '0',
  `order_stat` int(11) DEFAULT '0',
  `sectionname_kh` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_gl_sections`
--

INSERT INTO `erp_gl_sections` (`sectionid`, `sectionname`, `AccountType`, `description`, `pandl`, `order_stat`, `sectionname_kh`) VALUES
(10, 'CURRENT ASSETS', 'AS', 'CURRENT ASSETS', 0, 10, NULL),
(11, 'FIXED ASSETS', 'AS', 'FIXED ASSETS', 0, 11, NULL),
(20, 'CURRENT LIABILITIES', 'LI', 'CURRENT LIABILITIES', 0, 20, NULL),
(21, 'NON-CURRENT LIABILITIES', 'LI', 'NON-CURRENT LIABILITIES', 0, 21, NULL),
(30, 'EQUITY AND RETAINED EARNING', 'EQ', 'EQUITY AND RETAINED EARNING', 0, 30, NULL),
(40, 'INCOME', 'RE', 'INCOME', 1, 40, NULL),
(50, 'COST OF GOODS SOLD', 'CO', 'COST OF GOODS SOLD', 1, 50, NULL),
(60, 'OPERATING EXPENSES', 'EX', 'OPERATING EXPENSES', 1, 60, NULL),
(70, 'OTHER INCOME', 'OI', 'OTHER INCOME', 1, 70, NULL),
(80, 'OTHER EXPENSE', 'OX', 'OTHER EXPENSE', 1, 80, NULL),
(90, 'GAIN & LOSS', 'GL', 'GAIN & LOSS', 1, 90, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_gl_trans`
--

CREATE TABLE IF NOT EXISTS `erp_gl_trans` (
  `tran_id` int(11) NOT NULL,
  `tran_type` varchar(20) DEFAULT '0',
  `tran_no` bigint(20) NOT NULL DEFAULT '1',
  `tran_date` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `sectionid` int(11) DEFAULT '0',
  `account_code` int(19) DEFAULT '0',
  `narrative` varchar(100) DEFAULT '',
  `amount` decimal(25,2) DEFAULT '0.00',
  `reference_no` varchar(55) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `biller_id` int(11) DEFAULT '0',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `bank` tinyint(3) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_gl_trans`
--

INSERT INTO `erp_gl_trans` (`tran_id`, `tran_type`, `tran_no`, `tran_date`, `sectionid`, `account_code`, `narrative`, `amount`, `reference_no`, `description`, `biller_id`, `created_by`, `updated_by`, `bank`) VALUES
(1, 'SALES', 1, '2016-03-21 06:00:00', 40, 410101, 'Products', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(2, 'SALES', 1, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(3, 'SALES', 1, '2016-03-21 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(4, 'SALES', 1, '2016-03-21 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(5, 'SALES', 1, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '0.00', '1603-000003', 'KL-000003 (Cancelled)', NULL, 1, NULL, 1),
(6, 'SALES', 1, '2016-03-21 06:00:00', 10, 100102, 'Cash on Hand', '0.00', '1603-000003', 'KL-000003 (Cancelled)', NULL, 1, NULL, 1),
(7, 'SALES', 2, '2016-03-21 06:00:00', 40, 410101, 'Products', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(8, 'SALES', 2, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(9, 'SALES', 2, '2016-03-21 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(10, 'SALES', 2, '2016-03-21 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000003', 'KL-000003 (Cancelled)', 3, 1, NULL, 0),
(11, 'SALES', 2, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '0.00', '1603-000003', 'KL-000003 (Cancelled)', NULL, 1, NULL, 1),
(12, 'SALES', 2, '2016-03-21 06:00:00', 10, 100102, 'Cash on Hand', '0.00', '1603-000003', 'KL-000003 (Cancelled)', NULL, 1, NULL, 1),
(13, 'SALES', 3, '2016-03-21 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000004', 'KL-000004', 3, 1, NULL, 0),
(14, 'SALES', 3, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000004', 'KL-000004', 3, 1, NULL, 0),
(15, 'SALES', 3, '2016-03-21 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000004', 'KL-000004', 3, 1, NULL, 0),
(16, 'SALES', 3, '2016-03-21 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000004', 'KL-000004', 3, 1, NULL, 0),
(17, 'SALES', 3, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000004', 'KL-000004', NULL, 1, NULL, 1),
(18, 'SALES', 3, '2016-03-21 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000004', 'KL-000004', NULL, 1, NULL, 1),
(19, 'SALES', 4, '2016-03-21 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000005', 'KL-000005', 3, 1, NULL, 0),
(20, 'SALES', 4, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000005', 'KL-000005', 3, 1, NULL, 0),
(21, 'SALES', 4, '2016-03-21 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000005', 'KL-000005', 3, 1, NULL, 0),
(22, 'SALES', 4, '2016-03-21 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000005', 'KL-000005', 3, 1, NULL, 0),
(23, 'SALES', 4, '2016-03-21 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000005', 'KL-000005', NULL, 1, NULL, 1),
(24, 'SALES', 4, '2016-03-21 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000005', 'KL-000005', NULL, 1, NULL, 1),
(25, 'SALES', 5, '2016-03-22 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000006', 'KL-000006', 3, 1, NULL, 0),
(26, 'SALES', 5, '2016-03-22 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000006', 'KL-000006', 3, 1, NULL, 0),
(27, 'SALES', 5, '2016-03-22 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000006', 'KL-000006', 3, 1, NULL, 0),
(28, 'SALES', 5, '2016-03-22 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000006', 'KL-000006', 3, 1, NULL, 0),
(29, 'SALES', 5, '2016-03-22 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000006', 'KL-000006', NULL, 1, NULL, 1),
(30, 'SALES', 5, '2016-03-22 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000006', 'KL-000006', NULL, 1, NULL, 1),
(31, 'SALES', 6, '2016-03-23 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000007', 'KL-000007', 3, 1, NULL, 0),
(32, 'SALES', 6, '2016-03-23 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000007', 'KL-000007', 3, 1, NULL, 0),
(33, 'SALES', 6, '2016-03-23 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000007', 'KL-000007', 3, 1, NULL, 0),
(34, 'SALES', 6, '2016-03-23 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000007', 'KL-000007', 3, 1, NULL, 0),
(35, 'SALES', 6, '2016-03-23 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000007', 'KL-000007', NULL, 1, NULL, 1),
(36, 'SALES', 6, '2016-03-23 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000007', 'KL-000007', NULL, 1, NULL, 1),
(37, 'SALES', 7, '2016-03-23 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000008', 'KL-000008', 3, 1, NULL, 0),
(38, 'SALES', 7, '2016-03-23 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000008', 'KL-000008', 3, 1, NULL, 0),
(39, 'SALES', 7, '2016-03-23 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000008', 'KL-000008', 3, 1, NULL, 0),
(40, 'SALES', 7, '2016-03-23 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000008', 'KL-000008', 3, 1, NULL, 0),
(41, 'SALES', 7, '2016-03-23 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000008', 'KL-000008', NULL, 1, NULL, 1),
(42, 'SALES', 7, '2016-03-23 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000008', 'KL-000008', NULL, 1, NULL, 1),
(43, 'SALES', 8, '2016-03-23 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000009', 'KL-000009', 3, 1, NULL, 0),
(44, 'SALES', 8, '2016-03-23 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000009', 'KL-000009', 3, 1, NULL, 0),
(45, 'SALES', 8, '2016-03-23 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000009', 'KL-000009', 3, 1, NULL, 0),
(46, 'SALES', 8, '2016-03-23 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000009', 'KL-000009', 3, 1, NULL, 0),
(47, 'SALES', 8, '2016-03-23 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000009', 'KL-000009', NULL, 1, NULL, 1),
(48, 'SALES', 8, '2016-03-23 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000009', 'KL-000009', NULL, 1, NULL, 1),
(49, 'SALES', 9, '2016-03-24 06:00:00', 40, 410101, 'Products', '-300.00', '1603-000010', 'KL-000010', 3, 1, NULL, 0),
(50, 'SALES', 9, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1603-000010', 'KL-000010', 3, 1, NULL, 0),
(51, 'SALES', 9, '2016-03-24 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000010', 'KL-000010', 3, 1, NULL, 0),
(52, 'SALES', 9, '2016-03-24 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000010', 'KL-000010', 3, 1, NULL, 0),
(53, 'SALES', 9, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1603-000010', 'KL-000010', NULL, 1, NULL, 1),
(54, 'SALES', 9, '2016-03-24 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1603-000010', 'KL-000010', NULL, 1, NULL, 1),
(55, 'SALES', 10, '2016-03-24 06:00:00', 40, 410101, 'Products', '-70.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(56, 'SALES', 10, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(57, 'SALES', 10, '2016-03-24 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(58, 'SALES', 10, '2016-03-24 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(59, 'SALES', 10, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000011', 'KL-000011', NULL, 1, NULL, 1),
(60, 'SALES', 10, '2016-03-24 06:00:00', 10, 100102, 'Cash on Hand', '70.00', '1603-000011', 'KL-000011', NULL, 1, NULL, 1),
(61, 'SALES', 11, '2016-03-24 06:00:00', 40, 410101, 'Products', '-70.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(62, 'SALES', 11, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(63, 'SALES', 11, '2016-03-24 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(64, 'SALES', 11, '2016-03-24 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(65, 'SALES', 11, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000012', 'KL-000012', NULL, 1, NULL, 1),
(66, 'SALES', 11, '2016-03-24 06:00:00', 10, 100102, 'Cash on Hand', '70.00', '1603-000012', 'KL-000012', NULL, 1, NULL, 1),
(67, 'SALES', 12, '2016-03-28 06:00:00', 40, 410101, 'Products', '-70.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(68, 'SALES', 12, '2016-03-28 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(69, 'SALES', 12, '2016-03-28 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(70, 'SALES', 12, '2016-03-28 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(71, 'SALES', 12, '2016-03-28 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000013', 'KL-000014', NULL, 1, NULL, 1),
(72, 'SALES', 12, '2016-03-28 06:00:00', 10, 100102, 'Cash on Hand', '70.00', '1603-000013', 'KL-000014', NULL, 1, NULL, 1),
(73, 'SALES', 13, '2016-03-31 06:00:00', 40, 410101, 'Products', '-1700.00', '1603-000014', 'KL-000011', 3, 1, NULL, 0),
(74, 'SALES', 13, '2016-03-31 06:00:00', 10, 100200, 'Account Receivable', '1050.00', '1603-000014', 'KL-000011', 3, 1, NULL, 0),
(75, 'SALES', 13, '2016-03-31 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000014', 'KL-000011', 3, 1, NULL, 0),
(76, 'SALES', 13, '2016-03-31 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000014', 'KL-000011', 3, 1, NULL, 0),
(77, 'SALES', 13, '2016-03-31 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1603-000014', 'KL-000011', 3, 1, NULL, 0),
(78, 'SALES', 13, '2016-03-31 06:00:00', 10, 100200, 'Account Receivable', '-1050.00', '1603-000014', 'KL-000011', NULL, 1, NULL, 1),
(79, 'SALES', 13, '2016-03-31 06:00:00', 10, 100102, 'Cash on Hand', '1050.00', '1603-000014', 'KL-000011', NULL, 1, NULL, 1),
(80, 'SALES', 14, '2016-03-31 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000012', 'KL-000012', 3, 1, NULL, 1),
(81, 'SALES', 14, '2016-03-31 06:00:00', 10, 100102, 'Cash on Hand', '-70.00', '1603-000012', 'KL-000012', 3, 1, NULL, 1),
(82, 'SALES', 14, '2016-03-24 06:00:00', 40, 410101, 'Products', '70.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(83, 'SALES', 14, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(84, 'SALES', 14, '2016-03-24 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(85, 'SALES', 14, '2016-03-24 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000012', 'KL-000012', 3, 1, NULL, 0),
(86, 'SALES', 15, '2016-03-31 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000011', 'KL-000011', 3, 1, NULL, 1),
(87, 'SALES', 15, '2016-03-31 06:00:00', 10, 100102, 'Cash on Hand', '-70.00', '1603-000011', 'KL-000011', 3, 1, NULL, 1),
(88, 'SALES', 15, '2016-03-24 06:00:00', 40, 410101, 'Products', '70.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(89, 'SALES', 15, '2016-03-24 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(90, 'SALES', 15, '2016-03-24 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(91, 'SALES', 15, '2016-03-24 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000011', 'KL-000011', 3, 1, NULL, 0),
(92, 'SALES', 16, '2016-03-31 06:00:00', 40, 410101, 'Products', '-1700.00', '1603-000015', 'KL-000012', 3, 1, NULL, 0),
(93, 'SALES', 16, '2016-03-31 06:00:00', 10, 100200, 'Account Receivable', '1050.00', '1603-000015', 'KL-000012', 3, 1, NULL, 0),
(94, 'SALES', 16, '2016-03-31 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000015', 'KL-000012', 3, 1, NULL, 0),
(95, 'SALES', 16, '2016-03-31 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000015', 'KL-000012', 3, 1, NULL, 0),
(96, 'SALES', 16, '2016-03-31 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1603-000015', 'KL-000012', 3, 1, NULL, 0),
(97, 'SALES', 16, '2016-03-31 06:00:00', 10, 100200, 'Account Receivable', '-1050.00', '1603-000015', 'KL-000012', NULL, 1, NULL, 1),
(98, 'SALES', 16, '2016-03-31 06:00:00', 10, 100102, 'Cash on Hand', '1050.00', '1603-000015', 'KL-000012', NULL, 1, NULL, 1),
(99, 'SALES', 17, '2016-04-01 06:00:00', 40, 410101, 'Products', '-2402.00', '1604-000016', 'KL-000013', 3, 1, NULL, 0),
(100, 'SALES', 17, '2016-04-01 06:00:00', 10, 100200, 'Account Receivable', '2400.00', '1604-000016', 'KL-000013', 3, 1, NULL, 0),
(101, 'SALES', 17, '2016-04-01 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000016', 'KL-000013', 3, 1, NULL, 0),
(102, 'SALES', 17, '2016-04-01 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000016', 'KL-000013', 3, 1, NULL, 0),
(103, 'SALES', 17, '2016-04-01 06:00:00', 40, 410102, 'Sale Discount', '2.00', '1604-000016', 'KL-000013', 3, 1, NULL, 0),
(104, 'SALES', 17, '2016-04-01 06:00:00', 10, 100200, 'Account Receivable', '-1000.00', '1604-000016', 'KL-000013', NULL, 1, NULL, 1),
(105, 'SALES', 17, '2016-04-01 06:00:00', 10, 100102, 'Cash on Hand', '1000.00', '1604-000016', 'KL-000013', NULL, 1, NULL, 1),
(106, 'SALES', 18, '2016-04-01 06:00:00', 40, 410101, 'Products', '-200.00', '1604-000017', 'KL-000014', 3, 1, NULL, 0),
(107, 'SALES', 18, '2016-04-01 06:00:00', 10, 100200, 'Account Receivable', '200.00', '1604-000017', 'KL-000014', 3, 1, NULL, 0),
(108, 'SALES', 18, '2016-04-01 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000017', 'KL-000014', 3, 1, NULL, 0),
(109, 'SALES', 18, '2016-04-01 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000017', 'KL-000014', 3, 1, NULL, 0),
(110, 'SALES', 18, '2016-04-01 06:00:00', 10, 100200, 'Account Receivable', '-200.00', '1604-000017', 'KL-000014', NULL, 1, NULL, 1),
(111, 'SALES', 18, '2016-04-01 06:00:00', 10, 100102, 'Cash on Hand', '200.00', '1604-000017', 'KL-000014', NULL, 1, NULL, 1),
(112, 'SALES', 19, '2016-04-04 06:00:00', 40, 410101, 'Products', '-1865.00', '1604-000018', 'KL-000015', 3, 1, NULL, 0),
(113, 'SALES', 19, '2016-04-04 06:00:00', 10, 100200, 'Account Receivable', '1215.00', '1604-000018', 'KL-000015', 3, 1, NULL, 0),
(114, 'SALES', 19, '2016-04-04 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000018', 'KL-000015', 3, 1, NULL, 0),
(115, 'SALES', 19, '2016-04-04 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000018', 'KL-000015', 3, 1, NULL, 0),
(116, 'SALES', 19, '2016-04-04 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1604-000018', 'KL-000015', 3, 1, NULL, 0),
(117, 'SALES', 19, '2016-04-04 06:00:00', 10, 100200, 'Account Receivable', '-700.00', '1604-000018', 'KL-000015', NULL, 1, NULL, 1),
(118, 'SALES', 19, '2016-04-04 06:00:00', 10, 100102, 'Cash on Hand', '700.00', '1604-000018', 'KL-000015', NULL, 1, NULL, 1),
(119, 'SALES', 20, '2016-06-30 19:25:00', 10, 100200, 'Account Receivable', '-515.00', '1604-000018', 'KL-000015', 3, 1, NULL, 1),
(120, 'SALES', 20, '2016-06-30 19:25:00', 10, 100102, 'Cash on Hand', '515.00', '1604-000018', 'KL-000015', 3, 1, NULL, 1),
(121, 'SALES', 21, '2016-04-05 06:00:00', 40, 410101, 'Products', '-300.00', '1604-000020', 'KL-000016', 3, 1, NULL, 0),
(122, 'SALES', 21, '2016-04-05 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1604-000020', 'KL-000016', 3, 1, NULL, 0),
(123, 'SALES', 21, '2016-04-05 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000020', 'KL-000016', 3, 1, NULL, 0),
(124, 'SALES', 21, '2016-04-05 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000020', 'KL-000016', 3, 1, NULL, 0),
(125, 'SALES', 21, '2016-04-05 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1604-000020', 'KL-000016', NULL, 1, NULL, 1),
(126, 'SALES', 21, '2016-04-05 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1604-000020', 'KL-000016', NULL, 1, NULL, 1),
(127, 'SALES', 22, '2016-04-05 06:00:00', 40, 410101, 'Products', '-150.00', '1604-000021', 'KL-000011', 3, 1, NULL, 0),
(128, 'SALES', 22, '2016-04-05 06:00:00', 10, 100200, 'Account Receivable', '150.00', '1604-000021', 'KL-000011', 3, 1, NULL, 0),
(129, 'SALES', 22, '2016-04-05 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000021', 'KL-000011', 3, 1, NULL, 0),
(130, 'SALES', 22, '2016-04-05 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000021', 'KL-000011', 3, 1, NULL, 0),
(131, 'SALES', 22, '2016-04-05 06:00:00', 10, 100200, 'Account Receivable', '-150.00', '1604-000021', 'KL-000011', NULL, 1, NULL, 1),
(132, 'SALES', 22, '2016-04-05 06:00:00', 10, 100102, 'Cash on Hand', '150.00', '1604-000021', 'KL-000011', NULL, 1, NULL, 1),
(133, 'SALES', 23, '2016-04-05 06:00:00', 40, 410101, 'Products', '-150.00', '1604-000022', 'KL-000012', 3, 1, NULL, 0),
(134, 'SALES', 23, '2016-04-05 06:00:00', 10, 100200, 'Account Receivable', '150.00', '1604-000022', 'KL-000012', 3, 1, NULL, 0),
(135, 'SALES', 23, '2016-04-05 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000022', 'KL-000012', 3, 1, NULL, 0),
(136, 'SALES', 23, '2016-04-05 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000022', 'KL-000012', 3, 1, NULL, 0),
(137, 'SALES', 23, '2016-04-05 06:00:00', 10, 100200, 'Account Receivable', '-150.00', '1604-000022', 'KL-000012', NULL, 1, NULL, 1),
(138, 'SALES', 23, '2016-04-05 06:00:00', 10, 100102, 'Cash on Hand', '150.00', '1604-000022', 'KL-000012', NULL, 1, NULL, 1),
(139, 'SALES', 24, '2016-04-06 06:00:00', 40, 410101, 'Products', '-1600.00', '1604-000023', 'KL-000017', 3, 1, NULL, 0),
(140, 'SALES', 24, '2016-04-06 06:00:00', 10, 100200, 'Account Receivable', '950.00', '1604-000023', 'KL-000017', 3, 1, NULL, 0),
(141, 'SALES', 24, '2016-04-06 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000023', 'KL-000017', 3, 1, NULL, 0),
(142, 'SALES', 24, '2016-04-06 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000023', 'KL-000017', 3, 1, NULL, 0),
(143, 'SALES', 24, '2016-04-06 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1604-000023', 'KL-000017', 3, 1, NULL, 0),
(144, 'SALES', 24, '2016-04-06 06:00:00', 10, 100200, 'Account Receivable', '-950.00', '1604-000023', 'KL-000017', NULL, 1, NULL, 1),
(145, 'SALES', 24, '2016-04-06 06:00:00', 10, 100102, 'Cash on Hand', '950.00', '1604-000023', 'KL-000017', NULL, 1, NULL, 1),
(146, 'SALES', 25, '2016-04-06 06:00:00', 40, 410101, 'Products', '-1050.00', '1604-000024', 'KL-000018', 3, 1, NULL, 0),
(147, 'SALES', 25, '2016-04-06 06:00:00', 10, 100200, 'Account Receivable', '825.00', '1604-000024', 'KL-000018', 3, 1, NULL, 0),
(148, 'SALES', 25, '2016-04-06 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000024', 'KL-000018', 3, 1, NULL, 0),
(149, 'SALES', 25, '2016-04-06 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000024', 'KL-000018', 3, 1, NULL, 0),
(150, 'SALES', 25, '2016-04-06 06:00:00', 40, 410102, 'Sale Discount', '225.00', '1604-000024', 'KL-000018', 3, 1, NULL, 0),
(151, 'SALES', 25, '2016-04-06 06:00:00', 10, 100200, 'Account Receivable', '-825.00', '1604-000024', 'KL-000018', NULL, 1, NULL, 1),
(152, 'SALES', 25, '2016-04-06 06:00:00', 10, 100102, 'Cash on Hand', '825.00', '1604-000024', 'KL-000018', NULL, 1, NULL, 1),
(153, 'SALES', 26, '2016-04-18 06:00:00', 40, 410101, 'Products', '-1500.00', '1604-000026', 'KL-000014', 3, 1, NULL, 0),
(154, 'SALES', 26, '2016-04-18 06:00:00', 10, 100200, 'Account Receivable', '850.00', '1604-000026', 'KL-000014', 3, 1, NULL, 0),
(155, 'SALES', 26, '2016-04-18 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000026', 'KL-000014', 3, 1, NULL, 0),
(156, 'SALES', 26, '2016-04-18 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000026', 'KL-000014', 3, 1, NULL, 0),
(157, 'SALES', 26, '2016-04-18 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1604-000026', 'KL-000014', 3, 1, NULL, 0),
(158, 'SALES', 26, '2016-04-18 06:00:00', 10, 100200, 'Account Receivable', '-850.00', '1604-000026', 'KL-000014', NULL, 1, NULL, 1),
(159, 'SALES', 26, '2016-04-18 06:00:00', 10, 100102, 'Cash on Hand', '850.00', '1604-000026', 'KL-000014', NULL, 1, NULL, 1),
(160, 'SALES', 27, '2016-04-18 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000013', 'KL-000014', 3, 1, NULL, 1),
(161, 'SALES', 27, '2016-04-18 06:00:00', 10, 100102, 'Cash on Hand', '-70.00', '1603-000013', 'KL-000014', 3, 1, NULL, 1),
(162, 'SALES', 27, '2016-03-28 06:00:00', 40, 410101, 'Products', '70.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(163, 'SALES', 27, '2016-03-28 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(164, 'SALES', 27, '2016-03-28 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(165, 'SALES', 27, '2016-03-28 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000013', 'KL-000014', 3, 1, NULL, 0),
(166, 'SALES', 28, '2016-04-19 06:00:00', 40, 410101, 'Products', '-1009.00', '1604-000027', 'KL-000020', 3, 1, NULL, 0),
(167, 'SALES', 28, '2016-04-19 06:00:00', 10, 100200, 'Account Receivable', '1009.00', '1604-000027', 'KL-000020', 3, 1, NULL, 0),
(168, 'SALES', 28, '2016-04-19 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000027', 'KL-000020', 3, 1, NULL, 0),
(169, 'SALES', 28, '2016-04-19 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000027', 'KL-000020', 3, 1, NULL, 0),
(170, 'SALES', 28, '2016-04-19 06:00:00', 10, 100200, 'Account Receivable', '-1009.00', '1604-000027', 'KL-000020', NULL, 1, NULL, 1),
(171, 'SALES', 28, '2016-04-19 06:00:00', 10, 100102, 'Cash on Hand', '1009.00', '1604-000027', 'KL-000020', NULL, 1, NULL, 1),
(172, 'SALES', 29, '2016-04-20 06:00:00', 40, 410101, 'Products', '-750.00', '1604-000028', 'KL-000009', 3, 1, NULL, 0),
(173, 'SALES', 29, '2016-04-20 06:00:00', 10, 100200, 'Account Receivable', '525.00', '1604-000028', 'KL-000009', 3, 1, NULL, 0),
(174, 'SALES', 29, '2016-04-20 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000028', 'KL-000009', 3, 1, NULL, 0),
(175, 'SALES', 29, '2016-04-20 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000028', 'KL-000009', 3, 1, NULL, 0),
(176, 'SALES', 29, '2016-04-20 06:00:00', 40, 410102, 'Sale Discount', '225.00', '1604-000028', 'KL-000009', 3, 1, NULL, 0),
(177, 'SALES', 29, '2016-04-20 06:00:00', 10, 100200, 'Account Receivable', '-525.00', '1604-000028', 'KL-000009', NULL, 1, NULL, 1),
(178, 'SALES', 29, '2016-04-20 06:00:00', 10, 100102, 'Cash on Hand', '525.00', '1604-000028', 'KL-000009', NULL, 1, NULL, 1),
(179, 'SALES', 30, '2016-04-25 06:00:00', 40, 410101, 'Products', '-1300.00', '1604-000029', 'KL-000016', 3, 1, NULL, 0),
(180, 'SALES', 30, '2016-04-25 06:00:00', 10, 100200, 'Account Receivable', '650.00', '1604-000029', 'KL-000016', 3, 1, NULL, 0),
(181, 'SALES', 30, '2016-04-25 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000029', 'KL-000016', 3, 1, NULL, 0),
(182, 'SALES', 30, '2016-04-25 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000029', 'KL-000016', 3, 1, NULL, 0),
(183, 'SALES', 30, '2016-04-25 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1604-000029', 'KL-000016', 3, 1, NULL, 0),
(184, 'SALES', 30, '2016-04-25 06:00:00', 10, 100200, 'Account Receivable', '-650.00', '1604-000029', 'KL-000016', NULL, 1, NULL, 1),
(185, 'SALES', 30, '2016-04-25 06:00:00', 10, 100102, 'Cash on Hand', '650.00', '1604-000029', 'KL-000016', NULL, 1, NULL, 1),
(186, 'SALES', 31, '2016-04-27 06:00:00', 40, 410101, 'Products', '-300.00', '1604-000031', 'KL-000021', 3, 1, NULL, 0),
(187, 'SALES', 31, '2016-04-27 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1604-000031', 'KL-000021', 3, 1, NULL, 0),
(188, 'SALES', 31, '2016-04-27 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000031', 'KL-000021', 3, 1, NULL, 0),
(189, 'SALES', 31, '2016-04-27 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000031', 'KL-000021', 3, 1, NULL, 0),
(190, 'SALES', 31, '2016-04-27 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1604-000031', 'KL-000021', NULL, 1, NULL, 1),
(191, 'SALES', 31, '2016-04-27 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1604-000031', 'KL-000021', NULL, 1, NULL, 1),
(192, 'SALES', 32, '2016-04-28 06:00:00', 40, 410101, 'Products', '-1600.00', '1604-000032', 'KL-000022', 3, 1, NULL, 0),
(193, 'SALES', 32, '2016-04-28 06:00:00', 10, 100200, 'Account Receivable', '950.00', '1604-000032', 'KL-000022', 3, 1, NULL, 0),
(194, 'SALES', 32, '2016-04-28 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000032', 'KL-000022', 3, 1, NULL, 0),
(195, 'SALES', 32, '2016-04-28 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000032', 'KL-000022', 3, 1, NULL, 0),
(196, 'SALES', 32, '2016-04-28 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1604-000032', 'KL-000022', 3, 1, NULL, 0),
(197, 'SALES', 32, '2016-04-28 06:00:00', 10, 100200, 'Account Receivable', '-950.00', '1604-000032', 'KL-000022', NULL, 1, NULL, 1),
(198, 'SALES', 32, '2016-04-28 06:00:00', 10, 100102, 'Cash on Hand', '950.00', '1604-000032', 'KL-000022', NULL, 1, NULL, 1),
(199, 'SALES', 33, '2016-04-26 06:00:00', 40, 410101, 'Products', '-70.00', '1603-000030', 'KL-000025', 3, 1, NULL, 0),
(200, 'SALES', 33, '2016-04-26 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1603-000030', 'KL-000025', 3, 1, NULL, 0),
(201, 'SALES', 33, '2016-04-26 06:00:00', 50, 500101, 'Cost Products', '0.00', '1603-000030', 'KL-000025', 3, 1, NULL, 0),
(202, 'SALES', 33, '2016-04-26 06:00:00', 10, 100430, 'Inventory', '0.00', '1603-000030', 'KL-000025', 3, 1, NULL, 0),
(203, 'SALES', 33, '2016-04-26 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1603-000030', 'KL-000025', NULL, 1, NULL, 1),
(204, 'SALES', 33, '2016-04-26 06:00:00', 10, 100102, 'Cash on Hand', '70.00', '1603-000030', 'KL-000025', NULL, 1, NULL, 1),
(205, 'SALES', 34, '2016-04-11 06:00:00', 40, 410101, 'Products', '-300.00', '1604-000025', 'KL-000019', 3, 1, NULL, 0),
(206, 'SALES', 34, '2016-04-11 06:00:00', 10, 100200, 'Account Receivable', '300.00', '1604-000025', 'KL-000019', 3, 1, NULL, 0),
(207, 'SALES', 34, '2016-04-11 06:00:00', 50, 500101, 'Cost Products', '0.00', '1604-000025', 'KL-000019', 3, 1, NULL, 0),
(208, 'SALES', 34, '2016-04-11 06:00:00', 10, 100430, 'Inventory', '0.00', '1604-000025', 'KL-000019', 3, 1, NULL, 0),
(209, 'SALES', 34, '2016-04-11 06:00:00', 10, 100200, 'Account Receivable', '-300.00', '1604-000025', 'KL-000019', NULL, 1, NULL, 1),
(210, 'SALES', 34, '2016-04-11 06:00:00', 10, 100102, 'Cash on Hand', '300.00', '1604-000025', 'KL-000019', NULL, 1, NULL, 1),
(211, 'SALES', 35, '0000-00-00 00:00:00', 40, 410101, 'Products', '0.00', '1605-000033', 'KL-000023 (Cancelled)', 3, 1, NULL, 0),
(212, 'SALES', 35, '0000-00-00 00:00:00', 10, 100200, 'Account Receivable', '0.00', '1605-000033', 'KL-000023 (Cancelled)', 3, 1, NULL, 0),
(213, 'SALES', 35, '0000-00-00 00:00:00', 50, 500101, 'Cost Products', '0.00', '1605-000033', 'KL-000023 (Cancelled)', 3, 1, NULL, 0),
(214, 'SALES', 35, '0000-00-00 00:00:00', 10, 100430, 'Inventory', '0.00', '1605-000033', 'KL-000023 (Cancelled)', 3, 1, NULL, 0),
(215, 'SALES', 35, '0000-00-00 00:00:00', 40, 410102, 'Sale Discount', '0.00', '1605-000033', 'KL-000023 (Cancelled)', 3, 1, NULL, 0),
(216, 'SALES', 35, '0000-00-00 00:00:00', 10, 100200, 'Account Receivable', '0.00', '1605-000033', 'KL-000023 (Cancelled)', NULL, 1, NULL, 1),
(217, 'SALES', 35, '0000-00-00 00:00:00', 10, 100102, 'Cash on Hand', '0.00', '1605-000033', 'KL-000023 (Cancelled)', NULL, 1, NULL, 1),
(218, 'SALES', 36, '2016-05-16 06:00:00', 10, 100200, 'Account Receivable', '-1400.00', '1604-000016', 'KL-000013', 3, 1, NULL, 1),
(219, 'SALES', 36, '2016-05-16 06:00:00', 10, 100102, 'Cash on Hand', '1400.00', '1604-000016', 'KL-000013', 3, 1, NULL, 1),
(220, 'SALES', 37, '2016-05-26 06:00:00', 40, 410101, 'Products', '-30.00', '1605-000035', 'KL-000020', 3, 1, NULL, 0),
(221, 'SALES', 37, '2016-05-26 06:00:00', 10, 100200, 'Account Receivable', '30.00', '1605-000035', 'KL-000020', 3, 1, NULL, 0),
(222, 'SALES', 37, '2016-05-26 06:00:00', 50, 500101, 'Cost Products', '0.00', '1605-000035', 'KL-000020', 3, 1, NULL, 0),
(223, 'SALES', 37, '2016-05-26 06:00:00', 10, 100430, 'Inventory', '0.00', '1605-000035', 'KL-000020', 3, 1, NULL, 0),
(224, 'SALES', 37, '2016-05-26 06:00:00', 10, 100200, 'Account Receivable', '-30.00', '1605-000035', 'KL-000020', NULL, 1, NULL, 1),
(225, 'SALES', 37, '2016-05-26 06:00:00', 10, 100102, 'Cash on Hand', '30.00', '1605-000035', 'KL-000020', NULL, 1, NULL, 1),
(226, 'SALES', 38, '2016-06-02 06:00:00', 40, 410101, 'Products', '-30.00', '1606-000036', 'KL-000020', 3, 1, NULL, 0),
(227, 'SALES', 38, '2016-06-02 06:00:00', 10, 100200, 'Account Receivable', '30.00', '1606-000036', 'KL-000020', 3, 1, NULL, 0),
(228, 'SALES', 38, '2016-06-02 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000036', 'KL-000020', 3, 1, NULL, 0),
(229, 'SALES', 38, '2016-06-02 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000036', 'KL-000020', 3, 1, NULL, 0),
(230, 'SALES', 38, '2016-06-02 06:00:00', 10, 100200, 'Account Receivable', '-30.00', '1606-000036', 'KL-000020', NULL, 1, NULL, 1),
(231, 'SALES', 38, '2016-06-02 06:00:00', 10, 100102, 'Cash on Hand', '30.00', '1606-000036', 'KL-000020', NULL, 1, NULL, 1),
(232, 'SALES', 39, '2016-06-03 06:00:00', 40, 410101, 'Products', '-15.00', '1606-000037', 'KL-000011', 3, 1, NULL, 0),
(233, 'SALES', 39, '2016-06-03 06:00:00', 10, 100200, 'Account Receivable', '15.00', '1606-000037', 'KL-000011', 3, 1, NULL, 0),
(234, 'SALES', 39, '2016-06-03 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000037', 'KL-000011', 3, 1, NULL, 0),
(235, 'SALES', 39, '2016-06-03 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000037', 'KL-000011', 3, 1, NULL, 0),
(236, 'SALES', 39, '2016-06-03 06:00:00', 10, 100200, 'Account Receivable', '-15.00', '1606-000037', 'KL-000011', NULL, 1, NULL, 1),
(237, 'SALES', 39, '2016-06-03 06:00:00', 10, 100102, 'Cash on Hand', '15.00', '1606-000037', 'KL-000011', NULL, 1, NULL, 1),
(238, 'SALES', 40, '2016-06-03 06:00:00', 40, 410101, 'Products', '-15.00', '1606-000038', 'KL-000012', 3, 1, NULL, 0),
(239, 'SALES', 40, '2016-06-03 06:00:00', 10, 100200, 'Account Receivable', '15.00', '1606-000038', 'KL-000012', 3, 1, NULL, 0),
(240, 'SALES', 40, '2016-06-03 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000038', 'KL-000012', 3, 1, NULL, 0),
(241, 'SALES', 40, '2016-06-03 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000038', 'KL-000012', 3, 1, NULL, 0),
(242, 'SALES', 40, '2016-06-03 06:00:00', 10, 100200, 'Account Receivable', '-15.00', '1606-000038', 'KL-000012', NULL, 1, NULL, 1),
(243, 'SALES', 40, '2016-06-03 06:00:00', 10, 100102, 'Cash on Hand', '15.00', '1606-000038', 'KL-000012', NULL, 1, NULL, 1),
(244, 'SALES', 41, '2016-06-06 06:00:00', 40, 410101, 'Products', '-70.00', '1606-000039', 'KL-000026', 3, 1, NULL, 0),
(245, 'SALES', 41, '2016-06-06 06:00:00', 10, 100200, 'Account Receivable', '70.00', '1606-000039', 'KL-000026', 3, 1, NULL, 0),
(246, 'SALES', 41, '2016-06-06 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000039', 'KL-000026', 3, 1, NULL, 0),
(247, 'SALES', 41, '2016-06-06 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000039', 'KL-000026', 3, 1, NULL, 0),
(248, 'SALES', 41, '2016-06-06 06:00:00', 10, 100200, 'Account Receivable', '-70.00', '1606-000039', 'KL-000026', NULL, 1, NULL, 1),
(249, 'SALES', 41, '2016-06-06 06:00:00', 10, 100102, 'Cash on Hand', '70.00', '1606-000039', 'KL-000026', NULL, 1, NULL, 1),
(250, 'SALES', 42, '2016-06-17 06:00:00', 40, 410101, 'Products', '-80.00', '1606-000040', 'KL-000018', 3, 1, NULL, 0),
(251, 'SALES', 42, '2016-06-17 06:00:00', 10, 100200, 'Account Receivable', '80.00', '1606-000040', 'KL-000018', 3, 1, NULL, 0),
(252, 'SALES', 42, '2016-06-17 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000040', 'KL-000018', 3, 1, NULL, 0),
(253, 'SALES', 42, '2016-06-17 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000040', 'KL-000018', 3, 1, NULL, 0),
(254, 'SALES', 42, '2016-06-17 06:00:00', 10, 100200, 'Account Receivable', '-80.00', '1606-000040', 'KL-000018', NULL, 1, NULL, 1),
(255, 'SALES', 42, '2016-06-17 06:00:00', 10, 100102, 'Cash on Hand', '80.00', '1606-000040', 'KL-000018', NULL, 1, NULL, 1),
(256, 'SALES', 43, '2016-06-17 06:00:00', 40, 410101, 'Products', '0.00', '1606-000041', 'KL-000027 (Cancelled)', 3, 1, NULL, 0),
(257, 'SALES', 43, '2016-06-17 06:00:00', 10, 100200, 'Account Receivable', '0.00', '1606-000041', 'KL-000027 (Cancelled)', 3, 1, NULL, 0),
(258, 'SALES', 43, '2016-06-17 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000041', 'KL-000027 (Cancelled)', 3, 1, NULL, 0),
(259, 'SALES', 43, '2016-06-17 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000041', 'KL-000027 (Cancelled)', 3, 1, NULL, 0),
(260, 'SALES', 43, '2016-06-17 06:00:00', 40, 410102, 'Sale Discount', '0.00', '1606-000041', 'KL-000027 (Cancelled)', 3, 1, NULL, 0),
(261, 'SALES', 43, '2016-06-17 06:00:00', 10, 100200, 'Account Receivable', '0.00', '1606-000041', 'KL-000027 (Cancelled)', NULL, 1, NULL, 1),
(262, 'SALES', 43, '2016-06-17 06:00:00', 10, 100102, 'Cash on Hand', '0.00', '1606-000041', 'KL-000027 (Cancelled)', NULL, 1, NULL, 1),
(263, 'SALES', 44, '2016-06-22 06:00:00', 40, 410101, 'Products', '-1710.00', '1606-000042', 'KL-000019', 3, 1, NULL, 0),
(264, 'SALES', 44, '2016-06-22 06:00:00', 10, 100200, 'Account Receivable', '1060.00', '1606-000042', 'KL-000019', 3, 1, NULL, 0),
(265, 'SALES', 44, '2016-06-22 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000042', 'KL-000019', 3, 1, NULL, 0),
(266, 'SALES', 44, '2016-06-22 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000042', 'KL-000019', 3, 1, NULL, 0),
(267, 'SALES', 44, '2016-06-22 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1606-000042', 'KL-000019', 3, 1, NULL, 0),
(268, 'SALES', 44, '2016-06-22 06:00:00', 10, 100200, 'Account Receivable', '-1060.00', '1606-000042', 'KL-000019', NULL, 1, NULL, 1),
(269, 'SALES', 44, '2016-06-22 06:00:00', 10, 100102, 'Cash on Hand', '1060.00', '1606-000042', 'KL-000019', NULL, 1, NULL, 1),
(270, 'SALES', 45, '2016-06-17 06:00:00', 40, 410101, 'Products', '-1815.00', '1606-000041', 'KL-000024', 3, 1, NULL, 0),
(271, 'SALES', 45, '2016-06-17 06:00:00', 10, 100200, 'Account Receivable', '1395.00', '1606-000041', 'KL-000024', 3, 1, NULL, 0),
(272, 'SALES', 45, '2016-06-17 06:00:00', 50, 500101, 'Cost Products', '0.00', '1606-000041', 'KL-000024', 3, 1, NULL, 0),
(273, 'SALES', 45, '2016-06-17 06:00:00', 10, 100430, 'Inventory', '0.00', '1606-000041', 'KL-000024', 3, 1, NULL, 0),
(274, 'SALES', 45, '2016-06-17 06:00:00', 40, 410102, 'Sale Discount', '420.00', '1606-000041', 'KL-000024', 3, 1, NULL, 0),
(275, 'SALES', 45, '2016-06-17 06:00:00', 10, 100200, 'Account Receivable', '-1395.00', '1606-000041', 'KL-000024', NULL, 1, NULL, 1),
(276, 'SALES', 45, '2016-06-17 06:00:00', 10, 100102, 'Cash on Hand', '1395.00', '1606-000041', 'KL-000024', NULL, 1, NULL, 1),
(277, 'SALES', 46, '2016-05-07 06:00:00', 40, 410101, 'Products', '-1600.00', '1605-000033', 'KL-000023', 3, 1, NULL, 0),
(278, 'SALES', 46, '2016-05-07 06:00:00', 10, 100200, 'Account Receivable', '950.00', '1605-000033', 'KL-000023', 3, 1, NULL, 0),
(279, 'SALES', 46, '2016-05-07 06:00:00', 50, 500101, 'Cost Products', '0.00', '1605-000033', 'KL-000023', 3, 1, NULL, 0),
(280, 'SALES', 46, '2016-05-07 06:00:00', 10, 100430, 'Inventory', '0.00', '1605-000033', 'KL-000023', 3, 1, NULL, 0),
(281, 'SALES', 46, '2016-05-07 06:00:00', 40, 410102, 'Sale Discount', '650.00', '1605-000033', 'KL-000023', 3, 1, NULL, 0),
(282, 'SALES', 46, '2016-05-07 06:00:00', 10, 100200, 'Account Receivable', '-950.00', '1605-000033', 'KL-000023', NULL, 1, NULL, 1),
(283, 'SALES', 46, '2016-05-07 06:00:00', 10, 100102, 'Cash on Hand', '950.00', '1605-000033', 'KL-000023', NULL, 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `erp_groups`
--

CREATE TABLE IF NOT EXISTS `erp_groups` (
  `id` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_groups`
--

INSERT INTO `erp_groups` (`id`, `name`, `description`) VALUES
(1, 'owner', 'Owner'),
(2, 'admin', 'Administrator'),
(3, 'customer', 'Customer'),
(4, 'supplier', 'Supplier'),
(5, 'sales', 'Saller'),
(6, 'stock', 'Stock Manager'),
(7, 'manager', 'Manager'),
(10, 'visitor', 'Visitor'),
(11, 'cashier', 'Cashier');

-- --------------------------------------------------------

--
-- Table structure for table `erp_loans`
--

CREATE TABLE IF NOT EXISTS `erp_loans` (
  `id` int(11) NOT NULL,
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
  `updated_by` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `erp_loans`
--
DELIMITER $$
CREATE TRIGGER `gl_trans_loan_delete` AFTER DELETE ON `erp_loans`
 FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference_no;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `erp_login_attempts`
--

CREATE TABLE IF NOT EXISTS `erp_login_attempts` (
  `id` mediumint(8) unsigned NOT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_marchine`
--

CREATE TABLE IF NOT EXISTS `erp_marchine` (
  `id` mediumint(8) unsigned NOT NULL,
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
  `150` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_marchine_logs`
--

CREATE TABLE IF NOT EXISTS `erp_marchine_logs` (
  `id` mediumint(8) unsigned NOT NULL,
  `marchine_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `old_number` int(11) DEFAULT NULL,
  `new_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_migrations`
--

CREATE TABLE IF NOT EXISTS `erp_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_migrations`
--

INSERT INTO `erp_migrations` (`version`) VALUES
(312);

-- --------------------------------------------------------

--
-- Table structure for table `erp_notifications`
--

CREATE TABLE IF NOT EXISTS `erp_notifications` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_date` datetime DEFAULT NULL,
  `till_date` datetime DEFAULT NULL,
  `scope` tinyint(1) NOT NULL DEFAULT '3'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_notifications`
--

INSERT INTO `erp_notifications` (`id`, `comment`, `date`, `from_date`, `till_date`, `scope`) VALUES
(1, '<p>Thank you for using iCloudERP - POS. If you find any error/bug, please email to support@cloudnet.com.kh with details. You can send us your valued suggestions/feedback too.</p>', '2014-08-15 12:00:57', '2015-01-01 00:00:00', '2017-01-01 00:00:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `erp_order_ref`
--

CREATE TABLE IF NOT EXISTS `erp_order_ref` (
  `ref_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `so` int(11) NOT NULL DEFAULT '1' COMMENT 'sale order',
  `qu` int(11) NOT NULL DEFAULT '1' COMMENT 'quote',
  `po` int(11) NOT NULL DEFAULT '1' COMMENT 'purchase order',
  `to` int(11) NOT NULL DEFAULT '1' COMMENT 'transfer to',
  `pos` int(11) NOT NULL DEFAULT '1' COMMENT 'pos',
  `do` int(11) NOT NULL DEFAULT '1' COMMENT 'delivery order',
  `pay` int(11) NOT NULL DEFAULT '1',
  `re` int(11) NOT NULL DEFAULT '1' COMMENT 'sale return',
  `ex` int(11) NOT NULL DEFAULT '1' COMMENT 'expense',
  `sp` int(11) NOT NULL DEFAULT '1' COMMENT 'sale payement',
  `pp` int(11) NOT NULL DEFAULT '1' COMMENT 'purchase payment',
  `sl` int(11) NOT NULL DEFAULT '1' COMMENT 'sale loan',
  `tr` int(11) NOT NULL DEFAULT '1',
  `rep` int(11) NOT NULL DEFAULT '1',
  `con` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_order_ref`
--

INSERT INTO `erp_order_ref` (`ref_id`, `biller_id`, `date`, `so`, `qu`, `po`, `to`, `pos`, `do`, `pay`, `re`, `ex`, `sp`, `pp`, `sl`, `tr`, `rep`, `con`) VALUES
(1, 3, '2016-02-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(2, 3, '2016-03-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(3, 3, '2016-04-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(4, 3, '2016-05-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(5, 3, '2016-06-01', 1, 1, 1, 1, 1, 41, 1, 1, 1, 44, 1, 1, 46, 1, 1),
(6, 3, '2016-07-01', 1, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1),
(7, 3, '2016-08-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(8, 3, '2016-09-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(9, 3, '2016-10-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(10, 3, '2016-11-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(11, 3, '2016-12-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(12, 3, '2017-01-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(13, 3, '2017-02-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(14, 3, '2017-03-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(15, 3, '2017-04-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(16, 3, '2017-05-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(17, 3, '2017-06-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(18, 3, '2017-07-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(19, 3, '2017-08-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(21, 3, '2017-09-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(22, 3, '2017-10-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(23, 3, '2017-11-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(24, 3, '2017-12-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(25, 3, '2018-01-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(26, 3, '2018-02-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(27, 3, '2018-03-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(28, 3, '2018-04-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(29, 3, '2018-05-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(30, 3, '2018-06-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(31, 3, '2018-07-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(32, 3, '2018-08-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(33, 3, '2018-09-01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `erp_payments`
--

CREATE TABLE IF NOT EXISTS `erp_payments` (
  `id` int(11) NOT NULL,
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
  `purchase_return_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_payments`
--

INSERT INTO `erp_payments` (`id`, `biller_id`, `date`, `sale_id`, `return_id`, `purchase_id`, `deposit_id`, `purchase_deposit_id`, `loan_id`, `expense_id`, `transaction_id`, `reference_no`, `paid_by`, `cheque_no`, `cc_no`, `cc_holder`, `cc_month`, `cc_year`, `cc_type`, `amount`, `pos_paid`, `currency`, `created_by`, `attachment`, `type`, `note`, `pos_balance`, `pos_paid_other`, `pos_paid_other_rate`, `approval_code`, `purchase_return_id`) VALUES
(1, NULL, '2016-03-21 06:00:00', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00001', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha</p>', '0.0000', NULL, NULL, NULL, NULL),
(3, NULL, '2016-03-21 06:00:00', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00004', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '', '0.0000', NULL, NULL, NULL, NULL),
(4, NULL, '2016-03-21 06:00:00', 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00005', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '', '0.0000', NULL, NULL, NULL, NULL),
(5, NULL, '2016-03-22 06:00:00', 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00006', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(6, NULL, '2016-03-23 06:00:00', 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00007', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(7, NULL, '2016-03-23 06:00:00', 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00008', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(8, NULL, '2016-03-23 06:00:00', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00009', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(9, NULL, '2016-03-24 06:00:00', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00010', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(10, NULL, '2016-03-24 06:00:00', 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00011', 'cash', '', '', '', '', '', 'Visa', '70.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(11, NULL, '2016-03-24 06:00:00', 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00012', 'cash', '', '', '', '', '', 'Visa', '70.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(12, NULL, '2016-03-28 06:00:00', 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00013', 'cash', '', '', '', '', '', 'Visa', '70.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(13, NULL, '2016-03-31 06:00:00', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00014', 'cash', '', '', '', '', '', 'Visa', '1050.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(14, 3, '2016-03-31 06:00:00', 13, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00015', 'cash', '', '', '', '', '', 'Visa', '70.0000', '70.0000', NULL, 1, NULL, 'returned', NULL, '0.0000', NULL, NULL, NULL, NULL),
(15, 3, '2016-03-31 06:00:00', 12, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00015', 'cash', '', '', '', '', '', 'Visa', '70.0000', '70.0000', NULL, 1, NULL, 'returned', NULL, '0.0000', NULL, NULL, NULL, NULL),
(16, NULL, '2016-03-31 06:00:00', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00015', 'cash', '', '', '', '', '', 'Visa', '1050.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(17, NULL, '2016-04-01 06:00:00', 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00016', 'cash', '', '', '', '', '', 'Visa', '1000.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(18, NULL, '2016-04-01 06:00:00', 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00017', 'cash', '', '', '', '', '', 'Visa', '200.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(19, NULL, '2016-04-04 06:00:00', 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00018', 'cash', '', '', '', '', '', 'Visa', '700.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(20, 3, '2016-04-05 06:00:00', 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00019', 'cash', '', '', '', '', '', 'Visa', '515.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(21, NULL, '2016-04-05 06:00:00', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00020', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(22, NULL, '2016-04-05 06:00:00', 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00021', 'cash', '', '', '', '', '', 'Visa', '150.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(23, NULL, '2016-04-05 06:00:00', 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00022', 'cash', '', '', '', '', '', 'Visa', '150.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By: Panha Soun</p>', '0.0000', NULL, NULL, NULL, NULL),
(24, NULL, '2016-04-06 06:00:00', 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00023', 'cash', '', '', '', '', '', 'Visa', '950.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(25, NULL, '2016-04-06 06:00:00', 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00024', 'cash', '', '', '', '', '', 'Visa', '825.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(26, NULL, '2016-04-18 06:00:00', 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00025', 'cash', '', '', '', '', '', 'Visa', '850.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(27, 3, '2016-04-18 06:00:00', 14, 3, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00026', 'cash', '', '', '', '', '', 'Visa', '70.0000', '70.0000', NULL, 1, NULL, 'returned', NULL, '0.0000', NULL, NULL, NULL, NULL),
(28, NULL, '2016-04-19 06:00:00', 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00026', 'cash', '', '', '', '', '', 'Visa', '1009.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(29, NULL, '2016-04-20 06:00:00', 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00027', 'cash', '', '', '', '', '', 'Visa', '525.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received By Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(30, NULL, '2016-04-25 06:00:00', 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00028', 'cash', '', '', '', '', '', 'Visa', '650.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(31, NULL, '2016-04-27 06:00:00', 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00029', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(32, NULL, '2016-04-28 06:00:00', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00030', 'cash', '', '', '', '', '', 'Visa', '950.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(33, NULL, '2016-04-26 06:00:00', 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00031', 'cash', '', '', '', '', '', 'Visa', '70.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(34, NULL, '2016-04-11 06:00:00', 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00032', 'cash', '', '', '', '', '', 'Visa', '300.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(36, 3, '2016-05-16 06:00:00', 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00034', 'cash', '', '', '', '', '', 'Visa', '1400.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(37, NULL, '2016-05-26 06:00:00', 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00035', 'cash', '', '', '', '', '', 'Visa', '30.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(38, NULL, '2016-06-02 06:00:00', 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00036', 'cash', '', '', '', '', '', 'Visa', '30.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(39, NULL, '2016-06-03 06:00:00', 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00037', 'cash', '', '', '', '', '', 'Visa', '15.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(40, NULL, '2016-06-03 06:00:00', 37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00038', 'cash', '', '', '', '', '', 'Visa', '15.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(41, NULL, '2016-06-06 06:00:00', 38, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00039', 'cash', '', '', '', '', '', 'Visa', '70.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(42, NULL, '2016-06-17 06:00:00', 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00040', 'cash', '', '', '', '', '', 'Visa', '80.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(44, NULL, '2016-06-22 06:00:00', 41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00042', 'cash', '', '', '', '', '', 'Visa', '1060.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(45, NULL, '2016-06-17 06:00:00', 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1606/00043', 'cash', '', '', '', '', '', 'Visa', '1395.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL),
(46, NULL, '2016-05-07 06:00:00', 43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RV/1607/00001', 'cash', '', '', '', '', '', 'Visa', '950.0000', '0.0000', NULL, 1, NULL, 'received', '<p>Received by Panha Soun </p>', '0.0000', NULL, NULL, NULL, NULL);

--
-- Triggers `erp_payments`
--
DELIMITER $$
CREATE TRIGGER `gl_trans_payment_insert` AFTER INSERT ON `erp_payments`
 FOR EACH ROW BEGIN

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
	SET v_tran_no = (SELECT MAX(tran_no)+1 FROM erp_gl_trans);

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
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_payment_update` AFTER UPDATE ON `erp_payments`
 FOR EACH ROW BEGIN

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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `erp_paypal`
--

CREATE TABLE IF NOT EXISTS `erp_paypal` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL,
  `paypal_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '2.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '3.9000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '4.4000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_paypal`
--

INSERT INTO `erp_paypal` (`id`, `active`, `account_email`, `paypal_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 0, 'mypaypal@paypal.com', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Table structure for table `erp_permissions`
--

CREATE TABLE IF NOT EXISTS `erp_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `products-index` tinyint(1) DEFAULT '0',
  `products-add` tinyint(1) DEFAULT '0',
  `products-edit` tinyint(1) DEFAULT '0',
  `products-delete` tinyint(1) DEFAULT '0',
  `products-cost` tinyint(1) DEFAULT '0',
  `products-price` tinyint(1) DEFAULT '0',
  `quotes-index` tinyint(1) DEFAULT '0',
  `quotes-add` tinyint(1) DEFAULT '0',
  `quotes-edit` tinyint(1) DEFAULT '0',
  `quotes-pdf` tinyint(1) DEFAULT '0',
  `quotes-email` tinyint(1) DEFAULT '0',
  `quotes-delete` tinyint(1) DEFAULT '0',
  `sales-index` tinyint(1) DEFAULT '0',
  `sales-add` tinyint(1) DEFAULT '0',
  `sales-edit` tinyint(1) DEFAULT '0',
  `sales-pdf` tinyint(1) DEFAULT '0',
  `sales-email` tinyint(1) DEFAULT '0',
  `sales-delete` tinyint(1) DEFAULT '0',
  `purchases-index` tinyint(1) DEFAULT '0',
  `purchases-add` tinyint(1) DEFAULT '0',
  `purchases-edit` tinyint(1) DEFAULT '0',
  `purchases-pdf` tinyint(1) DEFAULT '0',
  `purchases-email` tinyint(1) DEFAULT '0',
  `purchases-delete` tinyint(1) DEFAULT '0',
  `transfers-index` tinyint(1) DEFAULT '0',
  `transfers-add` tinyint(1) DEFAULT '0',
  `transfers-edit` tinyint(1) DEFAULT '0',
  `transfers-pdf` tinyint(1) DEFAULT '0',
  `transfers-email` tinyint(1) DEFAULT '0',
  `transfers-delete` tinyint(1) DEFAULT '0',
  `customers-index` tinyint(1) DEFAULT '0',
  `customers-add` tinyint(1) DEFAULT '0',
  `customers-edit` tinyint(1) DEFAULT '0',
  `customers-delete` tinyint(1) DEFAULT '0',
  `suppliers-index` tinyint(1) DEFAULT '0',
  `suppliers-add` tinyint(1) DEFAULT '0',
  `suppliers-edit` tinyint(1) DEFAULT '0',
  `suppliers-delete` tinyint(1) DEFAULT '0',
  `sales-deliveries` tinyint(1) DEFAULT '0',
  `sales-add_delivery` tinyint(1) DEFAULT '0',
  `sales-edit_delivery` tinyint(1) DEFAULT '0',
  `sales-delete_delivery` tinyint(1) DEFAULT '0',
  `sales-email_delivery` tinyint(1) DEFAULT '0',
  `sales-pdf_delivery` tinyint(1) DEFAULT '0',
  `sales-gift_cards` tinyint(1) DEFAULT '0',
  `sales-add_gift_card` tinyint(1) DEFAULT '0',
  `sales-edit_gift_card` tinyint(1) DEFAULT '0',
  `sales-delete_gift_card` tinyint(1) DEFAULT '0',
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
  `sales-loan` tinyint(1) DEFAULT '0',
  `reports-daily_purchases` tinyint(1) DEFAULT '0',
  `reports-monthly_purchases` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_permissions`
--

INSERT INTO `erp_permissions` (`id`, `group_id`, `products-index`, `products-add`, `products-edit`, `products-delete`, `products-cost`, `products-price`, `quotes-index`, `quotes-add`, `quotes-edit`, `quotes-pdf`, `quotes-email`, `quotes-delete`, `sales-index`, `sales-add`, `sales-edit`, `sales-pdf`, `sales-email`, `sales-delete`, `purchases-index`, `purchases-add`, `purchases-edit`, `purchases-pdf`, `purchases-email`, `purchases-delete`, `transfers-index`, `transfers-add`, `transfers-edit`, `transfers-pdf`, `transfers-email`, `transfers-delete`, `customers-index`, `customers-add`, `customers-edit`, `customers-delete`, `suppliers-index`, `suppliers-add`, `suppliers-edit`, `suppliers-delete`, `sales-deliveries`, `sales-add_delivery`, `sales-edit_delivery`, `sales-delete_delivery`, `sales-email_delivery`, `sales-pdf_delivery`, `sales-gift_cards`, `sales-add_gift_card`, `sales-edit_gift_card`, `sales-delete_gift_card`, `pos-index`, `sales-return_sales`, `reports-index`, `reports-warehouse_stock`, `reports-quantity_alerts`, `reports-expiry_alerts`, `reports-products`, `reports-daily_sales`, `reports-monthly_sales`, `reports-sales`, `reports-payments`, `reports-purchases`, `reports-profit_loss`, `reports-customers`, `reports-suppliers`, `reports-staff`, `reports-register`, `reports-account`, `sales-payments`, `purchases-payments`, `purchases-expenses`, `bulk_actions`, `customers-deposits`, `customers-delete_deposit`, `products-adjustments`, `accounts-index`, `accounts-add`, `accounts-edit`, `accounts-delete`, `sales-loan`, `reports-daily_purchases`, `reports-monthly_purchases`) VALUES
(1, 5, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, 1, 1, 1, NULL, NULL, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 1, 1, 0, 0),
(2, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, NULL, NULL, NULL, 1, 1, 1, 1, 1, 1, 0, 0),
(3, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 8, 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 10, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, NULL, NULL, NULL, 1, 1, 1, 1, 1, 0, 0, 0),
(8, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, NULL, NULL, NULL, 1, 1, 1, 1, 1, 0, 0, 0),
(9, 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, 1, 1, 1, 1, NULL, NULL, 1, 1, 1, 1, NULL, NULL, 1, 1, 1, 1, NULL, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, NULL, NULL, NULL, 1, 1, 1, 1, 1, NULL, 0, 0),
(10, 13, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `erp_pos_register`
--

CREATE TABLE IF NOT EXISTS `erp_pos_register` (
  `id` int(11) NOT NULL,
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
  `closed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_pos_register`
--

INSERT INTO `erp_pos_register` (`id`, `date`, `user_id`, `cash_in_hand`, `status`, `total_cash`, `total_cheques`, `total_cc_slips`, `total_cash_submitted`, `total_cheques_submitted`, `total_cc_slips_submitted`, `note`, `closed_at`, `transfer_opened_bills`, `closed_by`) VALUES
(1, '2016-05-04 20:24:46', 1, '100.0000', 'open', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_pos_settings`
--

CREATE TABLE IF NOT EXISTS `erp_pos_settings` (
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
  `auto_delivery` tinyint(1) unsigned DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_pos_settings`
--

INSERT INTO `erp_pos_settings` (`pos_id`, `cat_limit`, `pro_limit`, `default_category`, `default_customer`, `default_biller`, `display_time`, `cf_title1`, `cf_title2`, `cf_value1`, `cf_value2`, `receipt_printer`, `cash_drawer_codes`, `focus_add_item`, `add_manual_product`, `customer_selection`, `add_customer`, `toggle_category_slider`, `toggle_subcategory_slider`, `show_search_item`, `product_unit`, `cancel_sale`, `suspend_sale`, `print_items_list`, `finalize_sale`, `today_sale`, `open_hold_bills`, `close_register`, `keyboard`, `pos_printers`, `java_applet`, `product_button_color`, `tooltips`, `paypal_pro`, `stripe`, `rounding`, `char_per_line`, `pin_code`, `purchase_code`, `envato_username`, `version`, `show_item_img`, `pos_layout`, `display_qrcode`, `show_suspend_bar`, `show_payment_noted`, `payment_balance`, `authorize`, `show_product_code`, `auto_delivery`) VALUES
(1, 22, 20, 3, 467, 3, '1', 'GST Reg', 'VAT Reg', '123456789', '987654321', 'BIXOLON SRP-350II', 'x1C', 'Ctrl+F3', 'Ctrl+Shift+M', 'Ctrl+Shift+C', 'Ctrl+Shift+A', 'Ctrl+F11', 'Ctrl+F12', 'F1', 'F2', 'F4', 'F7', 'F9', 'F8', 'Ctrl+F1', 'Ctrl+F2', 'Ctrl+F10', 0, 'BIXOLON SRP-350II, BIXOLON SRP-350II', 0, 'warning', 0, 0, 0, 0, 42, NULL, 'purchase_code', 'envato_username', '3.0.1.21', 1, 0, 0, 1, 1, 1, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `erp_products`
--

CREATE TABLE IF NOT EXISTS `erp_products` (
  `id` int(11) NOT NULL,
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
  `currentcy_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_products`
--

INSERT INTO `erp_products` (`id`, `code`, `name`, `unit`, `cost`, `price`, `alert_quantity`, `image`, `category_id`, `subcategory_id`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `quantity`, `tax_rate`, `track_quantity`, `details`, `warehouse`, `barcode_symbology`, `file`, `product_details`, `tax_method`, `type`, `supplier1`, `supplier1price`, `supplier2`, `supplier2price`, `supplier3`, `supplier3price`, `supplier4`, `supplier4price`, `supplier5`, `supplier5price`, `no`, `promotion`, `promo_price`, `start_date`, `end_date`, `supplier1_part_no`, `supplier2_part_no`, `supplier3_part_no`, `supplier4_part_no`, `supplier5_part_no`, `currentcy_code`) VALUES
(5, 'MHD-001', 'Tution Fee Per Term Morning (MHD)', 'term', NULL, '750.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(6, 'MHD-002', 'Tution Fee Per Semester Morning (MHD)', 'semester', NULL, '1400.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(7, 'MHD-003', 'Tution Fee Per Year Morning (MHD)', 'year', NULL, '2700.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(8, 'AHD-001', 'Tution Fee Per Term Afternoon (AHD)', 'term', NULL, '675.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(9, 'AHD-002', 'Tution Fee Per Semester Afternoon (AHD)', 'semester', NULL, '1260.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(10, 'AHD-003', 'Tution Fee Per Year Afternoon (AHD)', 'year', NULL, '2430.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'term', NULL, '1300.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(12, 'FD-002', 'Tution Fee Per Semester Full Day (FD)', 'semester', NULL, '2500.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(13, 'FD-003', 'Tution Fee Per Year Full Day (FD)', 'year', NULL, '4800.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'term', NULL, '90.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(15, 'SNACK-F002', 'Snack Fee Semester Full Day (FD)', 'semester', NULL, '180.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(16, 'SNACK-F003', 'Snack Fee Year Full Day (FD)', 'year', NULL, '360.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001-11-30', '0001-11-30', NULL, NULL, NULL, NULL, NULL, 'USD'),
(17, 'SNACK-H001', 'Snack Fee Term Half Day (HD)', 'term', NULL, '50.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(18, 'SNACK-H002', 'Snack Fee Semester Half Day (HD)', 'semester', NULL, '100.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(19, 'SNACK-H003', 'Snack Fee Year Half Day (HD)', 'year', NULL, '200.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(20, 'LUNCH-001', 'Lunch (Optional) Term', 'term', NULL, '150.0000', '0.0000', 'no_image.png', 5, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(21, 'LUNCH-002', 'Lunch (Optional) Semester', 'semester', NULL, '300.0000', '0.0000', 'no_image.png', 5, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(22, 'LUNCH-003', 'Lunch (Optional) Year', 'year', NULL, '600.0000', '0.0000', 'no_image.png', 5, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(23, 'LEAR-001', 'Learning Meterials Term', 'term', NULL, '110.0000', '0.0000', 'no_image.png', 6, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(24, 'LEAR-002', 'Learning Meterials Semester', 'semester', NULL, '220.0000', '0.0000', 'no_image.png', 6, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(25, 'LEAR-003', 'Learning Meterials Year', 'year', NULL, '440.0000', '0.0000', 'no_image.png', 6, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(26, 'UNIFORM-001', 'Uniform (1set)', 'each', '0.0000', '15.0000', '0.0000', 'no_image.png', 7, NULL, '', '', '', '', '', '', '-19.0000', 1, 1, '', NULL, 'code128', NULL, '', 0, 'standard', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'unit', NULL, '300.0000', '0.0000', 'no_image.png', 7, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(28, 'ADMIN-001', 'Administrative Fee (Pay Per Year)', 'year', NULL, '200.0000', '0.0000', 'no_image.png', 7, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD'),
(29, 'Week-001', '1 week trail', 'each', NULL, '70.0000', '0.0000', 'no_image.png', 7, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', NULL, '', 0, 'service', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, NULL, NULL, NULL, NULL, 'USD');

-- --------------------------------------------------------

--
-- Table structure for table `erp_product_photos`
--

CREATE TABLE IF NOT EXISTS `erp_product_photos` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_product_variants`
--

CREATE TABLE IF NOT EXISTS `erp_product_variants` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `qty_unit` decimal(15,4) DEFAULT NULL,
  `currentcy_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_purchases`
--

CREATE TABLE IF NOT EXISTS `erp_purchases` (
  `id` int(11) NOT NULL,
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
  `suspend_note` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `erp_purchases`
--
DELIMITER $$
CREATE TRIGGER `gl_trans_purchase_delete` AFTER DELETE ON `erp_purchases`
 FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference_no;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_purchase_insert` AFTER INSERT ON `erp_purchases`
 FOR EACH ROW BEGIN
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
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_purchase_update` AFTER UPDATE ON `erp_purchases`
 FOR EACH ROW BEGIN
DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;

IF NEW.status="received"  AND  NEW.return_id > 0 THEN

/*
	SET v_tran_no = (SELECT MAX(tran_no)+1 FROM erp_gl_trans);	
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
			'PURCHASES',
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
			'PURCHASES',
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
			'PURCHASES',
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
			'PURCHASES',
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
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `erp_purchase_items`
--

CREATE TABLE IF NOT EXISTS `erp_purchase_items` (
  `id` int(11) NOT NULL,
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
  `container_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_purchase_items`
--

INSERT INTO `erp_purchase_items` (`id`, `purchase_id`, `transfer_id`, `product_id`, `product_code`, `product_name`, `option_id`, `net_unit_cost`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `expiry`, `subtotal`, `quantity_balance`, `date`, `status`, `unit_cost`, `real_unit_cost`, `quantity_received`, `supplier_part_no`, `supplier_id`, `container_id`) VALUES
(1, NULL, NULL, 27, '', '', NULL, '0.0000', '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', '3.0000', '0000-00-00', '', NULL, NULL, NULL, NULL, NULL, 0),
(2, NULL, NULL, 29, '', '', NULL, '0.0000', '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', '3.0000', '0000-00-00', '', NULL, NULL, NULL, NULL, NULL, 0),
(3, NULL, NULL, 26, '', '', NULL, '0.0000', '0.0000', 1, '0.0000', NULL, NULL, NULL, NULL, NULL, '0.0000', '-19.0000', '0000-00-00', '', NULL, NULL, NULL, NULL, NULL, 0),
(4, NULL, NULL, 6, '', '', NULL, '0.0000', '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', '1.0000', '0000-00-00', '', NULL, NULL, NULL, NULL, NULL, 0),
(5, NULL, NULL, 18, '', '', NULL, '0.0000', '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', '1.0000', '0000-00-00', '', NULL, NULL, NULL, NULL, NULL, 0),
(6, NULL, NULL, 11, '', '', NULL, '0.0000', '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', '1.0000', '0000-00-00', '', NULL, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `erp_quotes`
--

CREATE TABLE IF NOT EXISTS `erp_quotes` (
  `id` int(11) NOT NULL,
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
  `supplier` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_quote_items`
--

CREATE TABLE IF NOT EXISTS `erp_quote_items` (
  `id` int(11) NOT NULL,
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
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_return_items`
--

CREATE TABLE IF NOT EXISTS `erp_return_items` (
  `id` int(11) NOT NULL,
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
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_return_items`
--

INSERT INTO `erp_return_items` (`id`, `sale_id`, `return_id`, `sale_item_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`) VALUES
(1, 0, 1, 21, 29, 'Week-001', '1 week trail', 'service', 0, '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000'),
(2, 0, 2, 20, 29, 'Week-001', '1 week trail', 'service', 0, '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000'),
(3, 0, 3, 22, 29, 'Week-001', '1 week trail', 'service', 0, '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000');

-- --------------------------------------------------------

--
-- Table structure for table `erp_return_purchases`
--

CREATE TABLE IF NOT EXISTS `erp_return_purchases` (
  `id` int(11) NOT NULL,
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
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_return_purchase_items`
--

CREATE TABLE IF NOT EXISTS `erp_return_purchase_items` (
  `id` int(11) NOT NULL,
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
  `real_unit_cost` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_return_sales`
--

CREATE TABLE IF NOT EXISTS `erp_return_sales` (
  `id` int(11) NOT NULL,
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
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_return_sales`
--

INSERT INTO `erp_return_sales` (`id`, `sale_id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `surcharge`, `grand_total`, `created_by`, `updated_by`, `updated_at`, `attachment`) VALUES
(1, 13, '2016-03-31 06:00:00', 'RT-1603-000001', 454, 'KL-000012', 3, 'Kinderland', 1, '&lt;p&gt;Returned for one week trail&lt;&sol;p&gt;', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 1, NULL, NULL, NULL),
(2, 12, '2016-03-31 06:00:00', 'RT-1603-000002', 453, 'KL-000011', 3, 'Kinderland', 1, '&lt;p&gt;Returned for 1 week trail&period;&lt;&sol;p&gt;', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 1, NULL, NULL, NULL),
(3, 14, '2016-04-18 06:00:00', 'RT-1603-000003', 456, 'KL-000014', 3, 'Kinderland', 1, '&lt;p&gt;Returned one week trail&period;&lt;&sol;p&gt;', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_sales`
--

CREATE TABLE IF NOT EXISTS `erp_sales` (
  `id` int(11) NOT NULL,
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
  `suspend_note` varchar(20) DEFAULT NULL,
  `other_cur_paid` decimal(25,0) NOT NULL,
  `other_cur_paid_rate` decimal(25,0) NOT NULL DEFAULT '0',
  `saleman_by` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_sales`
--

INSERT INTO `erp_sales` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `sale_status`, `payment_status`, `payment_term`, `due_date`, `created_by`, `updated_by`, `updated_at`, `total_items`, `total_cost`, `pos`, `paid`, `return_id`, `surcharge`, `attachment`, `suspend_note`, `other_cur_paid`, `other_cur_paid_rate`, `saleman_by`) VALUES
(3, '2016-03-21 06:00:00', '1603-000003', 445, 'KL-000003', 3, 'Kinderland', 1, '', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(5, '2016-03-21 06:00:00', '1603-000004', 446, 'KL-000004', 3, 'Kinderland', 1, '', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(6, '2016-03-21 06:00:00', '1603-000005', 447, 'KL-000005', 3, 'Kinderland', 1, '&lt;p&gt;Mr&period;Bunneng &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(7, '2016-03-22 06:00:00', '1603-000006', 448, 'KL-000006', 3, 'Kinderland', 1, '&lt;p&gt;Chao vouchlak &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(8, '2016-03-23 06:00:00', '1603-000007', 449, 'KL-000007', 3, 'Kinderland', 1, '&lt;p&gt;Soum Phalla &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(9, '2016-03-23 06:00:00', '1603-000008', 450, 'KL-000008', 3, 'Kinderland', 1, '&lt;p&gt;Soum Phalla &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(10, '2016-03-23 06:00:00', '1603-000009', 451, 'KL-000009', 3, 'Kinderland', 1, '&lt;p&gt;Sum channy &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(11, '2016-03-24 06:00:00', '1603-000010', 452, 'KL-000010', 3, 'Kinderland', 1, '&lt;p&gt;Chan Kimly &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(12, '2016-03-24 06:00:00', '1603-000011', 453, 'KL-000011', 3, 'Kinderland', 1, '&lt;p&gt;Rang Sey &lt;&sol;p&gt;', '', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '70.0000', 2, '0.0000', NULL, NULL, '0', '0', 0),
(13, '2016-03-24 06:00:00', '1603-000012', 454, 'KL-000012', 3, 'Kinderland', 1, '&lt;p&gt;Rang Sey &lt;&sol;p&gt;', '', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '70.0000', 1, '0.0000', NULL, NULL, '0', '0', 0),
(14, '2016-03-28 06:00:00', '1603-000013', 456, 'KL-000014', 3, 'Kinderland', 1, '&lt;p&gt;Nget Hak&lt;&sol;p&gt;', '', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '70.0000', 3, '0.0000', NULL, NULL, '0', '0', 0),
(15, '2016-03-31 06:00:00', '1603-000014', 453, 'KL-000011', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Rang Sey &lt;&sol;p&gt;', '&lt;p&gt;Returned 1 week trail -&lpar;70&dollar;&rpar; Total &lpar;980&dollar;&rpar;&lt;&sol;p&gt;', '1050.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1050.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 4, '0.0000', 0, '1050.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(16, '2016-03-31 06:00:00', '1603-000015', 454, 'KL-000012', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Rang Sey &lt;&sol;p&gt;', '', '1050.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1050.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 4, '0.0000', 0, '1050.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(17, '2016-04-01 06:00:00', '1604-000016', 455, 'KL-000013', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Kanitha&lt;&sol;p&gt;', '', '2400.0000', '2.0000', NULL, '2.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '2400.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 5, '0.0000', 0, '2400.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(18, '2016-04-01 06:00:00', '1604-000017', 456, 'KL-000014', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Kim Hak &lt;&sol;p&gt;', '', '200.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '200.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '200.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(19, '2016-04-04 06:00:00', '1604-000018', 457, 'KL-000015', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Hean Thida &lt;&sol;p&gt;', '', '1215.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1215.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 7, '0.0000', 0, '1215.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(20, '2016-04-05 06:00:00', '1604-000020', 458, 'KL-000016', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Sarath &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(21, '2016-04-05 06:00:00', '1604-000021', 453, 'KL-000011', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Rang Sey&nbsp; &lt;&sol;p&gt;', '', '150.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '150.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '150.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(22, '2016-04-05 06:00:00', '1604-000022', 454, 'KL-000012', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Rang Sey&lt;&sol;p&gt;', '', '150.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '150.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '150.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(23, '2016-04-06 06:00:00', '1604-000023', 459, 'KL-000017', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Vathana &lt;&sol;p&gt;', '', '950.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '950.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, '0.0000', 0, '950.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(24, '2016-04-06 06:00:00', '1604-000024', 460, 'KL-000018', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; cheata&lt;&sol;p&gt;', '', '825.0000', '225.0000', NULL, '225.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '825.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, '0.0000', 0, '825.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(25, '2016-04-18 06:00:00', '1604-000026', 456, 'KL-000014', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Kim Hak &lt;&sol;p&gt;', '', '850.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '850.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 5, '0.0000', 0, '850.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(26, '2016-04-19 06:00:00', '1604-000027', 462, 'KL-000020', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Kim chanserey &lt;&sol;p&gt;', '', '1009.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1009.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 6, '0.0000', 0, '1009.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(27, '2016-04-20 06:00:00', '1604-000028', 451, 'KL-000009', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Chan Kimly &lt;&sol;p&gt;', '', '525.0000', '225.0000', NULL, '225.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '525.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '525.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(28, '2016-04-25 06:00:00', '1604-000029', 458, 'KL-000016', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Sarim &lt;&sol;p&gt;', '', '650.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '650.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '650.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(29, '2016-04-27 06:00:00', '1604-000031', 463, 'KL-000021', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Sum Channy &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(30, '2016-04-28 06:00:00', '1604-000032', 464, 'KL-000022', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Chan Sotheary &lt;&sol;p&gt;', '', '950.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '950.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, '0.0000', 0, '950.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(31, '2016-04-26 06:00:00', '1603-000030', 468, 'KL-000025', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Mai Syvour &lt;&sol;p&gt;', '', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '70.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(32, '2016-04-11 06:00:00', '1604-000025', 461, 'KL-000019', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Vin Sao Pheng &lt;&sol;p&gt;', '', '300.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '300.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '300.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(34, '2016-05-26 06:00:00', '1605-000035', 462, 'KL-000020', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Kim Chanserey &lt;&sol;p&gt;', '', '30.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '30.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, '0.0000', 0, '30.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(35, '2016-06-02 06:00:00', '1606-000036', 462, 'KL-000020', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Kim Chanserey &lt;&sol;p&gt;', '', '30.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '30.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, '0.0000', 0, '30.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(36, '2016-06-03 06:00:00', '1606-000037', 453, 'KL-000011', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Rang Sey &lt;&sol;p&gt;', '', '15.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '15.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '15.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(37, '2016-06-03 06:00:00', '1606-000038', 454, 'KL-000012', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Rang Sey &lt;&sol;p&gt;', '', '15.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '15.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '15.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(38, '2016-06-06 06:00:00', '1606-000039', 469, 'KL-000026', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Channara &lt;&sol;p&gt;', '', '70.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '70.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, '0.0000', 0, '70.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(39, '2016-06-17 06:00:00', '1606-000040', 460, 'KL-000018', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Nhim Panha Socheata &lt;&sol;p&gt;', '', '80.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '80.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 3, '0.0000', 0, '80.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(41, '2016-06-22 06:00:00', '1606-000042', 461, 'KL-000019', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Cheng Bun Hour &lt;&sol;p&gt;', '', '1060.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1060.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 8, '0.0000', 0, '1060.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(42, '2016-06-17 06:00:00', '1606-000041', 466, 'KL-000024', 3, 'Kinderland', 1, '&lt;p&gt;Dad&colon; Seng Virauresna &lt;&sol;p&gt;', '', '1395.0000', '420.0000', NULL, '420.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1395.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 4, '0.0000', 0, '1395.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0),
(43, '2016-05-07 06:00:00', '1605-000033', 465, 'KL-000023', 3, 'Kinderland', 1, '&lt;p&gt;Mother&colon; Kong Chantty &lt;&sol;p&gt;', '', '950.0000', '650.0000', NULL, '650.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '950.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, '0.0000', 0, '950.0000', NULL, '0.0000', NULL, NULL, '0', '0', 0);

--
-- Triggers `erp_sales`
--
DELIMITER $$
CREATE TRIGGER `gl_trans_sale_delete` AFTER DELETE ON `erp_sales`
 FOR EACH ROW BEGIN

   UPDATE erp_gl_trans SET amount = 0, description = CONCAT(description,' (Cancelled)')
   WHERE reference_no = OLD.reference_no;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_sale_insert` AFTER INSERT ON `erp_sales`
 FOR EACH ROW BEGIN
DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;

IF NEW.sale_status="completed" AND NEW.total > 0 THEN

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
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `gl_trans_sale_update` AFTER UPDATE ON `erp_sales`
 FOR EACH ROW BEGIN
DECLARE v_tran_no INTEGER;
DECLARE v_tran_date DATETIME;

IF NEW.sale_status="completed"  AND  NEW.return_id > 0 THEN
/*

	SET v_tran_no = (SELECT MAX(tran_no)+1 FROM erp_gl_trans);	
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
			'SALES',
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
			'SALES',
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
			'SALES',
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
			'SALES',
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
			'SALES',
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
			'SALES',
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
			'SALES',
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
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `erp_sale_dev_items`
--

CREATE TABLE IF NOT EXISTS `erp_sale_dev_items` (
  `id` int(11) NOT NULL,
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
  `user_9` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_sale_items`
--

CREATE TABLE IF NOT EXISTS `erp_sale_items` (
  `id` int(11) NOT NULL,
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
  `product_noted` varchar(30) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_sale_items`
--

INSERT INTO `erp_sale_items` (`id`, `sale_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`, `product_noted`) VALUES
(11, 3, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(13, 5, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(14, 6, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(15, 7, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(16, 8, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(17, 9, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(18, 10, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(19, 11, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(20, 12, 29, 'Week-001', '1 week trail', 'service', NULL, '70.0000', '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000', ''),
(21, 13, 29, 'Week-001', '1 week trail', 'service', NULL, '70.0000', '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000', ''),
(22, 14, 29, 'Week-001', '1 week trail', 'service', NULL, '70.0000', '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000', ''),
(23, 15, 11, 'FD-001', 'Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(24, 15, 14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'service', NULL, '90.0000', '90.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '90.0000', '', '90.0000', ''),
(25, 15, 23, 'LEAR-001', 'Learning Meterials Term', 'service', NULL, '110.0000', '110.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '110.0000', '', '110.0000', ''),
(26, 15, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', 0, '200.0000', '200.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '200.0000', '', '200.0000', ''),
(27, 16, 11, 'FD-001', 'Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(28, 16, 14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'service', NULL, '90.0000', '90.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '90.0000', '', '90.0000', ''),
(29, 16, 23, 'LEAR-001', 'Learning Meterials Term', 'service', NULL, '110.0000', '110.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '110.0000', '', '110.0000', ''),
(30, 16, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', 0, '200.0000', '200.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '200.0000', '', '200.0000', ''),
(31, 17, 13, 'FD-003', 'Per Year Full Day (FD)', 'service', 0, '4798.0000', '4800.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '2.0000', '2400.0000', '', '4800.0000', ''),
(32, 17, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '0.0000', '0.0000', '2.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '0.0000', '', '0.0000', ''),
(33, 17, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', 0, '0.0000', '0.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '0.0000', '', '0.0000', ''),
(34, 17, 28, 'ADMIN-001', 'Administrative Fee (Pay Per Year)', 'service', 0, '0.0000', '0.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '0.0000', '', '0.0000', ''),
(35, 18, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', 0, '200.0000', '200.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '200.0000', '', '200.0000', ''),
(36, 19, 11, 'FD-001', 'Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(37, 19, 14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'service', NULL, '90.0000', '90.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '90.0000', '', '90.0000', ''),
(38, 19, 20, 'LUNCH-001', 'Lunch (Optional) Term', 'service', NULL, '150.0000', '150.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '150.0000', '', '150.0000', ''),
(39, 19, 23, 'LEAR-001', 'Learning Meterials Term', 'service', NULL, '110.0000', '110.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '110.0000', '', '110.0000', ''),
(40, 19, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '15.0000', '15.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '15.0000', '', '15.0000', ''),
(41, 19, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', 0, '200.0000', '200.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '200.0000', '', '200.0000', ''),
(42, 19, 28, 'ADMIN-001', 'Administrative Fee (Pay Per Year)', 'service', 0, '0.0000', '0.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '0.0000', '', '0.0000', ''),
(43, 20, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(44, 21, 20, 'LUNCH-001', 'Lunch (Optional) Term', 'service', NULL, '150.0000', '150.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '150.0000', '', '150.0000', ''),
(45, 22, 20, 'LUNCH-001', 'Lunch (Optional) Term', 'service', NULL, '150.0000', '150.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '150.0000', '', '150.0000', ''),
(46, 23, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(47, 23, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(48, 24, 5, 'MHD-001', 'Tution Fee Per Term Morning (MHD)', 'service', 0, '525.0000', '750.0000', '1.0000', 1, '0.0000', 1, '0.0000', '30%', '225.0000', '525.0000', '', '750.0000', ''),
(49, 24, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(50, 25, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(51, 25, 14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'service', NULL, '90.0000', '90.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '90.0000', '', '90.0000', ''),
(52, 25, 23, 'LEAR-001', 'Learning Meterials Term', 'service', NULL, '110.0000', '110.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '110.0000', '', '110.0000', ''),
(53, 25, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '0.0000', '0.0000', '2.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '0.0000', '', '0.0000', ''),
(54, 26, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '430.0000', '430.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '430.0000', '', '430.0000', ''),
(55, 26, 14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'service', 0, '68.0000', '68.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '68.0000', '', '68.0000', ''),
(56, 26, 20, 'LUNCH-001', 'Lunch (Optional) Term', 'service', 0, '113.0000', '113.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '113.0000', '', '113.0000', ''),
(57, 26, 23, 'LEAR-001', 'Learning Meterials Term', 'service', 0, '83.0000', '83.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '83.0000', '', '83.0000', ''),
(58, 26, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', NULL, '15.0000', '15.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '15.0000', '', '15.0000', ''),
(59, 26, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(60, 27, 5, 'MHD-001', 'Tution Fee Per Term Morning (MHD)', 'service', 0, '525.0000', '750.0000', '1.0000', 1, '0.0000', 1, '0.0000', '30%', '225.0000', '525.0000', '', '750.0000', ''),
(61, 28, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(62, 29, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(63, 30, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(64, 30, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(65, 31, 29, 'Week-001', '1 week trail', 'service', NULL, '70.0000', '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000', ''),
(66, 32, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(69, 34, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '15.0000', '15.0000', '2.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30.0000', '', '15.0000', ''),
(70, 35, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '15.0000', '15.0000', '2.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30.0000', '', '15.0000', ''),
(71, 36, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', NULL, '15.0000', '15.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '15.0000', '', '15.0000', ''),
(72, 37, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', NULL, '15.0000', '15.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '15.0000', '', '15.0000', ''),
(73, 38, 29, 'Week-001', '1 week trail', 'service', NULL, '70.0000', '70.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70.0000', '', '70.0000', ''),
(74, 39, 17, 'SNACK-H001', 'Snack Fee Term Half Day (HD)', 'service', NULL, '50.0000', '50.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '50.0000', '', '50.0000', ''),
(75, 39, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '15.0000', '15.0000', '2.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30.0000', '', '15.0000', ''),
(80, 41, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(81, 41, 14, 'SNACK-F001', 'Snack Fee Term Full Day (FD)', 'service', NULL, '90.0000', '90.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '90.0000', '', '90.0000', ''),
(82, 41, 20, 'LUNCH-001', 'Lunch (Optional) Term', 'service', NULL, '150.0000', '150.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '150.0000', '', '150.0000', ''),
(83, 41, 23, 'LEAR-001', 'Learning Meterials Term', 'service', NULL, '110.0000', '110.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '110.0000', '', '110.0000', ''),
(84, 41, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', 0, '15.0000', '15.0000', '4.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '60.0000', '', '15.0000', ''),
(85, 42, 6, 'MHD-002', 'Tution Fee Per Semester Morning (MHD)', 'service', 0, '980.0000', '1400.0000', '1.0000', 1, '0.0000', 1, '0.0000', '30%', '420.0000', '980.0000', '', '1400.0000', ''),
(86, 42, 18, 'SNACK-H002', 'Snack Fee Semester Half Day (HD)', 'service', NULL, '100.0000', '100.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '100.0000', '', '100.0000', ''),
(87, 42, 26, 'UNIFORM-001', 'Uniform (1set)', 'standard', NULL, '15.0000', '15.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '15.0000', '', '15.0000', ''),
(88, 42, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', ''),
(89, 43, 11, 'FD-001', 'Tution Fee Per Term Full Day (FD)', 'service', 0, '650.0000', '1300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '50%', '650.0000', '650.0000', '', '1300.0000', ''),
(90, 43, 27, 'REGIS-001', 'Registration Fee (Pay One Time Only)', 'service', NULL, '300.0000', '300.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300.0000', '', '300.0000', '');

-- --------------------------------------------------------

--
-- Table structure for table `erp_sessions`
--

CREATE TABLE IF NOT EXISTS `erp_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_sessions`
--

INSERT INTO `erp_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('0d0603c85536a9a4040e30949d0102a4ce8b574d', '103.12.163.9', 1467282835, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238323533343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('108cb0623d252c7d52b361437acf959caef01fbe', '103.12.163.9', 1467275421, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237353335363b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1104150a2a591eac3413acb3fbff47169ed77429', '103.12.163.9', 1467266963, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236363635343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('1a105cd8a633d04c56ba296d55f1758b33035fab', '103.12.163.9', 1467608386, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373630383338363b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333533373739223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313436373539373432303b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a383a223130302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323031362d30352d30342031343a32343a3436223b),
('22d7ee492b0502f5aa04eb1558ef2262d0317975', '103.12.163.9', 1467268322, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236383030393b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('265fb4538ec3d29f65c30e5d50062391d96190a5', '103.12.163.9', 1467281892, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238313534393b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('27898deb85a586555b48116aa88e10263fe1ede7', '103.12.163.9', 1467273955, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237333232363b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2cf386f2e046384a06d7e52c32cea13d5ac0a6af', '103.12.163.9', 1467335455, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333353432343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('32c85385b457125e89ccbfae7cbbef095e946997', '103.12.163.9', 1467353497, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373335333439373b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333430393037223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3321ffeffb6e7c0b84944da908a100b30b0f84df', '103.12.163.9', 1467351956, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373335313837313b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333430393037223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('360248fdc5f99f450250179d2cd45f90cfcfee43', '103.12.163.9', 1467338320, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333383331383b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('36e256127e58dd69b23ed10ca75007fe7af076d5', '103.12.163.9', 1467344902, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373334343930323b),
('38b7f651ccd74c368289fcc2ec8fa0efc13ce9b8', '103.12.163.9', 1467278115, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237373934373b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('442d232da662f5a26470cf51cb6a407214064876', '103.12.163.9', 1467281262, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238313132353b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('474a3884411d8a07c624e47f239605936385e4d8', '103.12.163.9', 1467626469, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373632363436393b7265717565737465645f706167657c733a31333a2273616c65732f656469742f3431223b),
('476833ef9405c1fc69f099bf812e86331f9d290e', '103.12.163.9', 1467597494, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373539373439343b7265717565737465645f706167657c733a303a22223b),
('50abfeb2c937c29a05f2a3ee9927fd7c21f19ec3', '103.12.163.9', 1467597440, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373539373139373b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333533373739223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313436373539373432303b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a383a223130302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323031362d30352d30342031343a32343a3436223b),
('59609a9aef658a6fc0d4e2e24e9421b35ef1e599', '103.12.163.9', 1467685599, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373638353539393b),
('5b435d4e0145f30515e7c367aa0badd385c60ecb', '103.12.163.9', 1467603714, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373630333639303b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333533373739223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313436373539373432303b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a383a223130302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323031362d30352d30342031343a32343a3436223b),
('5c3468e0eef1ccb816b680cda8b18bd8233288fc', '103.12.163.9', 1467280284, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237393936323b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('5c35ca159b0b82bf098e69b5768aa7b230fa3a0c', '42.115.109.247', 1467353801, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373335333736353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333434393232223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313436373335333739303b),
('629cdde7d4ded5fc637a863e5fec474c09de3615', '103.12.163.9', 1467344882, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373334343838323b7265717565737465645f706167657c733a353a2273616c6573223b),
('62c19fedadeaa9ddd97d0b8852c0f5dcc46ea332', '103.12.163.9', 1467269774, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236393532313b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('64e37acd49ce287699212252b3675a2dafb81e29', '103.12.163.9', 1467274146, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237343134363b),
('650a28b2ab7ad7ec3ce84b93075661c1cb249997', '42.115.109.247', 1467686279, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373638363237383b7265717565737465645f706167657c733a303a22223b),
('6aaa9466382c7fb6cf7a2c0daab5a01303801726', '103.12.163.9', 1467355804, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373335353530383b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333430393037223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('710104440c43acb4d96743c507b53a6759bec8e8', '103.12.163.9', 1467269502, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236393231383b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('74c88331b305aa2e22ce4b27e71ef3c50d14f0c3', '103.12.163.9', 1467276506, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237363035353b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('81545a82d4d64a349a4f98e4549262159858b689', '103.12.163.9', 1467279944, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237393634363b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8198b4c1550768a5ab5734777fd2748ee327773e', '103.12.163.9', 1467279613, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237393234333b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('892cbde0a1c650651362ab5a6364bab0899137f1', '103.12.163.9', 1467271582, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237303634353b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('8a626b5d2a12b5a71956ab732709c02d07e4ec3b', '103.12.163.9', 1467522423, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373532323432333b),
('8c417e013849854cb0efe7a98f3e28a1ab25d47e', '103.12.163.9', 1467594111, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373539333834393b),
('962a595c12033324d0a0f986fa4ab2e5e08a4963', '103.12.163.9', 1467448469, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373434383436383b7265717565737465645f706167657c733a353a2273616c6573223b),
('976a632265bef77f00e4c5faee691ebe22450223', '103.12.163.9', 1467277530, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237373235323b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('9afc9c13f5664b39f13b073cfdccfeb71000ec34', '103.12.163.9', 1467337236, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333363738333b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('9ba7100204b5b2e7b02fbf1a7d4b7d13c1620c71', '103.12.163.9', 1467337776, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333373736333b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('9ee0be48959f1a4e1b3d7001165726a0d2aeee0f', '103.12.163.9', 1467344924, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373334343930333b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333430393037223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a33383a223c703e596f7520617265207375636365737366756c6c79206c6f6767656420696e2e3c2f703e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('a0da5358e490d301019dd03ce45c88340fd44cc7', '103.12.163.9', 1467281069, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238303732383b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('a51c9c945f4d529d5d85efca7cef459350732ff8', '103.12.163.9', 1467276894, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237363539343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('acebb120ecf02c7ca467e849307a0fabd1e073ab', '103.12.163.9', 1467335767, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333353736363b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bcc94cb396697a3e136c458f98f40f4857a26262', '103.12.163.9', 1467270185, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236393930393b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bdfe2bb9117f813fe2328f43bfb5ab540cde8a15', '103.12.163.9', 1467268344, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236383333313b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bf1c29e0532ce9dadf0d3238ec89d62f6b148dad', '103.12.163.9', 1467597494, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373539373439343b),
('bf8a53477f6c36b1c7d937ba9c60414f218d7bdb', '103.12.163.9', 1467334268, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333343236373b7265717565737465645f706167657c733a36313a227265706f7274732f70726f6669745f6c6f73732f323031362d30332d3031253230303025334130302f323031362d30372d303125323031372533413337223b),
('c2316e9091202cfa90fa241dd2bbe9edb50f3691', '103.12.163.9', 1467283081, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238323837373b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c498fdf99895cc466584aa617cf2486fd97e0eb4', '103.12.163.9', 1467280713, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238303333383b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('c4e76ec98630e26f79279d94cef9ad3a05c72085', '103.12.163.9', 1467340962, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373334303035333b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c50950656f46fc8211d1445e404e2d7d04dc6b26', '103.12.163.9', 1467270574, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237303233333b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('c70b53e283fe5b1ecf7be5c6ae16cba189a2b812', '103.12.163.9', 1467353606, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373335333630363b),
('c8fd724725e2bd80730d43d09f289d75a4680217', '103.12.163.9', 1467450774, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373435303737343b7265717565737465645f706167657c733a353a2273616c6573223b),
('cbf87022852f33aed1e3d866da5d074b9edaf807', '103.12.163.9', 1467277197, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237363930303b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b6d6573736167657c733a32333a2253616c65207375636365737366756c6c79206164646564223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('d34bf88590ed3da70c5f6b986128996f79760783', '103.12.163.9', 1467274145, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237343134353b7265717565737465645f706167657c733a353a2273616c6573223b),
('d50e6e35f7c49c960b1e04ac538f66235a6578ec', '103.12.163.9', 1467337720, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333373433323b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d65c3a530f13f9e42d0d413976cb319d7deb1d68', '103.12.163.9', 1467353605, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373335333630353b7265717565737465645f706167657c733a31353a2273797374656d5f73657474696e6773223b),
('d97d9f02e1b1c44bff7f1af1714c4fc15c2c13b9', '103.12.163.9', 1467468313, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373436383331333b),
('da84fe1f9a71e7b2b13705ed10afe5c68ca5592c', '103.12.163.9', 1467267401, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236373033313b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('db08446d857b8d94ee9a54501747c2fe72b44448', '103.12.163.9', 1467273054, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237313734353b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f736c6c737c693a313b),
('dfaf29047b1c8d0bdc6047315bdbf4b375105d56', '103.12.163.9', 1467335774, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333353736383b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e28858d7e0e7642bc1a656ee9268486e81289feb', '103.12.163.9', 1467604214, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373630343231343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333533373739223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313436373539373432303b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a383a223130302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323031362d30352d30342031343a32343a3436223b),
('e35f7ffa41dfb13a8d533b1eda714f7cf339f27b', '103.12.163.9', 1467506739, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373530363733393b),
('e5d51d355ad3ffcc44ab4459b1716bdccc8475fe', '103.12.163.9', 1467283237, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238333139343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e80fa42321ce64caf1dd500d620d63a40e1b6f87', '103.12.163.9', 1467277909, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373237373538313b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('eadd211d9ea1ba3629de49e04f28d80bd6b16547', '103.12.163.9', 1467336442, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333363038353b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('eb2fa03e8009fd63a1b960229b6ad0456a3b92c4', '103.12.163.9', 1467604909, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373630343636343b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333533373739223b6c6173745f69707c733a31343a2234322e3131352e3130392e323437223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313436373539373432303b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a383a223130302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323031362d30352d30342031343a32343a3436223b),
('ed99b431dec8564d8bfddf2ac71b0552d5178b3f', '103.12.163.9', 1467342358, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373334323334373b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f26954483cc70402e30a24b1330f7143401b3a8e', '103.12.163.9', 1467267908, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373236373632363b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f5ac06fd831b31d3fffd3a338bd22b47bcca190a', '103.12.163.9', 1467282500, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373238313933373b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637313930333736223b6c6173745f69707c733a31323a2234322e3131352e34322e3234223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f7fc263d458ef4f14b27cdd524016b07df147e22', '42.115.109.247', 1467340924, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373334303839363b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637333335343234223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fa73a1906cf5575f696c2721ef0c044596a40fb5', '103.12.163.9', 1467334267, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333343236373b),
('ff019c4c71b99444062aa32b9151e6783d41ed4f', '103.12.163.9', 1467336726, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373333363434393b6964656e746974797c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a32313a226f776e657240636c6f75646e65742e636f6d2e6b68223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231343637323532343333223b6c6173745f69707c733a31323a223130332e31322e3136332e39223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b766965775f72696768747c733a313a2230223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ff43ba5d307aab43f639a608bc6428bb99a0d3e7', '103.12.163.9', 1467685641, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373638353634313b);

-- --------------------------------------------------------

--
-- Table structure for table `erp_settings`
--

CREATE TABLE IF NOT EXISTS `erp_settings` (
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
  `convert_prefix` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_settings`
--

INSERT INTO `erp_settings` (`setting_id`, `logo`, `logo2`, `site_name`, `language`, `default_warehouse`, `accounting_method`, `default_currency`, `default_tax_rate`, `rows_per_page`, `version`, `default_tax_rate2`, `dateformat`, `sales_prefix`, `quote_prefix`, `purchase_prefix`, `transfer_prefix`, `delivery_prefix`, `payment_prefix`, `return_prefix`, `expense_prefix`, `transaction_prefix`, `item_addition`, `theme`, `product_serial`, `default_discount`, `product_discount`, `discount_method`, `tax1`, `tax2`, `overselling`, `restrict_user`, `restrict_calendar`, `timezone`, `iwidth`, `iheight`, `twidth`, `theight`, `watermark`, `reg_ver`, `allow_reg`, `reg_notification`, `auto_reg`, `protocol`, `mailpath`, `smtp_host`, `smtp_user`, `smtp_pass`, `smtp_port`, `smtp_crypto`, `corn`, `customer_group`, `default_email`, `mmode`, `bc_fix`, `auto_detect_barcode`, `captcha`, `reference_format`, `racks`, `attributes`, `product_expiry`, `purchase_decimals`, `decimals`, `qty_decimals`, `decimals_sep`, `thousands_sep`, `invoice_view`, `default_biller`, `envato_username`, `purchase_code`, `rtl`, `each_spent`, `ca_point`, `each_sale`, `sa_point`, `update`, `sac`, `display_all_products`, `display_symbol`, `symbol`, `item_slideshow`, `barcode_separator`, `remove_expired`, `sale_payment_prefix`, `purchase_payment_prefix`, `sale_loan_prefix`, `auto_print`, `returnp_prefix`, `alert_day`, `convert_prefix`) VALUES
(1, 'logo2.png', 'IMG_7862_-_Copy_(2).JPG', 'Kinderland', 'english', 1, 2, 'USD', 1, 10, '3.0.2', 1, 5, 'SALE', 'QUOTE', 'PO', 'TR', 'DO', 'IPAY', 'RE', 'EX', 'J', 1, 'default', 0, 1, 1, 1, 1, 1, 1, 1, 0, 'Asia/Phnom_Penh', 800, 800, 60, 60, 0, 0, 0, 0, NULL, 'mail', '/usr/sbin/sendmail', 'pop.gmail.com', 'iclouderp@gmail.com', 'jEFTM4T63AiQ9dsidxhPKt9CIg4HQjCN58n/RW9vmdC/UDXCzRLR469ziZ0jjpFlbOg43LyoSmpJLBkcAHh0Yw==', '25', NULL, NULL, 5, 'iclouderp@gmail.com', 0, 4, 0, 0, 1, 1, 1, 0, 3, 2, 2, '.', ',', 0, 3, 'cloud-net', '53d35644-a36e-45cd-b7ee-8dde3a08f83d', 0, '10.0000', 1, '100.0000', 1, 0, 0, 0, NULL, NULL, 0, '_', 0, 'RV', 'PV', 'LOAN', 0, NULL, 7, 'CON');

-- --------------------------------------------------------

--
-- Table structure for table `erp_skrill`
--

CREATE TABLE IF NOT EXISTS `erp_skrill` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL DEFAULT 'testaccount2@moneybookers.com',
  `secret_word` varchar(20) NOT NULL DEFAULT 'mbtest',
  `skrill_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_skrill`
--

INSERT INTO `erp_skrill` (`id`, `active`, `account_email`, `secret_word`, `skrill_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 0, 'laykiry@yahoo.com', 'mbtest', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Table structure for table `erp_subcategories`
--

CREATE TABLE IF NOT EXISTS `erp_subcategories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_subcategories`
--

INSERT INTO `erp_subcategories` (`id`, `category_id`, `code`, `name`, `image`) VALUES
(1, 2, '011', 'Uniform', NULL),
(2, 2, '012', 'Sport', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_suspended`
--

CREATE TABLE IF NOT EXISTS `erp_suspended` (
  `id` mediumint(8) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `floor` varchar(20) DEFAULT '0',
  `ppl_number` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_suspended_bills`
--

CREATE TABLE IF NOT EXISTS `erp_suspended_bills` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
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
  `suspend_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_suspended_items`
--

CREATE TABLE IF NOT EXISTS `erp_suspended_items` (
  `id` int(11) NOT NULL,
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
  `product_noted` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_tax_rates`
--

CREATE TABLE IF NOT EXISTS `erp_tax_rates` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `rate` decimal(12,4) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_tax_rates`
--

INSERT INTO `erp_tax_rates` (`id`, `name`, `code`, `rate`, `type`) VALUES
(1, 'No Tax', 'NT', '0.0000', '2'),
(2, 'VAT @10%', 'VAT10', '10.0000', '1'),
(3, 'GST @6%', 'GST', '6.0000', '1'),
(4, 'VAT @20%', 'VT20', '20.0000', '1'),
(5, 'TAX @10%', 'TAX', '10.0000', '1');

-- --------------------------------------------------------

--
-- Table structure for table `erp_transfers`
--

CREATE TABLE IF NOT EXISTS `erp_transfers` (
  `id` int(11) NOT NULL,
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
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_transfer_items`
--

CREATE TABLE IF NOT EXISTS `erp_transfer_items` (
  `id` int(11) NOT NULL,
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
  `warehouse_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_users`
--

CREATE TABLE IF NOT EXISTS `erp_users` (
  `id` int(11) unsigned NOT NULL,
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
  `phone` varchar(20) DEFAULT NULL,
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
  `allow_discount` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_users`
--

INSERT INTO `erp_users` (`id`, `last_ip_address`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `avatar`, `gender`, `group_id`, `warehouse_id`, `biller_id`, `company_id`, `show_cost`, `show_price`, `award_points`, `view_right`, `edit_right`, `allow_discount`) VALUES
(1, 0x3130332e31322e3136332e39, 0x0000, 'owner', 'f536eef28fd507c1fe24273c65171af8d4299d14', NULL, 'owner@cloudnet.com.kh', NULL, NULL, NULL, '8a5d98b76e7cad45a8efc6c8c4eda7cdd1ab04a5', 1351661704, 1467597350, 1, 'Owner', 'Owner', 'ABC Shop', '012345678', NULL, 'male', 1, NULL, NULL, NULL, 0, 0, 1607, 0, 0, 0),
(2, 0x34322e3131352e31312e313835, 0x34322e3131352e31312e313835, 'manager', '2732eb091ddcefb745a940450ec21250e2fee44a', NULL, 'manager@cloudnet.com.kh', NULL, NULL, NULL, NULL, 1445470525, 1445470670, 1, 'manager', 'manager', 'ABC Shop', '023 634 6666', NULL, 'male', 2, 1, 3, NULL, 0, 0, 103, 0, 0, 0),
(4, 0x3139322e3136382e312e3138, 0x3139322e3136382e312e313939, 'test', 'f6ce3fa3548133f371d4d5c69a941bb22c6420c9', NULL, 'test@test.com', NULL, NULL, NULL, NULL, 1461114995, 1462253731, 1, 'test', 'test', 'test', '092581212', NULL, 'male', 5, NULL, 3, NULL, NULL, NULL, 26, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `erp_user_logins`
--

CREATE TABLE IF NOT EXISTS `erp_user_logins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_user_logins`
--

INSERT INTO `erp_user_logins` (`id`, `user_id`, `company_id`, `ip_address`, `login`, `time`) VALUES
(1, 1, NULL, 0x34322e3131352e34322e3234, 'owner@cloudnet.com.kh', '2016-06-29 04:40:16'),
(2, 1, NULL, 0x34322e3131352e34322e3234, 'owner@cloudnet.com.kh', '2016-06-29 08:52:56'),
(3, 1, NULL, 0x3130332e31322e3136332e39, 'owner@cloudnet.com.kh', '2016-06-30 02:07:13'),
(4, 1, NULL, 0x3130332e31322e3136332e39, 'owner@cloudnet.com.kh', '2016-07-01 01:10:24'),
(5, 1, NULL, 0x34322e3131352e3130392e323437, 'owner@cloudnet.com.kh', '2016-07-01 02:41:47'),
(6, 1, NULL, 0x3130332e31322e3136332e39, 'owner@cloudnet.com.kh', '2016-07-01 03:48:42'),
(7, 1, NULL, 0x34322e3131352e3130392e323437, 'owner@cloudnet.com.kh', '2016-07-01 06:16:19'),
(8, 1, NULL, 0x3130332e31322e3136332e39, 'owner@cloudnet.com.kh', '2016-07-04 01:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `erp_variants`
--

CREATE TABLE IF NOT EXISTS `erp_variants` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erp_warehouses`
--

CREATE TABLE IF NOT EXISTS `erp_warehouses` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `map` varchar(255) DEFAULT NULL,
  `phone` varchar(55) DEFAULT NULL,
  `email` varchar(55) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_warehouses`
--

INSERT INTO `erp_warehouses` (`id`, `code`, `name`, `address`, `map`, `phone`, `email`) VALUES
(1, 'WH1', 'Warehouse 1', '<p>Phnom Penh</p>', NULL, '089333255', 'icloud-erp@gmail.com'),
(2, 'WH2', 'Warehouse 2', '<p>Siem Reap</p>', NULL, '016282825', 'icloud-erp@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `erp_warehouses_products`
--

CREATE TABLE IF NOT EXISTS `erp_warehouses_products` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `erp_warehouses_products`
--

INSERT INTO `erp_warehouses_products` (`id`, `product_id`, `warehouse_id`, `quantity`, `rack`) VALUES
(8, 5, 1, '0.0000', NULL),
(9, 5, 2, '0.0000', NULL),
(10, 6, 1, '0.0000', NULL),
(11, 6, 2, '0.0000', NULL),
(12, 7, 1, '0.0000', NULL),
(13, 7, 2, '0.0000', NULL),
(14, 8, 1, '0.0000', NULL),
(15, 8, 2, '0.0000', NULL),
(16, 9, 1, '0.0000', NULL),
(17, 9, 2, '0.0000', NULL),
(18, 10, 1, '0.0000', NULL),
(19, 10, 2, '0.0000', NULL),
(20, 11, 1, '0.0000', NULL),
(21, 11, 2, '0.0000', NULL),
(22, 12, 1, '0.0000', NULL),
(23, 12, 2, '0.0000', NULL),
(24, 13, 1, '0.0000', NULL),
(25, 13, 2, '0.0000', NULL),
(26, 14, 1, '0.0000', NULL),
(27, 14, 2, '0.0000', NULL),
(28, 15, 1, '0.0000', NULL),
(29, 15, 2, '0.0000', NULL),
(30, 16, 1, '0.0000', NULL),
(31, 16, 2, '0.0000', NULL),
(32, 17, 1, '0.0000', NULL),
(33, 17, 2, '0.0000', NULL),
(34, 18, 1, '0.0000', NULL),
(35, 18, 2, '0.0000', NULL),
(36, 19, 1, '0.0000', NULL),
(37, 19, 2, '0.0000', NULL),
(38, 20, 1, '0.0000', NULL),
(39, 20, 2, '0.0000', NULL),
(40, 21, 1, '0.0000', NULL),
(41, 21, 2, '0.0000', NULL),
(42, 22, 1, '0.0000', NULL),
(43, 22, 2, '0.0000', NULL),
(44, 23, 1, '0.0000', NULL),
(45, 23, 2, '0.0000', NULL),
(46, 24, 1, '0.0000', NULL),
(47, 24, 2, '0.0000', NULL),
(48, 25, 1, '0.0000', NULL),
(49, 25, 2, '0.0000', NULL),
(50, 26, 1, '-19.0000', NULL),
(51, 26, 2, '0.0000', NULL),
(52, 27, 1, '0.0000', NULL),
(53, 27, 2, '0.0000', NULL),
(54, 28, 1, '0.0000', NULL),
(55, 28, 2, '0.0000', NULL),
(56, 29, 1, '0.0000', NULL),
(57, 29, 2, '0.0000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `erp_warehouses_products_variants`
--

CREATE TABLE IF NOT EXISTS `erp_warehouses_products_variants` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `erp_account_settings`
--
ALTER TABLE `erp_account_settings`
  ADD PRIMARY KEY (`id`,`biller_id`);

--
-- Indexes for table `erp_adjustments`
--
ALTER TABLE `erp_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_bom`
--
ALTER TABLE `erp_bom`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_bom_items`
--
ALTER TABLE `erp_bom_items`
  ADD PRIMARY KEY (`id`), ADD KEY `transfer_id` (`bom_id`), ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `erp_calendar`
--
ALTER TABLE `erp_calendar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_captcha`
--
ALTER TABLE `erp_captcha`
  ADD PRIMARY KEY (`captcha_id`), ADD KEY `word` (`word`);

--
-- Indexes for table `erp_categories`
--
ALTER TABLE `erp_categories`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_combine_items`
--
ALTER TABLE `erp_combine_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_combo_items`
--
ALTER TABLE `erp_combo_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_companies`
--
ALTER TABLE `erp_companies`
  ADD PRIMARY KEY (`id`), ADD KEY `group_id` (`group_id`), ADD KEY `group_id_2` (`group_id`);

--
-- Indexes for table `erp_convert`
--
ALTER TABLE `erp_convert`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_convert_items`
--
ALTER TABLE `erp_convert_items`
  ADD PRIMARY KEY (`id`), ADD KEY `transfer_id` (`convert_id`), ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `erp_costing`
--
ALTER TABLE `erp_costing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_currencies`
--
ALTER TABLE `erp_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_customer_groups`
--
ALTER TABLE `erp_customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_date_format`
--
ALTER TABLE `erp_date_format`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_deliveries`
--
ALTER TABLE `erp_deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_deposits`
--
ALTER TABLE `erp_deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_expenses`
--
ALTER TABLE `erp_expenses`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`) USING BTREE;

--
-- Indexes for table `erp_gift_cards`
--
ALTER TABLE `erp_gift_cards`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `card_no` (`card_no`);

--
-- Indexes for table `erp_gl_charts`
--
ALTER TABLE `erp_gl_charts`
  ADD PRIMARY KEY (`accountcode`), ADD KEY `AccountCode` (`accountcode`) USING BTREE, ADD KEY `AccountName` (`accountname`) USING BTREE;

--
-- Indexes for table `erp_gl_sections`
--
ALTER TABLE `erp_gl_sections`
  ADD PRIMARY KEY (`sectionid`);

--
-- Indexes for table `erp_gl_trans`
--
ALTER TABLE `erp_gl_trans`
  ADD PRIMARY KEY (`tran_id`), ADD KEY `Account` (`account_code`) USING BTREE, ADD KEY `TranDate` (`tran_date`) USING BTREE, ADD KEY `TypeNo` (`tran_no`) USING BTREE, ADD KEY `Type_and_Number` (`tran_type`,`tran_no`) USING BTREE;

--
-- Indexes for table `erp_groups`
--
ALTER TABLE `erp_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_loans`
--
ALTER TABLE `erp_loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_login_attempts`
--
ALTER TABLE `erp_login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_marchine`
--
ALTER TABLE `erp_marchine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_marchine_logs`
--
ALTER TABLE `erp_marchine_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_notifications`
--
ALTER TABLE `erp_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_order_ref`
--
ALTER TABLE `erp_order_ref`
  ADD PRIMARY KEY (`ref_id`);

--
-- Indexes for table `erp_payments`
--
ALTER TABLE `erp_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_paypal`
--
ALTER TABLE `erp_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_permissions`
--
ALTER TABLE `erp_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_pos_register`
--
ALTER TABLE `erp_pos_register`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_pos_settings`
--
ALTER TABLE `erp_pos_settings`
  ADD PRIMARY KEY (`pos_id`);

--
-- Indexes for table `erp_products`
--
ALTER TABLE `erp_products`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `code` (`code`), ADD KEY `category_id` (`category_id`), ADD KEY `id` (`id`), ADD KEY `id_2` (`id`), ADD KEY `category_id_2` (`category_id`);

--
-- Indexes for table `erp_product_photos`
--
ALTER TABLE `erp_product_photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_product_variants`
--
ALTER TABLE `erp_product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_purchases`
--
ALTER TABLE `erp_purchases`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`) USING BTREE;

--
-- Indexes for table `erp_purchase_items`
--
ALTER TABLE `erp_purchase_items`
  ADD PRIMARY KEY (`id`), ADD KEY `purchase_id` (`purchase_id`), ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `erp_quotes`
--
ALTER TABLE `erp_quotes`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_quote_items`
--
ALTER TABLE `erp_quote_items`
  ADD PRIMARY KEY (`id`), ADD KEY `quote_id` (`quote_id`), ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `erp_return_items`
--
ALTER TABLE `erp_return_items`
  ADD PRIMARY KEY (`id`), ADD KEY `sale_id` (`sale_id`), ADD KEY `product_id` (`product_id`), ADD KEY `product_id_2` (`product_id`,`sale_id`), ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `erp_return_purchases`
--
ALTER TABLE `erp_return_purchases`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_return_purchase_items`
--
ALTER TABLE `erp_return_purchase_items`
  ADD PRIMARY KEY (`id`), ADD KEY `purchase_id` (`purchase_id`), ADD KEY `product_id` (`product_id`), ADD KEY `product_id_2` (`product_id`,`purchase_id`), ADD KEY `purchase_id_2` (`purchase_id`,`product_id`);

--
-- Indexes for table `erp_return_sales`
--
ALTER TABLE `erp_return_sales`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_sales`
--
ALTER TABLE `erp_sales`
  ADD PRIMARY KEY (`id`,`surcharge`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_sale_dev_items`
--
ALTER TABLE `erp_sale_dev_items`
  ADD PRIMARY KEY (`id`), ADD KEY `sale_id` (`sale_id`), ADD KEY `product_id` (`product_id`), ADD KEY `product_id_2` (`product_id`,`sale_id`), ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `erp_sale_items`
--
ALTER TABLE `erp_sale_items`
  ADD PRIMARY KEY (`id`), ADD KEY `sale_id` (`sale_id`), ADD KEY `product_id` (`product_id`), ADD KEY `product_id_2` (`product_id`,`sale_id`), ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `erp_sessions`
--
ALTER TABLE `erp_sessions`
  ADD PRIMARY KEY (`id`), ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `erp_settings`
--
ALTER TABLE `erp_settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `erp_skrill`
--
ALTER TABLE `erp_skrill`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_subcategories`
--
ALTER TABLE `erp_subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_suspended`
--
ALTER TABLE `erp_suspended`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_suspended_bills`
--
ALTER TABLE `erp_suspended_bills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_suspended_items`
--
ALTER TABLE `erp_suspended_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_tax_rates`
--
ALTER TABLE `erp_tax_rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_transfers`
--
ALTER TABLE `erp_transfers`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_transfer_items`
--
ALTER TABLE `erp_transfer_items`
  ADD PRIMARY KEY (`id`), ADD KEY `transfer_id` (`transfer_id`), ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `erp_users`
--
ALTER TABLE `erp_users`
  ADD PRIMARY KEY (`id`), ADD KEY `group_id` (`group_id`,`warehouse_id`,`biller_id`), ADD KEY `group_id_2` (`group_id`,`company_id`);

--
-- Indexes for table `erp_user_logins`
--
ALTER TABLE `erp_user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_variants`
--
ALTER TABLE `erp_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_warehouses`
--
ALTER TABLE `erp_warehouses`
  ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `erp_warehouses_products`
--
ALTER TABLE `erp_warehouses_products`
  ADD PRIMARY KEY (`id`), ADD KEY `product_id` (`product_id`), ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Indexes for table `erp_warehouses_products_variants`
--
ALTER TABLE `erp_warehouses_products_variants`
  ADD PRIMARY KEY (`id`), ADD KEY `option_id` (`option_id`), ADD KEY `product_id` (`product_id`), ADD KEY `warehouse_id` (`warehouse_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `erp_adjustments`
--
ALTER TABLE `erp_adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_bom`
--
ALTER TABLE `erp_bom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_bom_items`
--
ALTER TABLE `erp_bom_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_calendar`
--
ALTER TABLE `erp_calendar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_captcha`
--
ALTER TABLE `erp_captcha`
  MODIFY `captcha_id` bigint(13) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `erp_categories`
--
ALTER TABLE `erp_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `erp_combine_items`
--
ALTER TABLE `erp_combine_items`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_combo_items`
--
ALTER TABLE `erp_combo_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_companies`
--
ALTER TABLE `erp_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=471;
--
-- AUTO_INCREMENT for table `erp_convert`
--
ALTER TABLE `erp_convert`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_convert_items`
--
ALTER TABLE `erp_convert_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_costing`
--
ALTER TABLE `erp_costing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT for table `erp_currencies`
--
ALTER TABLE `erp_currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `erp_customer_groups`
--
ALTER TABLE `erp_customer_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `erp_date_format`
--
ALTER TABLE `erp_date_format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `erp_deliveries`
--
ALTER TABLE `erp_deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT for table `erp_deposits`
--
ALTER TABLE `erp_deposits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `erp_expenses`
--
ALTER TABLE `erp_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_gift_cards`
--
ALTER TABLE `erp_gift_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_gl_trans`
--
ALTER TABLE `erp_gl_trans`
  MODIFY `tran_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=284;
--
-- AUTO_INCREMENT for table `erp_groups`
--
ALTER TABLE `erp_groups`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `erp_loans`
--
ALTER TABLE `erp_loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_login_attempts`
--
ALTER TABLE `erp_login_attempts`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_marchine`
--
ALTER TABLE `erp_marchine`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_marchine_logs`
--
ALTER TABLE `erp_marchine_logs`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_notifications`
--
ALTER TABLE `erp_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `erp_order_ref`
--
ALTER TABLE `erp_order_ref`
  MODIFY `ref_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `erp_payments`
--
ALTER TABLE `erp_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `erp_permissions`
--
ALTER TABLE `erp_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `erp_pos_register`
--
ALTER TABLE `erp_pos_register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `erp_products`
--
ALTER TABLE `erp_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `erp_product_photos`
--
ALTER TABLE `erp_product_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_product_variants`
--
ALTER TABLE `erp_product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_purchases`
--
ALTER TABLE `erp_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_purchase_items`
--
ALTER TABLE `erp_purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `erp_quotes`
--
ALTER TABLE `erp_quotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_quote_items`
--
ALTER TABLE `erp_quote_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_return_items`
--
ALTER TABLE `erp_return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `erp_return_purchases`
--
ALTER TABLE `erp_return_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_return_purchase_items`
--
ALTER TABLE `erp_return_purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_return_sales`
--
ALTER TABLE `erp_return_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `erp_sales`
--
ALTER TABLE `erp_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `erp_sale_dev_items`
--
ALTER TABLE `erp_sale_dev_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_sale_items`
--
ALTER TABLE `erp_sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `erp_subcategories`
--
ALTER TABLE `erp_subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `erp_suspended`
--
ALTER TABLE `erp_suspended`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_suspended_bills`
--
ALTER TABLE `erp_suspended_bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_suspended_items`
--
ALTER TABLE `erp_suspended_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_tax_rates`
--
ALTER TABLE `erp_tax_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `erp_transfers`
--
ALTER TABLE `erp_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_transfer_items`
--
ALTER TABLE `erp_transfer_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_users`
--
ALTER TABLE `erp_users`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `erp_user_logins`
--
ALTER TABLE `erp_user_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `erp_variants`
--
ALTER TABLE `erp_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `erp_warehouses`
--
ALTER TABLE `erp_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `erp_warehouses_products`
--
ALTER TABLE `erp_warehouses_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT for table `erp_warehouses_products_variants`
--
ALTER TABLE `erp_warehouses_products_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
