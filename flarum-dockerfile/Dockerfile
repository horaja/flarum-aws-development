FROM php:8.3-fpm-alpine

ARG FLARUM_VERSION=^1.8.0

RUN apk update && apk add --no-cache \
	git \
	curl \
	openssl \
	autoconf \
	build-base \
	libzip-dev \
	libpng-dev \
	jpeg-dev \
	freetype-dev \
	libexif-dev \
	libxml2-dev \
	oniguruma-dev \
	curl-dev \
	supervisor

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
		&& docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip mbstring exif dom curl

RUN echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED" > /usr/local/etc/php/conf.d/99-flarum-error-reporting.ini
RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/99-flarum-error-reporting.ini
RUN echo "log_errors = On" >> /usr/local/etc/php/conf.d/99-flarum-error-reporting.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/flarum

RUN composer create-project flarum/flarum . "${FLARUM_VERSION}" --stability=stable --remove-vcs --no-progress --no-interaction --prefer-dist --no-plugins

RUN chown -R www-data:www-data /var/www/flarum

COPY ./entrypoint2.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm"]