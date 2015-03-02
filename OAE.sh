#!/bin/bash
Setup()
{
	echo 'Running Setup for OAE'
	for var in "$@"
	do
		if [[ $var == All ]]
                then
			./OAESetup.sh Node Cassandra
			. ~/.bashrc
			./OAESetup.sh Redis ElasticSearch RabbitMQ GraphicsMagick PreviewProcessor Nginx Etherpad Hilary
		fi
		if [[ $var == *"Node"* ]]
                then
			./OAESetup.sh Node
			. ~/.bashrc
		fi
		if [[ $var == *"Cassandra"* ]]
                then
			./OAESetup.sh Cassandra
			. ~/.bashrc
		fi
		if [[ $var == *"Redis"* ]]
                then
			./OAESetup.sh Redis
		fi
		if [[ $var == *"ElasticSearch"* ]]
                then
			./OAESetup.sh ElasticSearch
		fi
		if [[ $var == *"RabbitMQ"* ]]
                then
			./OAESetup.sh RabbitMQ
		fi
		if [[ $var == *"GraphicsMagick"* ]]
                then
			./OAESetup.sh GraphicsMagick
		fi
		if [[ $var == *"PreviewProcessor"* ]]
                then
			./OAESetup.sh PreviewProcessor
		fi
		if [[ $var == *"Nginx"* ]]
                then
			./OAESetup.sh Nginx
		fi
		if [[ $var == *"Etherpad"* ]]
                then
			./OAESetup.sh Etherpad
		fi
		if [[ $var == *"Hilary"* ]]
                then
			./OAESetup.sh Hilary
		fi
	done
	./OAESetup.sh "$@"
	. ~/.bashrc
	echo 'Finish Setup for OAE'
}
