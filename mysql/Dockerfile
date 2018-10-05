FROM cbiit/centos7:base
MAINTAINER Shaun Einolf

LABEL \
  BASE_OS="CBIIT CentOS 7" \
  DEFAULT_IMAGE="cbiit/centos7" \
  DEFAULT_TAG="centos7" \
  DESCRIPTION="Deployment environment for drupal (based on CentOS 7)" \
  VERSION="1.0" \
  UID="DRUPAL_1.0_C7"

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum install -y yum-plugin-ovl
RUN yum -y update
RUN yum -y install \
    mariadb-server \
    mariadb-client \
    vi

ADD run.sh /usr/bin/
RUN chmod 777 /usr/bin/run.sh

# expose mysql port #
EXPOSE 3306

# start php fpm and supervisor #
ENTRYPOINT ["/usr/bin/run.sh"]
