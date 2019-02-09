#!/bin/sh
# Usage: pidiotop.sh <PID>
# Example: pidiotop.sh $(pgrep -n dd)
# Requires: bc
# apt-get install bc -y 

set -ue
pid="${1}"
interval=10
bbytes=
bytes=
while true; do
        bbytes="${bytes}"
        bytes=$(awk -v rbytes='read_bytes:' '$1 == rbytes { print $2; exit}' "/proc/${1}/io")
        if [ -n "${bbytes}" ]; then
                mbs=$(echo "(${bytes}-${bbytes})/${interval}/1000/1000" | bc -l)
                printf "\r${mbs}MB/s"
        fi
        sleep "${interval}"s
done
