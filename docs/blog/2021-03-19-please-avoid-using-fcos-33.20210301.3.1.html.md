# Please avoid using FCOS 33.20210301.3.1 for new OKD installs

<!--- cSpell:ignore Vadim -->

Hi,

Due to several issues ([1] and [2]) fresh installations using FCOS
33.20210301.3.1 would fail. The fix is coming in Podman 3.1.0.

Please use an older stable release - 33.20210217.3.0 - as a starting
point instead. See download links at
[https://builds.coreos.fedoraproject.org/browser?stream=stable](https://builds.coreos.fedoraproject.org/browser?stream=stable]) (might
need some scrolling),

Note, that only fresh installs are affected. Also, you won't be left
with outdated packages, as OKD does update themselves to latest stable
FCOS content during installation/update.

1. [https://bugzilla.redhat.com/show_bug.cgi?id=1936927](https://bugzilla.redhat.com/show_bug.cgi?id=1936927)
2. [https://github.com/openshift/okd/issues/566](https://github.com/openshift/okd/issues/566)

--
Cheers,
Vadim
