-- SQL DDL commands for the database structured mandated by the Technical
-- Paper on portuguese Plano Director Municipal
-- This file assumes a Spatialite database will be created

-- for each table, be sure to include:
-- proper comments
-- * creation of indexes
-- * creatio of spatial columns
-- * appropriate triggers
-- * appropriate restrictions

-- TODO
-- Adicionar constraints do tipo CHECK para garantir que o formato dos campos
-- que representam datas corresponde ao formato esperado

--
-- Comandos relativos a criacao da tabela TABELA_IS_PO
--

DROP TABLE IF EXISTS 'TABELA_IS_PO';

CREATE TABLE 'TABELA_IS_PO' (
    -- Tabela que representa os indices sequenciais da Planta de Ordenamento

    'INDICE_SEQUENCIAL_PO' INTEGER PRIMARY KEY,
    'TEMA' TEXT NOT NULL,
    'SUBTEMA' TEXT,
    'DESIGNACAO' TEXT
);

--
-- Comandos relativos a criacao da tabela TABELA_IS_PC
--

DROP TABLE IF EXISTS 'TABELA_IS_PC';

CREATE TABLE 'TABELA_IS_PC' (
    -- Tabela que representa os indices sequenciais da Planta de Condicionantes

    'INDICE_SEQUENCIAL_PC' INTEGER PRIMARY KEY,
    'TEMA' TEXT NOT NULL,
    'SUBTEMA' TEXT,
    'DESIGNACAO' TEXT
);

--
-- Comandos relativos a criacao da tabela TABELA_DESACTIVO
--

DROP TABLE IF EXISTS 'TABELA_DESACTIVO';

CREATE TABLE 'TABELA_DESACTIVO' (
    -- Tabela que representa ???

    'IDENTIFICADOR' INTEGER NOT NULL,
    'DTCC' TEXT,
    'DINAMICA_ACTO_PDM' TEXT,
    'DIPLOMA_ACTO_PDM' TEXT,
    'DATA_ACTO_PDM' TEXT,
    'OBSERVACOES' TEXT,

    CONSTRAINT 'pk_td'
        PRIMARY KEY ('IDENTIFICADOR'),
    CONSTRAINT 'check_din'
        CHECK ('DINAMICA_ACTO_PDM' IN ('Alteracao', 'Alteracao por adaptacao',
                                       'Alteracao simplificada', 
                                       'Correcao material', 'Rectificacao'))

);

--
-- Comandos relativos a criacao da tabela TABELA_ESPECIFICACAO
--

DROP TABLE IF EXISTS 'TABELA_ESPECIFICACAO';

CREATE TABLE 'TABELA_ESPECIFICACAO' (
    -- Tabela que representa ???

    'IDENTIFICADOR' INTEGER NOT NULL,
    'DTCC' TEXT,
    'ESPECIFICACAO_PARTICULAR_PO' TEXT,
    'ETIQUETA_PO' TEXT,
    'ESPECIFICACAO_PARTICULAR_PC' TEXT,
    'ETIQUETA_PC' TEXT,
    'OBSERVACOES' TEXT,

    CONSTRAINT 'pk_te'
        PRIMARY KEY ('IDENTIFICADOR')
);

--
-- Comandos relativos a criacao da tabela TABELA_LEGISLACAO_ASSOCIADA
--

DROP TABLE IF EXISTS 'TABELA_LEGISLACAO_ASSOCIADA';

CREATE TABLE 'TABELA_LEGISLACAO_ASSOCIADA' (
    -- Tabela que representa ???

    'IDENTIFICADOR' INTEGER NOT NULL,
    'DTCC' TEXT,
    'DIPLOMA_ESPECIFICO' TEXT NOT NULL,
    'OBSERVACOES' TEXT,

    CONSTRAINT 'pk_te'
        PRIMARY KEY ('IDENTIFICADOR')
);

--
-- Comandos relativos a criacao da tabela TABELA_OBJECTO_AREA
--

DROP TABLE IF EXISTS 'TABELA_OBJECTO_AREA';

