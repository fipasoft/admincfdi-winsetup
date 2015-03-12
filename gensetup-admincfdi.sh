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

function getver {
    cd ./admin-cfdi
    version=`git describe --tags`
    cd ..
}

function geniss {
    echo "Generando archivo ./output/admincfdi-${version}.iss"
    mkdir -p ./output
    cp -f ./template/admincfdi.iss ./output/admincfdi-${version}.iss
}

loadconfig
getrepo
getver
geniss
