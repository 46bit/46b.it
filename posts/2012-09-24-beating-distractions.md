---
title: Beat distractions and stop multitasking
---
A big problem when working alone is keeping focus: it's way too easy to get distracted and find you've wasted 20 minutes on something that really doesn't matter. I used to just try to not run into this trap, but over the years I've come across a couple of tricks to tackle it.
<!--more-->

## Block distracting sites

First of all, block access to all the sites you don't need for work. This certainly means Twitter, Facebook, Hacker News and Reddit. When you need focus it means your email as well. The easiest option is to append the following lines to your `/etc/hosts` file (you'll need `sudo` permissions).

<pre>127.0.0.1  twitter.com www.twitter.com
127.0.0.1  facebook.com www.facebook.com
127.0.0.1  news.ycombinator.com reddit.com www.reddit.com

# Keep the following line if you want to block Gmail
127.0.0.1  mail.google.com</pre>

Simply remove those lines to make the sites accessible again.

Having these sites blocked stops those "let's just open Twitter for a second" distractions, freeing you up from all the ways to waste time online. To be honest, it's made me reconsider what I actually gain from most of these sites.

## Disable your notifications

I first got this tip from somewhere I've long since lost track of. If you consider email, social media, modern phones and so forth there's a buzz of insignificant notifications we get bombarded with daily. New emails, Twitter replies and so forth are usually not important enough to interrupt your work for - regardless of how it can feel, there's not much that can't wait a few hours.

Disable all push notifications on your phones, disable the bongs of new emails and try to keep to checking them only when you get up for a break. They really don't matter. You've better things to do than trying to keep track of your social life at the same time as doing what you get paid/pay yourself for.

I'd love to hear what works for any of you.
