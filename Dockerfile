FROM python:3.6-stretch

MAINTAINER OpenLab <ezkissel@indiana.edu>

RUN apt-get update
RUN apt-get -y install sudo cmake gcc libaprutil1-dev vim libapr1-dev mongodb lldpd python-setuptools python-pip supervisor 

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/osiris && \
    echo "osiris:x:${uid}:${gid}:OSIRIS,,,:/home/osiris:/bin/bash" >> /etc/passwd && \
    echo "osiris:x:${uid}:" >> /etc/group && \
    echo "osiris ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/osiris && \
    chmod 0440 /etc/sudoers.d/osiris && \
    chown ${uid}:${gid} -R /home/osiris && \
    chown ${uid}:${gid} -R /opt
    
USER osiris
ENV HOME /home/osiris
WORKDIR $HOME

RUN git clone -b develop https://github.com/periscope-ps/unisrt
RUN git clone -b master https://github.com/periscope-ps/lace
RUN git clone -b master https://github.com/gskip17/topology.git

ADD build.sh .
RUN bash ./build.sh

ADD ryu.conf /etc/supervisor/conf.d/
ADD osiris-sdn-app.conf /etc/ryu/

ENV DEBUG DEBUG
ADD run.sh .
CMD bash ./run.sh
