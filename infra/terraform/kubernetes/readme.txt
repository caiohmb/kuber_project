create cluster
kind create cluster --name chmb-kuber --config kind.yaml

create api-gateway
# Install CRD
kubectl kustomize https://github.com/nginxinc/nginx-gateway-fabric/config/crd/gateway-api/standard | kubectl apply -f -

# Install chart
helm install ngf oci://ghcr.io/nginxinc/charts/nginx-gateway-fabric --create-namespace -n nginx-gateway

# install ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
