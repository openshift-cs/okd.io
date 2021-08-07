# OKD.io

This repo contains the sources for the [OKD.io](https://www.okd.io/).

## Development

**Note** [`Node.js` is a required dependency](http://stackoverflow.com/a/6283074/6758654) on Linux machines

Firstly install the necessary packages on your machine:

```
sudo apt-get install ruby-full
sudo gem install bundler
sudo bundle install
```

To develop on your local machine run the middleman server and you
should be able to preview your changes at http://localhost:4567

```
bundle exec middleman server
```

### Developing with a local container

To test a local version of the site using a containerized builder/server, please
see the [local containerized server instructions](https://github.com/openshift-cs/okd.io/blob/master/hack/local-container-server/readme.md).

## Create Blog article

Create a file in the directory **source/blog**. 

The filename must be in the format: **yyyy-mm-dd-\<title\>.html.markdown**

The first lines of the file must contain this:
```
---
title: <TITLE>
date: yyyy-mm-dd (exactly the same date as for the filename!)
tags: upgrade (choose tags to categorize articles)
---

< MARKDOWN :-) >
```

## Deployment

To deploy your changes please submit a pull request while following [our contribution guidelines](./CONTRIBUTING.md)

Make sure to populate the `OPENSHIFT_GITHUB_ID` and `OPENSHIFT_GITHUB_SECRET` env variables to ensure authenticated GitHub API usage (and prevent request throttling).
