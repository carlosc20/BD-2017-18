-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries Auxiliar e Controlador
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
    ------------------------------------------------------
    Auxiliar e Controlador
    
    Auxiliar
    ✔ ver_lugares_livres()
    
	Controlador
	✔ ver_ciclos_planeados()
    ✔ ver_ciclos_a_decorrer() (não testado)
	✔ completar_ciclo(partida, destino, inicio, fim)
    ------------------------------------------------------
    */
    
    
-- Ver lugares de estacionamento livres
-- Auxiliar
SELECT 
    designacao AS 'Designação'
FROM
    Lugar_local AS L
        LEFT JOIN
    Aviao AS A ON A.lugar_local = L.id
WHERE
    A.lugar_local IS NULL;

-- Ver ciclos planeados
-- Controlador
SELECT * FROM ciclos_planeado;

-- NAO TESTADO
-- Ver ciclos a decorrer 
-- Controlador
SELECT 
	*
FROM
	Servico AS S
		INNER JOIN
	Servico_ao_cliente AS SC ON SC.id = S.id
		INNER JOIN
	Ciclo AS C ON C.id_servico = SC.id
WHERE
	DATE(S.data_de_inicio) <= DATE(NOW())
		AND C.hora_partida IS NOT NULL
		AND C.hora_partida >= TIME(NOW())
		AND C.hora_chegada IS NULL;

-- Completa informação de um ciclo(id)
-- Controlador
/*
drop procedure `completar_ciclo`;
*/
DELIMITER $$
Create Procedure `completar_ciclo`(IN id INT, IN partida TIME, IN chegada TIME)
BEGIN
    UPDATE Ciclo
    SET 
        hora_partida = partida,
        hora_chegada = chegada
    WHERE
        id_servico = id;
END
$$
/*
CALL completar_ciclo(1, "18:25:00", "19:55:00");
*/