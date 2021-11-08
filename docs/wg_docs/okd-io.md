# Contributing to okd.io

The source for **okd.io** is in a [github repository](https://github.com/openshift-cs/okd.io/){: target=_blank}.

The site is created using [MkDocs](https://www.mkdocs.org){: target=_blank}. which takes Markdown documents and turns them into a static website that can be accessed from a filesystem or served from a web server.

To update or add new content to the site you need to

- fork the repository in your own github account
    - it important to leave the repo name as **okd.io** in your github account if you want to use Che/CodeReady Containers to modify the content
- make the changes in your local repository
- create a pull request to deliver the updates to the primary repository.

The site is created using [MkDocs](http://mkdocs.org){: target="_blank" .external } with the [Materials theme](https://squidfunk.github.io/mkdocs-material/){: target="_blank" .external } theme.

## Updating the site

To make changes to the site.  Create a pull request to deliver the changes in your fork of the repo to the main branch of the **okd.io** repo.  Before creating a pull request you should run the build script and verify there are no spelling mistakes or broken links.  Details on how to do this can be found at the end of the instructions for [setting up a documentation environment](doc-env.md)

Github automation is used to generate the site then publish to github pages, which serves the site.  If your changes contain spelling issues or broken links, then the automation will fail and the github pages site will not be updated, so please do a local test using the **build.sh** script before creating the pull request.
