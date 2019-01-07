#!/usr/bin/env bash

sudo apt-get update -y

which  wget nginx vim openjdk-8-jdk &>/dev/null || {
  sudo apt-get install -y wget nginx vim openjdk-8-jdk
}

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

sudo apt-get install apt-transport-https -y

echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list

apt-get update && apt-get install logstash -y

#apt-get install filebeat -y
#apt-get update
#dpkg -i /vagrant/soft/logstash-6.5.4.deb

# Configure Logstash
systemctl daemon-reload
systemctl enable logstash
cp /vagrant/conf/logstash.conf /etc/logstash/conf.d/logstash.conf
systemctl start logstash

cp /vagrant/conf/nginx_logs.service /etc/systemd/system/nginx_logs.service
systemctl daemon-reload
systemctl enable nginx_logs.service
systemctl start nginx_logs.service
