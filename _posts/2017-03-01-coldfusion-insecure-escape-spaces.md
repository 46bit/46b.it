---
title: Why we escape spaces against XSS
tags: Hacking
layout: post
---
I'm in my Masters year at the moment, which means I have a lot fewer classes but a lot higher expectations in assignments. I'm also undertaking an MEng project (I'll write about this sometime.) So I have a lot more unreserved time but a bit more work to do. I've been filling one day a week doing security and maintainance work on old ColdFusion web applications.

ColdFusion is an old web technology that Macromedia put out. It's like you implementated of PHP in HTML tags. For I have been working with it - trying to secure a large number of small webapps built with it in years gone by.

There's a bit of a problem with securing these legacy apps. They're a mess, and **ColdFusion is insecure by default.** Let's take some typical Ruby `erb` markup:
<!--more-->

``` ruby
<input name="forename" value="<%= forename %>">
```

The `<%= … %>` tags automatically escape what's being printed against XSS. The default case is the safe one. Outputting without escaping has to be explictly specified with the `raw` function. Sadly, ColdFusion only autoescapes in special cases - and I've been warned that even then it isn't bulletproof.

``` coldfusion
<cfinput name="forename" value="#form.forename#">
```

People running ColdFusion are generally moving to the open source [Railo](@TODO) and [Lucee](@TODO) servers. These applied a sanity pass to what they should support.

A decision I support is expecting the webapps to work and be secure on both old and new servers. This rules out using anything that was insecure in ColdFusion. It also rules out anything that was new in Railo/Lucee.

<img src="/assets/coldfusion-insecure-intersection.png" alt="Pictorial depiction of which solutions can be used." width="600">

The intersection of secure and available in both is to import the [OSASP ESAPI API](https://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API) from Java.

``` coldfusion
<cfoutput>
    <input name="forename" value="#request.esapi.encodeForHTMLAttribute(form.forename)#">
</cfoutput>
```

Yuck, huh? You might notice we're using `cfoutput` and `input` tags now. As I'll explain, this works around double-escaping issues.

## Why Escape Spaces against XSS?

In one of these application I was escaping a `cfinput value` with ESAPI:

``` coldfusion
<cfinput name="forename" value="#request.esapi.encodeForHTMLAttribute(form.forename)#">
```

But on Lucee `cfinput` is running `encodeForHTMLAttribute` itself and so we're double-escaping `form.forename`. So some characters got double escaped: ` ` (space) &rarr; `&#32;` &rarr; `&amp;#32;`.

Instead of `Stranger Things` your prefilled form field now says `Stranger&#32;Things`.

You wanted this: <input value="Stranger&#32;Things"><br>
You get this: <input value="Stranger&amp;#32;Things">

This could have the approach of escaping almost any character outside `/a-z0-9/i` but I was genuinely surprised that spaces are escaped. I found myself wondering why. Turns out there is a very good reason. Let's go back to `erb`, which escapes by default.

``` html
<input name="forename" value=<%= forename %>>
```

See how there's no quotation marks for the `value` attribute? HTML is happy without them. So a library that doesn't escape spaces would leave you vulnerable.

``` html
forename = 'Stranger&amp;Things onload=alert("XSS")'

<input value=Stranger&amp;Things onload=alert('XSS')>
```

I think this fits into Defence In Depth. Attribute tags *should* have the quotation marks, but mistakes happen and nobody is looking for that particular mistake. You have a problem when it only takes one missing quotation mark to open up your website to XSS. Escaping spaces is therefore quite important.

## Salvaging legacy applications

I've found this a frustrating but enjoyable bit of work. Legacy is always a bit fascinating - at Archaeology Data Service I was reverse-engineering some 'interesting' ESRI XML formats.

I don't know how completely one can secure applications by hand when they're messy, insecure by default, and number in the dozens. I'm doing my very best and making heavy use to regexes to check every last `#…#` and use of `cf` tags. But this is only a very small slice of ColdFusion's weirdness: by default it acts like [PHP with `register_globals` turned on](https://en.wikibooks.org/wiki/PHP_Programming/Configuration:_Register_Globals).

Well-built software has lingering undiscovered security problems; with sufficient mess one is guaranteed to miss some. But my regexes and discipline does allow eliminating some error classes in near-entirety.

I think my next step should be to fuzz these applications. That's how they'll be attacked, so I think it's absolutely necessary to do it ourselves. I should also take a look into the `X-XSS-Protection` header, but I'm guessing it isn't something to rely upon.

Until next time,<br>
&mdash; 46bit
