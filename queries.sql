
USE `mydb` ;

-- quantos servicos cada cliente fez de cada tipo
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
    
    
    
-- que aeronaves aterraram no aerodromo vindas de outros locais
SELECT DISTINCT
    Marcas_da_aeronave
FROM
    Ciclo
WHERE
    icao_destino = 'LPVF'
        AND icao_origem != 'LPVF';


-- quantos voos foram feitos que começaram e acabaram no aerodromo
SELECT 
    COUNT(*)
FROM
    Ciclo
WHERE
    icao_origem = icao_destino;


-- 3 clientes que gastaram mais e quanto gastaram
SELECT 
    C.Nome, SUM(CS.Pagamento) AS Total
FROM
    Cliente AS C
        INNER JOIN
    Cliente_servico AS CS ON CS.id_cliente = C.id
        INNER JOIN
    Quotas AS Q ON Q.id = C.id
GROUP BY C.id
ORDER BY Total
LIMIT 3;


-- que aeronave foi mais lucrativa
SELECT 
    A.Marcas_da_aeronave,
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


	-----------------------------------------------------

	'Piloto' 
    'Instrutor' 
    'Revisor' 
	✔ ver_servicos_atribuidos(numero funcionario)
	✔ adiciona_observacao_servico(observacao, servico)
    Revisor só:
    ✔ ver_avioes_nossos()
	✔ ver_historico_manutencoes(aviao)
    ✔ completar_manutencao(despesas, nr fatura)
    ✔ atualizar_data_revisao_aviao(aviao)
    
    'Rececionista' 
    ? criar_cliente(coisas)
    ? atualizar_cliente()...
    M ver_clientes() -> ordenados por numero
    D adicionar_quota(id_cliente) -> cria socio se for primeira
    M ver_servicos() -> ordenado por id
    ver_servicos_com_vagas(tipo)
    M ver_avioes() -> ordenado por id
    ver_disponibilidade_funcionarios(funcao) ->
    ver_disponibilidade_avioes(tipo) ->
    cria_servico_ao_cliente(coisas)
    cancelar_servico(id)
    adiar_servico()??
    
    'Controlador' 
	ver_ciclos_planeados()
    ver_ciclos_a_decorrer() (não testado)
    atualiza_icao_aviao(icao)
    completar_ciclo(partida, destino, inicio, fim)

	'Auxiliar' 
    ✔ ver_lugares_livres()
    
    'Gestor'
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
    
    -----------------------------------------------------
    'Administrador' ✔?
	criar_manutencao(cenas)
    ver_avioes_revisoes() -> avioes ordenados por revisoes
    
    ver_tempo_servico_funcionario_periodo(periodo, funcionario) -> total, serviço, livres
    ver_ex_funcionarios()
    
    ? criar_funcionario(coisas)
    ? atualizar_funcionario(coisas)
    criar_horario()
    atribuir_horario()
    
	-----------------------------------------------------
	Todos:
    
    ✔ proc_ver_horario
	-----------------------------------------------------

	outros avioes ficam no maximo 48 horas
    verificar e multa


-- ver disponibilidade dos funcionários
drop procedure `proc_ver_disponibilidade_funcionarios`;
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
CALL proc_ver_disponibilidade_funcionarios('2018-06-24 12:00', '2018-06-24 13:00', 'Piloto');


-- ver ciclos a decorrer (não testado)
drop procedure `proc_ver_ciclos_a_decorrer`;
DELIMITER $$
Create Procedure proc_ver_ciclos_a_decorrer ()
BEGIN
	select * from Servico as S
    inner join Servico_ao_cliente as SC on SC.id = S.id
    inner join Ciclo as C on C.id_servico = SC.id
    where date(S.data_de_inicio) <= date(now())
    and C.hora_partida is not null and C.hora_partida >= time(now())
    and C.hora_chegada is null;
END
$$
CALL proc_ver_ciclos_a_decorrer();

-- lugares livres
drop procedure `proc_ver_lugares_livres`;
DELIMITER $$
Create Procedure proc_ver_lugares_livres ()
BEGIN
    select designacao as 'Designação' from Lugar_local as L
    left join Aviao as A on A.lugar_local = L.id
    where A.lugar_local is null;
END
$$
CALL proc_ver_lugares_livres();

-- ver_socios_quotas (falta testar)
drop procedure `proc_ver_socios_quotas`;
DELIMITER $$
Create Procedure proc_ver_socios_quotas ()
BEGIN
	select C.nome, COUNT(*) AS 'Número de Quotas' from Cliente as C
    inner join Quotas AS Q on C.id = Q.id
    group by C.id
    order by 'Número de Quotas' DESC;
END
$$
CALL proc_ver_socios_quotas();

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