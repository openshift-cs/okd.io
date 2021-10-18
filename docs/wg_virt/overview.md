# OKD Virtualization Subgroup

The Goal of the OKD Virtualization Subgroup is to provide an integrated solution for classical virtualization users
based on [OKD](https://www.okd.io/), [HCO](https://github.com/kubevirt/hyperconverged-cluster-operator) and [KubeVirt](http://kubevirt.io/),
including a graphical user interface and deployed using bare metal suited method.

[Meet our community](community.md)!

## Projects

The OKD Virtualization Subgroup is monitoring and integrating the following projects in a user consumable virtualization solution:

<!--- cSpell:ignore Kube Virt Medik Konveyor operatorhub -->
* [OKD](https://www.okd.io/) - as the platform
* [KubeVirt](http://kubevirt.io/) - as the virtualization plugin
* [HyperConverged Cluster Operator (HCO)](https://github.com/kubevirt/hyperconverged-cluster-operator) - for supporting tools
* [Rook](https://rook.io/)? (Or whatever the upstream operator is called) for feature rich data storage
* [Medik8s](https://www.medik8s.io/) and [NHC](https://github.com/medik8s/node-healthcheck-operator) for high-availability
* [Konveyor](https://www.konveyor.io/) for migration from other platforms
* [Faros](https://faros.dev/) deploy on small footprint, bare-metal clusters

## Deployment

* [UPI](https://docs.okd.io/latest/installing/installing_bare_metal/installing-bare-metal.html) first
* [Assisted Installer](https://github.com/openshift/assisted-installer)? for easy provisioning of OKD on bare-metal nodes

## Mailing List & Slack

OKD Workgroup Google Group: <https://groups.google.com/forum/#!forum/okd-wg>

Slack Channel: <https://kubernetes.slack.com/messages/openshift-dev>

## TODO

* some social activity like a blog post and more upstream documentation

* just as a general comment (I don't have "real" data), I want to add that on CI side we are more flaky on OKD than on OCP: nothing so serious, but we see more false positives on OKD lanes than on OCP ones

## SIG Membership

<!--- cSpell:ignore Michal Skrivanek Tiraboschi Sandro Bonazzola Deutsch -->
 * [Fabian Deutsch](https://github.com/fabiand) (Red Hat)
 * [Sandro Bonazzola](https://github.com/sandrobonazzola) (Red Hat)
 * [Simone Tiraboschi](https://github.com/tiraboschi) (Red Hat)
 * [Michal Skrivanek](https://github.com/michalskrivanek) (Red Hat)

## Resources for the SIG

### Automation in place:

HCO main branch gets tested against OKD 4.9: <https://github.com/openshift/release/blob/master/ci-operator/config/kubevirt/hyperconverged-cluster-operator/kubevirt-hyperconverged-cluster-operator-main__okd.yaml>

HCO precondition job: <https://prow.ci.openshift.org/job-history/gs/origin-ci-test/pr-logs/directory/pull-ci-k[…]onverged-cluster-operator-main-okd-hco-e2e-image-index-gcp>

KubeVirt is uploaded to operatorhub and on community-operators: <https://github.com/redhat-openshift-ecosystem/community-operators-prod/tree/main/operators/community-kubevirt-hyperconverged>

