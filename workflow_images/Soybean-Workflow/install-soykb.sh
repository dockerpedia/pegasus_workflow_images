#!/bin/bash

mkdir -p soykb/ && \
    mkdir -p soykb/wrappers/ && \
    wget https://github.com/rafaelfsilva/workflow-reproducibility/raw/master/components/soykb/soykb.tar.gz && \
    tar -xzf soykb.tar.gz && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/software.tar.gz && \
    tar -xzf software.tar.gz -C soykb/ && \
    cd ~/soykb/wrappers/ && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/picard-wrapper  && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/software-wrapper && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/gatk-wrapper && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/bwa-wrapper && \
    chmod +X . && \
    wget https://gist.githubusercontent.com/sirspock/0446aeb932c63d08292f0ddcd21c9c37/raw/195e044d7f0e7c33556ee8a39dcd88081df8ad09/soybean-workflow.conf \
    -O ~/.soybean-workflow.conf && \
    ln -s ~/.ssh/id_rsa ~/.ssh/id_dsa && \
    ln -s ~/.ssh/id_rsa ~/.ssh/workflow && \
    rm /home/workflow/software.tar.gz /home/workflow/soykb.tar.gz
