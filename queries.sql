
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
