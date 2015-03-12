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
    if [ ! -d ./app/.git ]
    then
        echo "Clonando "${repo}
        git clone ${repo} app
    else
        echo "Actualizando desde "${repo}
        cd ./app
        git pull origin master
        cd ..
    fi
}

function setvars {
    cd ./app
    version=`git describe --tags`
    cd ..
    guid=`uuidgen`
}

function geniss {
    issfile=./output/${project}-${version}.iss
    template=./template/app.iss
    echo "Generando archivo "${issfile}
    mkdir -p ./output
    sed \
        -e "s/\${sourcedir}/${sourcedir}/" \
        -e "s/\${project}/${project}/" \
        -e "s/\${pubname}/${pubname}/" \
        -e "s/\${puburl}/${puburl}/" \
        -e "s/\${version}/${version}/" \
        -e "s/\${guid}/${guid}/" \
        ${template} \
    > ${issfile}
}

loadconfig
getrepo
setvars
geniss
