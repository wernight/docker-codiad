FROM linuxserver/baseimage.apache
MAINTAINER Werner Beroux <werner@beroux.com>

# Install required packages.
RUN set -x \
 && apt-get update -q \
 && apt-get install -q -y \
        git \
        expect \
        php5-ldap \
    # Cleanup
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add some files .
COPY defaults/ /defaults/
COPY init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Ports and volumes.
EXPOSE 80 443
VOLUME /config
