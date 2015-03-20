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
        if [ ${branch} != 'master' ]
        then
            cd ./app
            git fetch
            git checkout --track origin/${branch}
            git pull origin
            cd ..
        fi
    else
        echo "Actualizando desde "${repo}
        cd ./app
        git checkout ${branch}
        git pull origin
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
    releasedir=./release/${version}
    issfile=${releasedir}/${project}-${version}.iss
    template=./template/app.iss
    echo "Generando archivo "${issfile}
    mkdir -p ${releasedir}
    sed \
        -e "s/\${sourcedir}/${sourcedir}/" \
        -e "s/\${project}/${project}/" \
        -e "s/\${pubname}/${pubname}/" \
        -e "s/\${puburl}/${puburl}/" \
        -e "s/\${entrypoint}/${entrypoint}/" \
        -e "s/\${version}/${version}/" \
        -e "s/\${guid}/${guid}/" \
        ${template} \
    > ${issfile}
}

function build {
    DISPLAY=:10
    exefile=${releasedir}/${project}-${version}.exe
    sumfile=${releasedir}/${project}-${version}-sha256sum.txt
    (Xvfb :10 -ac&) 2> "/tmp/Xvfb.log"
    [ -f "$issfile" ] && issfile=$(winepath -w "$issfile")
    wine "${innopath}" "$issfile" "/q"
    killall Xvfb
    mv ./Output/${project}-${version}.exe ${exefile}
    sha256sum ${exefile} > ${sumfile}
}

loadconfig
getrepo
setvars
geniss
build
