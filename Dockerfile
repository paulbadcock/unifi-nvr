FROM ubuntu:16.04
MAINTAINER paul@bad.co.ck
ENV UNIFI_VER 3.8.5

# Install Pre-reqs
RUN apt-get update && apt-get install -y \
  wget \
  apt-utils \ 
  openjdk-8-jre-headless \
  && rm -rf /var/lib/apt/lists/*

# Add NVR Start-up
ADD start_nvr.sh /

# Install NVR
RUN wget -q -O unifi-video.deb https://dl.ubnt.com/firmwares/ufv/v${UNIFI_VER}/unifi-video.Ubuntu16.04_amd64.v${UNIFI_VER}.deb && \
  apt-get update && apt-get install -y ./unifi-video.deb \
  && rm -rf /var/lib/apt/lists/* \
  && rm -f unifi-video.deb

# set start_nvr.sh executable 
RUN chmod +x /start_nvr.sh

# Volumes
VOLUME /var/lib/unifi-video  
VOLUME /var/log/unifi-video

# Ports
EXPOSE 7442 7443 7445 7446 7447 7080 6666

# start NVR
CMD ["sh","/start_nvr.sh"]
