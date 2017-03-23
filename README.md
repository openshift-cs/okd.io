# OpenShift.org

[![Build Status](https://travis-ci.org/openshift/openshift.org.svg?branch=master)](https://travis-ci.org/openshift/openshift.org)

This repo contains the sources for the [OpenShift.org](https://www.openshift.org/).

## Development

**Note** [`Node.js` is a required dependency](http://stackoverflow.com/a/6283074/6758654) on Linux machines

Firstly install the necessary packages on your machine:

    bundle install

To develop on your local machine run the middleman server and you
should be able to preview your changes at http://localhost:4567

    bundle exec middleman server

## Deployment

To deploy your changes to http://openshift.org/ you need to have your
ssh key set up with the current Openshift app (or be on osdevelopers), and then execute:

    bundle exec middleman deploy

This makes sure that `middleman build` is also executed and **all the current** changes on the folder will be deployed (including uncommitted ones).

Make sure to populate the `OPENSHIFT_GITHUB_ID` and `OPENSHIFT_GITHUB_SECRET` env variables to ensure authenticated GitHub API usage (and prevent request throttling).
