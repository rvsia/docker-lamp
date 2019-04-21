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

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    ca-certificates \
    gcc \
    git \
    libpq-dev \
    make \
    python-pip \
    python2.7 \
    python2.7-dev \
    ssh \
    libfreetype6-dev \
    pkg-config \
    libpng12-dev \
    pkg-config \
    libxml2 \
    libxslt1-dev \
    libmysqlclient-dev \
    && apt-get autoremove \
    && apt-get clean

RUN pip install setuptools -U
RUN pip install nltk
RUN pip install numpy
RUN pip install matplotlib==2.2.3
RUN pip install stop-words
RUN pip install PyStemmer
RUN pip install bagofwords==1.0.1
RUN pip install lxml
RUN pip install MySQL-python