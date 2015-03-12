#!/bin/bash
repo='https://github.com/linuxcabal/admin-cfdi'

if [ ! -f ./admin-cfdi/admincfdi.py ]
then
    git clone ${repo}
fi
