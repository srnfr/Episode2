#!/bin/bash
## A FAIRE SUR CHAQUE NOEUD DU CLUSTER
## S'Y CONNECTER PAR EXEMPLE AVEC NSENTER

cat <<EOF | tee /etc/systemd/system/sys-fs-bpf.mount
[Unit]
Description=BPF mounts
DefaultDependencies=no
Before=local-fs.target umount.target
After=swap.target

[Mount]
What=bpffs
Where=/sys/fs/bpf
Type=bpf
Options=rw,nosuid,nodev,noexec,relatime,mode=700

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start sys-fs-bpf.mount
systemctl enable sys-fs-bpf.mount

