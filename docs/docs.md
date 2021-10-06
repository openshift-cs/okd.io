# Documentation

<!--- cSpell:ignore mburke dmueller -->

There are 2 primary sources of information for OKD:  

- community documentation - [https://okd.io](https://okd.io){: target=blank} (this site)
- product documentation - [https://docs.okd.io](https://docs.okd.io/latest/welcome/index.html){: target=blank}

## Updates and Issues

If you encounter an issue with the documentation or have an idea to improve the content or add new content then please follow the directions below to learn how you can get changes made.

The source for the documentation is managed in github.  There are different processes for requesting changes in the community and product documentation:

### Community documentation

The [OKD Documentation subgroup](wg_docs/overview.md){: target=_blank} is responsible for the community documentation.  The process for making changes is set out in the [working group section of the documentation](wg_docs/okd-io.md){: target=_blank}

### Product documentation

The OKD docs are built off the [openshift/openshift-docs](https://github.com/openshift/openshift-docs/){: target=_blank} repo. If you notice any problems in the OKD docs that need to be addressed, you can either create a pull request with those changes against the [openshift/openshift-docs](https://github.com/openshift/openshift-docs/){: target=_blank} repo or [create an issue](https://github.com/openshift/openshift-docs/issues/new){: target=_blank} to suggest the changes.

Among the changes you could suggest are:

- errors
- typos
- missing information
- incorrect product name (OpenShift Container Platform instead of OKD)
- Incorrect operating system (RHEL or RHCOS instead of FCOS)
- incorrect code examples

If you create an issue, please do the following:

- Add [OKD] to the title of the issue.
- Provide as much information as possible, including the problem, the exact location in the file, the versions of OKD that the error affects (if known), and the correction you would like to see. A link to the file with the problem is extremely helpful.
- If you have the appropriate permissions, assign the issue to Michael Burke (mburke5678) and Diane Mueller (dmueller2001) so that the issue gets our direct attention.  You can assign an issue by including the following in the issue description:
    ```text
    /assign @mburke5678
    /assign @dmueller2001
    ```
    If not, you can @ mention mburke5678 in a comment.
- If you have the permissions, add a `kind/documentation` label.
