# An Introduction to Debugging OKD Release Artifacts
_by [Denis Moiseev](https://github.com/lobziik) and [Michael McCune](https://github.com/elmiko)_

During the course of installing, operating, and maintaining an OKD cluster it is natural for users to come across strange behaviors and failures that are difficult to understand. As Red Hat engineers working on OpenShift, we have many tools at our disposal to research cluster failures and to report our findings to our colleagues. We would like to share some of our experiences, techniques, and tools with the wider OKD community in the hopes of inspiring others to investigate these areas.

As part of our daily activities we spend a significant amount of time investigating bugs, and also failures in our release images and testing systems. As you might imagine, to accomplish this task we use many tools and pieces of _tribal knowledge_ to understand not only the failures themselves, but the complexity of the build and testing infrastructures. As Kubernetes and OpenShift have grown, there has always been an organic growth of tooling and testing that helps to support and drive the development process forward. To fully understand the depths of these processes is to be actively following what is happening with the development cycle. This is not always easy for users who are also focused on delivering high quality service through their clusters.

On 2 September, 2022, we had the opportunity to record a video of ourselves diving into the [OKD release artifacts](https://amd64.origin.releases.ci.openshift.org/) to show how we investigate failures in the continuous integration release pipeline. In this video we walk through the process of finding a failing release test, examining the [Prow console](https://docs.prow.k8s.io/docs/overview/architecture/), and then exploring the results that we find. We explain what these artifacts mean, how to further research failures that are found, and share some other web-based tools that you can use to find similar failures, understand the testing workflow, and ultimately share your findings through a bug report.

<iframe width="560" height="315" src="https://www.youtube.com/embed/4QPc7iOTaWE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

To accompany the video, here are some of the links that we explore and related content:

* [www.okd.io/installation/](https://www.okd.io/installation/) - the main OKD installation page, where our journey begins
* [amd64.origin.releases.ci.openshift.org/](https://amd64.origin.releases.ci.openshift.org/) - OKD releases for AMD64, the place to go for release images and continuous integration reporting
* [docs.prow.k8s.io/docs/overview/architecture/](https://docs.prow.k8s.io/docs/overview/architecture/) - an overview of Prow architecture, this is useful to understand how Prow operates
* [github.com/openshift/release](https://github.com/openshift/release) - OpenShift and OKD’s Prow configuration, go here to find how the jobs are setup
* [github.com/openshift/origin/](https://github.com/openshift/origin/) - conformance tests for OpenShift and OKD, this is where many of the Kubernetes tests are located
* [steps.ci.openshift.org/](https://steps.ci.openshift.org/) - CI step registry, useful for discovering how test jobs flow together
* [search.ci.openshift.org/](https://search.ci.openshift.org/) - CI log search, useful for finding similar test failures
* [docs.ci.openshift.org/docs/](https://docs.ci.openshift.org/docs/) - home of the OpenShift CI docs
* [docs.ci.openshift.org/docs/getting-started/useful-links/](https://docs.ci.openshift.org/docs/getting-started/useful-links/) - useful links to various services, also links to talks and presentations
* [docs.ci.openshift.org/docs/how-tos/artifacts/](https://docs.ci.openshift.org/docs/how-tos/artifacts/) - explanations of CI artifacts
* [issues.redhat.com](https://issues.redhat.com) - OpenShift/OKD bug reporting system

Finally, if you do find bugs or would like report strange behavior in your clusters, remember to visit [issues.redhat.com](https://issues.redhat.com) and use the project **OCPBUGS**.

