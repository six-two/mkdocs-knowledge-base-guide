# vercel-pw

I|pypi|mkdocs-vercel-pw-plugin|
I|github|six-two/mkdocs-vercel-pw-plugin|

A helper I wrote to password protect your site for free if you deploy it with Vercel.
It works by adding a rewrite rule that rewrites all request without valid authentication to a dummy page.
If you provide authentication, which the dummy page will try to read from the URL hash, then you can see the actual websites and the authentication is stored as a cookie.

This allows you to create a sharable URL that people can use to access your site (like `https://mkdocs-vercel-pw-plugin.vercel.app/#T%C3%A4%C3%9Ft%F0%9F%98%80Emoji`) while people finding it via Google, CA transparency logs, etc will not be able to read it.

Alternatively you could use the [client side decryption plugin from unverbuggt](https://github.com/unverbuggt/mkdocs-encryptcontent-plugin), but I do not use it since I am to lazy to patch Material's search to work with it ;)
