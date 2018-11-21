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
	(id	, nome, brevete, formacao_paraquedismo, numero_socio, data_nascimento, genero, numero_de_telefone, data_criacao, rua, codigo_postal)
	VALUES 
	(1	, 'Daniel Apelido'		, false	, true	, 1		, '1980-12-31', 'M', '+351 213 659 204', '2017-05-15 16:00:00', 'Rua Augusta 55, Coimbra, Coimbra', 				'3045-079'),
	(2	, 'Benedita Machado'	, false	, true	, null	, '1964-06-10', 'F', '+351 254 154 860', '2017-05-15 16:00:00', 'Avenida Marquês Tomar 63, Famões, Lisboa', 		'1685-906'),
	(3	, 'Martim Venâncio'		, true	, false	, null	, '1957-02-11', 'M', '+351 215 356 802', '2017-05-15 16:00:00', 'Avenida Júlio São Dias 17, Maia, Porto', 			'4475-810'),
	(4	, 'Constança Ferreira'	, true	, true	, 2		, '1991-06-18', 'F', '+351 222 404 805', '2017-05-15 16:00:00', 'Rua Afonso Albuquerque 51, Conqueiros, Leiria', 	'2425-831'),
	(5	, 'Nuno Martins'		, true	, true	, 3		, '1952-06-11', 'M', '+351 288 203 625', '2017-05-15 16:00:00', 'Rua São Salvador 101, Assento, Braga', 			'4730-360'),
	(6	, 'Carlota  Pires'		, true	, false	, null	, '1989-08-10', 'F', '+351 215 990 674', '2017-05-15 16:00:00', 'Rua Riamar 32, Sanfins, Aveiro', 					'4520-523'),
	(7	, 'Manuel  Neves'		, true	, false	, null	, '1962-03-26', 'M', '+351 209 956 073', '2017-05-15 16:00:00', 'Rua Projectada 58, Setúbal, Setúbal',				'2900-570'),
	(8	, 'Júlia  Magalhães'	, false	, false	, null	, '1954-09-13', 'F', '+351 297 481 565', '2017-05-15 16:00:00', 'Rua São Salvador 36, Igreja, Braga', 				'4730-190'),
	(9	, 'Ivan  Vasconcelos'	, false	, false	, 4		, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601');
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
    (4, 2018);
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
    (1	, 1, '2018-11-14 12:20:00', '1:00',  null),
	(2	, 3, '2018-07-22 15:15:00', '1:00',  null),
	(3	, 2, '2018-09-10 19:00:00', '1:00',  null),
    (4	, 2, '2018-09-10 19:00:00', '1:00',  null),
	(5	, 1, '2018-02-09 11:10:00', '1:00',  null),
	(6	, 2, '2017-06-23 16:50:00', '1:00',  null),
	(7	, 1, '2018-02-19 12:50:00', '1:00',  null),
	(8	, 1, '2018-02-19 12:50:00', '1:00',  null),
	(9	, 1, '2017-07-02 17:45:00', '1:00',  null),
	(10	, 1, '2017-05-08 13:50:00', '1:00',  null),
	(11	, 2, '2017-01-08 16:15:00', '1:00',  null),
	(14	, 1, '2018-07-12 16:30:00', '1:00',  null),
	(15	, 1, '2017-04-30 14:30:00', '1:00',  null),
	(16	, 1, '2018-11-19 14:20:00', '1:00',  null),
	(17	, 1, '2018-10-24 14:30:00', '1:00',  null),
	(19	, 3, '2018-01-17 13:25:00', '1:00',  null),
	(20	, 1, '2018-08-12 14:00:00', '1:00',  null),
	(22	, 2, '2018-04-09 16:45:00', '1:00',  null),
	(23	, 3, '2017-04-22 12:00:00', '1:00',  null),
	(24	, 3, '2018-08-18 17:30:00', '1:00',  null),
	(25	, 1, '2018-04-08 21:53:38', '1:00',  null),
	(26	, 1, '2018-08-08 10:00:00', '1:00',  null),
	(27	, 1, '2018-03-16 19:30:00', '1:00',  null),
	(28	, 1, '2017-08-29 08:55:00', '1:00',  null),
	(29	, 2, '2018-12-06 13:55:00', '1:00',  null),
	(30	, 3, '2017-10-12 10:10:00', '1:00', 'Os flags tiveram anomalias durante a aterragem');
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
INSERT INTO Cliente_servico
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
	(marcas_da_aeronave, proprietario, modelo, numero_max_passageiros, disponivel, data_proxima_revisao, icao_atual, lugar_local, tipo)
	VALUES 
	('CS-AVC', 'Aerodromo da feira'	, 'Fantasy Air Allegro 2000' 		, 2	, true	, '2020-10-30', 'LPVF', 1	, 1),
    ('CS-IPZ', 'Aerodromo da feira'	, 'Cessna Citation CJ2'		 		, 8	, false	, '2019-06-12', 'LPVF', 2	, 1),
	('CS-MRQ', 'Aerodromo da feira'	, 'Piper PA-28-140 Cherokee 160 hp'	, 2	, true	, '2019-08-02', 'LPVF', 3	, 1),
	('CS-JMQ', 'Aerodromo da feira'	, 'Piper PA-28R-200 Arrow II'		, 2	, true	, '2019-02-06', 'KTOO', null, 1),
	('CS-SBP', 'Eire'			   	, 'Beechcraft Baron G58'			, 4	, true	, '2019-01-07', 'LPVF', 4	, 1),
	('CS-DEW', 'Ailane'			   	, 'Pilatus PC-12 NG'				, 6	, true	, '2019-08-24', 'GLIP', null, 1);

-- DELETE FROM Aviao;
-- SELECT * FROM Aviao;


--
INSERT INTO Ciclo
	(id_servico, marcas_da_aeronave, icao_origem, icao_destino, hora_partida, hora_chegada, hora_partida_prevista, duracao_prevista)
	VALUES 
	(1, 'CS-AVC', 'LPVF', 'LPVF', '18:12:00', '19:15:00', '18:10:00', '01:00:00');
    -- (5, 'CS-AVC', 'LPVF', 'LPVF', '18:12:00', '19:15:00', '18:10:00', '01:00:00');
--
-- DELETE FROM Ciclo;
-- SELECT * FROM Ciclo;


--
INSERT INTO Manutencao
	(id, despesas, marcas_da_aeronave, fatura)
	VALUES 
    (1, null	, 'CS-AVC', null),
    (2, 150.00	, 'CS-MRQ', 55555784),
    (3, null	, 'CS-JMQ', null),
    (4, null	, 'CS-MRQ', null),
    (5, 300.00	, 'CS-AVC', 87418921),
    (6, null	, 'CS-JMQ', null),
    (7, 100.00	, 'CS-AVC', 48512417),
    (8, null	, 'CS-JMQ', null);
--
-- DELETE FROM Manutencao;
-- SELECT * FROM Manutencao;


INSERT INTO Funcionario
	(numero, nome, data_de_nascimento, genero, data_criacao, empregado, salario)
	VALUES 
	(1	, 'José Aerodromo'		, '1969-05-24', 'M', '2017-5-10 10:00:00', true	, 9676.67),
	(2	, 'Sílvia Despedida'	, '1981-01-14', 'F', '2017-5-10 10:00:00', false, 676.67),
	(3	, 'Maria Rececionista'	, '1972-10-02', 'F', '2017-5-10 10:00:00', true	, 676.67),
	(4	, 'Joaquim Controlador'	, '1977-05-15', 'M', '2017-5-10 10:00:00', true	, 676.67),
	(5	, 'Matilde Auxiliar'	, '1994-03-13', 'F', '2017-5-10 10:00:00', true	, 676.67),
	(6	, 'Selestina Piloto In'	, '1952-08-07', 'F', '2017-5-10 10:00:00', true	, 676.67),
    (7	, 'Eduarda Revisor In'	, '1979-04-02', 'M', '2017-5-10 10:00:00', true	, 676.67),
    (8	, 'Luís Faztudo'		, '1979-10-01', 'M', '2017-5-10 10:00:00', true	, 676.67),
    (9	, 'Catarina Castro'		, '1977-03-06', 'F', '2017-5-10 10:00:00', true , 676.67),
    (10	, 'Luís Viterbo'		, '1982-06-29', 'M', '2017-5-10 10:00:00', true , 676.67);
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
	(1	, 1),
	(2	, 2),
    (3	, 2),
    (4	, 3),
    (5	, 4),
    (6	, 5),
    (6	, 6),
    (7	, 6),
    (7	, 7),
    (8	, 5),
    (8	, 6),
    (8	, 7),
    (9	, 2),
    (10	, 3);
--
-- DELETE FROM Numero_funcao;
-- SELECT * FROM Numero_funcao;


INSERT INTO Horario
	(id, data_inicio, data_fim, hora_inicio, hora_fim)
	VALUES 
    (1, '2018-09-01', '2019-07-30', '06:00:00', '14:00:00'),
    (2, '2018-09-01', '2019-07-30', '14:00:00', '22:00:00'),
    (3, '2018-09-01', '2019-07-30', '09:30:00', '16:00:00'),
    (4, '2018-09-01', '2019-07-30', '15:00:00', '23:00:00'),
    (5, '2018-09-01', '2019-07-30', '15:00:00', '09:00:00');
--
-- DELETE FROM Horario;
-- SELECT * FROM Horario;


INSERT INTO Dias_da_semana
	(id, dia)
	VALUES 
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (2, 6),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4),
    (3, 5),
    (3, 6),
    (4, 2),
    (4, 3),
    (4, 4),
    (4, 5),
    (4, 6),
    (5, 2),
    (5, 3),
    (5, 4),
    (5, 5),
    (5, 6);
--
-- DELETE FROM Dias_da_semana;
-- SELECT * FROM Dias_da_semana;


INSERT INTO Horario_funcionario
	(id_funcionario, id_horario)
	VALUES 
    (1, 3),
    (3, 1),
    (4, 1),
    (5, 4),	
    (6, 2),
    (7, 3),
    (8, 4),
    (9, 2),
    (10,2);
--
-- DELETE FROM Horario_funcionario;
-- SELECT * FROM Horario_funcionario;


-- ------------------------------------------------------
-- <fim>
-- Carlos Castro, Daniel Costa, João Rodrigues, Marco Dantas
-- ------------------------------------------------------