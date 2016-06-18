FROM area51/rpi-raspbian:jessie
MAINTAINER Peter Mount <peter@retep.org>

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 91
ENV JAVA_VERSION_BUILD 14
ENV JAVA_PACKAGE       jdk

ENV PATH $PATH:/opt/jdk/bin

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
	openssh-client \
        reprepro \
	rsync \
        s3cmd \
        subversion \
        sudo \
        unzip \
        vim \
        zip \
	--no-install-recommends &&\
    curl https://downloads.hypriot.com/docker-hypriot_1.10.2-1_armhf.deb -o docker.deb &&\
    dpkg -i --force-depends docker.deb &&\
    rm -f docker.deb &&\
    mkdir -p /opt &&\
    curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o java.tar.gz\
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-arm32-vfp-hflt.tar.gz &&\
    gunzip -c java.tar.gz | tar -xf - -C /opt &&\
    rm -f java.tar.gz &&\
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk &&\
    rm -rf /opt/jdk/*src.zip &&\
    sed -e "s|PATH=\"|PATH=\"/opt/jdk/bin:|" -i /etc/profile &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem -o /lets-encrypt-x1-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x2-cross-signed.pem -o /lets-encrypt-x2-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -o /lets-encrypt-x3-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x4-cross-signed.pem -o /lets-encrypt-x4-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x1-cross-signed -file /lets-encrypt-x1-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x2-cross-signed -file /lets-encrypt-x2-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x3-cross-signed -file /lets-encrypt-x3-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x4-cross-signed -file /lets-encrypt-x4-cross-signed.pem &&\
    rm -f /*.pem

