#!/bin/bash

echo "Fill configmap"
IP_TO_BE_MODIFIED=$(kubectl cluster-info | head -1 | sed -e 's/.*https:\/\///' | cut -d: -f1)
PORT_TO_BE_MODIFIED=$(kubectl cluster-info | head -1 | sed -e 's/.*https:\/\///' | cut -d: -f2)

PORT_TO_BE_MODIFIED=443

echo "IP_TO_BE_MODIFIED => $IP_TO_BE_MODIFIED"
echo "PORT_TO_BE_MODIFIED => $PORT_TO_BE_MODIFIED"

rm -f calico-ebpf-configmap.yaml
cp calico-ebpf-configmap.yaml.org calico-ebpf-configmap.yaml

## SPECIAL SED FOR MACOS, see https://stackoverflow.com/questions/7573368/in-place-edits-with-sed-on-os-x
sed -i '' "s/<IP_TO_BE_MODIFIED>/$IP_TO_BE_MODIFIED/" calico-ebpf-configmap.yaml
sed -i '' "s/<PORT_TO_BE_MODIFIED>/$PORT_TO_BE_MODIFIED/" calico-ebpf-configmap.yaml

echo "---"
cat calico-ebpf-configmap.yaml
echo "--"
kubectl apply -f calico-ebpf-configmap.yaml -n tigera-operator

echo "Sleep 10sec.."
sleep 10

kubectl delete pod -n tigera-operator -l k8s-app=tigera-operator

kubectl patch ds -n kube-system kube-proxy -p '{"spec":{"template":{"spec":{"nodeSelector":{"non-calico": "true"}}}}}'

kubectl patch installation.operator.tigera.io default --type merge -p '{"spec":{"calicoNetwork":{"linuxDataplane":"BPF", "hostPorts":null}}}'

calicoctl patch felixconfiguration default --patch='{"spec": {"bpfKubeProxyIptablesCleanupEnabled": true}}' --allow-version-mismatch

calicoctl get felixconfiguration default --allow-version-mismatch --output=yaml

kubectl get installation.operator.tigera.io default  -o yaml | grep linuxDataplane 

rm -f calico-ebpf-configmap.yaml
