Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36F196E74
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgC2Q1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:27:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40799 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728303AbgC2Q1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 12:27:39 -0400
Received: (qmail 5597 invoked by uid 500); 29 Mar 2020 12:27:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2020 12:27:38 -0400
Date:   Sun, 29 Mar 2020 12:27:38 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <CAJZ5v0igUZnqFLcOhruDSNjv0HqCsy64tmYWyTX98xEc9cH14g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003291129360.3311-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 29 Mar 2020, Rafael J. Wysocki wrote:

> On Sat, Mar 28, 2020 at 8:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > > > A large part of the problem is related to an inconsistency between the
> > > > documentation and the code.  include/linux/pm.h says that
> > > > DPM_FLAG_SMART_SUSPEND tells bus types and PM domains about what the
> > > > driver wants.  This strongly implies that the PM core will ignore
> > > > SMART_SUSPEND.  But in fact the core does check that flag and takes its
> > > > own actions if the device has no subsystem-level callbacks!
> > >
> > > Right, which is because in those cases there is no "middle layer" between
> > > the driver and the core and if you want the driver to work both with
> > > something like genpd or the ACPI PM domain and without anything like that,
> > > the core needs to take those actions for consistency.
> >
> > Sure, the core is acting as a proxy for the missing subsystem
> > callbacks.  Still, it should be documented properly.
> >
> > Also, couldn't we simplify the behavior?  Right now the core checks
> > that there are no subsystem-level callbacks for any of _early, _late,
> > and _noirq variants before skipping a callback.  Couldn't we forget
> > about all that checking and simply skip the device-level callbacks?
> > (Yes, I realize this could lead to inconsistent behavior if the
> > subsystem has some callbacks defined but not others -- but subsystems
> > should never do that, at least, not if it would lead to trouble.)
> 
> In quite a few cases the middle layer has nothing specific to do in a
> given phase of suspend/resume, but the driver may.
> 
> Subsystems haven't been required to provide callbacks for all phases
> so far, so this change would require some modifications in there.
> 
> I actually prefer the core to do more, even if that means more
> complexity in it, to avoid possible subtle differences in behavior
> between subsystems.

What I meant was that it might be reasonable to get rid of the
no_subsys_cb checks.  For example, change __device_suspend_noirq() as
follows:

-	no_subsys_cb = !dpm_subsys_suspend_late_cb(dev, state, NULL);
-
-	if (dev_pm_smart_suspend_and_suspended(dev) && no_subsys_cb)
+	if (dev_pm_smart_suspend_and_suspended(dev))
		goto Skip;

with similar changes to the _suspend_late, _resume_noirq, and
_resume_early.  In each stage, we would bypass the driver's callback
if SMART_SUSPEND was set and there was no subsystem-level callback for
_that_ stage -- rather than there being no subsystem-level callbacks
for _any_ of the stages.

> > > > Furthermore, the PM core's actions don't seem to make sense.  If the
> > > > flag is set and the device is runtime-suspended when the system sleep
> > > > begins, the core will skip issuing the suspend_late and suspend_noirq
> > > > callbacks to the driver.  But it doesn't skip issuing the suspend
> > > > callback!  I can't figure that out.
> > >
> > > That's because if the core gets to executing ->suspend_late, PM-runtime has
> > > been disabled for the device and if the device is runtime-suspended at that
> > > point, so (at least if SMART_SUSPEND is set for the device) there is no reason
> > > to do anything more to it.
> >
> > But if SMART_SUSPEND is set and the device is runtime-suspended, why
> > issue the ->suspend callback?
> 
> The driver itself or the middle-layer may want to resume the device.
> 
> Arguably, it may do that in ->prepare() too, but see below.
> 
> > Why not just do pm_runtime_disable()
> > then (to prevent the device from resuming) and skip the callback?
> 
> Because another driver may want to runtime-resume that device in order
> to use it for something before ->suspend_late().  Of course, you may
> argue that this means a missing device link or similar, so it is not
> clear-cut.
> 
> The general rule is that "synchronous" PM-runtime can be expected to
> work before ->suspend_late(), so ->suspend() callbacks should be able
> to use it safely in all cases in principle.

