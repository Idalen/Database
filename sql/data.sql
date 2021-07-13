-- Insercao de dados em PAIS

INSERT INTO pais
    VALUES ('ARGENTINA'),
    ('ANGOLA'),
    ('JAPAO'),
    ('BRASIL'),
    ('ITALIA');


-- Insercao de dados em PARQUE TEMATICO

INSERT INTO parque_tematico  
    VALUES(
        12345678911, 
        'ARGENTINA',
        'PARQUE DIDI',
        150.0,
        700,
        '08:00:00','22:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '08:00:00','22:00:00'
        ),
        (
        12345678910, 
        'ANGOLA',
        'PARQUE MADU',
        99.99,
        NULL,
        '08:00:00','22:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '09:00:00','12:00:00',
        '08:00:00','22:00:00'
        );


-- Insercao de dados em restaurante
INSERT INTO restaurante
    VALUES
    (
        12345678912, -- documento restaurante
        12345678911, -- documento parque
        'RESTAURANTE DO DIOGO', -- nome restaurante
        numrange(100, 500, '[)'),-- faixa de preço,
        '08:00:00','21:00:00', -- ini fim dom
        '09:00:00','12:00:00', -- ini fim seg
        '10:00:00','15:00:00', -- ini fim ter
        '09:00:00','12:00:00', -- ini fim qua
        '08:00:00','19:00:00', -- ini fim qui
        '09:00:00','12:00:00', -- ini fim sex
        '08:00:00','22:00:00'  -- ini fim sab
    ),
    (
        12345678913,
        12345678910,
        'RESTAURANTE DA MADU',
        numrange(100, 500, '[)'),
        '08:00:00','21:00:00',
        '09:00:00','12:00:00',
        '10:00:00','15:00:00',
        '09:00:00','12:00:00',
        '08:00:00','19:00:00',
        '09:00:00','12:00:00',
        '08:00:00','22:00:00'
    );

-- Insercao dados tabela cozinha
INSERT INTO cozinha 
    VALUES
    (
        12345678912, -- documento restaurante
        'FRANCESA' -- cozinha
    ),
    (
        12345678912,
        'ITALIANA'
    ),
    (
        12345678913,
        'JAPONESA'
    ),
    (
        12345678913,
        'CHINESA'
    ),
    (
        12345678913,
        'COREANA'
    );

-- insercao de dados em hotel
INSERT INTO hotel
    VALUES
    (
        12345678914, -- documento hotel
        12345678911, -- fk parque
        'HOTEL DO DIOGO', -- nome hotel
        0, -- total_quartos
        0 -- total_vagas
    ),
    (
        12345678915,
        12345678910,
        'HOTEL DA MADU',
        0,
        0
    );

-- insercaod e dados em servico hotel
INSERT INTO servico_hotel
    VALUES
    (
        12345678914, -- documento hotel
        'LAVANDERIA' -- serviço
    ),
    (
        12345678914,
        'ACADEMIA'
    ),
    (
        12345678914,
        'DESJEJUM'
    ),
    (
        12345678915,
        'DESJEJUM'
    ),
    (
        12345678915,
        'PISCINA'
    ),
    (
        12345678915,
        'SAUNA'
    );

-- insercao de dados na tabela quarto
INSERT INTO quarto
    VALUES 
    (
        12345678914, -- documento do hotel
        1, -- número do quarto
        2
    ),
    (
        12345678914,
        2,
        1
    ),
    (
        12345678914, 
        3,
        3
    ),
    (
        12345678914, 
        4,
        2
    ),
    (
        12345678915,
        1,
        2
    ),
    (
        12345678915,
        2,
        1
    ),
    (
        12345678915,
        3,
        4
    );

-- insercao de dados em turista
INSERT INTO turista
    VALUES
    (
        12345678916, -- passaporte
        'DIOGO', -- nome 
        '2000-03-27', -- data de nascimento
        '(16)999999999' -- telefone
    ),
    (
        12345678917,
        'MADU',
        '2001-04-19',
        '(16)999999998'
    ),
    (
        12345678918,
        'DANIEL',
        '2001-09-18',
        '(16)999999997'
    ),
    (
        12345678919,
        'FRED',
        '2000-10-10',
        '(16)999999996'
    );

