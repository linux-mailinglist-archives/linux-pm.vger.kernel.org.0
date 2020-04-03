Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1D19DBE2
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391021AbgDCQlG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:41:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52781 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728389AbgDCQlG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 12:41:06 -0400
Received: (qmail 18471 invoked by uid 500); 3 Apr 2020 12:41:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Apr 2020 12:41:05 -0400
Date:   Fri, 3 Apr 2020 12:41:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <2274735.ifPVKiii8o@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004031135130.7035-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 3 Apr 2020, Rafael J. Wysocki wrote:

> I'll address the other points in your message separately.
> 
> The rules for SMART_SUSPEND are as follows:

These rules are a sort of high-level overview.  They don't (for the
most part) say exactly what will happen, in terms of which callbacks
will be issued and under what circumstances.  I have tried to provide 
such a description inline below.

> (a) If SMART_SUSPEND is set and the device is runtime-suspended during system
>     suspend, it is not expected to be resumed by the core or the middle layer
>     (subsystem) code unless the latter has a specific reason to do that (e.g.
>     it knows that the device needs to be reconfigured which cannot be done
>     without resuming it).
> 
>     The device can still be resumed when it is needed to suspend a dependent
>     device, but that cannot happen before the "late suspend" phase.

Don't you mean it cannot happen during or after the "late suspend"  
phase?  (More precisely, it cannot happen after the time when the core
would issue the device's ->suspend_late callback, but it can happen
between that time and the time when the "late suspend" phase began --
for example, from within the dependent device's ->suspend_late
callback.)  After all, __device_suspend_late() calls
__pm_runtime_disable(), following which the device _cannot_ be runtime
resumed.

Putting this in operational terms, it seems to say that if
SMART_SUSPEND is set and the device is runtime-suspended at the times
when the core would normally issue the driver's ->suspend_late or
->suspend_noirq callback, then the core will skip the callback (with a
similar requirement for subsystems).  Correct?

> (b) Drivers that set SMART_SUSPEND are allowed to reuse their PM-runtime
>     callbacks for system-wide suspend and resume.
> 
>     That is, they can point either the ->suspend_late or the ->suspend_noirq
>     callback pointer to the same function as ->runtime_suspend and they can
>     point either the ->resume_noirq or ->the resume_early callback to the'
>     same function as ->runtime_resume.

Well, in theory any driver or subsystem can do this whenever it wants
to, regardless of any flag settings.  It's then up to the driver or
subsystem to make sure the callback "does the right thing".

What I'm concerned about now is: What guarantees can the core give to 
the driver and subsystem, so that they will know what is necessary in 
order to "do the right thing"?

> (c) Drivers that set SMART_SUSPEND are alwo allowed to provide special
>     simplified callbacks for the "freeze" and "thaw" transitions during
>     hibernation (and restore) and (if they do so) special callbacks for the
>     "restore" phase.

What do you mean by "simplified"?

As I see it, the suspend-side callbacks are generally responsible for 
four things:

	1. Quiesce the device (finish ongoing I/O and do not allow any
	   more to start).

	2. Save the current device state.

	3. Install the appropriate wakeup settings.

	4. Put the device into low-power mode.

(Not explicitly listed: Perform a runtime-resume if needed in order to
carry out these four items.)

During a SUSPEND transition, we usually expect all four to happen.  
During a FREEZE transition, we only require 1.  During a POWEROFF
transition we require 1 and 3, and possibly 4 (depending on how the
platform handles poweroff).

Similar requirements apply to the resume-side callbacks.  (But note 
that RESTORE is not the inverse of POWEROFF; it is more like an inverse 
of FREEZE with the added complication that the device's initial state 
is unknown.)

What changes to this analysis would SMART_SUSPEND allow?  None if the 
device is runtime-active.  But if the device is runtime-suspended and 
the wakeup settings don't need to be changed, then presumably none of 
the four items are necessary.

