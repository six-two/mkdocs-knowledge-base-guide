# remove_sections

I|github|six-two/mkdocs-remove-sections-plugin|
I|pypi|mkdocs-remove-sections-plugin|

You can use this plugin if you want to share your knowledge base with other people but you want to redact some information from them.
For yourself you can build it with a config that does not use this plugin.

## Configuration

If you want to have a version with and without censoring, the easiest thing is to enable the plugin only if an environment variable is set:

```yaml
plugins:
- remove_sections:
    enabled: !ENV [REMOVE_PRIVATE, false]
```

Then you can set or omit the variable during the build process to choose the version:

=== "Censored version"
    ```bash
    REMOVE_PRIVATE=true python3 -m mkdocs build
    ```

=== "Uncensored version"
    ```bash
    python3 -m mkdocs build
    ```

For deployment, you can have two CI pipelines.
For more info see [the vercel password plugin page](vercel-pw.md).

## Usage

Start any section that you want to censor with `Private:` like this:
```
## Example

This will be visible

### Private: Solutions

This will be redacted

#### Question 1

This will also be redacted, since it is in a subsection.

### Different section

This will not be redacted anymode.

#### Private: Another redacted section

This will also be redacted
```

This will be rendered normally if the plugin is disabled.
But if it is enabled, it will look like this:

## Example

This will be visible

### Private: Solutions

This will be redacted

#### Question 1

This will also be redacted, since it is in a subsection.

### Different section

This will not be redacted anymode.

#### Private: Another redacted section

This will also be redacted
