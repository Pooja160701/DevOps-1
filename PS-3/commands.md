# 🛡️  Problem Statement 3  
## Zero Trust KubeArmor Policy Setup and Verification

Below are the exact commands used to configure, deploy, and test the KubeArmor Zero Trust Policy for the Kubernetes workload (PS1).

---

### ⚙️ 1. Verify Kubernetes Context
```bash
kubectl config current-context
````

---

### 🧩 2. Check if the Cluster is Running

```bash
kubectl get pods -n kube-system
```

---

### 🪄 3. Add Helm to PATH (Git Bash only)

```bash
echo 'export PATH=$PATH:/c/ProgramData/chocolatey/bin' >> ~/.bashrc
source ~/.bashrc
```

---

### 🧰 4. Add and Update KubeArmor Helm Repository

```bash
helm repo add kubearmor https://kubearmor.github.io/charts
helm repo update
```

---

### 🚀 5. Install KubeArmor in the Cluster

```bash
helm install kubearmor kubearmor/kubearmor --namespace kube-system
```

---

### 🔒 6. Apply Zero Trust KubeArmor Policy

```bash
kubectl apply -f PS-3/kubearmor-zero-trust-ps1.yaml
```

---

### ✅ 7. Verify Policy Creation

```bash
kubectl get kubearmorpolicies -n default
```

---