-- insercao de dados restricoes alimentares
INSERT INTO restricoes_alimentares
    VALUES
    (
        12345678917,
        'ALERGIA CAMARAO'
    ),
    (
        12345678917,
        'CELIACA'
    ),
    (
        12345678918,
        'ALERGIA AMENDOIM'
    ),
    (
        12345678918,
        'VEGANO'
    );

INSERT INTO necessidades_especiais
    VALUES
    (
        12345678916, -- passaporte turista
        'CADEIRANTE' -- necessidade
    ),
    (
        12345678917,
        'DEFICIENTE VISUAL'
    );

INSERT INTO avaliacao
    VALUES
    (
        12345678916, -- passaporte turista
        12345678912,
        5
    ),
    (
        12345678916,
        12345678913,
        4.5
    ),
    (
        12345678917,
        12345678913,
        4
    ),
    (
        12345678918,
        12345678913,
        4.8
    ),
    (
        12345678918,
        12345678912,
        1
    );

-- insercao de dados hospedagem
INSERT INTO hospedagem
    VALUES 
    (
        12345678918, -- turista
        12345678914, -- hotel
        2, -- quarto
        '[2021-05-06 13:00, 2021-05-07 10:00)' -- duracao

    ),
    (
        12345678917, -- turista
        12345678915,
        2,
        '[2021-05-20 13:00, 2021-05-23 10:30)'
    ),
    (
        12345678916, -- turista
        12345678915,
        1,
        '[2021-05-10 13:00, 2021-05-15 09:30)'
    );

INSERT INTO grupo_turistas
    VALUES
    (
        12345678919, -- admin grupo
        'GRUPO DO FRED' -- nome grupo
    ),
    (
        12345678916,
        'GRUPO DO DIOGO'
    );

INSERT INTO participacao
    VALUES
    (
        12345678919,
        12345678919,
        'GRUPO DO FRED'
    ),
    (
        12345678918,
        12345678919,
        'GRUPO DO FRED'
    ),
    (
        12345678916,
        12345678916,
        'GRUPO DO DIOGO'
    ),
    (
        12345678917,
        12345678916,
        'GRUPO DO DIOGO'
    );

INSERT INTO viagem
    VALUES
    (
        12345678919, -- admin_grupo
        'GRUPO DO FRED', -- nome_grupo
        '2021-05-10' , '2021-05-20', -- duracao
        'BRASIL', -- pais_origem
        'JAPAO' -- pais_destino
    ),
    (
        12345678916,
        'GRUPO DO DIOGO',
        '2021-03-20', '2021-04-01',
        'ANGOLA',
        'ITALIA'
    );

INSERT INTO passeio
    VALUES
    (
        DEFAULT, -- id
        '2021-05-19', -- data
        12345678919, -- admin grupo
        'GRUPO DO FRED', -- nome grupo
        12345678910, -- parque
        'MARIA',
        120
    ),
    (
        DEFAULT,
        '2021-03-30',
        12345678916,
        'GRUPO DO DIOGO',
        12345678911,
        'NATALIA',
        60
    );

-- insercao de dados idiomas_guias
INSERT INTO idiomas_guia
    VALUES 
    (
        1,
        'FRANCES'
    ),
    (
        1,
        'INGLES'
    ),
    (
        2,
        'ESPANHOL'
    );

INSERT INTO atracao
    VALUES
    (
        12345678910,
        'RODA GIGANTE',
        FALSE,
        40
    ),
    (
        12345678911,
        'MONTANHA RUSSA',
        FALSE,
        50
    ),
    (
        12345678911,
        'CINEMA',
        TRUE,
        100
    ),
    (
        12345678910,
        'TEATRO',
        TRUE,
        50
    );

INSERT INTO evento
    VALUES
    (
        1,
        12345678911,
        'CINEMA',
        '123456'
    ),
    (
        2,
        12345678910,
        'TEATRO',
        '123457'
    );

INSERT INTO restricoes_atracao
    VALUES
    (
        12345678910,
        'RODA GIGANTE',
        'IDADE MINIMA 13'
    ),
    (
        12345678911,
        'MONTANHA RUSSA',
        'ALTURA MINIMA 140'
    );