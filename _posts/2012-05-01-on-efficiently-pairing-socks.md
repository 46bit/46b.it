---
title: On efficiently pairing socks
tags: Math
layout: post
---
Anyone who has done an appreciable amount of laundry has probably noticed the time commonly taken matching up socks of different styles and colours.

My efforts to optimise the process have led me to the curious practice of un-matching: making pairs of socks so as to deliberately **not** be a matching pair. It's much faster, much simpler to compute and yet because there is a process behind it you have a defence against allegations of laziness.
<!--more-->

![](/assets/writing/different-coloured-socks.jpg)

If you consider the normal process of matching socks, a sock is picked from the top of the pile, then the pile is traversed to find a matching sock (a [Linear search](http://en.wikipedia.org/wiki/Linear_search)). As such, we're discussing a horribly brute-forced example of the [stable roommates problem](http://en.wikipedia.org/wiki/Stable_roommates_problem).

Optimisations to the matching algorithm were [discussed back in 2003](http://www.mail-archive.com/kragen-tol@canonical.org/msg00084.html):

<blockquote>
	<p>"I maintain an "unpaired sock buffer", usually on my leg, which is initially empty. Then, for each sock in the sequence, I do a sequential search through this buffer for its mate. If I find the mate, I remove it from the buffer and form a pair; if I do not, I add the new sock to the buffer &hellip;</p>
	<p>The worst case for this problem is to compare every sock against every other sock. The worst case for the naive sock-buffer method isn't that bad; it happens when the sock sequence is palindromic. Here, you need only compare to half the other socks at most, and a quarter of them on average, which is four times better than the worst case."</p>
	<p>&mdash; <cite>[On the complexity of sock-matching](http://www.mail-archive.com/kragen-tol@canonical.org/msg00084.html) by Kragen Sitaker</cite></p>
</blockquote>

My concept of unmatching provides for a major speed boost to this process. Whereas previously two given socks might have had a 20% chance of being a valid pair, that now becomes a 80% chance. Providing that there is no major bias towards a given style of sock, this provides a massive speedup. The worst case may in fact be the best case for ordinary matching: when every sock is next to a matching sock in the pile.

*With luck, nobody will ever again ask why my socks don't match.*
