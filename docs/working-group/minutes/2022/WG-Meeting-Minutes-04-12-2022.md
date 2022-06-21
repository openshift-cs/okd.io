# OKD Working Group Meeting Notes

## April 12, 2022

### Attendees:

* Jaime Magiera  - University of Michigan
* Brian Innes - IBM
* Larry Brigman - CommScope
* Michael elmiko McCune - Red Hat
* Timothée Ravier - Red Hat
* Mohammad Reza Ostadi
* Daniel Axelrod - Datto
* Sri Ramanujam
* Bruce Link - BCIT
* Neal Gompa - Datto
* Christian Glombek - Red Hat

### Agenda

* Agenda Review
* OKD Release updates (Christian)
    * https://github.com/systemd/systemd/pull/22868 (rejected, new try WIP)
    * https://github.com/openshift/installer/pull/5788 (Installer fix for bootstrap api-int issue)
* FCOS updates (Timothée)
    * Fedora 36 test day/week:
        * https://github.com/coreos/fedora-coreos-tracker/issues/1147
        * https://github.com/coreos/fedora-coreos-tracker/issues/1123
        * https://github.com/coreos/fedora-coreos-tracker/issues/1101
    * Removing libvarlink-utils from FCOS:
        * https://github.com/coreos/fedora-coreos-tracker/issues/1130
    * Update hardware version in VMware OVA after 6.5/6.7 EOL date:
        * https://github.com/coreos/fedora-coreos-tracker/issues/1141
        * https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-vmware/#_modifying_ovf_metadata
    * VirtualBox images coming soon!
        * https://github.com/coreos/fedora-coreos-tracker/issues/1008
* Docs updates (Brian, Jaime)
    * Systems and Contributors guides
        * https://binnes.github.io/okd-io/okd_tech_docs/
    * Meeting minutes going into the website
    * Website styling
        * http://luminouscoder.com/okd.io/public
    * Automated testing
        * Example: https://github.com/JaimeMagiera/oct
    * Troubleshooting
        * https://github.com/kxr/o-must-gather
        * https://github.com/elmiko/okd-camgi
          * https://github.com/elmiko/camgi.rs (rust rewrite)
        * https://github.com/rvanderp3/release-devenv
* Issues
    * Ceph/Rook issues with FCOS 35 release in OKD 4.10 (https://github.com/openshift/okd/issues/1160)
    * [NetworkPolicy - deny-all policy does not correctly restrict traffic to pod when using nodeports ](https://github.com/openshift/okd/issues/1175)
* Discussions
* New Business
    * CRC
    * Survey
    * Vote for subcommittee co-chairs
* Tasks
    * Jaime - get 4.10 and 4.11 update info (ongoing)
    * Charro Gruver - gather OKD download stats from dl.fedoraproject.org or delegate
    * Daniel - Write up guides format into README in guides directory and then file tickets against people who have agreed to update them
    * Ceate troubleshooting dicsussion thread (Brian)
