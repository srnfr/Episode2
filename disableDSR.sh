#!/bin/bash
calicoctl patch felixconfiguration default --patch='{"spec": {"bpfExternalServiceMode": "Tunnel"}}' --allow-version-mismatch

