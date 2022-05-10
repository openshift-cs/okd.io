# Operator Hub Catalogs

<!--- cSpell:ignore Devworkspace devspaces -->

!!!Warning
    This section is under construction
    
OKD contains many operators which deliver the base platform, however there is also additional capabilities delivered as operators available via the Operator Hub.

The operator hub story for OKD isn't ideal currently (as at OKD 4.10) as OKD shares source with OpenShift, the commercial sibling to OKD.  OpenShift has additional operator hub catalogs provided by Red Hat, which deliver additional capabilities as part of the supported OpenShift product. These additional capabilities are not currently provided to OKD.

OpenShift and OKD share a community catalog of operators, which are a subset of the operators available in the [OperatorHub](https://operatorhub.io){target=_blank}.  The operators in the community catalog should run on OKD/OpenShift and will include any additional configuration, such as security context configuration.

However, where an operator in the community catalog has a dependency that Red Hat supports and delivers as part of the additional OpenShift operator catalog, then the community catalog operator will specify the dependency from the supported OpenShift catalog.  This results in missing dependency errors when attempting to install on OKD.

!!!Question
    - will the proposed OKD catalog solve all the dependency issues in the community catalog?
    - what is the timeline for the OKD catalog?

!!!Todo
    Some useful repo links - do we need to create instructions for specific operators?

    - Community operator source
        - [docs](https://redhat-openshift-ecosystem.github.io/community-operators-prod/)
        - [repo](https://github.com/redhat-openshift-ecosystem/community-operators-prod)
    - OKD operators : [repo](https://github.com/redhat-openshift-ecosystem/okd-operators)
    - Marketplace operator : [repo](https://github.com/operator-framework/operator-marketplace)
    - Devworkspace operator : [repo](https://github.com/devfile/devworkspace-operator)
    - GitOps operator : [repo](https://github.com/redhat-developer/gitops-operator)
    - devspaces (crw) : [public repo](https://github.com/redhat-developer/devspaces)
