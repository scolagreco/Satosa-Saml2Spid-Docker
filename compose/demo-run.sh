#!/bin/bash

source /satosa_proxy/bash_env

SATOSA_APP=/usr/lib/python3.8/site-packages/satosa
uwsgi --uid 1000 --https 0.0.0.0:9999,$BASEDIR/pki/cert.pem,$BASEDIR/pki/privkey.pem --check-static-docroot --check-static $BASEDIR/static/ --static-index disco.html &
P1=$!
uwsgi --uid 1000 --wsgi-file $SATOSA_APP/wsgi.py  --https 0.0.0.0:10000,$BASEDIR/pki/cert.pem,$BASEDIR/pki/privkey.pem --callable app -b 32648
P2=$!
wait $P1 $P2
