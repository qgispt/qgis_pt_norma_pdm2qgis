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
-- table objecto_catalogo
--

DROP TABLE IF EXISTS objecto_catalogo;

CREATE TABLE objecto_catalogo (

    id INTEGER NOT NULL,
    indice_sequencial INTEGER NOT NULL,
    designacao TEXT NOT NULL,

    CONSTRAINT pk_objcat
        PRIMARY KEY (id)
);

--
-- table tema_ordenamento
--

DROP TABLE IF EXISTS tema_ordenamento;

CREATE TABLE tema_ordenamento (

    id INTEGER NOT NULL,
    designacao TEXT,
    subtema TEXT,

    CONSTRAINT pk_temord
        PRIMARY KEY (id)
);

--
-- table tema_condicionante
--

DROP TABLE IF EXISTS tema_condicionante;

CREATE TABLE tema_condicionante (

    id INTEGER NOT NULL,
    designacao TEXT,
    subtema TEXT,

    CONSTRAINT pk_temcon
        PRIMARY KEY (id)
);


--
-- table objecto_catalogo_ordenamento
--

DROP TABLE IF EXISTS objecto_catalogo_ordenamento;

CREATE TABLE objecto_catalogo_ordenamento (

    id INTEGER NOT NULL,
    tema INTEGER NOT NULL,

    CONSTRAINT pk_objcatord
        PRIMARY KEY (id),
    CONSTRAINT fk_objcatord_objcat
        FOREIGN KEY (id)
            REFERENCES objecto_catalogo
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_objcatord_temord
        FOREIGN KEY (tema)
            REFERENCES tema_ordenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_objcatord_temord;

CREATE INDEX idx_objcatord_temord ON objecto_catalogo_ordenamento (tema);

--
-- table objecto_catalogo_condicionantes
--

DROP TABLE IF EXISTS objecto_catalogo_condicionantes;

CREATE TABLE objecto_catalogo_condicionantes (

    id INTEGER NOT NULL,
    tema INTEGER NOT NULL,

    CONSTRAINT pk_objcatcon
        PRIMARY KEY (id),
    CONSTRAINT fk_objcatcon_objcat
        FOREIGN KEY (id)
            REFERENCES objecto_catalogo
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_objcatord_temcon
        FOREIGN KEY (tema)
            REFERENCES tema_condicionante
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_objcatcon_temcon;

CREATE INDEX idx_objcatcon_temcon ON objecto_catalogo_condicionantes (tema);

--
-- table entidade
--

DROP TABLE IF EXISTS entidade;

CREATE TABLE entidade (
    -- Entities being modelled in Plano Director Municipal

    id INTEGER NOT NULL,
    dtcc TEXT NOT NULL,
    designacao TEXT,

    CONSTRAINT pk_ent
        PRIMARY KEY (id)
);

--
-- table entidade_ordenamento
--

DROP TABLE IF EXISTS entidade_ordenamento;

CREATE TABLE entidade_ordenamento (

    id INTEGER NOT NULL,
    objecto_catalogo INTEGER NOT NULL,
    designacao TEXT,
    etiqueta TEXT,

    CONSTRAINT pk_entord
        PRIMARY KEY (id),
    CONSTRAINT fk_entord_ent
        FOREIGN KEY (id)
            REFERENCES entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_entord_objcatord
        FOREIGN KEY (objecto_catalogo)
            REFERENCES objecto_catalogo_ordenamento
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_entord_objcatord;

CREATE INDEX idx_entord_objcatord ON entidade_ordenamento (objecto_catalogo);

--
-- table entidade_condicionante
--

DROP TABLE IF EXISTS entidade_condicionante;

CREATE TABLE entidade_condicionante (

    id INTEGER NOT NULL,
    objecto_catalogo INTEGER NOT NULL,
    designacao TEXT,
    etiqueta TEXT,

    CONSTRAINT pk_entcon
        PRIMARY KEY (id),
    CONSTRAINT fk_entcon_ent
        FOREIGN KEY (id)
            REFERENCES entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_entcon_objcatcon
        FOREIGN KEY (objecto_catalogo)
            REFERENCES objecto_catalogo_condicionantes
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_entcon_objcatcon;

CREATE INDEX idx_entcon_objcatcon ON entidade_condicionante (objecto_catalogo);

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
            REFERENCES entidade_condicionante
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
            REFERENCES entidade_condicionante
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
-- table estado_entidade_ordenamento
--

DROP TABLE IF EXISTS estado_entidade_ordenamento;

CREATE TABLE estado_entidade_ordenamento (

    id INTEGER NOT NULL,
    entidade INTEGER NOT NULL,
    dinamica_acto_pdm TEXT,
    data_acto_pdm TEXT,
    observacoes TEXT,

    CONSTRAINT pk_estord
        PRIMARY KEY (id),
    CONSTRAINT fk_estord_entord
        FOREIGN KEY (entidade)
            REFERENCES entidade_ordenamento
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

CREATE INDEX idx_estord_entord ON estado_entidade_ordenamento (entidade);

-- 
-- table geometria
-- 

DROP TABLE IF EXISTS geometria;

CREATE TABLE geometria (

    id  INTEGER NOT NULL,
    entidade INTEGER NOT NULL,

    CONSTRAINT pk_geom
        PRIMARY KEY (id),
    CONSTRAINT fk_geom_ent
        FOREIGN KEY (entidade)
            REFERENCES entidade
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

DROP INDEX IF EXISTS idx_geom_ent;

CREATE INDEX idx_geom_ent ON geometria (entidade);

--
-- table geometria_poligono
--

DROP TABLE IF EXISTS geometria_poligono;

CREATE TABLE geometria_poligono (

    id INTEGER NOT NULL,

    CONSTRAINT pk_geompol
        PRIMARY KEY (id),
    CONSTRAINT fk_geompol_geom
        FOREIGN KEY (id)
            REFERENCES geometria
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

SELECT AddGeometryColumn('geometria_poligono', 'geom', 3763, 'POLYGON', 'XY');

--
-- table geometria_linha
--

DROP TABLE IF EXISTS geometria_linha;

CREATE TABLE geometria_linha (

    id INTEGER NOT NULL,

    CONSTRAINT pk_geomlin
        PRIMARY KEY (id),
    CONSTRAINT fk_geomlin_geom
        FOREIGN KEY (id)
            REFERENCES geometria
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

SELECT AddGeometryColumn('geometria_linha', 'geom', 3763, 'LINESTRING', 'XY');

--
-- table geometria_ponto
--

DROP TABLE IF EXISTS geometria_ponto;

CREATE TABLE geometria_ponto (

    id INTEGER NOT NULL,

    CONSTRAINT pk_geompon
        PRIMARY KEY (id),
    CONSTRAINT fk_geompon_geom
        FOREIGN KEY (id)
            REFERENCES geometria
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

SELECT AddGeometryColumn('geometria_ponto', 'geom', 3763, 'POINT', 'XY');

-- view entidade_poligono

-- view creation
-- registering the geometry column in the views_geometry_columns table
-- creating instead of triggers to update the original tables

CREATE VIEW entidade_poligono AS
    SELECT 
        ent.id AS id, 
        ent.rowid AS rowid, -- seems to be needed by QGIS
        ent.designacao AS designacao_entidade, 
        ent.dtcc as dtcc,
        entord.objecto_catalogo AS objecto_catalogo_ordenamento,
        entord.designacao AS designacao_ordenamento,
        entord.etiqueta AS etiqueta_ordenamento,
        entcon.objecto_catalogo AS objecto_catalogo_condicionantes,
        entcon.designacao AS designacao_condicionantes, 
        entcon.etiqueta AS etiqueta_condicionantes,
        geompol.geom AS geom -- seems to be needed by QGIS
    FROM entidade AS ent
    LEFT JOIN entidade_ordenamento AS entord ON (
        entord.id = ent.id)
    LEFT JOIN entidade_condicionante AS entcon ON (
        entcon.id = ent.id)
    JOIN geometria AS geometria ON (
        geometria.entidade = ent.id
    )
    JOIN geometria_poligono AS geompol ON (
        geompol.id = ent.id
    );

INSERT INTO views_geometry_columns
-- (view_name, view_geometry, view_rowid, f_table_name, f_geometry_column)
-- VALUES ('entidade_poligono', 'geom', 'rowid', 'geometria_poligono', 'geom');
(view_name, view_geometry, view_rowid, f_table_name, f_geometry_column, read_only)
VALUES ('entidade_poligono', 'geom', 'rowid', 'geometria_poligono', 'geom', 0);

CREATE TRIGGER trig_entpol_ent INSTEAD OF INSERT ON entidade_poligono
BEGIN
    INSERT INTO entidade 
    (id, dtcc, designacao)
    VALUES
        (new.id, new.dtcc, new.designacao_entidade);
END;

CREATE TRIGGER trig_entpol_entord INSTEAD OF INSERT ON entidade_poligono
WHEN
    new.objecto_catalogo_ordenamento IS NOT NULL
BEGIN
    INSERT INTO entidade_ordenamento
    (id, designacao, etiqueta, objecto_catalogo)
    VALUES
        (new.id, new.designacao_ordenamento, new.etiqueta_ordenamento, new.objecto_catalogo_ordenamento);
END;

CREATE TRIGGER trig_entpol_entcon INSTEAD OF INSERT ON entidade_poligono
WHEN
    new.objecto_catalogo_condicionantes IS NOT NULL
BEGIN
    INSERT INTO entidade_condicionante
    (id, designacao, etiqueta, objecto_catalogo)
    VALUES
        (new.id, new.designacao_condicionantes, new.etiqueta_condicionantes, 
            new.objecto_catalogo_condicionantes);
END;

CREATE TRIGGER trig_entpol_geom INSTEAD OF INSERT ON entidade_poligono
BEGIN
    INSERT INTO geometria
    (entidade)
    VALUES
        (new.id);
END;

CREATE TRIGGER trig_entpol_geompol INSTEAD OF INSERT ON entidade_poligono
BEGIN
    INSERT INTO geometria_poligono
    (id, geom)
    VALUES
        (new.id, new.geom);
END;
