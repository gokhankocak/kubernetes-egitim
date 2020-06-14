#!/bin/bash

microk8s kubectl create secret docker-registry my-image-pull-secret \
    --docker-username=<username> \
    --docker-password=<password> \
    --docker-email=<email-address>