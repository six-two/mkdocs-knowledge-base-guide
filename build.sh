#!/usr/bin/env bash

if [[ $# -lt 1 ]] || [[ "$1" != "PRIVATE" && "$1" != "SHARED" ]]; then
    echo "[*] Usage: <PRIVATE/SHARED> [PORT]"
    exit 1
fi

# cd into the repo's root dir
cd "$( dirname "${BASH_SOURCE[0]}" )"


# delete the output directories if they already exist
rm -rf public

# Set CICD_NO_VENV=yes in CI pipeline to skip venv usage
if [[ -z "$CICD_NO_VENV" ]]; then
    if [[ ! -f venv/bin/activate ]]; then
        echo "[*] Please create a virtual python environment:"
        echo python3 -m venv --clear --upgrade-deps venv
        exit 1
    fi

    echo "[*] Using virtual python environment"
    source venv/bin/activate

    if [[ ! "$VIRTUAL_ENV" -ef venv ]]; then
        echo "[-] \$VIRTUAL_ENV has unexpected value: $VIRTUAL_ENV"
        echo "    Hint: If you moved this directory or did any other big modifications, please remove the $(realpath venv) directory"
    fi
fi

if [[ -f ~/.leak-list ]]; then
    # Check for user specific leaks. Global file -> I do not need to upload the secrets to the cloud.
    # Of course this has the disadvantage that the cloud can not check.
    # Perl regex -> can do easy lookaheads and lookbehinds. So you can do stuff like "john[ -_]?(?!doe)" to serach for John but exclude "John Doe".
    # Sadly perl regex means we need to loop over the file
    while read -r LEAK_PATTERN; do
        echo "[*] Checking perl regex: $LEAK_PATTERN"
        if grep -i -P "$LEAK_PATTERN" -r . --color=always --exclude-dir={venv,.git} -l; then
            echo "[!] Leaks against local blacklist list found"
            echo "    Do not commit and push, the server can not find the leak and will publish the page!"
            exit 1
        fi
    done < ~/.leak-list
fi

# Stop the build if possible leaks are detected
echo "[*] Checking for possible IPv4 address or hostname leaks"
if find-and-check-hosts ./docs -E mermaid.min.js,toast.min.js,login-link.js,.png,.jpg,.jpeg,.webp -c ./find-and-check-hosts.yaml --hide ok --assert-no-results; then
    echo "No leaks found"
else
    echo "[!] Some potential leaks were found. Aborting..."
    exit 1
fi


set -e # exit on error

# Run the normal mkdocs build
# Invoke like this to work correctly on my mac (mkdocs has hardcoded interpreter to XCode version of python, which is too old for some of my code)
echo "[*] Building website with mkdocs"
SITE_VARIANT="$1" python3 -m mkdocs build -d public

DOWNLOAD_NAME=my-knowledgebase-download
if [[ "$1" == PRIVATE ]]; then
    # Tar the entire page. Rename the folder, so that the final directory will be named like that. Output should probably not be in the input folder, so we also need the move
    echo "[*] Building downloadable version"
    [[ -d "$DOWNLOAD_NAME" ]] && rm -rf "$DOWNLOAD_NAME"
    mv public "$DOWNLOAD_NAME"
    tar -czf "$DOWNLOAD_NAME.tar.gz" "$DOWNLOAD_NAME/"
    mv "$DOWNLOAD_NAME" public
    mv -f "$DOWNLOAD_NAME.tar.gz" public/
else
    echo "[*] Shared deployment, not building downloadable version"
    touch "public/$DOWNLOAD_NAME.tar.gz"
fi


# ==================== SERVE ===========================

# Start the web server if a port was given
if [ ! -z "$2" ]; then
    echo "[*] Serving the website at http://127.0.0.1:$2"
    python3 -m http.server --bind 127.0.0.1 --directory public "$2"
fi
