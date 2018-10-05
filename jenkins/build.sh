#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Build should be as follows: ./build.sh name port1 port2, where port 1 is bound to 8080 and port 2 is bound to 50000"
else
  docker build -t jenkins .
  echo $1 $2 $3
  docker run --name $1 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -p $2:8080 -p $3:50000 -d jenkins
fi
