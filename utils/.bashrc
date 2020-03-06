alias l="ls -ll"

function gbdir() {
  gobuster dir -u $1 -w $2 -t 50 $3
}

function dirsearch() {
  python3 tools/dirsearch/dirsearch.py -u $1 -e * -t 50 $2
}

function subdomains() {
  mkdir /bb-projects/$1
  assetfinder $1 | httprobe | tee -a /bb-projects/$1/$1-all.txt
}
