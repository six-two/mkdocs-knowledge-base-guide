# Vercel CI/CD

L|Homepage|https://vercel.com/|

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

By default the project is served at `https://<PROJEKT_NAME>.vercel.app`, but you can also choose any other `vercel.app` subdomain (if it is not used by someone else) or configure vercel to use your own domain.
Personally I have redirected all subdomains of `six-two.dev` to vercel using DNS (`CNAME` record for `*` to `cname.vercel-dns.com`), so that I can easily spin up new subdomains with vercel.

It takes care of requesting the certificates and all the other work.

## Authentication

An advantage of vercel is, that you can specify routing rules in the `vercel.json` files.
These allow you to add authentication like cookie based authentication or HTTP basic authentication to protect your website from unauthorized access.
You can see more on the [Vercel password plugin](vercel-pw.md) page.

