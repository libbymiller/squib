---
layout: default
---

<ul>
{% for post in site.posts %}
  <li> <a href="{{post.url | prepend: site.baseurl }}">{{ post.title | remove: '<p>' | remove: '</p>' }}</a> {% for t in post.tags %} <a class="label label-default" href="{{t}}.html">{{t}}</a> {% endfor %}<br>
      {{post.excerpt | remove: '<p>' | remove: '</p>'}}

  </li>
{% endfor %}
</ul>

# For Squibbers By Squibbers

This is a community-driven blog. Want to contribute? [Here's how]({{site.baseurl}}{% post_url 2015-08-03-Contributing-to-the-blog %}). We could use:

  * Showcases! Both the polished and the works-in-progress
  * Diaries of your prototypes
  * Awesome Ruby-fu
  * Collaboration techniques with Squib
  * Step-by-step guides for beginning Squibbers/Rubyists/programmers
