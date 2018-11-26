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
    
    
    ✔ criar_funcionario(coisas)
    ✔ atualizar_funcionario(coisas)
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


-- criar_funcionario adiciona um funcionario á tabela com os parametros fornecidos
drop procedure `proc_criar_funcionario`;
DELIMITER $$
Create Procedure `proc_criar_funcionario` (IN id INT, IN nome VARCHAR(255), IN data_nascimento DATE, genero CHAR(1), IN empregado TINYINT, IN salario DECIMAL(10,2))
BEGIN
    INSERT INTO Funcionario	
    VALUES (id,nome,data_nascimento,genero,empregado,salario);
	END
$$
-- call criar_funcionario(0,"Ruizinho",DATE("2017-06-15"),"M",1, 1000.5);


-- Função atualizar_funcionário atualiza um funcionario dado o numero do mesmo
drop procedure `proc_atualizar_funcionario`;
DELIMITER $$
Create Procedure `proc_atualizar_funcionario` (IN id INT, IN data_criação TIMESTAMP, IN empregado TINYINT, IN salario DECIMAL(10,2))
BEGIN
    UPDATE Funcionario
    SET nome = nome, data_de_nascimento = data_nascimento, genero=genero, data_criacao=data_criação, empregado=empregado, salario=salario
    WHERE numero=id;
    END
$$
-- call atualizar_funcionario(0,"Zèzinho",DATE("2017-06-15"),"M",TIMESTAMP("2017-07-23",  "13:10:11"),1, 1000.5);
