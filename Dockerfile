# Reminder @ME: The ghcr.io image only gets updated, when you push a new tag
FROM python:slim
RUN useradd --create-home app --uid 1001
USER 1001:1001
WORKDIR /home/app/

# Install my dependencies (mkdocs plugins)
COPY docker/requirements.txt .
RUN pip install --user --no-warn-script-location --no-cache-dir -r requirements.txt

# Copy some fallpack files to /share, in case the user just mounts their markdown files or mounts them to a wrong directory
COPY docker/ /share
WORKDIR /share

# By default serve the mounted notes
EXPOSE 8000
ENTRYPOINT ["/home/app/.local/bin/mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8000"]

LABEL org.opencontainers.image.source=https://github.com/six-two/mkdocs-knowledge-base-guide

