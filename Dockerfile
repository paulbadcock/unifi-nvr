FROM ubuntu:16.04
MAINTAINER paul@bad.co.ck

# Install Pre-reqs
RUN apt-get update && apt-get install -y \
  wget \
  apt-utils \ 
  openjdk-8-jre-headless \
  && rm -rf /var/lib/apt/lists/*

# Add NVR Start-up
ADD start_nvr.sh /

# Install NVR
CMD wget -q -O unifi-video.deb https://dl.ubnt.com/firmwares/ufv/v3.8.3/unifi-video.Ubuntu16.04_amd64.v3.8.3.deb
CMD dpkg -i unifi-video.deb
CMD apt-get -f install -y

# set start_nvr.sh executable 
CMD chmod +x /start_nvr.sh

#clean up
CMD rm unifi-video.deb

# Volumes
VOLUME /var/lib/unifi-video  
VOLUME /var/log/unifi-video

# Ports
EXPOSE 7442 7443 7445 7446 7447 7080 6666

# start NVR
CMD ["sh","/start_nvr.sh"]
