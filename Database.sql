/*
Navicat MySQL Data Transfer

Source Server         : Locale
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : es_extended

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2023-09-10 01:09:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `permission_levels`
-- ----------------------------
DROP TABLE IF EXISTS `permission_levels`;
CREATE TABLE `permission_levels` (
  `level` int(11) NOT NULL,
  `revive` int(11) NOT NULL DEFAULT 0,
  `tpm` int(11) NOT NULL DEFAULT 0,
  `gotoplayer` int(11) NOT NULL DEFAULT 0,
  `bring` int(11) NOT NULL DEFAULT 0,
  `giveitem` int(11) NOT NULL DEFAULT 0,
  `givemoney` int(11) NOT NULL DEFAULT 0,
  `ban` int(11) NOT NULL DEFAULT 0,
  `kick` int(11) NOT NULL DEFAULT 0,
  `kill` int(11) NOT NULL DEFAULT 0,
  `freeze` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of permission_levels
-- ----------------------------
INSERT INTO `permission_levels` VALUES ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `permission_levels` VALUES ('1', '0', '1', '1', '1', '0', '0', '0', '1', '0', '1');
INSERT INTO `permission_levels` VALUES ('2', '1', '1', '1', '1', '0', '0', '0', '1', '1', '1');
INSERT INTO `permission_levels` VALUES ('3', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for `user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE `user_permissions` (
  `identifier` varchar(46) NOT NULL,
  `permission_level` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_permissions
-- ----------------------------
