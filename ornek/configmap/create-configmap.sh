#!/bin/bash

microk8s kubectl create configmap my-config \
    --from-file=my-config.txt  \
    --from-literal=extra-param=extra-value \
    --from-literal=another-param=another-value