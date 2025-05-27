# Kafka Cluster Examples

This folder references the official Kafka cluster examples provided by the Strimzi project. These examples demonstrate how to deploy Kafka clusters with different configurations.

## Official Examples

The official examples are available in the Strimzi GitHub repository. Below is a summary of each example:

1. **[Kafka Ephemeral Cluster](https://github.com/strimzi/strimzi-kafka-operator/blob/main/examples/kafka/kafka-ephemeral.yaml)**  
   Deploys a Kafka cluster with ephemeral storage. This is suitable for development and testing environments where data persistence is not required.

2. **[Kafka Persistent Cluster](https://github.com/strimzi/strimzi-kafka-operator/blob/main/examples/kafka/kafka-persistent.yaml)**  
   Deploys a Kafka cluster with persistent storage. This is suitable for production environments where data durability is critical.

3. **[Kafka with External Access](https://github.com/strimzi/strimzi-kafka-operator/blob/main/examples/kafka/kafka-external.yaml)**  
   Deploys a Kafka cluster with external access enabled using LoadBalancer or NodePort. This is useful for exposing Kafka to clients outside the Kubernetes cluster.

4. **[Kafka with Authorization](https://github.com/strimzi/strimzi-kafka-operator/blob/main/examples/kafka/kafka-authorization-simple.yaml)**  
   Deploys a Kafka cluster with simple authorization enabled. This allows you to define access control lists (ACLs) for Kafka topics and users.

5. **[Kafka with Metrics](https://github.com/strimzi/strimzi-kafka-operator/blob/main/examples/kafka/kafka-metrics.yaml)**  
   Deploys a Kafka cluster with Prometheus metrics enabled. This is useful for monitoring Kafka performance and health.

6. **[Kafka Single Node](https://github.com/strimzi/strimzi-kafka-operator/blob/main/examples/kafka/kafka-single-node.yaml)**  
   Deploys a minimal single-node Kafka broker. This is ideal for development environments, testing, or scenarios with limited resources where a full multi-broker cluster is unnecessary.

## Usage

1. Clone the Strimzi repository:
   ```bash
   git clone https://github.com/strimzi/strimzi-kafka-operator.git
   cd strimzi-kafka-operator/examples/kafka
   ```

2. Deploy a Kafka cluster:
   - For an ephemeral cluster:
     ```bash
     oc apply -f kafka-ephemeral.yaml -n kafka-operator
     ```
   - For a persistent cluster:
     ```bash
     oc apply -f kafka-persistent.yaml -n kafka-operator
     ```
   - For external access:
     ```bash
     oc apply -f kafka-external.yaml -n kafka-operator
     ```
   - For authorization:
     ```bash
     oc apply -f kafka-authorization-simple.yaml -n kafka-operator
     ```
   - For metrics:
     ```bash
     oc apply -f kafka-metrics.yaml -n kafka-operator
     ```
   - For a single-node cluster:
     ```bash
     oc apply -f kafka-single-node.yaml -n kafka-operator
     ```

3. Verify the deployment:
   ```bash
   oc get kafka -n kafka-operator
   oc get pods -n kafka-operator
   ```

## Customization

You can modify the example YAML files to:
- Change the number of Kafka or ZooKeeper replicas.
- Adjust resource requests and limits.
- Enable external access using LoadBalancer or NodePort.
- Enable additional features like metrics or authorization.
- Configure storage (ephemeral or persistent). See [Storage considerations](#storage-considerations) for details.

## Storage considerations

When deploying Kafka clusters in KRaft (Kafka Raft) mode, storage configuration is especially important because both Kafka data and metadata are stored on disk by each broker. In KRaft mode:
- **No ZooKeeper**: All metadata previously managed by ZooKeeper is now managed by Kafka itself and stored locally on the brokers.
- **Storage Requirements**: Each broker must have persistent storage for both logs and metadata. Using ephemeral storage is not recommended for production, as data loss can lead to loss of cluster metadata and messages.
- **State Recovery**: If a broker loses its storage, it will lose both its data and metadata, which can impact the entire cluster's integrity.

### Storage Types Summary

- **Ephemeral**: Temporary, pod-local storage.
```yaml
# Using emptyDir (ephemeral):
volumes:
  - name: kafka-logs
    emptyDir: {}
```

- **Persistent**: Durable storage via PVC.
```yaml
# Using a persistentVolumeClaim:
volumes:
  - name: kafka-logs
    persistentVolumeClaim:
      claimName: kafka-logs-pvc
```

- **JBOD**: Multiple disks for load distribution.
```yaml
# Multiple PVCs for JBOD:
volumes:
  - name: kafka-disk-0
    persistentVolumeClaim:
      claimName: kafka-disk-0-pvc
  - name: kafka-disk-1
    persistentVolumeClaim:
      claimName: kafka-disk-1-pvc
```
