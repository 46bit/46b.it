---
title: Railway Data Revisited
tags: Data
layout: post
---
I mentioned Network Rail's feeds briefly last time but hadn't yet looked into them much. Thanks to [Samuel Littley](https://twitter.com/SMLittley/status/295175976818728963) for letting me know a bit more about them. [Sign up](https://datafeeds.networkrail.co.uk/ntrod/) and your access will be activated within an hour or so. Given that mine was granted at 3am GMT I suspect it's automated.
<!--more-->

My interest in this data comes down to how much I take trains to London, Manchester and elsewhere. Ever since I [built TrainTrackr](/2011/08/13/yrs2011/) in 2011 I've wanted to get a better idea of how late trains really are. These open data <s>feeds</s> firehoses offer me that chance.

## Using the data
**After getting access I discovered that the entire Data Feeds is almost as close to undocumented as you can get.** Thankfully I'd signed up to a talk at the [Open Data Institute](http://www.theodi.org) on this topic, given by [Jonathan Raper](https://twitter.com/madprof).

The honest truth is that it seems to be quite a pain. A few immediate problems:

* Network Rail may have released access to live train times, but the documentation around it is extremely lacking. This is apparently a result of the convoluted system the railways operate under.
* **The volume of data during the day is pretty big.** At least 500 messages a second. There's no reason you can't deal with that amount of data but the real problem is that **your API connection often drops**, causing you to miss some trains setting off. If you miss trains setting off from their first station, you'll struggle to work out where it's going along the entire route.

You then face the fact there's half a dozen different datasets: the train timetable, the live updates, changes to train journeys - and when trains have to divert you can lose track of where it's going altogether.

## Learning more
Unsurprisingly the train community got to this before I did, so there's quite a bit of useful things out there. I've not managed to find any overview/introduction that's up to date, so I might end up writing one next month.

If you want train data in a format where it's ready to build a Mobile API, try **[Placr's Transport API](https://developer.transportapi.com)**. Free for <1000 hits a day, paid above that. Placr's founder gave the ODI talk I mentioned, the slides are **[available online](http://www.scribd.com/doc/123365071/Friday-Lunchtime-Lectures-at-the-ODI-How-can-Open-Data-Revolutionise-your-Rail-Travel)**.

For an example of what can be done in terms of end-user applications, see **[Real Time Trains](http://www.realtimetrains.co.uk)** by Tom Cairns. There's also plenty of information **[on his blog](http://thomas-cairns.co.uk)** regarding the different data formats - and better, lots of relevant code **[on Github](https://github.com/swlines)**.

**[Peter Hicks](http://blog.poggs.com)** also has some **[useful code](https://github.com/poggs)** available, although seemingly focused on timetables rather than the live data. He gave a **[relevant talk](http://blog.poggs.com/2012/09/okfestival/)** last September in Helsinki that dives a bit more into licensing issues and so forth.

## My next step
I've got a much better idea what I'm doing than a couple of weeks ago, so I'm going to go out and start getting the data. Next post on this probably a few weeks away. **Thanks a lot to all mentioned for their help.**
