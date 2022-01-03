ARG ARG_PHP_VERSION=7

FROM php:${ARG_PHP_VERSION}-fpm-alpine

# Build arguments ...
# Version information
ARG ARG_APP_VERSION 

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.build-date=${ARG_BUILD_DATE} \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="GPLv3" \
    org.label-schema.name="MiGoller" \
    org.label-schema.vendor="MiGoller" \
    org.label-schema.version="${ARG_APP_VERSION}" \
    org.label-schema.description="smartVISU" \
    org.label-schema.url="https://github.com/MiGoller/smartvisu-docker" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/MiGoller/smartvisu-docker.git" \
    maintainer="MiGoller" \
    Author="MiGoller" \
    org.opencontainers.image.description="A smartVISU Docker php-fpm image." \
    org.opencontainers.image.source="https://github.com/MiGoller/smartvisu-docker"

# Persist app-reladted build arguments
ENV APP_VERSION=$ARG_APP_VERSION

# Create additional directories for: Custom configuration, working directory, database directory, scripts
RUN mkdir -p \
        /var/www/html \
        /var/www/html/temp

# Assign working directory
WORKDIR /var/www/html

# Install smartVisu
COPY --chown=www-data:www-data ./src/ /var/www/html/

VOLUME [ "/var/www/html", "/var/www/html/temp", "/var/www/html/dropins/widgets",  "/var/www/html/pages" ]

CMD [ "php-fpm" ]
