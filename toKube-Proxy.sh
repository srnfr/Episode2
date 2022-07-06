#!/bin/bash


kubectl patch installation.operator.tigera.io default --type merge -p '{"spec":{"calicoNetwork":{"linuxDataplane":"Iptables"}}}'

kubectl patch ds -n kube-system kube-proxy --type merge -p '{"spec":{"template":{"spec":{"nodeSelector":{"non-calico": null}}}}}'

calicoctl patch felixconfiguration default --patch='{"spec": {"bpfKubeProxyIptablesCleanupEnabled": false}}' --allow-version-mismatch

calicoctl get felixconfiguration default --allow-version-mismatch --output=yaml

kubectl get installation.operator.tigera.io default  -o yaml | grep linuxDataplane 
