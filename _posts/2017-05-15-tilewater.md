---
title: Tilewater, a miniature city builder.
layout: post
---

Tilewater is a little sandbox game I've built in Rust. It's a sandbox game, where you place roads and buildings and simulated people (*sims*) live out their lives in the world you've built.

Sims arrive by train, move into their <span style="padding: 0 6px; background: green; color: white; font-weight: bold;">houses</span>, visit <span style="padding: 0 6px; background: purple; color: white; font-weight: bold;">general stores</span> for their groceries, visit <span style="padding: 0 6px; background: blue; color: white; font-weight: bold;">saloons</span> to drink and find work, and then work in <span style="padding: 0 6px; background: red; color: white; font-weight: bold;">factories</span>. Play the video to see it in action:

<p><div style="position:relative;width:100%;height:0;padding-bottom:90.05%;"><iframe width='500' height='294' style="position:absolute;top:0;left:0;width:100%;height:100%;" src="https://www.youtube-nocookie.com/embed/Z_5WOXicQbc?rel=0&showinfo=0&modestbranding=1" frameborder="0"></iframe></div></p>
<!--more-->

It's still early days and I've been experimenting with sims building their own roads, more efficient pathfinding, and properly simulating an economy. The representation of buildings as `1x1` squares is something I find cute, and I plan to make them bigger on the inside than the outside similar to [Factorissimo](https://mods.factorio.com/mods/MagmaMcFry/Factorissimo).

Tilewater originated out of a bit of ennui. I submitted my dissertation, **[Time-lapse Extrapolation](https://r.46b.it/timelapse-extrapolation.pdf)**, last Tuesday. Getting it done was intense, as those of you who have done degrees no-doubt relate to. In the preceding weekend I'd worked 26 hours solid and then 14 or 16 the next, surrounded by 5 whiteboards and a useful [Trello board](https://trello.com/b/zybbxNTX/project-sections).

Suddenly I had a lot of free time! I slept and cycled and partied and had a great time. I'd been acting like a workaholic since March 22nd, and it takes time to fix that burnout. But after a few days started to feel a bit dissatisfied and aimless. So I took a project idea and ran with it. This time last year was when we started working on [sirpent](https://github.com/sirpent-team/sirpent-rust).

I've been watching a lot of Westworld lately, and I loved the idea of simulating frontier towns. In practice Tilewater is a long way from that idea, but having bandits run into town might happen in time.

I don't know how much further I'll develop Tilewater for the time being - I've been enjoying the sunshine and my books a bit more. But provided you're a little bit technical you can **[play Tilewater by following the directions on Github](https://github.com/46bit/tilewater)**.
