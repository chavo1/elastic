# This repo contain an Elastic Stack example configuration

## Prerequisite

- [Vagrant](https://www.vagrantup.com/) installed
- Basic knowledge about the Elastic Stack

## Clone the repo

```
git clone https://github.com/chavo1/elastic.git
cd elastic/elastic-single-node
vagrant up
```
## A following software will be installed on CentOS7 
- [Elasticsearch](https://www.elastic.co/products/elasticsearch)
- [Logstash](https://www.elastic.co/products/logstash)
- [Kibana](https://www.elastic.co/products/kibana)
- [Filebeat](https://www.elastic.co/products/beats/filebeat)

## 


```
$ ssh vagrant@192.168.56.56 -L 5601:localhost:5601
vagrant@192.168.56.56's password: vagrant
```
Than open the browser and login in Kibana http://localhost:5601