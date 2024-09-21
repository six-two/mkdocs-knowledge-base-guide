# MkDocs Knowledge Base Guide

This guide aims to show you how to publish your knowledge base with MkDocs.
It mainly describes my setup, so it focuses on extensions I personally use or created for my knowledge base.

You can read the guide at <https://mkdocs-knowledge-base-guide.six-two.dev/> or you can clone this repository and serve it with mkdocs.

## MkDocs advantages

- Actively developed
- Creates a static site that can be hosted anywhere cheaply (or even for free)
- Has a fully client side search function
- Has really great Material theme and many other plugins
- Writing small custom extensions is relativly easy, since it can be done in Python.
    The [hooks](https://www.mkdocs.org/user-guide/configuration/#hooks) option also enables writing custom hooks without creating all the boilerplate code that a "propper" extension needs.

## MkDocs Drawbacks

MkDocs processes all sites sequentially.
This can lead to slow build performace, which makes the live reloading nearly unusable in my opinion.
For my personal knowlege base, which contains over 700 pages with over 39k lines in total and uses many plugins, the build process takes around 40 seconds on a M3 Macbook.
In the CI/CD pipeline, the build takes much longer.
