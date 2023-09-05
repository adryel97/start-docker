# install PHP + apache
FROM php:8.1-apache

ARG USERNAME=user #coloque o nome de usuario
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME 

# apache2 rewrite
RUN a2enmod rewrite
RUN service apache2 restart

# apt installs
RUN apt-get -y update --fix-missing
RUN apt-get -y install curl vim git npm nodejs tar file xz-utils build-essential libzip-dev zip && docker-php-ext-install zip

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apt-get update && apt-get install -y \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libpng-dev \
  libonig-dev \
  libxml2-dev \
  && docker-php-ext-install -j$(nproc) iconv \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd

RUN apt-get -yqq install exiftool
RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif

RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/php/ext/imagick; \
  curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
  docker-php-ext-install imagick;

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install yarn
# RUN npm install -g yarn

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY . /var/www/html

# WORKDIR /var/www/html/wp-content/themes/vstart

# CMD ["yarn", "yarn watch"]

EXPOSE 80
# EXPOSE 8000
# EXPOSE 3000
# EXPOSE 3001
