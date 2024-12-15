---
title: My Blog To-Do List
slug: my-blog-to-do-list
date: 2023-03-23T02:20:28.000Z
date_updated: 2023-04-21T01:57:33.000Z
hero_image: https://summittservices.blob.core.windows.net/summitt-dweller-blog/images/2023/03/jessica-lewis-fJXv46LT7Xk-unsplash.jpg
tags: 
  - Development
  - Eleventy
  - Ghost
excerpt: Witness the birth of a new blog! Actually, a new version of a very old blog. There's still a lot of work to do.So, here's my "to-do" list, as it pertains to this blog, along with possible sources of guidance and inspriration.
---

Witness the birth of a new blog! Actually, a new version of a very old blog. There's still a lot of work to do.

So, here's my "to-do" list, as it pertains to this blog, along with possible sources of guidance and inspiration.

---

#### Update social icons and links in the blog.

Lose Twitter in favor of Mastodon, perhaps?  Again, see [https://ghost.org/tutorials/add-social-media-icons/](https://ghost.org/tutorials/add-social-media-icons/). 
---

#### Add the `OneTab` content type.

My old Hugo blog distinguished between a "post" and other types that I called "micropost" and "onetab".  Each type had its own unique metadata fields.  For example, each "micropost" had `location:` and detailed `published-date:` fields, but no `title:`.  See [https://ghost.org/docs/themes/routing](https://ghost.org/docs/themes/routing) for possible guidance.

See my previous "**Add `Micropost` and `OneTab` content types**" as well as "**Add `For Sale` and `OneTab` content types**" solutions below for guidance.
---

#### Process new `.env` variables.

Some of this has already been implemented to achieve the site banner that you see on the home page. See [https://www.11ty.dev/docs/data-js/#example-exposing-environment-variables](https://www.11ty.dev/docs/data-js/#example-exposing-environment-variables) for the guidance I used to pull that off. 
---

#### Add a photo gallery.

Maybe.  Another feature that my old Hugo blog supported, although I rarely kept it up-to-date.
---

#### Implement my Hugo Timeline module.

Make an 11ty version of [https://github.com/SummittDweller/hugo-timeline](https://github.com/SummittDweller/hugo-timeline) and implement it here. 
---

#### Engage Disqus Comments.

Another feature that my old Hugo blog had, and my [professional blog](https://static.grinnell.edu/dlad-blog) still uses.  Rinse and repeat.

---

## Everything below this line is DONE!  For now.

#### Pulling Too Much Data

Today (April 20, 2023) I received notice from *Mediacom*, my ISP, that I've used 75% of my monthly data allotment with about a week left in the term.  That's not a huge problem, but I've never come close to using even one-half of my data in any previous month.  I suspect this is due to all the massive image downloads taking place each time I build a dev copy of this blog.

The `yarn start` command that I use to build the `localhost` copy of this blog defines `ELEVENTY_ENV=dev`.  I'm going to see if I can use this environment setting to limit image downloads to the first ten in order to limit the "dev" download requirements.  If this works a switch of some kind might need to be defined so that I can override the limit as needed.

☑️ **Solved 20-Apr-2023**: This played out nicely, but rather than limited the number of images I simply limit the number of `posts` pulled by `.eleventy.js`.  The code looks like this now:

     var environ = process.env.ELEVENTY_ENV;
     console.log("ELEVENTY_ENV is: ", environ);
     if (environ == "dev") {
       post_limit = 6;
     } else {
       post_limit = 'all';
     }
    
     collection = await api.posts
       .browse({
         filter: "tag:-micropost",
         include: "tags,authors",
         limit: post_limit
       })
    ...
    

---

#### Implement robust site search.

Just like it says ^^^ there.  Using Lunr, [Pagefind](https://pagefind.app/), something else?

☑️ **Solved 20-Apr-2023**: This is done and I did indeed use [Pagefind](https://pagefind.app/) for the solution.  The details can be found elsewhere in this blog at [Searching for a Search Solution](__GHOST_URL__/glad-i-found-pagefind/) and also in this blog project's `README.md` file. 
---

#### Add `For Sale` and `OneTab` content types.

My old Hugo blog distinguished between a "post" and other types that I called "micropost" and "onetab".  Each type had its own unique metadata fields.  For example, each "micropost" had `location:` and detailed `published-date:` fields, but no `title:`.  See [https://ghost.org/docs/themes/routing](https://ghost.org/docs/themes/routing) for possible guidance.

See my previous "**Add `Micropost` and `OneTab` content types**" solution below for guidance.

☑️ **Solved 6-Apr-2023**: Ok, the `micropost` and `for_sale` portions of this is done, and documented (somewhat) in [https://github.com/SummittDweller/blog-eleventy-ghost/blob/main/README.md](https://github.com/SummittDweller/blog-eleventy-ghost/blob/main/README.md).  Note that in the end I introduced a new `for_sale` tag (note that it's all lowercase to set it apart from others) after trying to use other techniques.

I'm pushing the addtion of a `onetab` content type back up into this list, again.

---

#### Improve Front Matter Processing

This effort will make a significant change to the solution shown in "**Add and process post front matter**" below.  Specifically, I'm going to move the "front matter" for all content types out of the `excerpt`, because it's difficult/impossible to edit excerpts in my iPhone's *Ghost Publisher* software, and put it at the bottom of the content body with a `---` seperator marking the start of the data.  It should look something like this example:

    ---
    location: Toledo, IA
    price: $50.00
    note: This is just a note.
    

Basically, anything found at the bottom of a post, of any TYPE, below a `---` delimiter, becomes a key:value pair available in `post.data.<key>`.

☑️ **Solved 5-Apr-2023**: This is done but not as originally planned, and it may still need some work.  So, in the end I introduced a new `for_sale` tag (note that like `micropost` it's all lowercase to set it apart from others) after trying to use other techniques.

My new "rear matter" solution, detailed in the project's `README.md` file, actually uses a `dash-slash-dash` delimiter at the bottom of the content body, immediately followed by a `slash-dash-slash` delimiter... all run together in 6 characters, no spaces.

The first delimiter marks the end of the content, while the second one marks the start of the "rear matter".  I can't show you explicitly how that works here because putting those characters into a post like this will cause errant processing on this post. 🙃

---

#### Add `Micropost` and `OneTab` content types.

My old Hugo blog distinguished between a "post" and other types that I called "micropost" and "onetab".  Each type had its own unique metadata fields.  For example, each "micropost" had `location:` and detailed `published-date:` fields, but no `title:`.  See [https://ghost.org/docs/themes/routing](https://ghost.org/docs/themes/routing) for possible guidance.

☑️ **Solved 2-Apr-2023**: Ok, the `micropost` portion of this is done, and it's documented (somewhat) in [https://github.com/SummittDweller/blog-eleventy-ghost/blob/main/README.md](https://github.com/SummittDweller/blog-eleventy-ghost/blob/main/README.md).  Note that in the end I introduced a new `micropost` tag (note that it's all lowercase to set it apart from others) after trying to use other techniques like bits of `excerpt` and internal tags like `#micropost`.

I'm pushing the addtion of a `onetab` content type back up into this list, and will add a new `for-sale` tag and type to the mix.

---

#### Support better bulk ingest of content.

I have a lot of old blog posts to enter here, and research tells me that capability might be lacking.  Perhaps I can construct something using [https://ghost.org/docs/admin-api/javascript/](https://ghost.org/docs/admin-api/javascript/) or provide an update of [https://github.com/dumrauf/post2ghost](https://github.com/dumrauf/post2ghost) that works with the newest Ghost API?

☑️ **Solved 2-Apr-2023**: Well, I got this done after several failures.  Ultimately look to [https://github.com/SummittDweller/migrate-hugo-to-ghost](https://github.com/SummittDweller/migrate-hugo-to-ghost) and more recently, [https://github.com/SummittDweller/migrate-html-to-ghost](https://github.com/SummittDweller/migrate-html-to-ghost) for my solution. 
---

#### Investigate using "special control" tags.

Control Ghost and Eleventy behavior using tags that with @, #, or some other special character.  For example: `#Micropost`, or `$Micropost`.

🚫 **CANCELED 26-Mar-2023**: Now that front matter via the `excerpt` is working, I don't think this will be necessary. 
---

#### Add FontAwesome support for emoji.

I really miss those from my Hugo days, and they would be so handy to have for things like checking items off this list!  See [https://ghost.org/tutorials/add-social-media-icons/](https://ghost.org/tutorials/add-social-media-icons/) for guidance.

Looks like this is already avaialble in 11ty, [https://www.npmjs.com/package/@vidhill/fortawesome-free-regular-11ty-shortcode](https://www.npmjs.com/package/@vidhill/fortawesome-free-regular-11ty-shortcode), but can I code a shortcode call in Ghost and pass it through?  I'll bet not... NOPE.

☑️ **Solved 26-Mar-2023**: This turned out to be a bit of a gut 🥊.  So, I've scrapped the idea in favor of just using `CTRL - COMMAND - SPACE` on my Mac.
---

#### Add and process post front matter.

See [https://forum.ghost.org/t/custom-data-fields/8884/4](https://forum.ghost.org/t/custom-data-fields/8884/4) and [https://github.com/nchaulet/ghost-app-frontmatter](https://github.com/nchaulet/ghost-app-frontmatter).  Maybe this old project can be resurected and implemented here so that posts, and other types, can have robust "front matter" with custom display.

☑️ **Solved 26-Mar-2023**: Following the logic of the `parseFrontMatter` function in [https://github.com/nchaulet/ghost-app-frontmatter/blob/master/index.js](https://github.com/nchaulet/ghost-app-frontmatter/blob/master/index.js), I added the following code to `.eleventy.js`.

    // Add front matter processing of Ghost posts here, 
    // pulling data from the `post.excerpt`
    // Note that pulling from `post.codeinjection_head` and
    // `post.custom_excerpt` did NOT work!
          
    // console.log(post);
    // console.log("Before:", post.excerpt);
    var parsed = matter(post.excerpt, { delims: ['---', '---'] });
    post.data = parsed.data;
    var removed = post.excerpt.replace(/---[\S\s]*---/m, '');
    post.excerpt = removed;
    
    // console.log("After:", post.excerpt);
    // console.log("Data:", post.data);
    

It looks for typical `---` delimiters in the `excerpt` portion of a post and parses it into `data.<element>` key:value pairs that are available to my templates.
---

#### Display `publication` and `last-mod` dates.

Just what the title says. Displaying these things was something my old Hugo blog always did.

☑️ **Solved 26-Mar-2023**: Another easy addition in `src/_includes/partials/card.njk` where the Nunjucks now checks for matching `published_at` and `updated_at` dates, and reports "Published" if they match, or "Updated" if they don't. Also, `microposts` now show differnt data, including `location:` and the publication date AND time. 
---

#### Improve the display of `tags`.

Maybe seperate tags using `&middot;` symbols · like · this?  Perhaps have a look at [https://ghost.org/docs/themes/helpers/tags/](https://ghost.org/docs/themes/helpers/tags/).

☑️ **Solved 25-Mar-2023**: An easy addition in `src/_includes/partials/card.njk` where the Nunjucks now looks like this:

    <div class="post-card-tags">
      {% if post.tags %}
        {% for tag in post.tags %}
          {{ tag.name }} {% if not loop.last %} &middot; {% endif %}
        {% endfor %}
      {% endif %}
    </div>
    

---

#### Rebuild and deploy the site when content is published.

The site already builds and auto-deploys when changes are pushed to the code/structure, but the forerunner of this site also included a hook that did a build and deploy (per Netlify) when changes to the Ghost content are published. See [https://github.com/TryGhost/eleventy-starter-ghost](https://github.com/TryGhost/eleventy-starter-ghost) for possible guidance.

Better yet, check out [https://docs.digitalocean.com/reference/api/api-reference/#operation/apps_create_deployment](https://docs.digitalocean.com/reference/api/api-reference/#operation/apps_create_deployment).  It seems the mechanism that's required here is to make a request, like a `curl` or `POST`, to a particular URL (see sample below) perhaps with an auth token included for security.

    curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
      "https://api.digitalocean.com/v2/apps/{app_id}/deployments"
    

Now, the question is, how to make my Ghost install dispatch such a request?  Simple, see [https://ghost.org/docs/webhooks/](https://ghost.org/docs/webhooks/) but note that the request might need to be a `POST`, not a `curl`.

Hmmm, this is more difficult than I imagined, so this write-up might soon become a post of its own!

#### Preliminary Findings

Unfortunately, it looks like Ghost's webhooks don't integrate well with DigitalOcean.  DO requires a `POST` request that looks like this in `curl` form:

    curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer { $DIGITALOCEAN_TOKEN }" \
      -d '{ "force_build":true }' \
      "https://api.digitalocean.com/v2/apps/{ app ID }/deployments"
    

I can't find a way to build such a request in Ghost since the headers and  body of the webhooks it builds don't look like what you see above. The only thing that can be easily configured in a Ghost webhook is the destination address. So, now I'm going to look into the possibility of using an iOS or MacOS app that triggers a `curl` like the one you see above. Or, maybe I can add a protected page to the site itself and embed a Javascript `POST` request within?

☑️ **Solved 23-Mar-2023**: Please see [Built by Webhook + Password Protection](https://blog.summittdweller.com/built-by-webhook-password-protection/) for all the gory details.

---

#### Force rebuild with "Trigger Site Update" draft.

The idea here is to delay rebuilding the site until triggered by an editor, perhaps using a "special" trigger post.  This could help avoid multipe back-to-back rebuilds when lots of content is updated in a short period of time. Of course, if a "special" post were used for this it would have to be implicitly "ignored" and always in a "draft" state.

🚫 **CANCELED 23-Mar-2023**: No longer needed. Please see [Built by Webhook + Password Protection](https://blog.summittdweller.com/built-by-webhook-password-protection/) for all the gory details.

---

#### Engage spell checking.

Indications from as early as 2015 indicate that this should work straight from the browser, but I'm not so sure?

☑️ **Solved 23-Mar-2023**: Just toggle the little `abc-checkmark` icon down in the lower right corner of the editor window. Also, the `question-mark` icon down there is helpful too!  
---
