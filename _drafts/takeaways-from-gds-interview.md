---
title: Takeaways from GDS interview
layout: post
---

Leading up to the Government Digital Service interview today I'd been really, really nervous. Part of that is from post-dissertation burnout, but some of it results from my background. Most of the work I've done has been individual or in small teams, which naturally makes it harder to relate to competency-based questions. In practice I've been rather good at them on the spot because I have quite such a diversity and depth of experience, but I feel that the smaller environments mean team-related questions tend to lack a certain 'oomph' that I can definitely provide for more technical or sole-contributor-related questions.

What I did was to study the relevant Civil Service Competencies, summarising each in a few words and then taking each trait and relating an aspect of past experience. Surprisingly few experiences came up repeatedly, although a few experiences (such as the Cyberpracticals) had enough team-related difficulties, actions and successes that they acted as something of a 'catch-all'. Each competency went on an index card, largely in case I got stuck in the interview and needed a prompt. These summaries were a big help in answering larger, tougher questions because it meant I better understood the underlying experiences I could narrate.

As well as this I worked on doing more TDD. Right up until I started the coding test I wasn't sure whether to use Python or Rust, but I chose Python for two equal reasons. First, because the problem to be solved would be no easier in Rust for me. Second, because time spent narrating Rust to the interviewer would be time not spent narrating my abilities. If applying to teach software or as an expert in programming languages this would have been fine, but focusing on my strengths is better. One thing I tried to really cap my practicing was to build a REST API, using Python and Flask, in a TDD style. This was really quite difficult for me, for reasons largely unrelated to an API or REST. A certain level of boilerplate is needed for it to work, and in Python I struggled to find inspiration of how to reduce it. In Rust I didn't find convincing examples, with some relevant libraries expecting the passing of a query string as a string.

I think rapport went well, they got to the edge of my knowledge (scaling past the point of sharding, non-relational/geospatial/timeseries databases, key-value stores, and building efficient features such as Twitter's timeline.) They also seemed to respond well to my questions, and appreciate how narrative I was in the coding test. There were a few times where I was coding a quick few lines without narrating where it was going, which worked well given rapport but might not have worked well with a less engaged interviewer.

> I definitely didn’t know everything I was asked in the interview but being prompted allows you to realise you know more than you think you do.
>
> &mdash;[Digital People: Michaela Benyohai, Tech Lead for data at GDS](https://digitalpeople.blog.gov.uk/2017/03/08/digital-people-michaela-benyohai-developer-for-data-at-gds/)

It's true. A few times, when it comes to the benefits of splitting things out into separate tables vs embedding them in a single document, I found my knowledge while talking through something else.

Something interviews aren't very good for is teaching exact terminology. I couldn't describe SQL databases in terms of the various concepts, more how they are used. Databases in general are definitely something I should get stronger with.

I guess I'll see next week if I get a Developer position. Fingers, toes, everything crossed. The panel definitely got a fair impression of me, so whereas sometimes a bad interview makes you miserable when you get declined I think I'd find this relatively empowering provided I could get feedback on the areas that GDS and similar orgs would like me to demonstrate more of.

**Coding interview points**

* Always be talking about how and why, including things like the design space you're architecting it within and keeping clearing up any ambiguities.
* Ask about whether they'd like you to refactor or keep implementing
* Write types, but no implementation, then write tests, then write implementations.
* It's best to start with a straightforward representation of state, and at some point you might start feeling like your state representations are largely working around its issues. At that point you might be too short on time to properly resolve things, so give the interviewer your best impression of how to change the state representation to remove those transformations and offer them the choice between doing that refactoring and continuing with the spec.
