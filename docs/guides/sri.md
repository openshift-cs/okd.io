# Sri's Overkill Homelab Setup

<!--- cSpell:ignore Homelab Ryzen NVME baremetal helpernode ceph alertmanager grafana datacenter bitwarden jellyfin netbox quassel templating  -->

This document lays out the resources used to create my completely-overkill homelab. This cluster provides all the compute and storage I think I'll need for the foreseeable future, and the CPU, RAM, and storage can all be scaled vertically independently of each other. Not that I think I'll need to do that for a while.

More detail into the deployment and my homelab's Terraform configuration can be found [here](https://github.com/SriRamanujam/okd-deployment){: target=_blank}.

## Hardware

- 3 hyper-converged hypervisors
    - Ryzen 5 3600
    - 64 GiB RAM
    - 3x 4TiB HDD
    - 2x 500GiB SSD in RAID1
    - 1x 256GiB NVME for boot disk

- 1 NUC I had laying around gathering dust
    - Intel Core i3-5010U
    - 16 GiB RAM
    - 500GiB SSD

## Main cluster

My hypervisors each host an identical workload. The total size of this cluster is 3 control plane nodes, and 9 worker nodes.
So it splits very nicely three ways. Each hypervisor hosts 1 control plane VM and 3 worker VMs.

- 3 control plane nodes
    - 4x CPU
    - 10 GiB RAM
    - 50 GiB disk

- 9 worker nodes
    - 8x CPU
    - 16 GiB RAM
    - 50 GiB root disk
    - 4 TiB HDD for workload use

- 1 bootstrap node (temporary, taken down after initial setup is complete)
    - 4 vCPU
    - 8 GiB RAM
    - 120 GiB root disk

## Supporting infrastructure

### Networking

OKD, and especially baremetal UPI OKD, requires a very specific network setup. You will most likely need something more flexible than your ISP's router to get everything fully configured. [The documentation](https://docs.okd.io/latest/installing/installing_bare_metal/installing-bare-metal.html#installation-network-user-infra_installing-bare-metal){: target=_blank} is very clear on the various DNS records and DHCP static allocations you will need to make, so I won't go into them here.

However, there are a couple extra things that you may want to set for best results. In particular, I make sure that I have [PTR records](https://www.cloudflare.com/learning/dns/dns-records/dns-ptr-record/){: target=_blank} set up for all my cluster nodes. This is extremely important as the nodes need a correct PTR record set up for them to auto-discover their hostname. Clusters typically do not set themselves up properly if there are hostname collisions!

### API load balancer

I run a separate smaller VM on the NUC as a single-purpose load balancer appliance, running HAProxy.

- 1 load balancer VM
    - 2x vCPU
    - 256MiB RAM
    - 10GiB disk

The HAProxy config is straightforward. I adapted mine from the example config file created by the [ocp4-helpernode](https://github.com/RedHatOfficial/ocp4-helpernode/blob/master/templates/haproxy.cfg.j2){: target=_blank} playbook.

## Deployment

I create the VMs on the hypervisors using Terraform. The [Terraform Libvirt provider](https://github.com/dmacvicar/terraform-provider-libvirt){: target=_blank} is very, very cool. It's also used by `openshift-install` for its Libvirt-based deployments, so it supports everything needed to deploy OKD nodes. Most importantly, I can use Terraform to supply the VMs with their Ignition configs, which means I don't have to worry about passing kernel args manually or setting up a PXE server to get things going like the official OKD docs would have you do. Terraform also makes it easy to tear down the cluster and reset in case something goes wrong.

## Post-Bootstrap One-Time Setup

### Storage with Rook and Ceph

I deploy a Ceph cluster into OKD using Rook. The Rook configuration deploys OSDs on top of the 4TiB HDDs assigned to each worker. I deploy an erasure-coded CephFS pool (6+2) for RWX workloads and a 3x replica block pool for RWO workloads.

### Monitoring and Alerting

OKD comes with a very comprehensive monitoring and alerting suite, and it would be a shame not to take advantage of it. I set up an Alertmanager webhook to send any alerts to a [small program I wrote that posts the alerts to Discord](https://github.com/SriRamanujam/alertmanager-discord-bridge){: target=_blank}.

I also deploy a Prometheus + Grafana set up into the cluster that collects metrics from the various hypervisors and supporting infrastructure VMs. I use Grafana's built-in Discord alerting mechanism to post those alerts.

### LoadBalancer with MetalLB

[MetalLB](https://metallb.universe.tf){: target=_blank} is a piece of fantastic software that allows on-prem or otherwise non-public-cloud Kubernetes clusters to enjoy the luxury of `LoadBalancer` type services. It's dead simple to set up and makes you feel you're in a real datacenter. I deploy several workloads that don't use standard HTTP and so can't be deployed behind a `Route`. Without MetalLB, I wouldn't be able to deploy these workloads on OKD at all but with it, I can!

## Software I Run

I maintain an ansible playbook that handles deploying my workloads into the cluster. I prefer Ansible over other tools like Helm because it has more robust capabilities to store secrets, I find its templating capabilities more flexible and powerful than Helm's (especially when it comes to inlining config files into config maps or creating templated Dockerfiles for BuildConfigs), and because I am already familiar with Ansible and know how it works.

- [paperless-ng](https://github.com/jonaswinkler/paperless-ng){: target=_blank} - A document organizer that uses machine learning to automatically classify and organize
- [bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs){: target=_blank} - Password manager
- [Jellyfin](https://jellyfin.org/){: target=_blank} - Media management
- [Samba](https://www.samba.org/){: target=_blank} - I joined a StatefulSet to my AD domain and it serves an authenticated SMB share
- [Netbox](https://github.com/netbox-community/netbox){: target=_blank} - Infrastructure management tool
- [Quassel](https://quassel-irc.org){: target=_blank} - IRC bouncer
- [Ukulele](https://github.com/Frederikam/ukulele){: target=_blank} - Bot that plays music into Discord channels
- RPM and deb package repos for internal packages
