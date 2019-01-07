#!/usr/bin/env bash

sudo apt-get update -y

sudo apt install openjdk-8-jdk wget apt-transport-https wget curl vim -y

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update && sudo apt-get install -y elasticsearch kibana

#dpkg -i /vagrant/soft/elasticsearch-6.5.4.deb
#dpkg -i /vagrant/soft/kibana-6.5.4-amd64.deb

sed -i "s/#network.host:.*/network.host: 0.0.0.0/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/#http.port:.*/http.port: 9200/" /etc/elasticsearch/elasticsearch.yml

sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
curl -X PUT http://localhost:9200/_all/_settings -H 'Content-Type: application/json' -d'{ "index.blocks.read_only_allow_delete" : false } }'

sed -i "s/#server.port:.*/server.port: 5601/" /etc/kibana/kibana.yml
#sed -i -e 's/#elasticsearch.url: "http:\/\/localhost:9200"/elasticsearch.url: "http:\/\/localhost:9200"/g' /etc/kibana/kibana.yml
#sed -i -e 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' /etc/kibana/kibana.yml

sudo systemctl daemon-reload
sudo systemctl enable kibana
sudo systemctl start kibana

sudo apt-get install nginx apache2-utils -y

cat <<EOF >/etc/nginx/sites-available/kibana
server {
    listen 80;
    server_name 192.168.56.57;
    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

ln -s /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/

sudo nginx -t

sudo systemctl enable nginx
sudo systemctl start nginx

sleep 10

sudo systemctl restart nginx


