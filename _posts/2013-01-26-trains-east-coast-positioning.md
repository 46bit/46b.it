---
title: Trains and East Coast positioning data
tags: Data
layout: post
---

Back in 2011 I built TrainTrackr, a rapidly-built iOS app that worked together with a web interface **to track train journeys**. It seemed a brilliant way to tracing delays to trains and getting accurate data on their speeds along the route.
<!--more-->

One of the most regular train journeys I make is to head from Yorkshire to London on an East Coast service. It's at least a two hour journey, so I tend to get lots done.

Last year I noticed that **the Wifi login page displayed a position and speed for the train**. Fast forward some quick request monitoring and it turns out that **some [nice JSONP](https://www.ombord.info/api/jsonp/position/?callback=json) is available**.

``` javascript
> GET "https://www.ombord.info/api/jsonp/position/?callback=json"
json( {
  "version": "1.2",
  "time": "1359167756.0", // unix timestamp
  "age": "0",
  "latitude": "53.059942",
  "longitude": "-0.77284",
  "altitude": "31.1", // altitude in metres
  "speed": "33.171", // speed in metres/second
  "cmg": "134.68",
  "satellites": "12", // number of GPS signals being received
  "mode": "3"
});
```

It's actually quite awesome. **There's no authentication tokens to deal with**: if you're on the Wifi of an East Coast train then it's **updated in real-time**. If you're on the public internet, you get demo data.

The only niggle is that you can't remove the callback name to get truly valid JSON - some parentheses stick around. I also don't know what the `cmg` value is - let me know if you do.

Without planting Raspberry Pis to broadcast the data over the internet, it's **not as useful as a proper train-times system**. It *is* quite handy though if you want to pass a train journey hacking on something interesting.

I know the same Ombord system is used on other trains internationally, so this is worth trying on other services with Wifi as well. I'd love to hear if you get it working.

There's a private [API](https://datafeeds.networkrail.co.uk/ntrod/) for live train information now, but I don't know it's current status. I've heard literally nothing about it.

**UPDATE** (7th February 2012): I've now [written more about the Network Rail API](/2013/train-data-revisited/). If you're interested in more than just playing around whilst on East Coast trains it'll interest you more.
