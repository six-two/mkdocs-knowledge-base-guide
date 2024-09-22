# Material For MkDocs - Tags

You can manually add tags by adding the following to the top of your page:
```yaml
---
tags:
- Tag 1
- Another tag
---
```

For automatically tagging pages based on their path or file name, I wrote the [[auto-tag]] plugin.

Make sure to add the `tags` plugin to your `mkdocs.yml`:
```yaml
plugins:
- tags
```

If you want a page that lists all tags and what pages have it assigned, you can set the `tags_file` option:
```yaml
plugins:
- tags:
    tags_file: plugins/material/tags.md
```

... and then use the `TAGS` placeholder sureounded by curly brackets (like `[TAGS ]` but without the space) where the plugin should insert the list.

## Custom icons

You can also style each tag with a icon by adding the following to your `mkdocs.yml`:
```yaml
theme:
  name: material
  icon:
    tag:
      author: octicons/person-fill-24
      plugin: material/puzzle
extra:
  tags:
    Plugin: plugin
    "Written by me": author
```

This gives the tag `Written by me` the icon `octicons/person-fill-24` and `Plugin` the icon `material/puzzle`.
You can find valid icons using the search at <https://squidfunk.github.io/mkdocs-material/setup/changing-the-logo-and-icons/#logo-icon-bundled>.
You can open it by clicking the `+` icon in the first listing (after `logo: material/library`).

## Tag listing example

[TAGS]
