# Download option

## Print page

I|pypi|mkdocs-print-site-plugin|
I|github|timvink/mkdocs-print-site-plugin|

There are multiple plugins that allow you to download your documentation.
I used to use [timvink's mkdocs-print-site-plugin](https://github.com/timvink/mkdocs-print-site-plugin).

Usually they work by combining all pages on a single page and optionally converting that page to a PDF.
This does not work well with my large knowledge base, since a page this big causes performance problems when viewed in a browser, finding the section you want is very hard and some plugins (especially placeholders) cause issues.

## ZIP of build artifacts

My solution is to offer a download of the built site like it is hosted as a ZIP file.
It somewhat works when opened in a browser (as `file://` URLs), but is best viewed when it is served with a local web server like:
```bash
python3 -m http.server ~/Downloads/my-knowledgebase-download/
```

It is implemented by renaming the output directory after the build is done, creating a `.tar.gz` file of it and renaming the folder back:
```bash
echo "[*] Building downloadable version"
DOWNLOAD_NAME=my-knowledgebase-download
[[ -d "$DOWNLOAD_NAME" ]] && rm -rf "$DOWNLOAD_NAME"
mv site "$DOWNLOAD_NAME"
tar -czf "$DOWNLOAD_NAME.tar.gz" "$DOWNLOAD_NAME/"
mv "$DOWNLOAD_NAME" site
mv -f "$DOWNLOAD_NAME.tar.gz" site/
```

Then you can link `my-knowledgebase-download.tar.gz` in one of your pages as a download link.
MkDocs will complain about the file missing during the build (since it is only created afterwards), but that is fine.
If it annoys you too much, you can always commit an empty dummy file, so that it exists during the MkDocs build process.

