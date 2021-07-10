-- Insercao de dados em PAIS

INSERT INTO pais(nome_pais)
    VALUES ('Argentina'),
    VALUES ('Angola');


-- Insercao de dados em PARQUE TEMATICO

INSERT INTO parque_tematico
    VALUES(
        12345678911, 
        SELECT nome_pais FROM pais WHERE nome_pais='Argentina',
        'Parque Diogo'
        'Buenos Aires',
        150.0,
        700,
        '08:00-12:00 13:30-22:00',
        '09:00-12:00',
        '09:00-12:00',
        '09:00-12:00',
        '09:00-12:00',
        '09:00-12:00',
        '08:00-12:00 13:30-22:00'
        ),
    VALUES(
        12345678910, 
        SELECT nome_pais FROM pais WHERE nome_pais='Angola',
        'Parque Madu'
        'Buenos Aires',
        99.99,
        NULL,
        '08:00-12:00 13:30-22:00',
        '09:00-12:00',
        '09:00-12:00',
        '09:00-12:00',
        '09:00-12:00',
        '09:00-12:00',
        '08:00-12:00 13:30-22:00'
        );

    



