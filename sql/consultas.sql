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

-- TO DO:
-- ******* AQUI TEM Q PEGAR A CONSULTA NO database.py, pfvr faça isso daniel ******* --
-----/ 3ª CONSULTA /-----
--> Consulta a média das avaliações de restaurantes filtradas pelo parque especificado
--> e pelo tipo de cozinha desejado
--SELECT
--    restaurante.documento,
--    restaurante.nome,
--    restaurante.tipo_cozinha,
--    AVG(a.nota)::NUMERIC(2,1)
--FROM(
--    SELECT 
--    rest_by_pais.documento, rest_by_pais.nome, rest_by_pais.parque, c.tipo_cozinha
--    FROM(
--        SELECT r.documento, p.nome AS parque, r.nome AS nome
--        FROM parque_tematico p
--        INNER JOIN restaurante r
--            ON p.documento = r.parque
--        WHERE p.pais = 'ARGENTINA'
--    )rest_by_pais INNER JOIN cozinha c
--        ON rest_by_pais.documento = c.restaurante
--    WHERE c.tipo_cozinha = 'ITALIANA'
--)restaurante LEFT OUTER JOIN avaliacao a
--    ON a.restaurante = restaurante.documento
--GROUP BY 
--    restaurante.documento,
--    restaurante.nome, 
--    restaurante.tipo_cozinha
--ORDER BY AVG(a.nota);

-----/ FIM 3ª CONSULTA /-----


-- OK
-----/ 4ª CONSULTA (COM DIVISÃO)/-----
--> Consulta os hoteis de um parque espeficiado com o filtro de 2 serviços que o turista deseja
--> que o hotel ofereça. Note que são necessários ambos serviços.
SELECT filtered_hoteis.nome
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
    WHERE s.servico='LAVANDERIA'
) filtered_hoteis
INNER JOIN servico_hotel s -- Com o inner join, tem-se os hoteis com ambos serviços S1 e S2
ON filtered_hoteis.documento = s.hotel
WHERE s.servico='ACADEMIA';

-----/ FIM 4ª CONSULTA /-----

-----/ 5ª CONSULTA /-----
--> Checar pessoas do grupo do turista que ainda não estão hospedadas em algum hotel
--> durante uma viagem definida.
--SELECT nome
--FROM turista
--WHERE EXISTS (
--    SELECT
--    FROM participacao 
--    SELECT grupos.nome_grupo, grupos.admin_grupo
--    FROM (
--        SELECT p.admin_grupo, p.nome_grupo
--        FROM participacao p
--        INNER JOIN turista t
--            ON p.turista = t.passaporte 
--        WHERE t.nome='EUGENIO'
--    ) grupos 
--    INNER JOIN viagem v
--    ON grupos.admin_grupo=v.admin_grupo AND grupos.nome_grupo=v.nome_grupo
--    ORDER BY v.data_inicio ASC
--    LIMIT 1 -- VIAGEM MAIS PROXIMA
--    ;
--);


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

-----/ FIM 5ª CONSULTA /-----

-----/ 6ª CONSULTA
-- Consulta todas as atrações de um parque especificado
-- e divide em atrações livres e reservadas. 
-- Para as atrações reservadas, mostra as restrições presentes
--SELECT atracoes.nome
--    CASE WHEN atracoes.tipo = FALSE THEN atracoes.nome 
--    END AS atracoes_livres
--    --CASE 
--    --WHERE atracoes.tipo = true THEN atracoes.nome 
--    --END AS atracoes_reservadas
----    atracoes.nome FILTER (WHEN atracoes.tipo = FALSE) AS atracoes_livres,
----    atracoes.nome FILTER (WHEN atracoes.tipo = TRUE) AS atracoes_reservadas
--FROM (
--    SELECT a.nome, a.tipo, a.capacidade
--    FROM parque_tematico p
--    INNER JOIN atracao a
--        ON p.documento = a.parque
--    WHERE p.documento = 12345678910 -- PARQUE MADU
--) atracoes;
--GROUP BY atracoes.tipo, atracoes.nome;



-- Antiga segunda consulta (eu acho que não faz sentido para o contexto)
-- Consulta todas as hospedagens dos turistas, com as informações necessárias,
-- sendo estas nome do hotel, número do quarto, número de vagas, 
-- quantas pessoas hospedadas e quanto o turista pagará. Irá ordenar pelas estadias
-- mais proximas
--SELECT 
--    t.nome AS turista, 
--    detail.hotel, 
--    detail.quarto, 
--    detail.vagas AS vagas,
--    detail.qnt AS hospedes,
--    TRUNC(detail.diaria/detail.qnt, 2) AS preço_a_pagar,
--    detail.duracao AS estadia
--FROM(
--    SELECT h.hotel, h.quarto, h.duracao, h.turista, q.vagas, q.diaria,
--    COUNT(h.turista) OVER(PARTITION BY h.hotel, h.quarto) AS qnt
--    FROM hospedagem h
--    INNER JOIN quarto q
--        ON h.hotel=q.hotel AND h.quarto = q.numero
--    ORDER BY lower(h.duracao) DESC
--) detail
--RIGHT OUTER JOIN turista t
--    ON detail.turista = t.passaporte
--ORDER BY t.nome;
