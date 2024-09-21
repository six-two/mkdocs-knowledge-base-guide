# Vercel CI/CD

While you can use any CI/CD provider I like to use Vercel, since it is free, easy to use and has a routing feature that can be used to password protect the website.

To configure vercel you can add a `vercel.json` with the following contents to the root directory of your repository:

```json
{
    "installCommand": "python3 -m ensurepip; python3 -m pip install -r requirements.txt",
    "buildCommand": "python3 -m mkdocs build",
    "outputDirectory": "site",
    "github": {
        "silent": true
    }
}
```

You should commit and push this, before creating the Vercel project.

If you do not have a Vercel account, you can create a free one.
I personally am on the free tier and have not run in any limitations (except for the missing builtin authentication option) yet.
Then link your GitHub (or GitLab) account to Vercel.
Finally create a Vercel project: `Add New...` -> `Project` -> Select GitHub repo -> `Import` -> `Deploy`.

## Authentication

@TODO Link to plugin
