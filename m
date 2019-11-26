Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF00710A745
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKZX4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 18:56:43 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:64764 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKZX4m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 18:56:42 -0500
Received: from hp-x360n.lan (unknown [184.169.45.4])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47N15c4Wn7z1NdK;
        Tue, 26 Nov 2019 18:56:35 -0500 (EST)
Date:   Tue, 26 Nov 2019 15:56:29 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0jOmhe74rMLcMMNqtWZNuxrLPvjMsnQ3ka299VNbcSRtg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911261542430.2523@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com> <alpine.DEB.2.21.1911260833250.2714@hp-x360n> <12933162.9b7K5rSXZx@kreacher> <alpine.DEB.2.21.1911261102180.2714@hp-x360n>
 <CAJZ5v0jOmhe74rMLcMMNqtWZNuxrLPvjMsnQ3ka299VNbcSRtg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:

> Well, it would be useful to try it anyway.

Welp, so far, so good- and you MUST have changed something for sure, as I'm
getting these that I never got before; I suspended my laptop at 13:50 to
head to the airport (and yeah, I'm at 35K ft sending this :) ) and I just
opened my laptop for the first time now (15:38) ;

----
$ egrep 'suspend e' /var/log/syslog
...
Nov 26 13:50:09 hp-x360n kernel: [ 4601.889382] PM: suspend entry (s2idle)

Nov 26 14:04:21 hp-x360n kernel: [ 5452.857469] PM: suspend exit
Nov 26 14:04:24 hp-x360n kernel: [ 5455.950753] PM: suspend entry (s2idle)

Nov 26 14:04:34 hp-x360n kernel: [ 5465.709205] PM: suspend exit
Nov 26 14:05:04 hp-x360n kernel: [ 5496.135123] PM: suspend entry (s2idle)

Nov 26 14:05:23 hp-x360n kernel: [ 5515.506735] PM: suspend exit
Nov 26 15:06:56 hp-x360n kernel: [ 9210.061126] PM: suspend entry (s2idle)

Nov 26 15:13:02 hp-x360n kernel: [ 9575.620949] PM: suspend exit
Nov 26 15:23:04 hp-x360n kernel: [10178.010968] PM: suspend entry (s2idle)

Nov 26 15:26:07 hp-x360n kernel: [10361.368381] PM: suspend exit
Nov 26 15:36:10 hp-x360n kernel: [10964.067995] PM: suspend entry (s2idle)

Nov 26 15:38:13 hp-x360n kernel: [11087.514354] PM: suspend exit
----

So there were some 5 times where my laptop spontaneously (I'll bet it was
that damned accelerometer) woke up, sometimes for minutes at at time, all
the while in my laptop bag. I have a recessed power button on this thing
so I don't think it was getting bumped.

But the great news about this is this maybe explains why I'll try and resume
after being mobile; whatever awakening we used to do wouldn't be handled
(again, guessing :)) and we'd freeze up.

I keep saying the best way to break something "fixed" is to pubically
announce it so, so I'ma do it- but I have a good feeling about your last
patchset.

Now- how do I go about figuring out how to keep (what I can only assume is
the EC) quiet unless I'm actually trying to work on this thing? I can go back
to "ec_no_wakeup" but it seems like we're so close, might as well keep on going!

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
