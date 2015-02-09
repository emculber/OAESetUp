#!/bin/bash

echo 'Making dir ~/OAE if non exists'
mkdir ~/OAE
echo 'Change dir entering ~/Downloads'
cd ~/Downloads

#pre-processes
su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm'

#Command line installs
sudo yum install erlang
sudo yum group install "Development Tools"

#Download all files
wget http://nodejs.org/dist/v0.10.36/node-v0.10.36-linux-x64.tar.gz #Node.js
wget http://download.nextag.com/apache/cassandra/2.1.2/apache-cassandra-2.1.2-bin.tar.gz #Apache Cassandra
wget sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jre-8u25-linux-x64.tar.gz" #Orical Java 7
wget http://download.redis.io/releases/redis-2.8.19.tar.gz #Redis
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.2.tar.gz #ElasticSearch
#wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.4.3/rabbitmq-server-3.4.3-1.noarch.rpm #RabbitMQ
wget ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/1.3/GraphicsMagick-1.3.9.tar.gz #GraphicsMagick
#pdf2htmlEX
#LibreOffice
wget http://nginx.org/download/nginx-1.6.2.tar.gz #NginX
#git clone #EtherPad-lite
#git clone #Hilary
#git clone #3akai-ux

#Unpack all files
tar -zxvf node-v0.10.36-linux-x64.tar.gz -C /home/oae/OAE/
tar -zxvf node*.tar.gz -C ~/OAE
tar -zxvf apache*.tar.gz -C ~/OAE
tar -zxvf jre*.tar.gz -C ~/OAE
tar -zxvf radis*.tar.gz -C ~/OAE
tar -zxvf elasticsearch*.tar.gz -C ~/OAE
tar -zxvf GraphicsMagick*.tar.gz -C ~/OAE
tar -zxvf nginx*.tar.gz -C ~/OAE

#Check and add to path
echo $PATH | grep "node"
if [[ $? -eq 0 ]] ; then
	echo 'Node is in the PATH'
else
	echo 'Node is not in PATH'
	echo "export NODEJS_HOME=/home/oae/OAE/node-v0.10.36-linux-x64" >> /home/oae/.bashrc
	echo 'export PATH=$PATH:$NODEJS_HOME/bin' >> /home/oae/.bashrc
fi
echo $PATH | grep "jre"
if [[ $? -eq 0 ]] ; then
	echo 'JAVA is in PATH'
else
	echo 'JAVA is not in PATH'
	echo "export JAVA_HOME=/home/oae/OAE/jre1.8.0_25" >> /home/oae/.bashrc
	echo 'export PATH=$PATH:$NODEJS_HOME/bin' >> /home/oae/.bashrc
fi

#git Clone


#Additonal
#cassandra
sudo mkdir -p /var/log/cassandra
sudo chown -R oae /var/log/cassandra
sudo mkdir -p /var/lib/cassandra
sudo chown -R oea /var/lib/cassandra
#redis
cd ~/OAE/redis-2.8.19
make
sudo make install
#rabbitmq
cd ~/Downloads
#sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
#yum install rabbitmq-server-3.2.2-1.noarch.rpm
rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.4/rabbitmq-server-3.1.4-1.noarch.rpm
#GraphicsMagick
cd ~/OAE/GraphicsMagick-1.3.9
./configure --enable-shared
make
sudo make install


#run commands
/home/oae/OAE/apache-cassandra-2.1.2/bin/cassandra
/home/oae/OAE/redis-2.8.19/src/redis-server &
/home/oae/OAE/elasticsearch-1.1.2/bin/elasticsearch &
rabbitmq-server -detached

