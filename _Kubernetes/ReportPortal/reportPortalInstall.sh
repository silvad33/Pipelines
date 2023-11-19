kubectl config use-context aks-poc-eastus2

echo

kubectl create namespace report-portal

echo

helm repo add bitnami https://charts.bitnami.com/bitnami

echo

kubectl -n report-portal create secret generic reportportal-minio-creds \
    --from-literal=root-password=pr3sid10it$ \
    --from-literal=root-user=admin

echo

helm upgrade --install minio bitnami/minio \
    -f minioValues.yaml \
    -n report-portal \
    --version 11.10.3 \
    --create-namespace

echo

kubectl -n report-portal create secret generic reportportal-rabbitmq-creds \
    --from-literal=rabbitmq-password=vrvvev9xKC \
    --from-literal=rabbitmq-erlang-cookie=X3XzssZXXJavxNxMKsQRxLu6atArPf8t

echo

helm upgrade --install rabbitmq bitnami/rabbitmq \
    -f rabbitValues.yaml \
    -n report-portal \
    --version 10.3.8 \
    --create-namespace

echo

kubectl -n report-portal exec -it rabbitmq-0 -- rabbitmqctl set_vm_memory_high_watermark 0.8

echo

helm repo add bitnami-archive https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami

echo

kubectl -n report-portal create secret generic reportportal-postgresql-creds \
    --from-literal=postgresql-password=XXE7NNuj8czuUXFX \
    --from-literal=postgresql-postgres-password=EXXBdU5NFCnsDDXE

echo

helm upgrade --install postgresql bitnami-archive/postgresql \
    -f postgresValues.yaml \
    -n report-portal \
    --version 10.9.4 \
    --create-namespace

echo

helm repo add elastic https://helm.elastic.co

echo

helm upgrade --install elasticsearch elastic/elasticsearch \
    -n report-portal \
    -f elasticSearchValues.yaml \
    --version 7.17.3 \
    --create-namespace

echo

helm repo add reportportal https://reportportal.github.io/kubernetes

echo

helm upgrade --install report-portal reportportal/reportportal \
    -f reportPortalValues.yaml \
    -n report-portal \
    --create-namespace