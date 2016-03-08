FROM google/debian:jessie
MAINTAINER Joost van der Laan <joostvanderlaan@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

ENV NGINX_VERSION=1.9.12
ENV NPS_VERSION=1.10.33.6

RUN apt-get update -qq
RUN apt-get install -yqq build-essential zlib1g-dev libpcre3 libpcre3-dev openssl libssl-dev libperl-dev wget ca-certificates logrotate
RUN apt-get install -yqq unzip
# RUN apt-get install -yqq gcc-4.8
# Download
RUN (wget -qO - https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}-beta.tar.gz | tar zxf - -C /tmp) \
	&& (wget -qO - https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz | tar zxf - -C /tmp/ngx_pagespeed-${NPS_VERSION}-beta/) \
	&& (wget -qO - http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar zxf - -C /tmp)
# Install
RUN cd /tmp/nginx-${NGINX_VERSION} \
	&& ./configure --prefix=/etc/nginx/ --sbin-path=/usr/sbin/nginx \
	--add-module=/tmp/ngx_pagespeed-${NPS_VERSION}-beta \
	--with-http_ssl_module \
	--with-http_v2_module \
	--with-http_stub_status_module \
	&& make install
# Cleanup
RUN rm -Rf /tmp/* \
	&& apt-get purge -yqq wget build-essential \
	&& apt-get autoremove -yqq \
	&& apt-get clean

# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

EXPOSE 80 443

VOLUME ["/etc/nginx/sites-enabled"]
WORKDIR /etc/nginx/
ENTRYPOINT ["/usr/sbin/nginx"]

# Configure nginx
RUN mkdir /var/ngx_pagespeed_cache
RUN chmod 777 /var/ngx_pagespeed_cache
RUN mkdir /var/www
ONBUILD COPY nginx.conf /etc/nginx/conf/nginx.conf
ONBUILD COPY sites-enabled /etc/nginx/sites-enabled
