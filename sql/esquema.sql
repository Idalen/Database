-- Deletando database se este já existir
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
	documento NUMERIC(11, 0) PRIMARY KEY CHECK (documento > 0),
	pais VARCHAR(30) NOT NULL,
	nome VARCHAR(30) NOT NULL,
	preco NUMERIC(6, 2) CHECK (preco > 0),
	lotacao_maxima INTEGER CHECK(lotacao_maxima > 0),
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
	-- Check de range de horário de funcionamento
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
	nome VARCHAR(255),
	faixa_preco NUMRANGE,
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
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento) ON DELETE CASCADE, 
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
	tipo_cozinha VARCHAR(30),
	CONSTRAINT fk_rest FOREIGN KEY(restaurante) REFERENCES restaurante(documento) ON DELETE CASCADE, 
	CONSTRAINT pk_cozinha PRIMARY KEY(restaurante, tipo_cozinha)
);

-- Criando tabela do Hotel
CREATE TABLE hotel(
	documento NUMERIC(11, 0) PRIMARY KEY,
	parque NUMERIC(11, 0) NOT NULL,
	nome VARCHAR(30),
	total_quartos INTEGER DEFAULT 0 CHECK (total_quartos >= 0), -- total de quartos nao pode ser negativo
	total_vagas INTEGER DEFAULT 0 CHECK (total_quartos <= total_vagas), --sempre ha, no minimo, uma vaga, ocupada ou não, para cada quarto
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento) ON DELETE CASCADE
);

-- Criando tabela dos serviços do hotel
CREATE TABLE servico_hotel(
	hotel NUMERIC(11, 0),
	servico VARCHAR(30),
	CONSTRAINT fk_hotel FOREIGN KEY(hotel) REFERENCES hotel(documento) ON DELETE CASCADE,
	CONSTRAINT pk_servico_hotel PRIMARY KEY(hotel, servico)
);

-- Criando tabela do Quarto
CREATE TABLE quarto(
	hotel NUMERIC(11, 0),
	numero INTEGER CHECK(numero > 0), --O numero do quarto não pode ser 0 ou negativo 
	vagas INTEGER CHECK(vagas > 0),
	diaria NUMERIC(7, 2) CHECK(diaria >= 0),
	CONSTRAINT fk_hotel FOREIGN KEY(hotel) REFERENCES hotel(documento) ON DELETE CASCADE,
	CONSTRAINT pk_quarto PRIMARY KEY(hotel, numero)
);

-- Criando tabela do Turista
CREATE TABLE turista(
	passaporte NUMERIC(11, 0) PRIMARY KEY CHECK(passaporte > 0),
	nome VARCHAR(30) NOT NULL,
	data_nascimento DATE NOT NULL, -- tipo DATE
	telefone VARCHAR(20)
);

-- Criando tabela de Restrições Alimentares do Turista
CREATE TABLE restricoes_alimentares(
	turista NUMERIC(11, 0),
	restricao VARCHAR(30),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte) ON DELETE CASCADE,
	CONSTRAINT pk_restricoes_alimentares PRIMARY KEY(turista, restricao)
);

-- Criando tabela de Necessidades Especiais do Turista
CREATE TABLE necessidades_especiais(
	turista NUMERIC(11, 0),
	necessidade VARCHAR(30),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte) ON DELETE CASCADE,
	CONSTRAINT pk_necessidades_especiais PRIMARY KEY(turista, necessidade)
);

-- Criando tabela da Avaliação
CREATE TABLE avaliacao(
	turista NUMERIC(11, 0),
	restaurante NUMERIC(11, 0),
	nota NUMERIC(2, 1) NOT NULL CHECK (nota>=0 and nota <= 5),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte) ON DELETE CASCADE,
	CONSTRAINT fk_restaurante FOREIGN KEY(restaurante) REFERENCES restaurante(documento) ON DELETE CASCADE,
	CONSTRAINT pk_avaliacao PRIMARY KEY(turista, restaurante)
);

-- Criando tabela da Hospedagem 
CREATE TABLE hospedagem(
	turista NUMERIC(11, 0),
	hotel NUMERIC(11, 0),
	quarto INTEGER,
	duracao TSRANGE,
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte) ON DELETE CASCADE,
	CONSTRAINT fk_quarto FOREIGN KEY(quarto, hotel) REFERENCES quarto(numero, hotel) ON DELETE CASCADE,
	CONSTRAINT pk_hospedagem PRIMARY KEY(turista, quarto, hotel, duracao)
);

