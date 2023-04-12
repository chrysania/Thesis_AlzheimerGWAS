FROM python:3.7

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main' && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

RUN pip install hail==0.2.74 variant-spark==0.5.0-a0-dev0 Jinja2==3.0.3
