# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.23)
# Database: raichu_development
# Generation Time: 2018-10-05 02:52:56 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table addon_bank_branches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `addon_bank_branches`;

CREATE TABLE `addon_bank_branches` (
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `area` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `serial` smallint(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_fix` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bank_serial` smallint(6) DEFAULT NULL,
  `is_hide` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_addon_bank_branches_on_area_and_serial_and_bank_serial` (`area`,`serial`,`bank_serial`),
  KEY `index_addon_bank_branches_on_kind` (`kind`),
  KEY `index_addon_bank_branches_on_area` (`area`),
  KEY `index_addon_bank_branches_on_status` (`status`),
  KEY `index_addon_bank_branches_on_serial` (`serial`),
  KEY `index_addon_bank_branches_on_bank_serial` (`bank_serial`),
  KEY `index_addon_bank_branches_on_is_hide` (`is_hide`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='銀行分行列表';



# Dump of table admin_messages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_messages`;

CREATE TABLE `admin_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL,
  `serial` varchar(30) DEFAULT NULL,
  `message` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_messages_on_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table admin_receipts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_receipts`;

CREATE TABLE `admin_receipts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `manager_id` int(10) unsigned DEFAULT NULL,
  `serial` varchar(30) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `ori_twd_amount` decimal(16,0) DEFAULT '0' COMMENT '原加值金額',
  `twd_amount` decimal(16,0) DEFAULT '0' COMMENT '剩餘加值金額',
  `vendor` varchar(20) DEFAULT NULL,
  `memo` text,
  `trans_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `receipt_amount` decimal(12,0) DEFAULT '0' COMMENT '發票金額',
  `receipt_serial` varchar(255) DEFAULT NULL COMMENT '發票號碼',
  `receive_amount` decimal(16,0) DEFAULT '0' COMMENT '收款金額',
  PRIMARY KEY (`id`),
  KEY `index_admin_receipts_on_manager_id` (`manager_id`),
  KEY `index_admin_receipts_on_serial` (`serial`),
  KEY `index_admin_receipts_on_kind` (`kind`),
  KEY `index_admin_receipts_on_status` (`status`),
  KEY `index_admin_receipts_on_vendor` (`vendor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='會計收款紀錄(ttcode..)';



# Dump of table admin_transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_transactions`;

CREATE TABLE `admin_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `relation_user_id` bigint(20) DEFAULT NULL COMMENT '關聯資料user_id',
  `kind` int(11) NOT NULL COMMENT '分類',
  `info` text COMMENT '資訊',
  `memo` text COMMENT '備註',
  `manager_a_id` tinyint(4) DEFAULT '0' COMMENT '管理者a',
  `manager_b_id` tinyint(4) DEFAULT '0' COMMENT '管理者b',
  `approved_at` datetime DEFAULT NULL COMMENT '管理者b審核時間',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table alln_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alln_curvies`;

CREATE TABLE `alln_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_alln_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_alln_curvies_on_ati` (`ati`),
  KEY `index_alln_curvies_on_close_oid` (`close_oid`),
  KEY `index_alln_curvies_on_kind` (`kind`),
  KEY `index_alln_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table alln_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alln_invoices`;

CREATE TABLE `alln_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_alln_invoices_on_serial` (`serial`),
  KEY `index_alln_invoices_on_height` (`height`),
  KEY `index_alln_invoices_on_kind` (`kind`),
  KEY `index_alln_invoices_on_order_kind` (`order_kind`),
  KEY `index_alln_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_alln_invoices_on_relation_id` (`relation_id`),
  KEY `index_alln_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_alln_invoices_on_status` (`status`),
  KEY `index_alln_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_alln_invoices_on_tindex` (`tindex`),
  KEY `index_alln_invoices_on_txid` (`txid`),
  KEY `index_alln_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table alln_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alln_order_matches`;

CREATE TABLE `alln_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_alln_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_alln_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_alln_order_matches_on_kind` (`kind`),
  KEY `index_alln_order_matches_on_m_ati` (`m_ati`),
  KEY `index_alln_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_alln_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table alln_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alln_orders`;

CREATE TABLE `alln_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_alln_orders_on_is_buy` (`is_buy`),
  KEY `index_alln_orders_on_is_market` (`is_market`),
  KEY `index_alln_orders_on_receipt_id` (`receipt_id`),
  KEY `index_alln_orders_on_refund_kind` (`refund_kind`),
  KEY `index_alln_orders_on_status` (`status`),
  KEY `index_alln_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table alln_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alln_send_invoices`;

CREATE TABLE `alln_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_alln_send_invoices_on_height` (`height`),
  KEY `index_alln_send_invoices_on_kind` (`kind`),
  KEY `index_alln_send_invoices_on_status` (`status`),
  KEY `index_alln_send_invoices_on_tindex` (`tindex`),
  KEY `index_alln_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table announcements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `announcements`;

CREATE TABLE `announcements` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '狀態',
  `kind` int(11) NOT NULL COMMENT '分類ID',
  `subtitle` varchar(255) DEFAULT NULL,
  `title_cn` varchar(255) DEFAULT NULL,
  `subtitle_cn` varchar(255) DEFAULT NULL,
  `content_cn` text,
  `title_en` varchar(255) DEFAULT NULL,
  `subtitle_en` varchar(255) DEFAULT NULL,
  `content_en` text,
  PRIMARY KEY (`id`),
  KEY `index_announcements_on_kind` (`kind`),
  KEY `index_announcements_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ar_internal_metadata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ar_internal_metadata`;

CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;

INSERT INTO `ar_internal_metadata` (`key`, `value`, `created_at`, `updated_at`)
VALUES
	('environment','development','2018-08-08 04:29:06','2018-08-08 04:29:06');

/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bcd_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_curvies`;

CREATE TABLE `bcd_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(16,0) NOT NULL DEFAULT '0',
  `close` decimal(16,0) NOT NULL DEFAULT '0',
  `high` decimal(16,0) NOT NULL DEFAULT '0',
  `low` decimal(16,0) NOT NULL DEFAULT '0',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bcd_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_bcd_curvies_on_ati` (`ati`),
  KEY `index_bcd_curvies_on_close_oid` (`close_oid`),
  KEY `index_bcd_curvies_on_kind` (`kind`),
  KEY `index_bcd_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bcd_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_invoices`;

CREATE TABLE `bcd_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '原始帳號數量(必填)',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(16,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bcd_invoices_on_serial` (`serial`),
  KEY `index_bcd_invoices_on_height` (`height`),
  KEY `index_bcd_invoices_on_kind` (`kind`),
  KEY `index_bcd_invoices_on_order_kind` (`order_kind`),
  KEY `index_bcd_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_bcd_invoices_on_relation_id` (`relation_id`),
  KEY `index_bcd_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_bcd_invoices_on_status` (`status`),
  KEY `index_bcd_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_bcd_invoices_on_tindex` (`tindex`),
  KEY `index_bcd_invoices_on_txid` (`txid`),
  KEY `index_bcd_invoices_on_user_id` (`user_id`),
  KEY `index_bcd_invoices_on_wallet` (`wallet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='bcd帳';



# Dump of table bcd_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_order_matches`;

CREATE TABLE `bcd_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_bcd_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_bcd_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_bcd_order_matches_on_kind` (`kind`),
  KEY `index_bcd_order_matches_on_m_ati` (`m_ati`),
  KEY `index_bcd_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_bcd_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bcd_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_orders`;

CREATE TABLE `bcd_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `damount` decimal(16,0) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_bcd_orders_on_is_buy` (`is_buy`),
  KEY `index_bcd_orders_on_is_market` (`is_market`),
  KEY `index_bcd_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bcd_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bcd_orders_on_status` (`status`),
  KEY `index_bcd_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bcd_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_send_invoices`;

CREATE TABLE `bcd_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bcd_send_invoices_on_height` (`height`),
  KEY `index_bcd_send_invoices_on_kind` (`kind`),
  KEY `index_bcd_send_invoices_on_status` (`status`),
  KEY `index_bcd_send_invoices_on_tindex` (`tindex`),
  KEY `index_bcd_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table bcd_send_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_send_wallets`;

CREATE TABLE `bcd_send_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bcd_send_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber發送用的錢包';



# Dump of table bcd_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bcd_wallets`;

CREATE TABLE `bcd_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(62) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bcd_wallets_on_wallet` (`wallet`),
  KEY `index_bcd_wallets_on_status` (`status`),
  KEY `index_bcd_wallets_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比特幣錢包';



# Dump of table bch_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_curvies`;

CREATE TABLE `bch_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(16,0) NOT NULL DEFAULT '0',
  `close` decimal(16,0) NOT NULL DEFAULT '0',
  `high` decimal(16,0) NOT NULL DEFAULT '0',
  `low` decimal(16,0) NOT NULL DEFAULT '0',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bch_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_bch_curvies_on_ati` (`ati`),
  KEY `index_bch_curvies_on_close_oid` (`close_oid`),
  KEY `index_bch_curvies_on_kind` (`kind`),
  KEY `index_bch_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bch_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_invoices`;

CREATE TABLE `bch_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '原始帳號數量(必填)',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(16,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bch_invoices_on_serial` (`serial`),
  KEY `index_bch_invoices_on_kind` (`kind`),
  KEY `index_bch_invoices_on_relation_id` (`relation_id`),
  KEY `index_bch_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_bch_invoices_on_order_kind` (`order_kind`),
  KEY `index_bch_invoices_on_status` (`status`),
  KEY `index_bch_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_bch_invoices_on_tindex` (`tindex`),
  KEY `index_bch_invoices_on_txid` (`txid`),
  KEY `index_bch_invoices_on_user_id` (`user_id`),
  KEY `index_bch_invoices_on_wallet` (`wallet`),
  KEY `index_bch_invoices_on_height` (`height`),
  KEY `index_bch_invoices_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='bch帳';



# Dump of table bch_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_order_matches`;

CREATE TABLE `bch_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_bch_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_bch_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_bch_order_matches_on_m_ati` (`m_ati`),
  KEY `index_bch_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_bch_order_matches_on_s_user_id` (`s_user_id`),
  KEY `index_bch_order_matches_on_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bch_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_orders`;

CREATE TABLE `bch_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `damount` decimal(16,0) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_bch_orders_on_is_buy` (`is_buy`),
  KEY `index_bch_orders_on_is_market` (`is_market`),
  KEY `index_bch_orders_on_status` (`status`),
  KEY `index_bch_orders_on_user_id` (`user_id`),
  KEY `index_bch_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bch_orders_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bch_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_send_invoices`;

CREATE TABLE `bch_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bch_send_invoices_on_kind` (`kind`),
  KEY `index_bch_send_invoices_on_status` (`status`),
  KEY `index_bch_send_invoices_on_txid` (`txid`),
  KEY `index_bch_send_invoices_on_tindex` (`tindex`),
  KEY `index_bch_send_invoices_on_height` (`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table bch_send_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_send_wallets`;

CREATE TABLE `bch_send_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bch_send_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber發送用的錢包';



# Dump of table bch_usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_usdt_order_matches`;

CREATE TABLE `bch_usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方bch異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方usdt異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方bch異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方usdt異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BCH)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BCH)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BCH)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BCH)',
  PRIMARY KEY (`id`),
  KEY `index_bch_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_bch_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_bch_usdt_order_matches_on_kind` (`kind`),
  KEY `index_bch_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_bch_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_bch_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bch_usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_usdt_orders`;

CREATE TABLE `bch_usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BCH原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BCH已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BCH尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BCH手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 USDT_BCH',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BCH)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(BCH)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_bch_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_bch_usdt_orders_on_is_market` (`is_market`),
  KEY `index_bch_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bch_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bch_usdt_orders_on_status` (`status`),
  KEY `index_bch_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bch_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bch_wallets`;

CREATE TABLE `bch_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(62) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bch_wallets_on_wallet` (`wallet`),
  KEY `index_bch_wallets_on_status` (`status`),
  KEY `index_bch_wallets_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比特幣錢包';



# Dump of table bito_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_curvies`;

CREATE TABLE `bito_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bito_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_bito_curvies_on_ati` (`ati`),
  KEY `index_bito_curvies_on_close_oid` (`close_oid`),
  KEY `index_bito_curvies_on_kind` (`kind`),
  KEY `index_bito_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_eth_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_eth_order_matches`;

CREATE TABLE `bito_eth_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方bito異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方eth異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方bito異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方eth異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `match_id` varchar(128) DEFAULT NULL COMMENT 'matching engine產生的ID',
  `c_bito_sfee` decimal(60,0) NOT NULL DEFAULT '0' COMMENT '使用BITO付出手續費',
  `c_twd_sfee` decimal(60,0) NOT NULL DEFAULT '0' COMMENT 'TWD等值手續費',
  `bito_sfee` decimal(60,0) NOT NULL DEFAULT '0' COMMENT '使用BITO付出手續費',
  `twd_sfee` decimal(60,0) NOT NULL DEFAULT '0' COMMENT 'TWD等值手續費',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bito_eth_order_matches_on_match_id` (`match_id`),
  KEY `index_bito_eth_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_bito_eth_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_bito_eth_order_matches_on_kind` (`kind`),
  KEY `index_bito_eth_order_matches_on_m_ati` (`m_ati`),
  KEY `index_bito_eth_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_bito_eth_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_eth_order_u_u_ids
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_eth_order_u_u_ids`;

CREATE TABLE `bito_eth_order_u_u_ids` (
  `id` char(36) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 ETH_BITO',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  `bito_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用BITO付出手續費',
  `event_id` char(36) DEFAULT NULL COMMENT '建立此order的event id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bito_eth_orders_on_event_id` (`event_id`),
  KEY `index_bito_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_bito_eth_orders_on_is_market` (`is_market`),
  KEY `index_bito_eth_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bito_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bito_eth_orders_on_status` (`status`),
  KEY `index_bito_eth_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_eth_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_eth_orders`;

CREATE TABLE `bito_eth_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 ETH_BITO',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  `bito_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用BITO付出手續費',
  `event_id` varchar(255) DEFAULT NULL COMMENT '建立此order的event id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bito_eth_orders_on_event_id` (`event_id`),
  KEY `index_bito_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_bito_eth_orders_on_is_market` (`is_market`),
  KEY `index_bito_eth_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bito_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bito_eth_orders_on_status` (`status`),
  KEY `index_bito_eth_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_eth_orders_bak
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_eth_orders_bak`;

CREATE TABLE `bito_eth_orders_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 ETH_BITO',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  `bito_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用BITO付出手續費',
  PRIMARY KEY (`id`),
  KEY `index_bito_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_bito_eth_orders_on_is_market` (`is_market`),
  KEY `index_bito_eth_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bito_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bito_eth_orders_on_status` (`status`),
  KEY `index_bito_eth_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bito_eth_orders_bak` WRITE;
/*!40000 ALTER TABLE `bito_eth_orders_bak` DISABLE KEYS */;

INSERT INTO `bito_eth_orders_bak` (`id`, `status`, `user_id`, `is_buy`, `is_market`, `sprice`, `ori_c_samount`, `ori_samount`, `trade_c_samount`, `trade_samount`, `c_samount`, `samount`, `c_sfee`, `sfee`, `created_ati`, `updated_ati`, `matched_ati`, `deleted_ati`, `avg_sprice`, `refund_kind`, `twd_fee`, `receipt_id`, `created_atu`, `ori_c_saccount`, `ori_c_saccount_trade`, `ori_saccount`, `ori_saccount_trade`, `source`, `bito_sfee`)
VALUES
	(1,0,1,0,0,1111111111111,370370377777,33333334,0,0,370370377777,33333334,0,0,1533870338497,1533870338497,NULL,NULL,0,0,0,NULL,1533870338.5020,9000000000000000,0,1000000000000000000,0,0,0),
	(2,0,1,1,1,0,555555555555,0,0,0,555555555555,0,0,0,1533870338505,1533870338505,NULL,NULL,0,0,0,NULL,1533870338.5088,9000000000000000,0,999999999966666600,33333334,0,0);

/*!40000 ALTER TABLE `bito_eth_orders_bak` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bito_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_invoices`;

CREATE TABLE `bito_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bito_invoices_on_serial` (`serial`),
  KEY `index_bito_invoices_on_height` (`height`),
  KEY `index_bito_invoices_on_kind` (`kind`),
  KEY `index_bito_invoices_on_order_kind` (`order_kind`),
  KEY `index_bito_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_bito_invoices_on_relation_id` (`relation_id`),
  KEY `index_bito_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_bito_invoices_on_status` (`status`),
  KEY `index_bito_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_bito_invoices_on_tindex` (`tindex`),
  KEY `index_bito_invoices_on_txid` (`txid`),
  KEY `index_bito_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table bito_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_order_matches`;

CREATE TABLE `bito_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_bito_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_bito_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_bito_order_matches_on_kind` (`kind`),
  KEY `index_bito_order_matches_on_m_ati` (`m_ati`),
  KEY `index_bito_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_bito_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_orders`;

CREATE TABLE `bito_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_bito_orders_on_is_buy` (`is_buy`),
  KEY `index_bito_orders_on_is_market` (`is_market`),
  KEY `index_bito_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bito_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bito_orders_on_status` (`status`),
  KEY `index_bito_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_send_invoices`;

CREATE TABLE `bito_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bito_send_invoices_on_height` (`height`),
  KEY `index_bito_send_invoices_on_kind` (`kind`),
  KEY `index_bito_send_invoices_on_status` (`status`),
  KEY `index_bito_send_invoices_on_tindex` (`tindex`),
  KEY `index_bito_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table bito_usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_usdt_order_matches`;

CREATE TABLE `bito_usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方bito異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方usdt異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方bito異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方usdt異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  PRIMARY KEY (`id`),
  KEY `index_bito_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_bito_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_bito_usdt_order_matches_on_kind` (`kind`),
  KEY `index_bito_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_bito_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_bito_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bito_usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bito_usdt_orders`;

CREATE TABLE `bito_usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 USDT_BITO',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_bito_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_bito_usdt_orders_on_is_market` (`is_market`),
  KEY `index_bito_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_bito_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_bito_usdt_orders_on_status` (`status`),
  KEY `index_bito_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btc_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_curvies`;

CREATE TABLE `btc_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(16,0) NOT NULL DEFAULT '0',
  `close` decimal(16,0) NOT NULL DEFAULT '0',
  `high` decimal(16,0) NOT NULL DEFAULT '0',
  `low` decimal(16,0) NOT NULL DEFAULT '0',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_btc_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_btc_curvies_on_ati` (`ati`),
  KEY `index_btc_curvies_on_kind` (`kind`),
  KEY `index_btc_curvies_on_open_oid` (`open_oid`),
  KEY `index_btc_curvies_on_close_oid` (`close_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btc_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_invoices`;

CREATE TABLE `btc_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(16,0) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(16,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_btc_invoices_on_serial` (`serial`),
  KEY `index_btc_invoices_on_kind` (`kind`),
  KEY `index_btc_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_btc_invoices_on_status` (`status`),
  KEY `index_btc_invoices_on_user_id` (`user_id`),
  KEY `index_btc_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_btc_invoices_on_relation_id` (`relation_id`),
  KEY `index_btc_invoices_on_order_kind` (`order_kind`),
  KEY `index_btc_invoices_on_wallet` (`wallet`),
  KEY `index_btc_invoices_on_txid` (`txid`),
  KEY `index_btc_invoices_on_tindex` (`tindex`),
  KEY `index_btc_invoices_on_height` (`height`),
  KEY `index_btc_invoices_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table btc_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_order_matches`;

CREATE TABLE `btc_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_btc_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_btc_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_btc_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_btc_order_matches_on_s_user_id` (`s_user_id`),
  KEY `index_btc_order_matches_on_m_ati` (`m_ati`),
  KEY `index_btc_order_matches_on_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btc_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_orders`;

CREATE TABLE `btc_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '掛單價 50000',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btc手續費',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_btc_orders_on_status` (`status`),
  KEY `index_btc_orders_on_user_id` (`user_id`),
  KEY `index_btc_orders_on_is_buy` (`is_buy`),
  KEY `index_btc_orders_on_is_market` (`is_market`),
  KEY `index_btc_orders_on_refund_kind` (`refund_kind`),
  KEY `index_btc_orders_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btc_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_send_invoices`;

CREATE TABLE `btc_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_btc_send_invoices_on_kind` (`kind`),
  KEY `index_btc_send_invoices_on_status` (`status`),
  KEY `index_btc_send_invoices_on_txid` (`txid`),
  KEY `index_btc_send_invoices_on_tindex` (`tindex`),
  KEY `index_btc_send_invoices_on_height` (`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table btc_send_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_send_wallets`;

CREATE TABLE `btc_send_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_btc_send_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber發送用的錢包';



# Dump of table btc_usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_usdt_order_matches`;

CREATE TABLE `btc_usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方btc異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方usdt異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方btc異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方usdt異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BTC)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BTC)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BTC)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BTC)',
  PRIMARY KEY (`id`),
  KEY `index_btc_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_btc_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_btc_usdt_order_matches_on_kind` (`kind`),
  KEY `index_btc_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_btc_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_btc_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btc_usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_usdt_orders`;

CREATE TABLE `btc_usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTC原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTC已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTC尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTC手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 USDT_BTC',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BTC)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(BTC)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_btc_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_btc_usdt_orders_on_is_market` (`is_market`),
  KEY `index_btc_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_btc_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_btc_usdt_orders_on_status` (`status`),
  KEY `index_btc_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btc_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btc_wallets`;

CREATE TABLE `btc_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(62) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_btc_wallets_on_wallet` (`wallet`),
  KEY `index_btc_wallets_on_user_id` (`user_id`),
  KEY `index_btc_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比特幣錢包';



# Dump of table btg_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_curvies`;

CREATE TABLE `btg_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(16,0) NOT NULL DEFAULT '0',
  `close` decimal(16,0) NOT NULL DEFAULT '0',
  `high` decimal(16,0) NOT NULL DEFAULT '0',
  `low` decimal(16,0) NOT NULL DEFAULT '0',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_btg_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_btg_curvies_on_ati` (`ati`),
  KEY `index_btg_curvies_on_close_oid` (`close_oid`),
  KEY `index_btg_curvies_on_kind` (`kind`),
  KEY `index_btg_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btg_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_invoices`;

CREATE TABLE `btg_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(16,0) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(16,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_btg_invoices_on_serial` (`serial`),
  KEY `index_btg_invoices_on_order_kind` (`kind`),
  KEY `index_btg_invoices_on_relation_id` (`relation_id`),
  KEY `index_btg_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_btg_invoices_on_status` (`status`),
  KEY `index_btg_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_btg_invoices_on_tindex` (`tindex`),
  KEY `index_btg_invoices_on_txid` (`txid`),
  KEY `index_btg_invoices_on_user_id` (`user_id`),
  KEY `index_btg_invoices_on_wallet` (`wallet`),
  KEY `index_btg_invoices_on_height` (`height`),
  KEY `index_btg_invoices_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='btg帳';



# Dump of table btg_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_order_matches`;

CREATE TABLE `btg_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘btg待交易量',
  `b_ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_btg_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_btg_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_btg_order_matches_on_m_ati` (`m_ati`),
  KEY `index_btg_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_btg_order_matches_on_s_user_id` (`s_user_id`),
  KEY `index_btg_order_matches_on_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btg_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_orders`;

CREATE TABLE `btg_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '掛單價 50000',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg手續費',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_btg_orders_on_is_buy` (`is_buy`),
  KEY `index_btg_orders_on_is_market` (`is_market`),
  KEY `index_btg_orders_on_status` (`status`),
  KEY `index_btg_orders_on_user_id` (`user_id`),
  KEY `index_btg_orders_on_refund_kind` (`refund_kind`),
  KEY `index_btg_orders_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btg_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_send_invoices`;

CREATE TABLE `btg_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_btg_send_invoices_on_kind` (`kind`),
  KEY `index_btg_send_invoices_on_status` (`status`),
  KEY `index_btg_send_invoices_on_txid` (`txid`),
  KEY `index_btg_send_invoices_on_tindex` (`tindex`),
  KEY `index_btg_send_invoices_on_height` (`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table btg_send_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_send_wallets`;

CREATE TABLE `btg_send_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_btg_send_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber發送用的錢包';



# Dump of table btg_usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_usdt_order_matches`;

CREATE TABLE `btg_usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方btg異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方usdt異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方btg異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方usdt異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BTG)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BTG)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BTG)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BTG)',
  PRIMARY KEY (`id`),
  KEY `index_btg_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_btg_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_btg_usdt_order_matches_on_kind` (`kind`),
  KEY `index_btg_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_btg_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_btg_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btg_usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_usdt_orders`;

CREATE TABLE `btg_usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTG原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTG已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTG尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BTG手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 USDT_BTG',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BTG)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(BTG)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_btg_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_btg_usdt_orders_on_is_market` (`is_market`),
  KEY `index_btg_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_btg_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_btg_usdt_orders_on_status` (`status`),
  KEY `index_btg_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table btg_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `btg_wallets`;

CREATE TABLE `btg_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(62) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_btg_wallets_on_wallet` (`wallet`),
  KEY `index_btg_wallets_on_status` (`status`),
  KEY `index_btg_wallets_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTG錢包';



# Dump of table cgp_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cgp_curvies`;

CREATE TABLE `cgp_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_cgp_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_cgp_curvies_on_ati` (`ati`),
  KEY `index_cgp_curvies_on_close_oid` (`close_oid`),
  KEY `index_cgp_curvies_on_kind` (`kind`),
  KEY `index_cgp_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cgp_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cgp_invoices`;

CREATE TABLE `cgp_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_cgp_invoices_on_serial` (`serial`),
  KEY `index_cgp_invoices_on_height` (`height`),
  KEY `index_cgp_invoices_on_kind` (`kind`),
  KEY `index_cgp_invoices_on_order_kind` (`order_kind`),
  KEY `index_cgp_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_cgp_invoices_on_relation_id` (`relation_id`),
  KEY `index_cgp_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_cgp_invoices_on_status` (`status`),
  KEY `index_cgp_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_cgp_invoices_on_tindex` (`tindex`),
  KEY `index_cgp_invoices_on_txid` (`txid`),
  KEY `index_cgp_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table cgp_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cgp_order_matches`;

CREATE TABLE `cgp_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_cgp_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_cgp_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_cgp_order_matches_on_kind` (`kind`),
  KEY `index_cgp_order_matches_on_m_ati` (`m_ati`),
  KEY `index_cgp_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_cgp_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cgp_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cgp_orders`;

CREATE TABLE `cgp_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_cgp_orders_on_is_buy` (`is_buy`),
  KEY `index_cgp_orders_on_is_market` (`is_market`),
  KEY `index_cgp_orders_on_receipt_id` (`receipt_id`),
  KEY `index_cgp_orders_on_refund_kind` (`refund_kind`),
  KEY `index_cgp_orders_on_status` (`status`),
  KEY `index_cgp_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cgp_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cgp_send_invoices`;

CREATE TABLE `cgp_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cgp_send_invoices_on_height` (`height`),
  KEY `index_cgp_send_invoices_on_kind` (`kind`),
  KEY `index_cgp_send_invoices_on_status` (`status`),
  KEY `index_cgp_send_invoices_on_tindex` (`tindex`),
  KEY `index_cgp_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table currency_deposit_issues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `currency_deposit_issues`;

CREATE TABLE `currency_deposit_issues` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `currency_invoice_id` bigint(20) unsigned NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '不明匯款原由',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '退款狀態',
  `user_name` varchar(30) DEFAULT NULL COMMENT '存提領人全名',
  `bank_serial` smallint(6) DEFAULT NULL COMMENT '銀行代碼',
  `bank_branch` smallint(6) DEFAULT NULL COMMENT '分行代碼',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '銀行帳號',
  `memo` varchar(255) DEFAULT NULL,
  `serial_group` varchar(30) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `finished_at` datetime DEFAULT NULL COMMENT '退款完成時間',
  `ori_twd_amount` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '入帳原始金額',
  `twd_amount` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '退款金額',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '退款手續費',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_currency_deposit_issues_on_currency_invoice_id` (`currency_invoice_id`),
  KEY `index_currency_deposit_issues_on_kind` (`kind`),
  KEY `index_currency_deposit_issues_on_status` (`status`),
  KEY `index_currency_deposit_issues_on_finished_at` (`finished_at`),
  KEY `index_currency_deposit_issues_on_user_id` (`user_id`),
  KEY `index_currency_deposit_issues_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='現金加值問題單 - 退款流程';



# Dump of table currency_deposit_pendings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `currency_deposit_pendings`;

CREATE TABLE `currency_deposit_pendings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `currency_invoice_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `twd_amount` decimal(12,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0',
  `bank_info` varchar(500) DEFAULT NULL COMMENT '完整電文',
  `bank_serial` smallint(6) DEFAULT NULL COMMENT '銀行代碼',
  `bank_branch` smallint(6) DEFAULT NULL COMMENT '分行代碼',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '銀行帳號',
  `source_serial` varchar(255) DEFAULT NULL COMMENT '來源序號',
  `bank_kind` tinyint(4) DEFAULT '0' COMMENT '通知銀行別',
  `bank_at` datetime DEFAULT NULL COMMENT '交易日期',
  `serial_group` varchar(30) DEFAULT NULL COMMENT '批次上傳序號',
  `manager_a_id` tinyint(4) DEFAULT '0' COMMENT '管理者a',
  `manager_b_id` tinyint(4) DEFAULT '0' COMMENT '管理者b',
  `approved_at` datetime DEFAULT NULL COMMENT '管理者b審核時間',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ori_twd_amount` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `bank_trans_at` date DEFAULT NULL COMMENT '銀行真實入帳時間',
  PRIMARY KEY (`id`),
  KEY `index_currency_deposit_pendings_on_user_id` (`user_id`),
  KEY `index_currency_deposit_pendings_on_currency_invoice_id` (`currency_invoice_id`),
  KEY `index_currency_deposit_pendings_on_status` (`status`),
  KEY `index_currency_deposit_pendings_on_kind` (`kind`),
  KEY `index_currency_deposit_pendings_on_serial_group` (`serial_group`),
  KEY `index_currency_deposit_pendings_on_bank_trans_at` (`bank_trans_at`),
  KEY `index_currency_deposit_pendings_on_approved_at` (`approved_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table currency_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `currency_invoices`;

CREATE TABLE `currency_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '加值,提領,買入,賣出',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `twd_amount` decimal(12,0) NOT NULL DEFAULT '0',
  `memo` varchar(255) DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `bank_serial` smallint(6) DEFAULT NULL COMMENT '銀行代碼',
  `bank_branch` smallint(6) DEFAULT NULL COMMENT '分行代碼',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '銀行帳號',
  `token` varchar(255) DEFAULT NULL COMMENT 'Email驗證token',
  `token_at` datetime DEFAULT NULL COMMENT 'Email驗證時間',
  `bank_info` varchar(500) DEFAULT NULL COMMENT '完整電文',
  `serial_group` varchar(30) DEFAULT NULL COMMENT '批次序號(管理後台)',
  `ori_daccount` decimal(12,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0',
  `user_name` varchar(30) DEFAULT NULL COMMENT '存提領人全名',
  `bank_at` datetime DEFAULT NULL,
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_daccount_trade` decimal(12,0) DEFAULT NULL,
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '提領取消關聯單',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `source_serial` varchar(255) DEFAULT NULL COMMENT '來源序號',
  `bank_kind` tinyint(4) DEFAULT '0' COMMENT '通知銀行別',
  `finished_at` datetime DEFAULT NULL COMMENT '入帳加值完成/出款完成時間',
  `ori_twd_amount` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `bank_trans_at` date DEFAULT NULL COMMENT '銀行真實入帳時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_currency_invoices_on_serial` (`serial`),
  KEY `index_currency_invoices_on_kind` (`kind`),
  KEY `index_currency_invoices_on_status` (`status`),
  KEY `index_currency_invoices_on_user_id` (`user_id`),
  KEY `index_currency_invoices_on_twd_amount` (`twd_amount`),
  KEY `index_currency_invoices_on_bank_serial` (`bank_serial`),
  KEY `index_currency_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_currency_invoices_on_bank_kind` (`bank_kind`),
  KEY `index_currency_invoices_on_finished_at` (`finished_at`),
  KEY `index_currency_invoices_on_bank_trans_at` (`bank_trans_at`),
  KEY `index_currency_invoices_on_token_at` (`token_at`),
  KEY `index_currency_invoices_on_trans_at` (`trans_at`),
  KEY `index_currency_invoices_on_source_serial` (`source_serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='現金帳(所有現金增減都要有)';



# Dump of table cyber_payloads
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cyber_payloads`;

CREATE TABLE `cyber_payloads` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `cyber_kind` varchar(3) NOT NULL,
  `txid` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `retry_counter` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_cyber_payloads_on_cyber_kind_and_txid` (`cyber_kind`,`txid`),
  KEY `index_cyber_payloads_on_status` (`status`),
  KEY `index_cyber_payloads_on_cyber_kind` (`cyber_kind`),
  KEY `index_cyber_payloads_on_txid` (`txid`),
  KEY `index_cyber_payloads_on_created_at` (`created_at`),
  KEY `index_cyber_payloads_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cyber_rev_tran_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cyber_rev_tran_sources`;

CREATE TABLE `cyber_rev_tran_sources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cyber_tran_id` bigint(20) unsigned NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `txid` varchar(255) NOT NULL,
  `tindex` smallint(6) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cyber_rev_trans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cyber_rev_trans`;

CREATE TABLE `cyber_rev_trans` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cyber_kind` tinyint(4) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `txid` varchar(255) NOT NULL,
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfees` decimal(16,0) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cyber_send_tran_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cyber_send_tran_sources`;

CREATE TABLE `cyber_send_tran_sources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cyber_tran_id` bigint(20) unsigned NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `txid` varchar(255) NOT NULL,
  `tindex` smallint(6) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cyber_send_trans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cyber_send_trans`;

CREATE TABLE `cyber_send_trans` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cyber_kind` tinyint(4) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `txid` varchar(255) NOT NULL,
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfees` decimal(16,0) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table erc_payloads
# ------------------------------------------------------------

DROP TABLE IF EXISTS `erc_payloads`;

CREATE TABLE `erc_payloads` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_symbol` varchar(8) NOT NULL,
  `txid` varchar(255) NOT NULL COMMENT 'eth txid',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '狀態',
  `source_kind` tinyint(3) unsigned NOT NULL COMMENT 'invoice or pool_invoice',
  `source_id` bigint(20) unsigned NOT NULL COMMENT 'invoice_id or pool_invoice_id',
  `payload` longtext COMMENT 'broadcast原文，送出才需要',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_erc_payloads_on_contract_symbol` (`contract_symbol`) USING BTREE,
  KEY `index_erc_payloads_on_created_at` (`created_at`) USING BTREE,
  KEY `index_erc_payloads_on_source_id` (`source_id`) USING BTREE,
  KEY `index_erc_payloads_on_source_kind` (`source_kind`) USING BTREE,
  KEY `index_erc_payloads_on_status` (`status`) USING BTREE,
  KEY `index_erc_payloads_on_txid` (`txid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ERC系列送出的payload';



# Dump of table erc_pool_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `erc_pool_invoices`;

CREATE TABLE `erc_pool_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_symbol` varchar(8) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_status` tinyint(4) NOT NULL DEFAULT '0',
  `is_alarm` tinyint(1) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0',
  `from_wallet` varchar(40) DEFAULT NULL,
  `to_wallet` varchar(40) DEFAULT NULL,
  `txid` varchar(64) NOT NULL,
  `tindex` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `send_at` datetime DEFAULT NULL,
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_erc_pool_invoices_on_contract_symbol` (`contract_symbol`) USING BTREE,
  KEY `index_erc_pool_invoices_on_from_wallet` (`from_wallet`) USING BTREE,
  KEY `index_erc_pool_invoices_on_height` (`height`) USING BTREE,
  KEY `index_erc_pool_invoices_on_kind` (`kind`) USING BTREE,
  KEY `index_erc_pool_invoices_on_status` (`status`) USING BTREE,
  KEY `index_erc_pool_invoices_on_sub_kind` (`sub_kind`) USING BTREE,
  KEY `index_erc_pool_invoices_on_tindex` (`tindex`) USING BTREE,
  KEY `index_erc_pool_invoices_on_to_wallet` (`to_wallet`) USING BTREE,
  KEY `index_erc_pool_invoices_on_txid` (`txid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ERC流程水位用';



# Dump of table erc_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `erc_wallets`;

CREATE TABLE `erc_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(40) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_erc_wallets_on_wallet` (`wallet`) USING BTREE,
  KEY `index_erc_wallets_on_status` (`status`) USING BTREE,
  KEY `index_erc_wallets_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ERC錢包';



# Dump of table eth_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_curvies`;

CREATE TABLE `eth_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(16,0) NOT NULL DEFAULT '0',
  `close` decimal(16,0) NOT NULL DEFAULT '0',
  `high` decimal(16,0) NOT NULL DEFAULT '0',
  `low` decimal(16,0) NOT NULL DEFAULT '0',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_eth_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_eth_curvies_on_ati` (`ati`),
  KEY `index_eth_curvies_on_kind` (`kind`),
  KEY `index_eth_curvies_on_open_oid` (`open_oid`),
  KEY `index_eth_curvies_on_close_oid` (`close_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table eth_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_invoices`;

CREATE TABLE `eth_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(40) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(16,0) NOT NULL,
  `samount_rddt` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'eth餘數：最高分割18位，因此8+10，此值10位',
  `sfee_rddt` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'eth餘數：最高分割18位，因此8+10，此值10位',
  `height` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(16,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_eth_invoices_on_serial` (`serial`),
  KEY `index_eth_invoices_on_kind` (`kind`),
  KEY `index_eth_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_eth_invoices_on_status` (`status`),
  KEY `index_eth_invoices_on_user_id` (`user_id`),
  KEY `index_eth_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_eth_invoices_on_relation_id` (`relation_id`),
  KEY `index_eth_invoices_on_order_kind` (`order_kind`),
  KEY `index_eth_invoices_on_wallet` (`wallet`),
  KEY `index_eth_invoices_on_txid` (`txid`),
  KEY `index_eth_invoices_on_tindex` (`tindex`),
  KEY `index_eth_invoices_on_height` (`height`),
  KEY `index_eth_invoices_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ETC帳';



# Dump of table eth_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_order_matches`;

CREATE TABLE `eth_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_eth_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_eth_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_eth_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_eth_order_matches_on_s_user_id` (`s_user_id`),
  KEY `index_eth_order_matches_on_m_ati` (`m_ati`),
  KEY `index_eth_order_matches_on_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table eth_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_orders`;

CREATE TABLE `eth_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `damount` decimal(16,0) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` int(11) DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_eth_orders_on_status` (`status`),
  KEY `index_eth_orders_on_user_id` (`user_id`),
  KEY `index_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_eth_orders_on_is_market` (`is_market`),
  KEY `index_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_eth_orders_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table eth_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_send_invoices`;

CREATE TABLE `eth_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(40) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `samount_rddt` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'eth餘數：最高分割18位，因此8+10，此值10位',
  `sfee_rddt` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'eth餘數：最高分割18位，因此8+10，此值10位',
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_eth_send_invoices_on_kind` (`kind`),
  KEY `index_eth_send_invoices_on_status` (`status`),
  KEY `index_eth_send_invoices_on_txid` (`txid`),
  KEY `index_eth_send_invoices_on_tindex` (`tindex`),
  KEY `index_eth_send_invoices_on_height` (`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table eth_send_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_send_wallets`;

CREATE TABLE `eth_send_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_eth_send_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber發送用的錢包';



# Dump of table eth_usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_usdt_order_matches`;

CREATE TABLE `eth_usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方eth異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方usdt異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方eth異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方usdt異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  PRIMARY KEY (`id`),
  KEY `index_eth_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_eth_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_eth_usdt_order_matches_on_kind` (`kind`),
  KEY `index_eth_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_eth_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_eth_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table eth_usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_usdt_orders`;

CREATE TABLE `eth_usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 USDT_ETH',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_eth_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_eth_usdt_orders_on_is_market` (`is_market`),
  KEY `index_eth_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_eth_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_eth_usdt_orders_on_status` (`status`),
  KEY `index_eth_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table eth_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eth_wallets`;

CREATE TABLE `eth_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(40) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_eth_wallets_on_wallet` (`wallet`),
  KEY `index_eth_wallets_on_user_id` (`user_id`),
  KEY `index_eth_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乙太幣錢包';



# Dump of table ethc_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ethc_invoices`;

CREATE TABLE `ethc_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `receipt_id` bigint(20) unsigned DEFAULT NULL COMMENT '發票id，無用則保留',
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL COMMENT '原始餘額，實數',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易實數',
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee` decimal(65,0) DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `txid` varchar(64) NOT NULL,
  `tindex` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'confirm 數量，最高為4',
  `send_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) NOT NULL COMMENT '接收地址',
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  `ori_samount` decimal(65,0) DEFAULT NULL,
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ethc_invoices_on_txid` (`txid`) USING BTREE,
  KEY `index_ethc_invoices_on_height` (`height`) USING BTREE,
  KEY `index_ethc_invoices_on_kind` (`kind`) USING BTREE,
  KEY `index_ethc_invoices_on_receipt_id` (`receipt_id`) USING BTREE,
  KEY `index_ethc_invoices_on_relation_id` (`relation_id`) USING BTREE,
  KEY `index_ethc_invoices_on_relation_user_id` (`relation_user_id`) USING BTREE,
  KEY `index_ethc_invoices_on_serial` (`serial`) USING BTREE,
  KEY `index_ethc_invoices_on_status` (`status`) USING BTREE,
  KEY `index_ethc_invoices_on_sub_kind` (`sub_kind`) USING BTREE,
  KEY `index_ethc_invoices_on_tindex` (`tindex`) USING BTREE,
  KEY `index_ethc_invoices_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ETH_contract 帳';



# Dump of table faqs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `faqs`;

CREATE TABLE `faqs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_agent_events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_agent_events`;

CREATE TABLE `ico_agent_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ico_agent_id` bigint(20) NOT NULL COMMENT '代銷商id',
  `ico_firm_id` bigint(20) NOT NULL COMMENT '廠商id',
  `ico_firm_event_id` bigint(20) NOT NULL COMMENT '廠商活動id',
  `amount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '代銷數量',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_ico_agent_events_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_agent_events_on_ico_firm_event_id` (`ico_firm_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_agents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_agents`;

CREATE TABLE `ico_agents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ico_firm_id` bigint(20) NOT NULL COMMENT '廠商id',
  `name` varchar(50) NOT NULL COMMENT '代銷商名稱',
  `remark` text COMMENT '其他資訊',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ico_agents_on_ico_firm_id` (`ico_firm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_alln_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_alln_invoices`;

CREATE TABLE `ico_alln_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_alln_invoices_on_block_at` (`block_at`),
  KEY `index_ico_alln_invoices_on_code` (`code`),
  KEY `index_ico_alln_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_alln_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_alln_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_alln_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_alln_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_alln_invoices_on_serial` (`serial`),
  KEY `index_ico_alln_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_billings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_billings`;

CREATE TABLE `ico_billings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ico_firm_id` bigint(20) NOT NULL,
  `samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'ETH結算數量',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '接收的對方單的invoice id',
  `settle_date` date DEFAULT NULL COMMENT '結算日期',
  `pub_total_count` int(11) DEFAULT NULL COMMENT '公募筆數',
  `remark` varchar(255) DEFAULT NULL COMMENT '備註',
  `manager_a_id` tinyint(4) DEFAULT '0' COMMENT '管理者a',
  `manager_b_id` tinyint(4) DEFAULT '0' COMMENT '管理者b',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ico_billings_on_ico_firm_id` (`ico_firm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_bito_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_bito_invoices`;

CREATE TABLE `ico_bito_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_bito_invoices_on_code` (`code`),
  KEY `index_ico_bito_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_bito_invoices_on_serial` (`serial`),
  KEY `index_ico_bito_invoices_on_block_at` (`block_at`),
  KEY `index_ico_bito_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_bito_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_bito_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_bito_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_bito_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_cgp_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_cgp_invoices`;

CREATE TABLE `ico_cgp_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_cgp_invoices_on_code` (`code`),
  KEY `index_ico_cgp_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_cgp_invoices_on_serial` (`serial`),
  KEY `index_ico_cgp_invoices_on_block_at` (`block_at`),
  KEY `index_ico_cgp_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_cgp_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_cgp_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_cgp_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_cgp_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_firm_events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_firm_events`;

CREATE TABLE `ico_firm_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ico_firm_id` bigint(20) NOT NULL COMMENT '廠商id',
  `kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.私募閉鎖期, 1.公募閉鎖期, 2.公募優惠期間設定',
  `name` varchar(50) NOT NULL COMMENT '名稱',
  `start_at` date DEFAULT NULL COMMENT '開始日',
  `end_at` date DEFAULT NULL COMMENT '結束日',
  `block_at` date DEFAULT NULL COMMENT '公/私募: 閉鎖期',
  `amount` decimal(16,0) DEFAULT '0' COMMENT '數量',
  `discount` int(11) DEFAULT NULL COMMENT '折數(%)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ico_firm_events_on_ico_firm_id` (`ico_firm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_firms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_firms`;

CREATE TABLE `ico_firms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '公司名稱',
  `token` varchar(50) NOT NULL COMMENT 'Token全名',
  `token_number` varchar(5) NOT NULL COMMENT 'Token代號',
  `pri_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '私募閉鎖開關',
  `pri_total` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '私募總數',
  `pri_start_at` date DEFAULT NULL COMMENT '私募開始時間',
  `pri_end_at` date DEFAULT NULL COMMENT '私募結束時間',
  `pub_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公募開關',
  `pub_total` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '公募總數',
  `pub_reserved_total` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '公募一般代投數量',
  `pub_block_total` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '公募預售總數',
  `pub_price` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '公募價格(ETH)',
  `pub_start_at` date DEFAULT NULL COMMENT '公募開始時間',
  `pub_end_at` date DEFAULT NULL COMMENT '公募結束時間',
  `pur_intro` text COMMENT '公募購買說明',
  `pur_intro_cn` text COMMENT '公募購買說明CN',
  `pur_intro_en` text COMMENT '公募購買說明EN',
  `rec_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推薦人開關',
  `rec_intro` text COMMENT '推薦人機制說明',
  `rec_intro_cn` text COMMENT '推薦人機制說明CN',
  `rec_intro_en` text COMMENT '推薦人機制說明EN',
  `rec_feedback` varchar(255) DEFAULT NULL COMMENT '推薦人回饋 %',
  `recd_feedback` varchar(255) DEFAULT NULL COMMENT '被推薦人回饋 %',
  `release_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '發佈狀態',
  `remark` text COMMENT '其他資訊',
  `ico_manager_id` int(11) NOT NULL COMMENT '管理者Id',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `circulation` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總發行量',
  `reserved_total` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '保留總數',
  `pub_block_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公募預售開關',
  `withdraw_max` float DEFAULT NULL COMMENT '提領最高數量',
  `withdraw_min` float DEFAULT NULL COMMENT '提領最低數量',
  `flag` int(11) NOT NULL DEFAULT '0',
  `white_paper_url` varchar(255) DEFAULT NULL COMMENT '白皮書網址',
  `increase_amount` int(11) NOT NULL DEFAULT '0' COMMENT '實際增加數量',
  `less_amount` int(11) NOT NULL DEFAULT '0' COMMENT '小於數量',
  `progress_bar_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '顯示進度條',
  `pub_block_increase_amount` int(11) NOT NULL DEFAULT '0' COMMENT '公募預售增加數量',
  `pub_block_flag` int(11) NOT NULL DEFAULT '0' COMMENT '公募預售狀態',
  `pub_block_less_amount` int(11) NOT NULL DEFAULT '0' COMMENT '公募預售小於數量',
  `pub_block_progress_bar_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公募預售顯示進度條',
  `pub_block_reserved_total` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '公募預售代投數量',
  `billing_account` varchar(255) DEFAULT NULL COMMENT '出款帳號',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_managers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_managers`;

CREATE TABLE `ico_managers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `name` varchar(20) NOT NULL COMMENT '名稱',
  `permission` tinyint(4) NOT NULL DEFAULT '0',
  `otp_token_name` varchar(50) DEFAULT NULL,
  `otp_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP啟用狀態',
  `otp_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP更新次數(遞增)',
  `otp_config` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP使用設定',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '權限開關',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ico_managers_on_email` (`email`),
  UNIQUE KEY `index_ico_managers_on_reset_password_token` (`reset_password_token`),
  KEY `index_ico_managers_on_permission` (`permission`),
  KEY `index_ico_managers_on_otp_config` (`otp_config`),
  KEY `index_ico_managers_on_otp_status` (`otp_status`),
  KEY `index_ico_managers_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_modl_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_modl_invoices`;

CREATE TABLE `ico_modl_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_modl_invoices_on_block_at` (`block_at`),
  KEY `index_ico_modl_invoices_on_code` (`code`),
  KEY `index_ico_modl_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_modl_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_modl_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_modl_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_modl_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_modl_invoices_on_serial` (`serial`),
  KEY `index_ico_modl_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_panda_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_panda_invoices`;

CREATE TABLE `ico_panda_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_panda_invoices_on_code` (`code`),
  KEY `index_ico_panda_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_panda_invoices_on_serial` (`serial`),
  KEY `index_ico_panda_invoices_on_block_at` (`block_at`),
  KEY `index_ico_panda_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_panda_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_panda_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_panda_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_panda_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_qntu_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_qntu_invoices`;

CREATE TABLE `ico_qntu_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_qntu_invoices_on_block_at` (`block_at`),
  KEY `index_ico_qntu_invoices_on_code` (`code`),
  KEY `index_ico_qntu_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_qntu_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_qntu_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_qntu_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_qntu_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_qntu_invoices_on_serial` (`serial`),
  KEY `index_ico_qntu_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_rpc_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_rpc_invoices`;

CREATE TABLE `ico_rpc_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`),
  KEY `index_ico_rpc_invoices_on_block_at` (`block_at`),
  KEY `index_ico_rpc_invoices_on_code` (`code`),
  KEY `index_ico_rpc_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_rpc_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_rpc_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_rpc_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_rpc_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_rpc_invoices_on_serial` (`serial`),
  KEY `index_ico_rpc_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_sda_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_sda_invoices`;

CREATE TABLE `ico_sda_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `serial` varchar(255) NOT NULL COMMENT '序號',
  `currency` varchar(255) NOT NULL COMMENT '幣別',
  `pricing` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '定價',
  `discount` varchar(255) NOT NULL COMMENT '折扣',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '付款數量',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '購得數量',
  `code` varchar(255) DEFAULT NULL COMMENT '推薦人代碼',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ico_firm_id` bigint(20) NOT NULL,
  `price` decimal(16,0) NOT NULL,
  `trans_at` datetime DEFAULT NULL,
  `block_at` date DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '類型',
  `release_at` datetime DEFAULT NULL COMMENT '發佈日期',
  `ico_firm_event_id` bigint(20) DEFAULT NULL,
  `ico_user_id` bigint(20) DEFAULT NULL,
  `ico_agent_id` bigint(20) DEFAULT NULL,
  `ico_agent_event_id` bigint(20) DEFAULT NULL,
  `reward_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '購買人獎勵',
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '推薦人user_id',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ico_sda_invoices_on_block_at` (`block_at`),
  KEY `index_ico_sda_invoices_on_code` (`code`),
  KEY `index_ico_sda_invoices_on_ico_agent_event_id` (`ico_agent_event_id`),
  KEY `index_ico_sda_invoices_on_ico_agent_id` (`ico_agent_id`),
  KEY `index_ico_sda_invoices_on_ico_firm_event_id` (`ico_firm_event_id`),
  KEY `index_ico_sda_invoices_on_ico_firm_id` (`ico_firm_id`),
  KEY `index_ico_sda_invoices_on_ico_user_id` (`ico_user_id`),
  KEY `index_ico_sda_invoices_on_serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ico_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ico_users`;

CREATE TABLE `ico_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `kind_type` varchar(255) DEFAULT NULL,
  `kind_id` bigint(20) DEFAULT NULL,
  `remark` text,
  `otp_token_name` varchar(50) DEFAULT NULL,
  `otp_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP啟用狀態',
  `otp_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP更新次數(遞增)',
  `otp_config` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP使用設定',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '權限開關',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ico_users_on_email` (`email`),
  UNIQUE KEY `index_ico_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_ico_users_on_kind_type_and_kind_id` (`kind_type`,`kind_id`),
  KEY `index_ico_users_on_otp_config` (`otp_config`),
  KEY `index_ico_users_on_otp_status` (`otp_status`),
  KEY `index_ico_users_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table login_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `login_logs`;

CREATE TABLE `login_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_ati` bigint(20) unsigned NOT NULL,
  `remote_ip` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `from_created_ati` bigint(20) unsigned DEFAULT NULL,
  `from_remote_ip` bigint(20) unsigned DEFAULT NULL,
  `from_user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ltc_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_curvies`;

CREATE TABLE `ltc_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(16,0) NOT NULL DEFAULT '0',
  `close` decimal(16,0) NOT NULL DEFAULT '0',
  `high` decimal(16,0) NOT NULL DEFAULT '0',
  `low` decimal(16,0) NOT NULL DEFAULT '0',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ltc_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_ltc_curvies_on_ati` (`ati`),
  KEY `index_ltc_curvies_on_kind` (`kind`),
  KEY `index_ltc_curvies_on_open_oid` (`open_oid`),
  KEY `index_ltc_curvies_on_close_oid` (`close_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ltc_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_invoices`;

CREATE TABLE `ltc_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(16,0) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(16,0) DEFAULT NULL,
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ltc_invoices_on_serial` (`serial`),
  KEY `index_ltc_invoices_on_kind` (`kind`),
  KEY `index_ltc_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_ltc_invoices_on_status` (`status`),
  KEY `index_ltc_invoices_on_user_id` (`user_id`),
  KEY `index_ltc_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_ltc_invoices_on_relation_id` (`relation_id`),
  KEY `index_ltc_invoices_on_order_kind` (`order_kind`),
  KEY `index_ltc_invoices_on_wallet` (`wallet`),
  KEY `index_ltc_invoices_on_txid` (`txid`),
  KEY `index_ltc_invoices_on_tindex` (`tindex`),
  KEY `index_ltc_invoices_on_height` (`height`),
  KEY `index_ltc_invoices_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LTC帳';



# Dump of table ltc_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_order_matches`;

CREATE TABLE `ltc_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_ltc_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_ltc_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_ltc_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_ltc_order_matches_on_s_user_id` (`s_user_id`),
  KEY `index_ltc_order_matches_on_m_ati` (`m_ati`),
  KEY `index_ltc_order_matches_on_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ltc_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_orders`;

CREATE TABLE `ltc_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `trade_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `damount` decimal(16,0) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_ltc_orders_on_status` (`status`),
  KEY `index_ltc_orders_on_user_id` (`user_id`),
  KEY `index_ltc_orders_on_is_buy` (`is_buy`),
  KEY `index_ltc_orders_on_is_market` (`is_market`),
  KEY `index_ltc_orders_on_refund_kind` (`refund_kind`),
  KEY `index_ltc_orders_on_receipt_id` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ltc_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_send_invoices`;

CREATE TABLE `ltc_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(16,0) NOT NULL DEFAULT '0',
  `sfee` decimal(12,0) DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ltc_send_invoices_on_kind` (`kind`),
  KEY `index_ltc_send_invoices_on_status` (`status`),
  KEY `index_ltc_send_invoices_on_txid` (`txid`),
  KEY `index_ltc_send_invoices_on_tindex` (`tindex`),
  KEY `index_ltc_send_invoices_on_height` (`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table ltc_send_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_send_wallets`;

CREATE TABLE `ltc_send_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ltc_send_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber發送用的錢包';



# Dump of table ltc_usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_usdt_order_matches`;

CREATE TABLE `ltc_usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方ltc異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方usdt異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方ltc異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方usdt異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(LTC)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(LTC)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(LTC)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(LTC)',
  PRIMARY KEY (`id`),
  KEY `index_ltc_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_ltc_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_ltc_usdt_order_matches_on_kind` (`kind`),
  KEY `index_ltc_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_ltc_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_ltc_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ltc_usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_usdt_orders`;

CREATE TABLE `ltc_usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'LTC原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'LTC已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'LTC尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'USDT手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'LTC手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 USDT_LTC',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(USDT)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(USDT)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(LTC)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(LTC)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_ltc_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_ltc_usdt_orders_on_is_market` (`is_market`),
  KEY `index_ltc_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_ltc_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_ltc_usdt_orders_on_status` (`status`),
  KEY `index_ltc_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ltc_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ltc_wallets`;

CREATE TABLE `ltc_wallets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `wallet` varchar(62) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '自定名稱',
  `assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ltc_wallets_on_wallet` (`wallet`),
  KEY `index_ltc_wallets_on_user_id` (`user_id`),
  KEY `index_ltc_wallets_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='萊特幣錢包';



# Dump of table managers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `managers`;

CREATE TABLE `managers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `encrypted_password` varchar(255) NOT NULL,
  `permission` tinyint(4) NOT NULL DEFAULT '0',
  `otp_token_name` varchar(50) DEFAULT NULL,
  `telegram_name` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `otp_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP啟用狀態',
  `otp_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP更新次數(遞增)',
  `otp_config` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP使用設定',
  `status` tinyint(4) DEFAULT '0' COMMENT '權限開關',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_managers_on_email` (`email`),
  KEY `index_managers_on_permission` (`permission`),
  KEY `index_managers_on_otp_status` (`otp_status`),
  KEY `index_managers_on_otp_config` (`otp_config`),
  KEY `index_managers_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mith_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mith_curvies`;

CREATE TABLE `mith_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mith_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_mith_curvies_on_ati` (`ati`),
  KEY `index_mith_curvies_on_close_oid` (`close_oid`),
  KEY `index_mith_curvies_on_kind` (`kind`),
  KEY `index_mith_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mith_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mith_invoices`;

CREATE TABLE `mith_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mith_invoices_on_serial` (`serial`),
  KEY `index_mith_invoices_on_height` (`height`),
  KEY `index_mith_invoices_on_kind` (`kind`),
  KEY `index_mith_invoices_on_order_kind` (`order_kind`),
  KEY `index_mith_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_mith_invoices_on_relation_id` (`relation_id`),
  KEY `index_mith_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_mith_invoices_on_status` (`status`),
  KEY `index_mith_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_mith_invoices_on_tindex` (`tindex`),
  KEY `index_mith_invoices_on_txid` (`txid`),
  KEY `index_mith_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table mith_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mith_order_matches`;

CREATE TABLE `mith_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_mith_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_mith_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_mith_order_matches_on_kind` (`kind`),
  KEY `index_mith_order_matches_on_m_ati` (`m_ati`),
  KEY `index_mith_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_mith_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mith_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mith_orders`;

CREATE TABLE `mith_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_mith_orders_on_is_buy` (`is_buy`),
  KEY `index_mith_orders_on_is_market` (`is_market`),
  KEY `index_mith_orders_on_receipt_id` (`receipt_id`),
  KEY `index_mith_orders_on_refund_kind` (`refund_kind`),
  KEY `index_mith_orders_on_status` (`status`),
  KEY `index_mith_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mith_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mith_send_invoices`;

CREATE TABLE `mith_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mith_send_invoices_on_height` (`height`),
  KEY `index_mith_send_invoices_on_kind` (`kind`),
  KEY `index_mith_send_invoices_on_status` (`status`),
  KEY `index_mith_send_invoices_on_tindex` (`tindex`),
  KEY `index_mith_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table mobile_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_tokens`;

CREATE TABLE `mobile_tokens` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `mobile` varchar(20) NOT NULL COMMENT '+886912345678',
  `country_code` varchar(6) NOT NULL COMMENT '+886',
  `token` varchar(6) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mobile_tokens_on_user_id` (`user_id`),
  KEY `index_mobile_tokens_on_token` (`token`),
  KEY `index_mobile_tokens_on_kind` (`kind`),
  KEY `index_mobile_tokens_on_sub_kind` (`sub_kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手機驗證碼';



# Dump of table modl_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modl_curvies`;

CREATE TABLE `modl_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_modl_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_modl_curvies_on_ati` (`ati`),
  KEY `index_modl_curvies_on_close_oid` (`close_oid`),
  KEY `index_modl_curvies_on_kind` (`kind`),
  KEY `index_modl_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table modl_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modl_invoices`;

CREATE TABLE `modl_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_modl_invoices_on_serial` (`serial`),
  KEY `index_modl_invoices_on_height` (`height`),
  KEY `index_modl_invoices_on_kind` (`kind`),
  KEY `index_modl_invoices_on_order_kind` (`order_kind`),
  KEY `index_modl_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_modl_invoices_on_relation_id` (`relation_id`),
  KEY `index_modl_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_modl_invoices_on_status` (`status`),
  KEY `index_modl_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_modl_invoices_on_tindex` (`tindex`),
  KEY `index_modl_invoices_on_txid` (`txid`),
  KEY `index_modl_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table modl_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modl_order_matches`;

CREATE TABLE `modl_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_modl_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_modl_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_modl_order_matches_on_kind` (`kind`),
  KEY `index_modl_order_matches_on_m_ati` (`m_ati`),
  KEY `index_modl_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_modl_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table modl_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modl_orders`;

CREATE TABLE `modl_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_modl_orders_on_is_buy` (`is_buy`),
  KEY `index_modl_orders_on_is_market` (`is_market`),
  KEY `index_modl_orders_on_receipt_id` (`receipt_id`),
  KEY `index_modl_orders_on_refund_kind` (`refund_kind`),
  KEY `index_modl_orders_on_status` (`status`),
  KEY `index_modl_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table modl_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modl_send_invoices`;

CREATE TABLE `modl_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_modl_send_invoices_on_height` (`height`),
  KEY `index_modl_send_invoices_on_kind` (`kind`),
  KEY `index_modl_send_invoices_on_status` (`status`),
  KEY `index_modl_send_invoices_on_tindex` (`tindex`),
  KEY `index_modl_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table node_callback_stacks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `node_callback_stacks`;

CREATE TABLE `node_callback_stacks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) DEFAULT '0',
  `status` tinyint(4) DEFAULT '0',
  `cyber_kind` varchar(3) DEFAULT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `flag` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `contract_symbol` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_node_callback_stacks_kind` (`kind`),
  KEY `index_node_callback_stacks_status` (`status`),
  KEY `index_node_callback_stacks_kind_status` (`kind`,`status`),
  KEY `index_node_callback_stacks_kind_flag` (`flag`),
  KEY `index_node_callback_stacks_cyber_kind` (`cyber_kind`),
  KEY `index_node_callback_stacks_created_at` (`created_at`),
  KEY `index_node_callback_stacks_on_contract_symbol` (`contract_symbol`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `announcement_id` bigint(20) unsigned NOT NULL COMMENT '公告ID',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已讀/未讀',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notifications_on_announcement_id` (`announcement_id`),
  KEY `index_notifications_on_user_id` (`user_id`),
  KEY `index_notifications_on_is_read` (`is_read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table npxs_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_curvies`;

CREATE TABLE `npxs_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_npxs_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_npxs_curvies_on_ati` (`ati`),
  KEY `index_npxs_curvies_on_close_oid` (`close_oid`),
  KEY `index_npxs_curvies_on_kind` (`kind`),
  KEY `index_npxs_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table npxs_eth_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_eth_order_matches`;

CREATE TABLE `npxs_eth_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方npxs異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方eth異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方npxs異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方eth異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(NPXS)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(NPXS)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(NPXS)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(NPXS)',
  PRIMARY KEY (`id`),
  KEY `index_npxs_eth_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_npxs_eth_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_npxs_eth_order_matches_on_kind` (`kind`),
  KEY `index_npxs_eth_order_matches_on_m_ati` (`m_ati`),
  KEY `index_npxs_eth_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_npxs_eth_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table npxs_eth_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_eth_orders`;

CREATE TABLE `npxs_eth_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'NPXS原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'NPXS已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'NPXS尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'NPXS手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 ETH_NPXS',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(NPXS)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(NPXS)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_npxs_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_npxs_eth_orders_on_is_market` (`is_market`),
  KEY `index_npxs_eth_orders_on_receipt_id` (`receipt_id`),
  KEY `index_npxs_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_npxs_eth_orders_on_status` (`status`),
  KEY `index_npxs_eth_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table npxs_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_invoices`;

CREATE TABLE `npxs_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_npxs_invoices_on_serial` (`serial`),
  KEY `index_npxs_invoices_on_height` (`height`),
  KEY `index_npxs_invoices_on_kind` (`kind`),
  KEY `index_npxs_invoices_on_order_kind` (`order_kind`),
  KEY `index_npxs_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_npxs_invoices_on_relation_id` (`relation_id`),
  KEY `index_npxs_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_npxs_invoices_on_status` (`status`),
  KEY `index_npxs_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_npxs_invoices_on_tindex` (`tindex`),
  KEY `index_npxs_invoices_on_txid` (`txid`),
  KEY `index_npxs_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table npxs_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_order_matches`;

CREATE TABLE `npxs_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_npxs_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_npxs_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_npxs_order_matches_on_kind` (`kind`),
  KEY `index_npxs_order_matches_on_m_ati` (`m_ati`),
  KEY `index_npxs_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_npxs_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table npxs_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_orders`;

CREATE TABLE `npxs_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_npxs_orders_on_is_buy` (`is_buy`),
  KEY `index_npxs_orders_on_is_market` (`is_market`),
  KEY `index_npxs_orders_on_receipt_id` (`receipt_id`),
  KEY `index_npxs_orders_on_refund_kind` (`refund_kind`),
  KEY `index_npxs_orders_on_status` (`status`),
  KEY `index_npxs_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table npxs_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `npxs_send_invoices`;

CREATE TABLE `npxs_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_npxs_send_invoices_on_height` (`height`),
  KEY `index_npxs_send_invoices_on_kind` (`kind`),
  KEY `index_npxs_send_invoices_on_status` (`status`),
  KEY `index_npxs_send_invoices_on_tindex` (`tindex`),
  KEY `index_npxs_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table panda_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_curvies`;

CREATE TABLE `panda_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_panda_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_panda_curvies_on_ati` (`ati`),
  KEY `index_panda_curvies_on_close_oid` (`close_oid`),
  KEY `index_panda_curvies_on_kind` (`kind`),
  KEY `index_panda_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table panda_eth_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_eth_order_matches`;

CREATE TABLE `panda_eth_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方panda異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方eth異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方panda異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方eth異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  PRIMARY KEY (`id`),
  KEY `index_panda_eth_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_panda_eth_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_panda_eth_order_matches_on_kind` (`kind`),
  KEY `index_panda_eth_order_matches_on_m_ati` (`m_ati`),
  KEY `index_panda_eth_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_panda_eth_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table panda_eth_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_eth_orders`;

CREATE TABLE `panda_eth_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 ETH_BITO',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_panda_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_panda_eth_orders_on_is_market` (`is_market`),
  KEY `index_panda_eth_orders_on_receipt_id` (`receipt_id`),
  KEY `index_panda_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_panda_eth_orders_on_status` (`status`),
  KEY `index_panda_eth_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table panda_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_invoices`;

CREATE TABLE `panda_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_panda_invoices_on_serial` (`serial`),
  KEY `index_panda_invoices_on_height` (`height`),
  KEY `index_panda_invoices_on_kind` (`kind`),
  KEY `index_panda_invoices_on_order_kind` (`order_kind`),
  KEY `index_panda_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_panda_invoices_on_relation_id` (`relation_id`),
  KEY `index_panda_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_panda_invoices_on_status` (`status`),
  KEY `index_panda_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_panda_invoices_on_tindex` (`tindex`),
  KEY `index_panda_invoices_on_txid` (`txid`),
  KEY `index_panda_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table panda_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_order_matches`;

CREATE TABLE `panda_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_panda_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_panda_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_panda_order_matches_on_kind` (`kind`),
  KEY `index_panda_order_matches_on_m_ati` (`m_ati`),
  KEY `index_panda_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_panda_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table panda_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_orders`;

CREATE TABLE `panda_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_panda_orders_on_is_buy` (`is_buy`),
  KEY `index_panda_orders_on_is_market` (`is_market`),
  KEY `index_panda_orders_on_receipt_id` (`receipt_id`),
  KEY `index_panda_orders_on_refund_kind` (`refund_kind`),
  KEY `index_panda_orders_on_status` (`status`),
  KEY `index_panda_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table panda_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `panda_send_invoices`;

CREATE TABLE `panda_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_panda_send_invoices_on_height` (`height`),
  KEY `index_panda_send_invoices_on_kind` (`kind`),
  KEY `index_panda_send_invoices_on_status` (`status`),
  KEY `index_panda_send_invoices_on_tindex` (`tindex`),
  KEY `index_panda_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table personal_notices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `personal_notices`;

CREATE TABLE `personal_notices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text,
  `user_id` bigint(20) unsigned NOT NULL,
  `event_type` varchar(255) DEFAULT NULL,
  `event_id` bigint(20) unsigned DEFAULT NULL COMMENT '事件',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已讀/未讀',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_personal_notices_on_event_type_and_event_id` (`event_type`,`event_id`),
  KEY `index_personal_notices_on_user_id` (`user_id`),
  KEY `index_personal_notices_on_event_id` (`event_id`),
  KEY `index_personal_notices_on_is_read` (`is_read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table profile_apis
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profile_apis`;

CREATE TABLE `profile_apis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) NOT NULL,
  `api_secret` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `kind` int(11) DEFAULT '0',
  `identifier` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_profile_apis_on_user_id` (`user_id`),
  KEY `index_profile_apis_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table profile_banks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profile_banks`;

CREATE TABLE `profile_banks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` tinyint(4) DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(100) DEFAULT NULL,
  `serial` smallint(6) NOT NULL,
  `branch` smallint(6) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `account_serial` varchar(80) NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `serial_group` varchar(30) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL COMMENT '送審時間',
  `approved_at` datetime DEFAULT NULL COMMENT '審核時間',
  `profile_kyc_id` bigint(20) unsigned DEFAULT NULL,
  `bank_memo` text COMMENT '管理者審核銀行回覆內容',
  PRIMARY KEY (`id`),
  KEY `index_profile_banks_on_user_id` (`user_id`),
  KEY `index_profile_banks_on_status` (`status`),
  KEY `index_profile_banks_on_is_default` (`is_default`),
  KEY `index_profile_banks_on_profile_kyc_id` (`profile_kyc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user驗證銀行';



# Dump of table profile_kycs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profile_kycs`;

CREATE TABLE `profile_kycs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '照片類型 0:身份證正面 1:居留證正面 ... 9: 與證件自拍照',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '審核狀態',
  PRIMARY KEY (`id`),
  KEY `index_profile_kycs_on_kind` (`kind`),
  KEY `index_profile_kycs_on_status` (`status`),
  KEY `index_profile_kycs_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User個資照片(一張一份)';



# Dump of table profiles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `birthday` date DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL COMMENT '+886912345678',
  `country_code` varchar(6) DEFAULT NULL COMMENT '+886',
  `kyc_status` tinyint(4) DEFAULT '0' COMMENT '審核狀態',
  `kyc_kind` tinyint(4) DEFAULT '0' COMMENT 'kyc類型 0:身份證 1:居留證',
  `credential_at` date DEFAULT NULL COMMENT '身分證發證日期/居留證核發日期',
  `credential_expire_at` date DEFAULT NULL COMMENT '居留期限',
  `sex` int(11) DEFAULT '0' COMMENT '0:不提供 1:男 2:女',
  `credential_site` varchar(10) DEFAULT NULL COMMENT '身分證發證地點 10001:北縣..',
  `credential_way` tinyint(4) DEFAULT NULL COMMENT '身分證補換發類別 0:初發...',
  `kyc_sub_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '各個驗證(證件自拍銀行)的狀態',
  `identity_memo` text COMMENT '管理者審核自拍回覆內容',
  `receipt_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '發票類別 捐贈/載具..',
  `last_name_s` varchar(255) DEFAULT NULL,
  `first_name_s` varchar(255) DEFAULT NULL,
  `id_number_s` varchar(255) DEFAULT NULL,
  `id_back_number_s` varchar(255) DEFAULT NULL,
  `ebody` text,
  `receipt_main_s` varchar(255) DEFAULT NULL,
  `receipt_sub_s` varchar(255) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL COMMENT '送審時間',
  `admin_memo` text COMMENT '管理者MEMO',
  `selfie_memo` text,
  `admin_should_check` tinyint(1) DEFAULT '0' COMMENT '可疑名單',
  UNIQUE KEY `index_profiles_on_user_id` (`user_id`),
  KEY `index_profiles_on_country_code` (`country_code`),
  KEY `index_profiles_on_mobile` (`mobile`),
  KEY `index_profiles_on_kyc_status` (`kyc_status`),
  KEY `index_profiles_on_kyc_kind` (`kyc_kind`),
  KEY `index_profiles_on_receipt_kind` (`receipt_kind`),
  KEY `index_profiles_on_admin_should_check` (`admin_should_check`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User個資KYC';



# Dump of table qntu_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_curvies`;

CREATE TABLE `qntu_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_qntu_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_qntu_curvies_on_ati` (`ati`),
  KEY `index_qntu_curvies_on_close_oid` (`close_oid`),
  KEY `index_qntu_curvies_on_kind` (`kind`),
  KEY `index_qntu_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table qntu_eth_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_eth_order_matches`;

CREATE TABLE `qntu_eth_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` int(11) NOT NULL DEFAULT '0',
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sprice` decimal(65,0) NOT NULL DEFAULT '0',
  `m_c_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL,
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方qntu異動數量',
  `b_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方eth異動數量',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方qntu異動數量',
  `s_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '賣方eth異動數量',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `b_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `b_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `s_ori_c_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `s_ori_c_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  PRIMARY KEY (`id`),
  KEY `index_qntu_eth_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_qntu_eth_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_qntu_eth_order_matches_on_kind` (`kind`),
  KEY `index_qntu_eth_order_matches_on_m_ati` (`m_ati`),
  KEY `index_qntu_eth_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_qntu_eth_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table qntu_eth_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_eth_orders`;

CREATE TABLE `qntu_eth_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `sprice` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '掛單價 0.000037',
  `ori_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '中心貨幣(center)總價值 price * ori_samount',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO原始掛單數量 7000',
  `trade_c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH已成交價值',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO已成交數量',
  `c_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH尚未成交價值',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO尚未成交數量',
  `c_sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ETH手續費(sell)',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'BITO手續費(buy)',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_sprice` decimal(65,0) DEFAULT '0' COMMENT '成交均價 ETH_BITO',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `ori_c_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(ETH)',
  `ori_c_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(ETH)',
  `ori_saccount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '可用餘額(BITO)',
  `ori_saccount_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易中(BITO)',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_qntu_eth_orders_on_is_buy` (`is_buy`),
  KEY `index_qntu_eth_orders_on_is_market` (`is_market`),
  KEY `index_qntu_eth_orders_on_receipt_id` (`receipt_id`),
  KEY `index_qntu_eth_orders_on_refund_kind` (`refund_kind`),
  KEY `index_qntu_eth_orders_on_status` (`status`),
  KEY `index_qntu_eth_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table qntu_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_invoices`;

CREATE TABLE `qntu_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_qntu_invoices_on_serial` (`serial`),
  KEY `index_qntu_invoices_on_height` (`height`),
  KEY `index_qntu_invoices_on_kind` (`kind`),
  KEY `index_qntu_invoices_on_order_kind` (`order_kind`),
  KEY `index_qntu_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_qntu_invoices_on_relation_id` (`relation_id`),
  KEY `index_qntu_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_qntu_invoices_on_status` (`status`),
  KEY `index_qntu_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_qntu_invoices_on_tindex` (`tindex`),
  KEY `index_qntu_invoices_on_txid` (`txid`),
  KEY `index_qntu_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table qntu_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_order_matches`;

CREATE TABLE `qntu_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_qntu_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_qntu_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_qntu_order_matches_on_kind` (`kind`),
  KEY `index_qntu_order_matches_on_m_ati` (`m_ati`),
  KEY `index_qntu_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_qntu_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table qntu_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_orders`;

CREATE TABLE `qntu_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_qntu_orders_on_is_buy` (`is_buy`),
  KEY `index_qntu_orders_on_is_market` (`is_market`),
  KEY `index_qntu_orders_on_receipt_id` (`receipt_id`),
  KEY `index_qntu_orders_on_refund_kind` (`refund_kind`),
  KEY `index_qntu_orders_on_status` (`status`),
  KEY `index_qntu_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table qntu_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `qntu_send_invoices`;

CREATE TABLE `qntu_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_qntu_send_invoices_on_height` (`height`),
  KEY `index_qntu_send_invoices_on_kind` (`kind`),
  KEY `index_qntu_send_invoices_on_status` (`status`),
  KEY `index_qntu_send_invoices_on_tindex` (`tindex`),
  KEY `index_qntu_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table ratelimit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ratelimit`;

CREATE TABLE `ratelimit` (
  `endpoint` varchar(16) NOT NULL,
  `method` varchar(6) NOT NULL,
  `criteria` varchar(64) DEFAULT NULL,
  `priority` int(11) DEFAULT '0',
  `duration` int(11) DEFAULT '0',
  `limit` int(11) DEFAULT '1',
  PRIMARY KEY (`endpoint`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ratelimit設定';



# Dump of table receipts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `receipts`;

CREATE TABLE `receipts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `twd_amount` int(11) NOT NULL,
  `status` int(11) DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '發票類別(捐贈..)',
  `serial` varchar(150) DEFAULT NULL,
  `source_type` varchar(255) DEFAULT NULL COMMENT '原訂單type',
  `source_id` bigint(20) unsigned DEFAULT NULL COMMENT '原訂單id',
  `trans_at` datetime DEFAULT NULL COMMENT '開立完成時間',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ebody` text,
  `data_main_s` varchar(255) DEFAULT NULL,
  `data_sub_s` varchar(255) DEFAULT NULL,
  `receipted_at` datetime NOT NULL COMMENT '發票需開立的時間',
  `sfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費數量',
  `source_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '原訂單子類',
  `real_receipted_at` datetime DEFAULT NULL COMMENT '發票真實開立日期',
  PRIMARY KEY (`id`),
  KEY `index_receipts_on_user_id` (`user_id`),
  KEY `index_receipts_on_status` (`status`),
  KEY `index_receipts_on_kind` (`kind`),
  KEY `index_receipts_on_serial` (`serial`),
  KEY `index_receipts_on_source_type` (`source_type`),
  KEY `index_receipts_on_source_id` (`source_id`),
  KEY `index_receipts_on_trans_at` (`trans_at`),
  KEY `index_receipts_on_receipted_at` (`receipted_at`),
  KEY `index_receipts_on_source_kind` (`source_kind`),
  KEY `index_receipts_on_real_receipted_at` (`real_receipted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table rpc_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rpc_curvies`;

CREATE TABLE `rpc_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_rpc_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_rpc_curvies_on_ati` (`ati`),
  KEY `index_rpc_curvies_on_close_oid` (`close_oid`),
  KEY `index_rpc_curvies_on_kind` (`kind`),
  KEY `index_rpc_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table rpc_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rpc_invoices`;

CREATE TABLE `rpc_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_rpc_invoices_on_serial` (`serial`),
  KEY `index_rpc_invoices_on_height` (`height`),
  KEY `index_rpc_invoices_on_kind` (`kind`),
  KEY `index_rpc_invoices_on_order_kind` (`order_kind`),
  KEY `index_rpc_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_rpc_invoices_on_relation_id` (`relation_id`),
  KEY `index_rpc_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_rpc_invoices_on_status` (`status`),
  KEY `index_rpc_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_rpc_invoices_on_tindex` (`tindex`),
  KEY `index_rpc_invoices_on_txid` (`txid`),
  KEY `index_rpc_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table rpc_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rpc_order_matches`;

CREATE TABLE `rpc_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_rpc_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_rpc_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_rpc_order_matches_on_kind` (`kind`),
  KEY `index_rpc_order_matches_on_m_ati` (`m_ati`),
  KEY `index_rpc_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_rpc_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table rpc_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rpc_orders`;

CREATE TABLE `rpc_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_rpc_orders_on_is_buy` (`is_buy`),
  KEY `index_rpc_orders_on_is_market` (`is_market`),
  KEY `index_rpc_orders_on_receipt_id` (`receipt_id`),
  KEY `index_rpc_orders_on_refund_kind` (`refund_kind`),
  KEY `index_rpc_orders_on_status` (`status`),
  KEY `index_rpc_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table rpc_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rpc_send_invoices`;

CREATE TABLE `rpc_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rpc_send_invoices_on_height` (`height`),
  KEY `index_rpc_send_invoices_on_kind` (`kind`),
  KEY `index_rpc_send_invoices_on_status` (`status`),
  KEY `index_rpc_send_invoices_on_tindex` (`tindex`),
  KEY `index_rpc_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;

INSERT INTO `schema_migrations` (`version`)
VALUES
	('20170625054312'),
	('20170727105532'),
	('20170802111032'),
	('20170803044258'),
	('20170804091618'),
	('20170808072805'),
	('20170808103340'),
	('20170808112623'),
	('20170809052759'),
	('20170809054049'),
	('20170809074508'),
	('20170809083207'),
	('20170811064236'),
	('20170813173027'),
	('20170814072412'),
	('20170815103257'),
	('20170815105328'),
	('20170816084644'),
	('20170816093942'),
	('20170817025620'),
	('20170817073522'),
	('20170817084227'),
	('20170822073319'),
	('20170825062804'),
	('20170825072411'),
	('20170829063524'),
	('20170829064805'),
	('20170831033517'),
	('20170907022941'),
	('20170919103351'),
	('20170920084449'),
	('20170921084041'),
	('20170925120014'),
	('20170927062153'),
	('20170927104754'),
	('20170928035343'),
	('20170929031620'),
	('20170930085124'),
	('20170930091347'),
	('20171005063255'),
	('20171011070500'),
	('20171023065111'),
	('20171026051643'),
	('20171026061130'),
	('20171031083119'),
	('20171101055603'),
	('20171101071322'),
	('20171102032726'),
	('20171102092003'),
	('20171102132857'),
	('20171103021942'),
	('20171103081831'),
	('20171110053318'),
	('20171111071055'),
	('20171114095052'),
	('20171116101726'),
	('20171124033513'),
	('20171124101600'),
	('20171127033556'),
	('20171127083150'),
	('20171127084406'),
	('20171129072613'),
	('20171129124540'),
	('20171129124759'),
	('20171214060348'),
	('20171216063051'),
	('20171223092528'),
	('20171226123631'),
	('20180103075528'),
	('20180103101516'),
	('20180104064248'),
	('20180105171035'),
	('20180105172217'),
	('20180109094032'),
	('20180111061734'),
	('20180112031552'),
	('20180115044538'),
	('20180117092502'),
	('20180118080453'),
	('20180122113553'),
	('20180123064808'),
	('20180124050417'),
	('20180124095612'),
	('20180125093629'),
	('20180129094609'),
	('20180131101039'),
	('20180206092459'),
	('20180208091618'),
	('20180212080816'),
	('20180212083211'),
	('20180212085948'),
	('20180214041020'),
	('20180214082432'),
	('20180221082300'),
	('20180223031747'),
	('20180225060904'),
	('20180226042802'),
	('20180306055953'),
	('20180306075632'),
	('20180306134829'),
	('20180307033250'),
	('20180308064033'),
	('20180308083042'),
	('20180309054010'),
	('20180322083746'),
	('20180322103708'),
	('20180323102422'),
	('20180324153144'),
	('20180325022931'),
	('20180327041759'),
	('20180327041931'),
	('20180327042038'),
	('20180327075024'),
	('20180327103705'),
	('20180328083951'),
	('20180328084012'),
	('20180328084028'),
	('20180328084030'),
	('20180328084128'),
	('20180328084129'),
	('20180329023525'),
	('20180402035734'),
	('20180402061212'),
	('20180403020636'),
	('20180403024512'),
	('20180409060217'),
	('20180412040734'),
	('20180413084254'),
	('20180413111422'),
	('20180418100109'),
	('20180419035229'),
	('20180426061519'),
	('20180427041550'),
	('20180427055710'),
	('20180503101327'),
	('20180507051253'),
	('20180508045311'),
	('20180508072421'),
	('20180510071922'),
	('20180518073512'),
	('20180524040322'),
	('20180526080702'),
	('20180528042535'),
	('20180530044750'),
	('20180530061625'),
	('20180531050953'),
	('20180531075224'),
	('20180601035301'),
	('20180601082001'),
	('20180604043251'),
	('20180606061139'),
	('20180611070416'),
	('20180619092410'),
	('20180620032639'),
	('20180620065214'),
	('20180622044444'),
	('20180626030244'),
	('20180626080506'),
	('20180626081723'),
	('20180702063031'),
	('20180709030030'),
	('20180709042506'),
	('20180710024357'),
	('20180710180608'),
	('20180716100447'),
	('20180719074537'),
	('20180724062225'),
	('20180728051318'),
	('20180731075430'),
	('20180802082515'),
	('20180808040533'),
	('20180809093631'),
	('20180813071445'),
	('20180814051728'),
	('20180814060222'),
	('20180815044139'),
	('20180815061824'),
	('20180820061911'),
	('20180821053516'),
	('20180824081729'),
	('20180828064252'),
	('20180828064305'),
	('20180828064321'),
	('20180830121458'),
	('20180911024734'),
	('20180912065116'),
	('20180912065727');

/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sda_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sda_curvies`;

CREATE TABLE `sda_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sda_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_sda_curvies_on_ati` (`ati`),
  KEY `index_sda_curvies_on_close_oid` (`close_oid`),
  KEY `index_sda_curvies_on_kind` (`kind`),
  KEY `index_sda_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sda_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sda_invoices`;

CREATE TABLE `sda_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sda_invoices_on_serial` (`serial`),
  KEY `index_sda_invoices_on_height` (`height`),
  KEY `index_sda_invoices_on_kind` (`kind`),
  KEY `index_sda_invoices_on_order_kind` (`order_kind`),
  KEY `index_sda_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_sda_invoices_on_relation_id` (`relation_id`),
  KEY `index_sda_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_sda_invoices_on_status` (`status`),
  KEY `index_sda_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_sda_invoices_on_tindex` (`tindex`),
  KEY `index_sda_invoices_on_txid` (`txid`),
  KEY `index_sda_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table sda_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sda_order_matches`;

CREATE TABLE `sda_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_sda_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_sda_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_sda_order_matches_on_kind` (`kind`),
  KEY `index_sda_order_matches_on_m_ati` (`m_ati`),
  KEY `index_sda_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_sda_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sda_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sda_orders`;

CREATE TABLE `sda_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_sda_orders_on_is_buy` (`is_buy`),
  KEY `index_sda_orders_on_is_market` (`is_market`),
  KEY `index_sda_orders_on_receipt_id` (`receipt_id`),
  KEY `index_sda_orders_on_refund_kind` (`refund_kind`),
  KEY `index_sda_orders_on_status` (`status`),
  KEY `index_sda_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sda_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sda_send_invoices`;

CREATE TABLE `sda_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sda_send_invoices_on_height` (`height`),
  KEY `index_sda_send_invoices_on_kind` (`kind`),
  KEY `index_sda_send_invoices_on_status` (`status`),
  KEY `index_sda_send_invoices_on_tindex` (`tindex`),
  KEY `index_sda_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table simple_captcha_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `simple_captcha_data`;

CREATE TABLE `simple_captcha_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(40) DEFAULT NULL,
  `value` varchar(6) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_simple_captcha_data_on_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table site_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_settings`;

CREATE TABLE `site_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL DEFAULT '',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `str_value` varchar(255) DEFAULT NULL,
  `int_value` int(11) DEFAULT NULL,
  `flt_value` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_site_settings_on_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='後台系統參數';

LOCK TABLES `site_settings` WRITE;
/*!40000 ALTER TABLE `site_settings` DISABLE KEYS */;

INSERT INTO `site_settings` (`id`, `key`, `kind`, `str_value`, `int_value`, `flt_value`)
VALUES
	(1,'BtcWithdrawMax',2,NULL,NULL,50),
	(2,'updated_ati',0,NULL,1530505938,NULL),
	(3,'BtcWithdrawDaily',2,NULL,NULL,100),
	(4,'LtcWithdrawMax',2,NULL,NULL,5000),
	(5,'LtcWithdrawDaily',2,NULL,NULL,10000),
	(6,'EthWithdrawMax',2,NULL,NULL,50),
	(7,'EthWithdrawDaily',2,NULL,NULL,500),
	(8,'BchWithdrawMax',2,NULL,NULL,50),
	(9,'BchWithdrawDaily',2,NULL,NULL,500),
	(10,'BtgWithdrawMax',2,NULL,NULL,500),
	(11,'BtgWithdrawDaily',2,NULL,NULL,2500),
	(12,'BcdWithdrawMax',2,NULL,NULL,5000),
	(13,'BcdWithdrawDaily',2,NULL,NULL,10000),
	(14,'BtcWithdrawMin',2,NULL,NULL,0.0001),
	(15,'BtcWithdrawFee',2,NULL,NULL,0.0001),
	(16,'BtgWithdrawMin',2,NULL,NULL,0),
	(17,'BtgWithdrawFee',2,NULL,NULL,0),
	(18,'BcdWithdrawMin',2,NULL,NULL,0.001),
	(19,'BcdWithdrawFee',2,NULL,NULL,0.001),
	(20,'BuyMakerFee',2,NULL,NULL,0),
	(21,'BuyTakerFee',2,NULL,NULL,0),
	(22,'SellMakerFee',2,NULL,NULL,0),
	(23,'SellTakerFee',2,NULL,NULL,0),
	(24,'BtcConfirm',1,NULL,4,NULL),
	(25,'CgpTestNetExplorer',0,'https://ropsten.etherscan.io/tx/',NULL,NULL),
	(26,'BitoTestNetExplorer',0,'https://ropsten.etherscan.io/tx/',NULL,NULL),
	(27,'CgpExplorer',0,'https://etherscan.io/tx/',NULL,NULL),
	(28,'BitoExplorer',0,'https://etherscan.io/tx/',NULL,NULL),
	(29,'PandaExplorer',0,'https://etherscan.io/tx/',NULL,NULL),
	(30,'PandaTestNetExplorer',0,'https://ropsten.etherscan.io/tx/',NULL,NULL),
	(31,'BitoDepositMin',2,NULL,NULL,0),
	(32,'BitoDepositMinFee',2,NULL,NULL,4),
	(33,'BitoWithdrawMin',2,NULL,NULL,70),
	(34,'BitoWithdrawMax',2,NULL,NULL,60000),
	(35,'BitoWithdrawFee',2,NULL,NULL,4),
	(36,'BitoWithdrawDaily',2,NULL,NULL,120000),
	(37,'BitoConfirm',1,NULL,20,NULL),
	(38,'CgpTradeMin',2,NULL,NULL,20),
	(39,'BitoTradeMin',2,NULL,NULL,125),
	(40,'PandaTradeMin',2,NULL,NULL,125),
	(41,'CgpDepositMin',2,NULL,NULL,0),
	(42,'CgpDepositMinFee',2,NULL,NULL,1),
	(43,'CgpWithdrawMin',2,NULL,NULL,15),
	(44,'CgpWithdrawMax',2,NULL,NULL,10000),
	(45,'CgpWithdrawFee',2,NULL,NULL,1),
	(46,'CgpWithdrawDaily',2,NULL,NULL,20000),
	(47,'CgpConfirm',1,NULL,20,NULL),
	(48,'PandaDepositMin',2,NULL,NULL,0),
	(49,'PandaDepositMinFee',2,NULL,NULL,4),
	(50,'PandaWithdrawMin',2,NULL,NULL,70),
	(51,'PandaWithdrawMax',2,NULL,NULL,60000),
	(52,'PandaWithdrawFee',2,NULL,NULL,4),
	(53,'PandaWithdrawDaily',2,NULL,NULL,120000),
	(54,'PandaConfirm',1,NULL,20,NULL),
	(55,'NodeBtgRevFeeModeSplit',0,'B|100000,C1,Z0|50000000,B20,Z100|6553500000000,B12,Z20',NULL,NULL),
	(56,'MithDepositMin',2,NULL,NULL,0),
	(57,'AllnMarketBuyMinTwd',1,NULL,1000,NULL),
	(58,'SdaTradeMin',2,NULL,NULL,670);

/*!40000 ALTER TABLE `site_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_status`;

CREATE TABLE `site_status` (
  `key` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `str_value` varchar(255) DEFAULT NULL,
  `int_value` int(11) DEFAULT NULL,
  `flt_value` float DEFAULT NULL,
  `txt_value` text,
  `updated_ati` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `index_site_status_on_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trans_balances
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trans_balances`;

CREATE TABLE `trans_balances` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `source_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `bch_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `btg_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `bcd_samount` decimal(16,0) NOT NULL DEFAULT '0',
  `serial` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trans_balances_on_source_user_id` (`source_user_id`),
  UNIQUE KEY `index_trans_balances_on_serial` (`serial`),
  KEY `index_trans_balances_on_target_user_id` (`target_user_id`),
  KEY `index_trans_balances_on_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BitoEX移轉餘額列表';



# Dump of table trx_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trx_curvies`;

CREATE TABLE `trx_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trx_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_trx_curvies_on_ati` (`ati`),
  KEY `index_trx_curvies_on_close_oid` (`close_oid`),
  KEY `index_trx_curvies_on_kind` (`kind`),
  KEY `index_trx_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trx_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trx_invoices`;

CREATE TABLE `trx_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trx_invoices_on_serial` (`serial`),
  KEY `index_trx_invoices_on_height` (`height`),
  KEY `index_trx_invoices_on_kind` (`kind`),
  KEY `index_trx_invoices_on_order_kind` (`order_kind`),
  KEY `index_trx_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_trx_invoices_on_relation_id` (`relation_id`),
  KEY `index_trx_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_trx_invoices_on_status` (`status`),
  KEY `index_trx_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_trx_invoices_on_tindex` (`tindex`),
  KEY `index_trx_invoices_on_txid` (`txid`),
  KEY `index_trx_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table trx_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trx_order_matches`;

CREATE TABLE `trx_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_trx_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_trx_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_trx_order_matches_on_kind` (`kind`),
  KEY `index_trx_order_matches_on_m_ati` (`m_ati`),
  KEY `index_trx_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_trx_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trx_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trx_orders`;

CREATE TABLE `trx_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_trx_orders_on_is_buy` (`is_buy`),
  KEY `index_trx_orders_on_is_market` (`is_market`),
  KEY `index_trx_orders_on_receipt_id` (`receipt_id`),
  KEY `index_trx_orders_on_refund_kind` (`refund_kind`),
  KEY `index_trx_orders_on_status` (`status`),
  KEY `index_trx_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trx_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trx_send_invoices`;

CREATE TABLE `trx_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_trx_send_invoices_on_height` (`height`),
  KEY `index_trx_send_invoices_on_kind` (`kind`),
  KEY `index_trx_send_invoices_on_status` (`status`),
  KEY `index_trx_send_invoices_on_tindex` (`tindex`),
  KEY `index_trx_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table ttcodes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ttcodes`;

CREATE TABLE `ttcodes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `serial` varchar(60) DEFAULT NULL,
  `twd_amount` decimal(16,0) DEFAULT '0',
  `rate` decimal(16,0) DEFAULT NULL,
  `symbol` varchar(10) DEFAULT NULL,
  `samount` decimal(16,0) DEFAULT '0',
  `vendor` varchar(20) DEFAULT NULL,
  `serial_group` varchar(30) DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `source_type` varchar(255) DEFAULT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `admin_receipt_id` int(11) DEFAULT NULL,
  `is_downloaded` tinyint(1) NOT NULL DEFAULT '0',
  `is_callbacked` tinyint(1) NOT NULL DEFAULT '0',
  `memo` varchar(255) DEFAULT NULL,
  `retry_counter` int(11) DEFAULT '0',
  `retry_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ttcodes_on_user_id` (`user_id`),
  KEY `index_ttcodes_on_kind` (`kind`),
  KEY `index_ttcodes_on_status` (`status`),
  KEY `index_ttcodes_on_serial` (`serial`),
  KEY `index_ttcodes_on_source_type` (`source_type`),
  KEY `index_ttcodes_on_source_id` (`source_id`),
  KEY `index_ttcodes_on_serial_group` (`serial_group`),
  KEY `index_ttcodes_on_admin_receipt_id` (`admin_receipt_id`),
  KEY `index_ttcodes_on_is_downloaded` (`is_downloaded`),
  KEY `index_ttcodes_on_is_callbacked` (`is_callbacked`),
  KEY `index_ttcodes_on_retry_counter` (`retry_counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usdt_curvies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usdt_curvies`;

CREATE TABLE `usdt_curvies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ati` bigint(20) unsigned NOT NULL,
  `svolume` decimal(19,0) NOT NULL DEFAULT '0',
  `open` decimal(18,2) NOT NULL DEFAULT '0.00',
  `close` decimal(18,2) NOT NULL DEFAULT '0.00',
  `high` decimal(18,2) NOT NULL DEFAULT '0.00',
  `low` decimal(18,2) NOT NULL DEFAULT '0.00',
  `kind` tinyint(4) DEFAULT '0',
  `open_oid` int(11) NOT NULL,
  `close_oid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_usdt_curvies_on_ati_and_kind` (`ati`,`kind`),
  KEY `index_usdt_curvies_on_ati` (`ati`),
  KEY `index_usdt_curvies_on_close_oid` (`close_oid`),
  KEY `index_usdt_curvies_on_kind` (`kind`),
  KEY `index_usdt_curvies_on_open_oid` (`open_oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usdt_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usdt_invoices`;

CREATE TABLE `usdt_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `sub_kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `relation_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的user_id',
  `relation_id` bigint(20) unsigned DEFAULT NULL COMMENT '內轉發送/接收的對方單的id',
  `order_kind` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費實數',
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  `confirm_at` datetime DEFAULT NULL,
  `trans_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `deleted_memo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_at` datetime DEFAULT NULL,
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `mailed_at` datetime DEFAULT NULL,
  `rate` decimal(12,0) DEFAULT NULL COMMENT '發送當下匯率(會計用)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領等值台幣手續費(發票)',
  `dprice` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '提領時匯率',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '實際原始金額',
  `ori_saccount_pddt` decimal(65,0) DEFAULT NULL,
  `samount_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '虛數，pddt必須算decimal',
  `sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '使用者支付的手續費虛數，rddt為8位',
  `from_wallet` varchar(255) DEFAULT NULL,
  `to_wallet` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `ori_samount_pddt` decimal(65,0) DEFAULT NULL,
  `trans_sfee` decimal(65,0) DEFAULT '0' COMMENT '鍊上交易手續費實數',
  `trans_sfee_rddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '鍊上交易手續費虛數，rddt為8位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_usdt_invoices_on_serial` (`serial`),
  KEY `index_usdt_invoices_on_height` (`height`),
  KEY `index_usdt_invoices_on_kind` (`kind`),
  KEY `index_usdt_invoices_on_order_kind` (`order_kind`),
  KEY `index_usdt_invoices_on_receipt_id` (`receipt_id`),
  KEY `index_usdt_invoices_on_relation_id` (`relation_id`),
  KEY `index_usdt_invoices_on_relation_user_id` (`relation_user_id`),
  KEY `index_usdt_invoices_on_status` (`status`),
  KEY `index_usdt_invoices_on_sub_kind` (`sub_kind`),
  KEY `index_usdt_invoices_on_tindex` (`tindex`),
  KEY `index_usdt_invoices_on_txid` (`txid`),
  KEY `index_usdt_invoices_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC帳';



# Dump of table usdt_order_matches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usdt_order_matches`;

CREATE TABLE `usdt_order_matches` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_order_id` bigint(20) unsigned NOT NULL,
  `b_user_id` bigint(20) unsigned NOT NULL,
  `b_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `b_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `b_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `b_ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘BTC待交易量',
  `b_ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '前次剩餘現金待交易量',
  `s_order_id` bigint(20) unsigned NOT NULL,
  `s_user_id` bigint(20) unsigned NOT NULL,
  `s_is_market` tinyint(1) NOT NULL DEFAULT '0',
  `s_is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `s_ori_samount` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `m_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '交易數量S',
  `m_dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易價格',
  `m_dfee` decimal(16,0) NOT NULL DEFAULT '0',
  `m_sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `m_ati` bigint(20) unsigned NOT NULL COMMENT '交易時間',
  `b_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `b_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `s_ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `s_ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `b_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方cyber變動量(餘額/交易)',
  `b_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `s_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '賣方cyber變動量(餘額/交易)',
  `s_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '買方現金變動量(餘額/交易)',
  `kind` int(11) NOT NULL DEFAULT '0',
  `is_up` tinyint(1) NOT NULL DEFAULT '0',
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `s_ori_damount` decimal(16,0) NOT NULL DEFAULT '0',
  `m_dfee_fix` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '手續費反向補正(負值)',
  PRIMARY KEY (`id`),
  KEY `index_usdt_order_matches_on_b_order_id` (`b_order_id`),
  KEY `index_usdt_order_matches_on_b_user_id` (`b_user_id`),
  KEY `index_usdt_order_matches_on_kind` (`kind`),
  KEY `index_usdt_order_matches_on_m_ati` (`m_ati`),
  KEY `index_usdt_order_matches_on_s_order_id` (`s_order_id`),
  KEY `index_usdt_order_matches_on_s_user_id` (`s_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usdt_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usdt_orders`;

CREATE TABLE `usdt_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL,
  `ori_daccount` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount` decimal(65,0) NOT NULL DEFAULT '0',
  `is_buy` tinyint(1) NOT NULL,
  `is_market` tinyint(1) NOT NULL,
  `dprice` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '掛單價 50000.1',
  `ori_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '總價值 25000',
  `ori_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '原始掛單數量 0.5',
  `trade_damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '已成交金額(總價值) 0 -> 25000',
  `trade_samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '已成交數量 0 -> 0.5',
  `damount` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '尚未成交金額 25000 -> 0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0' COMMENT '尚未成交數量(主要) 0.5 -> 0',
  `dfee` decimal(16,0) NOT NULL DEFAULT '0' COMMENT '現金手續費',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt_orders_on_user_id',
  `created_ati` bigint(20) unsigned NOT NULL,
  `updated_ati` bigint(20) unsigned NOT NULL,
  `matched_ati` bigint(20) unsigned DEFAULT NULL COMMENT '完成時間',
  `deleted_ati` bigint(20) unsigned DEFAULT NULL,
  `avg_price` decimal(16,4) DEFAULT NULL COMMENT '成交均價',
  `refund_kind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '買單補正 0:不需退, 1:需退, 2:已退',
  `ori_daccount_trade` decimal(16,0) NOT NULL DEFAULT '0',
  `ori_saccount_trade` decimal(65,0) NOT NULL DEFAULT '0',
  `twd_fee` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '等值台幣手續費(發票)',
  `receipt_id` bigint(20) unsigned DEFAULT NULL,
  `created_atu` decimal(14,4) DEFAULT '0.0000',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '訂單來源',
  PRIMARY KEY (`id`),
  KEY `index_usdt_orders_on_is_buy` (`is_buy`),
  KEY `index_usdt_orders_on_is_market` (`is_market`),
  KEY `index_usdt_orders_on_receipt_id` (`receipt_id`),
  KEY `index_usdt_orders_on_refund_kind` (`refund_kind`),
  KEY `index_usdt_orders_on_status` (`status`),
  KEY `index_usdt_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usdt_send_invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usdt_send_invoices`;

CREATE TABLE `usdt_send_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `samount` decimal(65,0) NOT NULL DEFAULT '0',
  `sfee` decimal(65,0) NOT NULL DEFAULT '0',
  `wallet` varchar(62) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `tindex` int(11) DEFAULT NULL,
  `confirm_count` tinyint(4) NOT NULL DEFAULT '0',
  `confirm_ati` bigint(20) unsigned DEFAULT NULL,
  `trans_ati` bigint(20) unsigned DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_usdt_send_invoices_on_height` (`height`),
  KEY `index_usdt_send_invoices_on_kind` (`kind`),
  KEY `index_usdt_send_invoices_on_status` (`status`),
  KEY `index_usdt_send_invoices_on_tindex` (`tindex`),
  KEY `index_usdt_send_invoices_on_txid` (`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cyber歸帳用';



# Dump of table user_accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_accounts`;

CREATE TABLE `user_accounts` (
  `user_id` bigint(20) unsigned NOT NULL,
  `btc` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btc餘額',
  `btc_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btc交易中',
  `ltc` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'ltc餘額',
  `ltc_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'ltc交易中',
  `eth` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'eth餘額',
  `eth_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'eth交易中',
  `twd` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'twd餘額',
  `twd_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'twd交易中',
  `bch` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bch餘額',
  `bch_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bch交易中',
  `eth_rddt` decimal(10,0) NOT NULL DEFAULT '0',
  `verifier` varchar(512) DEFAULT NULL,
  `btg` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg餘額',
  `btg_trans` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg等待中',
  `btg_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg交易中',
  `bcd` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bcd餘額',
  `bcd_trans` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bcd等待中',
  `bcd_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bcd交易中',
  `bito` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito餘額',
  `bito_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito交易中',
  `panda` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda餘額',
  `panda_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda交易中',
  `cgp` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp餘額',
  `cgp_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp交易中',
  `ethc` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ethc餘額',
  `bito_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito餘額_小數點下',
  `panda_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda餘額_小數點下',
  `cgp_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp餘額_小數點下',
  `ethc_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ethc餘額_小數點下',
  `trx` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx餘額',
  `trx_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx交易中',
  `trx_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx餘額_小數點下',
  `mith` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith餘額',
  `mith_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith交易中',
  `mith_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith餘額_小數點下',
  `sda` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda餘額',
  `sda_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda交易中',
  `sda_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda餘額_小數點下',
  `alln` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln餘額',
  `alln_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln交易中',
  `alln_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln餘額_小數點下',
  `modl` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl餘額',
  `modl_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl交易中',
  `modl_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl餘額_小數點下',
  `usdt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt餘額',
  `usdt_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt交易中',
  `usdt_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt餘額_小數點下',
  `qntu` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu餘額',
  `qntu_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu交易中',
  `qntu_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu餘額_小數點下',
  `rpc` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc餘額',
  `rpc_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc交易中',
  `rpc_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc餘額_小數點下',
  `npxs` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs餘額',
  `npxs_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs交易中',
  `npxs_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs餘額_小數點下',
  `verification` varchar(512) DEFAULT NULL,
  UNIQUE KEY `index_user_accounts_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User持有貨幣';

LOCK TABLES `user_accounts` WRITE;
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;

INSERT INTO `user_accounts` (`user_id`, `btc`, `btc_trade`, `ltc`, `ltc_trade`, `eth`, `eth_trade`, `twd`, `twd_trade`, `bch`, `bch_trade`, `eth_rddt`, `verifier`, `btg`, `btg_trans`, `btg_trade`, `bcd`, `bcd_trans`, `bcd_trade`, `bito`, `bito_trade`, `panda`, `panda_trade`, `cgp`, `cgp_trade`, `ethc`, `bito_pddt`, `panda_pddt`, `cgp_pddt`, `ethc_pddt`, `trx`, `trx_trade`, `trx_pddt`, `mith`, `mith_trade`, `mith_pddt`, `sda`, `sda_trade`, `sda_pddt`, `alln`, `alln_trade`, `alln_pddt`, `modl`, `modl_trade`, `modl_pddt`, `usdt`, `usdt_trade`, `usdt_pddt`, `qntu`, `qntu_trade`, `qntu_pddt`, `rpc`, `rpc_trade`, `rpc_pddt`, `npxs`, `npxs_trade`, `npxs_pddt`, `verification`)
VALUES
	(9527,0,0,0,0,8999981837948244,18162051756,0,0,0,0,0,NULL,0,0,0,0,0,0,8999999999999933,67,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL);

/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_accounts_bak
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_accounts_bak`;

CREATE TABLE `user_accounts_bak` (
  `user_id` bigint(20) unsigned NOT NULL,
  `btc` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btc餘額',
  `btc_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btc交易中',
  `ltc` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'ltc餘額',
  `ltc_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'ltc交易中',
  `eth` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'eth餘額',
  `eth_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'eth交易中',
  `twd` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'twd餘額',
  `twd_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'twd交易中',
  `bch` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bch餘額',
  `bch_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bch交易中',
  `eth_rddt` decimal(10,0) NOT NULL DEFAULT '0',
  `verifier` varchar(512) DEFAULT NULL,
  `btg` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg餘額',
  `btg_trans` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg等待中',
  `btg_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'btg交易中',
  `bcd` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bcd餘額',
  `bcd_trans` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bcd等待中',
  `bcd_trade` decimal(16,0) NOT NULL DEFAULT '0' COMMENT 'bcd交易中',
  `bito` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito餘額',
  `bito_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito交易中',
  `panda` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda餘額',
  `panda_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda交易中',
  `cgp` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp餘額',
  `cgp_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp交易中',
  `ethc` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ethc餘額',
  `bito_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'bito餘額_小數點下',
  `panda_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'panda餘額_小數點下',
  `cgp_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'cgp餘額_小數點下',
  `ethc_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'ethc餘額_小數點下',
  `trx` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx餘額',
  `trx_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx交易中',
  `trx_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'trx餘額_小數點下',
  `mith` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith餘額',
  `mith_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith交易中',
  `mith_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'mith餘額_小數點下',
  `sda` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda餘額',
  `sda_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda交易中',
  `sda_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'sda餘額_小數點下',
  `alln` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln餘額',
  `alln_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln交易中',
  `alln_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'alln餘額_小數點下',
  `modl` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl餘額',
  `modl_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl交易中',
  `modl_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'modl餘額_小數點下',
  `usdt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt餘額',
  `usdt_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt交易中',
  `usdt_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'usdt餘額_小數點下',
  `qntu` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu餘額',
  `qntu_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu交易中',
  `qntu_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'qntu餘額_小數點下',
  `rpc` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc餘額',
  `rpc_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc交易中',
  `rpc_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'rpc餘額_小數點下',
  `npxs` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs餘額',
  `npxs_trade` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs交易中',
  `npxs_pddt` decimal(65,0) NOT NULL DEFAULT '0' COMMENT 'npxs餘額_小數點下',
  `verification` varchar(512) DEFAULT NULL,
  UNIQUE KEY `index_user_accounts_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User持有貨幣';

LOCK TABLES `user_accounts_bak` WRITE;
/*!40000 ALTER TABLE `user_accounts_bak` DISABLE KEYS */;

INSERT INTO `user_accounts_bak` (`user_id`, `btc`, `btc_trade`, `ltc`, `ltc_trade`, `eth`, `eth_trade`, `twd`, `twd_trade`, `bch`, `bch_trade`, `eth_rddt`, `verifier`, `btg`, `btg_trans`, `btg_trade`, `bcd`, `bcd_trans`, `bcd_trade`, `bito`, `bito_trade`, `panda`, `panda_trade`, `cgp`, `cgp_trade`, `ethc`, `bito_pddt`, `panda_pddt`, `cgp_pddt`, `ethc_pddt`, `trx`, `trx_trade`, `trx_pddt`, `mith`, `mith_trade`, `mith_pddt`, `sda`, `sda_trade`, `sda_pddt`, `alln`, `alln_trade`, `alln_pddt`, `modl`, `modl_trade`, `modl_pddt`, `usdt`, `usdt_trade`, `usdt_pddt`, `qntu`, `qntu_trade`, `qntu_pddt`, `rpc`, `rpc_trade`, `rpc_pddt`, `npxs`, `npxs_trade`, `npxs_pddt`, `verification`)
VALUES
	(1,1000000000000,0,9000000000000000,0,9000000000000000,0,10000000,0,1000000000000,0,0,NULL,1000000000000,0,0,1000000000000,0,0,1000000000000000000,0,1000000000000000000,0,1000000000000,0,1000000000000,0,0,0,0,1000000000000,0,0,1000000000000,0,0,1000000000000,0,0,1000000000000,0,0,1000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,';eth,cd7f99e8;bito,8a7f8d18');

/*!40000 ALTER TABLE `user_accounts_bak` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '帳戶狀態',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '驗證等級',
  `otp_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'OTP啟用狀態',
  `otp_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'OTP更新次數(遞增)',
  `otp_config` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `notice_status` int(11) NOT NULL DEFAULT '3' COMMENT '通知狀態',
  `access_at` datetime DEFAULT NULL COMMENT '修改資料，提領限定時間',
  `lang` tinyint(4) NOT NULL DEFAULT '0',
  `favorite` bigint(20) NOT NULL DEFAULT '0' COMMENT '我的最愛',
  `price_notice_status` tinyint(1) NOT NULL DEFAULT '0',
  `favorite_eth` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ETH - 我的最愛',
  `favorite_usdt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'USDT - 我的最愛',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`),
  KEY `index_users_on_status` (`status`),
  KEY `index_users_on_level` (`level`),
  KEY `index_users_on_otp_status` (`otp_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
