---
title: Migrating the Wieting Site in Drupal 8
slug: migrating-the-wieting-site-in-drupal-8
date: 2020-02-28T00:00:00.000Z
date_updated: 2023-04-02T03:50:55.000Z
---

# Migrating the Wieting Site in Drupal 8

Sorry for my extended absence here, I’ve been uber-busy with work, but have also been able to work a little (lots of long nights and weekends) on a long-overdue update of [https://Wieting.TamaToledo.com](https://Wieting.TamaToledo.com) in *Drupal 8*.  It’s true, I have been thinking about moving that site to make it static, almost certainly using *Hugo*, but I thought before doing so I’d give *Drupal 8* one more try.  I’m pleased to report that it’s working nicely again.  Here’s how I did it, and how I plan to keep it updated…

## Saved by “docker-compose-drupal”

I actually started the process of migrating and updating [the Wieting website](https://wieting.tamatoledo.com) in *Docksal*, but I failed… I could never figure out how to reliably and easily push my work to production from there.  *Docksal* just seems to wrap so much of itself into the `cli` container that drives it, I found it difficult to de-couple from that in production.

So I went looking elsewhere and discovered [Lando](https://devwithlando.org), and I did considerable work with it because *Lando*, at least in the case of *Drupal*, builds a 3-part development stack that looks a lot like what I wanted to deploy in production.  The parts of a *Lando* stack, and my production stack, are the same:

- An `nginx` web server container,
- A `mysql` or `mariadb` database container, and
- A `php` codebase container.

But once again I had trouble figuring out exactly how to push that development stack to production.  So, I went looking again for an open (and by that I mean “free” and freely modifiable) production-ready stack configuration that uses the 3-parts I had in mind.  I found [docker-compose-drupal](https://github.com/mogtofu33/docker-compose-drupal) and almost immediately created [my own fork](https://github.com/SummittDweller/docker-compose-drupal) of that project. Using [my `docker-compose-drupal` fork](https://github.com/SummittDweller/docker-compose-drupal) I set off to build a production instance, NOT a development instance, on my `summitt-dweller-DO-docker` droplet at *DigitalOcean*.  That project came to life in `/opt/docker-compose-drupal` there.

The evolution of `summitt-dweller-DO-docker:/opt/docker-compose-drupal` was quite an adventure, in large part because the *Wieting’s* web site had gone almost a year without any updates.  That meant upgrading the *Drupal* core from version 8.2.? to version 8.8.2, along with countless modules that had changed rather dramatically, so there were lots of bumps along the way.  I also had to move the site from a multi-site configuration, the old site lived in a container at `/var/www/html/web/sites/wieting`, to a *default* configuration that lives in the container at `/var/www/localhost/web/sites/default`.

Fortunately, [docker-compose-drupal](https://github.com/mogtofu33/docker-compose-drupal) includes some nice scripts and features to help with things like that, and they are nicely documented in the [project’s README.md](https://github.com/mogtofu33/docker-compose-drupal/blob/master/README.md) file.  I’ll elaborate on a few of the key features later in this post, but most of what I did during the migration and update is water-under-the-bridge, and should not need to be repeated, ever, so I won’t elaborate on all of it here.  It’s worth noting here that the work I did in my fork all happened in a branch named `wieting`.

## Moved to “wieting-D8-DO”

Once I had a new site working as I’d hoped, I wanted to begin a fresh new development and update cycle, so I used a process I’ve documented in my work blog: [“How to Create a New GitHub Repo from an Existing Branch”](https://static.grinnell.edu/blogs/McFateM/posts/065-create-new-github-project-from-a-branch/). That work created the *Wieting* site’s new home, [https://github.com/SummittDweller/wieting-D8-DO](https://github.com/SummittDweller/wieting-D8-DO), based on the *wieting* branch of the aforementioned fork of *docker-compose-drupal*.

## Site Update Workflow

Having built the [wieting-D8-DO](https://github.com/SummittDweller/wieting-D8-DO) project I need a reliable workflow that I could use to keep it up-to-date.  I created that workflow by migrating the existing production site at `summitt-dweller-DO-docker:/opt/docker-compose-drupal`, where it responded as *[https://Wieting.TamaToledo.org](https://Wieting.TamaToledo.org)*, to a new staging copy at `summitt-dweller-DO-docker:/opt/wieting-D8-DO`, where it would respond, temporarily, at my designated “staging” address, *[https://Wieting.SummittServices.com](https://Wieting.SummittServices.com)*.

While working as *administrator* on `summitt-dweller-DO-docker` the entire command-line process looked like this:

    echo $(date --iso-8601)cd /opt/docker-compose-drupalgit ls-files --others --ignored --exclude-standard > $(date --iso-8601).ignored.listtar czvf $(date --iso-8601).ignored.list.tar.gz --files-from $(date --iso-8601).ignored.listgpg --encrypt --recipient summitt.dweller@gmail.com $(date --iso-8601).ignored.list.tar.gzrm -fr $(date --iso-8601).ignored.list.tar.gzcd /optgit clone https://github.com/SummittDweller/wieting-D8-DO.gitcd wieting-D8-DOcp -f ../docker-compose-drupal/2020-02-27.ignored.list.tar.gz.gpg .gpg --decrypt 2020-02-27.ignored.list.tar.gz.gpg > ignored.tar.gztar xzvf ignored.tar.gzrm -f ignored.tar.gzcd ../docker-compose-drupalscripts/mysql dumpmv -f database/dump/dump.sql /opt/wieting-D8-DO/database/mysql-initcd /opt/wieting-D8-DOnano .envnano docker-compose.ymldocker-compose up -d

### Breaking the Workflow Down

Moving the site from `/opt/docker-compose-drupal` and [https://Wieting.TamaToledo.com](https://Wieting.TamaToledo.com), to `/opt/wieting-D8-DO` and [https://Wieting.SummittServices.com](https://Wieting.SummittServices.com) is a command-line process like this, with comments…
Comments / Commands# Set the working directory to the server’s project root, then `git clone` the *wieting-D8-DO* project.
`cd /opt`
`git clone https://github.com/SummittDweller/wieting-D8-DO.git`# Save today’s date in ISO 8601 format to `${today}`; we will use it a few times later on. 
`today=$(date --iso-8601)`# Set working directory to the initial project. Put the site into ‘maintenance_mode’, flush all caches, dump a copy of the project’s database, move previously dumped databases to an *.inactive* directory, and move the dumped database so it will initialze the new site upon startup. 
`cd /opt/docker-compose-drupal`
`scripts/drush sset system.maintenance_mode 1 --input-format=integer`
`scripts/drush cr`
`scripts/mysql dump -f dump_${today}.sql`
`mv -f /opt/wieting-D8-DO/database/mysql-init/*.sql /opt/wieting-D8-DO/database/mysql-init/.inactive/`
`mv -f database/dump/dump_${today}.sql /opt/wieting-D8-DO/database/mysql-init/`# Fetch a list of ignored files, then *tar* the ignored files to make an archive, and encrypt the tarball for security purposes, then remove the itermediate tarball. 
`git ls-files --others --ignored --exclude-standard > ${today}.ignored.list`
`tar czvf ${today}.ignored.list.tar.gz --files-from ${today}.ignored.list`
`gpg --encrypt --recipient summitt.dweller@gmail.com ${today}.ignored.list.tar.gz`
`rm -fr ${today}.ignored.list.tar.gz`# Now set the working directory to the new project, copy the tarball from the old site to the new one, decrypt and then restore/extract the tarball contents, and finally, remove the intermediate tarball. 
`cd /opt/wieting-D8-DO`
`cp -f ../docker-compose-drupal/${today}.ignored.list.tar.gz.gpg .`
`gpg --decrypt ${today}.ignored.list.tar.gz.gpg > ignored.tar.gz`
`tar xzvf ignored.tar.gz`
`rm -f ignored.tar.gz`# Working in the new directory, edit the *.env* file to set `PROJECT_NAME`, `NGINX_HOST_HTTP_PORT` and `NGINX_HOST_HTTPS_PORT` that won’t conflict with existing names. 
`nano .env`# Still in the new directory, edit the *docker-compose.yml* file to set the *nginx* service `labels:` to include  `traefik.frontend.rule=Host:wieting.SummittServices.com`, to properly address the new site. 
`nano docker-compose.yml`# Spin up the new site for testing. 
`docker-compose up -d`# Turn off ‘maintenance_mode’ in both sites. 
`/opt/docker-compose-drupal/scripts/drush sset system.maintenance_mode 0 --input-format=integer`
`/opt/wieting-D8-DO/scripts/drush sset system.maintenance_mode 0 --input-format=integer`
That worked nicely!  Time to end this saga, but I’ll return shortly, in another post, to document my workflow for ongoing maintenance and updates.  Until next time…
