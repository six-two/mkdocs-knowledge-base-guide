# Check for real IP addresses and host names

If you directly paste commands from real pentests into your knowlege base, then you may overlook some identifying information like IP addresses or hostnames from real projects.
Since this can be very bad, especially if your notes are publicly accessible, you should implement measures to catch these cases.

Personally I have measures, which should prevent it:

1. I use generic [placeholders](placeholder.md) instead of actual hostnames, ip addresses, usernames where possible.
2. Early in the build process I check all hostnames and ip addresses against a list of rules.
    If any non-allowlisted entries are found, the build is aborted, so that the potentially leaked information is not published.
    How it is implemented is shown below.
3. I have a list of additional checks, that are performed when I run the build script locally.

## Checks in CI/CD pipeline

I|pypi|find-and-check-hosts|
I|gitlab|six-two/find-and-check-hosts|

For the identification and checking of hostnames and IP addresses, I wrote a tool called `find-and-check-hosts`.
It is published as a python package with the same name.
Then in my build script, I check the `docs` directory while excluding images and certain JavaScript dependencies which would result in many false positives:
```bash
# cd into the repo's root dir
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Check for leaked IPs and hostnames
if ! find-and-check-hosts ./docs -E mermaid.min.js,toast.min.js,tiny-qr.html,login-link.js,.png,.jpg,.jpeg,.webp -c ./find-and-check-hosts.yaml --hide ok --assert-no-results; then
    echo "[!] Build aborted: Some potential leaks were found."
    exit 1
fi
```

It is still missing hash (NT:LM format) and IPv6 support, feel free to make a PR for them :)

## Local checks

I also have a list of leak patterns, that are not committed into the repository.
This is used for information like my name (my notes are anonymous), employer, hostnames of infrastrucure that I use, etc.
For this I have a file called `~/.knowlegebase-leak-check-patterns` that is checked when it exists.
This means that it is only checked, when I run the build script locally.
But I do that most of the time, because otherwise many builds will fail, because I did not add new URLs to the hostname allow list.

The section in my script looks like this:
```bash
if [[ -f ~/.knowlegebase-leak-check-patterns ]]; then
    # Perl regex can do easy lookaheads and lookbehinds. So you can do stuff like "john[ -_]?(?!doe)" to serach for John but exclude "John Doe".
    while read -r LEAK_PATTERN; do
        echo "[*] Checking perl regex: $LEAK_PATTERN"
        if grep -i -P "$LEAK_PATTERN" -r . --color=always --exclude-dir={venv,.git} -l; then
            echo "[!] Leaks against local blocklist list found"
            echo "    Do not commit and push, the server can not find the leak and will publish the page!"
            exit 1
        fi
    done < ~/.knowlegebase-leak-check-patterns
fi
```
