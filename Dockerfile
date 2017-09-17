FROM php:5

ARG composer_checksum=55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30
ARG composer_url=https://raw.githubusercontent.com/composer/getcomposer.org/ba0141a67b9bd1733409b71c28973f7901db201d/web/installer

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH=$PATH:vendor/bin

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
      apt-utils \
      locales \
  && echo ja_JP.UTF-8 UTF-8 > /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=ja_JP.UTF-8

RUN apt-get install -y --no-install-recommends \
      curl \
      git \
      python-dev \
      python-pip \
      zlib1g-dev \
      libxslt1-dev \
  && pip install awscli \
  && docker-php-ext-install zip pdo pdo_mysql xsl \
  && curl -o installer "$composer_url" \
  && echo "$composer_checksum *installer" | shasum -c -a 384 \
  && php installer --install-dir=/usr/local/bin --filename=composer \
  && rm -rf /var/lib/apt/lists/*

ADD php.ini-development /usr/local/etc/php/php.ini

ENV LC_ALL ja_JP.UTF-8
