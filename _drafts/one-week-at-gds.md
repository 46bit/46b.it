---
title: 'One week at GDS'
layout: post
---
I've been at the Government Digital Service for (almost!) a week now. I've joined the [GOV.UK Platform as a Service](https://www.cloud.service.gov.uk) team as a Developer. We're building and operating a specialised [PaaS](https://en.wikipedia.org/wiki/Platform_as_a_service) for government. At first I was surprised this would be done in-house rather than with an external company, but I've been lead a bit into the hard experience behind making it.

<!-- First thing first: being new at a large organisation is terrifying. There are hundreds of people on (I think) dozens of teams and all of them have a bit better idea what's what than you. Coming from a long sequence of smaller organisations this blew me off my feet a little the first few days. -->

I've been aware of GDS since its early days but for a long time I've been focused on other things (startups, Computer Science, getting well, …). Joining a larger organisation was a deliberate choice to get out of my comfort zone, as I feel like my technical growth at small orgs has plateued but my communication skills have continued to grow.

<!-- but it might not have happened at all without the support of a lot of people. - Issy Long, Nemil Dalal, Ben Wright, Thayer Prime, Laurence Smith, Chongyang Shi, Kate Whalen, Jess and Chris Schmidt and the lovely folks at Archaeology Data Service and SWEY. -->

A number of people have written about their time at GDS but it can be hard to find (or even to be sure it discusses the right country!) While wondering whether to apply I went looking and happened across Alice Bartlett's 2014 [Six months at GDS](http://alicebartlett.co.uk/blog/six-months-at-gds) post. She describes the shock of going from a small to big organisation, and yet it was clear that things settled down and she's done great things since. In some ways I don't have very much to add to that post.

GDS moved from Holborn to Whitechapel on Monday and I started there on Tuesday. This has had upsides (I was able to help some people on day 1 because I'd read the building floor plans when on holiday) and downsides (due to the chaos I only found out my team the day before I started, eep.) The new office seems nice - somewhat less central than Aviation House in Holborn was, but far more modern and suitable.

1. Tuesday: I didn't sleep very well before my first day. I met my team and remembered one or two names, but I was somewhat overwhelmed by trying to get used to the wider organisation and office. The head of our Government as a Platform section gave a talk on who, what and why it was and I managed to contribute a little. Issy calmed my nerves a little after work.
2. Wednesday: I slept really well before my second day. I remembered a couple of names but honestly not those I needed to. My anxiety level had fallen and I was able to think things through. Inbetween lots of onboarding and civil service tasks, I went to a learning lunch about agile at GDS that started to make sense to me. I've long been sold on the value of many items on the agile manifesto, but I could never understand why the document as a whole was a culture rather than a cult. This session gave me the flash of how items on it can feed together to be worth much more than the sum of their parts. Our User Researcher, Holly, presented research about billing options and then explained a lot of her role contributes and how things work! Then I went to an event about real-time web systems at Pusher, which was really quite helpful in understanding the design space I'm playing within in some Rust hobby projects.
3. Thursday: Lee walked me through how we test the database support we offer, with integration tests ensuring the whole system works as expected. Our Delivery Manager returned and further taught me a bunch about how the team works together. I put myself forward to help with some research for how users should configure applications to use our MySQL support, and Dan helped me with the basics of our PaaS. I went to Aqua Shard to celebrate family things (at this point I really felt like I needed my evenings back).
4. Friday: I started to really learn the ropes, now having enough of a sense of things to ask dumb/nervous questions.

<!--
 ranged from straightforward to terrifying and I was really too anxious to think everything through at the time.
2. Day 2 my anxiety level had fallen enough to start thinking everything through… in 3.5 pages of writing done because I couldn't sleep.
3. Day 3 and 4 I'd gotten some enlightenment from a lunchtime learning session on agile, being wowed by having an actual and enthusiastic User Researcher and realising what their role is in terms of delivery, and being taken under the wing as regards how the team works by our awesome Delivery Manager.

I'm on the GOV.UK Platform as a Service team. We're building and operating a service that handles deployment and running government services - something like a specialised Heroku. It might seem unusual we'd do this in-house but from what I understand this was a natural decision from past experience. The result of running such a service is that we're a mixed technical team: half of us are Developers and half are Web Operations. With pairing, debating and knowledge sharing our disciplines together work well building something like this.
-->

Towards the end of my course I had a difficult time deciding what would be a step up. At Dreamforge (as at hackdays and) we'd done remarkably technically impressive things, but mostly by flying by the seat of our pants. At Archaeology Data Service I did some really neat conversion work that I thought out much more, and found it a much saner and more representative atmosphere.

I've been interested in representation for a mix of reasons. I noticed right from the start of my career how draining I found male-dominated environments, but it took years to figure out what I was feeling: I found myself acting different to fit in and it takes consistent effort to resist that. I've also noticed that nerdy, talented female or LGBTQ friends often took a different and perhaps shallower path, sometimes getting put off or heading in other directions. While GDS seems to have some way to go in reaching gender parity, people here clearly appreciate its importance.

I really wanted a large company for my next stage. I don't know if my communication skills were really sufficient in the past, as I've was more naturally geared towards small, personal interactions, but I've deliberately grown around that to the point that it has gone well and I've grown comfortable asking questions without worrying they might be interpreted as dumb.

[IT'S OKAY (and I should stick some up by my desk for me and when other newbies start)]

[PaaS hand signals (and I should learn them)]

## Starting at GDS

I've taken an unconventionally conventional career path thus far. As of next Wednesday I'll have graduated from a MEng Computer Science at York. But I've made that last six entire years: 18 months of that as the lead engineer of a Y Combinator startup doing awesome 'in-browser CAD for 3D printing' work, 12 months of that on medical leave and working part-time to save Archaeological data,
 some incredibly difficult, awesome work

The big question for the last year was what to do next. A big part of me wanted to go back to small companies and startups - an environment I knew, but also an environment I didn't feel like I had very much left to learn from. If I wanted to 'do my own startup' then it would be a good idea, but I know much more about that environment now and the point it could appeal to me again is not now.

I also found that I was no longer an ideal fit for smaller companies. Generally they were seeking particular skills, ones I'd used quite a bit but not recently (in the last year I've written Rust, Python, MATLAB), and didn't seem themselves equipped to make good use of me. I think there's also a large amount of confusion as to where exactly to place me.

Thus I looked at larger organisations. I talked to a lot, applied to a dozen, and refined things down to two compelling options: The Guardian and GDS.

It was a p

Moving office and holidays meant I only found out what team I was on last minute: GOV.UK Platform-as-a-Service (GOV.UK PaaS for short.) This is a CloudFoundry deployment to run government web applications in a managed environment - relatively similar to running it on Heroku, for instance. The benefits immediately apparent are that the wrapper enables them to switch cloud supplier and allows them to enforce necessary security when running Government things. I think there's a great deal I can learn in this team, but also that it should play to my strengths.
