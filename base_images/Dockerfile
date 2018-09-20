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

ENV WORKFLOW_USER workflow
ENV GID 1000
ENV UID 1000
ENV PASS 123456

RUN apt-get install openssh-server supervisor -y && \
    groupadd -g ${GID} ${WORKFLOW_USER} && \
    useradd -m -u ${UID} -g ${GID} ${WORKFLOW_USER} && \
    usermod -a -G condor ${WORKFLOW_USER} && \
    echo "root:${PASS}" | chpasswd  && \
    mkdir /home/${WORKFLOW_USER}/example && \
    mkdir /run/sshd/ /run/condor && \
    chown condor:condor /run/condor && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime 

COPY condor_config.docker_image /etc/condor/config.d/
COPY start-condor.sh /usr/sbin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER ${WORKFLOW_USER}
RUN mkdir ~/.ssh/ && \
    chmod 700 ~/.ssh/ && \ 
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N "" && \
    cat ~/.ssh/id_rsa.pub >>  ~/.ssh/authorized_keys && \
    chmod 600 ~/.ssh/authorized_keys && \
    echo "Host *\nStrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" > ~/.ssh/config 

USER root
VOLUME ["/home/${WORKFLOW_USER}/submit"]
WORKDIR /home/${WORKFLOW_USER}/submit
CMD ["/usr/bin/supervisord"]