CREATE TABLE 'TABELA_OBJECTO_AREA' (
    -- Tabela que representa os objectos com geometria poligonal
    --
    -- Notas:
    -- * Em sqlite nao existe um tipo explicito para datas, por isso
    --   definimos o atributo DATA_INFORMACAO com o tipo TEXT e depois,
    --   ao inserir valores, temos de os formatar correctamente

   'IDENTIFICADOR' INTEGER NOT NULL, -- identificador da entidade
   'DTCC' TEXT, -- codigo de identificacao de distrito e concelho
   'PLANTA_PO' BOOLEAN NOT NULL, -- indica se esta entidade esta presente na planta de ordenamento
   'INDICE_SEQUENCIAL_PO' INTEGER,
   'TEMA_PO' TEXT,
   'SUBTEMA_PO' TEXT,
   'DESIGANCAO_PO' TEXT,
   'PLANTA_PC' BOOLEAN NOT NULL,
   'INDICE_SEQUENCIAL_PC' INTEGER,
   'TEMA_PC' TEXT,
   'SUBTEMA_PC' TEXT,
   'DESIGNACAO_PC' TEXT,
   'ORIGEM_INFORMACAO' TEXT NOT NULL,
   'DATA_INFORMACAO' TEXT NOT NULL, -- texto em formato ISO 8601 (YYYY-MM-DD HH:MM:SS)
   'LEGISLACAO_ASSOCIADA' INTEGER,
   'ESPECIFICACAO' INTEGER,
   'DESACTIVO' INTEGER,

    CONSTRAINT 'pk_toa'
        PRIMARY KEY ('IDENTIFICADOR'),
    CONSTRAINT 'check_toa_pk'
        CHECK (1000 <= 'IDENTIFICADOR' <= 9999),
    CONSTRAINT 'fk_toa_tipo'
        FOREIGN KEY ('INDICE_SEQUENCIAL_PO') 
            REFERENCES 'TABELA_IS_PO',
    CONSTRAINT 'fk_toa_tipc'
        FOREIGN KEY ('INDICE_SEQUENCIAL_PC') 
        REFERENCES 'TABELA_IS_PC',
    CONSTRAINT 'fk_toa_tla'
        FOREIGN KEY ('LEGISLACAO_ASSOCIADA') 
        REFERENCES 'TABELA_LEGISLACAO_ASSOCIADA',
    CONSTRAINT 'fk_toa_tesp'
        FOREIGN KEY ('ESPECIFICACAO') 
        REFERENCES 'TABELA_ESPECIFICACAO',
    CONSTRAINT 'fk_toa_tdes'
        FOREIGN KEY ('DESACTIVO') 
        REFERENCES 'TABELA_DESACTIVO'
);

DROP INDEX IF EXISTS 'idx_toa_tipo';

CREATE INDEX 'idx_toa_tipo' ON 'TABELA_OBJECTO_AREA' ('INDICE_SEQUENCIAL_PO');

DROP INDEX IF EXISTS 'idx_toa_tipc';

CREATE INDEX 'idx_toa_tipc' ON 'TABELA_OBJECTO_AREA' ('INDICE_SEQUENCIAL_PC');

DROP INDEX IF EXISTS 'idx_toa_tla';

CREATE INDEX 'idx_toa_tla' ON 'TABELA_OBJECTO_AREA' ('LEGISLACAO_ASSOCIADA');

DROP INDEX IF EXISTS 'idx_toa_tesp';

CREATE INDEX 'idx_toa_tesp' ON 'TABELA_OBJECTO_AREA' ('ESPECIFICACAO');

DROP INDEX IF EXISTS 'idx_toa_tdes';

CREATE INDEX 'idx_toa_tdes' ON 'TABELA_OBJECTO_AREA' ('DESACTIVO');

SELECT AddGeometryColumn('TABELA_OBJECTO_AREA', 'geom', 3763, 'POLYGON', 'XY');

-- Comandos SQL DML para a configuracao initial
-- Estes comandos sao necessarios para garantir que as chaves primarias das
-- tres tabelas principais comecam nos valores especificados na norma
-- Mais info em:
--
-- http://stackoverflow.com/questions/692856/set-start-value-for-autoincrement-in-sqlite

INSERT INTO 'TABELA_OBJECTO_AREA' (
    'IDENTIFICADOR', 'PLANTA_PO', 'PLANTA_PC', 'ORIGEM_INFORMACAO', 
    'DATA_INFORMACAO'
) VALUES (
    999, 0, 0, '', ''
);

DELETE FROM 'TABELA_OBJECTO_AREA' WHERE 'IDENTIFICADOR' = 999;
