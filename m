Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6E1086DA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 04:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKYDk2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 22:40:28 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:41428 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKYDk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 22:40:28 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Lt8k3KMbz1FcH;
        Sun, 24 Nov 2019 22:40:22 -0500 (EST)
Date:   Sun, 24 Nov 2019 19:40:19 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911241929220.16116@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com> <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
 <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Thanks for getting back to me.

On Sun, 24 Nov 2019, Rafael J. Wysocki wrote:

> > If "sleep_no_lps0" == 1, the machine never goes fully to sleep; the power
> > light stays on and the backlight goes off, but if I have external monitors
> > connected they're still showing dmesg activity. This is independent of the
> > state of "ec_no_wakeup".

> Hmm.  The external monitors part is something you have never mentioned.

I didn't realize that myself until I'd tried "sleep_no_lps0" testing for this
thread and happened to have my Thunderbolt dock connected.

> > If "ec_no_wakeup" == 1, the system *at times* will go to sleep and never return

> This is unclear.  What exactly do you mean by "go to sleep"?

It appears to do a suspend cycle; the screen goes off, the power light goes out,
and the power consumption (as measured at the charge port) (usually) goes to the
smallest draw this laptop is capable of in s2idle.

> Which part of the behavior does the "at times" phrase apply to?  The
> "going to sleep" or coming back?  Or both?

The coming back. Many times I'll hit a key on the keyboard (when "ec_no_wakeup"
is set) or open the lid or hit the the power button (if it's not set) and nothing
happens. IIRC the current draw doesn't increase either, but don't quote me on
that (it's easy enough to reproduce, so I'll try it out and report back).

> > (i.e. no power light comes on, it's totally unresponsive until I do a hard
> > reset with a power-button long-press) whether I'm plugged in or not.
> > This is new behavior.

> So how did it behave in 5.3.y?
...
> > Help! What can I do to return to the behavior of right before the s0 rework?
> I guess you mean the 5.3.y behavior.  And what was it?
...

Seemed to always work; I don't recall any issues with s2idle in earlier
kernels. Sometimes my idle draw would be much higher than it should be, but
I have zero clue as to why that is (which is why I'm chasing down bleeding-
edge PM commits).

> > If "ec_no_wakeup" == 0, the system goes fully to sleep and either of the
> > power button, lid opening or hitting a key resumes the laptop, but if I'm
> > plugged in and actually charging when I suspend (and I suspect if I plug
> > it in during suspend) it never returns, as in the case above.

> OK, so ec_no_wakeup doesn't really change the behavior substantially,
> it only makes certain things more or less likely to happen.
> Does it still hang if you use the keyboard to wake up the system?

When "ec_no_wakeup" is set, ONLY the keyboard wakes up the system, and the dead
system is unrelated to the method I'm using to wake things up.

> > Where in the code could I start looking to try to find out where the machine
> > goes dead?
>
> Well, because you identified 56b991849 as the first bad commit, the
> following three lines of code in drivers/acpi/sleep.c are likely to be
> the source of the problem:
>
>         acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
>         acpi_ec_flush_work();
>         acpi_os_wait_events_complete(); /* synchronize Notify handling */
>
> Can you please try to comment them out and retest?

I'll do that and get back to you.

> Note that you most likely won't be able to wake up the system via the
> lid/power button without them

Yeah, I'm used to that.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
