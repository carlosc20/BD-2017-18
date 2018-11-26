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

/*
DROP USER 'Administrador'@'localhost';
DROP USER 'Controlador'@'localhost';
DROP USER 'Auxiliar'@'localhost';
DROP USER 'Gestor'@'localhost';
DROP USER 'Piloto'@'localhost';
DROP USER 'Instrutor'@'localhost';
DROP USER 'Revisor'@'localhost';
DROP USER 'Rececionista'@'localhost';
*/

CREATE USER 'Administrador'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Controlador'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Auxiliar'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Gestor'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Piloto'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Instrutor'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Revisor'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Rececionista'@'localhost' IDENTIFIED BY 'password';



-- Administrador
GRANT SELECT ON Cliente TO 'Administrador'@'localhost';
GRANT SELECT ON Cliente_servico TO 'Administrador'@'localhost';
GRANT SELECT ON Servico_ao_cliente TO 'Administrador'@'localhost';
GRANT SELECT ON Servico TO 'Administrador'@'localhost';
GRANT SELECT ON Tipo TO 'Administrador'@'localhost';
GRANT SELECT ON Aviao TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Funcionario TO 'Administrador'@'localhost';
GRANT SELECT, INSERT ON Servico TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Manutencao TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Estado TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Tipo TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Funcao TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Horario_funcionario TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Horario TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Dias_da_semana TO 'Administrador'@'localhost';

-- 'Auxiliar'@'localhost'
GRANT SELECT ON lugares_livres TO 'Auxiliar'@'localhost';

-- 'Controlador'@'localhost'
GRANT SELECT ON ciclos_planeados TO 'Controlador'@'localhost';
GRANT SELECT, UPDATE ON Servico TO 'Controlador'@'localhost';
GRANT SELECT ON Servico_ao_clinte TO 'Controlador'@'localhost';
GRANT SELECT, UPDATE ON Ciclo TO 'Controlador'@'localhost';
GRANT SELECT ON Estado TO 'Controlador'@'localhost';

-- 'Gestor'@'localhost'
GRANT SELECT ON lucro_Avioes TO 'Gestor'@'localhost';
GRANT SELECT ON despesa_Socios TO 'Gestor'@'localhost';
GRANT SELECT ON Cliente_servico TO 'Gestor'@'localhost';
GRANT SELECT ON Servico TO 'Gestor'@'localhost';
GRANT SELECT ON Manutencao TO 'Gestor'@'localhost';
GRANT SELECT ON Funcionarios TO 'Gestor'@'localhost';
GRANT SELECT ON Quotas TO 'Gestor'@'localhost';
GRANT SELECT ON Tipo TO 'Gestor'@'localhost';
GRANT SELECT ON Estado TO 'Gestor'@'localhost';
GRANT SELECT, UPDATE ON Aviao TO 'Gestor'@'localhost';

-- 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost'
GRANT SELECT ON Horario TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT ON Horario_funcionario TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT ON Funcionario TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT ON Dias_da_semana TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT ON Servico_funcionario TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT ON Estado TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT ON Tipo TO 'Piloto'@'localhost', 'Instrutor'@'localhost', 'Revisor'@'localhost';
GRANT SELECT, UPDATE ON Aviao TO 'Revisor'@'localhost';
GRANT SELECT ON Servico TO 'Revisor'@'localhost';
GRANT SELECT, UPDATE ON Manutencao TO 'Revisor'@'localhost';

-- 'Rececionista'@'localhost'
GRANT SELECT, UPDATE, DELETE ON Servico TO 'Rececionista'@'localhost';
GRANT SELECT, INSERT ON Quotas TO 'Rececionista'@'localhost';
GRANT SELECT, INSERT ON Socio TO 'Rececionista'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Cliente TO 'Rececionista'@'localhost';
GRANT SELECT, INSERT, DELETE ON Servico_ao_cliente TO 'Rececionista'@'localhost';
GRANT SELECT ON Tipo TO 'Rececionista'@'localhost';
GRANT SELECT, INSERT, DELETE ON Cliente_servico TO 'Rececionista'@'localhost';
GRANT SELECT ON Funcionario TO 'Rececionista'@'localhost';
GRANT SELECT ON Funcao_funcionario TO 'Rececionista'@'localhost';
GRANT SELECT ON Funcao TO 'Rececionista'@'localhost';
GRANT SELECT ON Horario_funcionario TO 'Rececionista'@'localhost';
GRANT SELECT ON Horario TO 'Rececionista'@'localhost';
GRANT SELECT ON Dias_da_semana TO 'Rececionista'@'localhost';
GRANT SELECT ON Servico_funcionario TO 'Rececionista'@'localhost';
GRANT SELECT ON Aviao TO 'Rececionista'@'localhost';
GRANT SELECT ON Manutencao TO 'Rececionista'@'localhost';
GRANT SELECT ON Ciclo TO 'Rececionista'@'localhost';

FLUSH PRIVILEGES;
/*
GRANT SELECT, INSERT ON Studio TO kirk, picard
WITH GRANT OPTION;
GRANT SELECT ON Movie TO kirk, picard
WITH GRANT OPTION;
*/