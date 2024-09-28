FROM python:slim

# Install my dependencies (mkdocs plugins)
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r /tmp/requirements.txt

# Copy some fallpack files to /share, in case the user just mounts their markdown files or mounts them to a wrong directory
COPY docker/ /share
WORKDIR /share

# By default serve the mounted notes
EXPOSE 8000
ENTRYPOINT ["/usr/local/bin/mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8000"]
