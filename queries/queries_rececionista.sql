-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries Rececionista
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
    ------------------------------------------------------
    Rececionista
    ? criar_cliente(coisas)
    ? atualizar_cliente()...
    M ver_clientes() -> ordenados por numero
    ✔ adicionar_quota(id_cliente)
    M ver_servicos() -> ordenado por id
    ✔ ver_servicos_com_vagas(tipo)
    M ver_avioes() -> ordenado por id
    ✔ ver_disponibilidade_funcionarios(funcao) ->
    D ver_disponibilidade_avioes(tipo) ->
    D cria_servico_ao_cliente(coisas)
    ✔ cancelar_servico(id)
    ✔ adiar_servico()
    ------------------------------------------------------
    */
    

-- Adiciona quota a um cliente, se for a primeiro adiciona número de sócio
-- Rececionista
/*
drop procedure `adicionar_quota`;
*/
DELIMITER $$
Create Procedure `adicionar_quota`(IN id INT, IN ano_quota YEAR)
BEGIN
    DECLARE n_socio INT;
    DECLARE r BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET r = TRUE;
    SET n_socio = (SELECT numero_socio FROM Socio WHERE id_cliente = id);
    START TRANSACTION;
    SET AUTOCOMMIT = OFF;
    IF (n_socio IS NULL)
        THEN
            INSERT INTO Socio
            (id_cliente)
            VALUE (id);
            SET n_socio = (SELECT numero_socio FROM Socio where id_cliente = id);
        IF r
            THEN ROLLBACK;
        END IF;
    END IF;
        INSERT INTO Quotas (id, ano)
        VALUE (n_socio, ano_quota);
        IF r
            THEN ROLLBACK;
            ELSE COMMIT;
        END IF;
END
$$
/*
CALL adicionar_quota(6, 2023);
select * from Quotas;
select * from Socio;
*/

-- ver_servicos_com_vagas(tipo)
/*
drop procedure `ver_servicos_com_vagas`;
*/
DELIMITER $$
CREATE PROCEDURE `ver_servicos_com_vagas`(IN tipoServico VARCHAR(255))
BEGIN
    SELECT
		CS.id_servico AS 'id serviço', S.data_de_inicio AS 'data de incio' ,COUNT(*) AS 'número de clientes atuais', SC.limite_clientes AS 'número limite de clientes', (SC.limite_clientes - COUNT(*)) AS 'número de vagas'
	FROM
		Servico AS S
	INNER JOIN
		Servico_ao_cliente AS SC ON SC.id = S.id
	INNER JOIN
		Tipo AS T ON T.designacao = tipoServico
	INNER JOIN
		Cliente_servico AS CS ON CS.id_servico = S.id
	WHERE S.data_de_inicio > NOW() -- '2018-11-20 08:00:00'
	GROUP BY CS.id_servico
    HAVING COUNT(*) < SC.limite_clientes;
END
$$
/*
CALL ver_servicos_com_vagas("Paraquedismo");
*/
-- ver_disponibilidade_funcionarios(funcao) Super hard, necessita revisão de pro's
/*
drop procedure `ver_disponibilidade_funcionarios`;
*/
DELIMITER $$
CREATE PROCEDURE `ver_disponibilidade_funcionarios`(IN funcao VARCHAR(255), IN data_inicio DATETIME, IN data_fim DATETIME)
BEGIN
	SELECT DISTINCT F.numero, F.nome
    FROM Funcionario AS F
    INNER JOIN Funcao_funcionario AS FF ON FF.numero = F.numero
    INNER JOIN Funcao AS Fun ON Fun.id = FF.funcao
    
    INNER JOIN Horario_funcionario AS HF ON HF.id_funcionario = F.numero
    INNER JOIN Horario AS H ON H.id = HF.id_horario
    INNER JOIN Dias_da_semana AS D ON D.id = H.id
    
    LEFT JOIN Servico_funcionario AS SF ON SF.id_funcionario = F.numero
    LEFT JOIN Servico AS S ON S.id = SF.id_servico
    WHERE funcao = Fun.designacao AND
    
		  DAYOFWEEK(NOW()) = D.dia AND
		  (DATE(data_inicio) BETWEEN H.data_inicio AND H.data_fim) AND
          (TIME(data_inicio) BETWEEN H.hora_inicio AND H.hora_fim) AND
          (DATE(data_fim) BETWEEN H.data_inicio AND H.data_fim) AND
          (TIME(data_fim) BETWEEN H.hora_inicio AND H.hora_fim) AND
          
          (S.id IS NULL OR
          ((data_inicio NOT BETWEEN S.data_de_inicio AND (S.data_de_inicio + duracao)) AND
          (data_fim NOT BETWEEN S.data_de_inicio AND (S.data_de_inicio + duracao))));
