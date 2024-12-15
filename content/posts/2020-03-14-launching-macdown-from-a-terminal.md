---
title: Launching MacDown from a Terminal
slug: launching-macdown-from-a-terminal
date: 2020-03-15T00:00:00.000Z
date_updated: 2023-04-02T03:50:44.000Z
---

Lately I find that I like to open *Markdown* documents in *MacDown* rather than *Atom*.  This is espeically true of things like “README.md” documents that I intend to read, but not edit. This can be done without any special configuration, assuming *MacDown* is installed and working.  To do that use a syntax like this:

    open -b com.uranusjr.macdown path/to/document.md

A command I’ve been using quite often today is: `open -b com.uranusjr.macdown ~/GitHub/dg-isle/docs/install/install-local-migrate.md`.

That’s a wrap. Until next time…
