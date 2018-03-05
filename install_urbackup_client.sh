#!/bin/bash
# VARS
VER='2.2.5'
# PREREQS
TF=`mktemp` && wget "https://hndl.urbackup.org/Client/$VER/UrBackup%20Client%20Linux%20$VER.sh" -O $TF && sh $TF; rm $TF
exit 0
