# Проблема: долгая загрузка при нажатии на пост.
## 01-Zipkin
Долго выполняется поиск поста по ID.
![[01-zipkin-db_find_single_post.png]]
Порядок выполнения проблемного запроса:
```
ui_app:get -> post:/post/<id> -> post:db_find_single_post -> comment:get
```
Долго выполняется конкретно спан `db_find_single_post` в сервисе `post`
Среднее время выполнения около 3 секунд.
(!) Предпологаем: запрос к БД обрабатывается долго.
## 02-Prometheus
Подключим prometheus, добавим сервис `post` - посмотрим какие есть логи.
![[02-prometheus-post_read_db_seconds.png]]
В метрике Target `http://post:5000/metrics` видим:
```
post_read_db_seconds_count 1.0
post_read_db_seconds_sum 0.0013129711151123047
```
Очевидно, что запрос к БД отрабатывает быстро, а тормозит обработка запроса.
## 03-Python
Заходим в docker контейнер `post`
```bash
docker exec -it post bash
```
Изучаем список файлов
```bash
ls -l
```
Рассмотрим подробнее файл `post_app.py` (используя имеющиеся инструменты)
```bash
cat -n post_app.py
```
![[03-python-time_sleep.png]]
В функции `find_post`, которая должна выполнять запрос к сервису `post_db` добавлена пауза 3 секунды `time.sleep(3)` на строке 167.
(!) Предполагаем, что проблема в этом.
## 04-sed
Удаляем строку номер 167:
```bash
sed -i '167d' post_app.py
```
## 05-Zipkin
Перезагружаем контейнер
```bash
docker compose restart post
```
При нажатии на пост загрузка ускорилась.
Показатели в Zipkin подтверждают ускорение.
![[05-zipkin-db_find_single_post.png]]