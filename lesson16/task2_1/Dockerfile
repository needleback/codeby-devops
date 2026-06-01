# базовый образ alpine:latest
FROM alpine:latest

WORKDIR /opt

# Установка nginx
RUN apk update
RUN apk add --no-cache nginx

# Создание папки /opt/www
RUN mkdir www

# В папке файл index.html
COPY ./index.html ./www/index.html

# Создать конфиг nginx
RUN rm /etc/nginx/http.d/*
COPY ./lesson16_ng.conf /etc/nginx/http.d/lesson16_ng.conf

# открыть порт для nignx
EXPOSE 80

# запуск через CMD
CMD ["nginx", "-g", "daemon off;"]
