# ProperDocs Quickstart

L|Homepage|https://properdocs.org/|
I|pypi|properdocs|
I|github|ProperDocs/properdocs|

This is designed to get you up and running as quick as possible.

1. Install ProperDocs:

    ```bash
    pip install properdocs
    ```

2. Create a new ProperDocs project:
    ```bash
    properdocs new .
    ```
3. Remove `docs/index.md` and copy your notes into the `docs` directory.
4. Serve the site with ProperDocs to see if it looks OK: `properdocs serve`
5. Optional: Improve the site by adding plugins, themes, updating `properdocs.yml`, etc.
6. Deploy the site.
    For example by building it with `properdocs build` and uploading the `site` directory to your server's web root.
