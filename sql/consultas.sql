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
-- Consulta todas as hospedagens dos turistas, com as informações necessárias,
-- sendo estas nome do hotel, número do quarto, número de vagas, 
-- quantas pessoas hospedadas e quanto o turista pagará. Irá ordenar pelas estadias
-- mais proximas
SELECT 
    t.nome AS turista, 
    detail.hotel, 
    detail.quarto, 
    detail.vagas AS vagas,
    detail.qnt AS hospedes,
    TRUNC(detail.diaria/detail.qnt, 2) AS preço_a_pagar,
    detail.duracao AS estadia
FROM(
    SELECT h.hotel, h.quarto, h.duracao, h.turista, q.vagas, q.diaria,
    COUNT(h.turista) OVER(PARTITION BY h.hotel, h.quarto) AS qnt
    FROM hospedagem h
    INNER JOIN quarto q
        ON h.hotel=q.hotel AND h.quarto = q.numero
    ORDER BY lower(h.duracao) DESC
) detail
RIGHT OUTER JOIN turista t
    ON detail.turista = t.passaporte
ORDER BY t.nome;


-- 3ª consulta:
-- Consulta a média das avaliações de restaurantes filtradas pelo pais e pelo tipo de cozinha
SELECT
    restaurante.documento,
    restaurante.nome,
    restaurante.tipo_cozinha,
    AVG(a.nota)::NUMERIC(2,1)
FROM(
    SELECT 
    rest_by_pais.documento, rest_by_pais.nome, rest_by_pais.parque, c.tipo_cozinha
    FROM(
        SELECT r.documento, p.nome AS parque, r.nome AS nome
        FROM parque_tematico p
        INNER JOIN restaurante r
            ON p.documento = r.parque
        WHERE p.pais = 'ARGENTINA'
    )rest_by_pais INNER JOIN cozinha c
        ON rest_by_pais.documento = c.restaurante
    WHERE c.tipo_cozinha = 'ITALIANA'
)restaurante LEFT OUTER JOIN avaliacao a
    ON a.restaurante = restaurante.documento
GROUP BY 
    restaurante.documento,
    restaurante.nome, 
    restaurante.tipo_cozinha
ORDER BY AVG(a.nota);

-- 4ª consulta (com divisão, eu acho)
-- Consulta hoteis de um parque com o filtro de 2 serviços que o turista deseja.
SELECT filtered_hoteis.nome
FROM(
    SELECT hoteis.nome, hoteis.documento
    FROM (
        SELECT h.documento, h.nome 
        FROM hotel h
        INNER JOIN parque_tematico p
        ON h.parque = p.documento
        WHERE p.nome = 'PARQUE DIDI'
    ) hoteis
    INNER JOIN servico_hotel s
    ON hoteis.documento = s.hotel
    WHERE s.servico='LAVANDERIA'
) filtered_hoteis
INNER JOIN servico_hotel s
ON filtered_hoteis.documento = s.hotel
WHERE s.servico='ACADEMIA';


-- 5ª Consulta
-- Checar pessoas do grupo do turista que ainda não estão hospedadas em algum hotel
-- durante uma viagem definida.
--SELECT grupo.turista, grupo.nome
--FROM (
--    SELECT t.nome AS turista, p.nome_grupo AS nome
--    FROM turista t
--    INNER JOIN participacao p
--    ON t.passaporte = p.turista
--) grupo
--WHERE EXISTS
--(
--    SELECT part.turista, part.nome_grupo
--    FROM (
--        SELECT p.admin_grupo AS admin, p.nome_grupo AS nome
--        FROM turista t
--        INNER JOIN participacao p 
--        ON t.passaporte=p.turista
--        WHERE t.passaporte = 12345678918
--    ) g
--    INNER JOIN participacao part
--    ON part.admin_grupo=g.admin AND part.nome_grupo=g.nome
--);

-- atrações livre e reservada



