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
drop view lucro_Avioes;
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
SELECT * from lucro_Avioes;

CREATE VIEW despesa_Socios AS
SELECT CS.id_cliente, CS.id_servico, socios.numero_socio, socios.nome, precos.preco- CS.pagamento AS Perda FROM 
    Cliente_Servico AS CS
    INNER JOIN 
    (Select C.id, SO.numero_socio, C.nome 
	FROM Cliente AS C 
    INNER JOIN Socio AS SO ON SO.id_cliente = C.id) AS socios ON socios.id = CS.id_cliente
    INNER JOIN 
    (Select SAC.id, preco, desconto
    FROM Servico_ao_cliente AS SAC
    INNER JOIN Tipo AS T ON T.id = SAC.tipo) AS precos ON precos.id = CS.id_servico
	