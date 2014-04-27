---
title: The reluctant HAMLer
---
I've been writing HTML since my last year of Junior School. That's probably 500,000 lines written over 8-9 years and I long since reached the point of rarely needing to think about it. I usually don't even put it down as a skill anymore.

That probably explains my first thoughts on HAML, a templating language for Ruby that wraps up HTML with an alternate syntax (see below). Quite literally I thought **"WTF?"** It seemed crazy that anyone would try to mangle HTML: it's been around for a long time, and all you're doing is making another pain point for new developers. Right?
<!--more-->

<pre data-lang="haml">.lightbox-large
  %header
    %h1 Lorem ipsum
  #main
    %p{title: "Some more lipsum."}
      Dolor sit amet.</pre>

Not so right, actually. Once I started to use it, I liked it despite myself. It's taken a few months, but I think I know why.

When working on HTML, there's a few things about each tag that are more important than any of the others: the tag name (`h1`, `body`), the tag class (`.column`, `.search`) and the tag ID (`#page`, `#main-header`). HAML encourages you to put these 3 properties of each element up front, placing other attributes in a following hash. Hence you usually have all the information you need to write up the (S)CSS styles from the briefest glance at a source definition: no more attribute hunting.

It's not that HAML tends to be more succinct than HTML (it is) [1], or that HAML prevents broken markup (it does at the cost of painful debugging). What matters is that it's a lot easier for even an experienced frontend coder to style a page faster, and that's because of less thinking time - not because you spend less time typing.

As for my initial reluctance? Grouchy old man syndrome: I was so used to something that I didn't want to admit a change was for the better. This is actually quite a danger for a programmer, since things change a lot faster than you even *can* adapt a lot of the time, so I'm quite glad to show I can beat it.

Try [following the official tutorial](http://haml.info/tutorial.html) if you'd like to learn more about HAML.

[1] If you want to type less when writing normal HTML, try [Zen Coding](http://code.google.com/p/zen-coding/). Type `ul>li*12>a`, then press &#8984;-E and out comes the equivalent HTML and plenty of saved time. It's something of a one-way HAML-like tool.
