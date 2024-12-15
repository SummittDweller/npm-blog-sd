---
title: Hugo Mod Local
slug: hugo-mod-local
date: 2022-12-18T18:00:00.000Z
date_updated: 2023-04-05T01:29:15.000Z
tags: 
  - Development
  - Hugo
# type: micropost
location: Toledo, IA
---

Today I discovered a slick trick for local development of my first Hugo Module. The guidance I used was found in Working with Hugo Module Locally and it was spot-on! In my case the key was the additon of one line, two if you include the comment, to my project's config.yml file:
// Innocent line below!
replace github.com/SummittDweller/hugo-timeline => /Users/mark/GitHub/hugo-timeline



