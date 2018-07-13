FROM python:3.6-stretch

MAINTAINER OpenLab <ezkissel@indiana.edu>

RUN apt-get update
RUN apt-get -y install sudo cmake gcc libaprutil1-dev vim libapr1-dev mongodb lldpd redis-server python-setuptools python-pip python-m2crypto supervisor 

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

#RUN git config --global user.email "grantskipper17@gmail.com"
#RUN git config --global user.name "gskip17"

#RUN git clone -b develop https://github.com/periscope-ps/unis
RUN git clone -b develop https://github.com/periscope-ps/unisrt
RUN git clone -b master https://github.com/periscope-ps/lace
RUN git clone -b master https://github.com/gskip17/topology.git

ADD build.sh .
RUN bash ./build.sh

#RUN mkdir $HOME/.periscope

#ADD unis.conf /etc/supervisor/conf.d/
#ADD .rtcache $HOME/.periscope/.rtcache
#ADD .cache $HOME/.periscope/.cache/
#RUN sudo chown -R osiris:osiris $HOME/.periscope/.rtcache
#RUN sudo chown -R osiris:osiris $HOME/.periscope/.cache/
#RUN sudo chmod 775 -R $HOME/.periscope/.rtcache
#RUN sudo chmod 775 -R $HOME/.periscope/.cache/

ADD ryu.conf /etc/supervisor/conf.d/
ADD osiris-sdn-app.conf /etc/ryu/

ENV DEBUG DEBUG
ADD run.sh .
CMD bash ./run.sh
