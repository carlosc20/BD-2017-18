-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Aeródromo da Feira
-- Queries Rececionista
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Esquema: "mydb"
USE `mydb`;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;


	/*
    ------------------------------------------------------
    Rececionista
    ? criar_cliente(coisas)
    ? atualizar_cliente()...
    M ver_clientes() -> ordenados por numero
    ✔ adicionar_quota(id_cliente)
    M ver_servicos() -> ordenado por id
    D ver_servicos_com_vagas(tipo)
    M ver_avioes() -> ordenado por id
    ver_disponibilidade_funcionarios(funcao) ->
    ver_disponibilidade_avioes(tipo) ->
    cria_servico_ao_cliente(coisas)
    cancelar_servico(id)
    adiar_servico()??
    ------------------------------------------------------
    */
    

-- Adiciona quota a um cliente, se for a primeiro adiciona número de sócio
-- Rececionista
drop procedure `adicionar_quota`;
DELIMITER $$
Create Procedure `adicionar_quota`(IN id_cliente INT, IN ano_quota YEAR)
BEGIN
    DECLARE socio INT;
    DECLARE r BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET r = 1;
    SET socio = (SELECT numero_socio FROM Cliente WHERE id = id_cliente);
    START TRANSACTION;
    IF (socio IS NULL)
        THEN
            SET socio = ((
                SELECT numero_socio FROM Cliente
                ORDER BY numero_socio DESC
                LIMIT 1
            ) + 1);
            UPDATE Cliente 
            SET 
                numero_socio = socio
            WHERE
                id = id_cliente;
        IF r
            THEN ROLLBACK;
        END IF;
    END IF;
        INSERT Quotas (id, ano)
        VALUE (socio, ano_quota);
        IF r
            THEN ROLLBACK;
            ELSE COMMIT;
        END IF;
END
$$
CALL adicionar_quota(6, 2023);