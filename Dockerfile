FROM php:7.0.8-apache 
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
RUN usermod -u 1000 www-data
RUN curl -L -o /tmp/xdiff.tar.gz "http://www.xmailserver.org/libxdiff-0.23.tar.gz" \
    && mkdir -p /usr/src/xdiff \
    && tar -C /usr/src/xdiff -zxvf /tmp/xdiff.tar.gz --strip 1 \
    && rm /tmp/xdiff.tar.gz \
    && cd /usr/src/xdiff \
    && ./configure  && make && make install \
    \
    &&  pecl install xdiff && docker-php-ext-enable xdiff
RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 15M;" >> /usr/local/etc/php/conf.d/uploads.ini