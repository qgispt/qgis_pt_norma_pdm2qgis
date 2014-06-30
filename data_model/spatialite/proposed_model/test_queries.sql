-- Some testing queries for the alternative data model

SELECT oc.indice_Sequencial AS 'IS', e.designacao AS 'DESIGNACAO'
FROM ObjectoCatalogo AS oc
JOIN Entidade AS e ON (
    oc.entidade = e.identificador);
