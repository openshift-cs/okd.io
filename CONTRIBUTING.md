# Contributing

If you wish to contribute to this repository please follow the guidelines below.

## Forking this repository

The first thing you need to do is to [fork this repository](https://github.com/openshift/openshift.org#fork-destination-box) into your own github account.

Then, clone it into your local machine:

```bash
$ git clone git@github.com:your-username/openshift.org
```

And add the `upstream` remote to follow this repository's changes:

```bash
$ git remote add upstream git@github.com:openshift/openshift.org
$ git fetch upstream
$ git rebase upstream/master
```


## Submiting a Pull Request

After you've done your changes and tested them, you're ready to submit a Pull Request.

First, create a local branch on your local machine:

```bash
$ git checkout -b my-feature-branch
```

Then, add, commit, and push your changes:

```bash
$ git add .
$ git commit
$ git push origin my-feature-branch
```

Finally, submit a [submit a Pull Request](https://github.com/openshift/openshift.org/compare)
