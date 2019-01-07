# This repo contain an Elastic Stack example configuration on two vagrant boxes with NGINX logs redirected to Elasticsearch

## Prerequisite

- [Vagrant](https://www.vagrantup.com/) installed
- Basic knowledge about the Elastic Stack

## Clone the repo

```
git clone https://github.com/chavo1/elastic.git
cd elastic/elastic-nginx
vagrant up
```
## A following software will be installed on CentOS7 
- [Elasticsearch](https://www.elastic.co/products/elasticsearch)
- [Logstash](https://www.elastic.co/products/logstash)
- [Kibana](https://www.elastic.co/products/kibana)

## When Vagrant provision the VMs

- To access a Kibana UI open a Web browser of your choice and login in Kibana http://192.168.56.57

## Now we need logs to be generated

- Open a Web browser of your choice, The address of NGINX server will be http://192.168.56.56
- Now we need to generate a logs. This can be done by typing an address that not exist - for example:

http://192.168.56.56/whatever






