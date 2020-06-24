#!/bin/bash

microk8s kubectl run mars \
    --image=gcr.io/kuar-demo/kuard-amd64:blue \
    --replicas=2 \
    --labels="ver=1,app=mars,ortam=prod"

microk8s kubectl run venus \
    --image=gcr.io/kuar-demo/kuard-amd64:green \
    --replicas=2 \
    --labels="ver=2,app=venus,ortam=test"

microk8s kubectl get deployments --show-labels

microk8s kubectl label deployments venus "bolum=Muhasebe"

microk8s kubectl get deployments -L bolum

microk8s kubectl label deployments venus "bolum-"

microk8s kubectl get pods --show-labels

microk8s kubectl get pods --selector="ver=2"

microk8s kubectl get pods --selector="ortam=prod"

microk8s kubectl get pods --selector="app in (mars,venus,jupiter)"

microk8s kubectl get pods --selector="ver!=2"