-- Criando tabela do Grupo de Turistas 
CREATE TABLE grupo_turistas(
	admin NUMERIC(11, 0),
	nome_grupo VARCHAR(30),
	CONSTRAINT fk_admin FOREIGN KEY(admin) REFERENCES turista(passaporte) ON DELETE CASCADE,
	CONSTRAINT pk_grupo_turistas PRIMARY KEY(admin, nome_grupo)
);

-- Criando tabela de Participação
CREATE TABLE participacao(
	turista NUMERIC(11, 0),
	admin_grupo NUMERIC(11, 0),
	nome_grupo VARCHAR(30),
	CONSTRAINT fk_turista FOREIGN KEY(turista) REFERENCES turista(passaporte) ON DELETE CASCADE,
	CONSTRAINT fk_grupo FOREIGN KEY(admin_grupo, nome_grupo) REFERENCES grupo_turistas(admin, nome_grupo) ON DELETE CASCADE,
	CONSTRAINT pk_participacao PRIMARY KEY(turista, admin_grupo, nome_grupo)
);

-- Criando tabela da Viagem
CREATE TABLE viagem(
	admin_grupo NUMERIC(11, 0),
	nome_grupo VARCHAR(255),
	data_inicio DATE,
	data_fim DATE,
	pais_origem VARCHAR(30) NOT NULL,
	pais_destino VARCHAR(30) NOT NULL,
	CONSTRAINT check_data CHECK (data_inicio < data_fim),
	CONSTRAINT fk_grupo FOREIGN KEY(admin_grupo, nome_grupo) REFERENCES grupo_turistas(admin, nome_grupo) ON DELETE CASCADE,
	CONSTRAINT fk_pais_origem FOREIGN KEY(pais_origem) REFERENCES pais(nome_pais) ON DELETE CASCADE,
	CONSTRAINT fk_pais_destino FOREIGN KEY(pais_destino) REFERENCES pais(nome_pais) ON DELETE CASCADE, 
	CONSTRAINT pk_viagem PRIMARY KEY(admin_grupo, nome_grupo, data_inicio, data_fim)
);

-- Criando tabela do Passeio
CREATE TABLE passeio(
	id SERIAL PRIMARY KEY,
	data DATE, 
	admin_grupo NUMERIC(11, 0), 
	nome_grupo VARCHAR(30),
	parque NUMERIC(11, 0),
	nome_guia VARCHAR(30),
	preco_guia NUMERIC(5, 2) CHECK (preco_guia >=0 ), -- preco-guia tem que ser no minimo 0CONSTRAINT un_grupo UNIQUE (admin_grupo, nome_grupo),
	CONSTRAINT fk_grupo FOREIGN KEY(admin_grupo, nome_grupo) REFERENCES grupo_turistas(admin, nome_grupo) ON DELETE CASCADE,
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento) ON DELETE CASCADE,
	CONSTRAINT un_passeio UNIQUE(data, admin_grupo, nome_grupo, parque)
);

-- Criando tabela dos idiomas do(a) guia
CREATE TABLE idiomas_guia(
	passeio INTEGER,
	idioma VARCHAR(50),
	CONSTRAINT fk_passeio FOREIGN KEY(passeio) REFERENCES passeio(id) ON DELETE CASCADE,
	CONSTRAINT pk_idiomas_guia PRIMARY KEY(passeio, idioma)
);

-- Criando tabela da Atração
CREATE TABLE atracao(
	parque NUMERIC(11, 0),
	nome VARCHAR(30),
	tipo VARCHAR(30),
	capacidade INTEGER CHECK (capacidade > 0), -- capacidade precisa ser positiva
	CONSTRAINT fk_parque FOREIGN KEY(parque) REFERENCES parque_tematico(documento) ON DELETE CASCADE,
	CONSTRAINT pk_atracao PRIMARY KEY(parque, nome)
);

-- Criando tabela do Evento
CREATE TABLE evento(
	passeio INTEGER,
	parque_atracao NUMERIC(11, 0),
	nome_atracao VARCHAR(30),
	ingresso CHAR (25) NOT NULL, -- ingresso vai ser uma string com seu id
	CONSTRAINT fk_passeio FOREIGN KEY(passeio) REFERENCES passeio(id) ON DELETE CASCADE,
	CONSTRAINT fk_atracao FOREIGN KEY(parque_atracao, nome_atracao) REFERENCES atracao(parque, nome) ON DELETE CASCADE, 
	CONSTRAINT pk_evento PRIMARY KEY(passeio, parque_atracao, nome_atracao)
);
		
