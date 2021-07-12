DROP DATABASE IF EXISTS turismo_bd;

-- Criando database
CREATE DATABASE turismo_bd;

-- Conectando
\c turismo_bd;

-- Criando tabela do País
CREATE TABLE pais(
	nome_pais VARCHAR(30) PRIMARY KEY
);

-- Criando tabela do Parque Temático
CREATE TABLE parque_tematico(
	documento NUMERIC(11, 0) PRIMARY KEY CHECK (documento>0),
	pais VARCHAR(30) NOT NULL,
	nome VARCHAR(30) NOT NULL,
	preco NUMERIC(5, 2) CHECK (preco > 0),
	lotacao_maxima INTEGER CHECK(lotacao_maximo > 0),
	dom_inicio 	TIME,
	dom_fim 	TIME,
	seg_inicio 	TIME,
	seg_fim 	TIME,
	ter_inicio 	TIME,
	ter_fim 	TIME,
	qua_inicio	TIME,
	qua_fim 	TIME,
	qui_inicio 	TIME,
	qui_fim 	TIME,
	sex_inicio 	TIME,
	sex_fim 	TIME,
	sab_inicio 	TIME,
	sab_fim 	TIME,
	CONSTRAINT fk_pais FOREIGN KEY(pais) REFERENCES pais(nome_pais) ON DELETE SET NULL,
	-- Check de horario
	CONSTRAINT valid_dom CHECK (dom_inicio < dom_fim), 
	CONSTRAINT valid_seg CHECK (seg_inicio < seg_fim),
	CONSTRAINT valid_ter CHECK (ter_inicio < ter_fim),
	CONSTRAINT valid_qua CHECK (qua_inicio < qua_fim),
	CONSTRAINT valid_qui CHECK (qui_inicio < qui_fim),
	CONSTRAINT valid_sex CHECK (sex_inicio < sex_fim),
	CONSTRAINT valid_sab CHECK (sab_inicio < sab_fim)
);

-- Criando tabela do Restaurante
CREATE TABLE restaurante(
	documento NUMERIC(11, 0) PRIMARY KEY CHECK(documento > 0),
	parque NUMERIC(11, 0) NOT NULL,
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento), 
	nome VARCHAR(255),
	faixa_preco VARCHAR(255),
	dom_inicio 	TIME,
	dom_fim 	TIME,
	seg_inicio 	TIME,
	seg_fim 	TIME,
	ter_inicio 	TIME,
	ter_fim 	TIME,
	qua_inicio	TIME,
	qua_fim 	TIME,
	qui_inicio 	TIME,
	qui_fim 	TIME,
	sex_inicio 	TIME,
	sex_fim 	TIME,
	sab_inicio 	TIME,
	sab_fim 	TIME,
	-- check de horario
	CONSTRAINT valid_dom CHECK (dom_inicio < dom_fim),
	CONSTRAINT valid_seg CHECK (seg_inicio < seg_fim),
	CONSTRAINT valid_ter CHECK (ter_inicio < ter_fim),
	CONSTRAINT valid_qua CHECK (qua_inicio < qua_fim),
	CONSTRAINT valid_qui CHECK (qui_inicio < qui_fim),
	CONSTRAINT valid_sex CHECK (sex_inicio < sex_fim),
	CONSTRAINT valid_sab CHECK (sab_inicio < sab_fim)
);

-- Criando tabela dos tipos de cozinha de um restaurante 
CREATE TABLE cozinha(
	restaurante NUMERIC(11, 0),
	CONSTRAINT fk_rest FOREIGN KEY(restaurante) REFERENCES restaurante(documento), 
	tipo_cozinha VARCHAR(30),
	CONSTRAINT pk_cozinha PRIMARY KEY(restaurante, tipo_cozinha)
);

