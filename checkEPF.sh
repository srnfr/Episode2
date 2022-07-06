#!/bin/bash

kubectl get installation.operator.tigera.io default  -o yaml | grep linuxDataplane
