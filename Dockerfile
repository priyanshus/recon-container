FROM golang

RUN apt-get update \
    && apt-get -y upgrade
RUN apt-get install -y git curl wget nmap python3.7 python3-pip vim

RUN go get -v -u github.com/OWASP/Amass/v3/... \
    && cd $GOPATH/src/github.com/OWASP/Amass \
    && go install ./...

RUN go get github.com/tomnomnom/waybackurls \
  && go get -u github.com/tomnomnom/httprobe \
  && go get -u github.com/tomnomnom/assetfinder \
  && go get -u github.com/lc/gau \
  && go get -u github.com/OJ/gobuster \
  && go get -u github.com/michenriksen/aquatone

RUN mkdir tools \
  && cd tools \
  && git clone https://github.com/maurosoria/dirsearch.git \
  && git clone https://github.com/aboul3la/Sublist3r.git \
  && cd Sublist3r \
  && pip3 install -r requirements.txt

RUN mkdir utils
COPY utils/check-url-status.py ./utils
COPY utils/recon.sh ./utils
