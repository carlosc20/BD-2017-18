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
	Gestor e Administrador
    
    Gestor
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
    
    Administrador ?
	criar_manutencao(cenas)
    ver_avioes_revisoes() -> avioes ordenados por revisoes
    
    ver_tempo_servico_funcionario_periodo(periodo, funcionario) -> total, serviço, livres
    ver_ex_funcionarios()
    
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

-- criar_funcionario adiciona um funcionario á tabela com os parametros fornecidos
drop procedure `criar_funcionario`;
DELIMITER $$
Create Procedure `criar_funcionario` (IN id INT, IN nome VARCHAR(255), IN data_nascimento DATE, genero CHAR(1), IN data_criação TIMESTAMP, IN empregado TINYINT, IN salario DECIMAL(10,2))
BEGIN
    INSERT INTO Funcionario	
    VALUES (id,nome,data_nascimento,genero,data_criação,empregado,salario);
	END
$$
-- call criar_funcionario(0,"Ruizinho",DATE("2017-06-15"),"M",TIMESTAMP("2017-07-23",  "13:10:11"),1, 1000.5);

-- Função atualizar_funcionário atualiza um funcionario dado o numero do mesmo
drop procedure `atualizar_funcionario`;
DELIMITER $$
Create Procedure `atualizar_funcionario` (IN id INT, IN nome VARCHAR(255), IN data_nascimento DATE, genero CHAR(1), IN data_criação TIMESTAMP, IN empregado TINYINT, IN salario DECIMAL(10,2))
BEGIN
    UPDATE Funcionario
    SET nome = nome, data_de_nascimento = data_nascimento, genero=genero, data_criacao=data_criação, empregado=empregado, salario=salario
    WHERE numero=id;
    END
$$
-- call atualizar_funcionario(0,"Zèzinho",DATE("2017-06-15"),"M",TIMESTAMP("2017-07-23",  "13:10:11"),1, 1000.5);


