---
title: Fixing a Broken GitHub Repo
slug: fixing-a-broken-github-repo
date: 2023-01-19T18:00:00.000Z
date_updated: 2023-04-05T13:12:00.000Z
hero_image: https://images.unsplash.com/photo-1654277041218-84424c78f0ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDE2fHxnaXRodWJ8ZW58MHx8fHwxNjgwNzAwMjkw&ixlib=rb-4.0.3&q=80&w=2000
tags: 
  - Development
  - Git
excerpt: 

---

### *Don't Push Enormous Files to GitHub!*

Pay close attention to the statement above!  A couple of days ago I was working on content for [Tama-Toledo Community Visioning](https://cv.tamatoledo.org/) and I added a large `socialmedia.zip` file to the source repo, and then very stupidly pushed it to GitHub and the repo's `main` branch. Naturally, the push didn't finish so I removed the file and pushed a new commit to "remove it permanently". Well, that ain't how `git` works!

The "remove" commit appeared to have worked, but now the TTCV site wouldn't deploy since the build time had gone from less than 2 minutes, to more than 10 minutes. I immediately became suspicious of that pesky, large, `socialmedia.zip` file, but how could I properly get rid of it?

# Using `git filter-repo`

Fortunately, I found and followed the GitHub docs guidance in [Using git filter-repo](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#using-git-filter-repo) to remove the troublesome large file, namely `socialmedia.zip`, from the repo. The commands I used to do this included...

- **brew install git-filter-repo**
- **git clone**[https://github.com/Tama-Toledo/community-visioning](https://github.com/Tama-Toledo/community-visioning)

The above command was necessary because the next command expects a "clean", recently compressed local repository.

- **git filter-repo** --invert-paths --path socialmedia.zip
- **git remote add origin**[https://github.com/Tama-Toledo/community-visioning](https://github.com/Tama-Toledo/community-visioning)
- **git push origin --force --all**
- **git branch --set-upstream-to=origin/main** main

# It Worked!

The good news, this worked, and I now have my repo back in shape such that I can successfully deploy it again.

---

That's a wrap. Oh, in case you want to know what happened to `socialmedia.zip`, check out that project's [README.md](https://github.com/Tama-Toledo/community-visioning/blob/main/README.md) file.
