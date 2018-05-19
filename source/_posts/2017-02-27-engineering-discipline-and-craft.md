---
title: Engineering as slowly as possible
tags: Hacking
layout: post
---
I've become a fan of developing, "as slowly as possible." It's proven hard to crystallise what feelings this sums up, but I relate it to [slow, logical, conscious System Two](https://en.wikipedia.org/wiki/Thinking,_Fast_and_Slow#Two_systems) thinking.

The way you start a project indicates a lot about how it will progress. Something that gets a testsuite early on will probably keep one going; something that is essentially untested is hard to improve. This hill can be climbed over if one is lazy or very disciplined - but sustained effort to undo unforced mistakes is hard.

So making the right decisions at the right time is important. Ideally we should favour sustained velocity over quickly hacking something together and forgetting about it. We should have good craft *in order to* still move fast: building things well rather than just building them.
<!--more-->

There's a balance between productivity (immediate gratification) and quality of craft. Small hacks and hobby projects which might be thrown away should favor early productivity. Larger projects, ones worked on infrequently, or ones shared with others should favor craft. One needs to pick correctly.

The natural question is where do you place projects with potential? If a prototype can lead to bigger things but also be in the bin inside a week?

* Throwaway projects can have a long lifetime. I hacked together some scraping and cleanup tools for University of York Student Union candidates last year, but at least twenty people I had to email for their information. This year I [published an analysis piece in Nouse student newspaper](http://www.nouse.co.uk/2017/02/18/battle-of-the-colleges-whos-got-the-bnocs/) on a 36-hour turnaround. My quick hack now had to automate the entire process because of time constraints.<br><br>
* Involved projects can have a surprisingly short lifetime. The high-quality cybersecurity practicals I worked on all last summer have yet to see the light of day. The ambitious systems I built at Dreamforge in 2012-13 have mostly been offline for two years now - our proof-of-concept [Cookie Caster](http://cookiecaster.com) is the sole brilliant survivor.<br><br>
* Poor craft tends to bite you in the butt when you can least afford it. Our software at Dreamforge worked quite well for Cookie Caster and for much of the Fraemes project. Where it let us down was in trying to make Fraemes scale.<br><br>Five minutes checking for regressions after making changes is trivially affordable in the early months of a new project; 10&times; five minutes a day is unaffordable when you're overworked and expending available brainpower working on complex things.

Experience is a good teacher. The benefit of experience is identifying when to make tradeoffs and how to avoid tradeoffs you don't have to make. I've been reading with a lot of interest about continuous deployment at [The Guardian](https://www.theguardian.com/info/developer-blog/2016/dec/20/testing-in-production-rethinking-the-conventional-deployment-pipeline) and [SkyScanner](http://codevoyagers.com/2016/10/31/from-20-to-2-million-releases-a-year-part-2/).
