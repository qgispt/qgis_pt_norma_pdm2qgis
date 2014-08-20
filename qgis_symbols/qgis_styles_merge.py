# copyright: (C) 2014 Grupo Utilizadores QGIS Portugal
# email: qgis.portugal@gmail.com
# autor: Alexandre Neto
#
# Este ficheiro e software livre; voce pode redistribui-lo
# e/ou modifica-lo nos termos da Licenca Publica Geral GNU
# versao 2 (GPL2) como publicada pela Fundacao do
# Software Livre (FSF).


## List of QGIS Styles (XML) -> QGIS Styles (XML)
## Purpose: merge 2 or more QGIS styles (XML) in one single file

import xml.etree.ElementTree as ET

# List of QGIS styles filenames to aggregate
file_names = ['083_094.xml','095_098_Dominio_Hidrico.xml','099_113.xml','114_133.xml','134_173.xml']
# output filename
output = '083_173.xml'

# Iterate over files and get theirs XML trees
trees = []
for xml_file in file_names:
    trees.append(ET.parse(xml_file))

# Use the tree of the first listed file as base tree
# where all other xml elements will be added
base_xml_tree = trees[0]
base_qgis_style = base_xml_tree.getroot()
base_symbols = base_qgis_style[0]
base_coloramps = base_qgis_style[1]

# iterate trees except first one to get their symbols
# and colorramps and add them the base xml tree
for i in range(1,len(trees)):
    qgis_style = trees[i].getroot()
    symbols = qgis_style[0]
    colorramps = qgis_style[1]
    for symbol in symbols:
        base_symbols.append(symbol)
    for colorramp in colorramps:
        base_coloramps.append(colorramp)

# print XML code to see how it went
print unicode(ET.tostring(base_qgis_style))

# write new QGIS styles XML file
base_xml_tree.write(output, encoding='UTF-8')