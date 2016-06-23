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

RUN set -x \
    # Base program.
 && mkdir -p /config/projects \
 && rm -rf /config/www/* \
 && git clone https://github.com/Codiad/Codiad /config/www \
 && cp /defaults/config.php /config/www/config.php \
    # Fix ownership
 && chown -R abc:abc /config

VOLUME /config

# Ports and volumes.
EXPOSE 80 443

# Remove error on collaboration on startup.
CMD [[ -e /config/www/components/active/class.active.php ]] && sed -i s/' echo formatJSEND("error","Warning: File ".'/'#echo formatJSEND("error","Warning: File ".'/ /config/www/components/active/class.active.php; "/sbin/my_init"
