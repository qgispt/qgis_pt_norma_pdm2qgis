-- SQL DDL commands for the database structured mandated by the Technical
-- Paper on portuguese Plano Director Municipal
-- This file assumes a Spatialite database will be created

-- for each table, be sure to include:
-- proper comments
-- * creation of indexes
-- * creation of spatial columns
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
-- table TemaCondicionante
--

DROP TABLE IF EXISTS TemaCondicionante;

CREATE TABLE TemaCondicionante (

    id INTEGER NOT NULL,
    designacao TEXT,
    subtema TEXT,

    CONSTRAINT pk_temcon
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
-- table ObjectoCatalogoCondicionantes
--

DROP TABLE IF EXISTS ObjectoCatalogoCondicionantes;

CREATE TABLE ObjectoCatalogoCondicionantes (

    id INTEGER NOT NULL,
    tema INTEGER NOT NULL,

    CONSTRAINT pk_objcatcon
        PRIMARY KEY (id),
    CONSTRAINT fk_objcatcon_objcat
        FOREIGN KEY (id)
            REFERENCES ObjectoCatalogo
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_objcatord_temcon
        FOREIGN KEY (tema)
            REFERENCES TemaOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_objcatcon_temcon;

CREATE INDEX idx_objcatcon_temcon ON ObjectoCatalogoOrdenamento (tema);

--
-- table Entidade
--

DROP TABLE IF EXISTS Entidade;

CREATE TABLE Entidade (
    -- Entities being modelled in Plano Director Municipal

    id INTEGER NOT NULL,
    dtcc TEXT NOT NULL,
    designacao TEXT,

    CONSTRAINT pk_ent
        PRIMARY KEY (id)
);

--
-- table EntidadeOrdenamento
--

DROP TABLE IF EXISTS EntidadeOrdenamento;

CREATE TABLE EntidadeOrdenamento (

    id INTEGER NOT NULL,
    objecto_catalogo INTEGER NOT NULL,
    designacao TEXT,
    etiqueta TEXT,

    CONSTRAINT pk_entord
        PRIMARY KEY (id),
    CONSTRAINT fk_entord_ent
        FOREIGN KEY (id)
            REFERENCES Entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_entord_objcatord
        FOREIGN KEY (objecto_catalogo)
            REFERENCES ObjectoCatalogoOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_entord_objcatord;

CREATE INDEX idx_entord_objcatord ON EntidadeOrdenamento (objecto_catalogo);

--
-- table EntidadeCondicionante
--

DROP TABLE IF EXISTS EntidadeCondicionante;

CREATE TABLE EntidadeCondicionante (

    id INTEGER NOT NULL,
    objecto_catalogo INTEGER NOT NULL,
    designacao TEXT,
    etiqueta TEXT,

    CONSTRAINT pk_entcon
        PRIMARY KEY (id),
    CONSTRAINT fk_entcon_ent
        FOREIGN KEY (id)
            REFERENCES Entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_entcon_objcatcon
        FOREIGN KEY (objecto_catalogo)
            REFERENCES ObjectoCatalogoCondicionantes
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_entcon_objcatcon;

CREATE INDEX idx_entcon_objcatcon ON EntidadeCondicionante (objecto_catalogo);

--
-- table LegislacaoAssociada
--

DROP TABLE IF EXISTS LegislacaoAssociada;

CREATE TABLE LegislacaoAssociada (

    id INTEGER NOT NULL,
    entidade INTEGER NOT NULL,
    diploma_especifico TEXT,
    observacoes TEXT,

    CONSTRAINT pk_leg
        PRIMARY KEY (id),
    CONSTRAINT fk_leg_entcon
        FOREIGN KEY (entidade)
            REFERENCES EntidadeCondicionante
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_leg_entcon;

CREATE INDEX idx_leg_entcon ON LegislacaoAssociada (entidade);

--
-- table EstadoEntidadeCondicionante
--

DROP TABLE IF EXISTS EstadoEntidadeCondicionante;

CREATE TABLE EstadoEntidadeCondicionante (

    id INTEGER NOT NULL,
    entidade INTEGER NOT NULL,
    dinamica_acto_pdm TEXT,
    data_acto_pdm TEXT,
    observacoes TEXT,

    CONSTRAINT pk_estcon
        PRIMARY KEY (id),
    CONSTRAINT fk_estcon_entcon
        FOREIGN KEY (entidade)
            REFERENCES EntidadeCondicionante
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT check_estentcon_din
        CHECK ('dinamica_acto_pdm' IN ('Alteracao', 'Alteracao por adaptacao',
                                       'Alteracao simplificada', 
                                       'Correcao material', 'Rectificacao')),
    CONSTRAINT check_estcon_data
        CHECK (data_acto_pdm == strftime('%Y-%m-%d', data_acto_pdm))
);

DROP INDEX IF EXISTS idx_estcon_entcon;

CREATE INDEX idx_estcon_entcon ON EstadoEntidadeCondicionante (entidade);

--
-- table EstadoEntidadeOrdenamento
--

DROP TABLE IF EXISTS EstadoEntidadeOrdenamento;

CREATE TABLE EstadoEntidadeOrdenamento (

    id INTEGER NOT NULL,
    entidade INTEGER NOT NULL,
    dinamica_acto_pdm TEXT,
    data_acto_pdm TEXT,
    observacoes TEXT,

    CONSTRAINT pk_estord
        PRIMARY KEY (id),
    CONSTRAINT fk_estord_entord
        FOREIGN KEY (entidade)
            REFERENCES EntidadeOrdenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT check_estentord_din
        CHECK ('dinamica_acto_pdm' IN ('Alteracao', 'Alteracao por adaptacao',
                                       'Alteracao simplificada', 
                                       'Correcao material', 'Rectificacao')),
    CONSTRAINT check_estord_data
        CHECK (data_acto_pdm == strftime('%Y-%m-%d', data_acto_pdm))
);

DROP INDEX IF EXISTS idx_estord_entord;

CREATE INDEX idx_estord_entord ON EstadoEntidadeOrdenamento (entidade);

-- 
-- table Geometria
-- 

DROP TABLE IF EXISTS Geometria;

CREATE TABLE Geometria (

    id  INTEGER NOT NULL,
    entidade INTEGER NOT NULL,

    CONSTRAINT pk_geom
        PRIMARY KEY (id),
    CONSTRAINT fk_geom_ent
        FOREIGN KEY (entidade)
            REFERENCES Entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_geom_ent;

CREATE INDEX idx_geom_ent ON Geometria (entidade);

--
-- table GeometriaPoligono
--

DROP TABLE IF EXISTS GeometriaPoligono;

CREATE TABLE GeometriaPoligono (

    id INTEGER NOT NULL,

    CONSTRAINT pk_geompol
        PRIMARY KEY (id),
    CONSTRAINT fk_geompol_geom
        FOREIGN KEY (id)
            REFERENCES Geometria
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

SELECT AddGeometryColumn('GeometriaPoligono', 'geom', 3763, 'POLYGON', 'XY');

--
-- table GeometriaLinha
--

DROP TABLE IF EXISTS GeometriaLinha;

CREATE TABLE GeometriaLinha (

    id INTEGER NOT NULL,

    CONSTRAINT pk_geomlin
        PRIMARY KEY (id),
    CONSTRAINT fk_geomlin_geom
        FOREIGN KEY (id)
            REFERENCES Geometria
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

SELECT AddGeometryColumn('GeometriaLinha', 'geom', 3763, 'LINESTRING', 'XY');

--
-- table GeometriaPonto
--

DROP TABLE IF EXISTS GeometriaPonto;

CREATE TABLE GeometriaPonto (

    id INTEGER NOT NULL,

    CONSTRAINT pk_geompon
        PRIMARY KEY (id),
    CONSTRAINT fk_geompon_geom
        FOREIGN KEY (id)
            REFERENCES Geometria
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

SELECT AddGeometryColumn('GeometriaPonto', 'geom', 3763, 'POINT', 'XY');

-- view EntidadePoligono

-- view creation
-- registering the geometry column in the views_geometry_columns table
-- creating instead of triggers to update the original tables

CREATE VIEW EntidadePoligono AS
    SELECT 
        ent.id AS id, 
        ent.designacao AS designacao_entidade, 
        ent.dtcc as dtcc,
        entord.designacao AS designacao_ordenamento,
        entord.etiqueta AS etiqueta_ordenamento,
        entcon.designacao AS designacao_condicionantes, 
        entcon.etiqueta AS etiqueta_condicionantes,
        geompol.geom AS geom,
        geompol.rowid AS rowid
    FROM Entidade AS ent
    JOIN EntidadeOrdenamento AS entord ON (
        entord.id = ent.id)
    JOIN EntidadeCondicionante AS entcon ON (
        entcon.id = ent.id)
    JOIN Geometria AS geometria ON (
        geometria.entidade = ent.id)
    JOIN GeometriaPoligono AS geompol ON (
        geompol.id = geometria.id);

INSERT INTO views_geometry_columns
VALUES ('EntidadePoligono', 'geom', 'rowid', 'GeometriaPoligono', 'geom');

-- 
-- CREATE TRIGGER trig_entpolord_ent INSTEAD OF INSERT ON EntidadePoligonoOrdenamento
-- BEGIN
--     INSERT INTO Entidade 
--     (id, dtcc, designacao)
--     VALUES
--         (new.id, new.dtcc, new.designacao_entidade);
-- END;
-- 
-- CREATE TRIGGER trig_entpolord_entord INSTEAD OF INSERT ON EntidadePoligonoOrdenamento
-- BEGIN
--     INSERT INTO EntidadeOrdenamento
--     (id, designacao, etiqueta)
--     VALUES
--         (new.id, new.designacao_ordenamento, new.etiqueta);
-- END;
-- 
-- CREATE TRIGGER trig_entpolord_polentord INSTEAD OF INSERT ON EntidadePoligonoOrdenamento
-- BEGIN
--     INSERT INTO PoligonoEntidadeOrdenamento
--     (id, objecto, geom)
--     VALUES
--         (new.id, new.objecto, GeomFromWKB(new.geom, 3763));
-- END;



-- CREATE TRIGGER trig_entpolord INSTEAD OF UPDATE ON
-- 
-- CREATE TRIGGER trig_entpolord INSTEAD OF DELETE ON
