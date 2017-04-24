#!/bin/bash
dialog --title "HLSPANEL.COM installation Path" \
--backtitle "HLSPANEL installation " \
--yesno "Would you like to install hlspanel on your serve  \"/home/hlspanel/\"?" 17 60


#  
# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
response=$?
case $response in
   0) echo "File deleted.";;
   1) echo "File not deleted.";;
   255) echo "[ESC] key pressed.";;
esac
