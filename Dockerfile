FROM docker.repository.cloudera.com/cloudera/cdsw/engine:13-cml-2020.10-2

WORKDIR /tmp

#The RUN commands that install an editor
#For example: RUN apt-get install myeditor
RUN rm /etc/apt/sources.list.d/cloudera.list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    libapparmor1 \
    libclang-dev \
    lsb-release \
    psmisc \
    sudo

#The command that follows RUN is the same command you used to install the IDE to test it in a the session.
RUN wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.1335-amd64.deb && \
    dpkg -i rstudio-server-1.2.1335-amd64.deb

COPY rserver.conf /etc/rstudio/rserver.conf

COPY rstudio-cdsw /usr/local/bin/rstudio-cdsw

RUN chmod +x /usr/local/bin/rstudio-cdsw