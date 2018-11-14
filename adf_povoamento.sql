-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Povoamento inicial da base de dados
-- ------------------------------------------------------
-- ------------------------------------------------------

--
-- Esquema: "mydb"
USE `mydb` ;

--
-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

--
-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
	(id, nome, brevete, formacao_paraquedismo, email, numero_socio, data_nascimento, genero, numero_de_telefone)
	VALUES 
	(1, 'Daniel Apelido', false, true, 'daniel.apelido@example.com', 1, '1980-12-31', 'M', '923659204');
--
-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;

--
-- Povoamento da tabela "Quotas"
INSERT INTO Quotas
	(id, ano)
	VALUES 
	(1, 2017);
--
-- DELETE FROM Quotas;
-- SELECT * FROM Quotas;


--
-- Povoamento da tabela "Categoria"
INSERT INTO Categoria
	(id, designacao)
	VALUES 
	(1, 'Aula teórica'),
    (2, 'Aula prática');
--
-- DELETE FROM Categoria;
-- SELECT * FROM Categoria;


--
-- Povoamento da tabela "Estado"
INSERT INTO Estado
	(id, designacao)
	VALUES 
	(1, 'Normal'),
    (2, 'Cancelado'),
    (3, 'Adiado');
--
-- DELETE FROM Estado;
-- SELECT * FROM Estado;


--
-- Povoamento da tabela "Servico"
INSERT INTO Servico
	(id, estado, categoria, data_de_inicio, duracao, observacao)
	VALUES 
	(1, 1, 1, '2018-11-14 18:49:00', '00:45:00', 'Ovni avistado');
--
-- DELETE FROM Servico;
-- SELECT * FROM Servico;


--
-- Povoamento da tabela "Servico_cliente"
INSERT INTO Servico_cliente
	(id_cliente, id_servico, pagamento)
	VALUES 
	(1, 1, 20.00);
--
-- DELETE FROM Servico_cliente;
-- SELECT * FROM Servico_cliente;





-- ------------------------------------------------------
-- <fim>
-- Carlos Castro, Daniel Costa, João Rodrigues, Marco Dantas
-- ------------------------------------------------------