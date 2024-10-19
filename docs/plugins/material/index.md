# Material for MkDocs

L|Homepage|https://squidfunk.github.io/mkdocs-material/|
I|pypi|mkdocs-material|
I|github|squidfunk/mkdocs-material|

@TODO

The [setup](https://squidfunk.github.io/mkdocs-material/setup/) and [reference section](https://squidfunk.github.io/mkdocs-material/reference/) on the website explains how to use many of the featured offered by the plugin.
It is recommended to at least skim them for any cool features you want to use.

My usual minimum configuration in `mkdocs.yml` looks like this:

```yml
markdown_extensions:
  - pymdownx.highlight:
      anchor_linenums: true
      line_spans: __span
      pygments_lang_class: true
  - pymdownx.inlinehilite
  - pymdownx.snippets
  - pymdownx.superfences

theme:
    name: material
    features:
        - navigation.tabs
        - content.code.copy
    
    palette:
        # Palette toggle for light mode
        - media: "(prefers-color-scheme: light)"
          scheme: default
          toggle:
            icon: material/brightness-7
            name: Switch to dark mode

        # Palette toggle for dark mode
        - media: "(prefers-color-scheme: dark)"
          scheme: slate
          toggle:
            icon: material/brightness-4
            name: Switch to light mode
```

It configures:

- Code listings with syntax highlighting and a copy button
- Top layer navigation is moved to tabs at the top of the page, which makes it quicker to jump around.
- Dark theme and toggle to get light theme
