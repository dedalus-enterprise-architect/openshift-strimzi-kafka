# Helm Values for Strimzi Kafka Operator

This folder contains Helm values files for deploying the Strimzi Kafka Operator on OpenShift. Use these files to customize the deployment for development or production environments.

## Files

- `openshift-dev-example.yaml`: Values optimized for development environments.
- `openshift-prod-example.yaml`: Values optimized for production environments.

## Parameters

The following table explains the key parameters in the Helm values files:

| Parameter                                           | Example Value         | Description                                                                                   |
|-----------------------------------------------------|-----------------------|-----------------------------------------------------------------------------------------------|
| `watchNamespaces`                                   | `[]`                  | Namespaces the operator should watch. `[]` means all namespaces (cluster-wide).               |
| `podSecurityContext.fsGroup`                        | `null`                | Set to `null` for OpenShift SCC compatibility.                                                |
| `containerSecurityContext.allowPrivilegeEscalation` | `false`               | Disables privilege escalation in containers.                                                  |
| `containerSecurityContext.capabilities.drop`        | `["ALL"]`             | Drops all Linux capabilities for enhanced security.                                           |
| `resources.requests.cpu`                            | `200m`                | Minimum CPU requested for operator pods.                                                      |
| `resources.requests.memory`                         | `384Mi`               | Minimum memory requested for operator pods.                                                   |
| `resources.limits.cpu`                              | `1000m`               | Maximum CPU allowed for operator pods.                                                        |
| `resources.limits.memory`                           | `1Gi`                 | Maximum memory allowed for operator pods.                                                     |
| `logLevel`                                          | `INFO`                | Sets the log level for the operator (e.g., `DEBUG`, `INFO`, `WARN`, `ERROR`).                 |
| `logFormat`                                         | `json`                | Sets the log format for the operator (e.g., `plain`, `json`).                                 |

## Usage

To use a values file, pass it to the Helm command with the `--values` option. For example:

### Development Environment
```bash
helm install strimzi-kafka-operator strimzi/strimzi-kafka-operator \
  --namespace kafka-operator \
  --values openshift-dev-example.yaml
```

### Production Environment
```bash
helm install strimzi-kafka-operator strimzi/strimzi-kafka-operator \
  --namespace kafka-operator \
  --values openshift-prod-example.yaml
```

