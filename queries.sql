
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
    ver_ocupacao_local
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
    
    ver_horario
	-----------------------------------------------------



DELIMITER $$
Create Procedure `proc_funcionario_periodo` (IN dia DATE)
BEGIN
	SELECT s from Cromo AS CR
		INNER JOIN Jogador AS J ON J.Nr = CR.Jogador
        INNER JOIN Equipa AS Eq ON J.Equipa = Eq.ID
        where Eq.Designacao = nome
        ORDER BY Cr.PagCaderneta, CR.Nr;
END
$$
-- drop procedure `proc_alinea_4_f10`;
-- CALL PROC_ALINEA_4_F10("Sporting Clube de Braga");




-- drop procedure `proc_alinea_5`;
DELIMITER $$
Create Procedure `proc_alinea_5` ()
BEGIN
	SELECT CR.Nr, CR.tipo, J.Nome, Eq.Designacao, CR.Adquirido from Cromo AS CR
		INNER JOIN Jogador AS J ON J.Nr = CR.Jogador
        INNER JOIN Equipa AS Eq ON J.Equipa = Eq.ID;
END
$$
-- CALL PROC_ALINEA_5();



-- 7 
-- drop function alinea7
DELIMITER %%
create function `alinea7` (numero INT)
	RETURNS VARCHAR(100) deterministic
BEGIN
	DECLARE r,a,b,c VARCHAR(200);
	select tipocromo.Descricao, Jogador.Nome, Equipa.Designacao into a,b,c from Cromo
		inner join TipoCromo on Cromo.Tipo = TipoCromo.Id
        inner join Jogador on Cromo.Jogador = Jogador.Nr
        inner join Equipa on Jogador.Equipa = Equipa.Id
        WHERE Cromo.Nr = numero;
	set r = concat(a," ",b, " ",c); 
	RETURN r;
END
%%

select alinea7(2);
-- 8 
-- update cromo
-- ler info nova
-- inserir na tabela 
-- NEW Nr, NEW Adquirido
CREATE TABLE `mydb`.`audCromos`(
	`data_registo`DATETIME NOT NULL COMMENT '',
    `cromo` int NOT NULL COMMENT '',
    PRIMARY KEY (`data_registo`, `cromo`) COMMENT '');
   
   
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