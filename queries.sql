
USE `mydb` ;

-- quantos servicos cada cliente fez de cada tipo
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
    
    
    
-- que aeronaves aterraram no aerodromo vindas de outros locais
SELECT DISTINCT
    Marcas_da_aeronave AS 'Marcas da aeronave'
FROM
    Ciclo
WHERE
    icao_destino = 'LPVF'
        AND icao_origem != 'LPVF';


-- quantos voos foram feitos que começaram e acabaram no aerodromo
SELECT 
    COUNT(*) AS 'Numero'
FROM
    Ciclo
WHERE
    icao_origem = icao_destino;


-- 3 clientes que gastaram mais e quanto gastaram
SELECT 
    C.Nome, SUM(CS.Pagamento) AS Total
FROM
    Cliente AS C
        INNER JOIN
    Cliente_servico AS CS ON CS.id_cliente = C.id
        INNER JOIN
    Quotas AS Q ON Q.id = C.id
GROUP BY C.id
ORDER BY Total
LIMIT 3;


-- que aeronave foi mais lucrativa
SELECT 
    A.Marcas_da_aeronave AS 'Marcas da aeronave',
    IFNULL(SUM(SC.montante_total), 0) - IFNULL(SUM(M.despesas), 0) AS Lucro
FROM
    Aviao AS A
        LEFT JOIN
    Ciclo AS C ON C.marcas_da_aeronave = A.marcas_da_aeronave
        LEFT JOIN
    Servico_ao_cliente AS SC ON SC.id = C.id_servico
        LEFT JOIN
    Manutencao AS M ON M.marcas_da_aeronave = A.marcas_da_aeronave
GROUP BY A.marcas_da_aeronave
ORDER BY lucro DESC;

/*
	-----------------------------------------------------
	Horário flexível:
    
	'Piloto'
    'Instrutor'
    ver_servicos_periodo
    adicionar_observacao_servico
    
    'Revisor' ✔
    ver_manutencoes_atribuidas
    ver_aviao
    ver_historico_aviao
    atualizar manutencao
    atualizar data revisao aviao
    
    -----------------------------------------------------
    Horário fixo:
    
    'Rececionista' ✔
    inserir_cliente
    atualizar_cliente
	ver_cliente
    
    inserir_servico_ao_cliente
    ver_servicos_ao_cliente
    inserir_quotas/por socio

    ver_disponibilidade_funcionarios
    ver_disponibilidade_avioes
    
    -----------------------------------------------------
    'Controlador'
	ver_ciclos_periodo
    ver_ciclos_a_decorrer (não testado)
    ver_ocupacao_local
	-----------------------------------------------------
	'Auxiliar'
    ver_servicos_periodo
    ✔ ver lugares livres
    -----------------------------------------------------
    'Gestor'
    ver_transacoes_periodo
    ver_lucro_cliente
    ver_lucro_aviao
    ver_socios_quotas (não testado)
    
    -----------------------------------------------------
    'Administrador'
    ver_tempo_servico_funcionario_periodo
    
    criar_funcionario
    atualizar_funcionario
    criar horario
    
	-----------------------------------------------------
	Todos:
    
    ✔ proc_ver_horario
	-----------------------------------------------------
*/

-- ver disponibilidade dos funcionários
drop procedure if exists `proc_ver_disponibilidade_funcionarios`;
DELIMITER $$
Create Procedure `proc_ver_disponibilidade_funcionarios` (IN inicio DATETIME, IN fim DATETIME, IN funcao VARCHAR(255))
BEGIN
	SELECT 
		*
	FROM
		Funcionario AS Fun
			INNER JOIN
		Funcao_funcionario AS Ff ON Ff.numero = Fun.numero
			INNER JOIN
		Funcao AS F ON Ff.funcao = F.id
			INNER JOIN
		Horario_funcionario AS Hf ON Hf.id_funcionario = Fun.numero
			INNER JOIN
		Horario AS H ON H.id = Hf.id_horario
	WHERE
		designacao = funcao
			AND Fun.empregado = TRUE;
END
$$
CALL proc_ver_disponibilidade_funcionarios('2018-06-24 12:00', '2018-06-24 13:00', 'Piloto');


-- ver ciclos a decorrer (não testado)
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

-- lugares livres
SELECT 
    designacao AS 'Designação'
FROM
    Lugar_local AS L
        LEFT JOIN
    Aviao AS A ON A.lugar_local = L.id
WHERE
    A.lugar_local IS NULL;

-- ver_socios_quotas (falta testar)
SELECT 
    C.nome, COUNT(*) AS 'Número de Quotas'
