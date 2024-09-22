# awesome pages

I|pypi|mkdocs-awesome-pages-plugin|
I|github|lukasgeiter/mkdocs-awesome-pages-plugin|

This plugin enables you to set the order for all files in a folder without having to manually specify a whole navigation as `nav`.

For example to order the pages in my `setup` folder, I just added a file `setup/.pages` that specifies the order:
```yaml
nav:
    - quickstart.md
    - dependency-pinning.md
    - vercel-ci-cd.md
    - check-for-real-ip-addresses-and-hostnames.md
    - download.md
```
