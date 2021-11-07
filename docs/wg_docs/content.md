## Site content maintainability

<!--- cSpell:ignore linenums -->

The site has adopted Markdown as the standard way to create content for the site.  Previously the site used an HTML based framework, which resulted in content not being frequently updated as there was a steep learning curve.

All content on the site should be created using Markdown.  To ensure content is maintainable going forward only markdown features outlined below should be used to create site content.  If you wish to use additional components on a page then please contact the documentation working group to discuss your requirements before creating a pull request containing additional components.

MkDocs includes the ability to create custom page templates.  This facility has been used to create a customized home page for the site.  If any other pages require a custom layout or custom features, then a page template should be used so the content can remain in Markdown.  Creation of custom page templates should be discussed with the documentation working group.

## Changing content

MkDocs supports standard Markdown syntax and a set Markdown extensions provided by plugins.  The exact Markdown syntax supported is based on the [python implementation](https://python-markdown.github.io).

MkDocs is configured using the **mkdocs.yml** file in the root of the git repository.

The **mkdoc.yml** file defines the top level navigation for the site.  The level of indentation is configurable (this requires the theme to support this feature) with Markdown headings, levels 2 (`##`) and 3 (`###`) being used for the in-page navigation on the right of the page.

### Standard Markdown features

The following markdown syntax is used within the documentation

| Syntax | Result
|--------|-----------
|`# Title` | heading - you can create up to 6 levels of headings by adding additional `#` characters, so `###` is a level 3 heading
|`**text**` | will display the word ```text``` in **bold**
|`*text*` | will display the word ```text``` in *italic*
| `` `code` `` | inline code block
| ```` ```shell ... ``` ````| multi-line (Fenced) code block
| `1. list item` | ordered list
| `- unordered list item` | unordered list
| `---` | horizontal break

HTML can be embedded in Markdown, but embedded HTML should not be used in the documentation.  All content should use Markdown with the permitted extensions.

### Indentation

MkDocs uses 4 spaces for tabs, so when indenting code ensure you are working with tabs set to 4 spaces rather than 2, which is commonly used.

When using some features of Markdown indentation is used to identify blocks.

```md
1. Ubiquity EdgeRouter ER-X
    - runs DHCP (embedded), custom DNS server via AdGuard

    ![pic](./img/erx.jpg){width=80%}
```

In the code block above you will see the unordered list item is indented, so it aligns with the content of the ordered list (rather than aligning with the number of the ordered list).  The image is also indented so it too aligns with the ordered list text.

Many of the Markdown elements can be nested and indentation is used to define the nesting relationship.  If you look down on this page at the [Information boxes](#information-boxes) section, the example shows an example of nesting elements and the Markdown tab shows how indentation is being used to identify the nesting relationships.

### Links within MkDocs generated content

MkDocs will warn of any internal broken links, so it is important that links within the documentation are recognized as internal links.

- a link starting with a protocol name, such as http or https, is an external link
- a link starting with `/` is an external link.  This is because MkDocs generated content can be embedded into another web application, so links can point outside of the MkDocs generated site but hosted on the same website
- a link starting with a file name (including the .md extension) or relative directory (../directory/filename.md) is an internal link and will be verified by MkDocs

!!!Information
    Internal links should be to the Markdown file (with .md extension).  When the site is generated the filename will be automatically converted to the correct URL

As part of the build process a linkchecker application will check the generated html site for any broken links.  You can run this linkchecker locally using the instructions.  If any links in the documentation should be excluded from the link checker, such as links to localhost, then they should be added as a regex to the linkcheckerrc file, located in the root folder of the project - see [linkchecker documentation](https://linkchecker.github.io/linkchecker/index.html) for additional information

## Markdown Extensions used in OKD.io

There are a number of Markdown extensions being used to create the site.  See the mkdocs.yml file to see which extensions are configured.  The documentation for the extensions can be found [here](https://python-markdown.github.io/extensions/)

### Link configuration

Links on the page or embedded images can be annotated to control the links and also the appearance of the links:

#### Image

Images are embedded in a page using the standard Markdown syntax `![description](URL)`, but the image can be formatted with [Attribute Lists](https://python-markdown.github.io/extensions/attr_list/){: target="_blank" .external }.  This is most commonly used to scale an image or center an image, e.g.

```md
![GitHub repo url](images/github-repo-url.png){style="width: 80%" .center }
```

#### External Links

External links can also use attribute lists to control behaviors, such as open in new tab or add a css class attribute to the generated HTML, such as **external** in the example below:

```md
[MkDocs](http://mkdocs.org){: target="_blank" .external }
```

!!!info
    You can embed an image as the description of a link to create clickable images that launch to another site: `[![Image description](Image URL)](target URL "hover text"){: target=_blank}`

#### YouTube videos

It is not possible to embed a YouTube video and have it play in place using pure markdown.  You can use HTML within the markdown file to embed a video:

```html
<iframe width="100%" height="500" src="https://www.youtube.com/watch?v=qh1zYW7BLxE&t=431s" title="Building an OKD 4 Home Lab with special guest Craig Robinson" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

### Tabs

Content can be organized into a set of horizontal tabs.

```md
=== "Tab 1"
    Hello

=== "Tab 2"
    World
```

produces :

=== "Tab 1"
    Hello

=== "Tab 2"
    World

### Information boxes

The [Admonition](https://python-markdown.github.io/extensions/admonition/){: target="_blank" .external } extension allows you to add themed information boxes using the `!!!` and `???` syntax:

```md
!!! note
    This is a note
```

produces:

!!! note
    This is a note

and

```text
??? note
    This is a collapsible note

    You can add a `+` character to force the box to be initially open `???+`
```

produces a collapsible box:

??? note
    This is a collapsible note

    You can add a `+` character to force the box to be initially open `???+`

You can override the title of the box by providing a title after the Admonition type.

!!!Example
    You can also nest different components as required

    === "note"
        !!!note
            This is a note

    === "collapsible note"
        ???+note
            This is a note

    === "custom title note"
        !!!note "Sample Title"
            This is a note

    === "Markdown"
        ```md
        !!!Example
            You can also nest different components as required

            === "note"
                !!!note
                    This is a note

            === "collapsible note"
                ???+note
                    This is a note

            === "custom title note"
                !!!note "Sample Title"
                    This is a note
        ```

#### Supported Admonition Classes

The Admonitions supported by the Material theme are :

!!! note
    This is a note

!!! abstract
    This is an abstract

!!! info
    This is an info

!!! tip
    This is a tip

!!! success
    This is a success

!!! question
    This is a question

!!! warning
    This is a warning

!!! failure
    This is a failure

!!! danger
    This is a danger

!!! bug
    This is a bug

!!! example
    This is an example

!!! quote
    This is a quote

### Code blocks

Code blocks allow you to insert code or blocks of text in line or as a block.

To use inline you simply enclose the text using a single back quote **\`** character. So a command can be included using **\`oc get pods\`** and will create `oc get pods`

When you want to include a block of code you use a *fence*, which is 3 back quote character at the start and end of the block.  After the opening quotes you should also specify the content type contained in the block.

````text
```shell
oc get pods
```
````

which will produce:

``` shell
oc get pods
```

Notice that the block automatically gets the *copy to clipboard* link to allow easy copy and paste.

Every code block needs to identify the content.  Where there is no content type, then **text** should be used to identify the content as plain text.  Some of the common content types are shown in the table below.  However, a full link of supported content types can be found [here](https://pygments.org/docs/lexers/){: target="_blank"}, where the short name in the documentation should be used.

| type | Content
|------|--------
| **shell** | Shell script content
| **powershell** | Windows Power Shell content
| **bat** | Windows batch file (.bat or .cmd files)
| **json** | JSON content
| **yaml** | YAML content
| **markdown** or **md** | Markdown content
| **java** | Java programming language
| **javascript** or **js** | JavaScript programming language
| **typescript** or **ts** | TypeScript programming language
| **text** | Plain text content

#### Advanced highlighting of code blocks

There are some additional features available due to the highlight plugin installed in MkDocs.  Full details can be found in the [MkDocs Materials documentation](https://squidfunk.github.io/mkdocs-material/reference/code-blocks/){: target=_blank}.

#### Line numbers

You can add line numbers to a code block with the **linenums** directive.  You must specify the starting line number, 1 in the example below:

```` md
``` javascript linenums="1"
<script>
document.getElementById("demo").innerHTML = "My First JavaScript";
</script>
```
````

creates

``` javascript linenums="1"
<script>
document.getElementById("demo").innerHTML = "My First JavaScript";
</script>
```

!!!Info
    The line numbers do not get included when the copy to clipboard link is selected

## Spell checking

This project uses [cSpell](https://github.com/streetsidesoftware/cspell){: target=_blank} to check spelling within the markdown.  The configuration included in the project automatically excludes content in a code block, enclosed in triple back quotes \`\`\`.

The configuration file also specifies that US English is the language used in the documentation, so only US English spellings should be used for words where alternate international English spellings exist.

You can add words to be considered valid either within a markdown document or within the cspell configuration file, **cspell.json**, in the root folder of the documentation repository.

Words defined within a page only apply to that page, but words added to the configuration file apply to the entire project.

### Adding local words

You can add a list of words to be considered valid for spell checking purposes as a comment in a Markdown file.

The comment has a specific format to be picked up by the cSpell tool:

```<!--- cSpell:ignore linkchecker linkcheckerrc mkdocs mkdoc -->```

here the words *linkchecker*, *linkcheckerrc*, *mkdocs* and *mkdoc* are specified as words to be accepted by the spell checker within the file containing the comment.

### Adding global words

The cSpell configuration file **cspell.json** contains a list of words that should always be considered valid when spell checking.  The list of words applies to all files being checked.