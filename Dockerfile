FROM area51/rpi-java:8
MAINTAINER Peter Mount <peter@retep.org>

RUN apt-get update &&\
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        aufs-tools \
        autoconf \
        automake \
        build-essential \
        curl libcurl4-openssl-dev \
        cvs \
        git \
        mercurial \
        reprepro \
        s3cmd \
        subversion \
        sudo \
        unzip \
        vim \
        zip \
	--no-install-recommends &&\
    rm -f /*.pem

