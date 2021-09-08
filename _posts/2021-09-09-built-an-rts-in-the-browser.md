---
title: I built a real-time strategy game in the browser
layout: post
---

As a child I loved real-time strategy (RTS) games. A large and fairly open world, several players, competition for resources, and a goal of producing armies to conquer my opponents. Something about the mix of freedom and strategy was an absolute joy to me.

Games like Rise of Nations and Supreme Commander showed me how powerful computers could be. Some of my first serious programming was building community projects like gametags or modding tools.

I always wanted to build my own RTS game from scratch. Master all the different things needed: game design, engine design, graphics design, efficient pathfinding. It's taken a long time to get there, partly because I don't like C++.

Due to the pandemic, I had enough time last year to realise this old dream. Now that I've been making my blog more active it's time to share it properly.

## The game

My game is called [RTT](https://rtt.46b.it). Here's a preview:

<iframe src="https://rtt.46b.it/demo.html" style="width: 100%; aspect-ratio: 1/1; border: none; pointer-events: none; display: inline-block;"></iframe>

[RTT](https://rtt.46b.it) contains all the key elements of an RTS game: resource collection, unit production, AIs, obstacles, realistic pathfinding. And it runs completely in the browser! The engine is written in TypeScript. Pathfinding is done with a mix of my own routines and the [navmesh](https://github.com/mikewesthad/navmesh) npm library. It's rendered using ThreeJS, WebGL and GLSL.

There are several different types of units. Small engineers that can go build structures or collide with enemies. Larger tanks that spray out projectiles. Artillery that sends slow, powerful projectiles. And laser tanks that do exactly what it sounds like.

Getting it performant in multiple browsers has been hell. For a long time I was close to giving up. Even once I'd dealt with the worst-profiling code, and done things like caching paths, performance inside browsers varies a lot. My 6-year-old MacBook Pro with integrated graphics runs well now, and that's something I'm very proud of.

There's no proper UI right now, so all the players are AIs. There's some difficult problems taking it further, that I'll take about another day. But you can click-drag to select units and right-click to move them. [Go have a play!](https://rtt.46b.it)
