---
layout: post
title: How I Ditched CSS Framework for Flexbox
categories: Web
date: 2017-01-27 21:18:53 +08:00
tags: mozilla
excerpt_separator: <!--more-->
---

# Background
If you have visited this blog before September 2016, you should saw a standard website decorated with a CSS framework (I used [Foundation][]). But now if you open the developer tool in your browser, you won't see any CSS framework anymore. Back in September 2016 I migrated the whole site to [CSS Flexbox][], the not-so-new new standard of modern web layout. My site loads faster, is easier to maintain and didn't lose any compatibility. In this post I'll tell you why and how I migrated from a CSS framework to Flexbox.
<!--more-->

Just to clarify, I'm not against CSS frameworks. I use CSS frameworks a lot for fast prototyping (mostly [Bootstrap][] and [MDL][]). They enable you to create a professional-looking (or geek-looking?) website in just minutes. But they have downsides too. First, you end up including a lot of stuff you don't really need (given that you don't bother to create a custom build and just grap the standard edition from a CDN). This makes your page loads slowly and make the code hard to understand. Second, you usually use a lot of `<div>`s with crazy `class`es like "`col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0`" to layout the page. This makes your HTML unsemantic and bloats the code size. Finally, CSS frameworks usually uses a lot of JavaScript or CSS magic to ease out the difference in browsers, this is important for websites that needs to reach a wide range of audiences. But for a developer-facing blog like this one, I would prefer to promote modern web standards like [flexbox][] and [grid][] to accelerate their spread.

I have known flexbox for quite a while, but couldn't make up my mind to rewrite this blog with it. Early last September (2016), I attended the [View Source conference][] in Berlin. During that conference I heard some very inspiring talks by [Jen Simmons][], [Belen ???][] and [???][], one of the recurring topic is that they urge people to use flexbox and grid instead of using CSS frameworks blindly. They have analyzed why CSS frameworks will be a burden if you use it without thinking (you can click on their name to watch the recording, definitely worth the time!). Also, I took the responsibility to implement [flexbox][] in the [Servo][] browser engine. So I decided to take the rewrite as a exercise to understand [flexbox][] better.

As an aside: If you are interested in tracking or helping with the flexbox implementation in Servo, please check out this [tracking bug][]. It's really fun! I also found some help clarify the W3C specification by submitting a [pull request][] to the specification itself.

# How to use flexbox

I won't go though how I learned flexbox, but I'll list the resources in the end of this post.

flexbox game
Flexbox holygrial example
https://philipwalton.github.io/solved-by-flexbox/demos/holy-grail/
How to do flexbox RWD
  flex-direction with media query
  fix the width for readibility
Semantic tags
  - nav
  - dl
  - main
  - article
    - p
    - section
  - address

The result
  - More semantic code
  https://github.com/shinglyu/shinglyu.github.io/commit/c6e406559e2559860e14d96e200d3d420887ecea?diff=split
  - Easier to understand CSS
  - Reduced code size
  - Improved Performance

Resources
  - flexbox guid in css trics
  - flex game
  - solved by flexbox
  - jen simmons
  - Spec