END
$$
/*
CALL ver_disponibilidade_funcionarios("Piloto", "2019-01-02 12:00", "2019-01-02 13:00");
*/

/*
drop procedure `ver_disponibilidade_avioes`;
*/
DELIMITER $$
CREATE PROCEDURE `ver_disponibilidade_avioes`(IN tipo VARCHAR(255), IN data_inicio DATETIME, IN data_fim DATETIME)
BEGIN
	SELECT DISTINCT A.marcas_da_aeronave
    FROM Aviao AS A
    INNER JOIN Tipo AS T ON T.id = A.tipo
    
    LEFT JOIN Manutencao AS M ON M.marcas_da_aeronave = A.marcas_da_aeronave
    LEFT JOIN Servico AS MS ON MS.id = M.id
    
    LEFT JOIN Ciclo AS C ON A.marcas_da_aeronave = C.marcas_da_aeronave
    LEFT JOIN Servico_ao_cliente AS SC ON SC.id = C.id_servico
    LEFT JOIN Servico AS CS ON CS.id = SC.id
    WHERE T.designacao = tipo AND
    
		  (MS.id IS NULL OR (
		  (data_inicio NOT BETWEEN MS.data_de_inicio AND (MS.data_de_inicio + MS.duracao)) AND
          (data_fim NOT BETWEEN MS.data_de_inicio AND (MS.data_de_inicio + MS.duracao)))) AND
          
          (CS.id IS NULL OR (
		  (data_inicio NOT BETWEEN
		  (CS.data_de_inicio + C.hora_partida_prevista) AND
		  (CS.data_de_inicio + C.hora_chegada_prevista)) AND
          
		  (C.hora_partida IS NULL OR C.hora_chegada < data_inicio)));
END
$$
/*
CALL ver_disponibilidade_avioes("Paraquedismo", "2019-01-02 12:00", "2019-01-02 13:00");
*/

-- ver clientes() -> ordenados por número
SELECT * FROM list_Clientes;
SELECT * FROM list_Servicos_
    
/*
drop procedure `cancelar_servico`;
*/
DELIMITER $$
CREATE PROCEDURE `cancelar_servico`(IN idServico INT)
BEGIN
	UPDATE Servico
    SET estado = (SELECT Id FROM Estado WHERE designacao = "Cancelado")
    WHERE id = idServico;
END
$$
/*
CALL cancelar_servico(1);
*/

/*
drop procedure `adiar_servico`;
*/
DELIMITER $$
CREATE PROCEDURE `adiar_servico`(IN idServico INT, IN novaData DATETIME)
BEGIN
	UPDATE Servico
    SET estado = (SELECT Id FROM Estado WHERE designacao = "Adiado"),
		data_de_inicio = novaData
    WHERE id = idServico;
END
$$
/*
CALL adiar_servico(1, NOW() + INTERVAL 1 DAY);
*/

/*
DROP PROCEDURE `criar_servico_ao_cliente`
*/
DELIMITER $$
CREATE PROCEDURE `criar_servico_ao_cliente` (IN dataServico DATETIME,IN duracao TIME,IN tipo TINYINT,IN limiteClientes INT, OUT idServico INT)
BEGIN
    DECLARE r BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET r = TRUE;

    START TRANSACTION;
    SET AUTOCOMMIT = OFF;
    
	INSERT INTO Servico (estado, data_de_inicio, duracao) VALUE (1, dataServico, duracao);
    IF r THEN ROLLBACK;
    END IF;
    
    SET idServico = last_insert_id();
    
    INSERT INTO Servico_ao_cliente (id, tipo, limite_clientes) VALUE (idServico, tipo, limiteClientes);
    
    IF r THEN ROLLBACK;
		 ELSE COMMIT;
	END IF;
END
$$

DELIMITER $$
CREATE PROCEDURE `atribuir_funcionario_servico`(IN idServico INT, IN numeroFuncionario INT, IN funcao TINYINT)
BEGIN
	INSERT INTO Servico_funcionario VALUE (idServico, numeroFuncionario, funcao);
END
$$

/*
	call criar_servico_ao_cliente(NOW(), "1:00:00", 1, 3, @idServico);
    select @idServico;
	call atribuir_funcionario_servico(@idServico, 1, 1);
    SELECT * FROM Servico;
*/