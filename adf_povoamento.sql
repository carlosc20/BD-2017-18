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
	(id	, nome, brevete, formacao_paraquedismo, data_nascimento, genero, numero_de_telefone, data_criacao, rua, codigo_postal)
	VALUES 
	(1	, 'Daniel Apelido'		, false	, true	, '1980-12-31', 'M', '+351 213 659 204', '2017-05-15 16:00:00', 'Rua Augusta 55, Coimbra, Coimbra', 				'3045-079'),
	(2	, 'Benedita Machado'	, false	, false	, '1964-06-10', 'F', '+351 254 154 860', '2017-05-15 16:00:00', 'Avenida Marquês Tomar 63, Famões, Lisboa', 		'1685-906'),
	(3	, 'Martim Venâncio'		, false	, false	, '1957-02-11', 'M', '+351 215 356 802', '2017-05-15 16:00:00', 'Avenida Júlio São Dias 17, Maia, Porto', 			'4475-810'),
	(4	, 'Constança Ferreira'	, false	, false	, '1991-06-18', 'F', '+351 222 404 805', '2017-05-15 16:00:00', 'Rua Afonso Albuquerque 51, Conqueiros, Leiria', 	'2425-831'),
	(5	, 'Nuno Martins'		, false	, false	, '1952-06-11', 'M', '+351 288 203 625', '2017-05-15 16:00:00', 'Rua São Salvador 101, Assento, Braga', 			'4730-360'),
	(6	, 'Carlota  Pires'		, false	, false	, '1989-08-10', 'F', '+351 215 990 674', '2017-05-15 16:00:00', 'Rua Riamar 32, Sanfins, Aveiro', 					'4520-523'),
	(7	, 'Manuel  Neves'		, false	, false	, '1962-03-26', 'M', '+351 209 956 073', '2017-05-15 16:00:00', 'Rua Projectada 58, Setúbal, Setúbal',				'2900-570'),
	(8	, 'Júlia  Magalhães'	, false	, false	, '1954-09-13', 'F', '+351 297 481 565', '2017-05-15 16:00:00', 'Rua São Salvador 36, Igreja, Braga', 				'4730-190'),
	(9	, 'Ivan  Vasconcelos'	, false	, false	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(10	, 'João  Vasconcelos'	, false	, false	, '1983-01-13', 'M', '+351 240 522 339', '2017-05-15 16:00:00', 'Rua Caldeirão 16, Pedra da Adega, Leiria', 		'3240-601'),
    (11	, 'Mario Gotze'			, false	, false	, '1993-01-20', 'M', '+355 570 542 200', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
    (12	, 'Joana BomBom'		, false	, false	, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
    (13	, 'Mario Madeira'		, false , true	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
    (14	, 'Marco Dantas'		, false	, false	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(15	, 'Gabriel Souto'		, true	, true	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(16	, 'Henrique Marques'	, false	, false	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
    (17	, 'Mafalda Jornalista'	, false	, true	, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(18	, 'Marta Soares'		, true	, true	, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(19	, 'Pedro Bernardo'		, true	, false	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(20	, 'Joana Pina'			, false	, false	, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(21	, 'Sara Correia'		, false	, true	, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(22	, 'Ricardo Pão'			, false	, false	, '1981-09-11', 'M', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601'),
	(23	, 'Mafalda Silva'		, true	, false	, '1981-09-11', 'F', '+351 270 512 329', '2017-05-15 16:00:00', 'Rua Caldeirão 14, Pedra da Adega, Leiria', 		'3240-601');
--
-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;
INSERT INTO Socio
	(id_cliente)
    VALUES
    (1),
    (2),
    (3),
    (4),
    (10),
    (12),
    (13),
    (15),
    (20);
    

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
    (5, 2018),
    (6, 2017), -- não pagou uma
    (7, 2017),
    (7, 2018),
    (8, 2018),
    (9, 2016),
    (9, 2017),
    (9, 2018);
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
    (1	, 3, '2018-11-20 08:00:00', '2:00',  null),					-- aula pratica 12
	(2	, 1, '2018-11-20 09:30:00', '4:00',  null), 				-- man 7
	(3	, 3, '2018-11-20 10:00:00', '2:00',  null), 				-- aula pratica 12
    (4	, 1, '2018-11-20 15:00:00', '4:00',  'Derrame de óleo'), 	-- man 14
	(5	, 1, '2018-11-20 22:10:00', '1:00',  null), 				-- man 14
	(6	, 1, '2018-11-20 14:00:00', '2:00',  null),   				-- voo panoramico 6
	(7	, 1, '2018-11-20 16:00:00', '2:00',  null),					-- voo panoramico 6
	(8	, 1, '2018-11-20 18:00:00', '2:00',  null),					-- paraquedismo 6
	(9	, 2, '2018-11-20 20:00:00', '2:00',  null),					-- paraquedismo 6  cancelado
	(10	, 1, '2018-11-20 14:00:00', '2:00',  null), 				-- man 7
	(11	, 3, '2018-11-20 12:00:00', '2:00',  null),					-- aula pratica 12
    (12	, 1, '2018-11-20 16:15:00', '1:00',  'Coisas mecanicas'), 	-- man 7
    (13	, 2, '2018-11-20 14:00:00', '2:00',  null),					-- aula teorica 13
	(14	, 1, '2018-11-20 16:00:00', '2:00',  null),					-- aula teorica 13
	(15	, 1, '2018-11-20 18:00:00', '2:00',  null),					-- aula teorica 13
	(16	, 1, '2018-11-20 20:00:00', '2:00',  null),					-- aula teorica 13
	(17	, 1, '2018-11-20 15:00:00', '2:00',  null),					-- aula paraquedismo 8
	(19	, 3, '2018-11-20 17:00:00', '2:00',  null),					-- aula paraquedismo 8
	(20	, 1, '2018-11-20 22:00:00', '1:00',  'Coisas mecanicas'), 	-- man 8
	(22	, 1, '2018-11-20 19:00:00', '2:00',  null),					-- aula paraquedismo 8
    (23	, 1, '2018-11-20 20:00:00', '2:00',  null);					-- voo privado 6
--
-- DELETE FROM Servico;
-- SELECT * FROM Servico;


INSERT INTO Tipo
	(id, designacao, preco, desconto)
	VALUES 
    (1, 'Paraquedismo', 115.00, 0.10),
    (2, 'Voo panorâmico', 60.00, 0.05),
    (3, 'Voo privado', 200.00, 0.20),
    (4, 'Aula de paraquedismo', 10.00, 0.05), 
    (5, 'Aula de pilotagem teórica', 20.00, 0.10),
    (6, 'Aula de pilotagem prática', 45.00, 0.10);
--
-- DELETE FROM Tipo;
-- SELECT * FROM Tipo;


--
INSERT INTO Servico_ao_cliente
	(id, tipo, limite_clientes)
	VALUES 
    (1	, 5, 1),					
	(3	, 5, 1), 					
	(6	, 2, 4),   					
	(7	, 2, 4),					
	(8	, 1, 4),					
	(9	, 1, 4),					
	(11	, 6, 1),					
    (13	, 5, 10),					
	(14	, 5, 10),					
	(15	, 5, 10),				
	(16	, 5, 10),				
	(17	, 4, 5),					
	(19	, 4, 5),					
	(22	, 4, 5),					
    (23	, 3, 1);	
--
-- DELETE FROM Servico_externo;
-- SELECT * FROM Servico_externo;


-- presenca default é false
INSERT INTO Cliente_servico
	(id_cliente, id_servico, pagamento)
	VALUES 
    (1	,1	, 37.50),					
	(2	,3	, 37.50), 					
	(3	,6	, 57.00), 
    (4	,6	, 57.00), 
    (5	,6	, 60.00), 
    (6	,6	, 60.00), 
	(7	,7	, 60.00),
    (8	,7	, 60.00),
    (9	,7	, 60.00),
    (10	,7	, 57.00),
	(1	,8	, 103.50),
    (13	,8	, 103.50),
    (15	,8	, 115.00),
    (17	,8	, 115.00),
	(3	,11	, 37.50),									
	(11	,14	, 20.00),
    (12	,14	, 20.00),
    (13	,14	, 18.00),
	(1	,15	, 18.00),
    (2	,15	, 18.00),
    (3	,15	, 18.00),
    (4	,15	, 18.00),
    (5	,15	, 20.00),
	(6	,16	, 20.00),
    (7	,16	, 20.00),
    (8	,16	, 20.00),
    (9	,16	, 20.00),
	(2	,17	, 09.50),
    (3	,17	, 09.50),
    (4	,17	, 09.50),
    (5	,17	, 10.00),
    (6	,17	, 10.00),
	(7	,19	, 10.00),
    (8	,19	, 10.00),
    (9	,19	, 10.00),
    (10	,19	, 09.50),
	(11	,22	, 10.00),	
    (12	,22	, 10.00),
    (22	,22	, 10.00),
    (15	,23	, 160.00);					
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


INSERT INTO Aviao
	(marcas_da_aeronave, proprietario, modelo, numero_max_passageiros, disponivel, data_proxima_revisao, lugar_local, tipo)
	VALUES 
	('CS-AVC', 'Aerodromo da feira'	, 'Fantasy Air Allegro 2000' 		, 2	, true	, '2020-10-30', 1	, 3), 
    ('CS-IPZ', 'Aerodromo da feira'	, 'Cessna Citation CJ2'		 		, 2, false	, '2019-06-12', 2	, 6), 
	('CS-MRQ', 'Aerodromo da feira'	, 'Piper PA-28-140 Cherokee 160 hp'	, 4	, true	, '2019-08-02', 3	, 1),
    ('CS-XYW', 'Aerodromo da feira'	, 'Cessna Citation PO2'		 		, 2 , true	, '2019-06-12', 2	, 5),
	('CS-MDQ', 'Aerodromo da feira'	, 'Piper PA-28R-200 Arrow III'		, 4	, true	, '2019-02-06', 4	, 2),
	('CS-SBP', 'Eire'			   	, 'Beechcraft Baron G58'			, 10, true	, '2019-01-07', 4	, 1);
-- DELETE FROM Aviao;
-- SELECT * FROM Aviao;


--
INSERT INTO Ciclo
	(id_servico, marcas_da_aeronave, hora_partida, hora_chegada, hora_partida_prevista, duracao_prevista)
	VALUES 
	(1	, 'CS-IPZ', '2018-11-20 08:11:00', '2018-11-20 09:40:00', '2018-11-20 08:10:00', '2018-11-20 1:30'),					
	(3	, 'CS-IPZ', '2018-11-20 10:11:00', '2018-11-20 11:38:00', '2018-11-20 10:10:00', '2018-11-20 1:30'), 				
	(6	, 'CS-MDQ', '2018-11-20 14:10:00', '2018-11-20 15:40:00', '2018-11-20 14:10:00', '2018-11-20 1:30'),   				
	(7	, 'CS-MDQ', '2018-11-20 16:11:00', '2018-11-20 17:40:00', '2018-11-20 16:10:00', '2018-11-20 1:30'),					
	(8	, 'CS-MRQ', '2018-11-20 18:15:00', '2018-11-20 09:47:00', '2018-11-20 18:10:00', '2018-11-20 1:30'),				
	(11	, 'CS-IPZ', '2018-11-20 12:10:00', '2018-11-20 13:36:00', '2018-11-20 12:10:00', '2018-11-20 1:30'),					
    (23	, 'CS-AVC', '2018-11-20 20:10:00', '2018-11-20 21:42:00', '2018-11-20 20:10:00', '2018-11-20 1:30');					
--
-- DELETE FROM Ciclo;
-- SELECT * FROM Ciclo;


--
INSERT INTO Manutencao
	(id, despesas, marcas_da_aeronave, fatura)
	VALUES 
    (2	, null	, 'CS-AVC', null),
    (4	, 150.00, 'CS-MRQ', 55555784),
    (5	, null	, 'CS-MDQ', null),
    (10	, null	, 'CS-MRQ', null),
    (12	, 300.00, 'CS-AVC', 87418921),
    (13	, null	, 'CS-MDQ', null),
    (20	, 20.00	, 'CS-AVC', 87712345);
--
-- DELETE FROM Manutencao;
-- SELECT * FROM Manutencao;


INSERT INTO Funcionario
	(numero, nome, data_de_nascimento, genero, data_criacao, empregado, salario)
	VALUES 
	(1	, 'José Aerodromo'		, '1969-05-24', 'M', '2017-5-10 10:00:00', true	, 9676.67),-- admin
	(2	, 'Sílvia Despedida'	, '1981-01-14', 'F', '2017-5-10 10:00:00', false, 676.67), -- rece
	(3	, 'Maria Rececionista'	, '1972-10-02', 'F', '2017-5-10 10:00:00', true	, 676.67), -- rece
	(4	, 'Joaquim Controlador'	, '1977-05-15', 'M', '2017-5-10 10:00:00', true	, 676.67), -- contro
	(5	, 'Matilde Auxiliar'	, '1994-03-13', 'F', '2017-5-10 10:00:00', true	, 676.67), -- aux
	(6	, 'Selestina Piloto In'	, '1952-08-07', 'F', '2017-5-10 10:00:00', true	, 676.67), -- piloto
    (7	, 'Eduarda Revisor In'	, '1979-04-02', 'M', '2017-5-10 10:00:00', true	, 676.67), -- inst. revisor
    (8	, 'Luís Faztudo'		, '1979-10-01', 'M', '2017-5-10 10:00:00', true	, 676.67), -- pilot, inst, revisor
    (9	, 'Catarina Castro'		, '1977-03-06', 'F', '2017-5-10 10:00:00', true , 676.67), -- rece
    (10	, 'Luís Viterbo'		, '1982-06-29', 'M', '2017-5-10 10:00:00', true , 676.67), -- controlador
	(11	, 'Luisa Maria'			, '1992-07-22', 'F', '2017-5-10 10:00:00', true , 676.67), -- inst
    (12	, 'Luís Viterbo'		, '1982-06-29', 'M', '2017-5-10 10:00:00', true , 676.67), -- piloto, inst
	(13	, 'Luisa Maria'			, '1992-07-22', 'F', '2017-5-10 10:00:00', true , 676.67), -- piloto, inst
    (14	, 'Luisa Maria'			, '1992-07-22', 'F', '2017-5-10 10:00:00', false, 676.67); -- revisor
    
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
	(1	, 6, 12),
	(2	, 7, 7),
	(3	, 6, 12),
    (4	, 7, 14),
	(5	, 7, 14),
	(6	, 5, 6),
	(7	, 5, 6),
	(8	, 5, 6),
	(9	, 5, 6),
	(10	, 7, 7),
	(11	, 6, 12),
    (12	, 7, 7),
    (13	, 6, 13),
	(14	, 6, 13),
	(15	, 6, 13),
	(16	, 6, 13),
	(17	, 6, 9),
	(19	, 6, 9),
	(20	, 7, 9), 
	(22	, 6, 8),
    (23	, 5, 6);
    
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
    (10	, 3),
    (11	, 6),
    (12	, 5),
    (12	, 6),
    (13	, 5),
    (13	, 6),
    (14	, 7);
--
-- DELETE FROM Funcao_funcionario;
-- SELECT * FROM Funcao_funcionario;


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
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 4),	
    (6, 2),
    (7, 3),
    (8, 4),
    (9, 2),
    (10,2),
    (11,2),
    (12,1),
    (13,2),
    (14,4);
--
-- DELETE FROM Horario_funcionario;
-- SELECT * FROM Horario_funcionario;


-- ------------------------------------------------------
-- <fim>
-- Carlos Castro, Daniel Costa, João Rodrigues, Marco Dantas
-- ------------------------------------------------------