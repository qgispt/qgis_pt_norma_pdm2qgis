Como testar a base de dados Spatialite do modelo proposto
=========================================================

1. Criar a base de dados.

   * usando o programa *spatialite*, directamente na linha de comandos:

     .. code:: bash

        spatialite teste.db < proposed_model.sql

   * Usando o programa *spatialite-gui*

     * Navegar até 'Files' -> 'Creating a New (empty) SQLITE DB'
     * Escolher um sítio para guardar o ficheiro da base de dados (o spatialite
       guarda tudo num único ficheiro, ao contrário do PostGIS)
     * Escolher um nome para o ficheiro, por exemplo *teste.db*
     * É criada uma nova base de dados vazia
     * Vamos carregar a definição da base de dados
     * ...

#. Abrir a base de dados no QGIS

   * Navegar até 'Layer' -> 'Add spatialite layer...'
   * Na janela seguinte, seleccionar 'New' e depois escolher o ficheiro com
     a base de dados que criámos no passo anterior
   * Seleccionar agora a opção 'Connect'
   * Seleccionar agora a(s) layer(s) a adicionar ao QGIS

