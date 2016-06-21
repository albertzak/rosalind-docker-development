FROM node:0.10.44-slim

CMD /sbin/my_init

ENV RELEASE 1.3.3

RUN curl https://install.meteor.com/ | sh

RUN apt-get -y clean && apt-get -y update && apt-get -y install \
      git \
      curl \
      gnome-doc-utils \
      libtool \
    	automake \
    	autoconf \
      make \
      glib2.0-dev \
      libglib2.0-0 \
      python \
      g++ \
    && cd /tmp/ && \
      git clone https://github.com/albertzak/mdbtools && \
      cd mdbtools && \
      autoreconf -i -f && \
      ./configure --disable-man && \
      make && \
      make install && \
      ldconfig \
    && apt-get -y purge \
      gnome-doc-utils \
      libtool \
      automake \
      autoconf \
      glib2.0-dev \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mdb-export --help

VOLUME ~/.meteor
VOLUME ~/.npm

WORKDIR /app
