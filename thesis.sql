-- MySQL Script generated by MySQL Workbench
-- Sat Oct  7 15:11:13 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `no_identitas` VARCHAR(20) NULL,
  `name` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `remember_token` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pendaftar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pendaftar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `alamat` VARCHAR(255) NULL,
  `no_telp` VARCHAR(15) NULL,
  `jenis_kelamin` TINYINT(1) NULL COMMENT '1. Laki-laki\n2. Perempuan',
  `tempat_lahir` VARCHAR(50) NULL,
  `tanggal_lahir` DATE NULL,
  `anak_ke` TINYINT(2) NULL,
  `jumlah_saudara` TINYINT(2) NULL,
  `agama` TINYINT(1) NULL COMMENT '1. Islam\n2. Katolik\n3. Kristen\n4. Hindu\n5. Budha\n6. Konghucu',
  `nama_ibu_kandung` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_pendaftar_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_pendaftar_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `display_name` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `display_name` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`permissions_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`permissions_role` (
  `role_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  INDEX `fk_roles_has_permissions_permissions1_idx` (`permission_id` ASC),
  INDEX `fk_roles_has_permissions_roles_idx` (`role_id` ASC),
  CONSTRAINT `fk_roles_has_permissions_roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_permissions_permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `mydb`.`permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`role_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`role_user` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_users_has_roles_roles1_idx` (`role_id` ASC),
  INDEX `fk_users_has_roles_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_users_has_roles_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pendidikan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pendidikan` (
  `id` INT NOT NULL,
  `jenjang` VARCHAR(2) NULL COMMENT '1. Null\n2. SD\n3. SMP\n4. SMA\n5. SMK\n6. S1\n7. S2\n8. S3',
  `jurusan` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`riwayat_pendidikan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`riwayat_pendidikan` (
  `pendaftar_id` INT NOT NULL,
  `pendidikan_id` INT NOT NULL,
  `nama_institusi` VARCHAR(255) NULL,
  `tahun_lulus` YEAR NULL,
  PRIMARY KEY (`pendaftar_id`, `pendidikan_id`),
  INDEX `fk_pendaftar_has_pendidikan_pendidikan1_idx` (`pendidikan_id` ASC),
  INDEX `fk_pendaftar_has_pendidikan_pendaftar1_idx` (`pendaftar_id` ASC),
  CONSTRAINT `fk_pendaftar_has_pendidikan_pendaftar1`
    FOREIGN KEY (`pendaftar_id`)
    REFERENCES `mydb`.`pendaftar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pendaftar_has_pendidikan_pendidikan1`
    FOREIGN KEY (`pendidikan_id`)
    REFERENCES `mydb`.`pendidikan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
