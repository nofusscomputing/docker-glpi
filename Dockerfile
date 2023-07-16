ARG GLPI_VERSION=10.0.9

FROM debian:bullseye-slim as prepare

ARG GLPI_VERSION

ENV GLPI_VERSION $GLPI_VERSION

RUN echo "Acquire::http::Proxy \"http://192.168.1.172:3142\";\nAcquire::https::Proxy \"http://192.168.1.172:3142\";" > /etc/apt/apt.conf.d/apt_proxy.conf


RUN apt update; \
  apt install --no-install-recommends -y \
    git \
    curl \
    jq \
    lsb-release \
    wget \
    \
    apt-transport-https \
    ca-certificates;


RUN curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
RUN  sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] http://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list';


RUN export GLPI_URL=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/tags/${GLPI_VERSION} | jq .assets[0].browser_download_url | tr -d \"); \
  export TAR_FILENAME=$(basename ${GLPI_URL}); \
  wget -P /tmp/ ${GLPI_URL}; \
  tar -xzf /tmp/${TAR_FILENAME} -C /tmp;


FROM debian:bullseye-slim


ARG GLPI_VERSION


ENV DEBIAN_FRONTEND noninteractive

ENV GLPI_VERSION $GLPI_VERSION

 
COPY --from=prepare /etc/apt/apt.conf.d/apt_proxy.conf /etc/apt/apt.conf.d/apt_proxy.conf
  
COPY --from=prepare /usr/share/keyrings/deb.sury.org-php.gpg /usr/share/keyrings/deb.sury.org-php.gpg

COPY --from=prepare /etc/apt/sources.list.d/php.list /etc/apt/sources.list.d/php.list


RUN apt update; \
  apt install --no-install-recommends -y \
    apache2 \
    php7.4 \
    php7.4-mysql \
    php7.4-ldap \
    php7.4-xmlrpc \
    php7.4-imap \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php-cas \
    php7.4-intl \
    php7.4-zip \
    php7.4-bz2 \
    php7.4-redis \
    \
    cron \
    supervisor \
    ca-certificates; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/www/html; \
    rm /etc/apt/apt.conf.d/apt_proxy.conf; \
    a2enmod rewrite;


COPY --from=prepare /tmp/glpi /var/www/html


# RUN apt install --no-install-recommends -y \
#     libldap-2.4-2 \
#     libldap-common \
#     libsasl2-2 \
#     libsasl2-modules \
#     libsasl2-modules-db;


RUN chown www-data:www-data -R /var/www; \
  ln -s /var/www/html/bin/console /bin/console;


VOLUME /var/www/html/config
VOLUME /var/www/html/data
VOLUME /var/www/html/plugins
VOLUME /var/www/html/marketplacey
VOLUME /var/log

COPY includes/ /


RUN chmod 644 -R /etc/cron.d


WORKDIR /var/www/html


EXPOSE 80 443 9001


HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD \
  supervisorctl status || exit 1


CMD [ "/usr/bin/supervisord" ]
