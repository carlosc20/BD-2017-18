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
INSERT INTO Cliente
	(id, nome, brevete, formacao_paraquedismo, email, numero_socio, data_nascimento, genero, numero_de_telefone, data_criacao)
	VALUES 
	(1, 'Daniel Apelido', false, true, 'daniel.apelido@example.com', 1, '1980-12-31', 'M', '923659204', '2017-05-15 16:00:00');
--
-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;

--
INSERT INTO Quotas
	(id, ano)
	VALUES 
	(1, 2017),
    (1, 2018);
--
-- DELETE FROM Quotas;
-- SELECT * FROM Quotas;


--
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
    (2, 1, '2018-11-15 10:00:00', '02:00:00', null);
--
-- DELETE FROM Servico;
-- SELECT * FROM Servico;


--
INSERT INTO Tipo_externo
	(id, designacao)
	VALUES 
    (1, 'aula de ultra-leve');
--
-- DELETE FROM Tipo_externo;
-- SELECT * FROM Tipo_externo;


--
INSERT INTO Servico_externo
	(id, tipo, montante_total, limite_clientes)
	VALUES 
    (1, 1, 50.00, 1);
--
-- DELETE FROM Horario_funcionario;
-- SELECT * FROM Horario_funcionario;



INSERT INTO Servico_cliente
	(id_cliente, id_servico, pagamento)
	VALUES 
	(1, 1, 50.00);
--
-- DELETE FROM Servico_cliente;
-- SELECT * FROM Servico_cliente;


--
INSERT INTO Aviao
	(marcas_da_aeronave, proprietario, modelo, numero_max_passageiros, classificacao, disponivel, data_proxima_revisao, icao_atual)
	VALUES 
	('CS-AVC', 'aerodromo_da_feira', 'fantasy air allegro 2000', 2, 'ultra-leve', true, '2020-10-30', 'LPVF');
--
-- DELETE FROM Aviao;
-- SELECT * FROM Aviao;


--
INSERT INTO Lugar_local
	(marcas_da_aeronave, designacao)
	VALUES 
	('CS-AVC', 'Hangar A');
--
-- DELETE FROM Lugar_local;
-- SELECT * FROM Lugar_local;


--
INSERT INTO Ciclo
	(id_servico, marcas_da_aeronave, icao_origem, icao_destino, hora_partida, hora_chegada, hora_partida_prevista, duracao_prevista)
	VALUES 
	(1, 'CS-AVC', 'LPVF', 'LPVF', '18:12:00', '19:15:00', '18:10:00', '01:00:00');
--
-- DELETE FROM Ciclo;
-- SELECT * FROM Ciclo;


--
INSERT INTO Tipo_interno
	(id, designacao)
	VALUES 
    (1, 'revisão de rotina');
--
-- DELETE FROM Tipo_interno;
-- SELECT * FROM Tipo_interno;


--
INSERT INTO Servico_interno
	(id, tipo, despesas, marcas_da_aeronave)
	VALUES 
    (2, 1, 300.00, 'CS-AVC');
--
-- DELETE FROM Servico_interno;
-- SELECT * FROM Servico_interno;


--
INSERT INTO Funcionario
	(numero, nome, data_de_nascimento, genero, data_criacao)
	VALUES 
	(1, 'José Aerodromo', '1969-5-24', 'M', '2017-5-10 10:00:00');
--
-- DELETE FROM Funcionario;
-- SELECT * FROM Funcionario;


--
INSERT INTO Funcao
	(id, designacao)
	VALUES 
	(1, 'Piloto'),
    (2, 'Instrutor'),
    (3, 'Rececionista'),
    (4, 'Administrador'),
    (5, 'Revisor');
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


--
INSERT INTO Funcao_funcionario
	(numero, funcao)
	VALUES 
	(1, 1),
	(1, 2),
    (1, 5);
--
-- DELETE FROM Numero_funcao;
-- SELECT * FROM Numero_funcao;

--
INSERT INTO Horario
	(id, data_inicio, data_fim, hora_inicio, hora_fim)
	VALUES 
    (1, '2018-1-10', '2019-1-10', '09:30:00', '19:20:00');
--
-- DELETE FROM Horario;
-- SELECT * FROM Horario;

--
INSERT INTO Dias_da_semana
	(id, dia)
	VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5);
--
-- DELETE FROM Dias_da_semana;
-- SELECT * FROM Dias_da_semana;


--
INSERT INTO Horario_funcionario
	(id_horario, id_funcionario)
	VALUES 
    (1, 1);
--
-- DELETE FROM Horario_funcionario;
-- SELECT * FROM Horario_funcionario;


-- ------------------------------------------------------
-- <fim>
-- Carlos Castro, Daniel Costa, João Rodrigues, Marco Dantas
-- ------------------------------------------------------