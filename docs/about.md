# About OKD

OKD is the community distribution of Kubernetes optimized for continuous application development and multi-tenant deployment. OKD adds developer and operations-centric tools on top of Kubernetes to enable rapid application development, easy deployment and scaling, and long-term lifecycle maintenance for small and large teams. OKD is also referred to as Origin in GitHub and in the documentation. OKD makes launching Kubernetes on any cloud or bare metal a snap, simplifies running and updating clusters, and provides all of the tools to make your containerized-applications succeed.

## Features

- A fully automated distribution of Kubernetes on all major clouds and bare metal, OpenStack, and other virtualization providers
- Easily build applications with integrated service discovery and persistent storage.
- Quickly and easily scale applications to handle periods of increased demand.
- Support for automatic high availability, load balancing, health checking, and failover.
- Access to the Operator Hub for extending Kubernetes with new, automated lifecycle capabilities
- Developer centric tooling and console for building containerized applications on Kubernetes
- Push source code to your Git repository and automatically deploy containerized applications.
- Web console and command-line client for building and monitoring applications.
- Centralized administration and management of an entire stack, team, or organization.
- Create reusable templates for components of your system, and iteratively deploy them over time.
- Roll out modifications to software stacks to your entire organization in a controlled fashion.
- Integration with your existing authentication mechanisms, including LDAP, Active Directory, and public OAuth providers such as GitHub.
- Multi-tenancy support, including team and user isolation of containers, builds, and network communication.
- Allow developers to run containers securely with fine-grained controls in production.
- Limit, track, and manage the developers and teams on the platform.
- Integrated container image registry, automatic edge load balancing, and full spectrum monitoring with Prometheus.

## What can I run on OKD?

OKD is designed to run any Kubernetes workload. It also assists in building and developing containerized applications through the developer console.

For an easier experience running your source code, [Source-to-Image (S2I)](https://github.com/openshift/source-to-image){: target=_blank} allows developers to simply provide an application source repository containing code to build and run.  It works by combining an existing S2I-enabled container image with application source to produce a new runnable image for your application.

You can see the [full list of Source-to-Image builder images](https://github.com/openshift/library/tree/master/official){: target=_blank} and it's straightforward to [create your own](https://blog.openshift.com/create-s2i-builder-image/){: target=_blank}.  Some of our available images include:

- [Ruby](https://github.com/sclorg/s2i-ruby-container){: target=_blank}
- [Python](https://github.com/sclorg/s2i-python-container){: target=_blank}
- [Node.js](https://github.com/sclorg/s2i-nodejs-container){: target=_blank}
- [PHP](https://github.com/sclorg/s2i-php-container){: target=_blank}
- [Perl](https://github.com/sclorg/s2i-perl-container){: target=_blank}
- [WildFly](https://github.com/openshift-s2i/s2i-wildfly){: target=_blank}
- [MySQL](https://github.com/sclorg/mysql-container){: target=_blank}
- [MongoDB](https://github.com/sclorg/mongodb-container){: target=_blank}
- [PostgreSQL](https://github.com/sclorg/postgresql-container){: target=_blank}
- [MariaDB](https://github.com/sclorg/mariadb-container){: target=_blank}

## What sorts of security controls does OpenShift provide for containers?

OKD runs with the following security policy by default:

- Containers run as a non-root unique user that is separate from other system users
    - They cannot access host resources, run privileged, or become root
    - They are given CPU and memory limits defined by the system administrator
    - Any persistent storage they access will be under a unique SELinux label, which prevents others from seeing their content
    - These settings are per project, so containers in different projects cannot see each other by default
- Regular users can run Docker, source, and custom builds
    - By default, Docker builds can (and often do) run as root. You can control who can create Docker builds through the `builds/docker` and `builds/custom` policy resource.
- Regular users and project admins cannot change their security quotas.

Many containers expect to run as root (and therefore edit all the contents of the filesystem). The [Image Author's guide](https://docs.okd.io/latest/openshift_images/create-images.html#images-create-guide-openshift_create-images){: target=_blank} gives recommendations on making your image more secure by default:

- Don't run as root
- Make directories you want to write to group-writable and owned by group id 0
- Set the net-bind capability on your executables if they need to bind to ports < 1024

If you are running your own cluster and want to run a container as root, you can grant that permission to the containers in your current project with the following command:

```shell
# Gives the default service account in the current project access to run as UID 0 (root)
oc adm add-scc-to-user anyuid -z default
```

See the [security documentation](https://docs.okd.io/latest/authentication/managing-security-context-constraints.html){: target=_blank} more on confining applications.
