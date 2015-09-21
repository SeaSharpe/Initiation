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
-- Table 'user'
-- 
-- ---

DROP TABLE IF EXISTS `user`;
    
CREATE TABLE `user` (
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
  `dateDeleted` DATE NULL DEFAULT NULL,
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
  `billingAddress` INTEGER NULL DEFAULT NULL,
  `shippingAddress` INTEGER NULL DEFAULT NULL,
  `userID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Before complete this is the "Cart", after complete this is y';

-- ---
-- Table 'orderItem'
-- 
-- ---

DROP TABLE IF EXISTS `orderItem`;
    
CREATE TABLE `orderItem` (
  `gameID` INTEGER NULL DEFAULT NULL,
  `orderID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
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
-- Table 'profile'
-- 
-- ---

DROP TABLE IF EXISTS `profile`;
    
CREATE TABLE `profile` (
  `userID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `displayName` VARCHAR(30) NULL DEFAULT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `dateOfBirth` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`userID`)
);

-- ---
-- Table 'billing'
-- 
-- ---

DROP TABLE IF EXISTS `billing`;
    
CREATE TABLE `billing` (
  `swipeEmail` INTEGER NULL DEFAULT NULL,
  `userID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `swipeID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`userID`)
);

-- ---
-- Table 'friendship'
-- 
-- ---

DROP TABLE IF EXISTS `friendship`;
    
CREATE TABLE `friendship` (
  `frendeeID` INTEGER NULL DEFAULT NULL,
  `frenderID` INTEGER NULL DEFAULT NULL,
  `isFamilyMember` BINARY NULL DEFAULT NULL,
  `comments` VARCHAR(2000) NULL DEFAULT NULL,
  PRIMARY KEY ()
);

-- ---
-- Table 'review'
-- 
-- ---

DROP TABLE IF EXISTS `review`;
    
CREATE TABLE `review` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `gameID` INTEGER NULL DEFAULT NULL,
  `userID` INTEGER NULL DEFAULT NULL,
  `platformID` INTEGER NULL DEFAULT NULL,
  `subject` VARCHAR(300) NULL DEFAULT NULL,
  `body` VARCHAR NULL DEFAULT NULL,
  `dateCreated` DATE NULL DEFAULT NULL,
  `dateModified` DATE NULL DEFAULT NULL,
  `dateDeleted` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `user` ADD FOREIGN KEY (id) REFERENCES `profile` (`userID`);
ALTER TABLE `user` ADD FOREIGN KEY (id) REFERENCES `billing` (`userID`);
ALTER TABLE `userAddress` ADD FOREIGN KEY (id) REFERENCES `emailAddress` (`userAddressID`);
ALTER TABLE `userAddress` ADD FOREIGN KEY (id) REFERENCES `postalAddress` (`userAddressID`);
ALTER TABLE `userAddress` ADD FOREIGN KEY (userID) REFERENCES `user` (`id`);
ALTER TABLE `order` ADD FOREIGN KEY (billingAddress) REFERENCES `userAddress` (`id`);
ALTER TABLE `order` ADD FOREIGN KEY (shippingAddress) REFERENCES `userAddress` (`id`);
ALTER TABLE `order` ADD FOREIGN KEY (userID) REFERENCES `user` (`id`);
ALTER TABLE `orderItem` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `orderItem` ADD FOREIGN KEY (orderID) REFERENCES `order` (`id`);
ALTER TABLE `gamePlatform` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `gamePlatform` ADD FOREIGN KEY (platformID) REFERENCES `platform` (`id`);
ALTER TABLE `gameCategory` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `gameCategory` ADD FOREIGN KEY (categoryID) REFERENCES `category` (`id`);
ALTER TABLE `billing` ADD FOREIGN KEY (swipeEmail) REFERENCES `userAddress` (`id`);
ALTER TABLE `friendship` ADD FOREIGN KEY (frendeeID) REFERENCES `user` (`id`);
ALTER TABLE `friendship` ADD FOREIGN KEY (frenderID) REFERENCES `user` (`id`);
ALTER TABLE `review` ADD FOREIGN KEY (gameID) REFERENCES `game` (`id`);
ALTER TABLE `review` ADD FOREIGN KEY (userID) REFERENCES `user` (`id`);
ALTER TABLE `review` ADD FOREIGN KEY (platformID) REFERENCES `platform` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `postalAddress` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `emailAddress` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `user` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `game` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `userAddress` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `order` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `orderItem` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `platform` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `gamePlatform` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `gameCategory` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `profile` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `billing` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `friendship` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `review` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `postalAddress` (`userAddressID`,`addressLine1`,`addressLine2`,`city`,`region`,`country`,`postalCode`) VALUES
-- ('','','','','','','');
-- INSERT INTO `emailAddress` (`userAddressID`,`email`,`verificationKey`) VALUES
-- ('','','');
-- INSERT INTO `user` (`id`,`password_hash`,`hash_salt`) VALUES
-- ('','','');
-- INSERT INTO `game` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `userAddress` (`id`,`userID`,`dateCreated`,`dateDeleted`,`dateVerified`,`allowMarketing`) VALUES
-- ('','','','','','');
-- INSERT INTO `order` (`id`,`billingAddress`,`shippingAddress`,`userID`) VALUES
-- ('','','','');
-- INSERT INTO `orderItem` (`gameID`,`orderID`,`quantity`,`salePrice`) VALUES
-- ('','','','');
-- INSERT INTO `platform` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `gamePlatform` (`gameID`,`platformID`,`suggestedRetailPrice`,`releaseDate`) VALUES
-- ('','','','');
-- INSERT INTO `category` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `gameCategory` (`gameID`,`categoryID`) VALUES
-- ('','');
-- INSERT INTO `profile` (`userID`,`displayName`,`gender`,`firstName`,`lastName`,`dateOfBirth`) VALUES
-- ('','','','','','');
-- INSERT INTO `billing` (`swipeEmail`,`userID`,`swipeID`) VALUES
-- ('','','');
-- INSERT INTO `friendship` (`frendeeID`,`frenderID`,`isFamilyMember`,`comments`) VALUES
-- ('','','','');
-- INSERT INTO `review` (`id`,`gameID`,`userID`,`platformID`,`subject`,`body`,`dateCreated`,`dateModified`,`dateDeleted`) VALUES
-- ('','','','','','','','','');