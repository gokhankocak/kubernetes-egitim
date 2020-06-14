#!/bin/bash

curl -o kuard.crt https://storage.googleapis.com/kuar-demo/kuard.crt 
curl -o kuard.key https://storage.googleapis.com/kuar-demo/kuard.key

microk8s kubectl create secret generic kuard-tls \
    --from-file=kuard.crt \
    --from-file=kuard.key
