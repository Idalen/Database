--------------------/ CONSULTAS /--------------------

-----/ 1ª CONSULTA /-----
--/ Turista consulta todos quartos que existem em um parque específico 
--/ com base nos dias de checkin e checkout desejados e os filtros: 
--/     * valor da diária 
--/     * número de vagas

--SELECT available.nome_hotel, available.quarto, q.vagas,
--        q.diaria, 
--        q.diaria*(upper('[2021-07-05, 2021-07-07)'::tsrange) - lower('[2021-07-05, 2021-07-07)'::tsrange)) AS preço_total
--FROM
--(
--    SELECT hosp.quarto, hosp.hotel, hoteis.nome AS nome_hotel
--    FROM(
--        SELECT h.documento, h.nome AS nome
--        FROM parque_tematico p
--        INNER JOIN hotel h
--            ON p.documento = h.parque
--        WHERE p.documento = 12345678910
--    ) hoteis
--    INNER JOIN hospedagem hosp
--        ON hosp.hotel = hoteis.documento
--    WHERE NOT hosp.duracao && '[2021-07-05, 2021-07-07)'::tsrange
--) available 
--INNER JOIN
--quarto q
--    ON q.hotel = available.hotel AND q.numero = available.quarto
--
--WHERE q.vagas >= 2 AND q.diaria <= 400.00;
--;
--

--SELECT available.nome_hotel, available.quarto, q.vagas,
--        q.diaria, 
--        q.diaria*(upper('[2021-07-05, 2021-07-07)'::tsrange) - lower('[2021-07-05, 2021-07-07)'::tsrange)) AS preço_total
--FROM
--(
--    SELECT hoteis.quarto, hoteis.hotel, hoteis.nome AS nome_hotel
--    FROM(
--        SELECT h.documento, h.nome AS nome
--        FROM parque_tematico p
--        INNER JOIN hotel h
--            ON p.documento = h.parque
--        WHERE p.documento = 12345678910
--    ) hoteis
--    INNER JOIN quarto q
--        ON q.hotel = hoteis.hotel AND q.numero = hoteis.quarto
--) all
--INNER JOIN
--hospedagem hosp
--    ON all.hotel = available.hotel AND q.numero = available.quarto
--
--
--    hospedagem hosp
--        ON hosp.hotel = hoteis.documento
--    WHERE NOT hosp.duracao && '[2021-07-05, 2021-07-07)'::tsrange;

-----/ FIM 1ª CONSULTA /-----


-- OK
-----/ 2ª CONSULTA /-----
--> Calcula o lucro total de um hotel específico em um dia definido, 
--> assim como a quantidade de quartos sendo usados e a quantidade total de hóspedes.
SELECT 
    SUM(q.diaria) AS lucro_total,
    COUNT(quartos.quarto) AS total_quartos_ocupados, 
    SUM(quartos.hospedes) AS total_hospedes
FROM (
    -- Seleciona todos os quartos em que algum turista está hospedado naquele dia específico,
    -- e retorna a PK deste quarto (hotel e número) e o total de turistas hospedados
    SELECT DISTINCT 
        hosp.quarto, hosp.hotel,
        COUNT(hosp.turista) OVER(PARTITION BY hosp.hotel, hosp.quarto) AS hospedes
    FROM hotel h
    INNER JOIN hospedagem hosp
        ON h.documento = hosp.hotel
    WHERE h.documento=12345678915 AND '2021-05-21'::TIMESTAMP <@ hosp.duracao -- hotel da madu
) quartos
INNER JOIN quarto q -- Feito um inner join para conseguir as diárias dos quartos
    ON quartos.hotel = q.hotel AND quartos.quarto = q.numero
GROUP BY q.hotel; 

-----/ FIM 2ª CONSULTA /-----

-- OK
-----/ 3ª CONSULTA /-----
--> Consulta a média das avaliações de restaurantes filtradas pelo parque especificado
--> e pelo tipo de cozinha desejado
SELECT
    restaurante.documento,
    restaurante.nome,
    restaurante.tipo_cozinha,
    AVG(a.nota)::NUMERIC(2,1)
FROM(
    SELECT 
    rest_by_pais.parque, rest_by_pais.documento, rest_by_pais.nome, c.tipo_cozinha
    FROM(
        SELECT r.documento AS documento, p.nome AS parque, r.nome AS nome
        FROM parque_tematico p
        INNER JOIN restaurante r
            ON p.documento = r.parque
        WHERE p.documento = 12345678911
    )rest_by_pais INNER JOIN cozinha c
        ON rest_by_pais.documento = c.restaurante
    WHERE c.tipo_cozinha = 'FRANCESA'
)restaurante LEFT OUTER JOIN avaliacao a
    ON a.restaurante = restaurante.documento
