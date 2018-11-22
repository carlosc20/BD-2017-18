-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries 2
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
    ------------------------------------------------------
    Auxiliar, Controlador e Rececionista
    
    Auxiliar
    ✔ ver_lugares_livres()
    
	Controlador
	✔ ver_ciclos_planeados()
    ✔ ver_ciclos_a_decorrer() (não testado)
    ✔ atualiza_icao_aviao(icao)
	✔ completar_ciclo(partida, destino, inicio, fim)

    Rececionista'
    ? criar_cliente(coisas)
    ? atualizar_cliente()...
    M ver_clientes() -> ordenados por numero
    ✔ adicionar_quota(id_cliente)
    M ver_servicos() -> ordenado por id
    ver_servicos_com_vagas(tipo)
    M ver_avioes() -> ordenado por id
    ver_disponibilidade_funcionarios(funcao) ->
    ver_disponibilidade_avioes(tipo) ->
    cria_servico_ao_cliente(coisas)
    cancelar_servico(id)
    adiar_servico()??
    ------------------------------------------------------
    */
    
    
-- Ver lugares de estacionamento livres
-- Auxiliar
SELECT 
    designacao AS 'Designação'
FROM
    Lugar_local AS L
        LEFT JOIN
    Aviao AS A ON A.lugar_local = L.id
WHERE
    A.lugar_local IS NULL;
    

-- Ver ciclos planeados
-- Controlador
SELECT 
    id_servico,
    marcas_da_aeronave,
    icao_origem,
    icao_destino,
    hora_partida_prevista,
    duracao_prevista
FROM
    Ciclo AS C
        INNER JOIN
    Servico_ao_cliente AS SC ON SC.id = C.id_servico
        INNER JOIN
    Servico AS S ON S.id = SC.id
WHERE
    DATE(S.data_de_inicio) >= DATE(NOW())
        AND hora_partida IS NULL;


-- NAO TESTADO
-- Ver ciclos a decorrer 
-- Controlador
SELECT 
	*
FROM
	Servico AS S
		INNER JOIN
	Servico_ao_cliente AS SC ON SC.id = S.id
		INNER JOIN
	Ciclo AS C ON C.id_servico = SC.id
WHERE
	DATE(S.data_de_inicio) <= DATE(NOW())
		AND C.hora_partida IS NOT NULL
		AND C.hora_partida >= TIME(NOW())
		AND C.hora_chegada IS NULL;


-- Atualiza o código ICAO de um avião
-- Controlador
drop procedure `atualizar_icao_aviao`;
DELIMITER $$
CREATE PROCEDURE `atualizar_icao_aviao`(IN id CHAR(6), IN novo_icao CHAR(4))
BEGIN
    UPDATE Aviao 
    SET 
        icao_atual = novo_icao
    WHERE
        marcas_da_aeronave = id;
END
$$
CALL atualizar_icao_aviao("CS-AVC", "LPBZ");


-- Completa informação de um ciclo(id)
-- Controlador
drop procedure `completar_ciclo`;
DELIMITER $$
Create Procedure `completar_ciclo`(IN id INT, IN origem CHAR(4), IN destino CHAR(4), IN partida TIME, IN chegada TIME)
BEGIN
    UPDATE Ciclo
    SET 
        icao_origem = origem,
        icao_destino = destino,
        hora_partida = partida,
        hora_chegada = chegada
    WHERE
        id_servico = id;
END
$$
CALL completar_ciclo(1, "LPVF", "LPBZ", "18:25:00", "19:55:00");


-- adiciona quota a um cliente e se for a primeira mete numero de socio
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