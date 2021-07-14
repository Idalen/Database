-- Inserção de dados no banco de dados, com no mínimo 2 tuplas por tabela.

-- Tabela PAIS
INSERT INTO pais
    VALUES 
    ('ARGENTINA'), -- nome do país (PK)
    ('ANGOLA'),
    ('JAPAO'),
    ('BRASIL'),
    ('ITALIA');


-- Tabela PARQUE TEMATICO
INSERT INTO parque_tematico  
    VALUES(
        12345678911, -- documento do parque temático (PK)
        'ARGENTINA', -- nome do país (FK)
        'PARQUE DIDI', -- nome do parque
        150.0, -- preço do ingresso
        700, -- lotação máxima
        '08:00:00','22:00:00', -- horário de funcionamento (abertura, fechamento) no domingo
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na segunda
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na terça
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na quarta
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na quinta
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na sexta
        '08:00:00','22:00:00'  -- horário de funcionamento (abertura, fechamento) no sábado
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


-- Tabela RESTAURANTE
INSERT INTO restaurante
    VALUES
    (
        12345678912, -- documento do restaurante (PK)
        12345678911, -- documento do parque (FK)
        'RESTAURANTE DO DIOGO', -- nome do restaurante
        numrange(100, 500, '[)'),-- faixa de preço,
        '08:00:00','21:00:00', -- horário de funcionamento (abertura, fechamento) no domingo
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na segunda
        '10:00:00','15:00:00', -- horário de funcionamento (abertura, fechamento) na terça
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na quarta
        '08:00:00','19:00:00', -- horário de funcionamento (abertura, fechamento) na quinta
        '09:00:00','12:00:00', -- horário de funcionamento (abertura, fechamento) na sexta
        '08:00:00','22:00:00'  -- horário de funcionamento (abertura, fechamento) no sábado
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

-- Tabela COZINHA
INSERT INTO cozinha 
    VALUES
    (
        12345678912, -- documento do restaurante (FK)(PK)
        'FRANCESA' -- cozinha (PK)
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

-- Tabela HOTEL
INSERT INTO hotel
    VALUES
    (
        12345678914, -- documento do hotel (PK)
        12345678911, -- documento do parque (FK)
        'HOTEL DO DIOGO', -- nome do hotel
        0, -- total de quartos
        0 -- total de vagas
    ),
    (
        12345678915,
        12345678910,
        'HOTEL DA MADU',
        0,
        0
    );

-- Tabela SERVIÇO HOTEL
INSERT INTO servico_hotel
    VALUES
    (
        12345678914, -- documento do hotel (FK)(PK)
        'LAVANDERIA' -- nome do serviço (PK) 
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

-- Tabela QUARTO
INSERT INTO quarto
    VALUES 
    (
        12345678914, -- documento do hotel (FK)(PK)
        1, -- número do quarto (PK)
        2 -- número de vagas 
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

-- Tabela TURISTA
INSERT INTO turista
    VALUES
    (
        12345678916, -- número do passaporte (PK)
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

-- Tabela RESTRIÇÕES ALIMENTARES
INSERT INTO restricoes_alimentares
    VALUES
    (
        12345678917, -- passaporte turista (FK)(PK)
        'ALERGIA CAMARAO' -- descrição da restrição (PK)
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

-- Tabela NECESSIDADES ESPECIAIS
INSERT INTO necessidades_especiais
    VALUES
    (
        12345678916, -- passaporte do turista (FK)(PK)
        'CADEIRANTE' -- descrição da necessidade (PK)
    ),
    (
        12345678917,
        'DEFICIENTE VISUAL'
    );

-- Tabela AVALIAÇÃO dos restaurantes
INSERT INTO avaliacao
    VALUES
    (
        12345678916, -- passaporte do turista (FK)(PK)
        12345678912, -- documento do restaurante (FK)(PK)
        5 -- nota
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

-- Tabela HOSPEDAGEM
INSERT INTO hospedagem
    VALUES 
    (
        12345678918, -- passaporte do turista (FK)(PK)
        12345678914, -- documento do hotel (FK)(PK)
        2, -- número do quarto (PK)
        '[2021-05-06 13:00, 2021-05-07 10:00)' -- duração da estadia (PK)

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

-- Tabela GRUPO DE TURISTAS
INSERT INTO grupo_turistas
    VALUES
    (
        12345678919, -- passaporte administrador do grupo (FK)(PK)
        'GRUPO DO FRED' -- nome do grupo (PK)
    ),
    (
        12345678916,
        'GRUPO DO DIOGO'
    );

-- Tabela de PARTICIPACAO de um turista em um grupo de turistas.
-- OBS: Aqui é necessário adicionar o administrador do grupo como participante também. -- Trigger
INSERT INTO participacao
    VALUES
    (
        12345678918, -- passaporte turista (FK)(PK)
        12345678919, -- passaporte administrador do grupo (FK)(PK)
        'GRUPO DO FRED' -- nome do grupo (FK)(PK)
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