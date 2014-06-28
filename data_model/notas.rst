Notas relativas ao modelo de dados
==================================

* Nomenclatura geral. Qual a razão para todos o nomes de tabelas e atributos
  serem escritos em maiúsculas? A convenção usada normalmente em SQL é que os
  **comandos SQL** sejam escritos em maiúsculas. Os nomes dos elementos da base
  de dados custumam vir representados em minúsculas. Porquê prejudicar
  a legibilidade do código?

* Nomenclatura das tabelas. Qual a razão para o nome de cada tabela começar por
  'TABELA'? Estamos a falar de um modelo de base de dados, logo é óbvio que
  todas as entidades são representadas em tabelas. É como se o nome de cada
  pessoa começasse por 'PESSOA'. Porquê complicar algo tão simples como o nome
  das entidades do modelo?

* Chaves primárias. Qual a razão para estabelecer uma relação sequencial entre
  as chaves primárias das tabelas *TABELA_OBJECTO_AREA*, *TABELA_OBJECTO_LINHA*
  e *TABELA_OBJECTO_PONTO*? Se são entidades distintas, qual o interesse de
  dispor de uma relação explicíta entre os seus identificadores? Que benefício
  prático tem esta restrição, além de complicar a implementação do modelo de
  dados? Será algo herdado do universo CAD?

* Chaves primárias. Porquê restringir o número de registos que podem ser 
  representados em cada uma das tabelas principais? Qual a base para esta
  restrição? Não é um constrangimento associado aos dados, nem a nenhum SGBD
  particular. Então que sentido faz este constrangimento, além de complicar
  desnecessariamente a sua implementação?

* tabela *TABELA_OBJECTO_AREA*. Os tipos de dados dos atributos
  *LEGISLACAO_ASSOCIADA*, *ESPECIFICACAO* e *DESACTIVO* estão assinalados como
  booleano, mas o que faz sentido é que sejam chaves estrangeiras para as
  tabelas *TABELA_LEGISLACAO_ASSOCIADA*, *TABELA_ESPECIFICACAO*
  e *TABELA_DESACTIVO*

* Tabelas *TABELA_IS_PO e *TABELA_IS_PC*. O tipo de dados do atributo
  *DESIGNACAO* é omisso.

