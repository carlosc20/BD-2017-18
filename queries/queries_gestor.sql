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
CREATE VIEW lucro_Avioes AS
SELECT A.marcas_da_aeronave as 'Marcas da aeronave', modelo as 'Modelo',
   IFNULL(SUM(M.despesas), 0) AS 'Despesa em Manutenções', IFNULL(SUM(CS.pagamento), 0) AS 'Rendimento em Serviços',
   IFNULL(SUM(CS.pagamento), 0) - IFNULL(SUM(M.despesas), 0) AS Total
	FROM
    Aviao AS A
        LEFT JOIN
    Ciclo AS C ON C.marcas_da_aeronave = A.marcas_da_aeronave
        LEFT JOIN
    Servico_ao_cliente AS SC ON SC.id = C.id_servico
        LEFT JOIN
	Cliente_servico AS CS ON CS.id_servico = SC.id
		LEFT JOIN
    Manutencao AS M ON M.marcas_da_aeronave = A.marcas_da_aeronave
GROUP BY A.marcas_da_aeronave
ORDER BY Total DESC; 

CREATE VIEW despesa_Socios AS
SELECT CS.id_cliente, CS.id_servico, socios.numero_socio, socios.nome, -1*sum(precos.preco-CS.pagamento) AS Perda FROM 
    Cliente_Servico AS CS
    INNER JOIN 
    (Select C.id, SO.numero_socio, C.nome 
	FROM Cliente AS C 
    INNER JOIN Socio AS SO ON SO.id_cliente = C.id) AS socios ON socios.id = CS.id_cliente
    INNER JOIN 
    (Select SAC.id, preco, desconto
    FROM Servico_ao_cliente AS SAC
    INNER JOIN Tipo AS T ON T.id = SAC.tipo) AS precos ON precos.id = CS.id_servico
    GROUP BY id_cliente
    ORDER BY Perda;

SELECT SUM(Total) AS 'Lucro acumulado da empresa' From
((SELECT Total FROM lucro_Avioes) UNION (SELECT Perda FROM despesa_Socios)) AS T;

drop procedure `lucro_temporal`;
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
call lucro_temporal('2018-11-20 00:10:00', '2018-11-21 20:10:00'); 