#!/bin/bash

NAMESPACE=circleci-runner
RELEASE_NAME=circleci-runner

echo "[*] Creating namespace..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "[*] Adding CircleCI Helm repo..."
helm repo add circleci https://circleci.github.io/runner-charts
helm repo update

echo "[*] Installing CircleCI runner via Helm..."
helm install $RELEASE_NAME circleci/runner \
  -f charts/circleci-runner/values.yaml \
  --namespace $NAMESPACE

echo "[✓] Done. Use 'kubectl get pods -n $NAMESPACE' to check runner status."