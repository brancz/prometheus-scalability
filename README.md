# Prometheus Scalability

This repository is the home of the setup the Prometheus team uses to perform Prometheus scalability tests on resource kindly provided by [packet.net](https://www.packet.net/) to [CNCF](https://www.cncf.io/) projects.

## Cluster setup

> Note this description is low in detail and will be extended as we actually implement the setup

There is one machine, that acts as the PXE host for the other machines. This host runs [CoreOS Container Linux](https://coreos.com/os/docs/latest/) as well as [matchbox](https://coreos.com/matchbox/docs/latest/). Matchbox serves the iPXE server, GRUB configs, [Container Linux Configs](https://coreos.com/os/docs/latest/provisioning.html) and everything else required. Using this setup the bare metal machines are booted, and used to provision the VMs via KVM (QEMU via a container).

* 9 physical machine of type 2 are used.
* Each host has 256Gb of RAM and 2x 24 core CPUs.
* On 8/9 of the hosts 125 VMs are creates on each host VM allocates 2Gb (250Gb / 125 VMs) of memory and 0.36 CPU (45CPU cores / 125 VMs). The physical node has 6Gb of memory and 3 cores CPU left for managing the VMs.
* On the 9th node, two large VMs are creates with 125Gb and 23 CPU cores each. The physical node has 6Gb of memory and 2 cores CPU left for managing the VMs.

The VMs on the physical hosts are then booted with the same matchbox host as the physical machines. The VMs however bring up a fully functioning Kubernetes cluster using [Typhoon](https://typhoon.psdn.io/bare-metal/).

Any additional automation that cannot be done through [container linux configs](https://coreos.com/os/docs/latest/provisioning.html), is accomplished via [Ansible](https://www.ansible.com/).

## Prometheus setup

> Note this description is low in detail and will be extended as we actually implement the setup

The following components are created on top of Kubernetes:

* Prometheus deployment (configured with 30s scrape interval and 30s evaluation interval)
* node-exporter daemonset
* kube-state-metrics deployment
