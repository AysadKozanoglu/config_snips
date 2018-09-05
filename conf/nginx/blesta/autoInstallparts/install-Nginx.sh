#! /bin/sh
# author: Aysad Kozanoglu
# email: aysadx@gmail.com
#
# wget -O - https://git.io/fAcPN | bash

echo -e "install core packages...\n"
apt-get -qq -y install build-essential git
apt-get -qq -y install libpcre3 libpcre3-dev zlib1g zlib1g-dev
cd /tmp

# wget -q http://nginx.org/download/nginx-1.12.1.tar.gz
wget -q https://git.io/fAEv7

# wget -q https://ftp.openssl.org/source/old/0.9.x/openssl-0.9.8zf.tar.gz
wget -q https://git.io/fAEvp

tar zxvf nginx-1.12.1.tar.gz && tar zxvf openssl-0.9.8zf.tar.gz
cd nginx-1.12.1 && ./configure --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt=-Wl,-z,relro --sbin-path=/usr/local/sbin --with-http_stub_status_module --with-http_ssl_module --user=www-data --group=www-data --with-openssl=/tmp/openssl-0.9.8zf/ --with-stream && make && make install
echo -e "nginx installed\n"
