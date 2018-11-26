-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries Piloto, Instrutor e Revisor
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

    /*
    ------------------------------------------------------
    Piloto, Instrutor e Revisor
    
	✔ ver_servicos_atribuidos(numero funcionario)
	✔ adiciona_observacao_servico(observacao, servico)
    ✔ ver_avioes_nossos()
	✔ ver_historico_manutencoes(aviao)
    ✔ completar_manutencao(despesas, nr fatura)
    ✔ atualizar_data_revisao_aviao(aviao)
    
    ✔ ver_horario
    ------------------------------------------------------
    */
    
    
-- converte int em varchar com dia da semana
/*
drop function dia_semana
*/
DELIMITER $$
CREATE FUNCTION `dia_semana` (n INT)
	RETURNS VARCHAR(14) DETERMINISTIC
BEGIN
	RETURN (CASE
		WHEN n=0 THEN 'segunda-feira'
        WHEN n=1 THEN 'terça-feira'
        WHEN n=2 THEN 'quarta-feira'
        WHEN n=3 THEN 'quinta-feira'
        WHEN n=4 THEN 'sexta-feira'
        WHEN n=5 THEN 'sábado'
        WHEN n=6 THEN 'domingo'
	END);
END
$$

-- Vê horário de um funcionário
-- Todos
/*
drop procedure `proc_ver_horario`;
*/
DELIMITER $$
Create Procedure `proc_ver_horario` (IN numero INT)
BEGIN
	SELECT 
		data_inicio AS 'Data início',
		data_fim AS 'Data fim',
		hora_inicio AS 'Hora início',
		hora_fim AS 'Hora fim',
		GROUP_CONCAT(dia_semana(D.dia)
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
/*
CALL proc_ver_horario(1);
*/

-- NAO TESTADO
-- Vê serviços por concluir atribuídos a um funcionário(numero)
-- Instrutor, Piloto e Revisor
/*
drop procedure `proc_ver_servicos_atribuidos`;
*/
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
			AND S.data_de_inicio >= NOW(); -- '2018-01-01'
END
$$
/*
CALL proc_ver_servicos_atribuidos(13);
*/

-- Adiciona observação a um serviço(id)
-- Controlador, Rececionista
/*
drop procedure `proc_adicionar_observacao_servico`;
*/
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
/*
CALL proc_adicionar_observacao_servico(1, "O cliente não apareceu");
*/

-- Vê historio de manutenções de um avião
-- Revisor
/*
drop procedure `proc_historico_manutencao_aviao`;
*/
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
/*
CALL proc_historico_manutencao_aviao("CS-AVC");
*/

-- Completa os dados de uma manutenção com possíveis despesas e id de fatura correspondente
-- Revisor
/*
drop procedure `completar_manutencao`;
*/
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
/*
CALL completar_manutencao(1, 100, 111111111);
*/

-- Atualizar data de revisão de um avião
-- Revisor
/*
drop procedure `atualizar_data_de_revisao`;
*/
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
/*
CALL atualizar_data_de_revisao("CS-AVC", DATE(NOW()));
*/