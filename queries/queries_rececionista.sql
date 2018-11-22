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
    ver_disponibilidade_avioes(tipo) ->
    cria_servico_ao_cliente(coisas)
    cancelar_servico(id)
    adiar_servico()??
    ------------------------------------------------------
    */
    

-- Adiciona quota a um cliente, se for a primeiro adiciona número de sócio
-- Rececionista
drop procedure `adicionar_quota`;
DELIMITER $$
Create Procedure `adicionar_quota`(IN id_cliente INT, IN ano_quota YEAR)
BEGIN
    DECLARE socio INT;
    DECLARE r BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET r = 1;
    SET socio = (SELECT numero_socio FROM Cliente WHERE id = id_cliente);
    START TRANSACTION;
    IF (socio IS NULL)
        THEN
            SET socio = ((
                SELECT numero_socio FROM Cliente
                ORDER BY numero_socio DESC
                LIMIT 1
            ) + 1);
            UPDATE Cliente 
            SET 
                numero_socio = socio
            WHERE
                id = id_cliente;
        IF r
            THEN ROLLBACK;
        END IF;
    END IF;
        INSERT Quotas (id, ano)
        VALUE (socio, ano_quota);
        IF r
            THEN ROLLBACK;
            ELSE COMMIT;
        END IF;
END
$$
CALL adicionar_quota(6, 2023);

-- ver_servicos_com_vagas(tipo)
drop procedure `ver_servicos_com_vagas`;
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
	WHERE S.data_de_inicio > NOW()
	GROUP BY CS.id_servico
    HAVING COUNT(*) < SC.limite_clientes;
END
$$
CALL ver_servicos_com_vagas("Paraquedismo");

-- ver_disponibilidade_funcionarios(funcao) Super hard, necessita revisão de pro's
drop procedure `ver_disponibilidade_funcionarios`;
DELIMITER $$
CREATE PROCEDURE `ver_disponibilidade_funcionarios`(IN funcao VARCHAR(255), IN data_inicio DATETIME, IN data_fim DATETIME)
BEGIN
	SELECT F.numero, F.nome
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

-- Não testado
drop procedure `ver_disponibilidade_avioes`;
DELIMITER $$
CREATE PROCEDURE `ver_disponibilidade_avioes`(IN tipo VARCHAR(255), IN data_inicio DATETIME, IN data_fim DATETIME)
BEGIN
	SELECT A.marcas_do_aviao
    FROM Aviao AS A
    INNER JOIN Tipo AS T ON T.id = A.tipo
    
    LEFT JOIN Manutencao AS M ON M.marcas_da_aeronave = A.marcas_da_aeronave
    LEFT JOIN Servico AS MS ON S.id = M.id
    
    LEFT JOIN Ciclo AS C ON A.marcas_da_aeronave = C.marcas_da_aeronave
    LEFT JOIN Servico_ao_cliente AS SC ON SC.id = C.id_servico
    LEFT JOIN Servico AS CS ON S.id = SC.id
    WHERE T.designacao = tipo AND
    
		  (MS.id IS NULL OR (
		  (data_inicio NOT BETWEEN MS.data_inicio AND (MS.data_incio + MS.duracao)) AND
          (data_fim NOT BETWEEN MS.data_inicio AND (MS.data_incio + MS.duracao)))) AND
          
          (CS.id IS NULL OR (
		  (data_inicio NOT BETWEEN
		  (CS.data_de_inicio + C.hora_partida_prevista) AND
		  (CS.data_de_inicio + C.hora_chegada_prevista)) AND
		  (C.hora_partida IS NULL OR C.hora_chegada < data_inicio)));
END
$$

-- ver clientes() -> ordenados por número
CREATE VIEW  list_Clientes AS
SELECT nome AS 'Nome', brevete AS 'Brevete', formacao_paraquedismo AS 'Formação de Paraquedismo',
        numero_socio AS 'Número de Sócio', genero AS 'Género', numero_de_telefone AS 'Número de Telefone',
        rua AS 'Morada', codigo_postal AS 'Código Postal'
    FROM cliente
    ORDER BY cliente.id;

Select * From list_Clientes;


-- ver_servicos() -> ordenado por id .....faltam ciclos....faltam clientes atuais
SELECT S.id AS 'Identificador do Serviço', T.designacao AS 'Tipo', SC.montante_total AS 'Montante Total', SC.limite_clientes AS 'Limite de Clientes',
        count(*) AS 'Total de Clientes', E.designacao AS 'Estado', S.data_de_inicio AS 'Data e Hora de Início', S.duracao AS 'Duração prevista', S.observacao AS 'Observações'
    From Servico AS S
        INNER JOIN servico_ao_cliente AS SC ON SC.id = S.id
        INNER JOIN cliente_servico AS CS ON CS.id_servico = SC.id
        Inner Join cliente AS C ON C.id = CS.id_cliente
        INNER JOIN Tipo AS T ON T.id = SC.tipo
        Inner Join Estado AS E ON E.id = S.estado
    GROUP BY S.id;