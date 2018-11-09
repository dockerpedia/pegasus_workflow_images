FROM debian:9

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

LABEL maintainer "Maximiliano Osorio <mosorio@inf.utfsm.cl>"



RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
    gnupg && \
        rm -rf /var/lib/apt/lists/*

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Pegasus is a WMS able to manage workflows comprised of mil- lions of tasks, recording data about the execution and intermediate results. This image does not installs Condor as the scheduler." \
      org.label-schema.description="The Montage workflow was created by the NASA Infrared Processing and Analysis Center (IPAC) as an open source toolkit that can be used to generate custom mosaics of astronomical images in the Flexible Image Transport System (FITS) format" \
      org.label-schema.url="http://montage.ipac.caltech.edu/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/dockerpedia/montage" \
      org.label-schema.vendor="DockerPedia" \
      org.label-schema.version="1.0" \
      org.label-schema.schema-version="1.0"

#install pegasus
RUN     wget -O - http://download.pegasus.isi.edu/pegasus/gpg.txt | apt-key add - && \
        echo 'deb http://download.pegasus.isi.edu/wms/download/debian stretch main' > \
        /etc/apt/sources.list.d/pegasus.list && \
        apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends pegasus && \
        rm -rf /var/lib/apt/lists/* && \
        chmod o+rw /opt/

ENV WORKFLOW_USER workflow
ENV GID 1000
ENV UID 1000

RUN groupadd -g ${GID} ${WORKFLOW_USER} && \
    useradd -m -u ${UID} -g ${GID} ${WORKFLOW_USER} && \
    mkdir /home/${WORKFLOW_USER}/example && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

USER root
VOLUME ["/home/${WORKFLOW_USER}/"]
WORKDIR /home/${WORKFLOW_USER}/
