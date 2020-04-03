Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B7E19DF13
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgDCUPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:15:10 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36035 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727829AbgDCUPK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 16:15:10 -0400
Received: (qmail 2381 invoked by uid 500); 3 Apr 2020 16:15:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Apr 2020 16:15:09 -0400
Date:   Fri, 3 Apr 2020 16:15:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <3728342.COPzmv9P3G@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004031521501.27682-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For the most part we seem to be in agreement.

On Fri, 3 Apr 2020, Rafael J. Wysocki wrote:

> On Friday, April 3, 2020 6:41:05 PM CEST Alan Stern wrote:
> > On Fri, 3 Apr 2020, Rafael J. Wysocki wrote:

> > > (b) Drivers that set SMART_SUSPEND are allowed to reuse their PM-runtime
> > >     callbacks for system-wide suspend and resume.
> > > 
> > >     That is, they can point either the ->suspend_late or the ->suspend_noirq
> > >     callback pointer to the same function as ->runtime_suspend and they can
> > >     point either the ->resume_noirq or ->the resume_early callback to the'
> > >     same function as ->runtime_resume.
> > 
> > Well, in theory any driver or subsystem can do this whenever it wants
> > to, regardless of any flag settings.
> 
> Not exactly.
> 
> Say the driver wants to point both ->runtime_suspend and ->suspend_late to
> the same function.
> 
> If the bus type doesn't provide system-wide PM callbacks at all (which is
> the case for some bus types), that only works if the device is never
> runtime-suspended when ->suspend_late is about to run, because otherwise
> the function in question needs to check the context in which it is running
> (PM-runtime vs system-wide and runtime-suspended vs runtime-active in the
> latter case) which at least is awkward and hard to get right.
> 
> > It's then up to the driver or
> > subsystem to make sure the callback "does the right thing".
> 
> In theory.

Okay.  In any case, this is about what drivers should do, not about 
what the core should do.

> > What I'm concerned about now is: What guarantees can the core give to 
> > the driver and subsystem, so that they will know what is necessary in 
> > order to "do the right thing"?
> 
> I'm not sure what you mean.
> 
> If the subsystem provides callbacks, the core will run them regardless.
> 
> If it does not provide callbacks, the core will skip ->suspend_late and
> ->suspend_noirq for the driver and the device will remain suspended.
> 
> If SMART_SUSPEND is not set, the core will execute all of the callbacks
> that are present.

All right, then those are the guarantees I was thinking of.

> > > (c) Drivers that set SMART_SUSPEND are alwo allowed to provide special
> > >     simplified callbacks for the "freeze" and "thaw" transitions during
> > >     hibernation (and restore) and (if they do so) special callbacks for the
> > >     "restore" phase.
> > 
> > What do you mean by "simplified"?
> 
> Avoiding actual PM.
> 
> > As I see it, the suspend-side callbacks are generally responsible for 
> > four things:
> > 
> > 	1. Quiesce the device (finish ongoing I/O and do not allow any
> > 	   more to start).
> > 
> > 	2. Save the current device state.
> > 
> > 	3. Install the appropriate wakeup settings.
> > 
> > 	4. Put the device into low-power mode.
> > 
> > (Not explicitly listed: Perform a runtime-resume if needed in order to
> > carry out these four items.)
> > 
> > During a SUSPEND transition, we usually expect all four to happen.  

Based on what you said elsewhere, 4 may not be needed for SUSPEND 
(depending on the platform).

> > During a FREEZE transition, we only require 1.

Actually, FREEZE should do 2 as well.  Doing all four is acceptable,
though not optimal.

> That's what I mean by "simplified".
> 
> > During a POWEROFF
> > transition we require 1 and 3, and possibly 4 (depending on how the
> > platform handles poweroff).
> 
> But doing 2 is not a bug AFAICS.

Agreed.

> > Similar requirements apply to the resume-side callbacks.  (But note 
> > that RESTORE is not the inverse of POWEROFF; it is more like an inverse 
> > of FREEZE with the added complication that the device's initial state 
> > is unknown.)
> 
> It actually isn't even an inverse of FREEZE.  It is like RESUME with the
> additional requirements that (a) it can never be skipped and (b) the
> device need not be in a low-power state when it runs (the initial state
> of it is unknown if you will).

Let's put it like this: The resume-side callbacks should have the
overall effect of bringing the device back to its initial state, with
the following exceptions and complications:

	Unless SMART_SUSPEND and LEAVE_SUSPEND are both set, a device
	that was in runtime suspend before the suspend_late phase 
	must end up being runtime-active after the matching RESUME.

	Unless SMART_SUSPEND is set, a device that was in runtime 
	suspend before the freeze_late phase must end up being 
	runtime-active after the matching THAW.

[I'm not so sure about this.  Wouldn't it make more sense to treat
_every_ device as though SMART_SUSPEND was set for FREEZE/THAW
transitions, and require subsystems to do the same?]

	After RESTORE, _every_ device must end up being runtime 
	active.

	In general, each resume-side callback should undo the effect
	of the matching suspend-side callback.  However, because of
	the requirements mentioned in the preceding sentences,
	sometimes a resume-side callback will be issued even though
	the matching suspend-side callback was skipped -- i.e., when
	a device that starts out runtime-suspended ends up being
	runtime-active.

How does that sound?

> > What changes to this analysis would SMART_SUSPEND allow?  None if the 
> > device is runtime-active.  But if the device is runtime-suspended and 
> > the wakeup settings don't need to be changed, then presumably none of 
> > the four items are necessary.
> > 
> > Is this what you mean?
> 
> No.
> 
> What I meant was that even if the driver pointed ->runtime_suspend and
> ->suspend_late (say) to the same function and it pointed ->resume_early
> and ->runtime_resume to the same function, it didn't have to point
> ->freeze_late and ->thaw_early to the same pair of functions, respectively.
> 
> It can point ->freeze_late and ->thaw_early to a pair of different functions
> that only quiesce the device and reverse that, respectively.

