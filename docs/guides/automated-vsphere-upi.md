# Implementing an Automated Installation Solution for OKD on vSphere with User Provisioned Infrastructure (UPI)

## Introduction

It’s possible to completely automate the process of installing OpenShift/OKD on vSphere with User Provisioned Infrastructure by chaining together the various functions of OCT via a wrapper script.

## Steps

1. Deploy the DNS, DHCP, and load balancer infrastructure outlined in the Prerequisites section.
2. Create an install-config.yaml.template file based on the format outlined in the section Sample install-config.yaml file for VMware vSphere of the OKD docs. Do not add a pull secret. The script will query you for one or it will insert a default one if you use the –auto-secret flag.
3. Create a wrapper script that:
    - Installs the desired FCOS image
    - Downloads the oc and openshift-installer binaries for your desired release version
    - Generates and modifies the ignition files appropriately
    - Builds the cluster nodes
    - Triggers the installation process.

## Prerequisites

### DNS

1 entry for the bootstrap node of the format bootstrap.[cluster].domain.tld
3 entries for the master nodes of the form master-[n].[cluster].domain.tld
An entry for each of the desired worker nodes in the form worker-[n].[cluster].domain.tld
1 entry for the API endpoint in the form api.[cluster].domain.tld
1 entry for the API internal endpoint in the form api-int.[cluster].domain.tld
1 wildcard entry for the Ingress endpoint in the form *.apps.[cluster].domain.tld

### DHCP

### Load Balancer

vSphere UPI requires the use of a load balancer. There needs to be two pools.

- API: This pool should contain your master nodes.
- Ingress: This pool should contain your worker nodes.

### Proxy (Optional)

If the cluster will sit on a private network, you’ll need a proxy for outgoing traffic, both for the install process and for regular operation. In the case of the former, the installer needs to pull containers from the external registries. In the case of the latter, the proxy is needed when application containers need access to the outside world (e.g. yum installs, external code repositories like gitlab, etc.)

The proxy should be configured to accept connections from the IP subnet for your cluster. A simple proxy to use for this purpose is squid

## Wrapper Script

```shell
#!/bin/bash

masters_count=3
workers_count=2
template_url="https://builds.coreos.fedoraproject.org/prod/streams/testing/builds/33.20210314.2.0/x86_64/fedora-coreos-33.20210314.2.0-vmware.x86_64.ova"
template_name="fedora-coreos-33.20210201.2.1-vmware.x86_64"     
library="Linux ISOs"
cluster_name="mycluster"
cluster_folder="/MyVSPHERE/vm/Linux/OKD/mycluster"
network_name="VM Network"
install_folder=`pwd`

# Import the template
./oct.sh --import-template --library "${library}" --template-url "${template_url}"

# Install the desired OKD tools
oct.sh --install-tools --release 4.6

# Launch the prerun to generate and modify the ignition files
oct.sh --prerun --auto-secret

# Deploy the nodes for the cluster with the appropriate ignition data
oct.sh --build --template-name "${template_name}" --library "${library}" --cluster-name "${cluster_name}" --cluster-folder "${cluster_folder}" --network-name "${network_name}" --installation-folder "${install_folder}" --master-node-count ${masters_count} --worker-node-count ${workers_count} 

# Turn on the cluster nodes
oct.sh --cluster-power on --cluster-name "${cluster_name}"  --master-node-count ${masters_count} --worker-node-count ${workers_count}

# Run the OpenShift installer 
bin/openshift-install --dir=$(pwd) wait-for bootstrap-complete  --log-level=info
```

## Future Updates

- Generating the install-config template
- Pull directly from FCOS release feed
