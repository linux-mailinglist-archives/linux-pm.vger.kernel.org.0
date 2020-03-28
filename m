Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768CE196904
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgC1T6I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 15:58:08 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41871 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726497AbgC1T6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 15:58:08 -0400
Received: (qmail 13939 invoked by uid 500); 28 Mar 2020 15:58:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Mar 2020 15:58:07 -0400
Date:   Sat, 28 Mar 2020 15:58:07 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <10243663.e30Z2V8kAt@kreacher>
Message-ID: <Pine.LNX.4.44L0.2003281432130.9749-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 28 Mar 2020, Rafael J. Wysocki wrote:

> On Friday, March 27, 2020 9:45:09 PM CET Alan Stern wrote:

> > Raphael, I've been going over the PM core code, trying to figure out
> > what it's really doing.  It's kind of a mess.
> 
> Well, sorry about that. 
> 
> > A large part of the problem is related to an inconsistency between the
> > documentation and the code.  include/linux/pm.h says that
> > DPM_FLAG_SMART_SUSPEND tells bus types and PM domains about what the
> > driver wants.  This strongly implies that the PM core will ignore
> > SMART_SUSPEND.  But in fact the core does check that flag and takes its
> > own actions if the device has no subsystem-level callbacks!
> 
> Right, which is because in those cases there is no "middle layer" between
> the driver and the core and if you want the driver to work both with
> something like genpd or the ACPI PM domain and without anything like that,
> the core needs to take those actions for consistency.

Sure, the core is acting as a proxy for the missing subsystem
callbacks.  Still, it should be documented properly.

Also, couldn't we simplify the behavior?  Right now the core checks
that there are no subsystem-level callbacks for any of _early, _late,
and _noirq variants before skipping a callback.  Couldn't we forget
about all that checking and simply skip the device-level callbacks?  
(Yes, I realize this could lead to inconsistent behavior if the
subsystem has some callbacks defined but not others -- but subsystems
should never do that, at least, not if it would lead to trouble.)

Another issue is that the documentation exists in two separate places:
include/linux/pm.h and Documentation/driver-api/devices.rst (plus a
brief mention in Documentation/power/runtime_pm.rst).  This leads to
incompleteness and inconsistencies.  Ideally there would be a complete
explanation in one place (probably the devices.rst file) and the others
would refer to it.

> > Furthermore, the PM core's actions don't seem to make sense.  If the
> > flag is set and the device is runtime-suspended when the system sleep
> > begins, the core will skip issuing the suspend_late and suspend_noirq
> > callbacks to the driver.  But it doesn't skip issuing the suspend
> > callback!  I can't figure that out.
> 
> That's because if the core gets to executing ->suspend_late, PM-runtime has
> been disabled for the device and if the device is runtime-suspended at that
> point, so (at least if SMART_SUSPEND is set for the device) there is no reason
> to do anything more to it.

But if SMART_SUSPEND is set and the device is runtime-suspended, why 
issue the ->suspend callback?  Why not just do pm_runtime_disable() 
then (to prevent the device from resuming) and skip the callback?

> > Furthermore, the decisions about
> > whether to skip the resume_noirq, resume_early, and resume callbacks
> > are based on different criteria from the decisions on the suspend side.
> 
> Right, because there are drivers that don't want devices to stay in suspend
> after system resume even though they have been left in suspend by it.

This suggests that sometimes we may want to issue non-matching 
callbacks.  For example, ->resume_noirq, ->resume_early, and ->resume
but not ->suspend, ->suspend_late, or ->suspend_noirq.  Is that what 
you are saying?

> Arguably, they could be left in suspend and then resumed after the completion
> of system suspend, but that would add quite a bit of latency if the device
> needs to be accessed right after the system suspend is complete.
> 
> > That's not all: The SMART_SUSPEND decisions completely ignore the value
> > of DPM_FLAG_NEVER_SKIP!  NEVER_SKIP affects only the direct_completion
> > pathway.
> 
> As documented AFAICS.

But highly confusing.  Maybe we can change the name to, say, 
DPM_FLAG_NO_DIRECT_COMPLETE.

> > SMART_SUSPEND seems to have two different meanings.  (1) If the device 
> > is already in runtime suspend when a system sleep starts, skip the 
> > suspend_late and suspend_noirq callbacks.  (2) Under certain (similar) 
> > circumstances, skip the resume callbacks.  The documentation only 
> > mentions (1) but the code also handles (2).
> 
> That's because (2) is the THAW case and I was distracted before I got
> to documenting it properly.  Sorry.
> 
> The problem is that if you leave the device in runtime suspend, calling
> ->freeze_late() or ->freeze_noirq() on it is not useful and if you have
> skipped those, running the corresponding "thaw" callbacks is not useful
> either (what would they do, specifically?).
> 
> There is a whole problem of whether or not devices should be left in
> runtime suspend during hibernation and I have not had a chance to get
> to the bottom of that yet.

