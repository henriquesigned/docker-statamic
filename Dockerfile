
# alpine:3.6
FROM alpine@sha256:d6bfc3baf615dc9618209a8d607ba2a8103d9c8a405b3bd8741d88b4bef36478

RUN apk add --no-cache \
    php7 \
	php7-openssl \
	php7-mbstring \
	php7-tokenizer \
	php7-json \
	php7-gd \
	php7-imagick \
	php7-fileinfo \
    # Needed by composer
    php7-curl \
    php7-phar \
    php7-dom \
    php7-zip \
    php7-xml \
    php7-xmlwriter \
	unzip \
    wget

ENV COMPOSER_VERSION 1.5.2
ENV COMPOSER_CHECKSUM c0a5519c768ef854913206d45bd360efc2eb4a3e6eb1e1c7d0a4b5e0d3bbb31f
RUN wget -q https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar && \
    echo "$COMPOSER_CHECKSUM  composer.phar" | sha256sum -c - && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

COPY statamic-2.8.10.zip /tmp/
RUN unzip -q /tmp/statamic-2.8.10.zip -d /tmp/

WORKDIR /tmp/statamic/
EXPOSE 3000

ENTRYPOINT ["/usr/bin/php"]
CMD ["-S", "0.0.0.0:3000", "statamic/server.php"]
