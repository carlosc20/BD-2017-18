-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Horario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Horario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fim` TIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dias_da_semana`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dias_da_semana` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dias_da_semana` (
  `id` INT NOT NULL,
  `dia` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `dia`),
  CONSTRAINT `id_dias_da_semana`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`Horario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcionario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `numero` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `data_de_nascimento` DATE NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `data_criacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcao` (
  `id` TINYINT NOT NULL,
  `designacao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Horario_funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Horario_funcionario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Horario_funcionario` (
  `id_horario` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_horario`, `id_funcionario`),
  INDEX `funcionario_id_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `id_horario_horario_funcionario`
    FOREIGN KEY (`id_horario`)
    REFERENCES `mydb`.`Horario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_funcionario_horario_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`Funcionario` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aviao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aviao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Aviao` (
  `marcas_da_aeronave` VARCHAR(20) NOT NULL,
  `proprietario` VARCHAR(255) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `numero_max_passageiros` INT NOT NULL,
  `classificacao` VARCHAR(255) NOT NULL,
  `disponivel` TINYINT NOT NULL,
  `data_proxima_revisao` DATE NOT NULL,
  `icao_atual` CHAR(4) NULL,
  PRIMARY KEY (`marcas_da_aeronave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `id` TINYINT NOT NULL,
  `designacao` VARCHAR(63) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado` TINYINT NOT NULL,
  `data_de_inicio` DATETIME NOT NULL,
  `duracao` TIME NOT NULL,
  `observacao` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `estado_idx` (`estado` ASC) INVISIBLE,
  CONSTRAINT `estado_servico`
    FOREIGN KEY (`estado`)
    REFERENCES `mydb`.`Estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_externo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico_externo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico_externo` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_servico_externo`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`Servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ciclo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ciclo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ciclo` (
  `id_servico` INT NOT NULL,
  `marcas_da_aeronave` VARCHAR(20) NOT NULL,
  `icao_origem` CHAR(4) NOT NULL,
  `icao_destino` CHAR(4) NOT NULL,
  `hora_partida` TIME NULL,
  `hora_chegada` TIME NULL,
  `hora_partida_prevista` TIME NOT NULL,
  `duracao_prevista` TIME NOT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `marcas_da_aeronave_idx` (`marcas_da_aeronave` ASC) VISIBLE,
  CONSTRAINT `id_servico_servico_aviao`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico_externo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `marcas_da_aeronave_servico_aviao`
    FOREIGN KEY (`marcas_da_aeronave`)
    REFERENCES `mydb`.`Aviao` (`marcas_da_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico_funcionario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico_funcionario` (
  `id_servico` INT NOT NULL,
  `funcao` TINYINT NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_servico`, `id_funcionario`),
  INDEX `id_servico_idx` (`id_servico` ASC) VISIBLE,
  INDEX `funcao_idx` (`funcao` ASC) VISIBLE,
  INDEX `id_funcionario_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `id_servico_servico_funcionario`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `funcao_servico_funcionario`
    FOREIGN KEY (`funcao`)
    REFERENCES `mydb`.`Funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_funcionario_servico_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`Funcionario` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `brevete` TINYINT NOT NULL,
  `formacao_paraquedismo` TINYINT NOT NULL,
  `email` VARCHAR(45) NULL,
  `numero_socio` INT NULL,
  `data_nascimento` DATE NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `numero_de_telefone` VARCHAR(45) NOT NULL,
  `data_criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero_socio_UNIQUE` (`numero_socio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico_cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico_cliente` (
  `id_cliente` INT NOT NULL,
  `id_servico` INT NOT NULL,
  `pagamento` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_cliente`, `id_servico`),
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_servico_servico_cliente_idx` (`id_servico` ASC) VISIBLE,
  CONSTRAINT `id_cliente_servico_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_servico_servico_cliente`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico_externo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Quotas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Quotas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Quotas` (
  `id` INT NOT NULL,
  `ano` YEAR NOT NULL,
  PRIMARY KEY (`id`, `ano`),
  CONSTRAINT `id_quotas`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`Cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lugar_local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Lugar_local` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Lugar_local` (
  `marcas_da_aeronave` VARCHAR(20) NOT NULL,
  `designacao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`marcas_da_aeronave`),
  CONSTRAINT `id_lugar_local`
    FOREIGN KEY (`marcas_da_aeronave`)
    REFERENCES `mydb`.`Aviao` (`marcas_da_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcao_funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcao_funcionario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcao_funcionario` (
  `numero` INT NOT NULL,
  `funcao` TINYINT NOT NULL,
  PRIMARY KEY (`numero`, `funcao`),
  INDEX `funcao_funcao_funcionario_idx` (`funcao` ASC) VISIBLE,
  CONSTRAINT `funcao_funcao_funcionario`
    FOREIGN KEY (`funcao`)
    REFERENCES `mydb`.`Funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `numero_funcao_funcionario`
    FOREIGN KEY (`numero`)
    REFERENCES `mydb`.`Funcionario` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_interno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico_interno` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico_interno` (
  `id` INT NOT NULL,
  `despesas` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_servico_interno`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`Servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manuntencao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Manuntencao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Manuntencao` (
  `id_servico` INT NOT NULL,
  `marcas_da_aeronave` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `marcas_da_aeronave_manutencao_idx` (`marcas_da_aeronave` ASC) VISIBLE,
  CONSTRAINT `id_servico_manutencao`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico_interno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `marcas_da_aeronave_manutencao`
    FOREIGN KEY (`marcas_da_aeronave`)
    REFERENCES `mydb`.`Aviao` (`marcas_da_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
