FROM php:7.0-fpm

MAINTAINER wearelighthouse <christy@wearelighthouse.com>

# Update and requirements for extensions
RUN apt-get update \
	&& apt-get install -y \
		g++ \
		# exif requirements
		libexif-dev \
		# gd requirements
		libfreetype6-dev \
        libjpeg62-turbo-dev \
		libpng12-dev \
		# intl requirements
		libicu-dev

# PHP extensions
RUN docker-php-ext-install -j$(nproc) exif \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install -j$(nproc) mysqli pdo_mysql

# Composer
RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get install -y git zip unzip
