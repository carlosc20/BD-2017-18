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
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
  `data_criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `empregado` TINYINT NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcao` (
  `id` TINYINT NOT NULL,
  `designacao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `designacao_UNIQUE` (`designacao` ASC) VISIBLE)
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_funcionario_horario_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`Funcionario` (`numero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lugar_local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Lugar_local` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Lugar_local` (
  `id` TINYINT NOT NULL,
  `designacao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `designacao_UNIQUE` (`designacao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tipo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipo` (
  `id` TINYINT NOT NULL,
  `designacao` VARCHAR(255) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `desconto` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`Aviao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aviao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Aviao` (
  `marcas_da_aeronave` CHAR(6) NOT NULL,
  `tipo` TINYINT NOT NULL,
  `lugar_local` TINYINT NULL,
  `proprietario` VARCHAR(255) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `numero_max_passageiros` INT NOT NULL,
  `disponivel` TINYINT NOT NULL,
  `data_proxima_revisao` DATE NOT NULL,
  PRIMARY KEY (`marcas_da_aeronave`),
  INDEX `lugar_local_aviao_idx` (`lugar_local` ASC) VISIBLE,
  INDEX `tipo_aviao_idx` (`tipo` ASC) VISIBLE,
  CONSTRAINT `lugar_local_aviao`
    FOREIGN KEY (`lugar_local`)
    REFERENCES `mydb`.`Lugar_local` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tipo_aviao`
    FOREIGN KEY (`tipo`)
    REFERENCES `mydb`.`Tipo` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `id` TINYINT NOT NULL,
  `designacao` VARCHAR(63) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `designacao_UNIQUE` (`designacao` ASC) VISIBLE)
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
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_ao_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico_ao_cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico_ao_cliente` (
  `id` INT NOT NULL,
  `tipo` TINYINT NOT NULL,
  `limite_clientes` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `tipo_servico_externo_idx` (`tipo` ASC) VISIBLE,
  CONSTRAINT `id_servico_ao_cliente`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`Servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tipo_servico_ao_cliente`
    FOREIGN KEY (`tipo`)
    REFERENCES `mydb`.`Tipo` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ciclo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ciclo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ciclo` (
  `id_servico` INT NOT NULL,
  `marcas_da_aeronave` VARCHAR(6) NOT NULL,
  `hora_partida_prevista` DATETIME NOT NULL,
  `hora_chegada_prevista` DATETIME NOT NULL,
  `hora_partida` DATETIME NULL,
  `hora_chegada` DATETIME NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `marcas_da_aeronave_idx` (`marcas_da_aeronave` ASC) VISIBLE,
  CONSTRAINT `id_servico_servico_aviao`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico_ao_cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `marcas_da_aeronave_servico_aviao`
    FOREIGN KEY (`marcas_da_aeronave`)
    REFERENCES `mydb`.`Aviao` (`marcas_da_aeronave`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Servico_funcionario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Servico_funcionario` (
  `id_servico` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  `funcao` TINYINT NOT NULL,
  PRIMARY KEY (`id_servico`, `id_funcionario`),
  INDEX `id_servico_idx` (`id_servico` ASC) VISIBLE,
  INDEX `funcao_idx` (`funcao` ASC) VISIBLE,
  INDEX `id_funcionario_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `id_servico_servico_funcionario`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `funcao_servico_funcionario`
    FOREIGN KEY (`funcao`)
    REFERENCES `mydb`.`Funcao` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_funcionario_servico_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`Funcionario` (`numero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `data_criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `brevete` TINYINT NOT NULL,
  `formacao_paraquedismo` TINYINT NOT NULL,
  `numero_de_telefone` VARCHAR(45) NOT NULL,
  `morada` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente_servico` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente_servico` (
  `id_cliente` INT NOT NULL,
  `id_servico` INT NOT NULL,
  `pagamento` DECIMAL(10,2) NOT NULL,
  `presenca` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_cliente`, `id_servico`),
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_servico_servico_cliente_idx` (`id_servico` ASC) VISIBLE,
  CONSTRAINT `id_cliente_cliente_servico`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_servico_cliente_servico`
    FOREIGN KEY (`id_servico`)
    REFERENCES `mydb`.`Servico_ao_cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Socio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Socio` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Socio` (
  `id_cliente` INT NOT NULL,
  `numero_socio` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `numero_socio_UNIQUE` (`numero_socio` ASC) VISIBLE,
  CONSTRAINT `id_servico_socio`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
    REFERENCES `mydb`.`Socio` (`numero_socio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `numero_funcao_funcionario`
    FOREIGN KEY (`numero`)
    REFERENCES `mydb`.`Funcionario` (`numero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manutencao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Manutencao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Manutencao` (
  `id` INT NOT NULL,
  `marcas_da_aeronave` VARCHAR(6) NOT NULL,
  `despesas` DECIMAL(10,2) NULL,
  `fatura` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `marcas_da_aeronave_servico_interno_idx` (`marcas_da_aeronave` ASC) VISIBLE,
  CONSTRAINT `id_manutencao`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`Servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `marcas_da_aeronave_manutencao`
    FOREIGN KEY (`marcas_da_aeronave`)
    REFERENCES `mydb`.`Aviao` (`marcas_da_aeronave`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Ciclo_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Ciclo_BEFORE_INSERT` BEFORE INSERT ON `Ciclo` FOR EACH ROW
BEGIN
    IF NEW.hora_partida IS NULL AND NEW.hora_chegada IS NOT NULL
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A hora_partida não pode ser null quando hora_chegada é não null';
    END IF;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Ciclo_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Ciclo_BEFORE_UPDATE` BEFORE UPDATE ON `Ciclo` FOR EACH ROW
BEGIN
    IF NEW.hora_partida IS NULL AND NEW.hora_chegada IS NOT NULL
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'hora_partida não pode ser null quando hora_chegada é não null';
    END IF;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Cliente_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Cliente_BEFORE_INSERT` BEFORE INSERT ON `Cliente` FOR EACH ROW
BEGIN
    IF (TIMESTAMPDIFF(YEAR, NEW.data_nascimento, NOW()) < 17 AND (NEW.brevete = TRUE OR NEW.formacao_paraquedismo = TRUE))
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O Cliente deve ter 17 ou mais anos para ter brevete ou formação em paraquedismo';
    END IF;
    IF NEW.genero NOT IN ('M','F')
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O genero deve ser M ou F';
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
