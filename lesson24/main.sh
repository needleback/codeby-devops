#!/bin/bash
set -e

echo "------------------ Кластер ------------------"

echo
echo "-- Пересоздаю кластер с 2 доп узлами"
kind delete cluster
kind create cluster --config 01-kind-config.yaml

echo
echo "------------------ Wordpress ------------------"

echo
echo "-- Создаю пути для узлов"
docker exec kind-worker mkdir -p /data/mysql
docker exec kind-worker2 mkdir -p /data/wordpress

echo
echo "-- Устанавливаю namespace"
kubectl apply -f 02-namespace-dev.yaml

echo
echo "-- Устанавливаю chart wordpress"
helm install my-wordpress-mysql wordpress-mysql/
