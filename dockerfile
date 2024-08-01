ARG GLPI_VERSION=10.0.16
ARG VERSION_PHP=8.2

FROM debian:bookworm-slim as prepare

ARG GLPI_VERSION
ARG VERSION_PHP

ENV GLPI_VERSION $GLPI_VERSION
ENV VERSION_PHP $VERSION_PHP
# RUN echo "Acquire::http::Proxy \"http://192.168.1.172:3142\";\nAcquire::https::Proxy \"http://192.168.1.172:3142\";" > /etc/apt/apt.conf.d/apt_proxy.conf


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


FROM debian:bookworm-slim

LABEL \
  org.opencontainers.image.vendor="No Fuss Computing" \
  org.opencontainers.image.title="GLPI" \
  org.opencontainers.image.description="GLPI Within a docker container" \
  org.opencontainers.image.vendor="No Fuss Computing" \
  io.artifacthub.package.license="MIT"


ARG GLPI_VERSION
ARG VERSION_PHP


ENV DEBIAN_FRONTEND noninteractive

ENV GLPI_VERSION $GLPI_VERSION

ENV VERSION_PHP $VERSION_PHP

#COPY --from=prepare /etc/apt/apt.conf.d/apt_proxy.conf /etc/apt/apt.conf.d/apt_proxy.conf

COPY --from=prepare /usr/share/keyrings/deb.sury.org-php.gpg /usr/share/keyrings/deb.sury.org-php.gpg

COPY --from=prepare /etc/apt/sources.list.d/php.list /etc/apt/sources.list.d/php.list


RUN apt update; \
  apt install --no-install-recommends -y \
    ca-certificates \
    \
    cron \
    supervisor; \
  rm -rf /var/lib/apt/lists/*;

RUN apt update; \
  apt install --no-install-recommends -y \
    apache2 \
    php$VERSION_PHP \
    php$VERSION_PHP-mysql \
    php$VERSION_PHP-ldap \
    php$VERSION_PHP-xmlrpc \
    php$VERSION_PHP-imap \
    php$VERSION_PHP-curl \
    php$VERSION_PHP-gd \
    php$VERSION_PHP-mbstring \
    php$VERSION_PHP-xml \
    php-cas \
    php$VERSION_PHP-intl \
    php$VERSION_PHP-zip \
    php$VERSION_PHP-bz2 \
    php$VERSION_PHP-redis; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/www/html; \
  rm -f /etc/apt/apt.conf.d/apt_proxy.conf; \
  a2enmod rewrite;


COPY --from=prepare /tmp/glpi /var/www/html


# RUN apt install --no-install-recommends -y \
#     libldap-2.4-2 \
#     libldap-common \
#     libsasl2-2 \
#     libsasl2-modules \
#     libsasl2-modules-db;


RUN chown www-data:www-data -R /var/www; \
  ln -s /var/www/html/bin/console /bin/console; \
  touch /apache-passwd-glpi-inventory; \
  chown www-data:www-data /apache-passwd-glpi-inventory; \
  chmod 740 /apache-passwd-glpi-inventory;


VOLUME /var/www/html/config
VOLUME /var/www/html/data
VOLUME /var/www/html/files
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
