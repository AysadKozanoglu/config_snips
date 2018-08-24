#! /bin/sh
# author: Aysad Kozanoglu
# email: aysadx@gmail.com
# usage: 
#  wget -O - https://git.io/fAtDW | bash
echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
cd /tmp
wget https://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg
apt-get update
apt-get -y install php7.0-common php7.0-fpm php7.0-cli php7.0-json php7.0-imap php7.0-mysql php7.0-curl php7.0-imap php7.0-intl php7.0-mcrypt php-pear php7.0-gd php7.0-zip php7.0-xml php7.0-mbstring
dpkg -l | grep php7 
/etc/init.d/php7.0-fpm start ; /etc/init.d/php7.0-fpm status
