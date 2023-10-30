FROM debian:11-slim
LABEL Matthew Horwood <matt@horwood.biz>

COPY requirements.txt /ansible/requirements.txt
COPY requirements.yml /ansible/requirements.yml

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install python3-pip python3-wheel git && \
    useradd -d /ansible ansible && \
    python3 -m pip install -r /ansible/requirements.txt && \
    ansible-galaxy install -r /ansible/requirements.yml; \
    python3 -m pip cache purge; \
    apt-get clean;