-- Criando tabela do Hotel
CREATE TABLE hotel(
	documento NUMERIC(11, 0) PRIMARY KEY,
	parque NUMERIC(11, 0) NOT NULL,
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento),
	nome VARCHAR(30),
	total_quartos INTEGER CHECK (total_quartos > 0), -- total de quartos nao pode ser negativo
	total_vagas INTEGER CHECK (total_quartos <= total_vagas), --sempre ha, no minimo, uma vaga, ocupada ou não, para cada quarto
	quartos_livres INTEGER, -- ATRIBUTO DERIVADO
	vagas_livres INTEGER -- ATRIBUTO DERIVADO
);

-- Criando tabela dos serviços do hotel
CREATE TABLE servico_hotel(
	hotel NUMERIC(11, 0),
	CONSTRAINT fk_hotel FOREIGN KEY(hotel) REFERENCES hotel(documento),
	servico VARCHAR(30),
	CONSTRAINT pk_servico_hotel PRIMARY KEY(hotel, servico)
);

-- Criando tabela do Quarto
CREATE TABLE quarto(
	hotel NUMERIC(11, 0),
	CONSTRAINT fk_hotel FOREIGN KEY(hotel) REFERENCES hotel(documento),
	numero INTEGER CHECK(numero > 0), --O numero do quarto não pode ser 0 ou negativo 
	CONSTRAINT pk_quarto PRIMARY KEY(hotel, numero)
);

-- Criando tabela do Turista
CREATE TABLE turista(
	passaporte NUMERIC(11, 0) PRIMARY KEY CHECK(passaporte > 0),
	nome VARCHAR(30) NOT NULL,
	data_nascimento DATE NOT NULL, -- tipo DATE
	telefone VARCHAR(20),
	hotel NUMERIC(11, 0),
	quarto INTEGER,
	CONSTRAINT fk_quarto FOREIGN KEY(hotel, quarto) REFERENCES quarto(hotel, numero)
);

-- Criando tabela de Restrições Alimentares do Turista
CREATE TABLE restricoes_alimentares(
	turista NUMERIC(11, 0),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte),
	restricao VARCHAR(30),
	CONSTRAINT pk_restricoes_alimentares PRIMARY KEY(turista, restricao)
);


-- Criando tabela de Necessidades Especiais do Turista
CREATE TABLE necessidades_especiais(
	turista NUMERIC(11, 0),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte),
	necessidade VARCHAR(30),
	CONSTRAINT pk_necessidades_especiais PRIMARY KEY(turista, necessidade)
);


-- Criando tabela da Avaliação
CREATE TABLE avaliacao(
	turista NUMERIC(11, 0),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte),
	restaurante NUMERIC(11, 0),
	CONSTRAINT fk_restaurante FOREIGN KEY(restaurante) REFERENCES restaurante(documento),
	nota NUMERIC(1, 1) NOT NULL CHECK (nota>=0 and nota <= 5),
	CONSTRAINT pk_avaliacao PRIMARY KEY(turista, restaurante)
);

-- Criando tabela da Hospedagem 
CREATE TABLE hospedagem(
	turista NUMERIC(11, 0),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte),
	checkin TIMESTAMP,
	checkout TIMESTAMP,
	CONSTRAINT valid_hospedagem_timestamp CHECK (checkin < checkout)
	CONSTRAINT pk_hospedagem PRIMARY KEY(turista, checkin, checkout)
);

-- Criando tabela do Grupo de Turistas 
CREATE TABLE grupo_turistas(
	admin NUMERIC(11, 0),
	CONSTRAINT fk_admin FOREIGN KEY(admin) REFERENCES turista(passaporte),
	nome_grupo VARCHAR(30),
	quantidade INTEGER CHECK (quantidade > 0) --- !Atributo derivado
	CONSTRAINT pk_grupo_turistas PRIMARY KEY(admin, nome_grupo)
);

