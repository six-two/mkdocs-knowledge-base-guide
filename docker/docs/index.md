# No files found

You need to mount your notes directory to in the docker container to serve them:

- If you just want to serve a folder of markdown files with the default `mkdocs.yml` file, mount them to `/share/docs`.
- If you have a custom `mkdocs.yml`, then mount the folder containing the `mkdocs.yml` to `/share`
