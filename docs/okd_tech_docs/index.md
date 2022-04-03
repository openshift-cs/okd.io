# OKD Technical Documentation

<!--- cSpell:ignore pullspecs -->

This section of the documentation is for developers that want to customize OKD.

The section will cover:

- How is OKD delivered
- How to build an OKD operator
- How to deploy a self-build version of an OKD operator to an existing cluster
- How to create a customized OKD installer containing your self-built operator

The above section will allow you to work on fixes and enhancements to core OKD operators and be able to run them locally.

In addition to the above this section will also look at the Red Hat build and test setup, looking at how OpenShift and OKD operators are built and tested and how releases are created.

## OKD Releases

OKD is a Kubernetes based platform that delivers a fully managed platform from the core operating system to the Kubernetes platform and the services running on it.  All aspects of OKD are managed by a collection of operators.  

OKD shares most of the same source code as Red Hat OpenShift.  One of the primary differences is that OKD uses [Fedora CoreOS](https://getfedora.org/en/coreos?stream=stable){target=_blank} where OpenShift uses Red Hat Enterprise Linux CoreOS as the base platform for cluster nodes.

An OKD release is a strictly defined set of software.  A release is defined by a **release payload**, which contains an operator (Cluster Version Operator), a list of manifests to apply and a reference file.  You can get information about a release using the **oc** command line utility, `oc adm release info <release name>`.

You can find the latest available release [here](https://github.com/openshift/okd/releases){target=_blank}.  

For the OKD 4.10 release named *4.10.0-0.okd-2022-03-07-131213* the command would be `oc adm release info 4.10.0-0.okd-2022-03-07-131213`

you can add additional command line options to get more specific information about a release:

- `--commit-urls` shows the source code that makes up the release
- `--commits` allows you to specify 2 releases and see the differences between the releases
- `--pullspecs` show the exact container images that will be used by a release
