# базовый образ debian:11
FROM debian:11

WORKDIR /opt

# Установка nginx
RUN apt-get update \
    && apt-get install -y nginx

# Создание папки /opt/www
RUN mkdir www

# Там файл index.html
COPY ./index.html ./www/index.html

# Создать конфиг nginx
RUN rm -f /etc/nginx/sites-enabled/*
COPY ./lesson16_ng.conf /etc/nginx/sites-available/lesson16_ng.conf
RUN ln -s /etc/nginx/sites-available/lesson16_ng.conf /etc/nginx/sites-enabled/lesson16_ng.conf

# открыть порт для nignx
EXPOSE 80

# запуск через Entrypoint
ENTRYPOINT ["nginx", "-g", "daemon off;"]
