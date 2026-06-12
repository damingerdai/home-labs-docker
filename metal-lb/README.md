#  MetalLB

添加 Helm Repo：

```bash
helm repo add metallb https://metallb.github.io/metallb
helm repo update
```

安装：

```bash
helm install metallb metallb/metallb \
  -n metallb-system \
  --create-namespace
```

确认：

```bash
kubectl get pods -n metallb-system
```

跑完app.yaml文件之后验证

```bash
kubectl get ipaddresspool -n metallb-system


NAME           AUTO ASSIGN   AVOID BUGGY IPS   ADDRESSES
homelab-pool   true          false             ["192.168.31.230-192.168.31.239"]

kubectl get l2advertisement -n metallb-system
NAME      IPADDRESSPOOLS   IPADDRESSPOOL SELECTORS   INTERFACES
homelab                                              
```