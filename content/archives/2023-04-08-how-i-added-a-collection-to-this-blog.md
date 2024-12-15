---
title: How I Added a Collection to This Blog
slug: how-i-added-a-collection-to-this-blog
date: 2023-04-08T12:47:15.000Z
date_updated: 2023-04-13T00:53:35.000Z
hero_image: https://images.unsplash.com/photo-1591961172040-ee974a422616?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDEwMnx8Y29sbGVjdGlvbnxlbnwwfHx8fDE2ODA5NTc5ODI&ixlib=rb-4.0.3&q=80&w=2000
tags: 
  - Development
excerpt: What follows is an excerpt taken directly from this project's `README.md` file.  
---

What follows is an excerpt taken directly from this project's `README.md` file.

## Adding a 'micropost' Collection

I'm following the guidance at [Building content collections](https://ghost.org/tutorials/content-collections/) to turn my new `micropost` tag into a new Ghost collection.  I've downloaded the `routes.yml` file from my Ghost installation as suggested in the guidance, and it's now part of this project with initial contents of:

    routes:
    
    collections:
      /micropost/:
        permalink: /micropost/{slug}/
        template: index
        filter: tag:micropost
      /:
        permalink: /{slug}/
        template: index
        filter: tag:-micropost
    
    taxonomies:
      tag: /tag/{slug}/
      author: /author/{slug}/
    

This change allowed me to swap this first line of template logic for the second:

      {% if post.data.type != "micropost" %}
    

      {% if '/micropost/' not in post.url %}
    

The reverse logic in javascript now calls for:

      if (post.url.includes(`/micropost/`)) {
    

## Completing the Addition of the 'micropost' Collection

Having added a `micropost` collection (see above) I made a copy of `src/index.njk` named `src/microposts.njk` and set the template front matter to:

    ---
    pagination:
      data: collections.microposts
      size: 9
      alias: microposts
    ---
    

The key logic also changed to:

        <section class="post-feed">
            {% for post in microposts %}
              {# post.url | debugger #}
              {{ card(post) }}
            {% endfor %}
        </section>
    

All of this successfully created the new `/microposts/` path and I explicitly added it to the `site.navigation` in `src/_data/site.js`.  I also removed `About` from the `site.navigation` in the same source code.

## Don't Forget...

Remember to upload any changes to `routes.yml` back to Ghost via the [Settings | Labs](__GHOST_URL__/ghost/#/settings/labs) menu!

## Subsequent Changes in `.eleventy.js` Where Filtering is Key!

I recently found that "hiding" mircorposts from the home page was seriously fouling up my pagination, when I asked for 9 posts per page I would sometimes only see 5 or fewer posts spread across 3 pages.  The system was properly positioning 9 posts, but those that were tagged as `micropost` were hidden from view.

So, I revamped my `.eleventy.js` to do a better job of filtering (that IS the keyword here!) my *Ghost* content up-front, like this:

      // Get all posts, but NO microposts here!
      config.addCollection("posts", async function(collection) {
    
        collection = await api.posts
          .browse({
            include: "tags,authors",
            limit: "all",
            filter: "tag:-micropost" 
          })
          .catch(err => {
            console.error(err);
          });
    
        collection.forEach(post => {
    
          post.url = stripDomain(post.url);
          post.primary_author.url = stripDomain(post.primary_author.url);
          post.tags.map(tag => (tag.url = stripDomain(tag.url)));
          // Convert publish date into a Date object
          post.published_at = new Date(post.published_at);
          // Call custom MAM javascript
          var custom = require("./custom.js");
          post = custom.modify_post(post);
    
        });
    
        // Bring featured post to the top of the list
        collection.sort((post, nextPost) => nextPost.featured - post.featured);
    
        return collection;
      });
    
      // Get all posts AGAIN, but this time return only the microposts as a new collection
      // See https://11ty.rocks/posts/creating-and-using-11ty-collections/#more-ways-to-create-collections-with-addcollection
      config.addCollection("micropost", async function(collection) {
    
        collection = await api.posts
          .browse({
            include: "tags,authors",
            limit: "all",
            filter: "tag:micropost"
          })
          .catch(err => {
            console.error(err);
          });
    
        const new_collection = [];  
        collection.forEach(post => {
          post.url = stripDomain(post.url);
          post.primary_author.url = stripDomain(post.primary_author.url);
          post.tags.map(tag => (tag.url = stripDomain(tag.url)));
          // Convert publish date into a Date object
          post.published_at = new Date(post.published_at);
          // Call custom MAM javascript
          var custom = require("./custom.js");
          post = custom.modify_post(post);
          new_collection.push(post);
        });
    
        // console.log("Micropost collection:", new_collection);  // Dump what we hath created
        return new_collection;
      });
    
