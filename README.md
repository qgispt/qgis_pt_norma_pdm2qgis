NormaPDM2QGIS
=============

Descrição
---------

Aplicação da [Norma Técnica sobre o Modelo de Dados para o Plano Diretor Municipal](https://www.dgterritorio.gov.pt/node/1288) no QGIS.

Objetivos
----------
Facilitar o trabalho das Câmara Municipais e dos Gabinetes Técnicos na adaptação do QGIS para a elaboração/revisão dos Planos Municipais de Ordenamento do Território, nomeadamente dos Planos Diretores Municipais e Planos de Urbanização, através de:

- Construção da simbologia oficial tal como explanada na Norma Técnica;
- Criação dos scripts necessários para construção da base de dados;
- Cumprir ao máximo os requisitos da Norma Técnica sobre o Modelo de Dados para o PDM [1];
- Utilizar formatos abertos que potenciem a interoperabilidade entre diversas ferramentas;
- Utilizar recursos abertos que possam ser usados livremente para os fins pretendidos. Um exemplo claro é a utilização de símbolos cartográficos que tenham licenças que permitam a sua utilização;
- Utilizar ferramentas de código aberto que possam ser adaptadas e mantidas se for necessário;
- Facilitar o acesso em múltiplas plataformas (web, móvel, linux, windows, macOS);
- Facilitar o acesso por parte de utilizadores menos experientes.

Tecnologias
-----------
### Base de dados

Pretende-se utilizar um Sistema de Gestão de Base de Dados (SGBD) geo-relacional. Todas as opções em análise são suportadas pelo QGIS.

#### PostGIS ([http://postgis.net/](http://postgis.net/))
- SGBD robusto;
- Arquitetura cliente/servidor;
- Apropriado para instalações em larga escala, com utilização concorrente;
- A instalação e configuração é mais complexa do que as restantes ferramentas;
- Implementa inúmeras funções espaciais;
- Implementa o modelo Simple Features do OGC;
- Permite guardar simbologia SLD e QGS diretamente na base de dados.

#### Spatialite ([https://www.gaia-gis.it/fossil/libspatialite/home](https://www.gaia-gis.it/fossil/libspatialite/home))
- Baseado em SQLite;
- Um único ficheiro;
- Uma espécie de PostGIS para tótós, implementando a maioria das funções espaciais, mas mais fácil de instalar:
- Suportado também em Android;
- Permite guardar simbologia SLD e QGS directamente na base de dados (XmlBlob).

#### GeoPackage ([http://www.geopackage.org/](http://www.geopackage.org/))
- Standard OGC para intercâmbio de dados;
- Pretende substituir (finalmente) o Shapefile;
- Baseado em SQLite, tal como o Spatialite, mas é mais simples de criar;
- Standard recente, mas que já é suportado pela OGR, ESRI, GeoTools.

### Simbologia
Ambas as opções em análise são suportadas pelo QGIS.

#### QGS - QGIS Layer Style format
- Formato nativo do QGIS;
- Muitas opções de representação gráfica.

#### SLD - OGC Styled Layer Descriptor
- Standard OGC para representação gráfica de elementos;
- Utilizado em muitos software SIG, proeminentemente no GeoServer.

Licença
-----------
Todos os ficheiros que se encontram neste repositório são software livre; pode ser redistribuido e/ou modificado [nos termos da Licença Pública Geral GNU versão 2 (GPL2)](http://www.gnu.org/licenses/gpl-2.0.txt) como publicada pela [Fundação do Software Livre (FSF)](http://www.fsf.org/).
