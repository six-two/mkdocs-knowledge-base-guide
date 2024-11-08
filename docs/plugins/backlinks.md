# Backlinks

## mkdocs-backlinks

I|github|danodic-dev/mkdocs-backlinks|
I|pypi|mkdocs-backlinks|

Looks like a no longer maintained project, although some forks fix most glaring issue.
But somehow I did not get it working (did not inject backlinks into Material's `footer.html`).

## mkdocs-publisher

I|github|mkdocs-publisher/mkdocs-publisher|
I|pypi|mkdocs-publisher|

Looks like a nice plugin collection, but since I do not need most other function, just using it for backlinks looks overkill.
It also depends on the material plugin and forces a minimum version, which can cause issues if you need an older (or patched) version of the theme.

## Custom

See `hooks.py` in this repo.
It is roughly inspired by https://github.com/danodic-dev/mkdocs-backlinks, but directly injects the backlinks into the page.
Hopefully I soon have time to make it a proper plugin (with PyPI package and everything).
