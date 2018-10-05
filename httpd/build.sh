#!/bin/bash
rm -rf $3
docker kill $1
docker rm $1
docker build -t httpd .
IPAddress=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' maria)
#$2 is port, $1 is site/database name#
docker run --name $1 -v $3:/var/www/html -e IPADDRESS=$IPAddress -p $2:80 -e DB=$1 -d httpd


