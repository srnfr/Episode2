#!/bin/bash



## Pod Remote
export EBPF_INTERESTING_IP=10.240.0.12
export EBPF_INTERESTING_IP=77.194.43.229
## Pod Local
#export EBPF_INTERESTING_IP=10.240.0.13


export EBPF_INTERESTING_PORT=8080

for i in `kubectl get pod -o wide -n calico-system | grep calico-node | awk '{print $1}'`; do echo $i; echo "-----"; kubectl exec -n calico-system $i -- calico-node -bpf conntrack dump 2>&1 | grep ${EBPF_INTERESTING_IP} | grep ${EBPF_INTERESTING_PORT}; printf "\n"; done

