#!/bin/bash

if [ ! -s /root/.ssh/id_rsa ]; then
ssh-keygen -N "" -f /root/.ssh/id_rsa
fi

if [ ! -s /root/.ssh/config ]; then
cat <<'EOF' > /root/.ssh/config
ForwardAgent yes
EOF
fi

ssh-agent > /tmp/agent.sh && source /tmp/agent.sh
ssh-add
bash
