#!/bin/bash
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

while IFS= read -r line
do
  strip=$(echo $line|sed 's/https\?:\/\///')
  echo "${GREEN}Ports for $line ${RESET}\n"
  host $line
  masscan -p1-9999 $(dig +short $strip|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1) --max-rate 10000
done < $1