-- Criando tabela de Participação
CREATE TABLE participacao(
	turista NUMERIC(11, 0),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte),
	admin_grupo NUMERIC(11, 0),
	nome_grupo VARCHAR(30),
	CONSTRAINT fk_grupo FOREIGN KEY(admin_grupo, nome_grupo) REFERENCES grupo_turistas(admin, nome_grupo),
	CONSTRAINT pk_participacao PRIMARY KEY(turista, admin_grupo, nome_grupo)
);


-- Criando tabela da Viagem
CREATE TABLE viagem(
	admin_grupo NUMERIC(11, 0),
	nome_grupo VARCHAR(255),
	CONSTRAINT fk_grupo FOREIGN KEY(admin_grupo, nome_grupo) REFERENCES grupo_turistas(admin, nome_grupo),
	data_partida TIMESTAMP,
	data_chegada TIMESTAMP,
	pais_origem VARCHAR(30) NOT NULL,
	CONSTRAINT fk_pais_origem FOREIGN KEY(pais_origem) REFERENCES pais(nome_pais),
	pais_destino VARCHAR(30) NOT NULL,
	CONSTRAINT fk_pais_destino FOREIGN KEY(pais_destino) REFERENCES pais(nome_pais), 
	duracao INTEGER, --Atributo derivado
	CONSTRAINT pk_viagem PRIMARY KEY(admin_grupo, nome_grupo, data_partida, data_chegada)
);

-- Criando tabela do Passeio
CREATE TABLE passeio(
	id SERIAL PRIMARY KEY,
	data DATE UNIQUE, 
	admin_grupo NUMERIC(11, 0), 
	nome_grupo VARCHAR(30),
	CONSTRAINT un_grupo UNIQUE (admin_grupo, nome_grupo),
	CONSTRAINT fk_grupo FOREIGN KEY(admin_grupo, nome_grupo) REFERENCES grupo_turistas(admin, nome_grupo),
	parque NUMERIC(11, 0) UNIQUE,
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento),
	nome_guia VARCHAR(30),
	preco_guia NUMERIC(5, 2) CHECK (preco_guia >=0 ) -- preco-guia tem que ser no minimo 0
);

-- Criando tabela dos idiomas do(a) guia
CREATE TABLE idiomas_guia(
	passeio INTEGER,
	CONSTRAINT fk_passeio FOREIGN KEY(passeio) REFERENCES passeio(id),
	idioma VARCHAR(50),
	CONSTRAINT pk_idiomas_guia PRIMARY KEY(passeio, idioma)
);

-- Criando tabela da Atração
CREATE TABLE atracao(
	parque NUMERIC(11, 0),
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento),
	nome VARCHAR(30),
	tipo VARCHAR(30),
	-- tem que ter disponibilidade aqui, mas n sei oq significa
	capacidade INTEGER CHECK (capacidade > 0), -- capacidade precisa ser positiva
	CONSTRAINT pk_atracao PRIMARY KEY(parque, nome)
);

-- Criando tabela do Evento
CREATE TABLE evento(
	passeio INTEGER,
	CONSTRAINT fk_passeio FOREIGN KEY(passeio) REFERENCES passeio(id),
	parque_atracao NUMERIC(11, 0),
	nome_atracao VARCHAR(30),
	CONSTRAINT fk_atracao FOREIGN KEY(parque_atracao, nome_atracao) REFERENCES atracao(parque, nome), 
	ingresso CHAR (25) NOT NULL, -- ingresso vai ser uma string com seu id
	CONSTRAINT pk_evento PRIMARY KEY(passeio, parque_atracao, nome_atracao)
);
		
-- Criando tabela das Restrições das Atrações
CREATE TABLE restricoes_atracao(
	parque_atracao NUMERIC(11, 0),
	nome_atracao VARCHAR(30),
	CONSTRAINT fk_atracao FOREIGN KEY(parque_atracao, nome_atracao) REFERENCES atracao(parque, nome),
    restricao VARCHAR(30), -- ajeitar no MR
	CONSTRAINT pk_restricoes_atracao PRIMARY KEY(parque_atracao, nome_atracao, restricao)
);


