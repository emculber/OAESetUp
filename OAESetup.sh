#!/bin/bash

#mkdir /home/oae/OAE
#cd /home/oae/Downloads
#wget http://nodejs.org/dist/v0.10.36/node-v0.10.36-linux-x64.tar.gz
#tar -zxvf node-v0.10.36-linux-x64.tar.gz -C /home/oae/OAE/

if grep -q "bin" $PATH ; then
	echo 'files is in path'
else
	echo 'file is not in path'
fi
