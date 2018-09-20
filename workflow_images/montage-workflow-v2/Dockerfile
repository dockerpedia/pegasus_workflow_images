FROM debian:9

LABEL maintainer "Mats Rynge <rynge@isi.edu>"

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        gfortran \
        gnupg \
        libmariadbclient18 \
        libpq5 \
        locales \
        locales-all \
        openjdk-8-jre \
        pkg-config \
        python \
        python-astropy \
        python-future \
        python-dev \
        python-pip \
        unzip \
        vim \
        wget \
        git

#install pegasus
RUN     wget -O - http://download.pegasus.isi.edu/pegasus/gpg.txt | apt-key add - && \
        echo 'deb http://download.pegasus.isi.edu/wms/download/debian stretch main' > \
        /etc/apt/sources.list.d/pegasus.list && \
        apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y pegasus

RUN useradd  -ms /bin/bash appuser
WORKDIR /home/appuser
USER appuser
ADD --chown=appuser:appuser . /home/appuser/

RUN wget https://codeload.github.com/Caltech-IPAC/Montage/zip/master && \
    unzip master && \
    rm -f master && \
    mv Montage-master Montage && \
    cd Montage && \
    make

# install Montage
RUN mkdir montage-workflow-v2
ADD . montage-workflow-v2/ 
ENV PATH /home/appuser/Montage/bin/:$PATH
