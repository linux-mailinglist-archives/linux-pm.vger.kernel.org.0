Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB91AB3BF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgDOWUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 18:20:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43926 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgDOWUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 18:20:40 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 8701ae94ebb8b663; Thu, 16 Apr 2020 00:20:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Thu, 16 Apr 2020 00:20:35 +0200
Message-ID: <1998412.Cp2JyuGtSI@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2004141150590.12758-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004141150590.12758-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, April 14, 2020 7:47:35 PM CEST Alan Stern wrote:
> On Tue, 14 Apr 2020, Rafael J. Wysocki wrote:
> 
> > Note to self: avoid replying to technical messages late in the night ...
> > 
> > On Mon, Apr 13, 2020 at 11:32 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Saturday, April 11, 2020 4:41:14 AM CEST Alan Stern wrote:
> > > > Okay, this is my attempt to summarize what we have been discussing.
> > > > But first: There is a dev_pm_skip_resume() helper routine which
> > > > subsystems can call to see whether resume-side _early and _noirq driver
> > > > callbacks should be skipped.  But there is no corresponding
> > > > dev_pm_skip_suspend() helper routine.  Let's add one, or rename
> > > > dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().
> > >
> > > OK
> > >
> > > > Given that, here's my understanding of what should happen.  (I'm
> > > > assuming the direct_complete mechanism is not being used.)  This tries
> > > > to describe what we _want_ to happen, which is not always the same as
> > > > what the current code actually _does_.
> > >
> > > OK
> > >
> > > >       During the suspend side, for each of the
> > > >       {suspend,freeze,poweroff}_{late,noirq} phases: If
> > > >       dev_pm_skip_suspend() returns true then the subsystem should
> > > >       not invoke the driver's callback, and if there is no subsystem
> > > >       callback then the core will not invoke the driver's callback.
> > > >
> > > >       During the resume side, for each of the
> > > >       {resume,thaw,restore}_{early,noirq} phases: If
> > > >       dev_pm_skip_resume() returns true then the subsystem should
> > > >       not invoke the driver's callback, and if there is no subsystem
> > > >       callback then the core will not invoke the driver's callback.
> > > >
> > > >       dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
> > > >       set and the device's runtime status is "suspended".
> > >
> > > Agreed with the above.
> > >
> > > >       power.must_resume gets set following the suspend-side _noirq
> > > >       phase if power.usage_count > 1 (indicating the device was
> > > >       in active use before the start of the sleep transition) or
> > > >       power.must_resume is set for any of the device's dependents.
> > >
> > > Or MAY_SKIP_RESUME is unset (which means that the driver does not
> > > allow its resume callbacks to be skipped), or power.may_skip_resume
> > > is unset (which means that the subsystem does not allow the
> > > driver callbacks to be skipped).
> 
> Are you certain about that?  It contradicts what you said earlier, that
> MAY_SKIP_RESUME doesn't affect THAW transitions.

Yes, MAY_SKIP_RESUME, as well as power.may_skip_resume for that matter, really
should not affect the THAW transition at all.  I overlooked that when I was
writing the above (and earlier).

This means that the dev_pm_skip_resume() logic really is relatively
straightforward:
 - If the current transition is RESTORE, return "false".
 - Otherwise, if the current transition is THAW, return the return value
   of dev_pm_skip_suspend().
 - Otherwise (so the current transition is RESUME which is the only remaining
   case), return the logical negation of power.must_resume.

> Also, it would mean 
> that a device whose subsystem doesn't know about power.may_skip_resume 
> would never be allowed to stay in runtime suspend.

Not really, because I want the core to set power.may_skip_resume for the
devices for which dev_pm_skip_suspend() returns "true" if the "suspend_late"
subsystem-level callback is not present.  [It might be more consistent
to simply set it for all devices for which dev_pm_skip_suspend() returns
"true" and let the subsystems update it should they want to?  IOW, the
default value of power.may_skip_resume could be the return value of
dev_pm_skip_suspend()?]

> > > >       dev_pm_skip_resume() will return "false" if the current
> > > >       transition is RESTORE or power.must_resume is set.  Otherwise:
> > > >       It will return true if the current transition is THAW,
> > > >       SMART_SUSPEND is set, and the device's runtime status is
> > > >       "suspended".
> > >
> > > The other way around.  That is:
> > >
> > > dev_pm_skip_resume() will return "true" if the current transition is
> > > THAW and dev_pm_skip_suspend() returns "true" for that device (so
> > > SMART_SUSPEND is set, and the device's runtime status is "suspended",
> > > as per the definition of that function above).
> > 
> > The above is what I wanted to say ->
> 
> So for THAW, dev_pm_skip_resume() can return "true" even if 
> power.must_resume is set?  That doesn't seem right.