GROUP BY 
    restaurante.documento,
    restaurante.nome, 
    restaurante.tipo_cozinha
ORDER BY AVG(a.nota);

-----/ FIM 3ª CONSULTA /-----


-- OK
-----/ 4ª CONSULTA (COM DIVISÃO)/-----
--> Consulta os hoteis de um parque espeficiado com o filtro de 2 serviços que o turista deseja
--> que o hotel ofereça. Note que são necessários ambos serviços.

SELECT filtered_hoteis.nome AS nome
FROM(
    -- Seleciona todos os hoteis que possuem o servico S1.
    SELECT hoteis.nome, hoteis.documento
    FROM (
        -- Seleciona todos os hoteis do parque especificado
        SELECT h.documento, h.nome 
        FROM hotel h
        INNER JOIN parque_tematico p
        ON h.parque = p.documento
        WHERE p.documento = 12345678911 -- 'PARQUE DIDI'
    ) hoteis 
    INNER JOIN servico_hotel s
    ON hoteis.documento = s.hotel
    WHERE s.servico='LAVANDERIA' OR s.servico='ACADEMIA'
) filtered_hoteis
GROUP BY filtered_hoteis.documento, filtered_hoteis.nome
HAVING COUNT(*) = 2;

--SELECT filtered_hoteis.nome AS hoteis
--FROM(
--    -- Seleciona todos os hoteis que possuem o servico S1.
--    SELECT hoteis.nome, hoteis.documento
--    FROM (
--        -- Seleciona todos os hoteis do parque especificado
--        SELECT h.documento, h.nome 
--        FROM hotel h
--        INNER JOIN parque_tematico p
--        ON h.parque = p.documento
--        WHERE p.documento = 12345678911 -- 'PARQUE DIDI'
--    ) hoteis 
--    INNER JOIN servico_hotel s
--    ON hoteis.documento = s.hotel
--    WHERE s.servico='LAVANDERIA'
--) filtered_hoteis
--INNER JOIN servico_hotel s -- Com o inner join, tem-se os hoteis com ambos serviços S1 e S2
--ON filtered_hoteis.documento = s.hotel
--WHERE s.servico='ACADEMIA';

-----/ FIM 4ª CONSULTA /-----

-----/ 5ª CONSULTA /-----
--> Consulta todos os turistas participantes de todos os grupos de um administrador que não tem hospedagem marcada

SELECT tur.turista FROM(
    SELECT turista FROM grupo_turistas g -- todos turistas de todos os grupos de um admin
    INNER JOIN participacao p 
        ON g.nome_grupo = p.nome_grupo
    WHERE g.admin='12345678923'
) tur
WHERE NOT EXISTS(
    SELECT tur.turista FROM hospedagem h
    WHERE tur.turista=h.turista
);



-- OK
-----/ 6ª CONSULTA /-----
--> Consulta todas as atrações de um parque especificado que não tenha uma restrição específica. 

SELECT atracoes.nome AS nome_atracao, (
    CASE WHEN atracoes.tipo=true THEN 'RESERVADA'
    WHEN atracoes.tipo=false THEN 'LIVRE'
    ELSE 'UNKNOWN'
    END ) AS TIPO
FROM (
    SELECT a.nome, a.parque, a.tipo, a.capacidade
    FROM parque_tematico p
    INNER JOIN atracao a
        ON p.documento = a.parque
    WHERE p.documento = 12345678910 -- PARQUE MADU
) atracoes
WHERE atracoes.nome NOT IN (
    SELECT r.nome_atracao
    FROM restricoes_atracao r
    WHERE r.restricao = 'IDADE MINIMA 13' AND atracoes.parque = r.parque_atracao
)
ORDER BY atracoes.tipo;

-----/ FIM 6ª CONSULTA /-----

-----/ 7ª CONSULTA /-----
--> Turista deseja uma lista com todos os eventos do passeio mais próximo de uma data
--> especificada
SELECT 
    e.nome_atracao, e.ingresso AS codigo_info_ingresso, 
    proximo.nome_grupo AS grupo, proximo.data, proximo.nome_guia AS guia, proximo.preco_guia
FROM (
    SELECT p.id, p.admin_grupo, p.nome_grupo, p.data, p.nome_guia, p.preco_guia
    FROM passeio p 
    INNER JOIN participacao part
        ON p.admin_grupo = part.admin_grupo AND p.nome_grupo = part.nome_grupo
    WHERE part.turista = 12345678918 AND p.data > '2021-05-21'::TIMESTAMP
    ORDER BY p.data
    LIMIT 1
) proximo -- Passeio mais próximo da data definida
INNER JOIN evento e
    ON e.passeio = proximo.id
;

-----/ FIM 7ª CONSULTA /-----