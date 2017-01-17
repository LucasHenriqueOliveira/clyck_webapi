-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema anjtr452_clyck
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `anjtr452_clyck` ;

-- -----------------------------------------------------
-- Schema anjtr452_clyck
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `anjtr452_clyck` DEFAULT CHARACTER SET utf8 ;
USE `anjtr452_clyck` ;

-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`customer` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`customer` (
  `customer_id` VARCHAR(40) NOT NULL,
  `customer_first_name` VARCHAR(45) NOT NULL,
  `customer_last_name` VARCHAR(45) NOT NULL,
  `customer_email` VARCHAR(100) NOT NULL,
  `customer_password` VARCHAR(45) NULL DEFAULT NULL,
  `customer_birthday` TIMESTAMP NULL DEFAULT NULL,
  `customer_phone` VARCHAR(20) NULL DEFAULT NULL,
  `customer_cpf` VARCHAR(45) NULL DEFAULT NULL,
  `customer_stripe` VARCHAR(255) NULL DEFAULT NULL,
  `customer_token` VARCHAR(100) NULL DEFAULT NULL,
  `customer_device_id` VARCHAR(45) NULL DEFAULT NULL,
  `customer_registration_date` TIMESTAMP NULL DEFAULT NULL,
  `customer_sin_valid` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`auth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`auth` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`auth` (
  `auth_id` INT(11) NOT NULL AUTO_INCREMENT,
  `auth_customer_id` VARCHAR(40) NOT NULL,
  `auth_type` ENUM('facebook', 'google') NOT NULL,
  `auth_value` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`auth_id`),
  INDEX `fk_auth_customer_idx` (`auth_customer_id` ASC),
  CONSTRAINT `fk_customer`
    FOREIGN KEY (`auth_customer_id`)
    REFERENCES `anjtr452_clyck`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`bank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`bank` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`bank` (
  `bank_id` VARCHAR(40) NOT NULL,
  `bank_name` VARCHAR(100) NOT NULL,
  `bank_code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`bank_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`state` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`state` (
  `state_id` INT(11) NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`city` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`city` (
  `city_id` INT(11) NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(100) NOT NULL,
  `city_state_id` INT(11) NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_state_idx` (`city_state_id` ASC),
  CONSTRAINT `fk_city_state`
    FOREIGN KEY (`city_state_id`)
    REFERENCES `anjtr452_clyck`.`state` (`state_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`company` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`company` (
  `company_id` VARCHAR(40) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  `company_cnpj` VARCHAR(15) NOT NULL,
  `company_address` VARCHAR(100) NOT NULL,
  `company_latitude` DOUBLE NULL DEFAULT NULL,
  `company_longitude` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`user` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`user` (
  `user_id` VARCHAR(40) NOT NULL,
  `user_first_name` VARCHAR(45) NOT NULL,
  `user_last_name` VARCHAR(45) NULL DEFAULT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  `user_salt` VARCHAR(50) NOT NULL,
  `user_birthday` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_type` ENUM('Administrador', 'Gerente', 'Supervisor', 'Atendente') NOT NULL,
  `user_phone` VARCHAR(45) NULL DEFAULT NULL,
  `user_email` VARCHAR(45) NULL DEFAULT NULL,
  `user_active` TINYINT(1) NOT NULL DEFAULT '1',
  `user_login_default` TINYINT(1) NOT NULL DEFAULT '1',
  `user_id_active` INT(11) NULL DEFAULT NULL,
  `user_date_active` TIMESTAMP NULL DEFAULT NULL,
  `user_id_deactivate` INT(11) NULL DEFAULT NULL,
  `user_date_deactivate` TIMESTAMP NULL DEFAULT NULL,
  `user_id_company` VARCHAR(40) NOT NULL,
  `user_type_person` ENUM('Pessoa Física', 'Pessoa Jurídica') NOT NULL,
  `user_id_data_account` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_company_idx` (`user_id_company` ASC),
  CONSTRAINT `fk_company`
    FOREIGN KEY (`user_id_company`)
    REFERENCES `anjtr452_clyck`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`coupon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`coupon` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`coupon` (
  `coupon_id` VARCHAR(40) NOT NULL,
  `coupon_number` VARCHAR(45) NOT NULL,
  `coupon_tax` FLOAT NULL DEFAULT NULL,
  `coupon_sin_used` TINYINT(1) NULL DEFAULT '0',
  `coupon_event_id` VARCHAR(40) NOT NULL,
  `coupon_user_id` VARCHAR(40) NULL,
  PRIMARY KEY (`coupon_id`),
  INDEX `fkuc_idx` (`coupon_user_id` ASC),
  CONSTRAINT `fkuc`
    FOREIGN KEY (`coupon_user_id`)
    REFERENCES `anjtr452_clyck`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`type_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`type_account` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`type_account` (
  `type_account_id` INT(11) NOT NULL AUTO_INCREMENT,
  `type_account_description` VARCHAR(100) NOT NULL,
  `type_account_code` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`type_account_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`data_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`data_account` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`data_account` (
  `data_account_id` VARCHAR(40) NOT NULL,
  `data_account_id_bank` VARCHAR(40) NOT NULL,
  `data_account_agency` VARCHAR(10) NOT NULL,
  `data_account_account_number` VARCHAR(10) NOT NULL,
  `data_account_id_type_account` INT(11) NOT NULL,
  `data_account_beneficiary` VARCHAR(100) NOT NULL,
  `data_account_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`data_account_id`),
  INDEX `FK_type_idx` (`data_account_id_type_account` ASC),
  INDEX `fk_bank_idx` (`data_account_id_bank` ASC),
  CONSTRAINT `FK_type`
    FOREIGN KEY (`data_account_id_type_account`)
    REFERENCES `anjtr452_clyck`.`type_account` (`type_account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bank`
    FOREIGN KEY (`data_account_id_bank`)
    REFERENCES `anjtr452_clyck`.`bank` (`bank_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`event` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`event` (
  `event_id` VARCHAR(40) NOT NULL,
  `event_name` VARCHAR(100) NOT NULL,
  `event_initial_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `event_final_date` TIMESTAMP NULL DEFAULT NULL,
  `event_image` VARCHAR(255) NULL DEFAULT NULL,
  `event_state_id` INT(11) NOT NULL,
  `event_city_id` INT(11) NOT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `event_description` VARCHAR(255) NULL DEFAULT NULL,
  `event_tax_service` DECIMAL(10,2) NULL DEFAULT NULL,
  `event_user_id` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`event_id`),
  INDEX `fk_event_city_idx` (`event_city_id` ASC),
  INDEX `fk_event_user_idx` (`event_user_id` ASC),
  INDEX `fk_event_state_idx` (`event_state_id` ASC),
  CONSTRAINT `fk_event_city`
    FOREIGN KEY (`event_city_id`)
    REFERENCES `anjtr452_clyck`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_event_state`
    FOREIGN KEY (`event_state_id`)
    REFERENCES `anjtr452_clyck`.`state` (`state_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_event_user`
    FOREIGN KEY (`event_user_id`)
    REFERENCES `anjtr452_clyck`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`order` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`order` (
  `order_id` VARCHAR(40) NOT NULL,
  `order_customer_id` VARCHAR(40) NOT NULL,
  `order_customer_email` VARCHAR(150) NOT NULL,
  `order_tracking_number` VARCHAR(20) NOT NULL,
  `order_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order_price` DECIMAL(10,2) NOT NULL,
  `order_price_discount` DECIMAL(10,2) NULL DEFAULT NULL,
  `order_tax_service` DECIMAL(10,2) NULL DEFAULT NULL,
  `order_price_total` DECIMAL(10,2) NOT NULL,
  `order_schedule_date` TIME NULL DEFAULT NULL,
  `order_delivery_date` TIMESTAMP NULL DEFAULT NULL,
  `order_coupon_id` VARCHAR(40) NOT NULL,
  `order_event_id` VARCHAR(40) NOT NULL,
  `order_status` ENUM('complete', 'processing', 'pending', 'failed') NULL DEFAULT NULL,
  `order_vote_buying` ENUM('1', '2', '3', '4', '5') NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_customer_idx` (`order_customer_id` ASC),
  INDEX `fk_coupon_idx` (`order_coupon_id` ASC),
  INDEX `fk_event_idx` (`order_event_id` ASC),
  CONSTRAINT `fk_customer_or`
    FOREIGN KEY (`order_customer_id`)
    REFERENCES `anjtr452_clyck`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_coupon_ord`
    FOREIGN KEY (`order_coupon_id`)
    REFERENCES `anjtr452_clyck`.`coupon` (`coupon_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_event_order`
    FOREIGN KEY (`order_event_id`)
    REFERENCES `anjtr452_clyck`.`event` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`product` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`product` (
  `product_id` VARCHAR(40) NOT NULL,
  `product_name` VARCHAR(100) NOT NULL,
  `product_price` DECIMAL(10,2) NOT NULL,
  `product_image` VARCHAR(45) NULL DEFAULT NULL,
  `product_short_desc` VARCHAR(255) NOT NULL,
  `product_long_desc` TEXT NOT NULL,
  `product_event_id` VARCHAR(40) NOT NULL,
  `product_inventory_qtd` INT(11) NOT NULL,
  `product_inventory_current` INT(11) NOT NULL,
  `product_user_id` VARCHAR(40) NULL DEFAULT NULL,
  `product_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_event_idx` (`product_event_id` ASC),
  INDEX `fk_product_user_idx` (`product_user_id` ASC),
  CONSTRAINT `fk_product_event`
    FOREIGN KEY (`product_event_id`)
    REFERENCES `anjtr452_clyck`.`event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_user`
    FOREIGN KEY (`product_user_id`)
    REFERENCES `anjtr452_clyck`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`item` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`item` (
  `item_id` VARCHAR(40) NOT NULL,
  `item_order_id` VARCHAR(40) NOT NULL,
  `item_product_id` VARCHAR(40) NOT NULL,
  `item_price_unit` DECIMAL(10,2) NOT NULL,
  `item_quantity` INT(11) NOT NULL,
  `item_price_total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `kfod_idx` (`item_order_id` ASC),
  INDEX `fkprod_idx` (`item_product_id` ASC),
  CONSTRAINT `fk_order`
    FOREIGN KEY (`item_order_id`)
    REFERENCES `anjtr452_clyck`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prod`
    FOREIGN KEY (`item_product_id`)
    REFERENCES `anjtr452_clyck`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`payment` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`payment` (
  `payment_id` VARCHAR(40) NOT NULL,
  `payment_stripe` VARCHAR(255) NOT NULL,
  `payment_description` VARCHAR(45) NOT NULL,
  `payment_last4` VARCHAR(4) NOT NULL,
  `payment_customer_id` VARCHAR(40) NOT NULL,
  `payment_active` TINYINT(1) NULL DEFAULT '1',
  `payment_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_customer_idx` (`payment_customer_id` ASC),
  CONSTRAINT `fk_customer_pay`
    FOREIGN KEY (`payment_customer_id`)
    REFERENCES `anjtr452_clyck`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`sector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`sector` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`sector` (
  `sector_id` VARCHAR(40) NOT NULL,
  `sector_name` VARCHAR(45) NOT NULL,
  `sector_position` VARCHAR(45) NULL DEFAULT NULL,
  `sector_user_id` VARCHAR(40) NOT NULL,
  `sector_event_id` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`sector_id`),
  INDEX `fk_user_idx` (`sector_user_id` ASC),
  INDEX `fk_event_id_idx` (`sector_event_id` ASC),
  CONSTRAINT `fk_user`
    FOREIGN KEY (`sector_user_id`)
    REFERENCES `anjtr452_clyck`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_id`
    FOREIGN KEY (`sector_event_id`)
    REFERENCES `anjtr452_clyck`.`event` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `anjtr452_clyck`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anjtr452_clyck`.`transaction` ;

CREATE TABLE IF NOT EXISTS `anjtr452_clyck`.`transaction` (
  `transaction_id` VARCHAR(40) NOT NULL,
  `transaction_customer_id` VARCHAR(40) NOT NULL,
  `transaction_payment_id` VARCHAR(40) NOT NULL,
  `transaction_charge` VARCHAR(255) NULL DEFAULT NULL,
  `transaction_amount` VARCHAR(45) NOT NULL,
  `transaction_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_cust_idx` (`transaction_customer_id` ASC),
  INDEX `fk_trans_idx` (`transaction_payment_id` ASC),
  CONSTRAINT `fk_cust`
    FOREIGN KEY (`transaction_customer_id`)
    REFERENCES `anjtr452_clyck`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trans`
    FOREIGN KEY (`transaction_payment_id`)
    REFERENCES `anjtr452_clyck`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
