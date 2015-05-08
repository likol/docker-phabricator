FROM ubuntu:trusty-20150427
MAINTAINER Likol <likol@likol.idv.tw>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 8B3981E7A6852F782CC4951600A6F0A3C300EE8C \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
&& echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main " >> /etc/apt/sources.list \
&& echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main " >> /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y supervisor logrotate locales \
&& nginx openssh-server mysql-client git-core \
&& php5-fpm php5-apcu php5-mysql php5-curl python-pygments


sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/fpm/php.ini
sed -i 's/\;date.timezone =/date.timezone = Asia\/Taipei/g' /etc/php5/fpm/php.ini
sed -i 's/\;opcache.validate_timestamps=1/opcache.validate_timestamps=0/g' /etc/php5/fpm/php.ini
