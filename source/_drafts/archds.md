---
title: Archaeology Data Service
layout: post
---

Since I came back to York I have been focused on skills rather than experience, and I've sought to learn about the Geospatial and Security areas. [ADS and UOY]

I've had a slightly extended University career. Partly by choice and partly because of



 From April 2015 to January 2016 I took a leave-of-absence. I'd rather not go into the numerous causes here, but it was simply not possible to finish my 3rd year in any representative way. While my LoA officially began in April, the January exams stand out in my mind as something of a "last hurrah" for me being up to getting work done. T'was a difficult time.

In May 2015 I was taking a little time out of University. Recurring issues

Naturally I wanted to make best use of this recuperation time, and on the University's Careers job postings I found an internship post in the Archaeology department - in particular the Archaeology Data Service, a Digital Repository for Archaeological Data. I've often thought of my technology expertise as an empowering tool to bring to other disciplines, something that exposes me to domains with their own experts and lets me pick up a little of their domain knowledge. I'd also befriended some humanities people and was very eager to understand a little more of their worldview.

The job ad was somewhat vague. They didn't seem to be expecting a particularly talented engineer so much as someone who would be able to approach the problem - a sensible, pragmatic approach when seeking an intern, I dare say.

I was a little concerned about what the technology and mindset might be like, as I'd seen horrible IT environments in the past where it was evident that Open Source and things like Version Control had yet to be discovered, but from the interview I was extremely charmed:

1. King's Manor. York is an incredibly historic city: as a resident I use the 3 miles of Medieval-albeit-renovated city walls as a shortcut, have to dodge tourists on the ancient cobbled streets, and we've various bits of Roman remains or even walls still standing. Even given all that, the University of York's King's Manor campus is something else. The oldest bits of the building date back some 500 years, which to my eternal surprise given my industry means I've worked in a building older than my school.
2. The people. I don't know whether because ADS hire people from Archaeology who therefore live the dream, or it's an ADS-specific thing, but it is easily one of the warmest and seemingly least ego-driven organisations I have worked for. Despite this, a lot of people there seemed to deliver under quite sustained workloads. Part of why I started to first pay serious attention to the issue of under-representation of women in engineering was related to this.
3. Building geospatial skills. I had played around with QGIS and various other bits of geospatial software before and felt entirely out of my depth. This internship meant I got to *deliver* something quite involved, with help and feedback from people who had done GIS every day for years. In addition the prospect of bringing my deeper-than-perhaps-expected skills to bear excited me, as it meant that the manual work might be minimised and hopefully the productivity maximised.

The task was to

I did an internship at the Archaeology Data Service, trying to (in casual parlance) resurrect some old online maps. The complexity of this was really quite extreme: ADS had only two screenshots of the old mapping interface, and the formats used for the data were a mix of scattered, undocumented or partially incorrect. This was essentially reverse engineering but given the context I'd describe it as something of a Digital Archaeology project.

There was a lot of data and a lot of archaeological field works to ideally port, so I built quite a few general-purpose Python tools (each doing as small a job as possible) to perform the task. These were knitted together by shell scripts for each set of maps, and the mid-point in the scripts was generating canonical JSON descriptions of each map and the locations of the shapefiles, raster images, etc it contained.

When building this system I thought of it as a graph of little tasks being orchestrated together. Some data processing frameworks like Airflow encode this very representation, and I think their structure might have saved me time. But consider the organisation: the pure technical people at ADS have very constrained time and couldn't maintain it.

<!--If working in a bigger engineering organisation I'd happily use a data processing framework. If there were hard performance requirements and you couldn't just buy more servers I'd happily code an asynchronous service. However a little academic department doesn't have the technical throughput to maintain it.

The If you have devops or an ops team I'll happily use such a data processing framework; if you have hard performance requirements and can't just buy more servers I'll happily code an asynchronous server. But if you're a little academic department, working on a problem caused by a company killing off their own technology? I best use so

Nah. Use things that have enough momentum to be around and supported by the community in 10 or 15 years so they don't have to hire an intern to fix things. Something we discussed quite a bit was how to -->


This JSON was used by the website mapping interface, and to import the data as described next. The script then imported these images into PostGIS (for data storage) and GeoServer (to serve the map tile images.) In reality this import process was not quite so decoupled: the numerous ambiguities and errors meant that many of the database migration scripts were coupled to the source data. Few of these dependencies could be resolved without significant further engineering.

Importing into GeoServer was somewhat tricky: it has an API, but it seems a thin and inconsistent layer around its Java internals. I spent a fair amount of time creating layers manually to then see how the API described them - and then puzzling over why inserting that same JSON did not work. Having said this, I must commend the GeoServer project. For insertion the API does feel

A major difficulty with reverse-engineering was that the past ESRI software could support far more sophisticated maps. As such there were features specified in the XML whose functions I could barely guess at. Many could be understood by examining the map within which they were used: dealing with issues like this was mostly done by reviewing the outputted maps. Manual review on large datasets like this is an error-prone process, but one that perhaps sufficed when it was enough that the resulting maps were essentially accurate and *gave a good explanation of the archaeological sites.*

 More recently
