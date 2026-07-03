#!/bin/bash
set -e

echo "------------------ Кластер ------------------"

echo
echo "Пересоздаю кластер с 2 доп узлами"
kind delete cluster
kind create cluster --config 01-kind-config.yaml

echo
echo "------------------ Calico ------------------"

echo
echo "Устанавливаю Calico"
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/calico.yaml

echo
echo "Ожидаю 60 секунд..."
sleep 60

echo
echo "Проверка Calico: должны быть calico-kube-controllers и calico-node-xxxxx"
kubectl get pods -n kube-system

echo
echo "Проверка узлов Calico: должны быть Ready"
kubectl get nodes

echo
echo "------------------ Метрика ------------------"

echo
echo "Устанавливаю метрику"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo
echo "Ожидание установки..."
sleep 5

echo
echo "Метрика установлена"
kubectl get deployment metrics-server -n kube-system

echo
echo "Проверяю доступность метрики"
if ! kubectl wait --for=condition=Available=true deployments.apps/metrics-server \
          -n kube-system --timeout=20s; then

  echo
  echo "Метрика недоступна"
  echo "Редктирую манифест, что бы не проверял сертификат"
  kubectl patch deployment metrics-server -n kube-system --type=json -p='[
      {"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}
  ]'

  echo
  echo "Снова проверяю доступность метрики"
  kubectl wait --for=condition=Available=true deployments.apps/metrics-server \
      -n kube-system --timeout=180s
fi

echo
echo "------------------ Wordpress ------------------"

echo
echo "Создаю пути для узлов"
./02-create-path.sh

echo
echo "Устанавливаю namespace"
kubectl apply -f 03-namespace-dev.yaml

echo
echo "Создаю volume"
kubectl apply -f 04-volume.yaml

echo
echo "Создаю объекты wordpress и mysql"
kubectl apply -f 05-wordpress.yaml

echo
echo "Ожидаю доступность mysql"
kubectl wait --for=condition=ready pod -l app=mysql -n dev --timeout=300s

echo
echo "Создаю объект HorizontalPodAutoscaler горизонтального масштабирования"
kubectl apply -f 06-hpa.yaml

echo
echo "Создаю объект NetworkPolicy для ограничения входящего трафика на pod mysql"
kubectl apply -f 07-network-policy-mysql.yaml
