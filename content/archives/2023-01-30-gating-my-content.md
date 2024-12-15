---
title: Gating My Content
slug: gating-my-content
date: 2023-01-30T18:00:00.000Z
date_updated: 2023-03-21T02:37:52.000Z
tags: 
  - Netlify
  - Eleventy
  - Azure
  - Development
excerpt: Working through https://www.stackbit.com/blog/gating-content-jamstack to password protect some of the content at https://Wieting.TamaToledo.com is my tech pursuit today.   
---

# Gating Content in JAMstack Sites

This section's title was borrowed from a [Stackbit](https://www.stackbit.com/) article with the same title, [Gating Content in JAMstack Sites](https://www.stackbit.com/blog/gating-content-jamstack). Working through that article to password protect some of the content at [https://Wieting.TamaToledo.com](https://wieting.tamatoledo.com/) is my tech pursit today.

# Nope, Not on Netlify

Last evening I took a shot at implementing the *Netlify Identity* tricks from the aforementioned article, but could not easily get it to work. The problem, I think, is that the [https://Wieting.TamaToledo.com](https://wieting.tamatoledo.com/) on *Netlify* already uses *Netlify Identity* for authentication of my *Netlify CMS* forms, and adding a second, separate instance of that service isn't trivial and perhaps isn't even feasible. I also tried implementing some quick [StatiCrypt](https://www.npmjs.com/package/staticrypt) CLI protection but that also failed. *Netlify* does provide a really quick and painless solution, but it costs $20/month, at a minimum, to enable it.

# New StatiCrypt Strategy?

So, my next shot at this will involve creating a new [Eleventy](https://www.11ty.dev/) site just for the Wieting's protected content. Wish me luck and follow along here if you like.

# Trying Azure DevOps

I recently created a personal Azure account, registered to *[summitt.dweller@gmail.com](mailto:summitt.dweller@gmail.com)*, and last evening (January 31, 2023) I took a dive into [Azure DevOps](https://file+.vscode-resource.vscode-cdn.net/Users/mark/GitHub/blogs-SummittDweller/content/posts/2023/01/gating-content.md) under that account. The "welcome" email that I received says I now have an "organization" URL at [https://dev.azure.com/summittdweller](https://dev.azure.com/summittdweller).

I jumped into Azure DevOps because it looks like within that environment I can establish a Content Management System (CMS) not unlike the *NetlifyCMS* (or perhaps it IS NCMS) that I run for the Wieting Theatre, hosted with Netlify.com. I really like *NetlifyCMS*, but thus far I've had limited success with it, and ONLY at Netlify.com where the user authentication process is nicely streamlined. I hope that Azure DevOps has user authentication that's just as easy to manage, and at less cost.

So, I guess the strategy now is to see what Azure DevOps has to offer, rather than venturing further with [StatiCrypt](https://www.npmjs.com/package/staticrypt).

---

That's a TEMPORAY wrap, this post isn't finished just yet.
