-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `gerenciamento_eventos`;
CREATE SCHEMA IF NOT EXISTS `gerenciamento_eventos` DEFAULT CHARACTER SET utf8 ;
USE `gerenciamento_eventos` ;

-- -----------------------------------------------------
-- Table `mydb`.`local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciamento_eventos`.`local` (
  `local_id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `endereco` VARCHAR(80) NOT NULL,
  `capacidade_max` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`local_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciamento_eventos`.`evento` (
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(145) NULL,
  `data` DATE NOT NULL,
  `horario` VARCHAR(5) NOT NULL,
  `local_id` INT NOT NULL,
  `evento_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`evento_id`, `local_id`),
    FOREIGN KEY (`local_id`)
    REFERENCES `gerenciamento_eventos`.`local` (`local_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`participante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciamento_eventos`.`participante` (
  `participante_id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(65) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`participante_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inscricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciamento_eventos`.`inscricao` (
  `inscricao_id` INT NOT NULL AUTO_INCREMENT,
  `participante_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  PRIMARY KEY (`inscricao_id`, `participante_id`, `evento_id`),
    FOREIGN KEY (`participante_id`)
    REFERENCES `gerenciamento_eventos`.`participante` (`participante_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`evento_id`)
    REFERENCES `gerenciamento_eventos`.`evento` (`evento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `gerenciamento_eventos`.`local` (nome, endereco, capacidade_max, cidade) VALUES 
	("Pavilhão de Eventos", "Rua do Senai", 250, "Jaraguá from the South"),
    ("Rua de Eventos", "Rua Basilisco", 300, "Saint Paul"),
    ("Complexo Esportivo", "Rua Aspargo", 190, "Timbó");
    
INSERT INTO `gerenciamento_eventos`.`evento`
	(nome, descricao, data, horario, local_id) VALUES
	("Show de Horrores", "Sei lá", "2026-11-15", "19:00", 1),
	("Feira de Tecnologia", "Exposicao de projetos ", "2026-11-20", "14:00", 2),
	("Corrida", "Campeonato de Atletismo", "2026-11-25", "09:00", 3);

INSERT INTO `gerenciamento_eventos`.`participante`
(nome_completo, email, telefone) VALUES
("Joao Silva", "joao@gmail.com", "47990000001"),
("Maria Santos", "maria@gmail.com", "47990000002"),
("Pedro Oliveira", "pedro@gmail.com", "47990000003"),
("Ana Souza", "ana@gmail.com", "47990000004");

INSERT INTO `gerenciamento_eventos`.`inscricao`
(participante_id, evento_id) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2),
(3, 3),
(4, 3);

