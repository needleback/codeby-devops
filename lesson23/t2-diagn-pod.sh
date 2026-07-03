#!/bin/bash
set -e

echo
echo "удаляю старый pod диагностики, если остался"
kubectl delete pods diagnostic -n dev --ignore-not-found >/dev/null 2>&1

echo
echo "------------ Запускаю диагностику ------------"
kubectl apply -f 08-diagn-pod.yaml

echo
echo "-- вывожу логи"
kubectl logs -f diagnostic -n dev
