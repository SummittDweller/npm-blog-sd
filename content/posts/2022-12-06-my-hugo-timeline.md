---
title: My Hugo Timeline
slug: my-hugo-timeline
date: 2022-12-06T18:00:00.000Z
date_updated: 2023-04-05T13:05:24.000Z
hero_image:  https://summittservices.blob.core.windows.net/summitt-dweller-blog/images/2023/04/Rootstalk-Timeline.png
tags: 
  - Hugo
  - Development
  - DigitalOcean
excerpt: I've successfully added the code to drive a new `/timeline` page as part of this blog, but I did so "locally", and now I'd like to repeat the process but using the https://github.com/SummittDweller/hugo-timeline module per https://gohugo.io/hugo-modules/.
---

What follows is an excerpt from this blog's `README.md` file.

I've successfully added the code to drive a new `/timeline` page as part of this blog, but I did so "locally", and now I'd like to repeat the process but using the aforementioned [SummittDweller/hugo-timeline](https://github.com/SummittDweller/hugo-timeline)[module](https://gohugo.io/hugo-modules/).

I used guidance found in [Hugo Modules: Getting Started](https://scripter.co/hugo-modules-getting-started/) to make this happen, like so:

    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main› 
    ╰─$ brew install go
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main› 
    ╰─$ brew upgrade   # This is not "required", but probably overdue.
    
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ mkdir content/timeline/.out-of-the-way      # vvv Moving existing local stuff out of the way vvv
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ mv -f layouts/partials/hugo-timeline* content/timeline/.out-of-the-way/.   
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ mv -f layouts/shortcodes/hugo-timeline* content/timeline/.out-of-the-way/.
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ mv -f static/css/hugo-timeline* content/timeline/.out-of-the-way/.        
    
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ hugo mod init github.com/SummittDweller/blogs-SummittDweller        
    go: creating new go.mod: module github.com/SummittDweller/blogs-SummittDweller
    go: to add module requirements and sums:
            go mod tidy
    

Next, to pull in [SummittDweller/hugo-timeline](https://github.com/SummittDweller/hugo-timeline) as a module I turned to the `config.yml` file and guidance found in [Hugo Modules: everything you need to know!](https://www.thenewdynamic.com/article/hugo-modules-everything-from-imports-to-create/). Additions to `config.yml` are:

    module:
      imports:
        - path: github.com/SummittDweller/hugo-timeline
          mounts:
          - source: layouts
            target: layouts
          - source: static
            target: static
    

### Updating the Module

So, all of the above moves appeared to work correctly, at least locally, but I wanted to be sure I can successfully update the `hugo-timeline` module and get updated behavior in this project. The command required to make that happen per [Hugo Modules: everything you need to know!](https://www.thenewdynamic.com/article/hugo-modules-everything-from-imports-to-create/#upgrading) is:

    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ hugo mod get -u github.com/SummittDweller/hugo-timeline
    go: downloading github.com/SummittDweller/hugo-timeline v0.0.0-20221206191252-cd7178e7e43b
    go: upgraded github.com/SummittDweller/hugo-timeline v0.0.0-20221206043330-5f1ecbad913f => v0.0.0-20221206191252-cd7178e7e43b
    
    ╭─mark@Marks-Mac-Mini ~/GitHub/blogs-SummittDweller ‹main*› 
    ╰─$ hugo server
    port 1313 already in use, attempting to use an available port
    Start building sites … 
    hugo v0.107.0+extended darwin/amd64 BuildDate=unknown
    
                       | EN   
    -------------------+------
      Pages            | 288  
      Paginator pages  |   9  
      Non-page files   |   0  
      Static files     |  38  
      Processed images |   0  
      Aliases          |  79  
      Sitemaps         |   1  
      Cleaned          |   0  
    
    Built in 90 ms
    Watching for changes in /Users/mark/GitHub/blogs-SummittDweller/{archetypes,content,layouts,static,themes}
    Watching for config changes in /Users/mark/GitHub/blogs-SummittDweller/config.yaml, /Users/mark/GitHub/blogs-SummittDweller/go.mod
    Environment: "development"
    Serving pages from memory
    Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
    Web Server is available at //localhost:62846/ (bind address 127.0.0.1)
    Press Ctrl+C to stop
    

Eureka! The page rendered at `http://localhost:1313/timeline/` after the above `hugo mod get -u...` command is displaying the latest changes I made to `hugo-timeline`! Perfect!

---

**My work here is done, well, for now anyway.**
