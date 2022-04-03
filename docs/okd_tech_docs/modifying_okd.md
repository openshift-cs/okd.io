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

!!!Info
    Unfortunately many of the components have Dockerfiles that use RedHat internal build images from *registry.ci.openshift.org* which requires authorization.  E.g. console-operator uses *registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.17-openshift-4.10* as the builder

!!!Question
    - Are the images in *registry.ci.openshift.org* available publicly?
    - Can this [go-toolset](https://catalog.redhat.com/software/containers/rhel8/go-toolset/5b9c810add19c70b45cbd666){target=_blank} be used instead?
    - Is it possible to replicate a *release build* of an OKD component outside Red Hat CI infrastructure?
        - can a community member discover the build containers/configuration?

!!!Todo
    Work out the easiest steps needed to build the console-operator

    Scenario:

    - Modify console-operator to have a link to the community site **okd.io** instead of **docs.okd.io**
    - add to pre-existing cluster
    - build a custom release to include the modified console-operator, then install a new cluster will custom release

If it is not clear how to build a component you can look in the **release** repository at `https://github.com/openshift/release/tree/master/ci-operator/config/openshift/<operator repo name>`, this is used by the Red Hat build system to build components so can be used to determine how to build a component.

You should also check the repo **README.md** file or any documentation, typically in a **doc** folder, as there may be some repo specific details

!!!Question
    Are there any special repos unique to OKD that need specific mention here, such as machine config?

## Running the modified image on a cluster

An OKD release contain a specific set of images and there are operators that ensure that only the correct set of images are running a cluster, so you need to do some specific actions to be able to run your modified image on a cluster.  You can do this by:

1. running the image on an existing cluster
2. create a new installer containing your image then creating a new cluster with the modified installer

### Running on an existing cluster

The **Cluster Version Operator** watches the deployments and images related to the core OKD services to ensure that only valid images are running in the core.  This prevents you from changing any of the core images.  If you want to replace an image you need to scale the Cluster Version Operator down to 0 replicas:

``` shell
oc scale --replicas=0 deployment/cluster-version-operator -n openshift-cluster-version
```

Some images, such as the **Cluster Cloud Controller Manager Operator** and the **Machine API Operator** need additional steps to be able to make changes, but these typically have a **docs** folder containing additional information about how to make changes to these images.

### Create custom release
