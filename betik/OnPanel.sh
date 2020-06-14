#!/bin/bash

# MIT License
# Copyright (c) 2020 Gökhan Koçak
# www.gokhankocak.com

token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0
