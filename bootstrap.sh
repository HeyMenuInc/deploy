#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

# add repo for java7
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update

#apt-get install -y emacs

echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
apt-get install -q -y oracle-java7-installer

mkdir /var/lib/sqlite
chmod a+w /var/lib/sqlite

apt-get install -y tomcat7
echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7
service tomcat7 start

rm -rf /var/lib/tomcat7/webapps/ROOT
ln -sf /home/vagrant/emenu_server/target/CloudMenuServer /var/lib/tomcat7/webapps/ROOT

service tomcat7 restart
