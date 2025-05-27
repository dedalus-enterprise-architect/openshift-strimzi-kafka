#!/bin/bash
# Strimzi Kafka Operator installation script for OpenShift

set -e

# Check for required binaries
command -v oc >/dev/null 2>&1 || { echo "Error: oc is not installed or not in PATH."; exit 1; }
command -v helm >/dev/null 2>&1 || { echo "Error: helm is not installed or not in PATH."; exit 1; }

# Default values
NAMESPACE=${NAMESPACE:-"kafka-operator"}
HELM_RELEASE=${HELM_RELEASE:-"strimzi-kafka-operator"}
VALUES_FILE=${VALUES_FILE:-"../deploy/strimzi-values/values.yaml"}  # Default to a single values.yaml file

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --namespace)
      NAMESPACE="$2"
      shift; shift
      ;;
    --values)
      VALUES_FILE="$2"
      shift; shift
      ;;
    *)
      echo "Unknown option: $key"
      exit 1
      ;;
  esac
done

# Ensure VALUES_FILE is a valid file
if [ ! -f "$VALUES_FILE" ]; then
  echo "Error: Values file '$VALUES_FILE' does not exist."
  exit 1
fi

echo "Installing Strimzi Kafka Operator in namespace: $NAMESPACE"
echo "Using values file: $VALUES_FILE"

# Ensure namespace exists
echo "Creating namespace if it doesn't exist..."
oc get namespace $NAMESPACE >/dev/null 2>&1 || oc create namespace $NAMESPACE

# Add Helm repo
echo "Adding Strimzi Helm repository..."
helm repo add strimzi https://strimzi.io/charts/
helm repo update

# Install with Helm
echo "Installing Strimzi Kafka Operator..."
helm install $HELM_RELEASE strimzi/strimzi-kafka-operator \
  --namespace $NAMESPACE \
  --values $VALUES_FILE

echo "Waiting for pods to become ready..."
oc wait --for=condition=ready pod -l name=strimzi-cluster-operator -n $NAMESPACE --timeout=300s

echo "Strimzi Kafka Operator installation completed!"
