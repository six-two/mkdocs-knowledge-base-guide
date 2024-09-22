---
tags:
- Written by me
---

# auto-tag

I|pypi|mkdocs-auto-tag-plugin|
I|github|six-two/mkdocs-auto-tag-plugin|
L|Documentation|https://mkdocs-auto-tag-plugin.six-two.dev/|

I wrote this plugin to automatically tag files based on their folder.
So instead of tagging hundreds of pages manually, I can at least give them rough tags based on their location.
In this documentation the tags `Plugin` and `Setup` are automatically applied by it.
This can be done by adding installing the plugin and adding the following to your `mkdocs.yml`:
```yaml
plugins:
- autotag:
    globs:
        "plugins/**": "Plugin"
        "setup/**": "Setup"
- tags # Installed if you use material theme plugin
```

You also need to install a plugin, so that tags are processed.
With the `material` theme, you can just enable the [[tags]] plugins.
