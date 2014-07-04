-- SQL DDL commands for the database structured mandated by the Technical
-- Paper on portuguese Plano Director Municipal
-- This file assumes a Spatialite database will be created

-- for each table, be sure to include:
-- proper comments
-- * creation of indexes
-- * creatio of spatial columns
-- * appropriate triggers
-- * appropriate restrictions

--
-- table ObjectoCatalogo
--

DROP TABLE IF EXISTS ObjectoCatalogo;

CREATE TABLE ObjectoCatalogo (

    id INTEGER NOT NULL,
    indice_sequencial INTEGER NOT NULL,
    designacao TEXT NOT NULL,

    CONSTRAINT pk_objcat
        PRIMARY KEY (id)
);

--
-- table TemaOrdenamento
--

DROP TABLE IF EXISTS TemaOrdenamento;

CREATE TABLE TemaOrdenamento (

    id INTEGER NOT NULL,
    designacao TEXT,
    subtema TEXT,

    CONSTRAINT pk_temord
        PRIMARY KEY (id)
);

--
-- table ObjectoCatalogoOrdenamento
--

DROP TABLE IF EXISTS ObjectoCatalogoOrdenamento;

CREATE TABLE ObjectoCatalogoOrdenamento (

    id INTEGER NOT NULL,
    tema INTEGER NOT NULL,

    CONSTRAINT pk_objcatord
        PRIMARY KEY (id),
    CONSTRAINT fk_objcatord_objcat
        FOREIGN KEY (id)
            REFERENCES ObjectoCatalogo
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_objcatord_temord
        FOREIGN KEY (tema)
            REFERENCES TemaOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_objcatord_temord;

CREATE INDEX idx_objcatord_temord ON ObjectoCatalogoOrdenamento (tema);

--
-- table PoligonoObjectoCatalogoOrdenamento
--

DROP TABLE IF EXISTS PoligonoObjectoCatalogoOrdenamento;

CREATE TABLE PoligonoObjectoCatalogoOrdenamento (

    id INTEGER NOT NULL,

    CONSTRAINT pk_polobjcatord
        PRIMARY KEY (id),
    CONSTRAINT fk_polobjcatord_objcatord
        FOREIGN KEY (id)
            REFERENCES ObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

--SELECT AddGeometryColumn('PoligonoObjectoCatalogoOrdenamento', 'geom', 3763, 'POLYGON', 'XY');

--
-- table LinhaObjectoCatalogoOrdenamento
--

DROP TABLE IF EXISTS LinhaObjectoCatalogoOrdenamento;

CREATE TABLE LinhaObjectoCatalogoOrdenamento (

    id INTEGER NOT NULL,

    CONSTRAINT pk_linobjcatord
        PRIMARY KEY (id),
    CONSTRAINT fk_linobjcatord_objcatord
        FOREIGN KEY (id)
            REFERENCES ObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

--SELECT AddGeometryColumn('LinhaObjectoCatalogoOrdenamento', 'geom', 3763, 'LINESTRING', 'XY');

--
-- table PontoObjectoCatalogoOrdenamento
--

DROP TABLE IF EXISTS PontoObjectoCatalogoOrdenamento;

CREATE TABLE PontoObjectoCatalogoOrdenamento (

    id INTEGER NOT NULL,

    CONSTRAINT pk_ponobjcatord
        PRIMARY KEY (id),
    CONSTRAINT fk_ponobjcatord_objcatord
        FOREIGN KEY (id)
            REFERENCES ObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

--SELECT AddGeometryColumn('PontoObjectoCatalogoOrdenamento', 'geom', 3763, 'POINT', 'XY');

--
-- table Entidade
--

DROP TABLE IF EXISTS Entidade;

CREATE TABLE Entidade (
    -- Physical entities being represented in the object catalogue

    id INTEGER NOT NULL,
    dtcc TEXT NOT NULL,
    designacao TEXT,

    CONSTRAINT pk_ent
        PRIMARY KEY (id)
);

--
-- table PlanoDirectorMunicipal
--

DROP TABLE IF EXISTS PlanoDirectorMunicipal;

CREATE TABLE PlanoDirectorMunicipal (

    id INTEGER NOT NULL,
    designacao TEXT,
    publicacao TEXT,
    revisao TEXT,

    CONSTRAINT pk_pdm
        PRIMARY KEY (id),
    CONSTRAINT check_pdm_pub
        CHECK (publicacao == strftime('%Y-%m-%d', publicacao))
);

--
-- table PlantaOrdenamento
--

DROP TABLE IF EXISTS PlantaOrdenamento;

CREATE TABLE PlantaOrdenamento (

    id INTEGER NOT NULL,
    pdm INTEGER,
    publicacao TEXT,
    revisao TEXT,

    CONSTRAINT pk_plord
        PRIMARY KEY (id),
    CONSTRAINT fk_plord_pdm
        FOREIGN KEY (pdm)
            REFERENCES PlanoDirectorMunicipal
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT check_plord_pub
        CHECK (publicacao == strftime('%Y-%m-%d', publicacao))
);

DROP INDEX IF EXISTS idx_plord_pdm;

CREATE INDEX idx_plord_pdm ON PlantaOrdenamento (pdm);

--
-- table EntidadeOrdenamento
--

DROP TABLE IF EXISTS EntidadeOrdenamento;

CREATE TABLE EntidadeOrdenamento (

    id INTEGER NOT NULL,
    planta INTEGER NOT NULL,
    designacao TEXT,
    etiqueta TEXT,

    CONSTRAINT pk_entord
        PRIMARY KEY (id),
    CONSTRAINT fk_entord_ent
        FOREIGN KEY (id)
            REFERENCES Entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_entord_plord
        FOREIGN KEY (planta)
            REFERENCES PlantaOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_entord_plord;

CREATE INDEX idx_entord_plord ON EntidadeOrdenamento (planta);

--
-- table PoligonoEntidadeOrdenamento
--

DROP TABLE IF EXISTS PoligonoEntidadeOrdenamento;

CREATE TABLE PoligonoEntidadeOrdenamento (

    id INTEGER NOT NULL,
    objecto INTEGER NOT NULL,

    CONSTRAINT pk_polentord
        PRIMARY KEY (id),
    CONSTRAINT fk_polentord_entord
        FOREIGN KEY (id)
            REFERENCES EntidadeOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_polentord_polobjcatord
        FOREIGN KEY (objecto)
            REFERENCES PoligonoObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_polentord_polobjcatord;

CREATE INDEX idx_polentord_polobjcatord ON PoligonoEntidadeOrdenamento (objecto);

SELECT AddGeometryColumn('PoligonoEntidadeOrdenamento', 'geom', 3763, 'POLYGON', 'XY');

--
-- table LinhaEntidadeOrdenamento
--

DROP TABLE IF EXISTS LinhaEntidadeOrdenamento;

CREATE TABLE LinhaEntidadeOrdenamento (

    id INTEGER NOT NULL,
    objecto INTEGER NOT NULL,

    CONSTRAINT pk_linentord
        PRIMARY KEY (id),
    CONSTRAINT fk_linentord_entord
        FOREIGN KEY (id)
            REFERENCES EntidadeOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_linentord_linobjcatord
        FOREIGN KEY (objecto)
            REFERENCES LinhaObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_linentord_linobjcatord;

CREATE INDEX idx_linentord_linobjcatord ON LinhaEntidadeOrdenamento (objecto);

SELECT AddGeometryColumn('LinhaEntidadeOrdenamento', 'geom', 3763, 'LINESTRING', 'XY');

--
-- table PontoEntidadeOrdenamento
--

DROP TABLE IF EXISTS PontoEntidadeOrdenamento;

CREATE TABLE PontoEntidadeOrdenamento (

    id INTEGER NOT NULL,
    objecto INTEGER NOT NULL,

    CONSTRAINT pk_ponentord
        PRIMARY KEY (id),
    CONSTRAINT fk_ponentord_entord
        FOREIGN KEY (id)
            REFERENCES EntidadeOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_ponentord_ponobjcatord
        FOREIGN KEY (objecto)
            REFERENCES PontoObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_ponentord_ponobjcatord;

CREATE INDEX idx_ponentord_ponobjcatord ON PontoEntidadeOrdenamento (objecto);

SELECT AddGeometryColumn('PontoEntidadeOrdenamento', 'geom', 3763, 'POINT', 'XY');

-- view EntidadePoligonoOrdenamento

-- view creation
-- registering the geometry column in the views_geometry_columns table
-- creating instead of triggers to update the original tables

CREATE VIEW EntidadePoligonoOrdenamento AS
    SELECT ent.id AS id, ent.designacao AS designacao_entidade, ent.dtcc as dtcc,
        entord.planta AS planta, entord.designacao AS designacao_ordenamento,
        entord.etiqueta AS etiqueta, polentord.objecto AS objecto, 
        polentord.geom AS geom, polentord.rowid AS rowid
    FROM Entidade AS ent
    JOIN EntidadeOrdenamento AS entord ON (
        entord.id = ent.id)
    JOIN PoligonoEntidadeOrdenamento AS polentord ON (
        polentord.id = entord.id);

INSERT INTO views_geometry_columns
VALUES ('EntidadePoligonoOrdenamento', 'geom', 'rowid', 'PoligonoEntidadeOrdenamento', 'geom');

CREATE TRIGGER trig_entpolord_ent INSTEAD OF INSERT ON EntidadePoligonoOrdenamento
BEGIN
    INSERT INTO Entidade 
    (id, dtcc, designacao)
    VALUES
        (new.id, new.dtcc, new.designacao_entidade);
END;

CREATE TRIGGER trig_entpolord_entord INSTEAD OF INSERT ON EntidadePoligonoOrdenamento
BEGIN
    INSERT INTO EntidadeOrdenamento
    (id, planta, designacao, etiqueta)
    VALUES
        (new.id, new.planta, new.designacao_ordenamento, new.etiqueta);
END;

CREATE TRIGGER trig_entpolord_polentord INSTEAD OF INSERT ON EntidadePoligonoOrdenamento
BEGIN
    INSERT INTO PoligonoEntidadeOrdenamento
    (id, objecto, geom)
    VALUES
        (new.id, new.objecto, GeomFromWKB(new.geom, 3763));
END;



-- CREATE TRIGGER trig_entpolord INSTEAD OF UPDATE ON
-- 
-- CREATE TRIGGER trig_entpolord INSTEAD OF DELETE ON



-- 
-- 
-- --
-- -- table Entidade
-- --
-- 
-- DROP TABLE IF EXISTS Entidade;
-- 
-- CREATE TABLE Entidade (
--     -- Physical entities being represented in the object catalogue
-- 
--     identificador INTEGER NOT NULL,
--     dtcc TEXT NOT NULL,
--     designacao TEXT,
-- 
--     CONSTRAINT pk_ent
--         PRIMARY KEY (identificador)
-- );
-- 
-- --
-- -- table ObjectoCatalogo
-- --
-- 
-- DROP TABLE IF EXISTS ObjectoCatalogo;
-- 
-- CREATE TABLE ObjectoCatalogo (
--     -- Object types being drawn
-- 
--     indice_sequencial INTEGER NOT NULL,
--     entidade INTEGER NOT NULL,
--     simbologia TEXT, -- to be replaced by an XmlBlob
-- 
--     CONSTRAINT pk_objcat
--         PRIMARY KEY (indice_sequencial),
--     CONSTRAINT fk_objcat_ent
--         FOREIGN KEY (entidade) 
--             REFERENCES Entidade
--             ON DELETE CASCADE
--             ON UPDATE CASCADE
-- );
-- 
-- DROP INDEX IF EXISTS idx_objcat_ent;
-- 
-- CREATE INDEX idx_objcat_ent ON ObjectoCatalogo (entidade);
-- 
-- --
-- -- table MudancaEstado
-- --
-- 
-- DROP TABLE IF EXISTS MudancaEstado;
-- 
-- CREATE TABLE MudancaEstado (
--     -- Object types being drawn
-- 
--     identificador INTEGER NOT NULL,
--     objecto INTEGER NOT NULL,
--     designacao TEXT NOT NULL,
--     diploma_acto_pdm TEXT NOT NULL,
--     data_acto_pdm TEXT NOT NULL,
--     observacoes TEXT,
-- 
--     CONSTRAINT pk_mudest
--         PRIMARY KEY (identificador),
--     CONSTRAINT fk_mudest_objcat
--         FOREIGN KEY (objecto) 
--             REFERENCES ObjectoCatalogo
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT check_mudest_des
--         CHECK (designacao IN ('Activo', 'Alteracao',
--                               'Alteracao por adaptacao',
--                               'Alteracao simplificada',
--                               'Correcao material',
--                               'Rectificacao')),
--     CONSTRAINT check_mudest_data
--         CHECK (data_acto_pdm == strftime('%Y-%m-%d', data_acto_pdm))
-- );
-- 
-- DROP INDEX IF EXISTS idx_mudest_objcat;
-- 
-- CREATE INDEX idx_mudest_objcat ON MudancaEstado (objecto);
-- 
-- --
-- -- table TemaOrdenamento
-- --
-- 
-- DROP TABLE IF EXISTS TemaOrdenamento;
-- 
-- CREATE TABLE TemaOrdenamento (
-- 
--     identificador INTEGER NOT NULL,
--     designacao TEXT,
--     subtema TEXT,
-- 
--     CONSTRAINT pk_temord
--         PRIMARY KEY (identificador)
-- );
-- 
-- --
-- -- table TemaCondicionante
-- --
-- 
-- DROP TABLE IF EXISTS TemaCondicionante;
-- 
-- CREATE TABLE TemaCondicionante (
-- 
--     identificador INTEGER NOT NULL,
--     designacao TEXT,
--     subtema TEXT,
-- 
--     CONSTRAINT pk_temcon
--         PRIMARY KEY (identificador)
-- );
-- 
-- --
-- -- table ObjectoOrdenamento
-- --
-- 
-- DROP TABLE IF EXISTS ObjectoOrdenamento;
-- 
-- CREATE TABLE ObjectoOrdenamento (
-- 
--     objecto INTEGER NOT NULL,
--     tema INTEGER NOT NULL,
--     designacao TEXT,
-- 
--     CONSTRAINT pk_objord
--         PRIMARY KEY (objecto),
--     CONSTRAINT fk_objord_objcat
--         FOREIGN KEY (objecto) 
--             REFERENCES ObjectoCatalogo
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT fk_objord_temord
--         FOREIGN KEY (tema) 
--             REFERENCES TemaOrdenamento
--             ON DELETE CASCADE
--             ON UPDATE CASCADE
-- );
-- 
-- DROP INDEX IF EXISTS idx_objord_temord;
-- 
-- CREATE INDEX idx_objord_temord ON ObjectoOrdenamento (tema);
-- 
-- 
-- --
-- -- table ObjectoCondicionante
-- --
-- 
-- DROP TABLE IF EXISTS ObjectoCondicionante;
-- 
-- CREATE TABLE ObjectoCondicionante (
-- 
--     objecto INTEGER NOT NULL,
--     tema INTEGER NOT NULL,
--     designacao TEXT,
-- 
--     CONSTRAINT pk_objcon
--         PRIMARY KEY (objecto),
--     CONSTRAINT fk_objcon_objcat
--         FOREIGN KEY (objecto) 
--             REFERENCES ObjectoCatalogo
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT fk_objcon_temcon
--         FOREIGN KEY (tema) 
--             REFERENCES TemaCondicionante
--             ON DELETE CASCADE
--             ON UPDATE CASCADE
-- );
-- 
-- DROP INDEX IF EXISTS idx_objcon_temcon;
-- 
-- CREATE INDEX idx_objcon_temcon ON ObjectoCondicionante (tema);
-- 
-- --
-- -- table LegislacaoAssociada
-- --
-- 
-- DROP TABLE IF EXISTS LegislacaoAssociada;
-- 
-- CREATE TABLE LegislacaoAssociada (
-- 
--     identificador INTEGER NOT NULL,
--     objecto INTEGER NOT NULL,
--     diploma_especifico TEXT NOT NULL,
--     observacoes TEXT,
-- 
--     CONSTRAINT pk_legass
--         PRIMARY KEY (identificador),
--     CONSTRAINT fk_legass_objcon
--         FOREIGN KEY (objecto) 
--             REFERENCES ObjectoCatalogo
--             ON DELETE CASCADE
--             ON UPDATE CASCADE
-- );
-- 
-- DROP INDEX IF EXISTS idx_legass_objcon;
-- 
-- CREATE INDEX idx_legass_objcon ON LegislacaoAssociada (objecto);
-- 
-- --
-- -- table PlanoDirectorMunicipal
-- --
-- 
-- DROP TABLE IF EXISTS PlanoDirectorMunicipal;
-- 
-- CREATE TABLE PlanoDirectorMunicipal (
-- 
--     identificador INTEGER NOT NULL,
--     publicacao TEXT NOT NULL,
--     versao TEXT NOT NULL,
-- 
--     CONSTRAINT pk_pdm
--         PRIMARY KEY (identificador),
--     CONSTRAINT check_pdm_data
--         CHECK (publicacao == strftime('%Y-%m-%d', publicacao))
-- );
-- 
-- --
-- -- table PlantaOrdenamento
-- --
-- 
-- DROP TABLE IF EXISTS PlantaOrdenamento;
-- 
-- CREATE TABLE PlantaOrdenamento (
-- 
--     identificador INTEGER NOT NULL,
--     pdm INTEGER NOT NULL,
--     publicacao TEXT NOT NULL,
--     revisao TEXT NOT NULL,
-- 
--     CONSTRAINT pk_plord
--         PRIMARY KEY (identificador),
--     CONSTRAINT fk_plord_pdm
--         FOREIGN KEY (pdm) 
--             REFERENCES PlanoDirectorMunicipal
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT check_plord_data
--         CHECK (publicacao == strftime('%Y-%m-%d', publicacao))
-- );
-- 
-- DROP INDEX IF EXISTS idx_plord_pdm;
-- 
-- CREATE INDEX idx_plord_pdm ON PlantaOrdenamento (pdm);
-- 
-- --
-- -- table PlantaCondicionantes
-- --
-- 
-- DROP TABLE IF EXISTS PlantaCondicionantes;
-- 
-- CREATE TABLE PlantaCondicionantes (
-- 
--     identificador INTEGER NOT NULL,
--     pdm INTEGER NOT NULL,
--     publicacao TEXT NOT NULL,
--     revisao TEXT NOT NULL,
-- 
--     CONSTRAINT pk_plcon
--         PRIMARY KEY (identificador),
--     CONSTRAINT fk_plcon_pdm
--         FOREIGN KEY (pdm) 
--             REFERENCES PlanoDirectorMunicipal
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT check_plcon_data
--         CHECK (publicacao == strftime('%Y-%m-%d', publicacao))
-- );
-- 
-- DROP INDEX IF EXISTS idx_plcon_pdm;
-- 
-- CREATE INDEX idx_plcon_pdm ON PlantaCondicionantes (pdm);
-- 
-- --
-- -- table ObjectoPlantaOrdenamento
-- --
-- 
-- DROP TABLE IF EXISTS ObjectoPlantaOrdenamento;
-- 
-- CREATE TABLE ObjectoPlantaOrdenamento (
-- 
--     identificador INTEGER NOT NULL,
--     planta INTEGER NOT NULL,
--     objecto INTEGER NOT NULL,
--     origem_informacao TEXT,
--     data_informacao TEXT,
--     especificacao_particular TEXT,
--     etiqueta TEXT,
-- 
--     CONSTRAINT pk_objplord
--         PRIMARY KEY (identificador),
--     CONSTRAINT fk_objplord_plord
--         FOREIGN KEY (planta) 
--             REFERENCES PlantaOrdenamento
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT fk_objplord_objord
--         FOREIGN KEY (objecto) 
--             REFERENCES ObjectoOrdenamento
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT check_objplord
--         CHECK (data_informacao == strftime('%Y-%m-%d', data_informacao))
-- );
-- 
-- DROP INDEX IF EXISTS idx_objplord_plord;
-- 
-- CREATE INDEX idx_objplord_plord ON ObjectoPlantaOrdenamento (planta);
-- 
-- DROP INDEX IF EXISTS idx_objplord_objord;
-- 
-- CREATE INDEX idx_objplord_objord ON ObjectoPlantaOrdenamento (objecto);
-- 
-- --
-- -- table ObjectoPlantaCondicionantes
-- --
-- 
-- DROP TABLE IF EXISTS ObjectoPlantaCondicionantes;
-- 
-- CREATE TABLE ObjectoPlantaCondicionantes (
-- 
--     identificador INTEGER NOT NULL,
--     planta INTEGER NOT NULL,
--     objecto INTEGER NOT NULL,
--     origem_informacao TEXT,
--     data_informacao TEXT,
--     especificacao_particular TEXT,
--     etiqueta TEXT,
-- 
--     CONSTRAINT pk_objplcon
--         PRIMARY KEY (identificador),
--     CONSTRAINT fk_objplcon_plcon
--         FOREIGN KEY (planta) 
--             REFERENCES PlantaCondicionantes
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT fk_objplcon_objcon
--         FOREIGN KEY (objecto) 
--             REFERENCES ObjectoCondicionante
--             ON DELETE CASCADE
--             ON UPDATE CASCADE,
--     CONSTRAINT check_objplcon
--         CHECK (data_informacao == strftime('%Y-%m-%d', data_informacao))
-- );
-- 
-- DROP INDEX IF EXISTS idx_objplcon_plcon;
-- 
-- CREATE INDEX idx_objplcon_plcon ON ObjectoPlantaCondicionantes (planta);
-- 
-- DROP INDEX IF EXISTS idx_objplcon_objcon;
-- 
-- CREATE INDEX idx_objplcon_objcon ON ObjectoPlantaCondicionantes (objecto);
-- 
-- --
-- -- table PoligonoPlantaCondicionantes
-- --
-- 
-- DROP TABLE IF EXISTS PoligonoPlantaCondicionantes;
-- 
-- CREATE TABLE PoligonoPlantaCondicionantes (
-- 
--     objecto INTEGER NOT NULL,
-- 
--     CONSTRAINT pk_polcon
--         PRIMARY KEY (objecto)
-- );
-- 
-- SELECT AddGeometryColumn('PoligonoPlantaCondicionantes', 'geom', 3763, 'POLYGON', 'XY');
