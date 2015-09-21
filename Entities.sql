-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'postalAddress'
-- 
-- ---

DROP TABLE IF EXISTS `postalAddress`;
		
CREATE TABLE `postalAddress` (
  `userAddressID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `addressLine1` VARCHAR(255) NULL DEFAULT NULL,
  `addressLine2` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `region` VARCHAR(255) NULL DEFAULT NULL,
  `country` VARCHAR(255) NULL DEFAULT NULL,
  `postalCode` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`userAddressID`)
);

-- ---
-- Table 'emailAddress'
-- 
-- ---

DROP TABLE IF EXISTS `emailAddress`;
		
CREATE TABLE `emailAddress` (
  `userAddressID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `email` VARCHAR(200) NOT NULL DEFAULT 'NULL',
  `verificationKey` CHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`userAddressID`, `email`)
);

-- ---
-- Table 'User'
-- 
-- ---

DROP TABLE IF EXISTS `User`;
		
CREATE TABLE `User` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `password_hash` CHAR(32) NULL DEFAULT NULL,
  `hash_salt` CHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'game'
-- 
-- ---

DROP TABLE IF EXISTS `game`;
		
CREATE TABLE `game` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'userAddress'
-- 
-- ---

DROP TABLE IF EXISTS `userAddress`;
		
CREATE TABLE `userAddress` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `userID` INTEGER NULL DEFAULT NULL,
  `dateCreated` DATE NULL DEFAULT NULL,
  `dateExpired` DATE NULL DEFAULT NULL,
  `dateVerified` DATE NULL DEFAULT NULL,
  `allowMarketing` BINARY NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'order'
-- Before complete this is the "Cart", after complete this is your order history.
-- ---

DROP TABLE IF EXISTS `order`;
		
CREATE TABLE `order` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `userID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Before complete this is the "Cart", after complete this is y';

-- ---
-- Table 'orderItem'
-- 
-- ---

DROP TABLE IF EXISTS `orderItem`;
		
CREATE TABLE `orderItem` (
  `orderID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `gameID` INTEGER NULL DEFAULT NULL,
  `quantity` INTEGER NULL DEFAULT NULL,
  `salePrice` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`orderID`, `gameID`)
);

-- ---
-- Table 'platform'
-- 
-- ---

DROP TABLE IF EXISTS `platform`;
		
CREATE TABLE `platform` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'gamePlatform'
-- 
-- ---

DROP TABLE IF EXISTS `gamePlatform`;
		
CREATE TABLE `gamePlatform` (
  `gameID` INTEGER NULL DEFAULT NULL,
  `platformID` INTEGER NULL DEFAULT NULL,
  `suggestedRetailPrice` DECIMAL NULL DEFAULT NULL,
  `releaseDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`gameID`, `platformID`)
);

-- ---
-- Table 'category'
-- 
-- ---

DROP TABLE IF EXISTS `category`;
		
CREATE TABLE `category` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'gameCategory'
-- 
-- ---

DROP TABLE IF EXISTS `gameCategory`;
		
CREATE TABLE `gameCategory` (
  `gameID` INTEGER NULL DEFAULT NULL,
  `categoryID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`gameID`, `categoryID`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `userAddress` ADD FOREIGN KEY (id) REFERENCES `emailAddress` (`userAddressID`);
ALTER TABLE `userAddress` ADD FOREIGN KEY (id) REFERENCES `postalAddress` (`userAddressID`);
ALTER TABLE `userAddress` ADD FOREIGN KEY (userID) REFERENCES `User` (`id`);
ALTER TABLE `order` ADD FOREIGN KEY (userID) REFERENCES `User` (`id`);
ALTER TABLE `orderItem` ADD FOREIGN KEY (orderID) REFERENCES `order` (`id`);
ALTER TABLE `orderItem` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `gamePlatform` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `gamePlatform` ADD FOREIGN KEY (platformID) REFERENCES `platform` (`id`);
ALTER TABLE `gameCategory` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `gameCategory` ADD FOREIGN KEY (categoryID) REFERENCES `category` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `postalAddress` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `emailAddress` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `User` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `game` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `userAddress` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `order` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `orderItem` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `platform` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `gamePlatform` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `gameCategory` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `postalAddress` (`userAddressID`,`addressLine1`,`addressLine2`,`city`,`region`,`country`,`postalCode`) VALUES
-- ('','','','','','','');
-- INSERT INTO `emailAddress` (`userAddressID`,`email`,`verificationKey`) VALUES
-- ('','','');
-- INSERT INTO `User` (`id`,`password_hash`,`hash_salt`) VALUES
-- ('','','');
-- INSERT INTO `game` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `userAddress` (`id`,`userID`,`dateCreated`,`dateExpired`,`dateVerified`,`allowMarketing`) VALUES
-- ('','','','','','');
-- INSERT INTO `order` (`id`,`userID`) VALUES
-- ('','');
-- INSERT INTO `orderItem` (`orderID`,`gameID`,`quantity`,`salePrice`) VALUES
-- ('','','','');
-- INSERT INTO `platform` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `gamePlatform` (`gameID`,`platformID`,`suggestedRetailPrice`,`releaseDate`) VALUES
-- ('','','','');
-- INSERT INTO `category` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `gameCategory` (`gameID`,`categoryID`) VALUES
-- ('','');