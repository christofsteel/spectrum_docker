FROM debian:wheezy
MAINTAINER Christoph Stahl <christoph.stahl@uni-dortmund.de>

ENV DOMAIN example.com

RUN apt-get update && apt-get --no-install-recommends -y install apt-transport-https wget
RUN mkdir -p /usr/local/share/ca-certificates/cacert.org
RUN wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt
RUN apt-get install --no-install-recommends -y ca-certificates
RUN update-ca-certificates
RUN echo "deb [trusted=yes] https://repo.k-fortytwo.de/debian wheezy main" >> /etc/apt/sources.list
RUN apt-get update && apt-get --no-install-recommends -y install mercurial
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get intall --no-install-recommends -y git

WORKDIR /tmp
RUN git clone https://github.com/christofsteel/spectrum_docker 

RUN mkdir /etc/start.d/
RUN cp /tmp/spectrum_docker/spectrum /etc/start.d/
RUN chmod a+x /etc/start.d/spectrum
RUN cp /tmp/spectrum_docker/create_config_spectrum /usr/bin/
RUN chmod a+x /usr/bin/create_config_spectrum

ADD init.sh /bin/
ADD startd /bin/
RUN chmod a+x /bin/init.sh
RUN chmod a+x /bin/startd

ENTRYPOINT ["/bin/init.sh"]

RUN apt-get --no-install-recommends -y install nano
RUN apt-get --no-install-recommends -y install vim
RUN apt-get install --no-install-recommends -y libboost-date-time1.49.0 libboost-filesystem1.49.0  libboost-program-options1.49.0 libboost-regex1.49.0 libboost-signals1.49.0 libboost-system1.49.0 libboost-thread1.49.0 libc6 libgcc1 libidn11 liblog4cxx10 libmysqlclient18 libpopt0 libpq5 libpqxx-3.1 libprotobuf7 libqt4-network libqtcore4 libqtgui4 libsqlite3-0 libssl1.0.0 libstdc++6 libxml2 zlib1g libpurple0
RUN apt-get install --no-install-recommends -y libswiften2
RUN apt-get install --no-install-recommends -y libqt4-declarative libqt4-script libqt4-sql libqt4-xmlpatterns
RUN apt-get update
RUN apt-get install --no-install-recommends -y --force-yes spectrum2 spectrum2-backend-libpurple spectrum2-backend-libcommuni
