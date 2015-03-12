#!/bin/bash

function loadconfig {
    source ./config
    if [ -s ${repo} ]
    then
        "Error al leer la configuracion"
        exit 1
    fi
}

function getrepo {
    if [ ! -f ./admin-cfdi/admincfdi.py ]
    then
        echo "Clonando "${repo}
        git clone ${repo}
    else
        echo "Actualizando desde "${repo}
        cd ./admin-cfdi
        git pull origin master
        cd ..
    fi
}

function setvars {
    cd ./admin-cfdi
    version=`git describe --tags`
    cd ..
    guid=`uuidgen`
}

function geniss {
    issfile=./output/admincfdi-${version}.iss
    template=./template/admincfdi.iss
    echo "Generando archivo "${issfile}
    mkdir -p ./output
    sed \
        -e "s/\${version}/${version}/" \
        -e "s/\${guid}/${guid}/" \
        ${template} \
    > ${issfile}
}

loadconfig
getrepo
setvars
geniss
