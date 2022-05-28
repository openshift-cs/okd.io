# OKD Working Group Meeting Notes
## May 24, 2022

### Attendees:

* Jaime Magiera (University of Michigan)
* Bruce Link (BCIT)
* Timothée Ravier (Red Hat)
* Neal Gompa (Datto)
* Diane Mueller (Red Hat)
* Michael elmiko McCune (Red Hat)
* Jack Henschel (CERN)
* Erik Berg (UiO)

### Agenda

* Agenda Review
* OKD Release updates (Christian)
    * Question: Operator count? There was a change, we don't know the details
* FCOS updates (Timothée)
    * [Ignition config accessible to unprivileged software on VMware](https://lists.fedoraproject.org/archives/list/coreos-status@lists.fedoraproject.org/thread/M3EQHFIF2XXTZRVDDWHBZW3OHIHHP2GC/)
    * [Format change for Nutanix artifact](https://lists.fedoraproject.org/archives/list/coreos-status@lists.fedoraproject.org/thread/SZAD4FBCJFHDV3SSOLOXR4RUXRWGJN56/)
    * [coreos autoinstall creates huge number of xfs allocation groups](https://github.com/coreos/fedora-coreos-tracker/issues/1183)
        *  https://docs.okd.io/latest/installing/installing_bare_metal/installing-bare-metal.html#installation-user-infra-machines-advanced_disk_installing-bare-metal
* Docs updates (Brian, Jaime)
* Issues
    * [Plan for repository transition](https://github.com/openshift/okd/discussions/1206) is being formulated. Please provide feedback.
    * Survey
        * Dhriti forwarded [link to survey](https://docs.google.com/forms/d/1Ez-pamXYBt7GazAT2Nb8xlNjgTYJnjc_vWbiVHxCNx8/edit?ts=626a651a)
        * Need feedback
    * Rook/Ceph status
        * Fix applied upstream, waiting for it to make its way down to us
        * John's Bugzilla https://bugzilla.redhat.com/show_bug.cgi?id=2063929 still open
* Discussions
    * Discussion 1231
* Project Updates
    * CRC
        * New name
        * see https://www.youtube.com/watch?v=M_kjqMD6JlU at 9:51 in they talk about rebranding code ready workspaces to open shift dev spaces, and at 12:47 they talk about rebranding CEC to Openshift local.  (This is dated April 8, 2022)
    * Operate First/Mass Open Cloud 
        * Community managed CI/CD for OKD conversation(s) on the Boston University Cloud (MassOpenCloud)
    * CERN OKD on OpenStack 
        * invitation to speak to working group on their DIY OKD build process (June 7) & in Dublin at Gathering (June 23?)
        * Jack Henschel (CERN)
* Tasks
    * Jaime - get 4.10 and 4.11 update info (ongoing)
    * Charro Gruver - gather OKD download stats from dl.fedoraproject.org or delegate
    * Daniel - Write up guides format into README in guides directory and then file tickets against people who have agreed to update them
    * ~~Create troubleshooting dicsussion thread (Brian)~~ - https://github.com/openshift/okd/discussions/1198 
    * Find out about serial output for installs
        * manually editing `/var/lib/containers/storage/volumes/ironic/_data/html/*.conf` on the bootstrap node
        * https://docs.fedoraproject.org/en-US/fedora-coreos/emergency-shell/
        * https://docs.openshift.com/container-platform/4.10/installing/install_config/installing-customizing.html#installation-special-config-kargs_installing-customizing
        * or directly with `kernelArguments` for first boot: https://github.com/coreos/ignition/blob/main/docs/configuration-v3_3.md
    * find out about bare metal IPI install provding RHCOS nodes
    * Find out about DNS changes to support mx (Jaime and Diane)
