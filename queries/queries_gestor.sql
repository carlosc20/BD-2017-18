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
    
    
-- Vê registos de todos os aviões já usados
SELECT marcas_da_aeronave as 'Marcas da aeronave', proprietario as 'Proproetário', modelo as 'Modelo', numero_max_passageiros as 'Número máximo de passageiros', disponivel as 'Disponibilidade' FROM Aviao as A
left join Lugar_local as Ll on Ll.id = A.lugar_local
inner join Tipo as T on T.id = A.tipo;
    
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