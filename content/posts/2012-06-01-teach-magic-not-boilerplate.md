---
title: Teach magic not boilerplate
---

I address this to anyone trying to teach programming: hobbyists, University academics and school teachers.

## Don't try to teach Java to potential programmers.

To someone who has never looked into programming before, it's surprisingly intimidating. Getting to grips with it takes a while. Yet for someone who's interested you'll continue just because it's such incredible *fun*.
<!--more-->

<pre data-lang="java">class Program {
  public static main (String[] args) {
    System.out.println("Hello world.");
  }
}</pre>

That's *Hello world* in Java. 5 lines where only one actually makes any sense. Let alone the compilation and execution commands. You might think this is wonderful: they'll run off and look into the others. The reality is that it looks like nonsense. There's more important things for fresh programmers to learn than OOP.

Let's try Ruby. (Or Python, Scheme or a number of other 'simpler' languages.)

<pre data-lang="ruby">$ irb
> puts "Hello world."
Hello world.
=> nil
> </pre>

Look at that last `>`. It's *begging* you to type something for instant gratification (hence why I still love using [iREPL](http://irepl.im)). Yet it's still got everything you want to talk about deeper things.

<pre data-lang="ruby">> def fib n
>   return 1 if n < 2
>   return fib(n-1) + fib(n-2)
>   end
=> nil
> fib 5
=> 8
> fib 533
</pre>

Feel free to talk about recursion and explain why that `fib 533` is going to take a long time or hit a stack overflow. Then about how to better calculate Fibonacci numbers and about a bit of complexity theory. Then discuss a slightly more non-trivial problem. I'll steal one from [Greplin](https://www.greplin.com)'s application challenge.

> [...] Write code to find the first prime fibonacci number larger than a given minimum.  For example, the first prime fibonacci number larger than 10 is 13.

> &mdash; [Greplin Programming Challenge](http://challenge.greplin.com)

Set your students solving this to develop their problem solving skills. Have fun.
