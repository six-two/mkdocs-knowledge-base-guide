# vercel-pw

I|pypi|mkdocs-vercel-pw-plugin|
I|github|six-two/mkdocs-vercel-pw-plugin|

A helper I wrote to password protect your site for free if you deploy it with Vercel.
It works by adding a rewrite rule that rewrites all request without valid authentication to a dummy page.
If you provide authentication, which the dummy page will try to read from the URL hash, then you can see the actual websites and the authentication is stored as a cookie.

This allows you to create a sharable URL that people can use to access your site (like `https://mkdocs-vercel-pw-plugin.vercel.app/#T%C3%A4%C3%9Ft%F0%9F%98%80Emoji`) while people finding it via Google, CA transparency logs, etc will not be able to read it.

Alternatively you could use the [client side decryption plugin from unverbuggt](https://github.com/unverbuggt/mkdocs-encryptcontent-plugin), but I do not use it since I am to lazy to patch Material's search to work with it ;)

## Multiple deployments (censored and uncensored)

In combination with censoring certain contents using the [remove-sections](remove-sections.md) plugin, you likely want two deployments.

In my setup there is a `private/vercel.json` and a `shared/vercel.json`.
There are two Vercel projects, which use the same repository.
But each of them uses a different `vercel.json` and can have different environment variables, etc.

In my `mkdocs.yml` I then use the `vercel_pw` plugin twice to update both `vercel.json` files:

```yaml
plugins:
- vercel_pw:
    cookie_name: AUTH
    password: "SHARED_P@55W0RD_123!"
    restrict_to_domain: shared-notes.vercel.app
    vercel_json_path: ../shared/vercel.json
- vercel_pw:
    cookie_name: AUTH
    password: "PRIVATE_P@55W0RD_123!"
    restrict_to_domain: private-notes.vercel.app
    vercel_json_path: ../private/vercel.json
```
