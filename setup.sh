#!/bin/bash

apt-get update

#	Install tools
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

#	Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

#	Setup stable repo
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


apt-get update \
    -y upgrade

apt-get install -y git \
               curl \
               wget \
               nmap \
               python3.7 \
               vim \
               python3-pip

# Install Amass
go get -v -u github.com/OWASP/Amass/v3/... \
&& cd $GOPATH/src/github.com/OWASP/Amass \
&& go install ./...

cd /go/
## Install Go based tools
go get github.com/tomnomnom/waybackurls \
&& go get -u github.com/tomnomnom/httprobe \
&& go get -u github.com/tomnomnom/assetfinder \
&& go get -u github.com/lc/gau \
&& go get -u github.com/OJ/gobuster \
&& go get -u github.com/michenriksen/aquatone

# Install other tools in tools directory
mkdir tools \
&& cd tools \
&& git clone https://github.com/maurosoria/dirsearch.git \
&& git clone https://github.com/aboul3la/Sublist3r.git \
&& git clone https://github.com/danielmiessler/SecLists.git

# Setup Sublist3r
&& cd tools/Sublist3r \
&& pip3 install -r requirements.txt
