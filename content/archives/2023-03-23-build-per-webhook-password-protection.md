---
title: Built by Webhook + Password Protection
slug: build-per-webhook-password-protection
date: 2023-03-24T03:32:33.000Z
date_updated: 2023-03-24T03:44:16.000Z
hero_image: https://summittservices.blob.core.windows.net/summitt-dweller-blog/images/2023/03/Screenshot-2023-03-23-at-21.38.05.png
tags: 
  - Development
  - DigitalOcean
excerpt: My `https://blog.SummittDweller.com/rebuild.html -> DigitalOcean` trigger and webhook should do the job nicely since I'll be able to trigger it even from my iPhone when needed.
---

Today I used the resources you see in the [OneTab](https://www.one-tab.com/page/yNIzSr1nS_eCow7rVQFwdw) shown above to build a trigger from a [password-protected page in this blog](https://blog.SummittDweller.com/rebuild.html) to a DigitalOcean webhook.  The purpose of the webhook is to rebuild and subsequently deploy the entire blog.

I thought about using a traditional Ghost action, like `site.changed`, to do this but I frequently like to post 3 or more blog updates in rapid succession, and I didn't want Ghost triggering back-to-back-to-back rebuilds all of the time. Why not?  Because I'm cheap and I didn't want to blow through the limited quota of build minutes that my inexpensive DigitalOcean account provides.

My `https://blog.SummittDweller.com/rebuild.html -> DigitalOcean` trigger and webhook should do the job nicely since I'll be able to trigger it even from my iPhone when needed.

## The POST in `rebuild.njk`

Sometime soon I hope to create a diagram showing all the components and relationships/communication between the parts, but for now this brief explanation will have to suffice.

`rebuild.njk` is a Nunjucks template at the root of my Eleventy site with a defined permalink of `rebuild.html`.  Inside that `.njk` is a POST script that begins in the third line of the snippet shown below.

    {% extends 'layouts/default.njk' %}
    
    {% set codeinjection_head = "<script>
      fetch('https://api.digitalocean.com/v2/apps/86d9d69d-4a0e-4686-931b-69650094db15/deployments', {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ********** obfuscated ************',
        },
        body: JSON.stringify({ 'force_build': true })
      })
      .then(response => response.json())
      .then(response => console.log(JSON.stringify(response)))
    </script>" %}
    {% set codeinjection_foot = doc.codeinjection_foot %}
    
    {% set title = "Rebuild!" %}
    ...
    

The *** obfuscated *** portion is a secret.

## DigitalOcean's Response

That POST, when received by DigitalOcean, signals DO to trigger a rebuild of the site which has been programmed in the apps' DO settings to execute a build command of `yarn build` followed by `yarn encrypt`.

- 
The first command, `build` is defined in `package.json`, and using `.eleventy.js` it builds the site into a static collection of files in the project's `./dist` directory.

- 
The second command, `encrypt`, also defined in `package.json`, executes the `staticrypt` utility to encrypt `./dist/rebuild.html` placing a login page in front of it.

## StatiCrypt

The encryption provided by StatiCrypt effectively "hides" the authorization token, obfuscated above, from pyring eyes.

I built the encryption process in this site based on previous experience described in [Protecting Pages with StatiCrypt CLI](https://static.grinnell.edu/dlad-blog/posts/141-gating-my-content-and-more-parts-34/) and the references listed therein.  I borrowed pieces of several files from the project chronicled in that blog post, namely:

- 
`auth/login.html` - The login page that gets placed in front of `rebuild.html`

- 
The `encrypt` script definition which appears in `package.json`.  It reads:

        "encrypt": "staticrypt ./dist/rebuild.html '***************' --short -o ./dist/rebuild.html -f ./src/auth/login.html -t 'Summitt Dweller Blog - Rebuild' -i 'Please enter the passphrase.<br/>Hint: gh0st' --label-error 'Sorry, Ella says no. Try again.'"
    

- 
The `"staticrypt": "^2.4.0"` addition to the `dependencies:` portion of `package.json`

- 
The `- run: yarn encrypt` addition to the end of the `steps:` of the project's `.github/workflows/build-and-deploy.yml` file.
