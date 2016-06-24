---
layout: post
title: Identify Performance Regression in Servo
categories: Web
date: 2016-06-24 14:32:19 +08:00
excerpt_separator: <!--more-->
---

Performance has always been a key focus for the Servo browser engine project. But just measure the performance through profilers and benchmarks is not enough. The first impression to a real user is the page load time. Although many internal, non-visiable optimizations are important, we still want to make sure our page load time is doing well.

Back in April, I opened this bug [#10452](https://github.com/servo/servo/issues/10452) to start planning the page load test. With the kind advice from the Servo community and the Treeherder people, we finally settled for a test design similar to the Talos test suite, and decided to use Perfherder for visualization.

<!--more-->

## Test Design
[Talos](TBD) is a performance test suite designed for Gecko, the browser engine for Firefox. It has many different kinds of tests, covering user-level UI testing and benchmarking. But what we really care about is the [TP5](TBD) page load test suite. As the [wiki](TBD) says, TP5 use Firefox to load 51 scrapped websites selected from the [Alexa Top 500](TBD) sites of its time. Those sites are hand-picked, then downloaded and cleaned to remove all external web resources. Then these web pages are hosted on a local server to reduce network latency impact.

Each page is tested three times for Servo, then we take the medium of the three. (We should test more times, but it will take too long.) Then all the mediums are averaged using [geometric mean](TBD). Geometric mean has a great property that even if two test results are of different scale (e.g. 500 ms v.s. 10000 ms), if any one of them changed by 10%, they will have equal impact on the average.

## Visualization

Talos test results for Gecko have been using Treeherder and Perfherder for a while. The former is a dashboard for test results per commit; the latter is a line plot visualization for the Talos results. With the help from the Treeherder team, we were able to push Servo performance test results to the Perfherder dashboard. I had a [blog post](TBD) on how to do this.

Here is how Perfherder looks like:
![Perfherder]*(TBD)

## Implementation

We created a [python test runner](TBD) to execute the test. To minimize the effect of hardware differences, we run the Vagrant (VirtualBox backend) virtual machine used in Servo's CI infrastructure. (You can find the Vagrantfile [here](TBD)). The test is scheduled by [buildbot](TBD) and runs every midnight.

The test results are collected into a JSON file, then consumed by the test result [uploader script](TBD). The uploader script will format the test result, calculate the average and push the data to Treeherder/Perfherder throught the [Python client]

(version json)

## The 25% Speedup!


* Background
  * Why we need
  * tracing bug
  * talos and treeherder
* Test design
  * talos
  * Frequency
  * Buildbot
* The Jun 10 improvement
* Bisecting with Buildbot
* Conclusion
* Credit
  * wlach
  * annesh
  * lars