(With one exception: Since the PM core does pm_runtime_get_noresume()  
during the prepare stage, going _into_ runtime suspend is impossible
during ->prepare and ->suspend.  Of course, drivers can always call 
their runtime_suspend routines directly, but that wouldn't affect the 
power.runtime_status value.)

> That expectation goes against direct_complete in some cases, so
> drivers need to set NEVER_SKIP (or whatever it will be called in the
> future) to avoid that problem.

Ah, okay.  Very well, let's spell this out explicitly in the
documentation; it's an important difference.

> > > > Furthermore, the decisions about
> > > > whether to skip the resume_noirq, resume_early, and resume callbacks
> > > > are based on different criteria from the decisions on the suspend side.
> > >
> > > Right, because there are drivers that don't want devices to stay in suspend
> > > after system resume even though they have been left in suspend by it.
> >
> > This suggests that sometimes we may want to issue non-matching
> > callbacks.  For example, ->resume_noirq, ->resume_early, and ->resume
> > but not ->suspend, ->suspend_late, or ->suspend_noirq.  Is that what
> > you are saying?
> 
> Yes.
> 
> As per devices.rst:
> 
> "the driver must be prepared to
> cope with the invocation of its system-wide resume callbacks back-to-back with
> its ``->runtime_suspend`` one (without the intervening ``->runtime_resume`` and
> so on) and the final state of the device must reflect the "active" runtime PM
> status in that case."

Here would also be a good place to mention the difference between "keep
the device in runtime suspend" and "not issue the various resume
callbacks".  In theory, a subsystem and a driver could collaborate to
make their resume-side callbacks keep the device runtime-suspended, so
these two concepts are not identical.

Alternatively, we could specify that this sort of thing is never 
allowed: When the ->resume callback returns, the device _must_ be 
powered-up and runtime-active.  If we do this, then the _only_ way to 
avoid powering up the device (and to let it remain in runtime suspend) 
is for the core to skip issuing the resume-side callbacks.  Or at 
least, skip issuing the ->resume callback.

