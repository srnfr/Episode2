# Episode2
YAML d'illustration du Webinar "Securité des flux et Kubernetes - Episode 2"


Pour voir le replay : https://app.livestorm.co/bluetrusty/episode-2-securite-des-flux-et-kubernetes/live?s=e6cb5fc2-511f-4d0d-8ade-998ba9d95a2f#/chat

# Contenu
- `webdemo.yml` => echo-server en LB
- `loop.sh` et `unloop.sh` => crée 100 deployments
- `toEPBF.sh` => `bascule` le Dataplane en EBF sur un AKS Azure CNI +Calico en NP
- `toKube-Proxy.sh` => retour au Dataplane standard (kube-proxy)
- `calico-ebpf-configmap.yaml` => à modifier pour indiquer l'IP de l'API Server (nécessaire quand Calico remplace kube-proxy)
