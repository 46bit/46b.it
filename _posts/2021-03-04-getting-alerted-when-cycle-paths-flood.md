---
title: 'Getting alerted when cycle paths flood'
layout: post
---

I recently moved back to York, a city I absolutely love. One of the best things about living here is cycling. But York has two rivers, one of which brings rain from hills a long way away. Some of the best cycle routes can flood after rainfall when the rivers rise.
<!--more-->

There is already a very useful website for seeing which routes in York are flooded: [nosearmy.com/isitflooded/](http://nosearmy.com/isitflooded/). But it's annoying having to check my phone before I go cycling–especially when I'm trying to quickly fit six miles in at lunchtime. I'd rather get alerts when cycle paths flood.

I have a Grafana and Prometheus monitoring stack, so I'm going to use those to notify me. This makes sense if you're an engineer with DevOps skills; less so for an ordinary person.

## Where to find data on river water levels

To do this I'm going to use freely available River Level data from the Environment Agency. Data for York's main river level station, Viking Recorder, is online at [check-for-flooding.service.gov.uk/station/8208](https://check-for-flooding.service.gov.uk/station/8208).

There's also an API. It uses different ID numbers, but you can translate IDs. The `RLOIid` field on [environment.data.gov.uk/flood-monitoring/id/stations?_limit=50000](https://environment.data.gov.uk/flood-monitoring/id/stations?_limit=50000) matches the human-readable pages, and the `wiskiID` field is what to use for the API.

You can then fetch the latest river level reading for your station from [environment.data.gov.uk/flood-monitoring/id/stations/L2406.json](https://environment.data.gov.uk/flood-monitoring/id/stations/L2406.json). There's a few API endpoints to choose from but this one has the most metadata.

## How to get the data into Prometheus

Next challenge is how to get this into Prometheus. The river level API returns JSON, so we can use the off-the-shelf [github.com/prometheus-community/json_exporter](https://github.com/prometheus-community/json_exporter).

There are many different choices in how to file metrics from this JSON. I've ended up assuming there'll only be one `latestReading` for each station–that's true at this station, but you should see if it's true for yours.

The final config I've made for the json exporter is:

```
---
metrics:
- name: river_level
  path: "{ .items }"
  type: object
  values:
    measurement: "{ .measures[*].latestReading.value }"
    max_on_record: "{ .stageScale.maxOnRecord.value }"
    min_on_record: "{ .stageScale.minOnRecord.value }"
  labels:
    rloi_id: "{ .RLOIid }"
    wiski_id: "{ .wiskiID }"
    name: "{ .label }"
    town: "{ .town }"
```

Start up the JSON Exporter using that config:

```
$ ./json_exporter --config.file config.yml &
[…]
```

Then scrape the exporter, providing the station data URL:

```
$ curl "http://localhost:7979/probe?target=https://environment.data.gov.uk/flood-monitoring/id/stations/L2406.json"
# HELP river_level_measurement river_level
# TYPE river_level_measurement untyped
river_level_measurement{rloi_id="8208",station_name="Viking Recorder",town="York",wiski_id="L2406"} 0.649

# HELP river_level_min_on_record river_level
# TYPE river_level_min_on_record untyped
river_level_min_on_record{rloi_id="8208",station_name="Viking Recorder",town="York",wiski_id="L2406"} -0.082

# HELP river_level_max_on_record river_level
# TYPE river_level_max_on_record untyped
river_level_max_on_record{rloi_id="8208",station_name="Viking Recorder",town="York",wiski_id="L2406"} 5.4
```

Unfortunately the JSON Exporter doesn't support measurement units. It does support help text but I don't need that for myself (something to do later.) What I have done is configured some useful labels, including the IDs mentioned up the top of this article.

I've made a public Docker image for this if you want to re-use it: `ghcr.io/46bit/flood-exporter`.

## What's next?

The next step is to configure Prometheus to scrape that endpoint, and Grafana to render some pretty graphics and send alerts. I cover that in **[my next post](/2021/getting-alerted-when-cycle-paths-flood-part-two/)**.
