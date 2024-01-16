FROM debian:12-slim

ARG TENGINE_VERSION=3.1.0

EXPOSE 80 443

RUN apt-get update \
    && apt-get -y install \
        libpcre2-dev \
        libssl-dev \
        zlib1g-dev \
        wget \
        gcc \
        make \
    && wget https://github.com/alibaba/tengine/archive/${TENGINE_VERSION}.tar.gz \
    && tar -zxvf ${TENGINE_VERSION}.tar.gz && rm ${TENGINE_VERSION}.tar.gz \
    && mkdir /usr/local/nginx /var/tmp/nginx /var/log/nginx \
    && cd tengine-${TENGINE_VERSION} \
    && ./configure \
        --prefix=/usr/local/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/lock/nginx.lock \
        --user=nginx \
        --group=nginx \
        --http-client-body-temp-path=/var/tmp/nginx/client \
        --http-proxy-temp-path=/var/tmp/nginx/proxy \
        --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
        --http-scgi-temp-path=/var/tmp/nginx/scgi \
        --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
        --with-ipv6 \
        --with-http_v2_module \
        --with-http_ssl_module \
    && make && make install \
    && cd ../ && rm -rf tengine-${TENGINE_VERSION} \
    && useradd -s /sbin/nologin nginx \
    && cd /usr/local/nginx \
    && chown nginx:nginx -R /usr/local/nginx/logs \
    && chown nginx:nginx -R /var/tmp/nginx \
    && chmod 700 -R /var/tmp/nginx \
    && chmod 777 -R /usr/local/nginx/logs \
    && ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx \
    && apt-get clean && apt-get remove -y \
        libpcre2-dev \
        libssl-dev \
        zlib1g-dev \
        gcc \
        make

COPY nginx.conf /etc/nginx/
COPY index.html /etc/nginx/default/
COPY default.conf /etc/nginx/conf.d/

CMD ["nginx"]
