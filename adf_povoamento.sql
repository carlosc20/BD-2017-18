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

-- Esquema: "mydb"
USE `mydb` ;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


INSERT INTO Cliente
	(id, nome, brevete, formacao_paraquedismo, email, numero_socio, data_nascimento, genero, numero_de_telefone, data_criacao)
	VALUES 
	(1	, 'Daniel Apelido'		, false	, true	, 'daniel.apelido@example.com'	, 1		, '1980-12-31', 'M', '+351 923 659 204', '2017-05-15 16:00:00'),
	(2	, 'Ange Kops'			, false	, true	, 'akops1@jimdo.com'			, 2		, '1968-01-13', 'F', '+351 272 907 390', '2017-05-15 16:00:00'),
	(3	, 'Leigha Truckell'		, false	, true	, 'ltruckell2@pen.io'			, null	, '1964-06-10', 'F', '+351 254 154 860', '2017-05-15 16:00:00'),
	(4	, 'Jaye Inwood'			, true	, false	, 'jinwood3@parallels.com'		, null	, '1957-02-11', 'M', '+351 215 356 802', '2017-05-15 16:00:00'),
	(5	, 'Brockie Gaynes'		, true	, true	, 'bgaynes4@liveinternet.ru'	, 3		, '1991-06-18', 'M', '+351 222 404 805', '2017-05-15 16:00:00'),
	(6	, 'Gram Dreus'			, true	, true	, 'gdreus5@nytimes.com'			, 4		, '1952-06-11', 'M', '+351 288 203 625', '2017-05-15 16:00:00'),
	(7	, 'Selestina Fisbburne'	, true	, false	, 'sfisbburne6@sogou.com'		, null	, '1989-08-10', 'F', '+351 215 990 674', '2017-05-15 16:00:00'),
	(8	, 'Gilligan Jacox'		, true	, false	, 'gjacox7@vimeo.com'			, null	, '1962-03-26', 'F', '+351 209 956 073', '2017-05-15 16:00:00'),
	(9	, 'Vanya Dew'			, false	, false	, 'vdew8@whitehouse.gov'		, null	, '1954-09-13', 'F', '+351 297 481 565', '2017-05-15 16:00:00'),
	(10	, 'Roda Danilchenko'	, false	, false	, 'rdanilchenko9@cbc.ca'		, 5		, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00');
--
-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;


INSERT INTO Quotas
	(id, ano)
	VALUES 
	(1, 2016),
    (1, 2017),
    (2, 2016),
    (2, 2018),
    (3, 2016),
    (3, 2017),
    (3, 2018),
    (4, 2016),
    (4, 2017),
    (4, 2018),
    (5, 2018);
--
-- DELETE FROM Quotas;
-- SELECT * FROM Quotas;


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
INSERT INTO Servico
	(id, estado, data_de_inicio, duracao, observacao)
	VALUES 
	(1, 1, '2018-11-14 18:00:00', '01:30:00', 'Ovni avistado'),
    (2, 1, '2018-11-15 10:00:00', '02:00:00', null),
    (1, 1, '2018-11-14 02:20:41', '0:43', null),
	(2, 3, '2018-07-22 15:16:31', '2:25', null),
	(3, 2, '2018-09-10 18:59:29', '5:52', null),
	(5, 1, '2018-02-09 11:10:52', '13:25', null),
	(6, 2, '2017-06-23 16:50:44', '8:06', null),
	(7, 1, '2018-02-19 12:50:44', '4:34', null),
	(9, 1, '2017-07-02 17:41:54', '1:09', null),
	(10, 1, '2017-05-08 03:52:11', '22:54', null),
	(11, 2, '2017-01-08 06:13:58', '4:09', null),
	(14, 1, '2018-07-12 06:26:03', '8:51', null),
	(15, 1, '2017-04-30 04:29:28', '4:22', null),
	(16, 1, '2018-11-19 04:18:28', '17:24', null),
	(17, 1, '2018-10-24 04:24:54', '9:29', null),
	(19, 3, '2018-01-17 23:25:11', '10:32', null),
	(20, 1, '2018-08-12 03:59:45', '23:54', null),
	(22, 2, '2018-04-09 06:48:14', '16:27', null),
	(23, 3, '2017-04-22 01:56:56', '14:18', null),
	(24, 3, '2018-08-18 17:32:18', '3:46', null),
	(25, 1, '2018-04-08 22:53:38', '5:53', null),
	(26, 1, '2018-08-08 10:07:41', '11:48', null),
	(27, 1, '2018-03-16 19:26:17', '5:16', null),
	(28, 1, '2017-08-29 08:54:33', '8:40', null),
	(29, 2, '2018-12-06 13:56:25', '1:05', null),
	(30, 3, '2017-10-12 00:11:52', '10:42', '');
--
-- DELETE FROM Servico;
-- SELECT * FROM Servico;


INSERT INTO Tipo
	(id, designacao)
	VALUES 
    (1, 'Paraquedismo'),
    (2, 'Voo panorâmico'),
    (3, 'Voo privado'),
    (4, 'Voo comercial'),
    (5, 'Aulas de paraquedismo'),
    (6, 'Aulas de pilotagem');
--
-- DELETE FROM Tipo_externo;
-- SELECT * FROM Tipo_externo;


--
INSERT INTO Servico_ao_cliente
	(id, tipo, montante_total, limite_clientes)
	VALUES 
    (1, 1, 50.00, 1);
--
-- DELETE FROM Servico_externo;
-- SELECT * FROM Servico_externo;


--
INSERT INTO Servico_cliente
	(id_cliente, id_servico, pagamento)
	VALUES 
	(1, 1, 50.00);
--
-- DELETE FROM Servico_cliente;
-- SELECT * FROM Servico_cliente;


INSERT INTO Lugar_local
	(id, designacao)
	VALUES 
	(1, 'Hangar A'),
    (2, 'Hangar B'),
    (3, 'Hangar C'),
    (4, 'Hangar D'),
    (5, 'Hangar E');
--
-- DELETE FROM Lugar_local;
-- SELECT * FROM Lugar_local;


--
INSERT INTO Aviao
	(marcas_da_aeronave, proprietario, modelo, numero_max_passageiros, classificacao, disponivel, data_proxima_revisao, icao_atual, lugar_local)
	VALUES 
	('CS-AVC', 'Aerodromo da feira'	, 'fantasy air allegro 2000', 2		, 'ultra-leve'			, true	, '2020-10-30', 'LPVF', 1),
    ('CS-IPZ', 'Aerodromo da feira'	, 'aviao estragado'		 	, 14	, 'donec pharetra'		, false	, '2019-06-12', 'LPVF', 2),
	('CS-MRQ', 'Aerodromo da feira'	, 'velit id'				, 17	, 'cursus vestibulum'	, true	, '2019-08-02', 'LPVF', 3),
	('CS-JMQ', 'Aerodromo da feira'	, 'eu sapien cursus'		, 11	, 'pharetra magna'		, true	, '2019-02-06', 'KTOO', null),
	('CS-SBP', 'Eire'			   	, 'orci eget'				, 4		, 'at feugiat'			, true	, '2019-01-07', 'LPVF', 4),
	('CS-DEW', 'Ailane'			   	, 'potenti nullam'			, 15	, 'cras'				, true	, '2019-08-24', 'GLIP', null);
--	
-- DELETE FROM Aviao;
-- SELECT * FROM Aviao;


--
INSERT INTO Ciclo
	(id_servico, marcas_da_aeronave, icao_origem, icao_destino, hora_partida, hora_chegada, hora_partida_prevista, duracao_prevista)
	VALUES 
	(1, 'CS-AVC', 'LPVF', 'LPVF', '18:12:00', '19:15:00', '18:10:00', '01:00:00');
--
-- DELETE FROM Ciclo;
-- SELECT * FROM Ciclo;


--
INSERT INTO Manutencao
	(id, despesas, marcas_da_aeronave)
	VALUES 
    (1, null	, 'CS-AVC'),
    (1, 150.00	, 'CS-MRQ'),
    (1, null	, 'CS-JMQ'),
    (1, null	, 'CS-MRQ'),
    (1, 300.00	, 'CS-AVC'),
    (1, null	, 'CS-JMQ'),
    (1, 100.00	, 'CS-AVC'),
    (1, null	, 'CS-JMQ');
--
-- DELETE FROM Manutencao;
-- SELECT * FROM Manutencao;


INSERT INTO Funcionario
	(numero, nome, data_de_nascimento, genero, data_criacao, empregado)
	VALUES 
	(1, 'José Aerodromo'		, '1969-05-24', 'M', '2017-5-10 10:00:00', true),
	(2, 'Sílvia Despedida'		, '1981-01-14', 'F', '2017-5-10 10:00:00', false),
	(3, 'Maria Rececionista'	, '1972-10-02', 'F', '2017-5-10 10:00:00', true),
	(4, 'Joaquim Controlador'	, '1977-05-15', 'M', '2017-5-10 10:00:00', true),
	(5, 'Matilde Auxiliar'		, '1994-03-13', 'F', '2017-5-10 10:00:00', true),
	(6, 'Selestina Piloto'		, '1952-08-07', 'F', '2017-5-10 10:00:00', true),
    (7, 'Eduarda Revisor'		, '1952-08-07', 'M', '2017-5-10 10:00:00', true),
    (8, 'Luís Faztudo'			, '1952-08-07', 'M', '2017-5-10 10:00:00', true);
--
-- DELETE FROM Funcionario;
-- SELECT * FROM Funcionario;


INSERT INTO Funcao
	(id, designacao)
	VALUES 
    (1, 'Administrador'),
    (2, 'Rececionista'),
    (3, 'Controlador'),
    (4, 'Auxiliar'),
	(5, 'Piloto'),
    (6, 'Instrutor'),
    (7, 'Revisor');
--
-- DELETE FROM Funcao;
-- SELECT * FROM Funcao;


--
INSERT INTO Servico_funcionario
	(id_servico, funcao, id_funcionario)
	VALUES 
	(1, 2, 1),
    (2, 5, 1);
--
-- DELETE FROM Servico_funcionario;
-- SELECT * FROM Servico_funcionario;


INSERT INTO Funcao_funcionario
	(numero, funcao)
	VALUES 
	(1, 1),
	(2, 2),
    (3, 2),
    (4, 3),
    (5, 4),
    (6, 5),
    (6, 6),
    (7, 6),
    (7, 7),
    (8, 5),
    (8, 6),
    (8, 7);
--
-- DELETE FROM Numero_funcao;
-- SELECT * FROM Numero_funcao;


INSERT INTO Horario
	(id, data_inicio, data_fim, hora_inicio, hora_fim)
	VALUES 
    (1, '2018-01-10', '2018-06-25', '09:30:00', '19:20:00'),
    (2, '2018-07-20', '2018-12-01', '09:30:00', '19:20:00'),
    (3, '2018-01-10', '2018-06-25', '06:00:00', '09:00:00');
--
-- DELETE FROM Horario;
-- SELECT * FROM Horario;


INSERT INTO Dias_da_semana
	(id, dia)
	VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4),
    (3, 5);
--
-- DELETE FROM Dias_da_semana;
-- SELECT * FROM Dias_da_semana;


INSERT INTO Horario_funcionario
	(id_funcionario, id_horario)
	VALUES 
    (1, 1),
    (1, 2),
    (3, 1),
    (3, 2),
    (4, 1),
    (4, 2),
    (5, 1),
    (5, 2),
    (6, 3),
    (7, 3),
    (8, 3);
--
-- DELETE FROM Horario_funcionario;
-- SELECT * FROM Horario_funcionario;


-- ------------------------------------------------------
-- <fim>
-- Carlos Castro, Daniel Costa, João Rodrigues, Marco Dantas
-- ------------------------------------------------------