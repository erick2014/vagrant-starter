#!/usr/bin/env bash

apt-get update

#this is just for vagrant box locale config
apt-get install -y language-pack-en

locale-gen en_US.UTF-8

dpkg-reconfigure locales 

#install apache
apt-get install -y apache2
#symlink the root folder for apache
rm -rf /var/www/html
ln -fs /vagrant /var/www/html
echo "<html><head><title>indexpage</title></head> <body> <p>lol</p> </body> </html>" > /var/www/html/index.html

#copy the virtualhost
touch /etc/apache2/sites-available/dev.athleticgreens.com.conf

cp /vagrant/dev.athleticgreens.com.conf /etc/apache2/sites-available/
cp /vagrant/dev.agtest.com.conf /etc/apache2/sites-available/
cp /vagrant/apache2.conf /etc/apache2/apache2.conf

echo "------------installing git-------------"
apt-get install -y git

#install php
echo "-----------installing php------------"
apt-get install -y php5 php5-mysql libapache2-mod-php5 php5-mcrypt php5-curl -y 

#enable mcrypt 
php5enmod mcrypt

#enable modrewrite module
a2enmod rewrite

#enable the virtual host
a2ensite dev.athleticgreens.com.conf
a2ensite dev.agtest.com.conf

#restart apache server
service apache2 restart 

#install composer
echo "-------installing composer-------" 
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/bin --filename=composer

#remember to do vagrant reload once all process has finished