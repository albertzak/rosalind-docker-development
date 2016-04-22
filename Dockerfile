FROM phusion/passenger-nodejs:latest

CMD /sbin/my_init

ENV RELEASE 1.3.2.4

RUN curl https://install.meteor.com/ | sh

RUN apt-get update && apt-get -y install \
      git \
      curl \
      gnome-doc-utils \
      libtool \
    	automake \
    	autoconf \
      make \
      glib2.0-dev \
    && cd /tmp/ && \
      git clone https://github.com/albertzak/mdbtools && \
      cd mdbtools && \
      autoreconf -i -f && \
      ./configure --disable-man && \
      make && \
      make install && \
      ldconfig \
    && apt-get apt-get -y purge \
      gnome-doc-utils \
      libtool \
      automake \
      autoconf \
      make \
      glib2.0-dev \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN bash -c "echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sudo sysctl -p"

WORKDIR /app
