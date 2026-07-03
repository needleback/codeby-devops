#!/bin/bash
set -e
#set -euo pipefail

TIMEOUT_WAIT=20

echo
echo "------------------- Проверка соединения тестовый pod --> mysql -------------------"

echo
echo "-- удаляю старый pod, если остался"
kubectl delete pods test -n dev --ignore-not-found >/dev/null 2>&1

echo
echo "-- создаю тестовый pod"
kubectl run test --image=busybox --restart=Never -n dev -- sleep infinity

echo
echo "-- жду создания"
kubectl wait --for=condition=Ready pod/test -n dev --timeout=30s


set +e
echo
echo "-- проверяю соединение с mysql (таймаут ${TIMEOUT_WAIT} секунд) "
kubectl exec -it -n dev test \
    -- sh -c "nc -zvw ${TIMEOUT_WAIT} mysql 3306"
set -e

echo
echo "-- удаляю тестовый pod"
kubectl delete pods test -n dev

echo
echo "------------------- Проверка соединения wordpress --> mysql -------------------"

echo
echo "-- устанавливаю netcat-openbsd"
kubectl exec -it deployment/wordpress -n dev -- sh -c "apt update"
kubectl exec -it deployment/wordpress -n dev -- sh -c "apt install -y netcat-openbsd"

set +e
echo
echo "-- проверяю соединение с mysql (таймаут ${TIMEOUT_WAIT} секунд) "
kubectl exec -it -n dev deployment/wordpress \
    -- sh -c "nc -zvw ${TIMEOUT_WAIT} mysql 3306"
