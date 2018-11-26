
CREATE VIEW servicos_adiados_e_porfazer AS
SELECT S.id AS 'Identificador do Serviço', T.designacao AS 'Tipo', SC.limite_clientes AS 'Limite de Clientes',
        count(*) AS 'Total de Clientes', E.designacao AS 'Estado', S.data_de_inicio AS 'Data e Hora de Início', S.duracao AS 'Duração prevista', S.observacao AS 'Observações'
    From Servico AS S
        INNER JOIN servico_ao_cliente AS SC ON SC.id = S.id
        INNER JOIN cliente_servico AS CS ON CS.id_servico = SC.id
        Inner Join cliente AS C ON C.id = CS.id_cliente
        INNER JOIN Tipo AS T ON T.id = SC.tipo
        Inner Join Estado AS E ON E.id = S.estado
			where E.id = 3 OR E.id = 4
    GROUP BY S.id;
    
CREATE VIEW  list_Clientes AS
SELECT nome AS 'Nome', brevete AS 'Brevete', formacao_paraquedismo AS 'Formação de Paraquedismo',
	  genero AS 'Género', numero_de_telefone AS 'Número de Telefone',
        morada AS 'Morada' 
        FROM Cliente
    ORDER BY Cliente.id;
    
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
SELECT CS.id_cliente, socios.numero_socio, socios.nome, -1*sum(precos.preco-CS.pagamento) AS Perda FROM 
    Cliente_servico AS CS
    INNER JOIN 
    (Select C.id, SO.numero_socio, C.nome 
	FROM Cliente AS C 
    INNER JOIN Socio AS SO ON SO.id_cliente = C.id) AS socios ON socios.id = CS.id_cliente
    INNER JOIN 
    (Select SAC.id, preco, desconto
    FROM Servico_ao_cliente AS SAC
    INNER JOIN Tipo AS T ON T.id = SAC.tipo) AS precos ON precos.id = CS.id_servico
    GROUP BY CS.id_cliente
    ORDER BY Perda;

CREATE VIEW despesa_Funcionarios AS
SELECT F.nome AS 'Nome', F.numero AS 'Número' , -1*(1+TIMESTAMPDIFF(MONTH, F.data_criacao, now()))*F.salario AS acumulado FROM 
	     Funcionario AS F
         ORDER BY acumulado;
         

CREATE VIEW ciclos_planeado AS
SELECT 
    id_servico,
    marcas_da_aeronave,
    hora_partida_prevista,
    hora_chegada_prevista
FROM
    Ciclo AS C
        INNER JOIN
    Servico_ao_cliente AS SC ON SC.id = C.id_servico
        INNER JOIN
    Servico AS S ON S.id = SC.id
WHERE
    DATE(S.data_de_inicio) >= DATE(NOW())
        AND hora_partida IS NULL;