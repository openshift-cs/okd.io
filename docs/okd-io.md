# OKD.io

Currently this is the primary landing place for the OKD community, both the end user community and the working group community.

## Technology

OKD.io uses the [Middleman](https://middlemanapp.com){: target=_blank} static site framework.  However, this isn't the easiest technlogy to pick up as a working knowledge of HTML and CSS is needed to create content.  However, the current technology does allow a rich user experience to be created.

When trying to recruit a larget community around a project good documentation is essential, so we need to make the documentation as simple to create as possible to encourage the current community to expend the content currently available.

The site also needs to provide a basic search capability, especially if we increase the amount of content.  Currently a new member joining the community has to do a lot of searching to discover how to work with the community.

### Some technology options

- Use [github](https://github.com/openshift/okd){: target=_blank} as the primary source of information, so simple markdown content cam be added to the repo.  OKD.io would largely remain as the landing page for the community, where a small amount of information would link to getting started resources
- Use an alternate static site technology, where the content can be written without extensive knowledge of HTML and CSS, such as [MkDocs](https://www.mkdocs.org){:target=_blank}, which like GitHub uses a simple markdown syntax for content and allows the look and feel of the content to be customized.  This site is a Proof of Technology uising **MkDocs**, to allow the community to explore the technology and determine if it is a good fit for our needs.

## MkDocs Proof of Technology

MkDocs is a good fit for a documentation site, as it:

- uses standard Markdown for content, but allows extensions to produce better looking content, with features such as syntax highlighting in code, tabs, admonition (information) box, image size and justification
- provides a rich feature set to allow customization of a site and also a [community of site theme producers](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Themes){: target=_blank}.  It also allos individual pages to use a custom theme, so the home page can have a different look and feel.  To demonstrate this I did a rough copy of the existing home page and added it to the proof of technology site
- Provides both site and in-page navigation which is customizable both in terms of depth and also visual layout and structure.
- provides a client-side full site search capability
- provides a live preview when creating content.  Tooling can be installed and run locally or from a container

The Proof of Technology site is hosted on github pages and uses github actions to automatically update the site when new content is pushed to the main branch.  This should be easy to integrate with any automation needed to build and publish the site.

The site also uses cSpell to do a full spell check on the content and a link checker to validate all links contained on the site (except links within code blocks),

## Project landing page

Currently the proof of technology site uses a quick migration of the existing okd.io site honme page.  This isn't meant to be the final content, but just a demonstration of the ability to create a custom landing page.  The current site uses a number of libraries, such as [bootstrap](https://getbootstrap.com){: target=_blank}, which conflicts with the [materials MkDocs theme](https://squidfunk.github.io/mkdocs-material/){: target=_blank} css, so there are some formatting differences.

During the [Docs working group meeting](https://hackmd.io/lPScL-5bQa-utsuRlESf-Q?view#July-27-2021){: target=_blank} where this topic was introduces we looked at a number of open source sites to get an idea of what other projects do:

- [Porter](https://porter.sh){: target=_blank}
- [Helm](https://helm.sh){: target=_blank}

We need to decide what the project landing page should contain and how it should be styled

## MkDocs styling

If MkDocs or a different technology is selected, then we need to decide how the documentation content should look:

- color scheme
- navigation
- additional visual styling, such as font, additional visual sections
- content of header and footer

## Content and content location

Currently there is community content in GitHub issues and discussions, in the Google group forum, on OKD.io (including the Blogs section) and also in the OKD github repository.  There is no clear guidance on where to go to find specific content.

We should have a clear understanding on where we have content and what each location should be used for.  We should separate content to help end users get started and where they can connect with other community members to get asistance if they run into issues.  

The end user content should be distinct from the working group community content.
