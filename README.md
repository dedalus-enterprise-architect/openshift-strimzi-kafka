# Strimzi Kafka OpenShift Deployment
<!-- cSpell:ignore strimzi -->

This repository contains configuration and deployment files for running Apache Kafka on OpenShift using the Strimzi Kafka Operator.

## References

- [Strimzi Documentation](https://strimzi.io/docs/)

## Table of Contents

1. [References](#references)
2. [Table of Contents](#table-of-contents)
3. [Repository Structure](#repository-structure)
4. [Concepts](#concepts)
   - [Deployment](#deployment)
   - [Watch namespaces](#watch-namespaces)
   - [Role-Based Access Control (RBAC)](#role-based-access-control-rbac)
5. [Prerequisites](#prerequisites)
6. [Strimzi Kafka Operator deployment](#strimzi-kafka-operator-deployment)
   - [Manual](#manual)
   - [Automated](#automated)
7. [Kafka Cluster](#kafka-cluster)
8. [Strimzi Kafka Operator uninstallation](#strimzi-kafka-operator-uninstallation)
   - [Manual](#manual-1)
   - [Automated](#automated-1)

## Repository Structure

```
kafka/
├── README.md                  # Main documentation
├── deploy/                    # Deployment YAML files
│   ├── strimzi-values/        # Helm values files for different environments
│   │   ├── openshift-dev-example.yaml
│   │   └── openshift-prod-example.yaml
│   └── kafka-clusters/        # Additional Kafka cluster deployment examples
│       └── README.md          # Documentation for Kafka cluster deployment
├── scripts/                   # Installation and cleanup scripts
│   ├── install.sh             # Script for automated installation
│   ├── uninstall.sh           # Script for automated uninstallation
│   └── README.md             # Documentation for the install script
```

## Concepts

### Deployment

1. Deploy the Strimzi operator in a dedicated namespace, separate from the Kafka cluster and its components, to maintain clear resource and configuration boundaries.

2. Use a single Strimzi operator to manage all Kafka instances within the cluster, avoiding conflicts and redundancy.

3. The Cluster Operator uses `ClusterRole` resources to access necessary resources, which may require cluster administrator privileges for setup.

### Watch namespaces

Strimzi operators manage resources across namespaces with the following capabilities:

- **Cluster Operator**: Can watch a single namespace, multiple namespaces, or all namespaces in the cluster.
- **Topic Operator and User Operator**: Limited to watching a single namespace.
- **Access Operator**: Can watch a single namespace or all namespaces.

### Role-Based Access Control (RBAC)

Strimzi provides custom roles to delegate permissions for managing Strimzi resources:

1. `strimzi-view`: Allows users to view and list Strimzi resources (aggregates into default Kubernetes `view` role).

2. `strimzi-admin`: Grants additional permissions to create, edit, or delete Strimzi resources (aggregates into default Kubernetes `edit` and `admin` roles).

A cluster administrator can assign these roles to non-cluster administrators after deploying the Cluster Operator.

## Prerequisites

  - On your Linux client
    - OpenShift client utility: ```oc```
    - Helm client utility v3.11 or higher: ```helm```
    - Local clone of this repo
  - On OpenShift
    - Cluster admin privileges
    - Access to ```quay.io``` registry

## Strimzi Kafka Operator deployment

### Manual

1. **Add the Strimzi Helm Repository**
   ```bash
   helm repo add strimzi https://strimzi.io/charts/
   helm repo update
   ```

2. **Deploy the Strimzi Kafka Operator**

   ```bash
   NAMESPACE=kafka-operator
   helm install strimzi-kafka-operator strimzi/strimzi-kafka-operator \
     --namespace $NAMESPACE \
     --values deploy/strimzi-values/openshift-dev-example.yaml

3. **Verify the Deployment**
   ```bash
   NAMESPACE=kafka-operator
   helm status strimzi-kafka-operator -n $NAMESPACE
   oc get pods -n $NAMESPACE
   ```

### Automated

The deployment process can be automated using the provided script.
For additional details, please refer to the [script README](./scripts/README.md).

## Kafka Cluster

To deploy your Kafka cluster for different use cases and customizations, refer to the examples provided in [Kafka Clusters deployment](deploy/kafka-clusters/README.md).

## Strimzi Kafka Operator uninstallation

You can uninstall the Strimzi Kafka Operator and related resources either manually or using the provided script.

### Manual

1. **Delete Kafka Custom Resources**
   ```bash
   NAMESPACE=kafka-operator
   oc delete kafka --all -n $NAMESPACE
   ```

2. **Uninstall the Helm Release**
   ```bash
   NAMESPACE=kafka-operator
   helm uninstall strimzi-kafka-operator -n $NAMESPACE
   ```

3. **Delete Custom Resource Definitions (CRDs)**
   ```bash
   oc get crds | grep kafka | awk '{print $1}' | xargs oc delete crd
   ```

4. **Delete the Namespace (Optional)**
   ```bash
   NAMESPACE=kafka-operator
   oc delete namespace $NAMESPACE
   ```

### Automated

Use the provided `uninstall.sh` script to automate the uninstallation process.
For additional details, please refer to the [script README](./scripts/README.md).
