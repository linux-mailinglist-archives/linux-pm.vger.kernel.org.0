Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5391096EC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 00:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKYXcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 18:32:46 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:62769 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYXcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 18:32:46 -0500
Received: from hp-x360n (50-76-61-131-ip-static.hfc.comcastbusiness.net [50.76.61.131])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MNcR2xJFznw4;
        Mon, 25 Nov 2019 18:32:39 -0500 (EST)
Date:   Mon, 25 Nov 2019 15:32:38 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911251502490.13123@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
 <alpine.DEB.2.21.1911251155440.2817@hp-x360n> <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:

> It looks like the platform has problems with switching power between
> AC and battery while suspended.  Also this appears to be related to the EC.

That being said, I always keep a stock kernel on this machine (latest is Kubuntu
vmlinuz-5.0.0-35-generic) and the failure mode isn't reproducible on that. I'm
still wondering what's substantially different between the versions.

BTW, I've got breaking it down to a science now:

- Let the battery drain pretty well down (< ~80%)
- Boot the kernel I wish to test, while still on battery
- Intiate a suspend/resume, which will come back OK
- Initiate another suspend
- Plug in the charger. If I have my power meter in, I see it do the PD
  negotiation (it'll start off at 20V/150mA, then it'll PD ramp up to
  a full 2.5-2.75A @20v to charge the battery)
- Try to resume. It'll be totally dead and I have to long-power-button
  to get it back

- If I have "ec_no_wakeup=1" set, then the first time it seems to resume
  OK from the procedure above, then I'll wait about two minutes then
  flip the laptop around a bunch (apparently getting the accelerometer
  involved, which I guess happens during a car ride) which can also
  trigger the hard hangup when I plug it in before suspending

> Also I'm wondering if the problem is reproducible with ec_no_wakeup
> and the last patch I posted applied.

With the stock -rc kernel, I used to be able to work around this issue with
"ec_no_wakeup=1", but sometimes the battery would drain while "suspended"
far higher than idle at random.

With the second patchset (the introduction of acpi_s2idle_sync()) the
*second* resume while the battery is charging locks it up hard.

> But with that patch applied, please try to comment out the
> acpi_s2idle_sync() in acpi_s2idle_wake() and retest.

So get this- I took it out of acpi_s2idle_wake() and left it in acpi_s2idle_restore() ;
when I do this, I get the issue where it seems to no longer care about the
charging state, BUT it is back to responding to charger events (i.e., it won't
go to sleep as long as it's plugged in, and "ec_no_wakeup=1" has no effect on this.

It also turns out that it doesn't apparently matter if I remove the call of acpi_s2idle_sync()
from either of acpi_s2idle_wake() or acpi_s2idle_restore() but I get the behavior above.
I took a shot in the dark and commented out the call to acpi_ec_flush_work() in acpi_s2idle_sync()
and left the calls to acpi_s2idle_sync() in both _wake and _restore and also get this
behavior, which to me implies that whatever is in the acpi_ec_flush_work() call (and I
looked at it, but didn't go any further) is where it's hanging up. I can put WARN_ON(cond)
calls in places that'll write to EFI pstore, if you think that would be useful.

As this workaround does at least (so far, anyway) keep the machine from going off into
a black hole, I'm willing to live with it until/as we find a workaround that gets it
right; even though it'll be somewhat annoying to not go to sleep when charged AND
automatically wake up on power connection/disconnection events (can those be filtered
out of /proc/acpi/wakeup_sources ? Nothing looked obvious) at least I have a laptop
when I need it.

Can you think of any other strategy to try (and I'm all ears at this point; this
kind of breakage- while almost certainly that something in this HP BIOS/ACPI
is doing wrong, should be properly worked around for the rest of us poor suckers
who got these devices so I'm willing to help either fix it,

> > [1] - I can let it sit idle at home and it'll be OK, but when I put it in
> > my bag and go somewhere it always seems to be the trigger for failed resumes
> > I have no idea why.
> > BTW, what was different about your 2nd patch (the addition of acpi_s2idle_sync()
> > to the resume cycle) was I was getting WMI power events captured during
> > resume in the EC blocked/unblocked path, which hadn't happened before:

> That's because of the added ACPI events flushing in acpi_s2idle_restore().

> > Nov 25 10:17:29 hp-x360n kernel: [ 4419.296506] ACPI: EC: interrupt blocked
> > *** Nov 25 10:17:29 hp-x360n kernel: [ 4440.111494] hp_wmi_notify(): event_id 0x20001, event_data 0x00000000
> > *** Nov 25 10:17:29 hp-x360n kernel: [ 4440.111496] hp_wmi: Unknown event_id - 131073 - 0x0

> This looks kind of weird.
> Do you get similar "unknown" events during normal operation too?

Those two "unknows" only come about during charger state events, and I do see them when
up and running when I plug and unplug (that line with hp_wmi_notify() is my own addition).

> Anyway, hp_wmi is involved and I'm quite unsure if it is ready to
> handle events during acpi_s2idle_wake(), so that's why it may not work
> every time with the last patch applied.

So, I tried removing the total WMI subsystem first, then removed the HP-WMI subsystem with
basic WMI in. No change. Going thru the sequence above still locked things up hard.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
