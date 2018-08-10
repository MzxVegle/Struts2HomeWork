/*
Navicat MySQL Data Transfer

Source Server         : MyConnection
Source Server Version : 50720
Source Host           : 127.0.0.1:3306
Source Database       : mydatabase

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-06-07 20:00:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article_group
-- ----------------------------
DROP TABLE IF EXISTS `article_group`;
CREATE TABLE `article_group` (
  `article_group_id` int(11) NOT NULL,
  `article_group_name` varchar(100) NOT NULL,
  `article_group_create_time` date DEFAULT NULL,
  `article_group_alter_time` date DEFAULT NULL,
  PRIMARY KEY (`article_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_group
-- ----------------------------
INSERT INTO `article_group` VALUES ('1', 'c++', '2018-03-16', '2018-03-16');
INSERT INTO `article_group` VALUES ('2', 'java', '2018-03-16', '2018-03-16');
INSERT INTO `article_group` VALUES ('3', 'c#', '2018-03-16', '2018-03-16');

-- ----------------------------
-- Table structure for article_info
-- ----------------------------
DROP TABLE IF EXISTS `article_info`;
CREATE TABLE `article_info` (
  `article_id` int(11) NOT NULL,
  `article_group_id` int(11) NOT NULL,
  `article_name` int(11) NOT NULL,
  `article_content` text,
  `article_create_time` date DEFAULT NULL,
  `article_alter_time` date DEFAULT NULL,
  PRIMARY KEY (`article_id`),
  KEY `FK_(article_group_id)` (`article_group_id`),
  CONSTRAINT `FK_(article_group_id)` FOREIGN KEY (`article_group_id`) REFERENCES `article_group` (`article_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_info
-- ----------------------------

-- ----------------------------
-- Table structure for diary
-- ----------------------------
DROP TABLE IF EXISTS `diary`;
CREATE TABLE `diary` (
  `diary_id` int(11) NOT NULL,
  `diary_content` text NOT NULL,
  `diary_create_time` date NOT NULL,
  `diary_alter_time` date NOT NULL,
  PRIMARY KEY (`diary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of diary
-- ----------------------------

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `file_id` int(11) NOT NULL,
  `file_group_id` int(11) NOT NULL,
  `file_name` varchar(25) NOT NULL,
  `file_addr` text NOT NULL,
  `file_notice` text,
  `file_upload_time` date DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  KEY `FK(file)` (`file_group_id`),
  CONSTRAINT `FK(file)` FOREIGN KEY (`file_group_id`) REFERENCES `file_group` (`file_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for file_group
-- ----------------------------
DROP TABLE IF EXISTS `file_group`;
CREATE TABLE `file_group` (
  `file_group_id` int(11) NOT NULL,
  `file_group_name` varchar(50) NOT NULL,
  `file_group_create_time` date DEFAULT NULL,
  `file_group_alter_time` date DEFAULT NULL,
  `file_group_notice` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`file_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file_group
-- ----------------------------

-- ----------------------------
-- Table structure for leave_word
-- ----------------------------
DROP TABLE IF EXISTS `leave_word`;
CREATE TABLE `leave_word` (
  `leave_word` varchar(255) NOT NULL,
  `addr` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of leave_word
-- ----------------------------

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `photo_id` int(11) NOT NULL,
  `graph_id` int(11) NOT NULL,
  `photo_name` varchar(25) NOT NULL,
  `photo_addr` varchar(255) NOT NULL,
  `photo_notice` text,
  `photo_upload_time` date DEFAULT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `FK(photo)` (`graph_id`),
  CONSTRAINT `FK(photo)` FOREIGN KEY (`graph_id`) REFERENCES `photograph` (`graph_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of photo
-- ----------------------------

-- ----------------------------
-- Table structure for photograph
-- ----------------------------
DROP TABLE IF EXISTS `photograph`;
CREATE TABLE `photograph` (
  `graph_id` int(11) NOT NULL,
  `graph_name` varchar(25) NOT NULL,
  `graph_create_time` date DEFAULT NULL,
  `graph_alter_time` date DEFAULT NULL,
  PRIMARY KEY (`graph_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of photograph
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(10) NOT NULL,
  `password` varchar(25) NOT NULL,
  `permission` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('admin', 'admin', 'admin');
INSERT INTO `user` VALUES ('Jocker', 'Jocker', 'admin');
INSERT INTO `user` VALUES ('mzzxttao', 'mzzxttao', 'normal');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` varchar(15) NOT NULL,
  `username` varchar(15) NOT NULL,
  `realname` varchar(15) DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `reg_time` date DEFAULT NULL,
  KEY `FK(id)` (`id`),
  CONSTRAINT `FK(id)` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('admin', 'admin', '666', '男', '22', '2018-03-16');
INSERT INTO `userinfo` VALUES ('Jocker', 'Jocker', '', '女', '22', '2018-03-16');

-- ----------------------------
-- Procedure structure for delete_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_data`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_data`(in id varchar(10),out mess text)
BEGIN 
if EXISTS(Select * from `user` WHERE `user`.id = id ) THEN
  DELETE from `user` where `user`.id = id;
	set mess = '注销用户成功！';
ELSE
	
	set mess = CONCAT('不存在用户名:',id,'注销用户失败！');
  
END IF;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for reg_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `reg_user`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reg_user`(in id varchar(15),in pwd varchar(15),in permission varchar(7),in username varchar(15),in realname varchar(15),in sex varchar(3),in age int,out mess text)
BEGIN
DECLARE reg_date date;
set reg_date = NOW();
if EXISTS(Select * from `user` WHERE `user`.id = id ) THEN
  
	set mess = '用户已经存在！注册失败';
ELSE
	INSERT `user` VALUES(id,pwd,permission);
	INSERT userinfo VALUES(id,username, realname,sex,age,reg_date);
	set mess = CONCAT('注册成功！用户名:',id);
  
END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_user_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_user_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_info`(in id varchar(15),in username varchar(15),in realname varchar(15),in sex varchar(3),in age int,out mess text)
BEGIN
	IF EXISTS(SELECT * from userinfo where userinfo.id	= id) THEN
		
		UPDATE userinfo set userinfo.username=username,userinfo.realname=realname,userinfo.sex = sex,userinfo.age = age where userinfo.id = id;
		SET mess = CONCAT('更改',id,'用户的信息成功！');
	ELSE
		set mess = '未找到该用户！';
		
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_user_pwd
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_user_pwd`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_pwd`(in id varchar(15),in pwd varchar(15) ,out mess text)
BEGIN
	IF EXISTS(SELECT count(*) from `user` WHERE `user`.id = id) THEN
		
		UPDATE `user` SET `user`.`password`=pwd where `user`.id = id;
		set mess = CONCAT('更改',id,'用户的密码成功！');
	ELSE
		set mess='用户不存在，请先添加用户再修改！';
		
	END IF;
		
END
;;
DELIMITER ;