> > > > SMART_SUSPEND seems to have two different meanings.  (1) If the device
> > > > is already in runtime suspend when a system sleep starts, skip the
> > > > suspend_late and suspend_noirq callbacks.  (2) Under certain (similar)
> > > > circumstances, skip the resume callbacks.  The documentation only
> > > > mentions (1) but the code also handles (2).
> > >
> > > That's because (2) is the THAW case and I was distracted before I got
> > > to documenting it properly.  Sorry.
> > >
> > > The problem is that if you leave the device in runtime suspend, calling
> > > ->freeze_late() or ->freeze_noirq() on it is not useful and if you have
> > > skipped those, running the corresponding "thaw" callbacks is not useful
> > > either (what would they do, specifically?).
> > >
> > > There is a whole problem of whether or not devices should be left in
> > > runtime suspend during hibernation and I have not had a chance to get
> > > to the bottom of that yet.
> >
> > Not only that.  The distinction between SMART_SUSPEND and
> > direct_complete is rather subtle, and it doesn't seem to be carefully
> > explained anywhere.  In fact, I'm not sure I understand it myself.  :-)
> > For example, the direct_complete mechanism is very careful about not
> > leaving a device in runtime suspend if a descendant (or other dependent
> > device) will remain active.  Does SMART_SUSPEND behave similarly?  If
> > so, it isn't documented.
> 
> The difference is that SMART_SUSPEND allows the ->suspend callback to
> be invoked which may decide to resume the device (or reconfigure it
> for system wakeup if that doesn't require resuming it).  IOW, this
> means "I can cope with a runtime-suspended device going forward".
> [But if the device is still runtime-suspended during ->suspend_late(),
> its configuration is regarded as "final".]
> 
> In turn, direct_complete means something like "if this device is
> runtime-suspended, leave it as is and don't touch it during the whole
> suspend-resume cycle".

Right; let's spell this out in the documentation too.

> > > > At a couple of points in the code, THAW and RESTORE events are each
> > > > treatedly specially, with no explanation.
> > >
> > > Right, which is related to the kind of work in progress situation regarding
> > > the flags and hibernation mentioned above.  Again, sorry about that.
> >
> > I haven't thought about those issues as much as you have.  Still, it
> > seems obvious that the FREEZE/THAW phases should be very happy to leave
> > devices in runtime suspend throughout (without even worrying about
> > wakeup settings), and the RESTORE phase should always bring everything
> > back out of runtime suspend.
> 
> These were exactly my original thoughts, but then when I started to
> consider possible interactions the restore kernel (which also carries
> out the "freeze" transition before jumping into the image kernel), it
> became less clear.
> 
> The concerns is basically whether or not attempting to power on
> devices that are already powered on can always be guaranteed to work.

This doesn't affect THAW, because during THAW the driver knows what
state the device is in.  It only affects RESTORE.  But during RESTORE
the driver really doesn't know anything about the device state, even
with the current code.  The restore kernel doesn't even know whether
the boot kernel put the device through a FREEZE transition, because
it's possible that the driver was in a module that hadn't been loaded
yet when the resume-from-hibernation started.

Thus, drivers face this problem already.  I don't think we need to
worry about it.

> > What to do during the POWEROFF phase isn't so clear, because it depends
> > on how the platform handles the poweroff transition.
> 
> POWEROFF is exactly analogous to SUSPEND AFAICS.

The difference is that on many platforms (such as desktop PCs) the
POWEROFF callbacks don't have to power-down the device, because the
firmware will power _everything_ off (except the devices needed for
wakeup, of course).  But on other platforms this isn't true, so on them
POWEROFF does need to behave like SUSPEND.

> > Okay, let's start with direct_complete.  The direct_complete mechanism
> > is applied to the SUSPEND and RESUME phases under the following
> > conditions:
> >
> >         DPM_FLAG_NEVER_SKIP (or better, DPM_FLAG_NO_DIRECT_COMPLETE)
> >         is clear;  [Incidentally, since a driver can set this flag
> >         whenever its ->prepare routine returns 0, why do we need
> >         DPM_FLAG_SMART_PREPARE?]
> 
> Because the former allows the driver to avoid providing a ->prepare
> callback always returning 1.

Do you mean NEVER_SKIP allows the driver to avoid providing a ->prepare 
callback which always returns _0_?  If that's not what you meant, I 
don't understand.

> >         Either the device has no system-PM callbacks at all or else the
> >         ->prepare callback returns a positive value;
> 
> Why so?

Isn't that exactly what __device_prepare() does?  After your latest 
patch, we have:

	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
		(ret > 0 || dev->power.no_pm_callbacks) &&
		!dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);

which is exactly what I said, isn't it?

> >         All of the device's descendants and dependents also want to use
> >         direct_complete;
> 
> Yes.
> 
> >         Neither the device nor any of its descendants/dependents is
> >         enabled for wakeup;
> 
> Yes.
> 
> >         The device is runtime suspended just before the ->suspend
> >         callback would normally be issued.
> 
> Yes.
> 
> > When the mechanism applies, none of the suspend or resume callbacks (in
> > any of their normal, _early, _late, or _noirq variants) are issued,
> > only ->complete.  Consequently the device remains in runtime suspend
> > throughout the system sleep.
> >
> > Currently, direct_complete is never applied during any of the system
> > hibernation phases (FREEZE, THAW, POWEROFF, RESTORE).  This may change
> > in the future.
> >
> > Is this description correct and complete?
> 
> It is mostly. :-)

I forgot to mention that if power.syscore is set then none of these
mechanisms apply because none of the callbacks are issued.  Does
anything else need to be changed?

> > Can you give a similarly
> > succinct outline for how SMART_SUSPEND and LEAVE_SUSPENDED should work?
> > And also describe how they differ from direct_complete and how they
> > interact with it?  (For example, how does setting both flags differ
> > from returning a positive value from ->prepare?)
> 
> I will, but I need some time to do that.  Stay tuned.

You bet!

Alan Stern

