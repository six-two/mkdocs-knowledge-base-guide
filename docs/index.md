# Introduction

This guide aims to show you how to publish your knowledge base with ProperDocs (actively maintained fork of MkDocs).
It mainly describes my setup, so it focuses on extensions I personally use or created for my knowledge base.

You can read the guide at <https://mkdocs-knowledge-base-guide.six-two.dev/> or you can clone this repository and serve it with ProperDocs.

## ProperDocs advantages

- Creates a static site that can be hosted anywhere cheaply (or even for free)
- Has a fully client side search function
- Has really great Material theme and many other plugins
- Writing small custom extensions is relatively easy, since it can be done in Python.
    The [hooks](https://properdocs.org/user-guide/configuration/#hooks) option also enables writing custom hooks without creating all the boilerplate code that a "proper" extension needs.

## ProperDocs Drawbacks

ProperDocs processes all sites sequentially.
This can lead to slow build performance, which makes the live reloading for large sites nearly unusable in my opinion.
For my personal knowledge base, which contains over 700 pages with over 39k lines in total and uses many plugins, the build process takes around 40 seconds on a M3 Macbook.
In the CI/CD pipeline, the build takes much longer.

## Notes on MkDocs and Material for MkDocs

There have been [some events](https://fpgmaas.com/blog/collapse-of-mkdocs/) in the MkDocs space which left the MkDocs and Material for MkDocs projects without maintenance.
Luckily both are open source software, so there are forks of both projects that as of May 2026 are under active development.
I recommend you switch to them at:

- [ProperDocs](https://github.com/ProperDocs/properdocs) can be used to replace [MkDocs](https://github.com/mkdocs/mkdocs)
- MaterialX can be used to replace Material for Mkdocs

Both are drop-in replacements.
All you need to do is replace the packages `mkdocs-material` and `mkdocs` in your `requirements.in` with `mkdocs-materialx` and `properdocs` and run `pip-compile -U`.
Then in your `mkdocs.yml` change the theme from `name: material` to `materialx`.
Optionally, but recommended: Rename your `mkdocs.yml` to `properdocs.yml` and replace all invocations of `mkdocs serve` and `mkdocs build` with `properdocs serve` and `properdocs build`.
Also recommended: Pin `mkdocs<=1.6.1` in case future updates to it (mkdocs 2.0, which will break all plugins) ever go live.
