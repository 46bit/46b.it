## Is it worth building niche browser games, or not?

The problem is… building a good UI for an RTS game turns out to be pretty hard. And adding multiplayer requires serialising data, which has killed performance every time I've tried it. So right now it's AI-only, even though you can click-drag to select units and right-click to move them.

I've been struggling to decide whether to continue, and that's why I'm writing about it. WebGL is quite frustrating to work with, and so are modern browsers. Chrome offers support for all the technology needed to do a much higher-performance version: fast memory shared between JavaScript threads, canvas rendering in a background thread, etc. Firefox supports some of that. But Safari doesn't support any of that, which removes everyone on iOS.

RTS games are a lot less popular than they used to be. T hey're command-and-control games that benefit a lot from precise mice and keyboards. Nobody has ported them to mobile devices and found a UI that works well. So either I ignore mobile devices and ignore Safari, or I give up. Progress is agonisingly slow in getting these features into Safari … but maybe that's ok if it won't work in iOS anyway.

I'm trying to decide whether to build niche browser RTS games that will only perform well in Chrome. Chrome has most of the browser market, but giving up on cross-browser compatibility goes against everything I care about. And I don't know whether to carry on with something so nice. iOS looks very fun to develop for with the combination of Swift programming language and Metal graphics framework.
