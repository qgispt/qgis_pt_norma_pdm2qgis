-- Some testing data for the alternative data model

INSERT INTO Entidade (identificador, dtcc, designacao) 
    VALUES
        (1, '9201', 'Área de Intervenção do Plano'),
        (2, '9202', 'Espaço Central'),
        (3, '9203', 'Espaço Residencial'),
        (4, '9204', 'Espaço Urbano de Baixa Densidade'),
        (5, '9205', 'Espaço de Actividades Económicas');

INSERT INTO ObjectoCatalogo 
(indice_sequencial, entidade, simbologia) 
    VALUES
        (1, 1, 'simbologia de teste 1'),
        (2, 2, 'simbologia de teste 2'),
        (3, 3, 'simbologia de teste 3'),
        (4, 4, 'simbologia de teste 4'),
        (5, 5, 'simbologia de teste 5');

INSERT INTO MudancaEstado 
(objecto, designacao, diploma_acto_pdm, data_acto_pdm)
    VALUES
        (1, 'Activo', 'legislação xyz', '1999-01-10');

INSERT INTO TemaCondicionante
(designacao, subtema)
    VALUES
        ('Recursos Naturais - Recursos Hídricos', 'Domínio Público Hídrico'),
        ('Recursos Naturais - Recursos Hídricos', 'Albufeiras de Águas Públicas e Lagos ou Lagoas de Águas Públicas'),
        ('Recursos Naturais - Recursos Hídricos', 'Captações de Águas Subterrâneas para Abastecimento Público'),
        ('Área de Intervenção do Plano', 'Área de Intervenção do Plano');
