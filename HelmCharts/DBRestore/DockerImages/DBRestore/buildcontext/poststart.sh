mkdir ~/.kube
cp /clusterconfig/kubeconfig ~/.kube/config
cp /clusterconfig/kubeconfig /app/cluster-config.yaml

cd /app
dotnet BackupRestoreManagerConsole.dll