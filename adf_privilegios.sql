-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Privilégios e utilizadores
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb` ;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

CREATE USER 'utilizador'@'localhost' IDENTIFIED BY 'password'(edited)
GRANT <privilege list> ON <database element> TO <user list>
GRANT SELECT, INSERT ON Studio TO kirk, picard
WITH GRANT OPTION;
GRANT SELECT ON Movie TO kirk, picard
WITH GRANT OPTION;