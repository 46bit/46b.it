---
title: How probable are 3 consecutive birthdays?
---
Have you ever wondered what the likelihood is of having three consecutive birthdays in a row? It's a fun excursion from the classical statisical brain teaser on the [birthday problem](http://en.wikipedia.org/wiki/Birthday_problem).
<!--more-->

To begin with we'll **consider the probability of a given three people - let's call them Alex, Brian and Catherine - having consecutive birthdays.** For those familiar with sets, we'll represent them with the set <math>P = \{ Alex, Brian, Catherine \}</math>.

## Making assumptions
To keep the Math reasonably simple, we'll make a few assumptions:

* Births [aren't evenly distributed](http://www.stanford.edu/~dgleich/notebook/2009/04/birthday_distribution.html) throughout the year, but we'll assume they are.
* We'll ignore leapyears and take a year as 365 days.
* We'll assume these three people are picked at random.

## Applying Combinatorics
Recall that we defined the set of the 3 people as <math>P = \{ Alex, Brian, Catherine \}</math>.

P can be *permuted* (ordered) in several different ways, for instance <math>( Brian, Alex, Catherine )</math> or <math>( Catherine, Alex, Brian )</math>. How many different permutations are there? Time for a little Combinatorics.

If you've done this thing before, recall there are <math>m!</math> ways to rearrange <math>m</math> elements. If you've no idea what I just said, take a look at [this explanation](http://math.stackexchange.com/questions/108812/how-many-ways-can-we-order-a-set-of-n-elements). There are <math>|\mathrm{P}| = 3</math> birthdays, so there are <math>3! = 3 \times 2 \times 1 = \mathbf{6}</math> permutations.

## Applying Probability
Thanks to the [addition rule](https://www.khanacademy.org/math/probability/independent-dependent-probability/addition_rule_probability/v/addition-rule-for-probability) we just need to find the probability of a single permutation. We'll consider <math>( Alex, Brian, Catherine )</math>:

* Alex's birthday can happen on *any day of the year*, with probability <math>\frac{365}{365} = 1</math>.
* Brian's birthday must happen on *the day after that of Alex*, with probability <math>\frac{1}{365}</math>.
* Catherine's must happen on *the day after that of Brian*, again with probability <math>\frac{1}{365}</math>.

These events are all independent, so we can just use the [multiplication rule](http://stattrek.com/probability/probability-rules.aspx) to find the chance of them all occurring:

<blockmath>\frac{365}{365} \times \frac{1}{365} \times \frac{1}{365} = \frac{1}{365^2} = 0.000007506\ldots</blockmath>

That's roughly a <math>0.00075\%</math> chance. Now let's account for the 6 permutations:

<blockmath>6 \times \frac{1}{365^2} = \frac{6}{365^2} = 0.00004503\ldots</blockmath>

<b>So the probability of three people having consecutive birthdays is roughly <math>0.0045\%</math>.</b>

## Applying this result to groups of people
The original Birthday problem ultimately concerns *how many people you need in a group for two or more of them to share birthdays*.

To do this for our similar problem the key is to use how many different groups of 3 people can arise from a group of <math>x</math> people. Where <math>^{n}C_{k}</math> represents these [k-combinations](http://en.wikipedia.org/wiki/Combinations#Number_of_k-combinations), plot the function:

<blockmath>x \in \mathbb{Z}, x \ge 3,\ y =\ ^{x}C_{3} \times \frac{6}{365^2}</blockmath>

Then find the first value of <math>x</math> where <math>y > 0.5</math>, and you've got the smallest number of people where it is probable for there to be three consecutive birthdays.

I'll leave this final step as an exercise for the reader.

## Footnote
You might get confused if trying to derive this. There are 4 different ways to make 3 days of birthdays as <math>( Alex, Brian, Catherine )</math>, depending on whether the second two birthdays are the day before or after. However since these 4 different ways are each only of <math>\frac{1}{4}</math> probability it all cancels out.

---

Many thanks to the wonderful people that reviewed drafts of this post: the statistical [Samuel Littley](https://www.toastwaffle.com), the inventive [Nemil Dalal](http://toys.dreamforge.me/users/nemild), the organised [Andy Bursh](https://twitter.com/AndyBursh), the clarifying [Isabell Long](http://issyl0.co.uk) &amp; the syntactical [David Kendal](http://dpk.io).

Any statistical shortcomings are the fault of [the author](https://46b.it/about/), Michael Mokrysz.

---

**UPDATE 1**: I noticed I'd missed out the 4 different ways the birthdays can arise, so corrected for that.

---

**UPDATE 2**: [Samuel Littley](https://www.toastwaffle.com) pointed out that whilst there are indeed 4 ways to make each triple, the probability of any specific one happening means that we divide by 4 again. Post updated with this reasoning.
