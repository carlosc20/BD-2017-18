
USE `mydb` ;

-- quantos servicos cada cliente fez de cada tipo
SELECT c.nome, te.designacao, count(te.designacao) as numero FROM Cliente as c
	inner join servico_cliente as sc on sc.id_cliente = c.id
    inner join servico_externo as se on se.id = sc.id_servico
    inner join tipo_externo as te on te.id = se.id;
    
    
-- que aeronaves aterraram no aerodromo vindas de outros locais
SELECT DISTINCT marcas_da_aeronave FROM ciclo
	where icao_destino = 'LPVF' and icao_origem != 'LPVF';


-- quantos voos foram feitos que começaram e acabaram no aerodromo
select count(*) from ciclo
	where icao_origem = icao_destino;


-- 3 clientes que gastaram mais e quanto gastaram
SELECT c.nome, SUM(sc.pagamento) as total FROM Cliente as c
	inner join servico_cliente as sc on sc.id_cliente = c.id
    inner join quotas as q on q.id = c.id
order by total
limit 3;


-- que aeronave foi mais lucrativa
select a.marcas_da_aeronave, SUM(montante_total) - SUM(despesas) as lucro from aviao as a
	inner join ciclo as cic on cic.marcas_da_aeronave = a.marcas_da_aeronave
    inner join servico_externo as se on se.id = cic.id_servico
    inner join servico_interno as si on si.marcas_da_aeronave = a.marcas_da_aeronave
order by lucro;

	-----------------------------------------------------
	Horário flexível:
    
	'Piloto'
    'Instrutor'
    ver_servicos_periodo
    adicionar_observacao_servico
    
    'Revisor'
    ver_manutencoes_periodo
    ver_aviao
    ver_historico_aviao
    -----------------------------------------------------
    Horário fixo:
    
    'Rececionista'
    inserir_cliente
    atualizar_cliente
    inserir_servico_ao_cliente
    inserir_quotas
    ver_cliente
    ver_disponibilidade_funcionarios
    ver_disponibilidade_avioes
    ver_servicos_ao_cliente
    -----------------------------------------------------
    'Controlador'
	ver_ciclos_periodo
    ver_ciclos_a_decorrer
    ver_ocupacao_local
	-----------------------------------------------------
	'Auxiliar'
    ver_servicos_periodo
    ✔ ver lugares livres
    -----------------------------------------------------
    'Gestor'
    ver_transacoes_periodo
    ver_lucro_cliente
    ver_lucro_aviao
    ver_socios_quotas
    
    -----------------------------------------------------
    'Administrador'
    ver_tempo_servico_funcionario_periodo
	-----------------------------------------------------
	Todos:
    
    ✔ proc_ver_horario
	-----------------------------------------------------



DELIMITER $$
Create Procedure `proc_ver_disponibilidade_funcionarios` (IN inicio DATETIME, IN fim DATETIME, IN funcao VARCHAR(255))
BEGIN
	select * from Funcionario as Fun
    inner join Funcao_funcionario as Ff on Ff.numero = Fun.numero
    inner join Funcao as F on Ff.funcao = F.id
    inner join Horario_funcionario as Hf on Hf.id_funcionario = Fun.numero
    inner join Horario as H on H.id = Hf.id_horario
	where designacao = funcao and Fun.empregado = true;
END
$$
-- drop procedure `proc_ver_disponibilidade_funcionarios`;
-- CALL proc_ver_disponibilidade_funcionarios('2018-06-24 12:00', '2018-06-24 13:00', 'Piloto');


-- ver ciclos a decorrer
	select * from Servico as s
    inner join Servico_ao_cliente as sc on sc.id = s.id
    inner join Ciclo as C on sc.id = C.id_servico;
	-- where

-- lugares livres    
    select designacao as 'Designação' from Lugar_local as L
    left join Aviao as A on A.lugar_local = L.id
    where A.lugar_local is null;
    


drop procedure `proc_ver_horario`;
DELIMITER $$
Create Procedure `proc_ver_horario` (IN numero INT)
BEGIN
	select data_inicio as 'Data início', data_fim as 'Data fim', hora_inicio as 'Hora início', hora_fim as 'Hora fim', GROUP_CONCAT(dia_semana(D.dia) separator ', ') as 'dias da semana' from Horario as H
    inner join Horario_funcionario as Hf on Hf.id_horario = H.id
    inner join Funcionario as Fun on Fun.numero = Hf.id_funcionario
    inner join Dias_da_semana as D on H.id = D.id
	where Fun.numero = numero;
END
$$
CALL proc_ver_horario(1);


drop function dia_semana
DELIMITER %%
create function `dia_semana` (n INT)
	RETURNS VARCHAR(14) DETERMINISTIC
BEGIN
	DECLARE dia VARCHAR(14);
	SET dia = (CASE
		WHEN n=0 THEN 'segunda-feira'
        WHEN n=1 THEN 'terça-feira'
        WHEN n=2 THEN 'quarta-feira'
        WHEN n=3 THEN 'quinta-feira'
        WHEN n=4 THEN 'sexta-feira'
        WHEN n=5 THEN 'sábado'
        WHEN n=6 THEN 'domingo'
	END);
	RETURN dia;
END
%%
select dia_semana(3);

   
Implementar  um  gatilho que  registe  numa  tabela  de  auditoria  (“audCromos”), criada especificamente para o efeito, a data e a hora em que um dado cromo foi adquirido.
Este  gatilho  deverá ser  ativado  sempre  que  o  valor  do  atributo  “Adquirido”  da  tabela “Cromo” mude de ‘N’ para ‘S’
drop trigger alinea_8;
delimiter |   
create TRIGGER alinea_8 AFTER insert on cromo
	FOR EACH ROW -- o insert pode ser em várias linhas
	BEGIN
		IF NEW.Adquirido = 'S' THEN -- new. -> nova entrada...mesmo que seja um delete
			INSERT INTO `Caderneta`.`audCromos`(`data_registo`,`cromo`) VALUES
			(sysdate(), NEW.Nr);
		END IF;
END;