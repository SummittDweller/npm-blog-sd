---
title: My Photos Workflow
slug: my-photos-workflow
date: 2019-07-04T00:00:00.000Z
date_updated: 2023-04-02T03:51:06.000Z
---

I recently returned from vacation in Norway with a few hundred photos and a handful of videos, taken mostly using my iPhone 8.  I find that the Apple Photos app does a pretty nice job of cataloging photos and videos into `Moments`.  Each `Moment` includes all the images taken in a single day, and sometimes in a particular location, if photos are taken on the same day, but a great distance apart.

Moment names from my Norway vacation were nicely descriptive, like:

- Minneapolis-Saint Paul International Airport - Minneapolis, MN, June 11, 2019
- Paris Charles de Gaulle Airport - Mauregard, Île-de-France, June 12, 2019
- Jessheim - Akershus, June 12, 2019
- Kirkenes, Finnmark - Johan Knudtzens gate, June 12, 2019
- Kirkenes, Finnmark - Dr. Wessels gate, June 13, 2019
- Kirkenes, Finnmark - Johan Knudtzens gate, June 14, 2019
- Skarsvåg - Finnmark, June 14, 2019
- Arnøyhamn - Norway, June 15, 2019

## Exporting the Photos

I found [this resource](https://support.apple.com/guide/photos/export-photos-videos-and-slideshows-pht6e157c5f/mac) on the web and followed it for the export portion of my process.

So, I opened `Photos` on my Mac Mini, selected the `Moments` view/tab, culled some of the duplicates out, then selected all 359 remaining images using my mouse.  With the images highlighted I selected menu options: `File`, `Export`, and `Export 359 Photos...`. I subsequently filled in the following dialog like so:

![Photos Export Dialog](https://images.summittdweller.com/Norway-Photos-2019/PhotosExportDialog.png)

I choose a ‘Photo Kind’, or format, equal to `PNG` and a ‘Size’ equal to `Medium`, since most of the images are huge and would load very slowly in my blog if left at their original size.  I elected to save the exported PNG images into a new folder on my `~/Desktop` named `Norway-Medium-PNG-Export`.

## Upload to Digital Ocean “Spaces”

A few days ago I registered with *Digital Ocean*[“Spaces”](https://cloud.digitalocean.com/spaces?i=d7d6c7), and created my first “bucket” named `images-summittdweller`. *Spaces* provides me with up to 280 GB of REST-accessible object storage for a small monthly fee.  To host my photos there I simply created a “folder” named [Norway-Photos-2019](https://cloud.digitalocean.com/spaces/images-summittdweller?i=d7d6c7&amp;path=Norway-Photos-2019%2F) and did a drag-n-drop of each `~/Desktop/Norway-Medium-PNG-Export/` individual* folder directly into my browser window.  *Note that the drag-n-drop interface was unable to swallow the entire `Norway-Medium-PNG-Export` folder all at once. 😞

All of my uploads to the `images-summittdweller` bucket were declared as `Public` rather than `Private`, that way they can be accessed using simple URLs without authentication.

## Additional Images

In addition to the aforementioned photos, I also parked a copy of the `PhotosExportDialog.png` screen capture there in the root folder.  It’s accessible as [https://images.summittdweller.com/Norway-Photos-2019/PhotosExportDialog.png](https://images.summittdweller.com/Norway-Photos-2019/PhotosExportDialog.png) and that’s what I used above to embed the image you see in this document.

In the future, more images, perhaps some taken by Deb, Doug, or Mark McCune, can be added to this photo blog in a similar manner.

## Object Structure and URLs

A sampling of the bucket/object/filenames and URLs from `images-summittdweller` are tabulated below.  From this small sample the URL structure is easy to infer.
images-summittdweller Bucket PathURL./Norway-Photos-2019/PhotosExportDialog.png[https://images.summittdweller.com/Norway-Photos-2019/PhotosExportDialog.png](https://images.summittdweller.com/Norway-Photos-2019/PhotosExportDialog.png)./Norway-Photos-2019/Minneapolis-Saint Paul International Airport - Minneapolis, MN, June 11, 2019/IMG_0352.png[https://images.summittdweller.com/Norway-Photos-2019/Minneapolis-Saint%20Paul%20International%20Airport%20-%20Minneapolis,%20MN,%20June%2011,%202019/IMG_0352.png](https://images.summittdweller.com/Norway-Photos-2019/Minneapolis-Saint%20Paul%20International%20Airport%20-%20Minneapolis,%20MN,%20June%2011,%202019/IMG_0352.png)./Norway-Photos-2019/Tromsø - Troms, June 15, 2019/IMG_0527.png[https://images.summittdweller.com/Norway-Photos-2019/Troms%C3%B8%20-%20Troms,%20June%2015,%202019/IMG_0527.png](https://images.summittdweller.com/Norway-Photos-2019/Troms%C3%B8%20-%20Troms,%20June%2015,%202019/IMG_0527.png)
## Generating Markdown for Blog Photos

So the intent of all this is to populate the photo blogs that you see [here](http://localhost:1313/posts/2019/07/my-photo-workflow/content/photos). To that end I’ve created a simple [API](https://www.digitalocean.com/docs/api/) Python3 script based on guidance provided in [this article](https://www.digitalocean.com/community/questions/how-to-access-all-the-files-stored-in-a-spaces-folder).
