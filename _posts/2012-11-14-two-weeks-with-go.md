---
title: 'Two weeks with Go: an initial review'
tags: Hacking
layout: post
---
As someone who grew up with scripting languages, C and it's closer brethren always felt incredibly backward. The result of all their decades of history seems to be that obscure compiler flags and awkward syntax are an affectation of the entire community. I don't care for it, much as I like how fast the code can execute.
<!--more-->

What I want is a performant language, but one that doesn't seem like an argument towards becoming an Assembly hacker. So recently, I've been trying out a language called [Go](http://golang.org), released in 2009 by Google. It's billed as **a pleasantly modern language** that balances high performance with programmer productivity.

Here's a simple "Hello World"-style example:

``` go
package main

import "fmt"
import "strconv"

func main () {
  for i := 0; i < 12; i++ {
    fmt.Println("factorial(" + strconv.Itoa(i) + ") =", factorial(i))
  }
}

func factorial (of int) int {
  if of < 1 {
    return 1
  }
  return of * factorial(of - 1)
}
```

As opposed to having to free memory yourself everywhere, **Go has robust garbage collection**. No more deallocating memory, yet you still have plenty of power - if you want to use them, Pointers are still here.

What isn't present is more interesting. The object orientation is relatively light: there's little/no real sub-classing, everything is done from interfaces. There's also no generics: you can't ask for an interface in a function, you have to ask for a specific type. This means more code duplication, although there are some specific use-cases for genericness built into the language where sensible. The error model isn't exactly exceptions, either.

I've mostly been focusing on taking advantage of Go's [math/big](http://golang.org/pkg/math/big/) library so far, [playing with](https://github.com/46Bit/the-go-sandpit/) calculating decimal places of &pi;. The language is aimed more at systems than Math, but it's a place to start.

My next step is going to be parallelization. This is one of the things I've heard discussed most about Go. Rather than give you access to the underlying threads, Go tries to manage it for you automatically using [goroutines](http://golang.org/doc/effective_go.html#goroutines): when something blocks, other functions are executing concurrently wherever possible. At the moment I'm not taking advantage of goroutines at all, but I'll come back with my thoughts in a few weeks time.

**If you'd like to try Go out, try the [tutorial-as-REPL](http://tour.golang.org)**. Otherwise for OS X users, it's just a `brew install go` and `go build ./hello_world.go` away - have a play.

