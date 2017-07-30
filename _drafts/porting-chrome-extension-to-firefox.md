---
layout: post
title: Porting Chrome Extension to Firefox
categories: Web
date: 2017-07-21 15:53:44 +08:00
tags: mozilla
excerpt_separator: <!--more-->
---

Background: focus blocker
User graph
The API I used
manifest change
Browser style screenshot

Testing
web-ext
about:debugging

Review
need bump version
Remove console.log
No unused files
No remote scripts
official review criteria

Three years ago, I wrote the [FocusBlocker](oldfb) to help me focus on my master thesis. It's basically a website blocker that stops me from checking Facebook every five minute. But is different from other blockers like [LeechBlock](leechblock) that requires you to set a fixed schedule. FocusBlocker lets you set a quota, e.g. I can browse 10 minutes of Facebook then block it for 50 minutes. So as long as you have remaining quota, you can check Facebook anytime. I'm glad that other people find it useful, and I even got my first donation through AMO because of happy users.

Since this extension serves my need, I'm not actively maintaining it or adding new features. But I was aware of Firefox's [transition from the legacy Add-on SDK to WebExtension API](transition). So before WebExtension API is fully available, I started to migrate it to Chrome's extension format. But I didn't got the time to actually migrate it back to Firefox, until a user emails me asking for a WebExtension version. I looked into the statistics, the daily active user count drops from ~1000 to ~300. That's when I rolled up my sleeve and actually migrated it in one day. Here is how I did it and what I've learned from the process.

<!--more-->

# What needs to be changed
To evaluate the scope of the work. We need to first look at what APIs I used. The FocusBlocker Chrome version uses the three main APIs:

* `chrome.tabs`: to monitor new tabs opening and actually block existing tabs.
* `chrome.alarm`: Set timers for blocking and unblocking.
* `chrome.storage.sync`: To store the settings and persist the timer across browser restarts.

It's nice that these APIs are all supported (at least the parts I used) in Firefox, so I don't really need to modify any JavaScript code.

I loaded the manifest directly in Firefox's `about:debugging` page (you can also consider use the convenient [`web-ext`][web-ext] command line tool), but Firefox rejects it.

![about_debugging]

That's because Firefox requires you to set a unique `id` for each extension (you can read more about the `id` requirement [here][id_req]), and you must set a minimal version of Firefox on which the extension works, like so:

```
"applications": {
  "gecko": {
    "id": "focusblocker@shing.lyu",
    "strict_min_version": "48.0"
  }
},
```

There is one more modification need. Chrome uses the [`options_page` setting][options_page] to set the settings page, You need to write your own html page and css. But Firefox can apply its system style for your settings page, so the UI looks like part of the Firefox setting. You only need to set the following setting in the `manifest.json` file:

```
"options_ui": {
  "page": "options.html",
  "browser_style": true
},
```

That's all I need to port the extension from Chrome to Firefox. Super easy! The WebExtension team really did a good job on making the extensions compatible.

# Publishing the extension on AMO

To publish the extension on [addons.mozilla.org][amo], you need to zip all the files in a zip and upload it. Here are some tips for passing the review more easily. 

* You can't just upload a WebExtension-API-backed extension to replace your already-listed legacy extension, so please create a new listing.
* Don't pack any unnecessary file into the zip, exclude all the temporary test files from the zip.
* Remove or comment out all the `console.log()` calls. Although it's not a strict requirement, but it will make the review process much smoother.
* If you use any third party library, consider including (i.e. "vendoring") the file into the zip, or at least upload the source for review.
* If you've upload one version and you'd like to make some modifications or fix, you need to bump the version number, no matter how small the change is.

Here are the official review criteria, for your reference. 

Firefox is planning to completely roll out the new format in version 57 (around November, 2017). So if you have a legacy Firefox extension, or a Chrome extension you want to convert, now is a perfect timeing. 
