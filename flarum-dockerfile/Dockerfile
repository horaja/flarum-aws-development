FROM php:fpm-alpine

ARG FLARUM_VERSION=^1.8.0

RUN apk update && apk add --no-cache \
	git \
	curl \
	openssl \
	libzip-dev \
	libpng-dev \
	jpeg-dev \
	freetype-dev \
	libexif \
	supervisor \
	nginx

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
		&& docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip mbstring exif tokenizer dom curl openssl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/flarum

RUN composer create-project flarum/flarum . "${FLARUM_VERSION}" --stability=stable --remove-vcs --no-progress --no-interaction --prefer-dist --no-plugins

RUN chown -R www-data:www-data /var/www/flarum/storage /var/www/flarum/public/assets \
		&& chmod -R 775 /var/www/flarum/storage /var/www/flarum/public/assets

EXPOSE 9000

CMD ["php-fpm"]