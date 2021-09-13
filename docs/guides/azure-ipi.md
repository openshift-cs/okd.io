# Azure IPI Default Deployment

This describes the resources used by OpenShift after performing an installation using the default options for the installer.

## Infrastructure

### Compute

- 3 control plane nodes
    - instance type `Standard_D8s_v3`
- 3 compute nodes
    - instance type `Standard_D4s_v3`

### Networking

- 1 virtual network (VNet) containing 2 subnets
- 6 network interfaces
-3 network load balancers
    - 1 public for compute node access
    - 1 private for control plane access
    - 1 public for control plane access
- 2 public IP addresses
    - 1 for the public compute load balancer
    - 1 for the public control plane load balancer
- 7 private IP addresses
    - 1 per control plane node
    - 1 per compute node
    - 1 for the private control plane load balancer
- 2 network security groups
    - 1 for control plane allowing traffic on port 6443 from anywhere
    - 1 for compute allowing traffic on ports 80 and 443 from the internet

## Deployment

See the [OKD documentation](https://docs.okd.io/latest/installing/installing_azure/installing-azure-account.html){: target=_blank} to proceed with deployment
