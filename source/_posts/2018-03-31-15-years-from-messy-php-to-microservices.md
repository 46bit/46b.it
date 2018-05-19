---
title: 15 years of web development
layout: post
---

When I started web development in the early 2000s, your typical medium sized website ran on a single codebase that ran in exactly the same way on a few webservers. The frontend, things like accessibility and JavaScript, felt like novelties.

That single codebase *was* the website. It received web requests directly from its users, it talked directly to the database that stored the website's state, it decided all the business logic of how the website worked, and it rendered HTML to be sent back to the user.

Lots has changed. Some of this might be about the quality of environments I'm working in, but I don't think very much.

## Code quality

At the time, most of the code I saw from other programmers embedded SQL queries directly into HTML templates:

```php
<html>
<head>
<title>A website</title>
</head>
<body>
Visitor count: <?php
mysql_exec("INSERT INTO visitors (ip_address) VALUES ("
  . $_SERVER['REMOTE_ADDR'] . ");");
echo mysql_fetch_row(mysql_query("SELECT COUNT(*) FROM visitors;"));
?>
</body>
</html>
```

I haven't run that code, but it's quite typical of what freelance web developers were doing in the early 2000s. It rarely had proper error handling, rarely prevented SQL Injection, and almost never prevented XSS Injection.

I got a lot of feedback about how good I was at avoiding these problems, but I eventually decided that relying on my attention to detail to avoid these problems didn't work. Hence I picked up MySQL query parameters to avoid SQL Injection, and eventually PHP frameworks like CodeIgniter to avoid XSS Injection.

We've come a long way in our tooling since then. Modern frameworks automatically escape data being output into HTML templates against XSS attacks. Modern frameworks often have an architecture that would make it inconvenient and difficult to embed database queries into HTML. Modern frameworks are often used with ORMs or other mechanisms that make SQL Injection much less likely.

All of this means you don't have to think as much. Basic web application security and basic web application architecture is almost an automatic.

## Coupling of components

Earlier, I described how 2000s-era websites generally had one codebase for everything and deployed a single thing onto their webservers. This can work very happily when you first build a website, but it starts to have problems if you get a lot of traffic.

If you want to change how data is stored, for instance to add caching around it, your first task becomes to abstract the data layer from the rest of your codebase. This could consume weeks of work without delivering any user value.

Since the mid/late 2000s, mainstream frameworks started to separate the data layer out, for instance keeping it in the Models if following an MVC pattern. This meant that your changes only affect a more concentrated part of the codebase. But you ultimately still have one codebase and very little abstraction.

Things have marched on since then. These days you commonly deploy several components, rather than just one. You'll have an API component that exposes ways to access your data but abstracts most of the details of how that's done. You'll have a backend component that performs business logic on data it gets and sets using the API. Then you'll have a frontend component that directly interacts with user requests and talks to the backend.

You won't necessarily have all these components. You can achieve a lot of the benefits by keeping this pattern in mind at an early stage. But if you're a microservices architecture like GOV.UK you have several data layer APIs, many backends, and then relatively few frontends. Separating these components keeps each piece small enough to be effectively worked on.

## Frontend sophistication

Over those 15 years, JavaScript has gotten a lot faster and a lot more capable. Web browser APIs have gotten a lot more featureful, offering 3D graphics and videocalls and many other things besides.

User experience has gotten a lot better and a lot higher expectations (except for new weirdnesses like click-through cookie law banners.)

I started as more of a front-end developer, and then got to know the back-end as well. For many years I did freelance projects that were front-end, back-end or both and wouldn't say I did one side better than the other.

I think full-stack development has become less plausible. Expectations of user experience have gotten a lot higher, and the complexity of front-end development has exploded in a new search for the best ways of doing things.

The challenge we seem to be left with is where business logic belongs. The frontend is nicest if you can make it a thin wrapper and push that onto the backend; the backend is nicest if you can make it a thin wrapper and push that onto the frontend.

At this stage I identify as a backend/operations person. I'm sure I'll work heavily with the frontend again one day, but I don't think I can do both any longer.

## Testing and operational sophistication

Tests used to be purely for your business logic. You'd test that your code calculated the correct prices. Deployment often meant FTPing your code onto a shared hosting environment. It was a mess.

Things have changed for the better. Source control is almost universal. Infrastructure has gotten more accessible to developers, which is a good thing for me. Testing of running/deploying websites is much more common.

## What hasn't changed?

Very often we still want things to "just work!" But what things working look like is getting better and better, and that's a good thing.
