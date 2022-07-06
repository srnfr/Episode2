#!/bin/bash
calicoctl patch felixconfiguration default --patch='{"spec": {"bpfExternalServiceMode": "DSR"}}' --allow-version-mismatch

