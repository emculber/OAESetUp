#!/bin/bash

echo 'Making dir ~/OAE if non exists'
mkdir ~/OAE
echo 'Change dir entering ~/Downloads'
cd ~/Downloads

for var in "$@"
do
    if [[ $var == *"Node"* ]]
    then	
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
    fi
    if [[ $var == *"Cassandra"* ]]
    then	
	#Apache-Cassandra---------------
	#Orical Java 7
	sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
	"http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jre-8u25-linux-x64.tar.gz" #Orical Java 7 Download
	tar -zxvf jre*.tar.gz -C ~/OAE #Unpack Java and move it to ~/OAE
	echo $PATH | grep "jre" #Check to see if Java is in the env path
	if [[ $? -eq 0 ]] ; then
		echo 'JAVA is in PATH'
	else
		echo 'JAVA is not in PATH' #if its not in the path then put it in the bashrc
		echo "export JAVA_HOME=/home/oae/OAE/jre1.8.0_25" >> /home/oae/.bashrc
		echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/oae/.bashrc
	fi

	#Apache-Cassandra
	wget http://download.nextag.com/apache/cassandra/2.1.2/apache-cassandra-2.1.2-bin.tar.gz #Apache Cassandra
	tar -zxvf apache*.tar.gz -C ~/OAE #Unpack Apache-Cassandra and move to ~/OAE
	sudo mkdir -p /var/log/cassandra
	sudo chown -R oae /var/log/cassandra
	sudo mkdir -p /var/lib/cassandra
	sudo chown -R oae /var/lib/cassandra
	#Apache-Cassandra---------------
    fi
    if [[ $var == *"Redis"* ]]
    then	
	#Redis--------------------------
	wget http://download.redis.io/releases/redis-2.8.19.tar.gz #Redis Download
	sudo yum group install -y "Development Tools" #Dependencies
	sudo yum install -y tcl-devel.x86_64
	tar -zxvf redis*.tar.gz -C ~/OAE #Unpack Redis and Move it to ~/OAE
	cd ~/OAE/redis-2.8.19
	make
	sudo make install
	cd ~/Downloads
	#Redis--------------------------
    fi
    if [[ $var == *"ElasticSearch"* ]]
    then	
	#ElasticSearch------------------
	wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.2.tar.gz #ElasticSearch
	tar -zxvf elasticsearch*.tar.gz -C ~/OAE
	#ElasticSearch------------------
    fi
    if [[ $var == *"RabbitMQ"* ]]
    then	
	#RabbitMQ-----------------------
	su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm'
	sudo yum install -y erlang
	sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	sudo rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.4/rabbitmq-server-3.1.4-1.noarch.rpm
	#RabbitMQ-----------------------
    fi
    if [[ $var == *"GraphicsMagick"* ]]
    then	
	#GraphicsMagick-----------------
	sudo yum install -y gcc libpng libjpeg libpng-devel libjpeg-devel ghostscript
	sudo yum install -y libtiff libtiff-devel freetype freetype-devel
	wget ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/1.3/GraphicsMagick-1.3.20.tar.gz #GraphicsMagick
	tar -zxvf GraphicsMagick*.tar.gz -C ~/OAE
	cd ~/OAE/GraphicsMagick-1.3.20
	./configure --enable-shared
	make
	sudo make install
	cd ~/Downloads
	#GraphicsMagick-----------------
    fi
    if [[ $var == *"PreviewProcessor"* ]]
    then	
	#Preview-Processor--------------
	#pdf2htmlEX---------------------
	#pdf2htmlEX---------------------
        echo "Preview Processor not Avalable"
	#LibreOffice--------------------
	#LibreOffice--------------------
	#Preview-Processor--------------
    fi
    if [[ $var == *"Nginx"* ]]
    then	
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
    fi
    if [[ $var == *"Etherpad"* ]]
    then	
	#Etherpad-lite------------------
	cd ~/OAE/
	sudo yum install -y gzip git curl python openssl-devel && yum groupinstall -y "Development Tools"
	git clone git://github.com/ether/etherpad-lite.git
	cd etherpad-lite
	git fetch --tags
	git checkout tags/1.4.0
	bin/run.sh
	cd node_modules
	git clone https://github.com/oaeproject/ep_oae
	cd ep_oae
	npm install
	cp static/css/pad.css ~/OAE/etherpad-lite/src/static/custom/pad.css
	cd ~/OAE/etherpad-lite
	sed -i "s/\"xhr-polling/\"websocket\"\, \"xhr-polling/g" settings.json
	sed -i '/defaultPadText/c \"defaultPadText\"\ \:\ \"\",' settings.json
	#EtherPad-lite------------------
    fi
    if [[ $var == *"Hilary"* ]]
    then	
	#Hilary/3akai-ux----------------
	cd ~/OAE
	git clone git://github.com/oaeproject/Hilary.git
	git clone git://github.com/oaeproject/3akai-ux.git
	sudo bash -c "echo '127.0.0.1  admin.oakland.edu' >> /etc/hosts"
	sudo bash -c "echo '127.0.0.1  oae.oakland.edu' >> /etc/hosts"
	mkdir /home/oae/OAE/uploads
	mkdir /home/oae/OAE/files
	cd Hilary
	sed -i "/uploads'/c'uploadsDir': '/home/oae/OAE/uploads'," config.js
	sed -i 's/admin.oae.com/admin.oakland.edu/g' config.js
	APIKEY=$(cat /home/oae/OAE/etherpad-lite/APIKEY.txt)
	sed -i "/'apikey'/c'apikey': '$APIKEY'," config.js
	#TODO(erik): enable prevew processing when implimented
	cd ~/OAE/3akai-ux/nginx/
	sed -i 's/<%= nginxConf.NGINX_USER %>/oae/g' nginx.conf
	sed -i 's/<%= nginxConf.NGINX_GROUP %>/oae/g' nginx.conf
	sed -i 's/<%= nginxConf.NGINX_HOSTNAME %>/admin.oakland.edu/g' nginx.conf
	sed -i 's/<%= nginxConf.UX_HOME %>/\/home\/oae\/OAE\/3akai-ux/g' nginx.conf
	sed -i 's/<%= nginxConf.LOCAL_FILE_STORAGE_DIRECTORY %>/\/home\/oae\/OAE\/files/g' nginx.conf
	cd ~/OAE/Hilary
	npm install -d
	#Hilary/3akai-ux----------------
    fi
    echo "$var"
done
