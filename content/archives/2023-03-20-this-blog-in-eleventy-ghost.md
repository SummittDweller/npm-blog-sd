---
title: This Blog in Eleventy + Ghost
slug: this-blog-in-eleventy-ghost
date: 2023-03-20T13:44:12.000Z
date_updated: 2023-03-22T15:29:48.000Z
hero_image: https://summittservices.blob.core.windows.net/summitt-dweller-blog/images/2023/03/Screenshot-2023-03-20-at-09.32.12.png
tags: 
  - Development
  - Eleventy
  - Ghost
  - DigitalOcean
excerpt: Mackenzie's moving her portfolio page into an Eleventy (11ty) on frontend with content managed in Ghost on the backend.  I like that combination very much so to help support her move I'm doing the same. 
---

This past weekend my daughter, Mackenzie, made the decision to move her portfolio page into a configuration that features Eleventy (11ty) on the frontend with content managed in Ghost on the backend.  I like that combination very much so to help support her move, and learn a little something along the way, we've setup a new Ghost server in a DigitalOcean droplet, namely `ghostonubuntu2204-s-1vcpu-1gb-intel-nyc1-01` , and I've decided to make the same move myself.  

This post is intended to track my blog's journey from a `git` workflow (for both structure and content) in Hugo, to Eleventy + Ghost, and it begins with the guidance provided in [https://github.com/TryGhost/eleventy-starter-ghost](https://github.com/TryGhost/eleventy-starter-ghost).  I already have a working Ghost server as mentioned above, the one that we setup for Mackenzie's portfolio, and we've already followed [Install and host Multiple Ghost blog Servers on One Server](https://hooshmand.net/host-a-second-or-multiple-ghost-blogs-on-one-server/) to create the Ghost backend for this blog on the same DO droplet that host's Mackenzie's portfolio content.  The admin interface for my blog instance of Ghost is shown below.  
[

Ghost Admin

![](__GHOST_URL__/ghost/assets/img/apple-touch-icon-74680e326a7e87b159d366c7d4fb3d4b.png)Ghost

](__GHOST_URL__/ghost/#/posts)The backend: My `blog-ghost.summittservices.com` admin interface.
## Creating the 11ty Frontend

Working locally on my Mac Mini this is the input I captured...

    cd ~/GitHub
    git clone https://github.com/TryGhost/eleventy-starter-ghost.git blog-eleventy-ghost
    cd blog-eleventy-ghost
    yarn
    yarn start
    ^C

*Note that complete input and output from all commands is available in [https://gist.github.com/SummittDweller/1af7ecbb9051ee04d0a9dbad7f74c1e7](https://gist.github.com/SummittDweller/1af7ecbb9051ee04d0a9dbad7f74c1e7).*

That worked flawlessly and it's quick too!  

## Saving This Work in GitHub

Time to save what's been done here before our progress is lost, and I didn't fork the [`TryGhost/eleventy-starter-ghost`](https://github.com/TryGhost/eleventy-starter-ghost) project because I don't intend to try and improve it, so my project needs a new GitHub home.  My typical process for doing that looks something like this...

    rm -fr .git
    git init
    git add .
    git commit -m "First commit"
    git branch -M main
    git remote add origin https://github.com/SummittDweller/blog-eleventy-ghost.git
    git push -u origin main

## Replacing the Ghost Backend

By default the project I'm using connects its 11ty frontend to a Ghost backend at [https://eleventy.ghost.io/](https://eleventy.ghost.io/).  Fortunately, my project's `README.md` file, an ammended copy from the original `TryGhost` project, also provides the simple guidance required to change that, like so...

First, I visited [https://blog-ghost.summittservices.com/ghost/#/settings/integrations/](__GHOST_URL__/ghost/#/settings/integrations/64185c1723ad590d103c051a) to create new API keys, and saved them in my password vault.  Next, I needed to edit the project's `.env` file to read like this:

    # GHOST_API_URL=https://eleventy.ghost.io
    # GHOST_CONTENT_API_KEY=5a562eebab8528c44e856a3e0a
    GHOST_API_URL=https://blog-ghost.summittservices.com
    GHOST_CONTENT_API_KEY=***********hidden****************
    SITE_URL=http://localhost:8080

Done.  When the `blog-ghost.summittservices.com` instance of Ghost was created I took steps to "make it private", so it should function as a backend only.   So, running `yarn start` with the new `.env` configuration should give me a stripped-down `localhost:8080` edition of the blog pulling content from the intended Ghost backend, like so:

    yarn start
    

Yup, that works!  I get something that looks like this now:
![](images/2023/03/Screenshot-2023-03-20-at-08.40.32.png)My new blog connected to `blog-ghost.summittservices.com`.
Even better, when I save and `Publish` my work on this post, effectively removing its "Draft" status in `blog-ghost.summittservices.com`, I should see an instantaneous update in my `https://localhost:8080` instance of the blog.  Wish me luck...  

Beautimous!  Well, almost.  The change to the site was not "instantaneous", but after a quick `ctrl-c` and a new `yarn start` we have this:
![](images/2023/03/Screenshot-2023-03-20-at-08.45.11.png)New blog updated with an initial copy of this post.
## Migrating Content

Now that we have a working local site, it's time to copy some content (posts and microposts) that I wish to keep from my old blog at [https://github.com/SummittDweller/blogs-SummittDweller](https://github.com/SummittDweller/blogs-SummittDweller) into `blog-ghost.summittservices.com`.  For now I'm doing that "manually" by opening a new post and copying content from old .md files into them one-at-a-time.  Using that tedious process I managed to copy 8 posts forward into this blog.

Along the way I also did some quick investigation of [post2ghost](https://github.com/dumrauf/post2ghost), a utility aimed at helping populate Ghost posts from .md files.  Great idea!  Unfortunately, it looks like that work relies on an ancient version of the Ghost API, and I don't think it will work at all with the latest due to extensive changes in the API.

Still, I very much like the idea behind `post2ghost` and I also like the name.  Maybe I'll reach out and see if I can borrow the name and leverage the new Ghost API along with my [Hugo Front Matter Tools](https://github.com/Digital-Grinnell/hugo-front-matter-tools) project to create a Python script that will read .md files with front matter and turn them into API-compatible JSON for bulk creation of new Ghost posts.  More on that effort later...

## Next Step - Deploy and Assign an Address

Currently this new blog is only available locally as [https://localhost:8080](https://localhost:8080) because it does not yet deploy to any internet host.  The [Eleventy Starter Ghost](https://github.com/TryGhost/eleventy-starter-ghost) project that I'm following is equiped to deploy a site to [Netlify](https://www.netlify.com) and use deploy hooks from Ghost to trigger Netlify rebuilds.

Netlify is fine, but I only use them as a last resort, and thus far that's only for the [Wieting Theatre](https://Wieting.TamaToledo.com) where I rely on NetlifyCMS to manage backend content.  Ironically, NetlifyCMS was just rebranded as `Decap CMS`.  See [https://www.netlify.com/blog/netlify-cms-to-become-decap-cms/](https://www.netlify.com/blog/netlify-cms-to-become-decap-cms/) for details.

So, I'm going to try and reproduce the triggers, hooks and actions intended for Netlify with my own GitHub Action (plus whatever it takes) to deploy this blog as [https://blog.SummittDweller.com](https://blog.SummittDweller.com).  That URL currently delivers a Hugo static site hosted on DigitalOcean (DO).  Since my Ghost instance is also on DO I think I'll take a crack at deploying this blog to DO App Platform as a Starter App.  I hope that the guidance provided in [Step 11 — Deploying to DigitalOcean with App Platform](https://www.digitalocean.com/community/tutorials/how-to-create-and-deploy-your-first-eleventy-website#step-11-deploying-to-digitalocean-with-app-platform) proves helpful.

### Step 11 — Deploying to DigitalOcean with App Platform - My Specifics

The aforementioned guidance did indeed prove helpful, although it is a little out-dated compared to my acutal experience, which is detailed below in up-to-date (as of March 2023) words and pictures, of course.

First I visited my DigitalOcean account and clicked the `Create` button as directed.
![Image file is 0001.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0001.png) 
    Figure 1. Replacing the `blogs-summitt-dweller` app in DigitalOcean. Click `Create`.
  
Next, I selected `Apps` as directed in order to initiate the creation of a new `App`.
![Image file is 0011.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0011.png)Figure 2. Select 'Apps'.
This app is to be built from a GitHub repo so I chose `GitHub`, allowed the system to lookup all the GitHub repositories I've given DigitalOcean permisison to "see".
![Image file is 0027.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0027.png)Figure 3. Select `GitHub` and then the new site project repo.
I choose the my `SummittDweller/blog-eleventy-ghost` repo.
![Image file is 0045.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0045.png)Figure 4. Choose the repo.
Then accepted all the defaults for the `main` branch, the `/` root directory (of the project repo), the default for `Auto Deploy`, and clicked `Next` to proceed.
![Image file is 0065.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0065.png)Figure 5. Accept defaults and click `Next`.
Unfortunately, when I initiated the process DigitalOcean detected the repo as a "Web Service", perhaps because of the `netlify.toml` file?  I don't want to create a "Web Service" since those are more complex and expensive than a simple static 11ty site.  So, I choose to edit the `Resource Type` to change that.
![Image file is 0861.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0861.png)Figure 6. Edit the `Resource Type`...
I subsequently choose a `Static Site` and clicked to `Save` the change.
![Image file is 0916.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0916.png)Figure 7. Choose `Static Site` and click `Save`.
My 11ty project generates static content into the project's `/dist` directory so I edited the `Output Directory` setting, set it to `dist` and clicked to `Save` that change.
![Image file is 0954.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0954.png)Figure 8. Edit the `Output Directory`...![Image file is 0970.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0970.png)Figure 9. Set to `dist` and click `Save`.
Next I clicked `Back` to find the "Billing" section, review the new deployment fees (should be $3/month or less), and click `Create Resources` to begin the first build and deployment.
![Image file is 1003.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1003.png)Figure 10. Click `Back`...![Image file is 1114.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1114.png)Figure 11. Review fees and click `Create Resources`.
It took a few minutes, but once the app is complete you should see a screen like that shown in Figure 12 below.  Another unfortunate stumble... I forgot to change my App name up front so it carries a meaningless, random name of `coral-app`.  Let's change that now.
![Image file is 1139.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1139.png)Figure 12. App was created, but with a meaningless  name.
I clicked `Edit` in the "App Settings / Info" section and changed the name to better represent the project and site that's been created.
![Image file is 1258.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1258.png)Figure 13. Edit the App Settings Info to change the name.![Image file is 1461.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1461.png)Figure 14. Specify a better name and click `Save`.
Note that the unique URL generated for the app did NOT change.  I fear we are stuck with that name, but it won't be a concern for very long.  Once the deployment is done you should see a `Live App` link/button.  Click it!
![Image file is 1494.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1494.png)Figure 15. Wait for the app to deploy and click `Live App`.
Eureka!  We should have a new site deployed to DigitalOcean.
![Image file is 1513.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/1513.png)Figure 16. Eureka, we have an app!
One more thing to do, give this new site a meaningful URL.  Open the `Manage` screen and our new app, the click the `Settings` tab.
![Image file is 2014.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/2014.png)Figure 17. Manage the app and click `Settings`.
Click `Add Domain` and enter the "correct" URL.  In this case the app needs to respond at [https://blog.SummittDweller.com](https://blog.SummittDweller.com).
![Image file is 2024.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/2024.png)Figure 18. Click `Add Domain`.
My registar already points the `summittdweller.com` domain at the DigitalOcean DNS servers, so I choose `DigitalOcean DNS` as the keeper of the domain's records.
![Image file is 2062.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/2062.png)Figure 19. Enter the new domain name and choose DigitalOcean DNS.
After the domain is added I needed great patience since I could visit the site, but no valid certificates had been generated yet.  I was able to check my DigitalOcean `Network` screen to see that a new CNAME record has been added for the site, and after about 30 minutes I was finally able to open the "secure" site at [https://blog.SummittDweller.com](https://blog.SummittDweller.com).
![Image file is 2165.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/2165.png)Figure 20. Be patient, the site is not instantly secure.![Image file is 2450.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/2450.png)Figure 21. Visit `Networking` and observe a new CNAME record.
## Customization: Formatting Figures and Matomo

Ok, now that the domain is added I wanted to introduce my first bonafide customizations, namely

- Better formatting of figures like you see in the previous section and below, and
- Introduction of my [Matomo](https://analytics.summittservices.com) tracking code.

### Using Code Injection

Ghost has a nice feature called `Code Injection` that allows me to inject snippets of Javascript and CSS into every page's header and footer.  Not sure I'm "sold" on the use of `Code Injection` since it puts "code" into a database, and that's something I don't care to do.  However, as a short-term "test" it's a wonderful feature.

To engage it I visited my blog's [Ghost admin page](__GHOST_URL__/ghost) and clicked on the `gear icon` (lower-left red box in Figure 22 below) then selected the `Code Injection` as shown below.  The code injection screen that opens provides both header and footer editing spaces where Javascript and/or CSS can be added.
![Ghost-Code-Injection-01.png](https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/Ghost-Code-Injection-01.png)Figure 22. Opening Ghost Code Injection.
The CSS that I added in the header was:

    <style>
      p > figure > figcaption {
        font-weight: 400;
        font-style: italic;
        font-size: 16px;
        color: black;
        outline: 0;
        z-index: 300;
        padding: 2px 5px;
        text-align: left;
      }
        
      p > figure > img {
        border: 1px solid black;
      }    
    </style>  
    

The Javascript code injected into the footer was:

    <script>
      // Creates Captions from img Title attributes
      $("img").each(
        function() {
          // Let's make the title a caption
          if ($(this).attr("title")) {
            $(this).wrap(
              '<figure class="figure"></figure>'
            ).after(
              '<figcaption class="figure">' +
                 $(this).attr("title") +
              '</figcaption>'
          );
        }
      });
    </script>
    

Both of the above code snippets were inspired by blogger [Kevin Chung](https://blog.kchung.co/author/kchung/) and his [Adding image captions to Ghost](https://blog.kchung.co/adding-image-captions-to-ghost/) post.  Kevin's code looked for any `![alt](src)` image references in the content and reformatted them into HTML that looked something like this:

    <figure class="figure">
      <img src="https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/0011.png" alt="Image file is 0011.png" title="Figure 2. Select 'Apps'." loading="lazy"/>
      <figcaption class="figure">Figure 2. Select 'Apps'.</figcaption>
    </figure>    
    

Kevin's original code modified ALL of the images, the `<img>` tags, in the post if they had `alt` attributes, and in my case that's ALL images.  That's not what I wanted to happen, so I reworked the logic so that only images (`<img>`) with `title` attributes would get captured and reformatted.  That worked nicely, but my results were inconsistent.  The behavior I saw in localhost rendering was different than in my Ghost site, and sometimes differnt than in my Elevent site.  Not good.

All of the Markdown for the figures, like those in this section and above, that I wanted to control is generated using my [Convert Videos to Frames](https://github.com/SummittDweller/convert_videos_to_frames) utility, I chose to take the bull by the horns and just have it generate exactly the `<figure>` and `<figcaption>` HTML that I wanted to see.  So, the raw Markdown for the figure you see above is simply:

    <figure>
      <img class="figure" alt="Ghost-Code-Injection-01.png" src="https://sddocs.blob.core.windows.net/documentation/Eleventy-Ghost/Ghost-Code-Injection-01.png" />
      <figcaption class="figure"> 
        Figure 22. Opening Ghost Code Injection.
      </figcaption>
    </figure> 
    

The images in this instance are housed as BLOBs in *Azure Storage* and served directly from there.

The simple/raw approach that I ultimately arrived at is consistent and to-the-point, and it doesn't need any Ghost code injection so I removed all of the "injected" code from [https://blog-ghost.summittservices.com/ghost/#/settings/code-injection](__GHOST_URL__/ghost/#/settings/code-injection).  I also found that I could achieve better, more consistent CSS control by adding custom code to the end of the project's `src/_includes/css/styles.css` file like so:

    /* Summitt Dweller styles
    /* ---------------------------------------------------------- */
    
    figure img.figure.lazyloaded {
      border: 1px solid black;
    }
    
    figure {
      text-align: center;
    }
    
    .post-full-content figcaption {
      margin: 0.2em 3em 0;
      font-size: 55%;
      line-height: 1.6em;
      text-align: center;
      font-weight: 400;
    }
    
    code {
      font-family: monospace,monospace;
      font-size: .75em;
      background: #eceebd;
      padding: 2px 5px;
      border-radius: 5px;
    }
    
    pre > code {
      background: none;
      padding: 0;
    }
    

The intent is to wrap the images with a `class="figure"` attribute in a nice little black border, and more!

### Matomo

While Ghost code injection didn't behave well for reformatting figures, it does work nicely, and consistently, for Matomo tracking!  However, I'd still prefer to put as much as possible into code, not into a database, so I grabbed a copy of my Matomo code that's specifically for [this blog](https://blog.SummittDweller.com) and applied it like so in the project's `src/_includes/layouts/default.njk` file:

    <!-- Matomo -->
    <script>
      var _paq = window._paq = window._paq || [];
      /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
      _paq.push(['trackPageView']);
      _paq.push(['enableLinkTracking']);
      (function() {
        var u="https://analytics.summittservices.com/";
        _paq.push(['setTrackerUrl', u+'matomo.php']);
        _paq.push(['setSiteId', '10']);
        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
        g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
      })();
    </script>
    <!-- End Matomo Code -->
    

Beautimous. It just works!
