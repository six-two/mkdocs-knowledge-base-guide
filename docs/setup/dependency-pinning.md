# Dependency pinning

Python packages should be pinned to ensure that a build that works for you today will also keep working in a year.
Not pinning dependencies will cause others and your CI/CD pipeline to use the latest version of all dependencies, which can cause build to unexpectedly fail or introduce bugs in the deployed website that do not heppen in your local setup.

I like to use `pip-compile` from the `pip-tools` package.
It can be installed with pip or pipx:
```bash
pipx install pip-tools
```

Then make a list of your dependency packages (without pinning) and call it `requirements.in`.
If you have constraints (like use `mkdocs<=1.6.0`), you should include them in this file.
But usually I only need them if the latest version of a package has a bug that I need to avoid.

From the `requirements.in` you can create a `requirements.txt` which pins the latest versions allowed by the `requirements.in`.
It also pins the versions of indirect dependencies (dependencies of your pinned dependencies):
```bash
pip-compile -U
```

You can the install the pinned versions of the dependencies with:
```bash
pip install -r requirements.txt
```

To update the dependencies, you can run `pip-compile -U` and `pip install -r requirements.txt` again.
Then build the site and check that everything still works.
