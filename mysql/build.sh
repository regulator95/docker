docker build -t maria .
docker kill maria
docker rm maria
docker run --name maria -e MYSQL_USER=mysql -e MYSQL_PASSWORD=DBAdmin1 -p 3306:3306 -d maria
