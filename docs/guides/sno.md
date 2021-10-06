# Single Node OKD Installation

<!--- cSpell:ignore wildcard virt libguestfs epel devel -->

This document outlines how to deploy a single node OKD cluster using virt.

## Requirements

- Host with a minimal CentOS Stream, Fedora, or CentOS-8 installed (*do not create a /home filesystem*)
- Monitor, mouse, and keyboard attached to the host
- Static IP for the host
- The following packages installed: virt, wget, git, net-tools, bind, bind-utils, bash-completion, rsync, libguestfs-tools, virt-install, epel-release, libvirt-devel, httpd-tools, snf, nginx

## Procedure

For the complete procedure, please see [Building an OKD4 single node cluster with minimal resources](https://cgruver.github.io/okd4-single-node-cluster){: target=_blank}
