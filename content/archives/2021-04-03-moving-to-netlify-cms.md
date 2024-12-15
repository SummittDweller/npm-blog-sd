---
title: Moving to Netlify CMS
slug: moving-to-netlify-cms
date: 2021-04-04T00:00:00.000Z
date_updated: 2023-04-02T03:48:19.000Z
---

In my last post, [Adding *Netlify CMS* for Editing This Blog](http://localhost:1313/posts/2021/04/moving-to-netlify-cms/posts/2021/03/adding-netlify-to-this-blog/), I was able to successfully engage the [*Netlify CMS*](https://www.netlifycms.org/) with a “local” copy of this blog.  But I never got the CMS to work in production with this blog’s App on [*DigitalOcean*](https://www.digitalocean.com/) (*DO*). I should note that *DO*’s support folks were very helpful, but in the end I think all of the client-side stuff that *Netlify CMS* is doing was more than they were willing (capable?) of helping me overcome. That’s probably my fault more than their’s; client-side isn’t my strong suit.

In the week since then I have, however, been able to stand up a new working copy of the [*Wieting Theatre* website](https://wieting.Tama-Toledo.com) on [*Netlify.com*](https://www.netlify.com/), where it enjoys the same kind of automated builds and automatic deployment that I previously found at *DO*.  The big difference, at Netlify.com my *Netlify CMS* depoloyment works locally AND in production, giving me the ability to allow content editors, even those who don’t have a *Netlify.com* or *GitHub* account, to do what they do best, edit their content.

## The *Wieting Theatre*’s New Site, and the *CRB*

So this post started as a brain dump, chronicling how I got [https://Wieting.Tama-Toledo.com](https://Wieting.Tama-Toledo.com) to work.  But, instead of hashing out how I “did” it, I’m going to show you how I’m doing something similar, for a site that features the *Compass Rose Band*, or *CRB*, my brother-in-law’s band out of Cedar Rapids, Iowa.

## Netlify Identity

I think the real key to all of this is a *Netlify.com* agent called [*Netlify Identity*](https://docs.netlify.com/visitor-access/identity/). From the *Netlify.com* site and documentation…

*Netlify Identity* service brings a full suite of authentication functionality, backed by the *GoTrue* API. This allows you to manage and authenticate users on your site or app, without requiring them to be users of *Netlify* or any other service. You can use this for gated content, site administration, and more.

In theory, *Netlify Identity* can be deployed anywhere, but in practice, setting it up can be quite tricky (at least it was for me).  That’s where *Netlify.com* shines, and that’s understandable since they created both *Netlify CMS* and *Netlify Identity*. The two creations play well together, and make life easier for a devops like me. Well played indeed.

If you read my previous post you know that in a [*Hugo*](https://gohugo.io) site, like this one, the `./static/admin/config.yml` file holds all of your CMS info.  If you host content on *Netlify.com* with *Netlify CMS* and *Netlify Identity* engaged, all you really need in that config file is something like this:

    backend:  name: git-gateway  branch: main...

The rest of the CMS “magic” takes place in a server-side access manager that you can find at your *Netlify.com* site folder at `https://app.netlify.com/sites/[site-name]/identity`.  The client-side of the access/identity equation can be handled with an app template, and you can choose from many starter templates found at [Start with a Template](https://www.netlifycms.org/docs/start-with-a-template).

### External OAuth without *Netlify.com*

If you wish to proceed without using *Netlify.com* as your host, you’ll find a number of options at [External OAuth Client](https://www.netlifycms.org/docs/external-oauth-clients/). Beware, this option isn’t for a server-side guy like me, and the *Netlify.com* option is quick, easy, and cheap… at least I think so.

## Building a New *Compass Rose Band* Site on *Netlify.com*

Rather than rehashing the story of my *Wieting Theatre* migration to *Netlify.com*, I’m going to repeat that process and capture the journey while migrating our existing *Compass Rose Band* site from *DO*.

### Using *Netlify.com* and `one-click-hugo-cms`

From the [Start with a Template](https://www.netlifycms.org/docs/start-with-a-template) I clicked the `Deploy to Netlify` button under the ‘Hugo Site Starter’ option. This was super easy since *Netlify.com* already knows me… because I created a free account about a week ago. That selection took me to a screen where I was asked to identify a new *Github* repostory. Again, super easy because I had already logged in to *Github* earlier.

The default name for this new repository is `one-click-hugo-cms`, same as the template repository it will be built from. I choose to name my new repo `compass-rose-band-one-click`, for obvious reasons. That repository can be found at [https://github.com/SummittDweller/compass-rose-band-one-click](https://github.com/SummittDweller/compass-rose-band-one-click) where the `README.md` file is titled “Hugo template for Netlify CMS with Netlify Identity”. The initial repository contents looked like this:

![one-click-hugo-cms](http://localhost:1313/img/one-click-hugo-cms.png)

### Replacing the `/site`

A default *Hugo* site is automatically built and deployed for you as part of the one-click process, and *Netlify.com* will supply an address so you can see your creation. But that’s not the *Compass Rose Band*! No problem, I found it quick and easy to replace the default template site by first cloning my new repo to my workstation, and replacing the `/site` directory with my own contents.  It went like this…

- `cd ~/GitHub`  ⬅ This is where I keep local copies of all my GitHub projects.
- `git clone https://github.com/SummittDweller/compass-rose-band-one-click`
- `cd compass-rose-band-one-click`
- `git branch -m master main`  ⬅ Optional step, changes my local branch name to ‘main’.
- `rm -fr site/*`  ⬅ Remove the template site, the contents of `/site`.
- `cp -fr ~/GitHub/compass-rose-band/* site/.`  ⬅ Copy my local CRB site* to `/site`.

*Note that copying in the manner excludes all . files and directories, so the `.git` folder is NOT copied. This is IMPORTANT!

At this point, your old site has a new home in `./site` so if you navigate there and do `hugo server` you should see a local instance of the site.  Like so…

- `cd site`
- `hugo server`
- Visit `localhost:1313`, or whatever localhost site is indicated, to see your site.

### Pushing the Site to *Github*

So, now your *Netlify.com* project lives in a directory like my `~/GitHub/compass-rose-band-one-click`, and the corresponding *Hugo* site contents are in the `./site` folder there. To deploy this new copy of your site to *Netlify.com* simply do like this…

- `cd ~/GitHub/compass-rose-band-one-click`
- `git add .`
- `git commit -m 'Now with CRB site contents in ./site'`
- `git push -u origin main`

### Deploying the Site on *Netlify.com*

By default, pushing your changes to *Github* will automatically deploy them to your *Netlify.com* site, but you pushed to `main`, not `master`, so no synchornization is likely. But that’s easy to fix.

Navigate your browser to your *Netlify.com* “team” page, find your new project there, and click on `Site Settings`. Next you’ll see options for things like changing the name of your project and site.  I changed mine to `compass-rose-band-one-click` to match my *Github* repo name.

Visit the `Build & Deploy` link in the menu on the left side of the page, find the `Deploy contexts` info and click `Edit settings` there so you can change the production branch setting from `master` to `main`.  Leave the default setting of “Any pull request against your production branch / branch deploy branches” selected.

Next, visit the “Deploys” page in your *Netlify.com* project page at `https://app.netlify.com/sites/[project-name]/deploys`, mine is [https://app.netlify.com/sites/compass-rose-band-one-click/deploys](https://app.netlify.com/sites/compass-rose-band-one-click/deploys), and click the `Trigger deploy` button there.  You should then see a log of the deployment as it runs, and this time it should target your new `main` branch with your updated `./site` contents.

If successful you should see a screen featuring a block like this one:

![Successfuly deployed on &lt;em&gt;Netlify.com&lt;/em&gt;](http://localhost:1313/img/netlify-preview-deploy.png)

Click on the `Preview deploy ⬈` link and voilà, your site!

## Now…*Netlify CMS*

It’s getting late on this Sunday night so I’ll share the first few lines from the latest copy of my new project’s `./site/static/admin/config.yml` file for *Netlify CMS*.

    backend:  name: git-gateway  branch: main## To make local_backend mode work you must run 'npx netlify-cms-proxy-server' in its own terminal window##   from the project root.  See https://www.netlifycms.org/docs/beta-features/ for details.local_backend: truemedia_folder: site/static/img    public_folder: /img...

### What’s All That?

I’m back, as promised, and you’re probably asking what all that stuff in the `config.yml` file is doing? Well, as mentioned earlier, the simple `backend:` section (first three lines) links the CMS to the `main` branch of our new *Github* project.  The rest isn’t required, unless you also want to use the CMS on a local clone of the project, like when making mass edits locally.

Let me try to explain.

### `local_backend:` A *Netlify CMS* Beta Feature

If you visit the *Netlify CMS*’ [Beta Features!](https://www.netlifycms.org/docs/beta-features/) pages you’ll see `local_backend` mentioned near the very top. [*Note that as a beta feature this information is bound to move at some point.*] That feature enables configuration of an option to make the CMS avaialble when working locally on a cloned, presumably, copy of the *Github* repository.  The beta documentation mentions running `npx netlify-cms-proxy-server` as part of the process.

### A Local Problem with `./site`?  No, Not Really

So, in the local clone of my new *Compass Rose Band* one-click *Hugo* website, the “one-click” *Netlify CMS* parts live in the project’s root directory, and the *Hugo* site lives just “below” it in `./site`.  Accordingly my `media_folder:` setting shown above includes the `site/` prefix, and the same is true of all the `config.yml` keys that end in `folder:`.  This is correct for production, and it also works with a local clone IF I launch things correctly!

*Hugo* and the `hugo server` command that I need to preview local changes demands that I either `cd site` before I run it, or override the command’s path by specifying `hugo server -s site`.  Only this 2nd approach works!

So the process that’s needed for local development and testing, including *Netlify CMS* looks like this for me:

- If I don’t yet have the project locally I will begin with…`cd ~/GitHub; git clone --recursive https://github.com/SummittDweller/compass-rose-band-one-click; cd compass-rose-band-one-click`
- If I already have a local clone I’ll do this…`cd ~/GitHub/compass-rose-band-one-click; git pull`

From here on out there’s just one process, like so…

- `npx netlify-cms-proxy-server`   ⬅ In a new terminal window. See next section of this post.
- `atom .`  ⬅ Launch *Atom* in the working directory.
- `hugo server -s site`  ⬅ **Important:** Don’t forget the `-s site` option!
- Create and edit files as needed. Changes should be immediately visible in `http://localhost:1313`.
- To edit or create content using *Netlify CMS*, just visit `http://localhost:1313/admin/`.
- When all changes are complete…
- `git add .`
- `git commit -m 'a brief message here'`
- `git push`

### Requires *npx*, Part of *Node.js*

The `npx` command mentioned above requires that *npx* be installed, and it’s part of *Node.js*.  To make it run properly I followed guidance from [https://treehouse.github.io/installation-guides/mac/node-mac.html](https://treehouse.github.io/installation-guides/mac/node-mac.html) to ensure both were installed.  In at least one instance I also had to run `brew upgrade node` and `npm i -g npx` to ensure that *Node.js* was up-to-date, and that *npx* was available as needed.

The `npx netlify-cms-proxy-server`, loads and runs the *netlify-cms-proxy-server* script, and in doing so it will tie up your terminal window.  So, it’s best to **do this in a separate terminal window!**  Don’t put the command in the background (using a `&` flag at the end) as this won’t allow you to see if the command is working properly. When you run this command you should see some feedback from the script indicating what it is doing. The script binds to your working directory then effectively routes all *Netlify CMS* actions, performed in this instance via `http://localhost:1313/admin/`, to the local *git* repo there.

## Ok, Now We Need a Proper Domain

So, in its original form the *Compass Rose Band* site is aliased to three different domains:

- [https://compassroseband.net](https://compassroseband.net),
- [https://thecompassroseband.com](https://thecompassroseband.com), and
- [https://thecompassroseband.net](https://thecompassroseband.net)

I choose to try migrating these domains to the new *Netlify.com* site one-at-a-time, starting with the least-used domain, *thecompassroseband.net*.

To do this I started by visiting my *Netlify.com* account/team and the `Domains` menu, then my project-specific domain settings at [https://app.netlify.com/teams/summittdweller/dns/thecompassroseband.net](https://app.netlify.com/teams/summittdweller/dns/thecompassroseband.net).  In this page I’m given a list of 4 *Netlify.com* name servers that I can use for this particular project.  I made note of the four before moving on.

Next step was to visit my registrar, *enom.com*, where I have a control screen for editing DNS records and name servers.  I set the name server values for *thecompassroseband.net* there to the values that *Netlify.com* provided. And then, we wait… for the changes to propogate.

Fortunately, *Netlify.com* is on the ball… when I visit my new site’s domain controls page, [https://app.netlify.com/sites/compass-rose-band-one-click/settings/domain](https://app.netlify.com/sites/compass-rose-band-one-click/settings/domain), I find a widget that looks like this:

![DNS Propogation](http://localhost:1313/img/netlify-dns-propogation.png)

The cog behind “Waiting on DNS propagation” is spinning while *Netlify.com* waits for the transfer to happen.  So, I’m going to go for a walk and see what that cog looks like in an hour or two.

---

Clear as mud?  Give it a try, and hopefully it will begin to make sense.  Until next time…
