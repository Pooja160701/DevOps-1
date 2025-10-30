# Wisecow — containerized and Kubernetes-ready

This repo contains the Wisecow app plus Dockerfile, Kubernetes manifests, and a GitHub Actions workflow to build/push and optionally deploy.

## Local quick start (Minikube)

1. **Build and run locally with Docker:**

```bash
# build
docker build -t wisecow:local .
# run
docker run --rm -p 4499:4499 wisecow:local
# then open http://localhost:4499 in the browser
```
**Output:**

![Input Image](result.png)

2. **Deploy to Minikube / Kind (example using Minikube):**

```bash
docker save -o kicbase-v0.0.48.tar gcr.io/k8s-minikube/kicbase:v0.0.48

minikube image load ./kicbase-v0.0.48.tar

# start minikube
minikube start --driver=docker --container-runtime=docker --base-image=gcr.io/k8s-minikube/kicbase:v0.0.48 --preload=false --memory=2048 --cpus=2

# enable ingress for minikube
minikube addons enable ingress

# build image and load into minikube

docker build -t ghcr.io/pooja160701/wisecow:latest .

minikube image load ghcr.io/pooja160701/wisecow:latest

# create TLS secret (for ingress)
./k8s/create-tls-secret.sh wisecow.local

# apply k8s manifests
kubectl apply -f k8s/


# open in browser
# http(s)://wisecow.local
```

3. CI/CD

Push to `main` and GitHub Actions will build and push the image to GHCR. To enable auto-deploy, add a base64-encoded kubeconfig as the `KUBE_CONFIG` secret.