Again, that describes what drivers or subsystems should do, not what 
the core will do.

> > > [OK, I realize that (b) and (c) are not documented, see the notes below.]
> > > 
> > > Because of (a), if the device with SMART_SUSPEND set is still runtime-suspended
> > > during the "late" phase of suspend, the core will not invoke the driver's
> > > "late" and "noirq" suspend callbacks directly (*).  Middle layer (subsystem)
> > > code is expected to behave accordingly.
> > 
> > Okay, this agrees with what I wrote above.
> > 
> > > Because of (b), if the "late" and "noirq" driver callbacks were skipped during
> > > the "freeze" transition, the core will also avoid invoking the "noirq" and
> > > "early" callbacks provided by the driver during the "thaw" transition and
> > > the callbacks during the "restore" transition will be executed unconditionally
> > > (**).  Middle layer code is expected to behave accordingly.
> > 
> > All right.  To summarize: If the driver's ->freeze_late callback is
> > skipped then the driver's ->thaw-early will be skipped, and similarly
> > for ->freeze_noirq and ->thaw_noirq.  But RESTORE callbacks are never
> > skipped.  Correct?
> 
> Yes.

And this will be true whether or not LEAVE_SUSPENDED is set, right?

> > However, the most difficult transitions are SUSPEND and RESUME.  Is it
> > accurate to say that if the driver's ->suspend_late callback is skipped
> > then the driver's ->resume_early will be skipped, and similarly for
> > ->suspend_noirq and ->resume_noirq?
> 
> If LEAVE_SUSPENDED is set in addition to SMART_SUSPEND, then yes.
> 
> > > Notes:
> > > 
> > > 1. I have considered splitting SMART_SUSPEND into two or even three flags
> > >    so that (a), (b) and (c) are each associated with a separate flag, but
> > >    then I would expect the majority of users to use all of them anyway.
> > > 
> > > 2. LEAVE_SUSPENDED (which may be better renamed to SKIP_RESUME) is kind of
> > >    expected to be used along with SMART_SUSPEND unless there is a good enough
> > >    reason to avoid using it.  I admit that this isn't really straightforward,
> > >    maybe the default behavior should be to skip the resume and there should be
> > >    FORCE_RESUME instead of LEAVE_SUSPENDED.
> > 
> > One question not addressed above (in fact, the original reason for 
> > getting you involved in this discussion): What about the device's 
> > power.runtime_status?  Shall we say that that core will call 
> > pm_runtime_set_active() at some point before issuing the ->complete 
> > callback unless some combination of flags is set?  And what should that 
> > combination be?
> > 
> > After all, we expect that most drivers will want their devices to be in 
> > the runtime-active state at the end of a system sleep or hibernation.  
> > It makes sense for the core to do the necessary housekeeping.
> 
> The core will set the PM-runtime status to "active" in device_resume_noirq()
> if (a) the subsystem callbacks are not invoked (otherwise the subsystem is
> responsible for doing that) and (b) if the driver's callback not skipped
> (in which case its ->resume_early callback will not be skipped too).

Are you certain you want the subsystem callback to be responsible for
setting the runtime status to "active"?  Isn't this an example of
something the core could do in order to help simplify subsystems?

> > > 3. (*) Under the assumption that either ->suspend_late or ->suspend_noirq
> > >    points to the same routine as ->runtime_suspend (and the other is NULL),
> > >    invokig that callback for a runtime-suspended device is technically invalid.
> > 
> > Does this invalidate anything I wrote above?
> 
> I don't think so.  It is the reason why driver callbacks are skipped for
> runtime-suspended devices.

And this brings up another thing the core might do to help simplify
drivers and subsystems: If SMART_SUSPEND isn't set and the device is in
runtime suspend, couldn't the core do a pm_runtime_resume before
issuing the ->suspend or ->suspend_late callback?

> > >    In turn, under the assumption that either ->resume_early or ->resume_noirq
> > >    points to the same routine as ->runtime_resume (and the other is NULL), it is
> > >    valid to invoke that callback if the late/noirq suspend was skipped.
> > 
> > In other words, it's okay for the core either to issue or skip those 
> > callbacks.  Presumably the decision will be made based on some flag 
> > setting?
> 
> Yes.  A flag combined with the PM-runtime status of the device in
> device_suspend_noirq().
> 
> > > 4. (**) If the "freeze" and "thaw" callbacks are simplified, they cannot be
> > >    run back-to-back with ->runtime_resume and ->runtime_suspend, respectively.
> > >    Thus if "freeze" is skippend, "thaw" must be skipped too.  However,
> > >    "restore" needs to be prepared to be invoked after "freeze" or
> > >    ->runtime_suspend (and the state of the device may not match the
> > >    callback that ran previously), so it must be special.
> > > 
> > > 5. I agree that skipping the driver level of callbacks depending on what is
> > >    provided by the middle layer is inconsistent, but I wanted to take the
> > >    users of pm_runtime_force_suspend/resume() into account by letting those
> > >    things run.
> > > 
> > >    It would be more consistent to expect middle layer code (bus types, PM
> > >    domains) to provide either all of the noirq/early/late callbacks, or none
> > >    of them and make SMART_SUSPEND and pm_runtime_force_suspend/resume()
> > >    mutually exclusive.
> > 
> > I don't have a clear idea of how pm_runtime_force_suspend/resume() gets 
> > used.  Are we better off ignoring it for the time being?
> 
> Yes, we are.

We're converging on a final answer!

Alan Stern

