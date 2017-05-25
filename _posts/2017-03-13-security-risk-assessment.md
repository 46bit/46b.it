---
title: Security Risk Assessments of Semi-Autonomous Vehicles
tags: York
layout: post
hide: yes
---
I'm in my 4<sup>th</sup> year at York, the Masters year of my MEng Computer Science degree. This term I've taken the Topics in Privacy and Security (PSEC) module, which takes a wide technical swath through privacy and security issues. But the assessment is mostly focused on password cracking and doing a security risk assessment for automated road convoys.

We're assessing how to bring an EU-funded project, [SARTRE](https://en.wikipedia.org/wiki/Safe_Road_Trains_for_the_Environment), to market. The concept, "Safe Road Trains for the Environment," allows an equipped car to automatically follow ~6m behind a Lead Vehicle. You could sit back and watch a movie&mdash;er, do productive work.

<img src="/assets/sartre-drivers-doing-activities.png" alt="SARTRE following drivers doing immersive non-driving tasks" width="600">
<!--more-->

## Risks/viability of commercial deployment

Deploying this commercially is to move from a proof-of-concept to a live system. The most immediate issue I've identified is with this concept of following drivers not paying attention to the road: in the demonstrator, following vehicles had professional drivers who were paying attention.

On an actual highway unexpected things happen. If the platoon (convoy) is to return control to drivers should a sudden, unexpected thing happen then drivers cannot be doing other activities - they need road awareness.

The Parliamentary Science and Technology Office came up with a [classification system for automated road vehicles.](http://researchbriefings.parliament.uk/ResearchBriefing/Summary/POST-PN-443) *Under this classification the proof-of-concept only meets the concept of Partial Autonomy.*

<img src="/assets/hoc-autonomous-vehicle-levels.png" alt="UK Parliamentary Office of Science and Technology Analysis of scales of vehicle autonomy">

*Drivers not having to be attentive is classed as High Autonomy.* As with my musings, they've identified it as a hard step to take.

The demonstrator dissolved convoys by having vehicles automatically back off to 50m separations and 50km/h speeds. Thus drivers could regain control in a gentle manner. Sadly this isn't all that practical - in my opinion - on the road.

## Collective vs Individual appeal

The European Commision sees a major advantage of this project being reduced carbon emissions. The slipstream from vehicles a few metres ahead reduces the fuel used by vehicles in the platoon.

The reduced fuel usage appeals to all drivers in the form of lower costs. That is, it has individualistic appeal. Having the necessary equipment fitted can apparently pay itself back within 3 years on trucks - if produced at scale something similar seems plausible for cars.

Reducing CO<sub>2</sub> emissions is still more of a collective issue. As Europeans we're seeing oddities in the climate but not particularly as a critical issue every day. I suspect when it becomes a more individually-obvious issue there will finally be the will to take serious action, but at that point it may be too late to try anything but climate engineering.

The problem for this project is that to the public, reduced fuel usage might not be worth the attention costs. If drivers are automatically monitored for paying attention to the road it is plausible to keep them attentive or evict them from a platoon. But staying immersed in the road environment when taking no action would be very tedious over long periods. As such I don't think people will go for the project in high numbers unless this issue of having to pay constant attention is resolved.

## Summing up

It isn't clear how directly this is being taken further in the real world. But it's a nice model for semi-automated road vehicles, if only the emergency recovery of control can be worked out.

I've spent quite awhile with security-related topics before but this is my first time doing risk assessment exercises. I appreciate this work a lot more now. It can be dull, but that's because it involves a lot of gathering information before any serious analysis can be done. That this is the first such exercise I've performed naturally means I'm being conservative in how I go about it - in real-life there'd be more freedom to do more iterations and get solid facts.
