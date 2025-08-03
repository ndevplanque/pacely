FROM php:8.4-fpm

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl libonig-dev libpng-dev libjpeg-dev libfreetype6-dev \
    curl gnupg2 ca-certificates lsb-release apt-transport-https \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql zip gd bcmath

# Installer Composer globalement
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installer Node.js 20.x + npm via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
