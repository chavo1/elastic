#!/usr/bin/env bash

yum update -y

yum install wget vim curl -y

yum install java-1.8.0-openjdk -y

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.5.4.rpm

rpm --install elasticsearch-6.5.4.rpm

systemctl daemon-reload
systemctl enable elasticsearch
sed -i 's/#network.host: 192.168.0.1/network.host: ["localhost", "192.168.56.56"]/g' /etc/elasticsearch/elasticsearch.yml
systemctl start elasticsearch

wget https://artifacts.elastic.co/downloads/logstash/logstash-6.5.4.rpm

rpm --install logstash-6.5.4.rpm
systemctl enable logstash
cd /etc/logstash/conf.d
wget http://github.com/linuxacademy/content-elastic-log-samples/raw/master/apache.conf
systemctl start logstash

cd ~
mkdir -p /var/log/apache2
cd /var/log/apache2
wget http://github.com/linuxacademy/content-elastic-log-samples/raw/master/access.log
cd ~

wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.5.4-x86_64.rpm
rpm --install filebeat-6.5.4-x86_64.rpm
systemctl enable filebeat

rm /etc/filebeat/filebeat.yml
cp /vagrant/conf/filebeat.yml /etc/filebeat/filebeat.yml
filebeat setup
filebeat modules enable apache2
systemctl start filebeat

wget https://artifacts.elastic.co/downloads/kibana/kibana-6.5.4-x86_64.rpm
rpm --install kibana-6.5.4-x86_64.rpm
systemctl enable kibana
systemctl start kibana