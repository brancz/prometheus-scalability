[Unit]
Description=CoreOS matchbox Server
Documentation=https://github.com/coreos/matchbox

[Service]
User=matchbox
Group=matchbox
Environment="MATCHBOX_ADDRESS={{hostvars[ansible_hostname].ansible_vmbri0.ipv4.address}}:8080"
Environment="MATCHBOX_RPC_ADDRESS={{hostvars[ansible_hostname].ansible_vmbri0.ipv4.address}}:8081"
ExecStart=/usr/local/bin/matchbox -assets-path ''

# systemd.exec
ProtectHome=yes
ProtectSystem=full

[Install]
WantedBy=multi-user.target
