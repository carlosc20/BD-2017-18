-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries 3
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
	------------------------------------------------------
    Administrador ?
	criar_manutencao(cenas) -> transaction
    ✔ ver_avioes_revisoes() -> avioes ordenados por revisoes
    
    ver_tempo_servico_funcionario_periodo(periodo, funcionario) -> total, serviço, livres
    
    
    ✔ criar_funcionario(coisas)
    ✔ atualizar_funcionario(coisas)
    criar_horario()
    atribuir_horario()
    ------------------------------------------------------
    */

-- Quantos serviços cada cliente fez de cada tipo
-- Admin?
SELECT 
    C.Nome, T.Designacao, COUNT(*) AS Contagem
FROM
    Cliente AS C
        INNER JOIN
    Cliente_servico AS CS ON C.id = CS.id_cliente
        INNER JOIN
    Servico_ao_cliente AS SC ON SC.id = CS.id_servico
        INNER JOIN
    Tipo AS T ON SC.tipo = T.id
GROUP BY C.id , T.id;


-- Vê aviões ordenados pela data da próxima revisão
-- Administrador
SELECT 
    marcas_da_aeronave AS 'Marcas da aeronave',
    data_proxima_revisao AS 'Data da próxima revisão'
FROM
    Aviao
WHERE
    proprietario = 'Aerodromo da feira'
ORDER BY data_proxima_revisao;


-- criar_funcionario adiciona um funcionario á tabela com os parametros fornecidos
/*
drop procedure `criar_funcionario`;
*/
DELIMITER $$
Create Procedure `criar_funcionario` (IN id INT, IN nome VARCHAR(255), IN data_nascimento DATE, genero CHAR(1), IN empregado TINYINT, IN salario DECIMAL(10,2))
BEGIN
    INSERT INTO Funcionario	
    VALUES (id,nome,data_nascimento,genero,empregado,salario);
	END
$$
-- call criar_funcionario(0,"Ruizinho",DATE("2017-06-15"),"M",1, 1000.5);


-- Função atualizar_funcionário atualiza um funcionario dado o numero do mesmo
/*
drop procedure `atualizar_salario_funcionario`;
*/
DELIMITER $$
Create Procedure `atualizar_salario_funcionario` (IN id INT, IN salario DECIMAL(10,2))
BEGIN
    UPDATE Funcionario
    SET salario=salario
    WHERE numero=id;
    END
$$
/*
call atualizar_salario_funcionario(2, 1000.5);
*/

/*
drop procedure `criar_manutencao`;
*/
DELIMITER $$
Create Procedure `criar_manutencao` (IN marcas_da_aeronave CHAR(6), IN data_de_inicio DATETIME, IN duracao TIME, OUT idServico INT)
BEGIN
	DECLARE estadoId INT;
    DECLARE r BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET r = TRUE;
    START TRANSACTION;
    SET estadoId = (SELECT id FROM Estado WHERE designacao = "Normal");

    INSERT INTO Servico (estado, data_de_inicio, duracao)
    VALUES (estadoId, data_de_inicio, duracao);
    IF r
		THEN ROLLBACK;
	END IF;
    SET idServico = LAST_INSERT_ID();
    
    INSERT INTO Manutencao (id, marcas_da_aeronave)
    VALUES (servico_id, marcas_da_aeronave);
    IF r
        THEN ROLLBACK;
		ELSE COMMIT;
	END IF;
END
$$
/*
CALL criar_manutencao("CS-AVC", NOW() + INTERVAL 1 DAY, "1:00");
*/

SELECT Servico.id, Estado.designacao, Servico.observacao
FROM Servico
INNER JOIN Estado ON Estado.id = Servico.estado
WHERE estado IN (2, 3)