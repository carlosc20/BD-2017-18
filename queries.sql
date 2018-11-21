-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Coisas variadas
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb` ;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	-- outros avioes ficam no maximo 48 horas
    -- verificar e multa


-- QUERIES ALEATORIAS:
    
-- Que aeronaves aterraram no aeródromo vindas de outros locais
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