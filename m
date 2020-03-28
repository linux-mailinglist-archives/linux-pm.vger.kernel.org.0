Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D586196696
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 15:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgC1OPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 10:15:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43131 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1OPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 10:15:22 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 03b47b1560be92d4; Sat, 28 Mar 2020 15:15:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Sat, 28 Mar 2020 15:15:18 +0100
Message-ID: <10243663.e30Z2V8kAt@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2003271515480.29819-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2003271515480.29819-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, March 27, 2020 9:45:09 PM CET Alan Stern wrote:
> On Thu, 26 Mar 2020, Qais Yousef wrote:
> 
> > On 03/25/20 22:28, Rafael J. Wysocki wrote:
> > > On Wed, Mar 25, 2020 at 9:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > > Raphael, now that we have the direct_complete mechanism, can we revisit
> > > > this?  Should the PM core automatically call pm_runtime_set_active() if
> > > > dev->power.direct_complete isn't set?  Perhaps in device_resume_early()
> > > > prior to the pm_runtime_enable() call?
> > > >
> > > > It's possible we discussed this and decided against it at the time when
> > > > direct_complete was added, but if so I don't remember what was said.
> > > 
> > > Me neither. :-)
> > > 
> > > That said complexity has grown since then and there are the
> > > DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED flags that can be
> > > used to control that behavior to some extent.
> > > 
> > > Setting DPM_FLAG_SMART_SUSPEND alone, in particular, causes
> > > pm_runtime_set_active() to be called at the noirq stage of device
> > > resume either by the core or by bus types (e.g. PCI) etc.
> > > 
> > > It looks like ohci-platform might use DPM_FLAG_SMART_SUSPEND, but I
> > > need to take a closer look at that (possibly later this week).
> > 
> > Okay I take it this was root caused correctly and now it's a question of which
> > is a better fix.
> 
> Indeed.
> 
> Raphael, I've been going over the PM core code, trying to figure out
> what it's really doing.  It's kind of a mess.

Well, sorry about that. 

> A large part of the problem is related to an inconsistency between the
> documentation and the code.  include/linux/pm.h says that
> DPM_FLAG_SMART_SUSPEND tells bus types and PM domains about what the
> driver wants.  This strongly implies that the PM core will ignore
> SMART_SUSPEND.  But in fact the core does check that flag and takes its
> own actions if the device has no subsystem-level callbacks!

Right, which is because in those cases there is no "middle layer" between
the driver and the core and if you want the driver to work both with
something like genpd or the ACPI PM domain and without anything like that,
the core needs to take those actions for consistency.

> Furthermore, the PM core's actions don't seem to make sense.  If the
> flag is set and the device is runtime-suspended when the system sleep
> begins, the core will skip issuing the suspend_late and suspend_noirq
> callbacks to the driver.  But it doesn't skip issuing the suspend
> callback!  I can't figure that out.

That's because if the core gets to executing ->suspend_late, PM-runtime has
been disabled for the device and if the device is runtime-suspended at that
point, so (at least if SMART_SUSPEND is set for the device) there is no reason
to do anything more to it.

> Furthermore, the decisions about
> whether to skip the resume_noirq, resume_early, and resume callbacks
> are based on different criteria from the decisions on the suspend side.

Right, because there are drivers that don't want devices to stay in suspend
after system resume even though they have been left in suspend by it.

Arguably, they could be left in suspend and then resumed after the completion
of system suspend, but that would add quite a bit of latency if the device
needs to be accessed right after the system suspend is complete.

> That's not all: The SMART_SUSPEND decisions completely ignore the value
> of DPM_FLAG_NEVER_SKIP!  NEVER_SKIP affects only the direct_completion
> pathway.

As documented AFAICS.

> SMART_SUSPEND seems to have two different meanings.  (1) If the device 
> is already in runtime suspend when a system sleep starts, skip the 
> suspend_late and suspend_noirq callbacks.  (2) Under certain (similar) 
> circumstances, skip the resume callbacks.  The documentation only 
> mentions (1) but the code also handles (2).

That's because (2) is the THAW case and I was distracted before I got
to documenting it properly.  Sorry.

The problem is that if you leave the device in runtime suspend, calling
->freeze_late() or ->freeze_noirq() on it is not useful and if you have
skipped those, running the corresponding "thaw" callbacks is not useful
either (what would they do, specifically?).

There is a whole problem of whether or not devices should be left in
runtime suspend during hibernation and I have not had a chance to get
to the bottom of that yet.

> Other things in there also seem strange.  device_prepare() does a
> WARN_ON if either SMART_SUSPEND or LEAVE_SUSPENDED is set and the
> device is not runtime-PM-enabled.  That's understandable, but it's also
> racy.

I guess you mean the check in device_prepare().

> A system sleep can begin at any time; how can a driver know when
> it is safe to disable a device's runtime PM briefly?

Well, fair enough, but then I'm not sure if there is a good place for this
check at all, because drivers can briefly disable PM-runtime at any time in
theory.

> When device_prepare() calculates the power.direct_complete flag, it
> checks to see whether the device is currently in runtime suspend in
> some cases but not in others, as in the code added by your commit
> c62ec4610c40 ("PM / core:  Fix direct_complete handling for devices
> with no callbacks").  Since the runtime-PM state is going to checked in
> __device_suspend() anyway, we shouldn't need to check it here at all.

I guess the point is that in theory the device can be runtime-suspended
between device_prepare() and _device_suspend(), is by checking the status
in the former, we lose the opportunity to leave it in suspend if that
happens.

OK, fair enough.

> At a couple of points in the code, THAW and RESTORE events are each
> treatedly specially, with no explanation.

Right, which is related to the kind of work in progress situation regarding
the flags and hibernation mentioned above.  Again, sorry about that.

> The power.may_skip_resume flag is used in only one place, when 
> LEAVE_SUSPENDED is set and there are subsystem-level callbacks.  In 
> particular, it is _not_ used by dev_pm_may_skip_resume().  That seems 
> highly suspicious at best.

That's because it's for the middle-layer (subsystem-level) code to let the
core know that skipping the resume would be OK.

The core doesn't need that flag when it decides by itself.

> I think it would be worthwhile to expend some serious effort
> straightening all this stuff out.  Perhaps we could start with a more
> explicit description of what is supposed to happen at each step.  
> (Things to be careful about include phrases like "leave suspended",
> which is not the same as "don't call the resume callbacks", even though
> the two are easily conflated.)
> 
> What do you think?

I am certainly not going to reject any help. :-)

Also, I'm not against clarifying anything that is not clear enough.

Cheers!



