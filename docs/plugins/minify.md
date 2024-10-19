# minify

I|pypi|mkdocs-minify-plugin|
I|github|byrnereese/mkdocs-minify-plugin|

The `minify` plugin can make your pages smaller, which makes them load slightly faster.

When you view the HTML page that (Material for) MkDocs generates, you will see a lot of lines just containing white space, lots of (wrong) indentation, etc:

![MkDocs normal page source code snippet](mkdocs-view-source.png)

This means that minifying the page (removing unnecessary whitespace, comments and similar non-essential contents) can reduce the size of the web page a bit.

## Usage

The plugin gives you a lot of options, what you want to minify.
I usually minify everything except JavaScript code, since that is often written by me and minifying it makes debugging harder.
So my `mkdocs.yml` contains:
```yaml
plugins:
- minify:
    htmlmin_opts:
        remove_comments: true
    minify_css: true
    minify_html: true
    minify_js: false
```

With this plugin your page's source code looks much more compact:

![MkDocs minified page source code snippet](mkdocs-view-source-minified.png)


