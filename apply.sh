#!/bin/bash

echo 'Create bookinfo namespace with istio injection enabled'
kubectl create ns bookinfo
kubectl label ns bookinfo istio-injection=enabled

echo ''
echo 'Apply bookinfo'
kubectl apply -f ${TOMOCY}/istio-bookinfo-usual/bookinfo.yaml

getIP() {
    echo $(minikube ip)
}

IP=$(minikube ip)

while true
do
HTTP_PORT=$(kubectl get svc istio-ingressgateway \
-n istio-system \
-o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
if [ ! -z "${HTTP_PORT}" ]
then
break
fi

sleep 1
done

echo ''
echo "http://${IP}:${HTTP_PORT}/productpage"