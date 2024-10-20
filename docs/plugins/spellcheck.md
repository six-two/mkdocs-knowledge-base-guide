# spellcheck

I|pypi|mkdocs-spellcheck|
I|github|pawamoy/mkdocs-spellcheck|

My spelling isn't always the greatest, so it can be useful to add a plugin that checks my spelling.
It is somewhat limited as it does not check grammar, but it usually spots quite a lot of typos and supports a ignore list to stop it from complaining about false positives.

## Usage

```yaml
plugins:
  - spellcheck:
      # Reminder: if you change backends, include the backends in requirements.in and rebuild requirements.txt
      backends:
        - symspellpy  # as strings
        # - codespell:  # or nested configs
        #     dictionaries: [clear, rare]
      known_words: ../known_words.txt # path is relative from docs/ dir
      ignore_code: yes
      # minimum length of words to consider
      min_length: 2
      # maximum number of capital letters in a word
      max_capital: 1
      # keep unicode characters
      allow_unicode: no
      skip_files: 
      - tags.md
```

When you build the page and you make typos, you the will see warnings like:
```
WARNING -  mkdocs_spellcheck: (symspellpy)
           plugins/material/tags.md: Misspelled 'sureounded',
           did you mean 'surrounded'?
```

Sometimes it has ridiculous suggestions:
```
WARNING -  mkdocs_spellcheck: (symspellpy)
           setup/check-for-real-ip-addresses-and-hostnames.md:
           Misspelled 'hostname', did you mean 'hostage'?
```

In these cases add the word to the `known_words` file defined in the config (for example `known_words.txt`).
Similarly it flags most parts of URLs (`https`, `www`, `io`), so you need to add them to the list too.

## Secondary configuration files

Build times can grow quite a lot for large knowledge bases and checking all pages for typos slows it down further.
Plus for me typo hunting is not something I do with every build.
Thus I like to use this plugin in a secondary config.
This is another neat feature of mkdocs: you can have multiple configuration files for different purposes.
While by default `mkdocs.yml` is used, you can create more files like `mkdocs-spellcheck.yml` and use them with:
```bash
mkdocs serve -f mkdocs-spellcheck.yml
```

This enables you to make faster test builds by having a test configuration file that removes nice-to-have-but-not-critical plugins like spellcheck, minify, pagetree, extract-listings, etc.
This is usually fine, since you want to just test whether pages are displaying properly and whether your links work.
Plugins that change some text (badges) or are needed for the site to work (ezlinks) still should be used in that config.

Then you can have another config file for production builds that actually uses all these plugins to make your site prettier and more functional.