Not only that.  The distinction between SMART_SUSPEND and
direct_complete is rather subtle, and it doesn't seem to be carefully
explained anywhere.  In fact, I'm not sure I understand it myself.  :-)
For example, the direct_complete mechanism is very careful about not
leaving a device in runtime suspend if a descendant (or other dependent
device) will remain active.  Does SMART_SUSPEND behave similarly?  If
so, it isn't documented.

Besides, it seems like a mistake to try controlling (1) and (2)  
together (i.e., with one flag).  Can we do a better job of
separating the functions of SMART_SUSPEND and LEAVE_SUSPENDED?

> > Other things in there also seem strange.  device_prepare() does a
> > WARN_ON if either SMART_SUSPEND or LEAVE_SUSPENDED is set and the
> > device is not runtime-PM-enabled.  That's understandable, but it's also
> > racy.
> 
> I guess you mean the check in device_prepare().
> 
> > A system sleep can begin at any time; how can a driver know when
> > it is safe to disable a device's runtime PM briefly?
> 
> Well, fair enough, but then I'm not sure if there is a good place for this
> check at all, because drivers can briefly disable PM-runtime at any time in
> theory.

There probably isn't a good place for it.  We could just get rid of the 
WARN.  I've never heard of it triggering.

> > When device_prepare() calculates the power.direct_complete flag, it
> > checks to see whether the device is currently in runtime suspend in
> > some cases but not in others, as in the code added by your commit
> > c62ec4610c40 ("PM / core:  Fix direct_complete handling for devices
> > with no callbacks").  Since the runtime-PM state is going to checked in
> > __device_suspend() anyway, we shouldn't need to check it here at all.
> 
> I guess the point is that in theory the device can be runtime-suspended
> between device_prepare() and _device_suspend(), is by checking the status
> in the former, we lose the opportunity to leave it in suspend if that
> happens.
> 
> OK, fair enough.
> 
> > At a couple of points in the code, THAW and RESTORE events are each
> > treatedly specially, with no explanation.
> 
> Right, which is related to the kind of work in progress situation regarding
> the flags and hibernation mentioned above.  Again, sorry about that.

I haven't thought about those issues as much as you have.  Still, it 
seems obvious that the FREEZE/THAW phases should be very happy to leave 
devices in runtime suspend throughout (without even worrying about 
wakeup settings), and the RESTORE phase should always bring everything 
back out of runtime suspend.

What to do during the POWEROFF phase isn't so clear, because it depends
on how the platform handles the poweroff transition.

> > The power.may_skip_resume flag is used in only one place, when 
> > LEAVE_SUSPENDED is set and there are subsystem-level callbacks.  In 
> > particular, it is _not_ used by dev_pm_may_skip_resume().  That seems 
> > highly suspicious at best.
> 
> That's because it's for the middle-layer (subsystem-level) code to let the
> core know that skipping the resume would be OK.
> 
> The core doesn't need that flag when it decides by itself.

This may be another situation where changing a name would make things
clearer.  One doesn't immediately recognize that
dev_pm_may_skip_resume() applies only in cases where there is no
subsystem-level callback.

> > I think it would be worthwhile to expend some serious effort
> > straightening all this stuff out.  Perhaps we could start with a more
> > explicit description of what is supposed to happen at each step.  
> > (Things to be careful about include phrases like "leave suspended",
> > which is not the same as "don't call the resume callbacks", even though
> > the two are easily conflated.)
> > 
> > What do you think?
> 
> I am certainly not going to reject any help. :-)
> 
> Also, I'm not against clarifying anything that is not clear enough.

Okay, let's start with direct_complete.  The direct_complete mechanism
is applied to the SUSPEND and RESUME phases under the following
conditions:

	DPM_FLAG_NEVER_SKIP (or better, DPM_FLAG_NO_DIRECT_COMPLETE)
	is clear;  [Incidentally, since a driver can set this flag 
	whenever its ->prepare routine returns 0, why do we need
	DPM_FLAG_SMART_PREPARE?]

	Either the device has no system-PM callbacks at all or else the
	->prepare callback returns a positive value;

	All of the device's descendants and dependents also want to use
	direct_complete;

	Neither the device nor any of its descendants/dependents is
	enabled for wakeup;

	The device is runtime suspended just before the ->suspend
	callback would normally be issued.

When the mechanism applies, none of the suspend or resume callbacks (in
any of their normal, _early, _late, or _noirq variants) are issued,
only ->complete.  Consequently the device remains in runtime suspend
throughout the system sleep.

Currently, direct_complete is never applied during any of the system
hibernation phases (FREEZE, THAW, POWEROFF, RESTORE).  This may change
in the future.

Is this description correct and complete?  Can you give a similarly
succinct outline for how SMART_SUSPEND and LEAVE_SUSPENDED should work?  
And also describe how they differ from direct_complete and how they
interact with it?  (For example, how does setting both flags differ 
from returning a positive value from ->prepare?)

Alan Stern

