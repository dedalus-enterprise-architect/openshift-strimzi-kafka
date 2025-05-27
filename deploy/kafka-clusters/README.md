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
- Configure storage (ephemeral or persistent).
- Enable additional features like metrics or authorization.

For more details, refer to the [Strimzi Documentation](https://strimzi.io/docs/).
