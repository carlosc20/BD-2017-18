
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


	-----------------------------------------------------

	'Piloto' 
    'Instrutor' 
    'Revisor' 
	✔ ver_servicos_atribuidos(numero funcionario)
	✔ adiciona_observacao_servico(observacao, servico)
    Revisor só:
    ✔ ver_avioes_nossos()
	✔ ver_historico_manutencoes(aviao)
    ✔ completar_manutencao(despesas, nr fatura)
    ✔ atualizar_data_revisao_aviao(aviao)
    
    'Rececionista' 
    ? criar_cliente(coisas)
    ? atualizar_cliente()...
    M ver_clientes() -> ordenados por numero
    D adicionar_quota(id_cliente) -> cria socio se for primeira
    M ver_servicos() -> ordenado por id
    ver_servicos_com_vagas(tipo)
    M ver_avioes() -> ordenado por id
    ver_disponibilidade_funcionarios(funcao) ->
    ver_disponibilidade_avioes(tipo) ->
    cria_servico_ao_cliente(coisas)
    cancelar_servico(id)
    adiar_servico()??
    
    'Controlador' 
	ver_ciclos_planeados()
    ver_ciclos_a_decorrer() (não testado)
    atualiza_icao_aviao(icao)
    completar_ciclo(partida, destino, inicio, fim)

	'Auxiliar' 
    ✔ ver_lugares_livres()
    
    'Gestor'
    ver_funcionarios() -> ordenados
    ver_despesas_manutencao_por_aviao()
    ver_avioes()
    ver_ganhos_por_aviao()
    ver_lucro_por_aviao()
    ver_ganhos_quotas()
    ver_descontos()
    ver_ganhos_socios()
    ver_lucro_total()
    por_aviao_indisponivel(aviao)
    
    -----------------------------------------------------
    'Administrador' ✔?
	criar_manutencao(cenas)
    ver_avioes_revisoes() -> avioes ordenados por revisoes
    
    ver_tempo_servico_funcionario_periodo(periodo, funcionario) -> total, serviço, livres
    ver_ex_funcionarios()
    
    ? criar_funcionario(coisas)
    ? atualizar_funcionario(coisas)
    criar_horario()
    atribuir_horario()
    
	-----------------------------------------------------
	Todos:
    
    ✔ proc_ver_horario
	-----------------------------------------------------

	outros avioes ficam no maximo 48 horas
    verificar e multa


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
SELECT 
    *
FROM
    Cliente