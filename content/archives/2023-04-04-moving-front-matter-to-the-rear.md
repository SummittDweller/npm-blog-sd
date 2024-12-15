---
title: Moving Front Matter to the Rear
slug: moving-front-matter-to-the-rear
date: 2023-04-04T18:17:54.000Z
date_updated: 2023-04-05T13:35:45.000Z
hero_image: https://images.unsplash.com/photo-1567972787460-5b9f5f23f514?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDd8fHJlYXJ8ZW58MHx8fHwxNjgwNjMyMjMx&ixlib=rb-4.0.3&q=80&w=2000
---

I've been using an iOS app called *Publisher for Ghost* to craft and post new microposts from my iPhone.  Just one problem so far... I can't seem to successfully edit and save `excerpt` content so my current scheme of populating the `excerpt` with "front matter" isn't working well.  So, it's time to move that front matter out of the `excerpt` and to the end of the content body.

Update: *Publisher for Ghost* just isn't cutting it so I did a little research and am on the cusp of making a switch... to [Ulysses](https://ulysses.app/), because it has a great little piece of *Ghost* integration built-in.

Note that in the remainder of this article there are references to the delimiter I use to set my "rear matter" apart from other content.  That delimiter is a series of three consecutive `-/` pairs, for a total of 6 characters.  These 6 characters actually form two 3-character delimiters, the first `dash-slash-dash` marks the end of the "content" while the second `slash-dash-slash` marks the beginning of the "rear matter" data.

So, my example format (from this very post) for "rear matter" data looks a little like this, but with NO spaces:

    -/ -/ -/
    location: Toledo, IA
    explanation: There's a reason why I choose an odd delimiter.  Read on.
    

## Code

The code responsible for parsing this "rear matter" is from my `custom.js` and it reads like this:

         // Set post.data defaults
        post.data = '';
        post.data.type = 'post'
        post.data.location = 'Toledo, IA';
    
        // Looking for -/ -/ -/ to define end of content and start of our front matter
        // Replace post.html with everything above the last -/ -/ -/ delimiter
        let parts = post.html.replace(/<!--.*-->/gi, '').split('-/ -');
        let len = parts.length;
        if (len > 1) {
          let frontmatter = parts[len-1].replace(/<.*>/gi, '\n');
          let parsed = matter(frontmatter, {delims: '/- /'});
          post.data = parsed.data;
          post.html = parts.slice(0, -1).join('')
          post.excerpt = post.html.replace(/(<([^>]+)>)/gi, "")
        } 
    
    

## Why the Odd Delimiter?

Well, because I said so.  Since my code pulls from `post.html` I found it necessary to first `split` the post, then remove any/all HTML tags from the "rear matter" portion before passing that into the *gray-matter* package and the `matter` function for parsing.

So, the `dash-slash-dash` is used to split the `post.html` and the `slash-dash-slash` after it becomes the opening delimiter for the `matter` function.  Using `------` or anything beginning with `---` wasn't ideal because the Markdown editors I use frequently convert those into `<hr>` tags.

Another factor, I find the `-/` combination is easy to type on my iPhone because both characters appear on the same "special characters" keyboard, so I don't have to switch keyboard in between, and they are positioned side-by-side.

-/-/-/

location: Toledo, IA

explanation: There's a reason why I choose an odd looking delimiter.  Read on.
