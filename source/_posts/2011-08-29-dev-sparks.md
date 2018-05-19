---
title: Development Sparks
tags: Git, Math
layout: post
---
When we encounter a problem as developers, there's usually 3 ways to solve it. There's the hacky way with its attendant long-term maintainance costs. There's a way which works without too much trouble. And there's the spark of genius that solves all the troubles with the minimum of effort.
<!--more-->

As I'm sure you'll like me appreciate doing the latter when possible, I thought I'd share a couple of them - one for keeping private config details of git repos, and the other for letting you write neater code for sliders and the like. I'm planning on making this into a regular series of posts whenever I come across similarly helpful tricks.

## Config templates in Git

When developing a site, it's more than easy to update your local database config file and then include that in your next code commit - and usually, that's fine. The problem is that things like this make it easier for a compromise of one thing (your code repository for instance) to allow access to something potentially even more private (say, your company databases).

By default, there's no obvious-to-all way to stop git from quite happily adding updated config files, short of making sure you remember not to every time you commit. Adding a path to .gitignore does nothing if it's already in previous commits - and you don't really want to have to manually add a config file every time you check code out.

The solution is the quite simple spark I [first discovered here](http://blog.pagebakers.nl/2009/01/29/git-ignoring-changes-in-tracked-files/): `git update-index --assume-unchanged path`. Simply run that and git will never notice any changes to the file. This way, you can add a basic template configuration file, and then change it to appropriate local details without having to worry about accidentally exposing them elsewhere.

## Everything is easy with the modulus

A lot of the time, especially when dealing with sliders and the like, you come across code that requires a conditional check for a special case - going back to the first slide if you go past the last for instance. Whilst this works, there's a trick to making it far neater and reliable: the modulus.

In this context, getting the modulus amounts to **getting the remainder when one number is divided by another**, and the symbol in programming is usually %. For example, `5 % 2 == 1` because `5 - 2 - 2 == 1`.

Say you're coding a jQuery slider and want to go back to slide 1 once you reach the end. Counting from 0, the index of the next slide could be coded as `slideN = (slideN + 1 <= slides.length) ? 0 : slideN + 1`. This checks if you are on the last slide, and if so then goes to the 0th slide rather than the next slide. On the other hand, it's easier to write `slideN = (slideN + 1) % slides.length`. This does exactly the same.

Now the really neat thing: previous slides. Conditionally it'd be `slideN = (slideN - 1 > 0) ? slides.length - 1 : slideN - 1`, which goes to the last slide if you're on the first one. Using a modulo, it's neater `slideN = (slideN - 1 + slides.length) % slides.length`. When you can actually express the next slide as `slideN = (slideN + 1 + slides.length) % slides.length` as well, this gives you a really nice way to not have to worry about the scrolling direction for which logic to use, simply incrementing or decrementing as need be.

Once you get used to using %, neat uses pop up all over the place both in UI work and elsewhere.
