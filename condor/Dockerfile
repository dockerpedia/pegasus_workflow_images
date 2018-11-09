FROM debian:9

LABEL maintainer "Maximiliano Osorio <mosorio@inf.utfsm.cl>"

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Pegasus" \
      org.label-schema.description="Pegasus is a WMS able to manage workflows comprised of mil- lions of tasks, recording data about the execution and intermediate results. This image installs and uses Condor as the scheduler." \
      org.label-schema.url="https://pegasus.isi.edu/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/dockerpedia/pegasus_workflow_images" \
      org.label-schema.vendor="DockerPedia" \
      org.label-schema.version="1.0" \
      org.label-schema.schema-version="1.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        gnupg

#install pegasus
RUN wget -O - http://download.pegasus.isi.edu/pegasus/gpg.txt | apt-key add - && \
        echo 'deb http://download.pegasus.isi.edu/wms/download/debian stretch main' > \
        /etc/apt/sources.list.d/pegasus.list && \
        apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends pegasus condor && \
        rm -rf /var/lib/apt/lists/*

ENV WORKFLOW_USER workflow
ENV GID 1000
ENV UID 1000

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssh-server \
        supervisor && \
    groupadd -g ${GID} ${WORKFLOW_USER} && \
    useradd -m -u ${UID} -g ${GID} ${WORKFLOW_USER} && \
    usermod -a -G condor ${WORKFLOW_USER} && \
    mkdir /home/${WORKFLOW_USER}/example && \
    mkdir /run/sshd/ /run/condor && \
    chown condor:condor /run/condor && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    rm -rf /var/lib/apt/lists/* && \
    chmod o+rw /opt/

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
VOLUME ["/home/${WORKFLOW_USER}/out"]
WORKDIR /home/${WORKFLOW_USER}/
CMD ["/usr/bin/supervisord"]
