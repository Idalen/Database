-- Inserção de dados no banco de dados, com no mínimo 3 tuplas por tabela.

-- Tabela PAÍS
INSERT INTO pais
    VALUES 
    ('ARGENTINA'), -- nome (PK)
    ('ANGOLA'),
    ('JAPAO'),
    ('BRASIL'),
    ('ITALIA');

-- Tabela PARQUE TEMÁTICO
INSERT INTO parque_tematico  
    VALUES(
        12345678911, -- documento (PK)
        'ARGENTINA', -- país (FK)
        'PARQUE DIDI', -- nome
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
        ),
        (
        12345678913,
        'ITALIA',
        'PARQUE DANIBOY',
        450.0,
        1000,
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
        12345678912, -- documento (PK)
        12345678911, -- parque (FK)
        'RESTAURANTE DO DIOGO', -- nome
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
        12345678915,
        12345678911,
        'RESTAURANTE DO FREDERICO',
        numrange(100, 500, '[)'),
        '08:00:00','21:00:00',
        '09:00:00','12:00:00',
        '10:00:00','15:00:00',
        '09:00:00','12:00:00',
        '08:00:00','19:00:00',
        '09:00:00','12:00:00',
        '08:00:00','22:00:00' 
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
    ),
    (
        12345678914,
        12345678913,
        'RESTAURANTE DA DAN',
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
        12345678915, -- restaurante (FK)(PK)
        'FRANCESA' -- nacionalidade (PK)
    ),
    (
        12345678915,
        'ALEMA'
    ),(
        12345678914,
        'BRASILEIRA'
    ),
    (
        12345678914,
        'JAPONESA'
    ),
    (
        12345678914,
        'AMERICANA'
    ),
    (
        12345678912,
        'FRANCESA'
    ),
    (
        12345678912,
        'ITALIANA'
    ),
    (
        12345678912,
        'AMERICANA'
    ),
    (
        12345678913,
        'AMERICANA'
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
        12345678914, -- documento (PK)
        12345678911, -- parque (FK)
        'HOTEL DO DIOGO', -- nome
        0, -- total de quartos
        0 -- total de vagas
    ),
    (
        12345678916,
        12345678911,
        'HOTEL DO FRECONHA',
        0,
        0
    ),
    (
        12345678915,
        12345678910,
        'HOTEL DA MADU',
        0,
        0
    );

-- Tabela SERVIÇO do HOTEL
INSERT INTO servico_hotel
    VALUES
    (
        12345678916, -- hotel (FK)(PK)
        'LAVANDERIA' -- serviço (PK) 
    ),
    (
        12345678916,
        'ACADEMIA'
    ),
    (
        12345678916,
        'DESJEJUM'
    ),(
        12345678914,
        'LAVANDERIA'
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
        12345678914, -- hotel (FK)(PK)
        1, -- número (PK)
        2, -- vagas
        250.00 -- diária 
    ),
    (
        12345678914,
        2,
        1,
        250.00
    ),
    (
        12345678914, 
        3,
        2,
        250.00
    ),
    (
        12345678914, 
        4,
        2,
        250.00
    ),
    (
        12345678915,
        1,
        2,
        250.00
    ),
    (
        12345678915,
        2,
        1,
        250.00
    ),
    (
        12345678915,
        3,
        4,
        250.00
    ),
    (
        12345678916, 
        1, 
        2, 
        550.00
    ),
    (
        12345678916,
        2,
        1,
        250.00
    ),
    (
        12345678916, 
        3,
        3,
        250.00
    ),
    (
        12345678916, 
        4,
        2,
        350.00
    );

-- Tabela TURISTA
INSERT INTO turista
    VALUES
    (
        12345678916, -- passaporte (PK)
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
    ),
    (
        12345678920,
        'MARIA',
        '1993-03-27',
        '(16)999999999'
    ),
    (
        12345678921,
        'DILMA',
        '1953-04-19',
        '(16)999999998'
    ),
    (
        12345678922,
        'CARLOS',
        '1987-09-18',
        '(16)999999997'
    ),
    (
        12345678923,
        'EUGENIO',
        '2003-10-10',
        '(16)999999996'
    );

