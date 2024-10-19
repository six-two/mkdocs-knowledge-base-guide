# MkDocs plugins

L|MkDocs plugin (developer) guide|https://www.mkdocs.org/dev-guide/plugins/|
L|MkDocs plugin catalog|https://github.com/mkdocs/catalog|

In my opinion one of the greatest strengths of MkDocs is its extensibility using plugins.
There is a big and growing list of plugins available.
And if what you are looking for is missing (and not a complex problem), you can write a custom hook that implements it or ask ChatGPT/Phind to write it for you.

The following pages detail plugins I find helpful, but there are many more available at <https://github.com/mkdocs/catalog>.
The best plugin in my opinion is the [Material for MkDocs theme](material/index.md), which is basically a plugin collection in itself bundled with a great looking theme.
It is the most popular plugin and for example also used by [OWASP Cheat Sheets](https://cheatsheetseries.owasp.org/index.html) and quite a few other sites I have seen in the wild.
It improves many features of MkDocs, including the search.

## Installation

Each plugins can be installed by installing the python package with pip.
The name of the package is shown in a `PyPI` badge like the one below:

I|pypi|mkdocs-auto-tag-plugin|

You also can copy the install command by clicking on the `PyPI` text of badge.

## Usage

You have to add the plugin to your `mkdocs.yml`.
If you add plugins, the order is (sometimes) important and you have to add the `search` plugin unless you do not want the search.
For example if you just wanted the `autotag` plugin, you would add:
```yaml
plugins:
- search
- autotag
```

If the plugin requires configuration options, you usually specify them right in the plugin listing.
For example:
```yaml
plugins:
- search
- autotag:
    globs:
        "plugins/**": "Plugin"
        "setup/**": "Setup"
```

