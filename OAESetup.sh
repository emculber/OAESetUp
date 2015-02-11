#!/bin/bash

echo 'Making dir ~/OAE if non exists'
mkdir ~/OAE
echo 'Change dir entering ~/Downloads'
cd ~/Downloads

#NODEJS-------------------------
wget http://nodejs.org/dist/v0.10.36/node-v0.10.36-linux-x64.tar.gz #Node.js Download
tar -zxvf node*.tar.gz -C ~/OAE #Unpack Node.JS and move to ~/OAE
echo $PATH | grep "node" #Check to see if Node.js is in env path
if [[ $? -eq 0 ]] ; then
	echo 'Node is in the PATH'
else
	echo 'Node is not in PATH' #if its no in the path then put it in the bashrc
	echo "export NODEJS_HOME=/home/oae/OAE/node-v0.10.36-linux-x64" >> /home/oae/.bashrc
	echo 'export PATH=$PATH:$NODEJS_HOME/bin' >> /home/oae/.bashrc
fi
#NODEJS-------------------------

#Apache-Cassandra---------------
#Orical Java 7
wget sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jre-8u25-linux-x64.tar.gz" #Orical Java 7 Download
tar -zxvf jre*.tar.gz -C ~/OAE #Unpack Java and move it to ~/OAE
echo $PATH | grep "jre" #Check to see if Java is in the env path
if [[ $? -eq 0 ]] ; then
	echo 'JAVA is in PATH'
else
	echo 'JAVA is not in PATH' #if its not in the path then put it in the bashrc
	echo "export JAVA_HOME=/home/oae/OAE/jre1.8.0_25" >> /home/oae/.bashrc
	echo 'export PATH=$PATH:$NODEJS_HOME/bin' >> /home/oae/.bashrc
fi

#Apache-Cassandra
wget http://download.nextag.com/apache/cassandra/2.1.2/apache-cassandra-2.1.2-bin.tar.gz #Apache Cassandra
tar -zxvf apache*.tar.gz -C ~/OAE #Unpack Apache-Cassandra and move to ~/OAE
sudo mkdir -p /var/log/cassandra
sudo chown -R oae /var/log/cassandra
sudo mkdir -p /var/lib/cassandra
sudo chown -R oea /var/lib/cassandra
#Apache-Cassandra---------------

#Redis--------------------------
wget http://download.redis.io/releases/redis-2.8.19.tar.gz #Redis Download
sudo yum group install "Development Tools" #Dependencies
tar -zxvf radis*.tar.gz -C ~/OAE #Unpack Redis and Move it to ~/OAE
cd ~/OAE/redis-2.8.19
make
sudo make install
#Redis--------------------------

cd ~/Downloads

#ElasticSearch------------------
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.2.tar.gz #ElasticSearch
tar -zxvf elasticsearch*.tar.gz -C ~/OAE
#ElasticSearch------------------

#RabbitMQ-----------------------
su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm'
sudo yum install erlang
sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.4/rabbitmq-server-3.1.4-1.noarch.rpm
#RabbitMQ-----------------------

#GraphicsMagick-----------------
sudo yum install -y gcc libpng libjpeg libpng-devel libjpeg-devel ghostscript
sudo yum install -y libtiff libtiff-devel freetype freetype-devel
wget ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/1.3/GraphicsMagick-1.3.9.tar.gz #GraphicsMagick
tar -zxvf GraphicsMagick*.tar.gz -C ~/OAE
cd ~/OAE/GraphicsMagick-1.3.9
./configure --enable-shared
make
sudo make install
#GraphicsMagick-----------------

cd ~/Downloads

#Preview-Processor--------------
#pdf2htmlEX---------------------
#pdf2htmlEX---------------------

#LibreOffice--------------------
#LibreOffice--------------------
#Preview-Processor--------------

#Nginx--------------------------
#PCRE
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.35.tar.gz #PCRE
tar -zxvf pcre*.tar.gz -C ~/OAE

#Nginx
wget http://nginx.org/download/nginx-1.6.2.tar.gz #NginX
tar -zxvf nginx*.tar.gz -C ~/OAE
cd ~/OAE/nginx-1.6.2/
./configure --with-pcre=/home/oae/OAE/pcre-8.35/
make
sudo make install
#Nginx--------------------------

#Etherpad-lite------------------
cd ~/OAE/
sudo yum install gzip git curl python openssl-devel && yum groupinstall "Development Tools"
git clone git://github.com/ether/etherpad-lite.git
cd etherpad-lite
bin/run.sh
cd node_modules
git clone https://github.com/oaeproject/ep_oae
cd ep_oae
npm install
cp static/css/pad.css ../../src/static/custom/pad.css
cd ../..
sed -i "s/\"xhr-polling/\"websocket\"\, \"xhr-polling/g" settings.json
sed -i '/defaultPadText/c \"defaultPadText\"\ \:\ \"\"' settings.json
#EtherPad-lite------------------

#Hilary/3akai-ux----------------
cd ~/OAE
git clone git://github.com/oaeproject/Hilary.git
git clone git://github.com/oaeproject/3akai-ux.git
sudo bash -c "echo '127.0.0.1  admin.oakland.edu' >> /etc/hosts"
sudo bash -c "echo '127.0.0.1  oae.oakland.edu' >> /etc/hosts"
mkdir /home/oae/OAE/uploads
#Hilary/3akai-ux----------------
