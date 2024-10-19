# placeholder

I|Homepage|https://mkdocs-placeholder-plugin.six-two.dev/usage/|
I|pypi|mkdocs-placeholder-plugin|
I|github|six-two/mkdocs-placeholder-plugin|

I wrote this plugin for two reasons:

1. It is really annoying having to manually replace values like the name of an ethernet interface or the IP address of the target, especially when it occurs multiple times.
2. When you leave data in commands it is easy to accidentially leave in real values that leak information.

While this can be somewhat remedied by using shell variables in the commands, this removes some information:

- What do valid values look like?
- How are they formatted?

At least for me it also makes debugging commands hell, makes understanding my shell history (as attack log) way harder and sharing the exact commands with others is also much harder.

Instead I decided to create a plugin that takes placeholder values in the documentation and replaces them with example values that can be changed by the user on the fly.


@TODO: usage, demo
