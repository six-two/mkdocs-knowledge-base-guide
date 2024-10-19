# placeholder

L|Homepage|https://mkdocs-placeholder-plugin.six-two.dev/usage/|
I|pypi|mkdocs-placeholder-plugin|
I|github|six-two/mkdocs-placeholder-plugin|

I wrote this plugin for two reasons:

1. It is really annoying having to manually replace values like the name of an ethernet interface or the IP address of the target, especially when it occurs multiple times.
2. When you leave data in commands it is easy to accidentally leave in real values that leak information.

While this can be somewhat remedied by using shell variables in the commands, this removes some information:

- What do valid values look like?
- How are they formatted?

At least for me it also makes debugging commands hell, makes understanding my shell history (as attack log) way harder and sharing the exact commands with others is also much harder.

Instead I decided to create a plugin that takes placeholder values in the documentation and replaces them with example values that can be changed by the user on the fly.

## Usage

First you define the placeholders that you want to use with your site in a file called `placeholder-plugin.yaml`.
While there are some advanced options like validators, descriptions, etc in the beginning you can just use the simple syntax that defines a placeholder and assigns a default value like this:

```yaml
settings:
  # to hide the table ath the top of each page, which is not really needed since inline editors are supported
  auto_placeholder_tables: false

placeholders:
  PLACEHOLDER_NAME_1: "Value for placeholder 1"
  WLAN_INTERFACE: wlan0
```

A thing to know about this plugin is that you set most configurations via its configuration file `placeholder-plugin.yaml` and not via the `plugins` section of your `mkdocs.yml`.

Then you can use it in the page by specifying it surrounded by lowercase `x` (like `xPLACEHOLDER_NAME_1x`).
An user can click on any location where you use the placeholder, to assign a new value.
This value is immediately applied everywhere on the page and is persistent, so it will be there when the page is reloaded or another page uses the same placeholder.

More settings and features can be found in the [plugin's documentation](https://mkdocs-placeholder-plugin.six-two.dev/usage/).

## Demo

Below are the commands to set the WLAN network device `xWLAN_INTERFACEx` to monitoring mode:

```bash
nmcli device set xWLAN_INTERFACEx managed no
sudo ip l set xWLAN_INTERFACEx down
sudo iw dev xWLAN_INTERFACEx set type monitor
sudo ip l set xWLAN_INTERFACEx up
```

Once you are done, you can return `xWLAN_INTERFACEx` to the normal mode:

```bash
sudo ip l set xWLAN_INTERFACEx down
sudo iw dev xWLAN_INTERFACEx set type managed
sudo ip l set xWLAN_INTERFACEx up
nmcli device set xWLAN_INTERFACEx managed yes
```

