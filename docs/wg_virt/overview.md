# OKD Virtualization Subgroup

<!--- cSpell:ignore Kube Virt Medik Konveyor operatorhub baremetal -->

The Goal of the OKD Virtualization Subgroup is to provide an integrated solution for classical virtualization users
based on [OKD](https://www.okd.io/), [HCO](https://github.com/kubevirt/hyperconverged-cluster-operator) and [KubeVirt](http://kubevirt.io/),
including a graphical user interface and deployed using bare metal suited method.

[Meet our community](community.md)!

## Documentation

* [Guide to installing OKD Virtualization on Bare Metal UPI](../guides/virt-baremetal-upi/index.md)

## Projects

The OKD Virtualization Subgroup is monitoring and integrating the following projects in a user consumable virtualization solution:

* [OKD](https://www.okd.io/) - as the platform
* [KubeVirt](http://kubevirt.io/) - as the virtualization plugin
* [HyperConverged Cluster Operator (HCO)](https://github.com/kubevirt/hyperconverged-cluster-operator) - for supporting tools
* [Rook](https://rook.io/)? (Or whatever the upstream operator is called) for feature rich data storage
* [Medik8s](https://www.medik8s.io/) and [NHC](https://github.com/medik8s/node-healthcheck-operator) for high-availability
* [Konveyor](https://www.konveyor.io/) for migration from other platforms
* [Faros](https://github.com/project-faros/faros.dev) deploy on small footprint, bare-metal clusters

## Deployment

* [UPI](https://docs.okd.io/latest/installing/installing_bare_metal/installing-bare-metal.html) first
* [Assisted Installer](https://github.com/openshift/assisted-installer)? for easy provisioning of OKD on bare-metal nodes

## Mailing List & Slack

OKD Workgroup Google Group: <https://groups.google.com/forum/#!forum/okd-wg>

Slack Channel: <https://kubernetes.slack.com/messages/openshift-dev>

## TODO

* some social activity like a blog post and more upstream documentation

* improve reliability of testing and CI on OKD

## SIG Membership

<!--- cSpell:ignore Michal Skrivanek Tiraboschi Sandro Bonazzola Deutsch -->
 * [Fabian Deutsch](https://github.com/fabiand) (Red Hat)
 * [Sandro Bonazzola](https://github.com/sandrobonazzola) (Red Hat)
 * [Simone Tiraboschi](https://github.com/tiraboschi) (Red Hat)
 * [Michal Skrivanek](https://github.com/michalskrivanek) (Red Hat)

## Resources for the SIG

### Automation in place:

HCO main branch gets tested against OKD 4.9: <https://github.com/openshift/release/blob/master/ci-operator/config/kubevirt/hyperconverged-cluster-operator/kubevirt-hyperconverged-cluster-operator-main__okd.yaml>

HCO precondition job: <https://prow.ci.openshift.org/job-history/gs/origin-ci-test/pr-logs/directory/pull-ci-kubevirt-hyperconverged-cluster-operator-main-okd-hco-e2e-image-index-gcp>

KubeVirt is uploaded to operatorhub and on community-operators: <https://github.com/redhat-openshift-ecosystem/community-operators-prod/tree/main/operators/community-kubevirt-hyperconverged>

