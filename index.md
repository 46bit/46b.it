---
title: Miki Mokrysz
layout: page
---
<div style="overflow: hidden;">
  <img class="avatar botspace" src="/assets/avatar.jpg">
  <p class="intro">I'm a cloud software engineer and aspiring artist. I design and build large-scale web systems remotely from 🚴‍♀️ York, UK. My pronouns are 🏳️‍🌈 <a href="http://my.pronoun.is/they">they/them</a>. You can email me at <a href="mailto:miki@46b.it">miki@46b.it</a>.</p>
</div>

<h2>Recent writing <a href="/writing/">(more)</a></h2>
<ul class="post-list">
  {% for post in site.posts limit:4 %}
    {% include post-list-item.html %}
  {% endfor %}
</ul>

<h2>Recent art <a href="/art/">(more)</a></h2>
<ul class="artwork-list">
  {% assign random_artwork = site.artworks | sample:4 %}
  {% for artwork in random_artwork %}
    {% if artwork.hide %}
      {% continue %}
    {% endif %}
    {% if artwork.draft %}
      {% continue %}
    {% endif %}
    <li>
      <a class="post-title" href="{{ artwork.web_url | default: artwork.url }}"><img class="artwork-thumb" src="{{ artwork.thumb_url }}" alt="{{ artwork.title | escape }}" title="{{ artwork.title | escape }}"></a>
    </li>
  {% endfor %}
</ul>
