#!/bin/bash
repo='https://github.com/linuxcabal/admin-cfdi'

function getrepo {
    if [ ! -f ./admin-cfdi/admincfdi.py ]
    then
        git clone ${repo}
    else
        cd ./admin-cfdi
        git pull origin master
        cd ..
    fi
}

getrepo
