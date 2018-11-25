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

CREATE USER 'Administrador'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Controlador'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Auxiliar'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Gestor'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Piloto'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Instrutor'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Revisor'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'Rececionista'@'localhost' IDENTIFIED BY 'password';

-- Administrador
GRANT SELECT ON Cliente TO Administrador;
GRANT SELECT ON Cliente_servico TO Administrador;
GRANT SELECT ON Servico_ao_cliente TO Administrador;
GRANT SELECT ON Servico TO Administrador;
GRANT SELECT ON Tipo TO Admnistrador;
GRANT SELECT ON Aviao TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Funcionario TO Administrador;
GRANT SELECT, INSERT ON Servico TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Manutencao TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Estado TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Tipo TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Funcao TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Horario_funcionario TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Horario TO Administrador;
GRANT SELECT, INSERT, UPDATE ON Dias_da_semana TO Administrador;

-- Auxiliar
GRANT SELECT ON lugares_livres TO Auxiliar;

-- Controlador
GRANT SELECT ON ciclos_planeados TO Controlador;
GRANT SELECT, UPDATE ON Servico TO Controlador;
GRANT SELECT ON Servico_ao_clinte TO Controlador;
GRANT SELECT, UPDATE ON Ciclo TO Controlador;
GRANT SELECT ON Estado TO Controlador;

-- Gestor
GRANT SELECT ON lucro_Avioes TO Gestor;
GRANT SELECT ON despesa_Socios TO Gestor;
GRANT SELECT ON Cliente_servico TO Gestor;
GRANT SELECT ON Servico TO Gestor;
GRANT SELECT ON Manutencao TO Gestor;
GRANT SELECT ON Funcionarios TO Gestor;
GRANT SELECT ON Quotas TO Gestor;
GRANT SELECT ON Tipo TO Gestor;
GRANT SELECT ON Estado TO Gestor;
GRANT SELECT, UPDATE ON Aviao TO Gestor;

-- Piloto, Instrutor, Revisor
GRANT SELECT ON Horario TO Piloto, Instrutor, Revisor;
GRANT SELECT ON Horario_funcionario TO Piloto, Instrutor, Revisor;
GRANT SELECT ON Funcionario TO Piloto, Instrutor, Revisor;
GRANT SELECT ON Dias_da_semana TO Piloto, Instrutor, Revisor;
GRANT SELECT ON Servico_funcionario TO Piloto, Instrutor, Revisor;
GRANT SELECT ON Estado TO Piloto, Instrutor, Revisor;
GRANT SELECT ON Tipo TO Piloto, Instrutor, Revisor;
GRANT SELECT, UPDATE ON Aviao TO Revisor;
GRANT SELECT ON Servico TO Revisor;
GRANT SELECT, UPDATE ON Manutencao TO Revisor;

-- Rececionista
GRANT SELECT, UPDATE, DELETE ON Servico TO Rececionista;
GRANT SELECT, INSERT ON Quotas TO Rececionista;
GRANT SELECT, INSERT ON Socio TO Rececionista;
GRANT SELECT, INSERT, UPDATE ON Cliente TO Rececionista;
GRANT SELECT, INSERT, DELETE ON Servico_ao_cliente TO Rececionista;
GRANT SELECT ON Tipo TO Rececionista;
GRANT SELECT, INSERT, DELETE ON Cliente_servico TO Rececionista;
GRANT SELECT ON Funcionario TO Rececionista;
GRANT SELECT ON Funcao_funcionario TO Rececionista;
GRANT SELECT ON Funcao TO Rececionista;
GRANT SELECT ON Horario_funcionario TO Rececionista;
GRANT SELECT ON Horario TO Rececionista;
GRANT SELECT ON Dias_da_semana TO Rececionista;
GRANT SELECT ON Servico_funcionario TO Rececionista;
GRANT SELECT ON Aviao TO Rececionista;
GRANT SELECT ON Manutencao TO Rececionista;
GRANT SELECT ON Ciclo TO Rececionista;

FLUSH PRIVILEGES;
/*
GRANT SELECT, INSERT ON Studio TO kirk, picard
WITH GRANT OPTION;
GRANT SELECT ON Movie TO kirk, picard
WITH GRANT OPTION;
*/