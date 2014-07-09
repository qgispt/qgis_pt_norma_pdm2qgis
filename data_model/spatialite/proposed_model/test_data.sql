-- Some testing data for the alternative data model

DELETE FROM objecto_catalogo;
INSERT INTO objecto_catalogo 
(id, indice_sequencial, designacao) 
    VALUES
        (1, 1, 'Área de Intervenção do Plano'),
        (2, 2, 'Espaço Central'),
        (3, 3, 'Espaço Residencial'),
        (4, 4, 'Espaço Urbano de Baixa Densidade'),
        (5, 5, 'Espaço de Actividades Económicas');

DELETE FROM tema_condicionante;
INSERT INTO tema_condicionante
(id, designacao, subtema)
    VALUES
        (1, 'Recursos Naturais - Recursos Hídricos', 'Domínio Público Hídrico'),
        (2, 'Recursos Naturais - Recursos Hídricos', 'Albufeiras de Águas Públicas e Lagos ou Lagoas de Águas Públicas'),
        (3, 'Recursos Naturais - Recursos Hídricos', 'Captações de Águas Subterrâneas para Abastecimento Público'),
        (4, 'Recursos Naturais - Recursos Geológicos', 'Águas de Nascente'),
        (5, 'Recursos Naturais - Recursos Geológicos', 'Águas Minerais Naturais'),
        (6, 'Recursos Naturais - Recursos Geológicos', 'Pedreiras'),
        (7, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Reserva Agrícola Nacional'),
        (8, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Obras de Aproveitamento Hidroagrícola'),
        (9, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Oliveiras'),
        (10, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Sobreiros ou Azinheiras'),
        (11, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Azevinho'),
        (12, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Regime Florestal'),
        (13, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Povoamentos Florestais Percorridos por Incêndio'),
        (14, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Protecção ao Risco de Incêndio'),
        (15, 'Recursos Naturais - Recurso Agrícolas e Florestais', 'Árvores e Arvoredo de Interesse Público'),
        (16, 'Recursos Naturais - Recursos Ecológicos', 'Reserva Ecológica Nacional'),
        (17, 'Recursos Naturais - Recursos Ecológicos', 'Áreas Protegidas'),
        (18, 'Recursos Naturais - Recursos Ecológicos', 'Rede Natura 2000'),
        (19, 'Património Edificado', 'Imóveis Classificados'),
        (20, 'Património Edificado', 'Edifícios Públicos e Outras Construções'),
        (21, 'Equipamentos', 'Estabelecimentos Prisionais e Tutelares de Menores'),
        (22, 'Equipamentos', 'Instalações Aduaneiras'),
        (23, 'Equipamentos', 'Defesa Nacional'),
        (24, 'Infraestruturas', 'Abastecimento de Água'),
        (25, 'Infraestruturas', 'Drenagem de Águas Residuais'),
        (26, 'Infraestruturas', 'Rede Eléctrica'),
        (27, 'Infraestruturas', 'Gasodutos e Oleodutos'),
        (28, 'Infraestruturas', 'Rede Rodoviária Nacional e Rede Rodoviária Regional'),
        (29, 'Infraestruturas', 'Estradas Nacionais Desclassificadas'),
        (30, 'Infraestruturas', 'Estradas e Caminhos Municipais'),
        (31, 'Infraestruturas', 'Rede Ferroviária'),
        (32, 'Infraestruturas', 'Aeroportos e Aeródromos'),
        (33, 'Infraestruturas', 'Telecomunicações'),
        (34, 'Infraestruturas', 'Faróis e outros Sinais Marítimos'),
        (35, 'Infraestruturas', 'Marcos Geodésicos'),
        (36, 'Actividades Perigosas', 'Estabelecimentos com Produtos Explosivos'),
        (37, 'Actividades Perigosas', 'Estabelecimentos com Substâncias Perigosas'),
        (38, 'Área de Intervenção do Plano', 'Área de Intervenção do Plano');

DELETE FROM tema_ordenamento;
INSERT INTO tema_ordenamento
(id, designacao, subtema)
    VALUES
        (1, 'Classificação Qualificação do Solo', 'Solo Urbano - urbanizado'),
        (2, 'Classificação Qualificação do Solo', 'Solo Urbano - urbanizável'),
        (3, 'Classificação Qualificação do Solo', 'Solo Rural'),
        (4, 'Áreas com Funções Específicas', 'Estrutura Ecológica Municipal'),
        (5, 'Áreas com Funções Específicas', 'Espaço Canal'),
        (6, 'Áreas de Intervenção', 'Unidade Operativa de Planeamento e Gestão (UOPG)'),
        (7, 'Áreas de Intervenção', 'Área de Intervenção de Planos Municipais de Ordenamento do Território (PMOT)'),
        (8, 'Áreas de Intervenção', 'Área de Intervenção de Planos Especiais de Ordenamento do Território (PEOT)'),
        (9, 'Sistemas Estruturantes', 'Equipamentos de Utilização Colectiva'),
        (10, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Rede de Infraestruturas de Transporte'),
        (11, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Sistemas de Abastecimento de Água'),
        (12, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Sistemas de Drenagem de Águas Residuais'),
        (13, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Sistemas de Recolha, Depósito e Tratamento de Resíduos'),
        (14, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Sistemas de Abastecimento de Energia Eléctrica'),
        (15, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Sistemas de Abastecimento de Combustíveis'),
        (16, 'Sistemas Estruturantes', 'Infraestruturas Territoriais - Sistemas de Telecomunicações'),
        (17, 'Área de Intervenção do Plano', 'Área de Intervenção do Plano');

DELETE FROM objecto_catalogo_ordenamento;
INSERT INTO objecto_catalogo_ordenamento
(id, tema) 
    VALUES
        (1, 17),
        (2, 1),
        (3, 1),
        (4, 1),
        (5, 1);

DELETE FROM entidade;
INSERT INTO entidade
(id, designacao, dtcc)
    VALUES
        (1, 'limites do concelho', '90023');

DELETE FROM entidade_ordenamento;
INSERT INTO entidade_ordenamento
(id, objecto_catalogo, designacao, etiqueta)
    VALUES
        (1, 1, '', '');

DELETE FROM geometria_poligono;
INSERT INTO geometria_poligono
(id, objecto, geom)
    VALUES
        (1, 1, GeomFromText('POLYGON((
            -0.430722891566265 0.412179969879519,
            -0.434864457831325 0.396084337349399,
            -0.434864457831325 0.383283132530121,
            -0.429875753012048 0.365493222891567,
            -0.407661897590361 0.361351656626507,
            -0.384224397590361 0.391660391566266,
            -0.38535391566265 0.405685240963856,
            -0.395048945783132 0.412085843373495,
            -0.413591867469879 0.415286144578314,
            -0.430722891566265 0.412179969879519))', 
            3763));
