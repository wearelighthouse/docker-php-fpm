FROM php:5.6-fpm

MAINTAINER wearelighthouse <christy@wearelighthouse.com>

# Update and requirements for extensions
RUN requirements="g++ libicu-dev" \
	&& apt-get update \
	&& apt-get install -y $requirements

# PHP extensions
RUN docker-php-ext-install intl \
	&& docker-php-ext-install pdo_mysql

# Composer
RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get install -y git zip unzip

# Purge requirements
RUN apt-get purge --auto-remove -y $requirements \
	&& rm -rf /var/lib/apt/lists/*
