# BLESTA AUTO INSTALLER SCRIPT
### nginx + php7 + letsencrypt + ionCube + MySQL

Blesta version : blesta-4.3.2

script will install with compiling nginx from source and php7, mysql, ionCube, certbot (letsencrypt from git) repo

USAGE:
```
 wget -O - https://git.io/fA0jz | bash
```

Production ready -> Tested on Debian Jessie 8.11(recommended)

Info: it is good to install on fresh installed debian


The auto instalaltion script do following:
- installatin of mysql
- php7 (with needed extension)
- ioncube
- nginx compile installation
- blesta configurations for php7
- download and unpack blesta script
- hotfixing blesta for php7
- letsencrypt for the domain


Aysad Kozanoglu
