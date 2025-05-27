#!/bin/bash
# Strimzi Kafka Operator uninstallation script for OpenShift

set -e

# Check for required binaries
command -v oc >/dev/null 2>&1 || { echo "Error: oc is not installed or not in PATH."; exit 1; }
command -v helm >/dev/null 2>&1 || { echo "Error: helm is not installed or not in PATH."; exit 1; }

# Default values
NAMESPACE="kafka-operator"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --namespace)
      NAMESPACE="$2"
      shift; shift
      ;;
    *)
      echo "Unknown option: $key"
      exit 1
      ;;
  esac
done

echo "Uninstalling Strimzi Kafka Operator from namespace: $NAMESPACE"

# Delete Kafka custom resources
echo "Deleting all Kafka custom resources..."
oc delete kafka --all -n $NAMESPACE || echo "No Kafka resources found."

# Uninstall the Helm release
echo "Uninstalling Helm release..."
helm uninstall strimzi-kafka-operator -n $NAMESPACE || echo "Helm release not found."

# Delete Custom Resource Definitions (CRDs)
echo "Deleting Kafka-related CRDs..."
oc get crds | grep kafka | awk '{print $1}' | xargs oc delete crd || echo "No Kafka CRDs found."

# Optionally delete the namespace
read -p "Do you want to delete the namespace $NAMESPACE? (y/N): " CONFIRM
if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
  echo "Deleting namespace $NAMESPACE..."
  oc delete namespace $NAMESPACE || echo "Namespace not found."
else
  echo "Namespace $NAMESPACE not deleted."
fi

echo "Uninstallation completed!"
