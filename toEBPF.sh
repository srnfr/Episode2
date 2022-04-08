#!/bin/bash

kubectl apply -f calico-ebpf-configmap.yaml -n tigera-operator

echo "Sleep 10sec.."
sleep 10

kubectl delete pod -n tigera-operator -l k8s-app=tigera-operator

kubectl patch ds -n kube-system kube-proxy -p '{"spec":{"template":{"spec":{"nodeSelector":{"non-calico": "true"}}}}}'

kubectl patch installation.operator.tigera.io default --type merge -p '{"spec":{"calicoNetwork":{"linuxDataplane":"BPF", "hostPorts":null}}}'

calicoctl patch felixconfiguration default --patch='{"spec": {"bpfKubeProxyIptablesCleanupEnabled": true}}' --allow-version-mismatch

calicoctl get felixconfiguration default --allow-version-mismatch --output=yaml

kubectl get installation.operator.tigera.io default  -o yaml | grep linuxDataplane 
