# encrypt source

This may not be useful to most of you.
I wrote it, so that certain information is stored encrypted, so that GitHub / GitLab will not be able to scan it.
It is decrypted at build time by the CI/CD environment.

Since the [vercel password authentication](vercel-pw.md) plugin is storing the URL and password in the same location, anyone with access to the source code could still access it.
But it will not be easily found by automated code scans.
