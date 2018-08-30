#! /bin/sh
# author: Aysad Kozanoglu
# email: aysadx@gmail.com
#
echo -e "install core packages...\n"
 apt-get -qq -y install build-essential git
 apt-get -qq -y install libpcre3 libpcre3-dev zlib1g zlib1g-dev
 cd /tmp
 wget -q http://nginx.org/download/nginx-1.12.1.tar.gz
 wget -q http://s.tip90.com/source/packages/openssl-0.9.8zf.tar.gz && tar zxvf nginx-1.12.1.tar.gz && tar zxvf openssl-0.9.8zf.tar.gz && cd nginx-1.12.1 && ./configure --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt=-Wl,-z,relro --sbin-path=/usr/local/sbin --with-http_stub_status_module --with-http_ssl_module --user=www-data --group=www-data --with-openssl=/source/openssl-0.9.8zf/ --with-stream
 make && make install
 echo -e " set sysconf tuning \n"
 wget -O /etc/sysctl.conf "https://raw.githubusercontent.com/AysadKozanoglu/mytools/master/conf/sysctl.conf"
 sysctl -p /etc/sysctl.conf
 
echo -e "nginx php mysql installed\n"
