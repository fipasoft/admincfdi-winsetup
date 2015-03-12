#!/bin/bash
repo='https://github.com/linuxcabal/admin-cfdi'

function getrepo {
    if [ ! -f ./admin-cfdi/admincfdi.py ]
    then
        "Clonando "${repo}
        git clone ${repo}
    else
        "Actualizando desde "${repo}
        cd ./admin-cfdi
        git pull origin master
        cd ..
    fi
}

getrepo
