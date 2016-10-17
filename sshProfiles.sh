#! /bin/bash
#
# coder: Aysad Kozanoglu
# email : aysadx@gmail.com
# web: http://onweb.pe.hu
#

sn[0]='server title'
sl[0]='root@<ip-adress>'
sp[0]='<port>'
#sn[1]=''
#sl[1]=''
#sp[1]=''

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo ""
echo "waehle ein server:"
echo "" && echo ""
a=0
for i in "${sn[@]}"
do
 echo  $a"." ${sn[a]} " "${sn[a]}
 ((a++))
done

 tput setaf 2; read -p "zu Welchem Server ?" y
echo ""
echo "verbinde zur "${sl[y]}
  ssh -p ${sp[y]} ${sl[y]}
exit
