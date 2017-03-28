---
title: Designing a better home for writing.
layout: post
---
This blog experienced a lull from `2014-07-07` to `2017-02-27`, some 966 days. A lot happened in that timespan - I went through a long period of therapy, spent awhile reverse-engineering Dig data from dead ESRI databases in an Archaeology department, and got into everything from Swing Dancing to Python.

What didn't change was that the old design, well, sucked. I don't mean that it was the worst thing ever, but it was underwhelming as a place to write. So I'm going to talk through the redesign process.

<img src="/assets/old-new-aside.png" width="1000">

<!--more-->

I'm not a UI designer, but I have a pretty good grasp of UX from working at a web agency and a consumer-focused startup. I think this showed: this design was perfectly functional, links were quite visible, and the important text stood out. But the UI was very `LaTeX`y-monochrome, perhaps a reflection of how I was feeling when I made it.

When I started writing again I was nervous about how well I could write. I am not a naturally talented writer. But as with many skills worth learning, you just need to practice it enough that it becomes second nature. As I get more used to writing my writing should improve. I might build an audience of Rustaceans. My writing elsewhere should become clearer and easier. But part of this is having a pleasing place to write.

## Redesign narrative

### I need some colours

From past experience it helps me to get an initial colour palette. Many experienced designers seem to design in grayscale and treat the colours as second to content. I however find I struggle with how to colorize a design and make it pop. I wanted to stick with `hakyll`, a Haskell static site generator, and I didn't want to change the content.

I've always liked maroony reds, so that was my startpoint. Ten minutes of Adobe Kuler later, I had [this](https://color.adobe.com/46bit-color-theme-9379807/):

<img src="/assets/new-colours.png" width="600">

### First sketch

I chose to use my [Securing legacy ColdFusion or: Why escape spaces against XSS?](/2017/coldfusion-insecure-escape-spaces/) post as the content for the redesign. It isn't my best post ever, but the mix of text and code is quite representative of what I'll be writing here.

<img src="/assets/redesign-1.png" width="600">

A half hour in this is looking quite effective. The navigation colours don't work, the logo text is too heavy, but the basic structure works.

### Fourth sketch

Out of necessity I'm jumping ahead a way.

<img src="/assets/redesign-4.png" width="600">

At this point I'd copied in more content. This seemed essential in understanding how a long post would perform. I've previously found that simple designs with the header out of sight can be monochrome.

### Sixth sketch

<img src="/assets/redesign-6.png" width="600">

As someone who does a lot of business with the US and rest-of-the-world, I'm quite a fan of the `YYYY-MM-DD` date format. But here I started experimenting with including the day of the week, and in the final design I concluded a 'human' format would surprise users less.

### Eleventh sketch

<img src="/assets/redesign-11.png" width="600">

I tried to bring in more colours from the colourscheme, building a big header. This does sort-of work - but so much cyan is a risk when it comes to flexibility later.

### Eighteenth sketch

<img src="/assets/redesign-18.png" width="600">

I tried dropping the header and adding a bar below the navigation to enhance the structural connection to the active navigation item. This seemed like a great idea.

### Nineteenth sketch, the final one

<img src="/assets/redesign-19.png" width="600">

Inspired, I brought the reds and the more active navigation together. I loved it and decided this was enough to start implementing. Further changes could be made in the browser.

## What's live now

<img src="/assets/new-homepage.png" width="600">

You might notice - the narrow yellow line below the title bar originated in Sketch 11. It isn't in the colourscheme at all; I picked it up by chance. But it has made it into the live design, dividing the title bar and the post date on pages that list posts. It was on other pages for a while, but it split up the title and the text too much - the Achilles Heel of this design.

As of last night I've built in mobile support. Something I haven't done with this design is use Flexbox - I'm still using floats for positioning the logo and navigation. I've my MEng project to do and am under a lot of time pressure, so it was the wrong time to learn that.

So having written this post, one new priority is finding a better layout for this post on wider screens.

<img src="/assets/the-redesign-post.png" width="600">

I probably want to display images and text side by side. (Much of the text ugliness here is down to me having zoomed out.)

There is still a long way to go, but this is a design that can grow easily.
