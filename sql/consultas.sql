-- CONSULTAS

-- 1ª consulta:
-- Turista consulta todos quartos que existem em todos os parques de um país definido 
-- com base nos filtros:
--     * valor da diária 
--     * número de vagas

-- Na consulta a seguir, o país é ARGENTINA, valor da diária é <= 400 e 
-- o número de vagas é >= 2.
SELECT
    q.vagas,
    q.diaria, 
    TRUNC(q.diaria/q.vagas, 2) AS diaria_por_vaga,
    hoteis.nome AS nome_hotel, 
    hoteis.parque
FROM(
    SELECT h.documento, p.nome AS parque, h.nome AS nome
    FROM parque_tematico p
    INNER JOIN hotel h
        ON p.documento = h.parque
    WHERE p.pais = 'ARGENTINA'
) hoteis
INNER JOIN quarto q
    ON q.hotel = hoteis.documento
WHERE q.vagas >= 2 AND q.diaria <= 400.00;


-- 2ª consulta:
-- Consulta hospedagens próximas do turista, com as informações necessárias,
-- sendo estas nome do hotel, número do quarto, número de vagas, 
-- quantas pessoas hospedadas e quanto o turista pagará.
-- Irá mostrar as hospedagens que iniciam num prazo de 1 semana.
--SELECT 
--FROM(
--    SELECT
--    FROM hospedagem 
--    LEFT JOIN turista
--        ON turista.passaporte=hospedagem.turista
--    WHERE 
--) near



-- 3ª consulta :

