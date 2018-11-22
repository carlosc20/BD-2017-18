-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries 3
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
	------------------------------------------------------
    Administrador ?
	criar_manutencao(cenas) -> transaction
    ✔ ver_avioes_revisoes() -> avioes ordenados por revisoes
    
    ver_tempo_servico_funcionario_periodo(periodo, funcionario) -> total, serviço, livres
    
    
    ? criar_funcionario(coisas)
    ? atualizar_funcionario(coisas)
    criar_horario()
    atribuir_horario()
    ------------------------------------------------------
    */


-- Quantos serviços cada cliente fez de cada tipo
-- Admin?
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


-- Vê aviões ordenados pela data da próxima revisão
-- Administrador
SELECT 
    marcas_da_aeronave AS 'Marcas da aeronave',
    data_proxima_revisao AS 'Data da próxima revisão'
FROM
    Aviao
WHERE
    proprietario = 'Aerodromo da feira'
ORDER BY data_proxima_revisao;