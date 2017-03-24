 #!/bin/sh
#
#    Aysad Kozanoglu
#  simple json encoding
#
#  web: aysad.pe.hu
# mail: aysadx@gmail.com
#
# Version Date: 24.03.2017
#
# exmaple:
# 
# echo a 1 b 2 c 3 | ./json.sh 
#
# Output:
# {'a': '1', 'b': '2', 'c': 'e'}
#


arr=();

while read x y; 
do 
    arr=("${arr[@]}" $x $y)
done

vars=(${arr[@]})
len=${#arr[@]}

printf "{"
for (( i=0; i<len; i+=2 ))
do
    printf "'${vars[i]}': '${vars[i+1]}'"
    if [ $i -lt $((len-2)) ] ; then
        printf ", "
    fi
done
printf "}"
echo