But it cannot be the other way around.

For example, invoking ->thaw_early() from the driver without the corresponding
->freeze_late() would be a bug in general, unless they point to the same
routines as ->runtime_resume() and ->runtime_suspend() (or equivalent),
respectively, but that need not be the case.

> > > Otherwise, it will return "true" if the current transition is RESTORE
> > > (which means that all devices are resumed) or power.must_resume is not
> > > set (so this particular device need not be resumed).
> > 
> > -> but this isn't.  In particular, I messed up the RESTORE part, so it
> > should read:
> > 
> > Otherwise, it will return "true" if the current transition is *not*
> > RESTORE (in which case all devices would be resumed) *and*
> > power.must_resume is not set (so this particular device need not be
> > resumed).
> > 
> > Sorry about that.
> 
> For the RESTORE and THAW cases that is exactly the same as what I 
> wrote, apart from the THAW issue noted above.

OK then.

> > > >  It will return "true" if the current transition is
> > > >       RESUME, SMART_SUSPEND and MAY_SKIP_RESUME are both set, and
> > > >       the device's runtime status is "suspended".
> > >
> > > Unless MAY_SKIP_RESUME is unset for at least one of its descendants (or
> > > dependent devices).
> > 
> > That should include the power.may_skip_resume flag, so as to read as follows:
> > 
> > Unless MAY_SKIP_RESUME is unset or power.may_skip_resume is unset for
> > at least one of its descendants (or dependent devices).
> 
> What about the runtime PM usage counter?

Yes, it applies to that too.

Of course, if dev_pm_skip_suspend() returns "true", the usage counter cannot
be greater than 1 (for the given device as well as for any dependent devices).

> > > >       For a RESUME
> > > >       transition, it will also return "true" if MAY_SKIP_RESUME and
> > > >       power.may_skip_resume are both set, regardless of
> > > >       SMART_SUSPEND or the current runtime status.
> > >
> > > And if the device was not in active use before suspend (as per its usage
> > > counter) or MAY_SKIP_RESUME is unset for at least one of its descendants (or
> > > dependent devices in general).
> > 
> > And analogously here, so what I really should have written is:
> > 
> > And if the device was not in active use before suspend (as per its
> > usage counter) or MAY_SKIP_RESUME or power.may_skip_resume is unset
> > for at least one of its descendants (or dependent devices in general).
> 
> In other words, for RESUME transitions you want the MAY_SKIP_RESUME and
> power.may_skip_resume restrictions to propagate up from dependent
> devices.

Yes, I do.

> And of course, the way to do that is by adding them into the
> power.must_resume flag.

Right.

> How do you want to handle the usage counter restriction.  
> Should that also propagate upward?

Yes, it should.

> And how should the result of dev_pm_skip_resume() be affected by 
> SMART_SUSPEND for RESUME transitions?

Not directly, just through power.must_resume.

> Maybe this is getting confusing because of the way I organized it.  
> Let's try like this:
> 
> Transition   Conditions for dev_pm_skip_resume() to return "true"
> ----------   ----------------------------------------------------
> 
> RESTORE      Never

Right.

> THAW         power.must_resume is clear (which requires
>                MAY_SKIP_RESUME and power.may_skip_resume to be set and 
>                the runtime usage counter to be = 1, and which 
>                propagates up from dependent devices)
>              SMART_SUSPEND is set,
>              runtime status is "suspended"

Like I said above:

 THAW			dev_pm_skip_suspend() returns "true".

> 
> RESUME       Same as THAW?  Or maybe don't require SMART_SUSPEND?
>                (But if SMART_SUSPEND is clear, how could the runtime 
>                status be "suspended"?)

 RESUME		power.must_resume is clear (which requires
				  MAY_SKIP_RESUME and power.may_skip_resume to be set and
				  the runtime usage counter to be = 1, and which 
				  propagates up from dependent devices)

Nothing else is really strictly required IMO.

> 
> I can't really tell what you want, because your comments at various 
> times have been inconsistent.

Sorry for the inconsistencies, I hope that it's more clear now.

Cheers!



