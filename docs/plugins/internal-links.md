# Plugins - Internal Links

L|Plugins for links & references|https://github.com/mkdocs/catalog?tab=readme-ov-file#-links--references|

There are many plugins that simplify the linking of pages in mkdocs.
The reason why you want them is that by default you have to do relative links to files (like `../setup/quickstart.md`).
Absolute links also work, but lead to warnings in past versions and may break if the page is not hosted at `/` (for example if you host it at `https://my-website.com/blog/`).

Plugins like ezlinks enable you to do linking with just the file name (so `quickstart.md`).
Thay means that you save a lot of time updating broken links when you move a file or rename a directory.
Some also support wiki links syntax, which looks like `[[quickstart]]` and saves you even more typing.

## ezlinks

I|pypi|mkdocs-ezlinks-plugin|
I|github|orbikm/mkdocs-ezlinks-plugin|

I use ezlinks and it works, but it seems no longer maintained.
So I recommend you do your own research for a good linking plugin.
You can check in the [Links & references](https://github.com/mkdocs/catalog?tab=readme-ov-file#-links--references) section of the plugin catalog.

Usually I enable the additional linking types:
```yaml
plugins:
- ezlinks:
      warn_ambiguities: true
      wikilinks: true
      reference_links: true
```