-- Tabela RESTRIÇÕES ALIMENTARES
INSERT INTO restricoes_alimentares
    VALUES
    (
        12345678917, -- turista (FK)(PK)
        'ALERGIA CAMARAO' -- restrição (PK)
    ),
    (
        12345678918,
        'ALERGIA AMENDOIM'
    ),
    (
        12345678920,
        'CELIACA'
    ),
    (
        12345678920,
        'VEGANISMO'
    ),
    (
        12345678922,
        'DIABETES'
    ),
    (
        12345678923,
        'HIPOLACTASIA'
    );

-- Tabela NECESSIDADES ESPECIAIS
INSERT INTO necessidades_especiais
    VALUES
    (
        12345678916, -- turista (FK)(PK)
        'DEFICIENCIA FISICA' -- necessidade (PK)
    ),
    (
        12345678917,
        'DEFICIENCIA VISUAL'
    ),
    (
        12345678918,
        'DEFICIENCIA AUDITIVA'
    ),
    (
        12345678919,
        'AUTISMO'
    ),
    (
        12345678921,
        'NANISMO'
    );

-- Tabela AVALIAÇÃO do restaurante
INSERT INTO avaliacao
    VALUES
    (
        12345678916, -- turista (FK)(PK)
        12345678912, -- restaurante (FK)(PK)
        5 -- nota
    ),
    (
        12345678918,
        12345678912,
        1
    ),
    (
        12345678920,
        12345678913,
        4.5
    ),
    (
        12345678917,
        12345678913,
        4.7
    ),
    (
        12345678918,
        12345678913,
        4.8
    ),
    (
        12345678920,
        12345678914,
        4
    ),
    (
        12345678917,
        12345678914,
        3
    ),
    (
        12345678918,
        12345678914,
        1.5
    );

-- Tabela HOSPEDAGEM
INSERT INTO hospedagem
    VALUES 
    (
        12345678918, -- turista (FK)(PK)
        12345678914, -- hotel (FK)(PK)
        3, -- número do quarto (FK)(PK)
        '[2021-05-06 13:00, 2021-05-07 10:00)' -- duração (PK)

    ),
    (
        12345678917, 
        12345678914, 
        3, 
        '[2021-05-06 13:00, 2021-05-07 10:00)' 

    ),
    (
        12345678917,
        12345678915,
        2,
        '[2021-05-20 13:00, 2021-05-23 10:30)'
    ),
    (
        12345678918,
        12345678915,
        1,
        '[2021-05-10 13:00, 2021-05-22 10:30)'
    ),
    (
        12345678916,
        12345678915,
        1,
        '[2021-05-10 13:00, 2021-05-22 09:30)'
    ),
    (
        12345678923,
        12345678916,
        1,
        '[2021-05-30 18:00, 2021-06-30 18:00)'
    );

-- Tabela GRUPO de TURISTAS
INSERT INTO grupo_turistas
    VALUES
    (
        12345678919, -- administrador (FK)(PK)
        'GRUPO DO FRED' -- nome (FK)(PK)
    ),
    (
        12345678916,
        'GRUPO DO DIOGO'
    ),
    (
        12345678923,
        'GRUPO DO EUGENIO'
    );

-- Tabela PARTICIPACAO de um turista em um grupo
-- OBS: Aqui é necessário adicionar o administrador do grupo como participante também. -- Trigger
INSERT INTO participacao
    VALUES
    (
        12345678918, -- turista (FK)(PK)
        12345678919, -- administrador do grupo (FK)(PK)
        'GRUPO DO FRED' -- grupo (FK)(PK)
    ),
    (
        12345678923,
        12345678916,
        'GRUPO DO DIOGO'
    ),
    (
        12345678917,
        12345678916,
        'GRUPO DO DIOGO'
    ),
    (
        12345678918,
        12345678916,
        'GRUPO DO DIOGO'
    ),
    (
        12345678920,
        12345678923,
        'GRUPO DO EUGENIO'
    ),
    (
        12345678921,
        12345678923,
        'GRUPO DO EUGENIO'
    ),
    (
        12345678922,
        12345678923,
        'GRUPO DO EUGENIO'
    );

