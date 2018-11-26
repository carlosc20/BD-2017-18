-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries Gestor
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
	------------------------------------------------------
    Gestor
    ver_funcionarios() -> ordenados
    ver_ex_funcionarios()
    ver_despesas_manutencao_por_aviao()
    ver_avioes()
    ver_ganhos_por_aviao()
    ver_lucro_por_aviao()
    ver_ganhos_quotas()
    ver_descontos()
    ver_ganhos_socios()
    ver_lucro_total()
    por_aviao_indisponivel(aviao)
    ------------------------------------------------------
    */

-- Vê infos de dinheiro de aviões
SELECT * FROM lucro_Avioes;

SELECT * FROM despesa_Socios;

SELECT * FROM despesa_Funcionarios;

/*
drop procedure `balanco_total`;
*/
DELIMITER $$
CREATE PROCEDURE `balanco_total`(IN preco_quota DECIMAL(10,2))
BEGIN
	SELECT SUM(Total) AS 'Balanço total da empresa' From
	((SELECT Total FROM lucro_Avioes) UNION (SELECT Perda FROM despesa_Socios) 
	UNION (SELECT preco_quota*count(*) FROM Quotas) UNION (SELECT acumulado FROM despesa_Funcionarios)) AS T;
END
$$
/*
call balanco_total(1000); 
*/

/*
drop procedure `lucro_temporal`;
*/
DELIMITER $$
CREATE PROCEDURE `lucro_temporal`(IN data_inicio DATETIME, IN data_fim DATETIME)
BEGIN
	SELECT  IFNULL(SUM(L.valor),0) AS 'Lucro total do intervalo' FROM
	((SELECT id_servico AS id, pagamento AS valor FROM Cliente_servico) UNION (SELECT id, IFNULL(-1*despesas,0) AS valor FROM Manutencao)) AS L 
    INNER JOIN 
	(SELECT S.id FROM Servico AS S
		WHERE S.data_de_inicio BETWEEN data_inicio AND data_fim) AS servicos ON servicos.id = L.id;
END
$$
/*
call lucro_temporal('2018-11-20 00:10:00', '2018-11-21 20:10:00'); 
*/