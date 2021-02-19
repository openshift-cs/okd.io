---
title: OKD upgrade from v4.5 to v4.6
date: 2021-02-18
tags: upgrade
---

Some upgrades from OKD 4 to a newer version require fixes to work. This article describes them.

## Versions and required fixes
| OKD Version   | Initial FCOS Version  | Mirror Fix needed  | Repo Disable Fix needed |
| -------------                 |:-------------:                    |:-:|:-:|
| 4.5.0-0.okd-2020-10-15-235428 | 32.20200629.3                     |   |   |
| 4.6.0-0.okd-2020-11-27-200126 | 32.20200629.3                     | x |   |
| 4.6.0-0.okd-2020-12-12-135354 | 33.20201124.10 -> 33.20201209.10  | x |   |
| 4.6.0-0.okd-2021-01-17-185703 | 33.20201209.10 -> 33.20201214.3   | x |   |
| 4.6.0-0.okd-2021-01-23-132511 | 33.20201214.3 -> 33.20210104.3    | x | x |
| 4.6.0-0.okd-2021-02-14-205305 | to 33.20210117.3.2                |   | x |

<br>

## "Image Mirror" Fix 

Use the scripts from >[here](https://github.com/jomeier/okd4-image-mirror-fix)< to fix the broken images from quay.io/openshift/okd-content.

## "Repo Disable" Fix
Disable all repositories on each OKD node:

```bash
sudo grep enabled=1 /etc/yum.repos.d/*
sudo find /etc/yum.repos.d/ -type f -exec sudo sed -i 's/enabled=1/enabled=0/g' {} +
sudo grep enabled=1 /etc/yum.repos.d/*
```
