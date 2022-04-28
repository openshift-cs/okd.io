# Making changes to OKD

<!--- cSpell:ignore podman Dockerfiles toolset -->

The source code for OKD is available on [github](https://github.com/openshift){target=_blank}.  OKD is made up of many components bundled into a release.  You can find the exact commit for each component included in a release using the `oc adm release info` command with the `--commit-urls` option, as outlined in the [overview](./index.md#okd-releases) section.

To make a change to OKD you need to:

1. Identify the component(s) that needs to be changed
2. Clone/fork the git repository (you can choose to fork the exact commit used to create the image referenced by the OKD release or a newer version of the source)
3. Make the change
4. Build the image and push to a container registry that the OKD cluster will be able to access
5. Run the modified container on a cluster

## Building images

Most component repositories contain a Dockerfile, so building the image is as simple as `podman build` or `docker build` depending on your container tool of choice.

Some component repositories contain a Makefile, so building the image can be done using the Makefile, typically with `make build`

First thing to do is to replace the `FROM` images in `Dockerfile.rhel7`.  You may want to just copy it to `Dockerfile` and then make the changes. 

```
    FROM registry.ci.openshift.org/openshift/release:golang-1.17 AS builder
```
and
```
    FROM registry.ci.openshift.org/origin/4.10:base
```
Note that these may change as golang and release requirements change.

The original images are unavailable to the public. There is an effort to update the Dockerfiles with publically available images.

    Scenario:

    - Modify console-operator to have a link to the community site **okd.io** instead of **docs.okd.io**
    - add to pre-existing cluster
    - build a custom release to include the modified console-operator, then install a new cluster will custom release

1. Fork the console-operator repository
2. Clone the new fork locally: `git clone https://github.com/<username>/console-operator.git`
3. create new branch from master (or main):  `git switch -c <branch name>`
4. Make needed modifications.  Commit/squash as needed.  Maintainers like to see 1 commit rather than several.
5. Create the image: `podman build -f <Dockerfile file> -t <target repo>/<username>/console-operator:4.11-<some additional identifier>`    
6. Push image to external repository: `podman push  <target repo>/<username>/console-operator:4.11-<some additional identifier>`    
7. Create new release to test with.  This requires the `oc` command to be available.  I use the following script.  It can be modified as needed:
```    
$ cat make_payload.sh
server=https://api.ci.openshift.org

from_release=registry.ci.openshift.org/origin/release:4.11.0-0.okd-2022-04-12-000907
release_name=4.11.0-0.jef-2022-04-12-0
to_image=quay.io/fortinj66/origin-release:v4.11-console-operator

oc adm release new --from-release ${from_release} \
                   --name ${release_name} \
                   --to-image ${to_image} \
                   console-operator=<target repo>/<username>/console-operator:4.11-<some additional identifier>
```

`from_release`, `release_name`, `to_image` will need to be updated as needed  
    
8. Pull installer for cluster release: `oc adm release extract --tools <to_image from above>`  (Make sure image is publically available)

    
!!!Warning
    When working with some Go lang projects you may need to be on Go lang v1.17 or better, as some projects use language features not supported before v1.17, even though some of the project README.md files may specify V1.15, these README files are out of date

If it is not clear how to build a component you can look in the **release** repository at `https://github.com/openshift/release/tree/master/ci-operator/config/openshift/<operator repo name>`, this is used by the Red Hat build system to build components so can be used to determine how to build a component.

You should also check the repo **README.md** file or any documentation, typically in a **doc** folder, as there may be some repo specific details

!!!Question
    Are there any special repos unique to OKD that need specific mention here, such as machine config?

## Running the modified image on a cluster

An OKD release contain a specific set of images and there are operators that ensure that only the correct set of images are running a cluster, so you need to do some specific actions to be able to run your modified image on a cluster.  You can do this by:

1. configuring an existing cluster to run a modified image
2. create a new installer containing your image then creating a new cluster with the modified installer

### Running on an existing cluster

The **Cluster Version Operator** watches the deployments and images related to the core OKD services to ensure that only valid images are running in the core.  This prevents you from changing any of the core images.  If you want to replace an image you need to scale the Cluster Version Operator down to 0 replicas:

``` shell
oc scale --replicas=0 deployment/cluster-version-operator -n openshift-cluster-version
```

Some images, such as the **Cluster Cloud Controller Manager Operator** and the **Machine API Operator** need additional steps to be able to make changes, but these typically have a **docs** folder containing additional information about how to make changes to these images.

### Create custom release