FROM
    Cliente AS C
        INNER JOIN
    Quotas AS Q ON C.id = Q.id
GROUP BY C.id
ORDER BY COUNT(*) DESC;

drop procedure `proc_ver_horario`;
DELIMITER $$
Create Procedure `proc_ver_horario` (IN numero INT)
BEGIN
	SELECT 
		data_inicio AS 'Data início',
		data_fim AS 'Data fim',
		hora_inicio AS 'Hora início',
		hora_fim AS 'Hora fim',
		GROUP_CONCAT(DIA_SEMANA(D.dia)
			SEPARATOR ', ') AS 'dias da semana'
	FROM
		Horario AS H
			INNER JOIN
		Horario_funcionario AS Hf ON Hf.id_horario = H.id
			INNER JOIN
		Funcionario AS Fun ON Fun.numero = Hf.id_funcionario
			INNER JOIN
		Dias_da_semana AS D ON H.id = D.id
	WHERE
		Fun.numero = numero
	GROUP BY H.id;
END
$$
CALL proc_ver_horario(1);


drop function dia_semana
DELIMITER %%
create function `dia_semana` (n INT)
	RETURNS VARCHAR(14) DETERMINISTIC
BEGIN
	DECLARE dia VARCHAR(14);
	SET dia = (CASE
		WHEN n=0 THEN 'segunda-feira'
        WHEN n=1 THEN 'terça-feira'
        WHEN n=2 THEN 'quarta-feira'
        WHEN n=3 THEN 'quinta-feira'
        WHEN n=4 THEN 'sexta-feira'
        WHEN n=5 THEN 'sábado'
        WHEN n=6 THEN 'domingo'
	END);
	RETURN dia;
END
%%

-- ver_servicos_atribuidos (numFuncionario) servicos por vir
drop procedure `proc_ver_servicos_atribuidos`;
DELIMITER $$
Create Procedure `proc_ver_servicos_atribuidos` (IN numero INT)
BEGIN
	SELECT 
		S.id,
		E.designacao AS 'estado',
		S.data_de_inicio AS 'data de início',
		S.duracao
	FROM
		Servico AS S
			INNER JOIN
		Servico_funcionario AS SF ON S.id = SF.id_servico
			INNER JOIN
		Estado AS E ON E.id = S.estado
	WHERE
		SF.id_funcionario = numero
			AND S.data_de_inicio >= NOW();
END
$$
CALL proc_ver_servicos_atribuidos(1);
-- adicionarObservacaoAoServico (idServico, Observacao)
drop procedure `proc_adicionar_observacao_servico`;
DELIMITER $$
Create Procedure `proc_adicionar_observacao_servico` (IN idServico INT, IN observacao TEXT)
BEGIN
	UPDATE Servico AS S 
	SET 
		observacao = observacao
	WHERE
		S.id = idServico;
END
$$
CALL proc_adicionar_observacao_servico(1, "Serviço foi realizado com sucesso");
-- verAvioes que nos pertencer e carateristicas
select * from Aviao as A
where A.proprietario = 'Aerodromo da feira';
-- historio de manutençao do avião
drop procedure `proc_historico_manutencao_aviao`;
DELIMITER $$
Create Procedure `proc_historico_manutencao_aviao`(IN id CHAR(6))
BEGIN
	SELECT 
		*
	FROM
		Servico AS S
			INNER JOIN
		Manutencao AS M ON S.id = M.id
	WHERE
		marcas_da_aeronave = id;
END
$$
CALL proc_historico_manutencao_aviao("CS-AVC");
-- completarManutenção(idServico, Despesas, NumFatura)
drop procedure `completar_manutencao`;
DELIMITER $$
Create Procedure `completar_manutencao`(IN idManutencao INT, IN nova_despesa DECIMAL(10,2), IN nova_fatura INT)
BEGIN
	UPDATE Manutencao 
	SET 
		despesas = nova_despesa,
		fatura = nova_fatura
	WHERE
		id = idManutencao;
END
$$
CALL completar_manutencao(1, 100, 111111111);

-- atualizar data de revisão de um avião
drop procedure `atualizar_data_de_revisao`;
DELIMITER $$
Create Procedure `atualizar_data_de_revisao`(IN id CHAR(6), IN nova_data DATE)
BEGIN
	UPDATE Aviao 
	SET 
		data_proxima_revisao = nova_data
	WHERE
		marcas_da_aeronave = id;
END
$$
CALL atualizar_data_de_revisao("CS-AVC", DATE(NOW()));
-- adiciona quota a um cliente e se for a primeira mete numero
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
select * from Quotas;
select * from Cliente;