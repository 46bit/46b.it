---
title: A first look at Quantum Computers
tags: Comp Sci
layout: post
---
The computer in front of you is pretty powerful, but it can't factor a 600-digit number before Earth gets cooked by the Sun. No supercomputer humanity does or could build could do that either, so it seemed a sure bet to base the security of some encryption schemes on factoring being (exponentially) hard.
<!--more-->

A quantum computer of sufficient size could do it using [Shor's algorithm](http://en.wikipedia.org/wiki/Shor%27s_algorithm). It could also allow you to simulate n-body problems in reasonable (polynomial) time. Thus you could break RSA encryption or simulate the interior of the sun right down to the sub-atomic scale.

If you've ever looked at Physics like the two-slit experiment, what follows might seem a little reminiscent. That's because it is.

## A hardwired machine
In the early days, computers were often programmed by altering their wiring. Instead of running a program stored on disk, computers like [ENIAC](http://en.wikipedia.org/wiki/ENIAC) had a number of units that were manually patched together every time you wanted to run a different program. You'd wire a floating-point multiplier up to vacuum tubes with it's input, then wire the output up to the next stage.

The model of quantum computers looks a lot like that. You're not going to sit in front of a quantum computer and write some C++ to define the program to run: rather you'll have to wire it up for every different program. It's not quite as simple as a metal wire either, since you've got to be very careful to not destroy the quantum effects you look to exploit.

I think it should be possible for a 2nd or 3rd generation computer to have this wiring quickly done by another computer, such that you could have most of the benefits of stored-programs. I speculate this mode of operation would be similar to programming modern FPGAs using VHDL, but I've not looked for research in this area yet.

## What the flip is a qubit?
A lot of people have heard that the quantum computer's form of a `bit` is called a `qubit`. The principle behind them is relatively simple to read about but harder (as with everything in quantum mechanics) to appreciate.

An ordinary `bit` is either 0 or 1. There's no middle ground. A `qubit` on the other hand can be both 0 and 1 right up until the moment you observe it. There's a probability you'll observe it as a 0, and another probability you'll observe a 1. This probability as to which state it's in is called superposition.

How you'd observe a `qubit` depends on your implementation of them, but it amounts to when you have an instrument measure their value. This measurement collapses the qubit into a classical state, so if you read the qubit again you'll read the same value as you did earlier.

Stopping this collapse into classical state from happening to the qubits whilst you're computing is known as quantum decoherence. It's one of the greatest problems to building a practical quantum computer.

That's it for a quick introduction. I've had to skip [entanglement](http://en.wikipedia.org/wiki/Quantum_entanglement) for now until I'm a bit more comfortable explaining it from the point of view of quantum computation. Possible algorithms, some Math and implementation detail discussion is what I'll start to discuss next time.
