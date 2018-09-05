#!/bin/sh
#
# author: Aysad Kozanoglu
# email: aysadx@gmail.com
#

read -p "give the domainname: " DOMAIN
read -p "give the email for ssl: " EMAIL

wget -O - https://git.io/fAcPN | bash
wget -O - https://git.io/fAtDW | bash

IONPATH=$(php -i | grep extension_dir | awk {'print $3'})
IONFILE="ioncube_loader_lin_7.0.so"
EXTENSION=${IONPATH}/${IONFILE}
WEBPATH="/usr/local/nginx/html"

cd /tmp;
# wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
wget https://git.io/fAEfH
tar zxvf ioncube_loaders_lin_x86-64.tar.gz
cp ioncube/${IONFILE} ${IONPATH}

echo -e "\n" >> /etc/php/7.0/fpm/php.ini; echo "zend_extension = ${EXTENSION}" >> /etc/php/7.0/fpm/php.ini
echo -e "\n" >> /etc/php/7.0/cli/php.ini; echo "zend_extension = ${EXTENSION}" >> /etc/php/7.0/cli/php.ini 

/etc/init.d/php7.0-fpm restart

debconf-set-selections <<< 'mysql-server mysql-server/root_password password r00t'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password r00t'

apt-get -y -q install mysql-server git unzip

config:
echo -e "\n getting configurations"

mkdir /usr/local/nginx/conf/conf.d  /usr/local/nginx/conf/vservers
wget -O /usr/local/nginx/conf/nginx.conf https://git.io/fAnMr
wget -O /usr/local/nginx/conf/conf.d/phpbalancer.conf https://git.io/fAn1A
wget -O /usr/local/nginx/conf/conf.d/phpvhost.conf  https://git.io/fAn1D
wget -O /usr/local/nginx/conf/vservers/vesta.conf https://git.io/fAnMc

nginx -s stop
killall nginx

if [ ! -d /sources ]; then mkdir /source;fi; cd /source;

git clone https://github.com/certbot/certbot && cd certbot;

echo -e "certbot ssl generation\n"
./certbot-auto certonly --non-interactive --authenticator standalone --text --expand --agree-tos --keep-until-expiring  --email ${EMAIL} -d ${DOMAIN}

echo -e "replace example with orginal domain"
sed -i 's/example.com/${DOMAIN}/g' /usr/local/nginx/conf/vservers/vesta.conf

echo -e "\n diffie hellmann generation \n"
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

cd ${WEBPATH}
# wget https://account.blesta.com/client/plugin/download_manager/client_main/download/116/blesta-4.3.2.zip
wget https://git.io/fAEv9

unzip blesta-4.3.2.zip
cp -R ${WEBPATH}/hotfix-php7/blesta/* ${WEBPATH}/blesta/
chown -R www-data:www-data ${WEBPATH}/blesta ${WEBPATH}/blesta/*

NGINXBIN=$(which nginx)
$NGINXBIN -s reload
/etc/init.d/php7.0-fpm restart
/etc/init.d/mysql restart

/etc/init.d/mysql status
/etc/init.d/php7.0-fpm status
$NGINXBIN -t

echo -e "\n END of Installation\n "
