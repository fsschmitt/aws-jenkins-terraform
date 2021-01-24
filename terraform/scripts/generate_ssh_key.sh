#!/bin/bash

PUB_KEY=/root/.ssh/id_rsa.pub
PRIV_KEY=/root/.ssh/id_rsa
if [[ -f "$PUB_KEY" ]]; then
    echo "[INFO] The file $PUB_KEY already exists, will use it .."
else
  echo "[NEW] Generating SSH Key pair to use on EC2 instances .."
  ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa
fi
