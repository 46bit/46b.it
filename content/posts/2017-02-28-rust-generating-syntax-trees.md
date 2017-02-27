---
title: Generating syntax trees in Rust
tags: Hacking
---
I've been writing a lot of Rust. Since [\@Taneb](https://github.com/Taneb) persuaded me to try it the language has grown phenomenally on me. I've always shied away from getting too attached to tools and focused more on systems but for the first time since my early Ruby days I've become a language fanboy.

While building my [Genetic Programming](https://github.com/46bit/evco) library I needed a convenient way to represent and generate syntax trees. More than anything I wanted users to write a minimum of code. I used an **interesting but problematic** Recursive Enum approach that's worth discussing.

``` rust
enum Equation {
    Add(Box<Equation>, Box<Equation>), // l + r
    Sub(Box<Equation>, Box<Equation>), // l - r
    Mul(Box<Equation>, Box<Equation>), // l × r
    Div(Box<Equation>, Box<Equation>), // l ÷ r
    Float(f64), // n
}
```

This is a very neat representation of a syntax tree for basic mathematics. One can express math quite simply:
<!--more-->

``` rust
use Equation::*;

// (17.2 × 50.0) ÷ (9.0 - 1.5)
let eq =
  Div(
    box Mul(
      box Float(17.2),
      box Float(50.0)
    ),
    Sub(
      box Float(9.0),
      box Float(1.5)
    )
  );
```

Now we want to evaluate a tree into an output `f64`. Here's a simple recursion:

``` rust
impl Equation {
    fn eval(&self) -> f64 {
        match *self {
            Add(ref left, ref right) => left.eval() + right.eval(),
            Sub(ref left, ref right) => left.eval() - right.eval(),
            Mul(ref left, ref right) => left.eval() * right.eval(),
            // In practice I tend to implement a `protectedDiv` which avoids `NaN`.
            Div(ref left, ref right) => left.eval() / right.eval(),
            Float(n) => n,
        }
    }
}
```

## Taking inputs

But the tree has a fixed value! That sucks. Let's make it a real equation:

``` rust
enum Equation {
    Add(Box<Equation>, Box<Equation>), // l + r
    Sub(Box<Equation>, Box<Equation>), // l - r
    Mul(Box<Equation>, Box<Equation>), // l × r
    Div(Box<Equation>, Box<Equation>), // l ÷ r
    Float(f64), // n
    Input,
}

impl Equation {
    // Eval now takes an input!
    fn eval(&self, input: f64) -> f64 {
        match *self {
            Add(ref left, ref right) => left.eval(input) + right.eval(input),
            Sub(ref left, ref right) => left.eval(input) - right.eval(input),
            Mul(ref left, ref right) => left.eval(input) * right.eval(input),
            // In practice I tend to implement a `protectedDiv` which avoids `NaN`.
            Div(ref left, ref right) => left.eval(input) / right.eval(input),
            Float(n) => n,
            Input => input,
        }
    }
}
```

## Going generic with `Evaluable`

We can implement a trait to represent an evaluable type and implement it this way. I'm considering an approach like this to genericise over tree-based genetic agents and other forms.

``` rust
trait Evaluable {
    type Input;
    type Output;

    fn eval(&self, input: Self::Input) -> Self::Output;
}

impl Evaluable for Equation {
    type Input = f64;
    type Output = f64;

    fn eval(&self, input: f64) -> f64 {
        match *self {
            Add(ref left, ref right) => left.eval(input) + right.eval(input),
            Sub(ref left, ref right) => left.eval(input) - right.eval(input),
            Mul(ref left, ref right) => left.eval(input) * right.eval(input),
            // In practice I tend to implement a `protectedDiv` which avoids `NaN`.
            Div(ref left, ref right) => left.eval(input) / right.eval(input),
            Float(n) => n,
            Input => input,
        }
    }
}
```

## Generation

Say we implement a function to generate a random nonterminal and a function to generate a random terminal. A new type that chooses whether to generate a nonterminal or terminal can then control various properties of generated trees. The details are a bit too lengthy to put here but this is something that [evco's `Tree` and `TreeGen`](https://docs.rs/evco/0.2.1/evco/gp/tree/index.html) quite carefully perform.

## Practical implementation

I find this approach very pretty but it's quite unsuitable to expect other people to implement to use a library. It's [at least 50 ugly lines of code](https://github.com/46bit/evco/blob/669dc40d2e4e3681e0f3d0c97c70fb0157784886/examples/symbolic_regression.rs#L27-L100) for users of my library to implement methods to generate the tree.

Having other people implement these methods also removes much hope of keeping things tail-recursive. Recursive datastructures are notorious for operations upon them blowing the stack and crashing the program.

I implemented tail-recursive iteration [inside the library](https://github.com/46bit/evco/blob/669dc40d2e4e3681e0f3d0c97c70fb0157784886/src/gp/tree/mod.rs#L98-L121) but it's too complex for third-parties to replicate without risking bugs.

## Custom derive

One way around this issue of people having to implement tedious methods is [a custom derivation](https://doc.rust-lang.org/book/procedural-macros.html) (`proc_macro_derive`.) The macro could analyse the types in the tree, identify enum variants as terminal vs nonterminal, and generate the methods accordingly.

This has implementation questions. A typical program doesn't want to be provided with a random `f64` - it wants one in a particular range. So we could require users to implement new types to wrap that, or allow attributes to mark the range to use:

``` rust
#[derive(GeneratableTree)]
enum Equation {
    Add(Box<Equation>, Box<Equation>), // l + r
    Sub(Box<Equation>, Box<Equation>), // l - r
    Mul(Box<Equation>, Box<Equation>), // l × r
    Div(Box<Equation>, Box<Equation>), // l ÷ r
    #[evco(range = "-10..10")]
    Float(f64), // n
}
```

## Alternative, better implementations

The biggest irritation with the datastructure is that accessing a particular node takes `O(n)` operations because you have to traverse the entire tree to find it.

One can take an approach like a [B-tree](https://en.wikipedia.org/wiki/B-tree) to optimise searching for elements. Sadly this doesn't suit evolutionary computation very much: mutation is about as common as accessing and trees cannot be rebalanced.

So it would be better to store trees as something other than a recursive datastructure where each node is in its own allocated memory.

## Heap

A common means of representing trees on a computer is a [Heap datastructure](https://en.wikipedia.org/wiki/Heap_(data_structure)). This structures nodes into an array thus getting better cache locality, quicker access times, etc. The problem is that the enum we have is inherently a recursive structure.

Let's try this:

``` rust
enum Equation {
    Add(f64, f64), // l + r
    Sub(f64, f64), // l - r
    Mul(f64, f64), // l × r
    Div(f64, f64), // l ÷ r
    Float(f64), // n
}
```

We could build and evaluate variants as we go, using this and the heap. But how do we indicate stored data versus arguments? We could supply stored data as a reference maybe?

``` rust
enum Equation {
    Add(f64, f64), // l + r
    Sub(f64, f64), // l - r
    Mul(f64, f64), // l × r
    Div(f64, f64), // l ÷ r
    Float(&f64), // n
}
```

This isn't very pretty. One option would be that `f64` inherently is generated and `Float` becomes unnecessary.

## Types

A further issue to consider: none of this uses generic types. All this only passes around `f64` and nothing else. I guess we could indicate return types by requiring mutable pointers? The code to make this work might be ugly but it'll be custom derived after all.

This allows specifying return type of each node, but generation logic would have to specify the tree's root node to get a consistent type out the top of the trees:

``` rust
enum Equation {
    Add(f64, f64, &mut f64), // l + r
    Sub(f64, f64, &mut f64), // l - r
    Mul(f64, f64, &mut f64), // l × r
    Div(f64, f64, &mut f64), // l ÷ r
    IfEq(f64, f64, &mut bool),
}
```

It's a pain.
