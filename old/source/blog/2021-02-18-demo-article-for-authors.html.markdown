---
title: Demo blog article for authors
date: 2021-02-18
tags: demo
---

# This is a demo article

See [this file in the okd.io Github repository](https://raw.githubusercontent.com/openshift-cs/okd.io/master/source/blog/2021-02-18-demo-article-for-authors.html.markdown) if you want to learn how this article was written with Github markdown syntax.

## Here's a table
| OKD Version   | Initial FCOS Version  | Mirror Fix needed  | Repo Disable Fix needed |
| -------------                 |:-------------:                    |:-:|:-:|
| 4.5.0-0.okd-2020-10-15-235428 | 32.20200629.3                     |   |   |
| 4.6.0-0.okd-2020-11-27-200126 | 32.20200629.3                     | x |   |
| 4.6.0-0.okd-2020-12-12-135354 | 33.20201124.10 -> 33.20201209.10  | x |   |

<br>

## Links

Use the scripts from [this repository](https://github.com/jomeier/okd4-image-mirror-fix) to fix the broken images from quay.io/openshift/okd-content.

## Code snippets
Disable all repositories on each OKD node:

```bash
sudo grep enabled=1 /etc/yum.repos.d/*
sudo find /etc/yum.repos.d/ -type f -exec sudo sed -i 's/enabled=1/enabled=0/g' {} +
sudo grep enabled=1 /etc/yum.repos.d/*
```

## Images
<img src="/blog/2021/02/18/demo-article-for-authors/metrics.png" width="200" /> <br>
<img src="/blog/2021/02/18/demo-article-for-authors/metrics.png" width="200" />
<img src="/blog/2021/02/18/demo-article-for-authors/metrics.png" width="200" />