-- Tabela VIAGEM
INSERT INTO viagem
    VALUES
    (
        12345678919, -- administrador do grupo (FK)(PK)
        'GRUPO DO FRED', -- grupo (FK)(PK)
        '2021-03-10' , '2021-05-20', -- duração (PK)
        'BRASIL', -- origem
        'ANGOLA' -- destino
    ),
    (
        12345678916,
        'GRUPO DO DIOGO',
        '2021-12-01', '2021-12-31',
        'ITALIA',
        'ARGENTINA'
        
    ),
    (
        12345678916,
        'GRUPO DO DIOGO',
        '2021-11-13', '2021-11-20',
        'JAPAO',
        'ARGENTINA'
    ),
    (
        12345678923,
        'GRUPO DO EUGENIO',
        '2021-05-30', '2021-06-30',
        'BRASIL',
        'ITALIA'
    );

-- Tabela PASSEIO
INSERT INTO passeio
    VALUES
    (
        DEFAULT, -- id (PK)
        '2021-05-19', -- data (PK)
        12345678919, -- administrador do grupo (FK)(PK)
        'GRUPO DO FRED', -- grupo (FK)(PK)
        12345678910, -- parque (FK)(PK)
        'MARIA', -- nome do guia
        120 -- preço do guia
    ),
    (
        DEFAULT,
        '2021-11-17',
        12345678916,
        'GRUPO DO DIOGO',
        12345678911,
        'NATALIA',
        60
    ),
    (
        DEFAULT,
        '2021-06-15',
        12345678923,
        'GRUPO DO EUGENIO',
        12345678913,
        'ESMERINDO',
        5
    );

-- Tabela IDIOMAS do GUIA
INSERT INTO idiomas_guia
    VALUES 
    (
        1,  -- passeio (FK)(PK)
        'FRANCES' -- idioma (PK)
    ),
    (
        1,
        'INGLES'
    ),
    (
        2,
        'ESPANHOL'
    ),
    (
        3,
        'PORTUGUES'
    ),
    (
        3,
        'SUECO'
    );

-- Tabela ATRAÇÃO
INSERT INTO atracao
    VALUES
    (
        12345678910, -- parque (FK)(PK)
        'RODA GIGANTE', -- atração (PK)
        FALSE, -- tipo (reservada ou não)
        40  -- capacidade
    ),
    (
        12345678910,
        'MONTANHA RUSSA',
        FALSE,
        50
    ),
    (
        12345678910,
        'CINEMA',
        TRUE,
        100
    ),
    (
        12345678911,
        'TEATRO',
        TRUE,
        50
    ),
    (
        12345678911,
        'TEATRO INFANTIL',
        TRUE,
        35
    ),
    (
        12345678913,
        'BATE-BATE',
        TRUE,
        20
    ),
    (
        12345678913,
        'APRESENTACAO',
        TRUE,
        100
    ),
    (
        12345678913,
        'CAMINHAO MONSTRO',
        TRUE,
        500
    );

-- Tabela EVENTO
INSERT INTO evento
    VALUES
    (
        1, -- passeio (FK)(PK)
        12345678910, -- parque (FK)(PK)
        'CINEMA', -- atração (FK)(PK)
        '123456'  -- ingresso
    ),
    (
        2,
        12345678911,
        'TEATRO',
        '123457'
    ),
    (
        3,
        12345678913,
        'BATE-BATE',
        '114153'
    ),
    (
        3,
        12345678913,
        'APRESENTACAO',
        '987654'
    ),
    (
        3,
        12345678913,
        'CAMINHAO MONSTRO',
        '314159'
    );

-- Tabela RESTRIÇÕES da ATRAÇÃO
INSERT INTO restricoes_atracao
    VALUES
    (
        12345678910, -- parque (FK)(PK)
        'RODA GIGANTE', -- atração (FK)(PK)
        'IDADE MINIMA 13' -- restrição (PK)
    ),
    (
        12345678910,
        'MONTANHA RUSSA',
        'ALTURA MINIMA 140'
    ),
    (
        12345678911,
        'TEATRO',
        'OBRIGATORIO CAMISA'
    ),
    (
        12345678913,
        'BATE-BATE',
        'IDADE MAXIMA 20'
    ),
    (
        12345678913,
        'CAMINHAO MONSTRO',
        'IDADE MINIMA 18'
    );
