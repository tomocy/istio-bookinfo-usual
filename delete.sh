#!/bin/bash

echo 'Delete bookinfo'
kubectl delete -f ${TOMOCY}/istio-bookinfo-usual
kubectl delete ns bookinfo