-- Criando tabela das Restrições das Atrações
CREATE TABLE restricoes_atracao(
	parque_atracao NUMERIC(11, 0),
	nome_atracao VARCHAR(30),
	restricao VARCHAR(30), -- ajeitar no MR
	CONSTRAINT fk_atracao FOREIGN KEY(parque_atracao, nome_atracao) REFERENCES atracao(parque, nome) ON DELETE CASCADE,
    CONSTRAINT pk_restricoes_atracao PRIMARY KEY(parque_atracao, nome_atracao, restricao)
);

CREATE FUNCTION update_hotel() RETURNS trigger AS
$BODY$
BEGIN
  UPDATE hotel
  SET total_quartos = total_quartos + 1, total_vagas = total_vagas+NEW.vagas
  WHERE documento = NEW.hotel;
  RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_hotel_after_insert
AFTER INSERT 
ON quarto
FOR EACH ROW
EXECUTE PROCEDURE update_hotel();

CREATE FUNCTION check_duration() RETURNS TRIGGER AS
$BODY$
DECLARE
	d record;
BEGIN
  	for d in select * from viagem where admin_grupo = NEW.admin_grupo AND nome_grupo = NEW.nome_grupo
  	loop
	if NEW.data NOT BETWEEN d.data_inicio AND d.data_fim then 
		raise exception 'Passeio não ocorre no período da viagem';
	end if;
  	end loop;
  	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_duration_trigger
BEFORE INSERT 
ON passeio
FOR EACH ROW
EXECUTE PROCEDURE check_duration();

-- TRIGGER: criação do grupo, administrador é adicionado automaticamente.
CREATE FUNCTION add_admin_as_participant() RETURNS trigger AS
$BODY$
DECLARE
	d record;
BEGIN
	INSERT INTO participacao
		VALUES(NEW.admin, NEW.admin, NEW.nome_grupo);
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER add_admin_as_participant_trigger
AFTER INSERT
ON grupo_turistas
FOR EACH ROW
EXECUTE PROCEDURE add_admin_as_participant();

CREATE FUNCTION check_viagem_overlapping() RETURNS trigger AS
$BODY$
DECLARE
	d record;
BEGIN
	FOR d IN SELECT data_inicio, data_fim FROM viagem 
	WHERE admin_grupo = NEW.admin_grupo AND nome_grupo = NEW.nome_grupo
  	LOOP
	IF ((NEW.data_inicio < d.data_fim) AND (NEW.data_fim > d.data_inicio)) THEN 
			raise exception 'Existe uma viagem marcada neste período';
	END IF;
  	END LOOP;
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER viagem_overlapping
BEFORE INSERT
ON viagem
FOR EACH ROW
EXECUTE PROCEDURE check_viagem_overlapping();

CREATE FUNCTION check_evento_consistency() RETURNS trigger AS
$BODY$
DECLARE
	parque_passeio NUMERIC(11, 0);
BEGIN
	SELECT parque FROM passeio WHERE NEW.passeio = id INTO parque_passeio;
	IF parque_passeio != NEW.parque_atracao THEN
		raise exception 'Passeio em parque diferente que atracao em um evento';
	END IF;
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER evento_consistency
BEFORE INSERT
ON evento
FOR EACH ROW
EXECUTE PROCEDURE check_evento_consistency();

CREATE FUNCTION check_quarto_capacity() RETURNS trigger AS
$BODY$
DECLARE
	qtde INTEGER;
	capacidade INTEGER;
BEGIN
	SELECT COUNT(quarto) FROM hospedagem WHERE quarto = NEW.quarto AND hotel = NEW.hotel INTO qtde;
	SELECT vagas FROM quarto WHERE numero = NEW.quarto AND hotel = NEW.hotel into capacidade;
	IF qtde = capacidade THEN
		raise exception 'O quarto está cheio';
	END IF; 	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER quarto_capacity
BEFORE INSERT
ON hospedagem
FOR EACH ROW
EXECUTE PROCEDURE check_quarto_capacity();

CREATE FUNCTION update_hotel_after_delete() RETURNS trigger AS
$BODY$
BEGIN
  UPDATE hotel
  SET total_quartos = total_quartos - 1, total_vagas = total_vagas-OLD.vagas
  WHERE documento = NEW.hotel;
  RETURN OLD;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER hotel_after_delete
AFTER DELETE
ON quarto
FOR EACH ROW
EXECUTE PROCEDURE update_hotel_after_delete();
