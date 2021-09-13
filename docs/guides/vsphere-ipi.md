# vSphere IPI Deployment

This describes the resources used by OpenShift after performing an installation using the required options for the installer.

## Infrastructure

### Compute

All vms stored within folder described above and tagged with tag created by installer.

* 3 control plane vms (name format: `{cluster name}-{generated cluster id}-master-{0,1,2}`)
  * 4 vCPU
  * 16 GB RAM
  * 120 GB storage
  
* 3 worker vms (name format: `{cluster name}-{generated cluster id}-master-{generated worker id}`)
  * 2 vCPU
  * 8 GB RAM
  * 120 GB storage

### Networking

Should be set up by user. Installer doesn't create anything there. Network name should be provided as installer argument.

### Miscellaneous

* tag category with format `openshift-{cluster name}-{generated cluster id}`
* tag with format `{cluster name}-{generated cluster id}`
* folder with title format `{cluster name}-{generated cluster id}`
* disabled virtual machine with name `{cluster name}-rhcos-{generated cluster id}` which using as template for further scaling

## Deployment

See the [OKD documentation](https://docs.okd.io/latest/installing/installing_vsphere/installing-vsphere-installer-provisioned.html){: target=_blank} to proceed with deployment
