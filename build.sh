#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  errorMessage="Build requires a sitename and port as follows: ./build sitename 8080 volumedirectory (/root/docker_volumes/sitename)"
  echo $errorMessage
else
  echo "Checking existence of database"
  database="$(docker ps --format="{{.Names}} {{.Ports}}" | grep 3306 | awk '{print $1;}')"
  if [ -z "$database" ]
    then
      echo "database does not exist let us create it"
      cd mysql
      ./build.sh
      cd ..
  else
    echo "database exists. try and start it"
    docker start $database
  fi
  echo "starting database"
  sleep 5
  cd httpd

  echo "Building site $1"
  ./build.sh $1 $2 $3

fi