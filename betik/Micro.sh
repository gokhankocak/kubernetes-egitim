#!/bin/bash

# MIT License
# Copyright (c) 2020 Gökhan Koçak
# www.gokhankocak.com

sudo apt-get update
sudo apt-get upgrade -y
sudo snap install microk8s --classic
sudo microk8s status --wait-ready
sudo microk8s enable dashboard dns metrics-server registry storage
sudo microk8s kubectl get all --all-namespaces
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube
sudo microk8s status