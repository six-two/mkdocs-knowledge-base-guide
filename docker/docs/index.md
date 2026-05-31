# No files found

You need to mount your notes directory to in the docker container to serve them:

- If you just want to serve a folder of markdown files with the default `properdocs.yml` file, mount them to `/share/docs`.
- If you have a custom `properdocs.yml`, then mount the folder containing the `properdocs.yml` to `/share`
