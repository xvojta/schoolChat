-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chat
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chat` DEFAULT CHARACTER SET utf8 ;
USE `chat` ;

-- -----------------------------------------------------
-- Table `chat`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `passwd` VARCHAR(32) NOT NULL,
  `name` VARCHAR(20) NULL,
  `surname` VARCHAR(20) NULL,
  `role` ENUM('admin', 'moderator', 'user') NULL DEFAULT 'user',
  `blocked` ENUM('Y', 'N') NULL DEFAULT 'N',
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `chat`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`rooms` (
  `id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `descr` VARCHAR(1000) NULL,
  `public` ENUM('Y', 'N') NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_rooms_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_rooms_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `chat`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat`.`Posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`Posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `msg` VARCHAR(1000) NOT NULL,
  `blocked` ENUM('Y', 'N') NULL DEFAULT 'N',
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_Posts_users_idx` (`owner_id` ASC) VISIBLE,
  INDEX `fk_Posts_rooms1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_Posts_users`
    FOREIGN KEY (`owner_id`)
    REFERENCES `chat`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Posts_rooms1`
    FOREIGN KEY (`room_id`)
    REFERENCES `chat`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat`.`users_rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`users_rooms` (
  `users_id` INT NOT NULL,
  `rooms_id` INT NOT NULL,
  INDEX `fk_users_has_rooms_rooms1_idx` (`rooms_id` ASC) VISIBLE,
  INDEX `fk_users_has_rooms_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_rooms_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `chat`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_rooms_rooms1`
    FOREIGN KEY (`rooms_id`)
    REFERENCES `chat`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
