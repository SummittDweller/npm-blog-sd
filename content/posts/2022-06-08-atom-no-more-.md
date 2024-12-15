---
title: Atom No More?
slug: atom-no-more-
date: 2022-06-09T00:00:00.000Z
date_updated: 2023-04-02T03:49:32.000Z
---

Yesterday one of my library colleagues at Grinnell College posted an [announcement](https://github.blog/2022-06-08-sunsetting-atom/) that [Atom](https://atom.io) would be retired (sunset) in December 2022.  Ouch, I have a lot of workflows that depend on *Atom*!

So, today part of my mission is to begin the process of migrating workflows, both work-related and personal/at-home, from *Atom* to its most logical replacement, [Visual Studio Code](https://code.visualstudio.com/) or *VS Code* as it’s largely known in the development community.  The other part of today’s mission was to update [this blog](https://blog.summittdweller.com/), something I’ve not done in far too long!

What better time to begin using *VS Code* than right now, to edit [this blog post](http://localhost:1313/posts/2022/06/atom-no-more/posts/2022/06/atom-no-more/)?  So, that’s what I did, er, am doing.

This could be a long story, but I’ll keep it short and just share the links, mostly.  I’ll begin on my personal Mac Mini, where I’m editing now, so I can test the entire process before repeating it on my other Mac workstations.

## Install Using Homebrew

I like to use `homebrew` whenever possible to manage installations on my Mac. On this Mac Mini I found [this Homebrew Formulae](https://formulae.brew.sh/cask/visual-studio-code) and put it to use…  All done.  Nice!

## Adding a Command Line / Terminal Shortcut

I’ve gotten quite used to launching *Atom* in my working directory with a simple command of the form `atom .`.  Can I do the same with *VS Code*?  Sure!  I used the guidance found in [How to Open Visual Studio Code From Your Terminal](https://www.freecodecamp.org/news/how-to-open-visual-studio-code-from-your-terminal/) to set that up.  Piece of cake.  I love finding timely, not stale, advice that just works!

Now I can simply navigate to a project folder on my Mac and type `code .` to open it all in *VS Code*.  Sweet!

## Replacing My Atom Packages

There are quite a few, nothing that I’ve written personally, but lots of published packages/extensions borrowed from others.  That’s one of the things I love(d) about *Atom*. On my Mac Mini, and most other Macs, that list looks something like this:

![My Installed Atom Packages](http://localhost:1313/img/my-atom-packages.png)

I told you there were quite a few.  I’m posting this image of my list just so I have a document as I begin to build the same into *VS Code*.  Oh, when I added the above image to this post, I did so by dragging my screen-capture from my desktop directly into the *VS Code*`EXPLORER` panel (left side of my window), just like I used to do with *Atom*.  Nice!

I’ll take my time and start replacing these as-needed.  First up…

### Replacing `ISO 8601 timestamp`

This *Atom* package allows me to add the current date and time, in ISO 8601 format, to the frontmatter of a blog post like the one you are reading now.  I found and followed [this documentation](https://marketplace.visualstudio.com/items?itemName=jsynowiec.vscode-insertdatestring) to set it up in *VS Code*.  In *Atom* I put my cursor at the point where my timestamp was needed, and went to the `Packages` menu to insert it.  In *VS Code* there doesn’t appear to be such a menu, but the documentation says I can use `command-shift-P` to open the “command pallette”, where I can scroll to or search for the command I want to engage.  Another piece of cake!

The result of inserting the current timestamp should be reflected in the frontmatter of this blog post.  😀

## More Goodies

This morning I updated this entry after adding a `Duplicate file or directory` command using the [Duplicate Action](https://marketplace.visualstudio.com/items?itemName=mrmlnc.vscode-duplicate) extension from the marketplace.  It works very nicely!

What’s could be better?  Well, finding a list of [10 “must-have” *VSCode* extensions](https://dev.to/gsdev/10-vscode-extensions-i-can-t-live-without-1i5c) and working my way through them!

## Luna Paint

I just stumbled across another handy *VSCode* extension, `Luna Paint`.  I’ve installed it, took all of 2 minutes to update TWO Macs, using the guidance provided in [this YouTube video](https://www.youtube.com/watch?v=I_6bZQZheC0).  It rocks!   2022-07-19T10:07:39-05:00

---

With any luck I’ll be able to use this post to perform much the same configuration on my other Macs, soon.  I promised I’d keep this long story short, so, until next time…
