FROM python:3.10-bullseye
LABEL Matthew Horwood <matt@horwood.biz>

COPY requirements.txt /ansible/requirements.txt
COPY requirements.yml /ansible/requirements.yml

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install python3-pip python3-wheel && \
    useradd -d /ansible ansible && \
    python -m pip install -r /ansible/requirements.txt && \
    ansible-galaxy install -r /ansible/requirements.yml

WORKDIR /ansible
USER ansible
