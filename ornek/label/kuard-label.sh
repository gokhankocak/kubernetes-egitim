#!/bin/bash

# MIT License
# Copyright (c) 2020 Gökhan Koçak
# www.gokhankocak.com

microk8s kubectl run mars \
    --image=gcr.io/kuar-demo/kuard-amd64:blue \
    --labels="ver=1,app=mars,ortam=prod"

microk8s kubectl run venus \
    --image=gcr.io/kuar-demo/kuard-amd64:green \
    --labels="ver=2,app=venus,ortam=test"

microk8s kubectl apply -f kuard-label.yaml

sleep 10

microk8s kubectl get deployments --show-labels

microk8s kubectl label deployments kuard "bolum=Finans"

microk8s kubectl get deployments -L bolum

microk8s kubectl label deployments kuard "bolum-"

microk8s kubectl get pods --show-labels

microk8s kubectl get pods --selector="ver=2"

microk8s kubectl get pods --selector="ortam=prod"

microk8s kubectl get pods --selector="app in (mars,venus,jupiter)"

microk8s kubectl get pods --selector="ver!=2"

# clean up
# microk8s kubectl delete deployment/kuard
# microk8s kubectl delete pod/venus
# microk8s kubectl delete pod/mars
