#!/usr/bin/env bash

apt-get update

#install apache
apt-get install -y apache2
rm -rf /var/www/html
ln -fs /vagrant /var/www/html

echo "<html><head><title>indexpage</title></head> <body> <p>lol</p> </body> </html>" > /var/www/html/index.html

#copy the virtualhost
touch /etc/apache2/sites-available/dev.athleticgreens.com.conf

cp /vagrant/hostfile /etc/apache2/sites-available/dev.athleticgreens.com.conf

echo "------------installing git-------------"
apt-get install -y git

#install php
echo "-----------installing php------------"
apt-get install -y php5 php5-mysql libapache2-mod-php5 php5-mcrypt php5-curl -y 

#enable mcrypt 
php5enmod mcrypt

#enable modrewrite module
a2enmod rewrite

#restart apache server
service apache2 restart 

#install composer
echo "-------installing composer-------" 
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/bin --filename=composer

