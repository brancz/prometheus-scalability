# Infrastructure Setup

This Ansible script sets up the test infrastructure on Packet.

Given a machine for the master nodes and multiple machines for worker nodes
it creates VMs, configures the network and installs a Kubernetes cluster
using the Tectonic Installer.

## How to

 1. Build the Docker container

    `docker build . -t prom-scalabilty-infra`

 1. Run Docker container

    `docker run -ti prom-scalabilty-infra:latest`

 1. Copy & paste the container's public key to your Packet account

    `cat /root/.ssh/id_rsa.pub`

 1. Start your machines on Packet

    > Make sure above public key is selected under SSH & User data

 1. Setup VLAN

     * Create VLAN using Packet interface
     * Assign this VLAN to each machine's eth1 interface

 1. Edit Ansible hosts to add your machines and adjust the host vars
    to match your machine type.

    `vi /etc/ansible/hosts`

 1. Wait until machines are up and run the Ansible playbook

    `ansible-playbook setup.yml`

    To destroy the current cluster and bring up a new one. First run the
    `teardown.yml` playbook and then the `setup.yml` playbook again.

 1. Access the cluster

    After Ansible finishes SSH into the master and use kubectl to access
    the cluster.
