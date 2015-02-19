#!/bin/bash
Setup()
{
	echo 'Running Setup for OAE'
	for var in "$@"
	do
		if [[ $var == All ]]
			./OAESetup.sh Node Cassandra
			. ~/.bashrc
			./OAESetup.sh Redis ElasticSearch RabbitMQ GraphicsMagick PreviewProcessor Nginx Etherpad Hilary
		fi
		if [[ $var == *"Node"* ]]
			./OAESetup.sh Node
			. ~/.bashrc
		fi
		if [[ $var == *"Cassandra"* ]]
			./OAESetup.sh Cassandra
			. ~/.bashrc
		fi
		if [[ $var == *"Redis"* ]]
			./OAESetup.sh Redis
		fi
		if [[ $var == *"ElasticSearch"* ]]
			./OAESetup.sh ElasticSearch
		fi
		if [[ $var == *"RabbitMQ"* ]]
			./OAESetup.sh RabbitMQ
		fi
		if [[ $var == *"GraphicsMagick"* ]]
			./OAESetup.sh GraphicsMagick
		fi
		if [[ $var == *"PreviewProcessor"* ]]
			./OAESetup.sh PreviewProcessor
		fi
		if [[ $var == *"Nginx"* ]]
			./OAESetup.sh Nginx
		fi
		if [[ $var == *"Etherpad"* ]]
			./OAESetup.sh Etherpad
		fi
		if [[ $var == *"Hilary"* ]]
			./OAESetup.sh Hilary
		fi
	done
	./OAESetup.sh "$@"
	. ~/.bashrc
	echo 'Finish Setup for OAE'
}
