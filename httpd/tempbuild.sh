#!/bin/bash
docker kill httpd
docker rm httpd
docker build -t httpd .
sudo rm -rf /Users/einolfs/docker_volumes/metastatic/*
docker run --name httpd -p 80:80 -d httpd

