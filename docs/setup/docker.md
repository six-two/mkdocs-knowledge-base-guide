# MkDocs in Docker

There are multiple reasons, why you may want to use mkdocs in docker instead of natively:

- You do not have Python installed on your system.
- You want the extra security of not having to execute random Python code (mkdocs plugins and their dependencies) on your host system.
- You have many MkDocs sites using almost all the exactly same plugins and it is a pain to update the dependencies regularly in all your Python virtual environments.

## Dockerfile

For this project I have built a simple somewhat reusable container, which you can use as a starting point.

The Dockerfile can be very simple:
```Dockerfile
FROM python:slim
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r /tmp/requirements.txt
COPY default-mkdocs.yml /share/mkdocs.yml
WORKDIR /share
ENTRYPOINT ["/usr/local/bin/mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8000"]
```

Basically your Dockerfile:

1. Uses a standard Python image.
    I do not use the `alpine` ones, since they have [no support for installing binary Python packages](https://pythonspeed.com/articles/alpine-docker-python/).
    So everything Python dependency needs to be built from source, which slows down the Dockerfile build quite a bit and requires additional dependencies.
2. Installs any MkDocs plugins which you may use in the site(s).
3. Optionally: Provides a fallback file for `mkdocs.yml`.
    This is only needed of you want to mount folders without a `mkdocs.yml`.
4. Executes `mkdocs serve` or `mkdocs build` when you start the container.

For hardening purposes you may not want to run `mkdocs` or `pip install` as root inside the container.
To accomplish this, you can crate a new user in the container and run all commands as that user:
```Dockerfile
FROM python:slim
RUN useradd --create-home app --uid 1001
USER 1001:1001
COPY requirements.txt /tmp/
RUN pip install --user --no-warn-script-location --no-cache-dir -r /tmp/requirements.txt
COPY default-mkdocs.yml /share/mkdocs.yml
WORKDIR /share
ENTRYPOINT ["/home/app/.local/bin/mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8000"]
```

## Build container

If you want to use my docker image, you can use the version hosted in the GitHub container registry:
```bash
docker pull ghcr.io/six-two/mkdocs-knowledge-base-guide
```

You can also use the `Dockerfile` in the root of this repository:
```bash
docker build --platform linux/amd64 -t ghcr.io/six-two/mkdocs-knowledge-base-guide .
```

!!! note "ARM issues"
    Some of the Python dependencies do not have binary packages compatible with ARM.
    This causes `pip` to try to build them from source, which in the case of `editdistpy` requires a C++ compiler:
    ```
    error: command 'g++' failed: No such file or directory
    ```
    To prevent having to install a bunch of extra packages in the image just to work on my mac, I build an x64 image instead.
    Linux (with QEMU) and macOS (with Rosetta) can run them pretty reliably.

## Serve web site

To serve any folder of Markdown files with the default `mkdocs.yml` from the container just mount the Markdown files into the correct location in the container:

```bash
docker run --rm -it -p 8000:8000 -v "$PWD/docs:/share/docs:ro" ghcr.io/six-two/mkdocs-knowledge-base-guide
```

If you have custom settings, you also want to mount the `mkdocs.yml` and maybe some other files.
In this case mount the whole root folder of your mkdocs project into the correct location in the container:
```bash
docker run --rm -it -p 8000:8000 -v "$PWD:/share:ro" ghcr.io/six-two/mkdocs-knowledge-base-guide
```

## Build web site

If you want to build the page, you need to mount the `/share` directory with read write, since the output files need to be written to it:
```bash
docker run --rm -it -v "$PWD:/share" ghcr.io/six-two/mkdocs-knowledge-base-guide build
```

Or if you just mount the notes into the image, you also need to mount a folder for the output files:
```bash
docker run --rm -it -v "$PWD/docs:/share/docs:ro" -v "$PWD/site:/share/site" ghcr.io/six-two/mkdocs-knowledge-base-guide build
```
