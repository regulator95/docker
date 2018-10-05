FROM jenkins:latest
USER root
RUN apt-get update && apt-get install -y \
	openjdk-8-jdk-headless \
	maven
EXPOSE 8080 50000
