---
title: Introduction to Evolutionary Computing
tags: Hacking
layout: post
---
I took an Evolutionary Computation course last semester, [EVCO](https://www.cs.york.ac.uk/postgraduate/modules/evco.html). This is a family of techniques where you simulate evolution to find good solutions to problems. Let's watch an evolutionary process evolve vehicles that can get through a course:

<p style="text-align: center;"><iframe width="560" height="315" src="https://www.youtube.com/embed/uxourrlPlf8" frameborder="0" allowfullscreen></iframe></p>

I'd like to thank [Dr Daniel Franks](https://www.york.ac.uk/biology/research/ecology-evolution/daniel-franks/) for a great course, enthusiastic teaching and many of the examples here.

Let's say you want to learn an equation that approximates a function. This is a simple example - one of my `evco` examples [evolves Snake players](https://github.com/46bit/evco/blob/v0.2.1/examples/snake.rs). We'll use an evolutionary approach called Genetic Programming, which evolves trees representing expressions.<!--more--> So if you want to approximate some data you might:

1. Randomly generate a population of equations. Each equation forms a genome of sorts.
2. Test how good an approximation each equation ("individual") gives.
3. Select the best equations to take forward.
4. Simulate sexual reproduction by swapping some randomly chosen parts of equations.
5. Simulate random mutations by randomly changing some terms in the equations.

## How effective can this be? Impressively creative.

This process can be excellent at finding creative solutions. Over sufficient timescales biological evolution is remarkably creative - just look at your own body.

![**NASA [evolved this antenna](https://en.wikipedia.org/wiki/Evolved_antenna) for a 2006 mission.**](/assets/writing/evolved-antenna.jpg)

But I've found that tuning an evolutionary process is quite intensive: it takes a lot of programmer time and (the challenge) a lot of unguided experimentation.

Evolution often reaches local maxima: it isn't generating individuals which act in usefully different ways and so all individuals bottleneck around the same maximum fitness. As the best individuals are bred preferentially, when an innovation occurs the effect in improving average fitness can be dramatic. A biological example of this might be how life on Earth was single-celled for billions of years before multicellular eukaryotes came along.

Six months has taught me that Evolutionary Computing is quite time-intensive but a brilliant hobby. These processes are stochastic: while subject to random variation they can be analysed. A lot of computation and analysis is necessary to understand how well a process is working.

## Genetic Programming in Python with DEAP

York's course used the [DEAP](http://deap.readthedocs.io/en/master/) library for Python. This feels something of a hobbyist's tool: it contains implementations of the ingredients necessary for evolutionary computing but doesn't get overly sophisticated.

One drawback with DEAP is that a lot of examples and suggested tooling don't work well with PyPy. (PyPy is a Just In Time compiler that can run many times faster than the reference CPython implementation.) For the assessment we had to evolve automated snake players, and it proved frustrating how much potential efficiency was lost.

*As a hobby project I decided to see how far I could get implementing things in Rust. I'll talk some more about that tomorrow.*
