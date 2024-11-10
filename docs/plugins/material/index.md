# Material for MkDocs

L|Homepage|https://squidfunk.github.io/mkdocs-material/|
I|pypi|mkdocs-material|
I|github|squidfunk/mkdocs-material|

Probably the best plugin/theme for MkDocs, I use it all the time.
While it officially is a theme it offers many other features (plugins) and has great documentation.

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
  - pymdownx.keys
  - pymdownx.snippets
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true

theme:
    name: material
    features:
        - navigation.tabs
        - content.code.copy
        - content.tabs.link

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
- [Tabs](https://squidfunk.github.io/mkdocs-material/reference/content-tabs/) that you can use with the following syntax:
    ```markdown
    === "Tab 1"

        Some content
    
    === "Tab 2"

        Different content
    ```

## Hide "Made with Material for MkDocs"

I understand why the author wants us to promote his great plugin, but I do not like it taking up space on my pages.
For any technically interested people they can see that the plugin is used via your source code or the meta tag in each of your pages:
```html
<meta name="generator" content="mkdocs-1.6.1, mkdocs-material-9.5.36">
```

Luckily it can easily be removed:

Just create an empty `overrides/partials/footer.html`:
```bash
mkdir -p overrides/partials; touch overrides/partials/footer.html
```

Then specify `custom_dir: overrides` in your theme settings in `mkdocs.yml`:
```yaml
theme:
    name: material
    custom_dir: overrides
```
