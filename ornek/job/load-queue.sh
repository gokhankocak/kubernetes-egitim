#!/bin/bash

QUEUE_POD=$(microk8s kubectl get pods -l app=work-queue,component=queue -o jsonpath='{.items[0].metadata.name}')
microk8s kubectl port-forward $QUEUE_POD 8080:8080 &
sleep 5

# Create a work queue called 'keygen'
curl -X PUT localhost:8080/memq/server/queues/keygen
# Create 100 work items and load up the queue.
for i in work-item-{0..99}; do
    curl -X POST localhost:8080/memq/server/queues/keygen/enqueue -d "$i"
done