Is this what you mean?

> [OK, I realize that (b) and (c) are not documented, see the notes below.]
> 
> Because of (a), if the device with SMART_SUSPEND set is still runtime-suspended
> during the "late" phase of suspend, the core will not invoke the driver's
> "late" and "noirq" suspend callbacks directly (*).  Middle layer (subsystem)
> code is expected to behave accordingly.

Okay, this agrees with what I wrote above.

> Because of (b), if the "late" and "noirq" driver callbacks were skipped during
> the "freeze" transition, the core will also avoid invoking the "noirq" and
> "early" callbacks provided by the driver during the "thaw" transition and
> the callbacks during the "restore" transition will be executed unconditionally
> (**).  Middle layer code is expected to behave accordingly.

All right.  To summarize: If the driver's ->freeze_late callback is
skipped then the driver's ->thaw-early will be skipped, and similarly
for ->freeze_noirq and ->thaw_noirq.  But RESTORE callbacks are never
skipped.  Correct?

However, the most difficult transitions are SUSPEND and RESUME.  Is it
accurate to say that if the driver's ->suspend_late callback is skipped
then the driver's ->resume_early will be skipped, and similarly for
->suspend_noirq and ->resume_noirq?

> Notes:
> 
> 1. I have considered splitting SMART_SUSPEND into two or even three flags
>    so that (a), (b) and (c) are each associated with a separate flag, but
>    then I would expect the majority of users to use all of them anyway.
> 
> 2. LEAVE_SUSPENDED (which may be better renamed to SKIP_RESUME) is kind of
>    expected to be used along with SMART_SUSPEND unless there is a good enough
>    reason to avoid using it.  I admit that this isn't really straightforward,
>    maybe the default behavior should be to skip the resume and there should be
>    FORCE_RESUME instead of LEAVE_SUSPENDED.

One question not addressed above (in fact, the original reason for 
getting you involved in this discussion): What about the device's 
power.runtime_status?  Shall we say that that core will call 
pm_runtime_set_active() at some point before issuing the ->complete 
callback unless some combination of flags is set?  And what should that 
combination be?

After all, we expect that most drivers will want their devices to be in 
the runtime-active state at the end of a system sleep or hibernation.  
It makes sense for the core to do the necessary housekeeping.

> 3. (*) Under the assumption that either ->suspend_late or ->suspend_noirq
>    points to the same routine as ->runtime_suspend (and the other is NULL),
>    invokig that callback for a runtime-suspended device is technically invalid.

Does this invalidate anything I wrote above?

>    In turn, under the assumption that either ->resume_early or ->resume_noirq
>    points to the same routine as ->runtime_resume (and the other is NULL), it is
>    valid to invoke that callback if the late/noirq suspend was skipped.

In other words, it's okay for the core either to issue or skip those 
callbacks.  Presumably the decision will be made based on some flag 
setting?

> 4. (**) If the "freeze" and "thaw" callbacks are simplified, they cannot be
>    run back-to-back with ->runtime_resume and ->runtime_suspend, respectively.
>    Thus if "freeze" is skippend, "thaw" must be skipped too.  However,
>    "restore" needs to be prepared to be invoked after "freeze" or
>    ->runtime_suspend (and the state of the device may not match the
>    callback that ran previously), so it must be special.
> 
> 5. I agree that skipping the driver level of callbacks depending on what is
>    provided by the middle layer is inconsistent, but I wanted to take the
>    users of pm_runtime_force_suspend/resume() into account by letting those
>    things run.
> 
>    It would be more consistent to expect middle layer code (bus types, PM
>    domains) to provide either all of the noirq/early/late callbacks, or none
>    of them and make SMART_SUSPEND and pm_runtime_force_suspend/resume()
>    mutually exclusive.

I don't have a clear idea of how pm_runtime_force_suspend/resume() gets 
used.  Are we better off ignoring it for the time being?

Alan Stern

