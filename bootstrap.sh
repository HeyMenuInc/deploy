#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

# install add-apt-repositories tool
#apt-get install python-software-properties

# add repo for java7
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update

#apt-get install -y emacs

echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
apt-get install -q -y oracle-java7-installer

# Install maven
apt-get install -y maven

# Install sqlite3
apt-get install -y sqlite3

mkdir /var/lib/sqlite
chmod a+w /var/lib/sqlite

# Install apache
apt-get install -y apache2

apt-get install -y tomcat7
echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7
sed -i 's/\\\"\$CATALINA_SH\\\" \$\@\"/\"$CATALINA_SH\" jpda $@\"/g' /etc/init.d/tomcat7
service tomcat7 start

# Enable header mod
a2enmod headers

# Install mod_jk
apt-get install -y libapache2-mod-jk
sed -i '{:a;N;$!ba;s/<\!--\n    <Connector port=\"8009\" protocol=\"AJP\/1.3\" redirectPort=\"8443\" \/>\n    -->/<Connector port=\"8009\" protocol=\"AJP\/1\.3\" redirectPort=\"8443\" \/>/g;t a}' /etc/tomcat7/server.xml
cp /vagrant/apache2/workers.properties /etc/libapache2-mod-jk/

# Install mod_proxy
apt-get install -y libapache2-mod-proxy-html
a2enmod proxy
a2enmod proxy_http

# Enable main web app and admin tool site
rm /etc/apache2/sites-enabled/000-default
cp /vagrant/apache2/emenu-server /etc/apache2/sites-available/
ln -s /etc/apache2/sites-available/emenu-server /etc/apache2/sites-enabled/emenu-server
cp /vagrant/apache2/emenu-admintool /etc/apache2/sites-available/
ln -s /etc/apache2/sites-available/emenu-admintool /etc/apache2/sites-enabled/emenu-admintool

# Link tomcat site to server build dir
service tomcat7 stop

rm -rf /var/lib/tomcat7/webapps/ROOT
ln -sf /home/vagrant/emenu_server/target/CloudMenuServer /var/lib/tomcat7/webapps/ROOT

service tomcat7 start
service apache2 restart
