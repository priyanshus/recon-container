#!/bin/bash
echo "*****************Finding Subdomains*********************"
workdir=~/projects
mkdir -p $workdir/$1/tmp
touch $workdir/$1/tmp/$1.txt
amass enum -d $1 |tee -a $workdir/$1/tmp/$1.txt
subfinder -d $1 |tee -a $workdir/$1/tmp/$1.txt
cat $workdir/$1/tmp/$1.txt | sort | uniq > $workdir/$1/scan-result.txt

echo "*****************Bruteforcing SubDomains****************"
gobuster dns -d $1 -w ~/tools/massdns/lists/names.txt -t 200 -o $workdir/$1/bruteforce-result.txt $2

echo "*****************HttpProbe for Subdomains***************"
cat $workdir/$1/scan-result.txt | httprobe -p 8080,80,443 | tee -a $workdir/$1/httprobe-result.txt

echo "*****************Generate DNS***************************"
dnsgen -f $workdir/$1/scan-result.txt | tee -a $workdir/$1/tmp-subdomains.txt
massdns -r ~/tools/massdns/lists/resolvers.txt -t AAAA  $workdir/$1/tmp-subdomains.txt > $workdir/$1/dnsgenerate-result.txt

echo "*****************Cleanup*******************************"
rm $workdir/$1/tmp-subdomains.txt
