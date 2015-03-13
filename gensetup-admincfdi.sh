#!/bin/bash

function loadconfig {
    source ./config
    if [ -s ${repo} ]
    then
        echo "Error al leer la configuracion"
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

function build {
    DISPLAY=:10
    exefile=./output/${project}-${version}.exe
    sumfile=./output/${project}-${version}-sha256sum.txt
    (Xvfb :10 -ac&) 2> "/tmp/Xvfb.log"
    [ -f "$issfile" ] && issfile=$(winepath -w "$issfile")
    wine "${innopath}" "$issfile" "/q"
    killall Xvfb
    sha256sum ${exefile} > ${sumfile}
}

loadconfig
getrepo
setvars
geniss
build
