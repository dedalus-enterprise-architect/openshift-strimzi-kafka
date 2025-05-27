# Scripts for Strimzi Kafka Operator deployment

This folder contains scripts for installing and uninstalling the Strimzi Kafka Operator on OpenShift.

## Installation (`install.sh`)

Use `install.sh` to deploy the Strimzi Kafka Operator and optionally a Kafka cluster.

### Usage

Run the script from the repository root:
```bash
cd kafka
./scripts/install.sh [OPTIONS]
```

### Options
- `--namespace <namespace>`: Specify the OpenShift namespace where the operator will be deployed (default: `kafka-operator`).
- `--values <path>`: Provide a custom Helm values file for the deployment (default: `../deploy/strimzi-values/values.yaml`).

### Examples
- Deploy the operator in a custom namespace with a specific values file:
  ```bash
  ./scripts/install.sh --namespace my-namespace --values ../deploy/strimzi-values/openshift-dev-example.yaml
  ```

- Deploy the operator in the default namespace with the default values file:
  ```bash
  ./scripts/install.sh
  ```

### What the Script Does
- Installs the Strimzi Kafka Operator using Helm.
- Ensures the specified namespace exists (creates it if it doesn't).
- Configures the operator based on the provided Helm values file.
- Waits for the operator pods to become ready.

---

## Uninstallation (`uninstall.sh`)

Use `uninstall.sh` to remove the Strimzi Kafka Operator and related resources.

### Usage

Run the script from the repository root:
```bash
cd kafka
./scripts/uninstall.sh --namespace kafka-operator
```

### What the Script Does
- Deletes all Kafka custom resources in the specified namespace.
- Uninstalls the Helm release for the Strimzi Kafka Operator.
- Deletes Kafka-related Custom Resource Definitions (CRDs).
- Optionally deletes the namespace.

### Example
- Uninstall from the `kafka-operator` namespace:
  ```bash
  ./scripts/uninstall.sh --namespace kafka-operator
  ```