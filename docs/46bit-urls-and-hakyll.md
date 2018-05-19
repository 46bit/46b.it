# _46bit URLs and Hakyll
Can achieve identical URL scheme trivially. Old redirects will work pending changes to site structure.

/2013/title.md -> /2013/title.html (obvious) -> /2013/title/index.html (desired)
/2014/title.md -> /2014/title.html (obvious) -> /2014/title/index.html (desired)
Current nginx redirects from ancient posts will still work naturally.

/about.md -> /about.html (obvious) -> /about/index.html
/ident.md -> /ident.html -> /ident/index.html
/talk will be retired for now. Redirect to contact details on /about.
Redirect on /contact will need changing to /about.
