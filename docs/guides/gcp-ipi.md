# GCP IPI Default Deployment

<!--- cSpell:ignore subnetworks -->

This describes the resources used by OpenShift after performing an installation using the default options for the installer.

## Infrastructure

### Compute

- 3 control plane nodes
    - instance type `n1-standard-4`
- 3 compute nodes
    - instance type `n1-standard-2`
- 1 image

### Networking

- 2 networks
- 2 subnetworks
- 3 static IP addresses
- 1 router
- 2 routes
- 3 target pools
- 10 firewall rules
- 2 forwarding rules
- 3 in-use global IP addresses
- 3 health checks

### Platform

- 5 IAM service accounts

## Deployment

See the [OKD documentation](https://docs.okd.io/latest/installing/installing_gcp/installing-gcp-account.html){: target=_blank} to proceed with deployment
