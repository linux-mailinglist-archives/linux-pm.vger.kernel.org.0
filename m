Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1701A87EA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502660AbgDNRsB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 13:48:01 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46809 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2502659AbgDNRrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 13:47:45 -0400
Received: (qmail 24357 invoked by uid 500); 14 Apr 2020 13:47:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Apr 2020 13:47:35 -0400
Date:   Tue, 14 Apr 2020 13:47:35 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <CAJZ5v0jSMC1FGc2N06B=2VmXRF1XJi4gNyKPkjfBPCEtjm50Yw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004141150590.12758-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Apr 2020, Rafael J. Wysocki wrote:

> Note to self: avoid replying to technical messages late in the night ...
> 
> On Mon, Apr 13, 2020 at 11:32 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Saturday, April 11, 2020 4:41:14 AM CEST Alan Stern wrote:
> > > Okay, this is my attempt to summarize what we have been discussing.
> > > But first: There is a dev_pm_skip_resume() helper routine which
> > > subsystems can call to see whether resume-side _early and _noirq driver
> > > callbacks should be skipped.  But there is no corresponding
> > > dev_pm_skip_suspend() helper routine.  Let's add one, or rename
> > > dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().
> >
> > OK
> >
> > > Given that, here's my understanding of what should happen.  (I'm
> > > assuming the direct_complete mechanism is not being used.)  This tries
> > > to describe what we _want_ to happen, which is not always the same as
> > > what the current code actually _does_.
> >
> > OK
> >
> > >       During the suspend side, for each of the
> > >       {suspend,freeze,poweroff}_{late,noirq} phases: If
> > >       dev_pm_skip_suspend() returns true then the subsystem should
> > >       not invoke the driver's callback, and if there is no subsystem
> > >       callback then the core will not invoke the driver's callback.
> > >
> > >       During the resume side, for each of the
> > >       {resume,thaw,restore}_{early,noirq} phases: If
> > >       dev_pm_skip_resume() returns true then the subsystem should
> > >       not invoke the driver's callback, and if there is no subsystem
> > >       callback then the core will not invoke the driver's callback.
> > >
> > >       dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
> > >       set and the device's runtime status is "suspended".
> >
> > Agreed with the above.
> >
> > >       power.must_resume gets set following the suspend-side _noirq
> > >       phase if power.usage_count > 1 (indicating the device was
> > >       in active use before the start of the sleep transition) or
> > >       power.must_resume is set for any of the device's dependents.
> >
> > Or MAY_SKIP_RESUME is unset (which means that the driver does not
> > allow its resume callbacks to be skipped), or power.may_skip_resume
> > is unset (which means that the subsystem does not allow the
> > driver callbacks to be skipped).

Are you certain about that?  It contradicts what you said earlier, that
MAY_SKIP_RESUME doesn't affect THAW transitions.  Also, it would mean 
that a device whose subsystem doesn't know about power.may_skip_resume 
would never be allowed to stay in runtime suspend.

> > >       dev_pm_skip_resume() will return "false" if the current
> > >       transition is RESTORE or power.must_resume is set.  Otherwise:
> > >       It will return true if the current transition is THAW,
> > >       SMART_SUSPEND is set, and the device's runtime status is
> > >       "suspended".
> >
> > The other way around.  That is:
> >
> > dev_pm_skip_resume() will return "true" if the current transition is
> > THAW and dev_pm_skip_suspend() returns "true" for that device (so
> > SMART_SUSPEND is set, and the device's runtime status is "suspended",
> > as per the definition of that function above).
> 
> The above is what I wanted to say ->

So for THAW, dev_pm_skip_resume() can return "true" even if 
power.must_resume is set?  That doesn't seem right.

> > Otherwise, it will return "true" if the current transition is RESTORE
> > (which means that all devices are resumed) or power.must_resume is not
> > set (so this particular device need not be resumed).
> 
> -> but this isn't.  In particular, I messed up the RESTORE part, so it
> should read:
> 
> Otherwise, it will return "true" if the current transition is *not*
> RESTORE (in which case all devices would be resumed) *and*
> power.must_resume is not set (so this particular device need not be
> resumed).
> 
> Sorry about that.

For the RESTORE and THAW cases that is exactly the same as what I 
wrote, apart from the THAW issue noted above.

> > >  It will return "true" if the current transition is
> > >       RESUME, SMART_SUSPEND and MAY_SKIP_RESUME are both set, and
> > >       the device's runtime status is "suspended".
> >
> > Unless MAY_SKIP_RESUME is unset for at least one of its descendants (or
> > dependent devices).
> 
> That should include the power.may_skip_resume flag, so as to read as follows:
> 
> Unless MAY_SKIP_RESUME is unset or power.may_skip_resume is unset for
> at least one of its descendants (or dependent devices).

What about the runtime PM usage counter?

> > >       For a RESUME
> > >       transition, it will also return "true" if MAY_SKIP_RESUME and
> > >       power.may_skip_resume are both set, regardless of
> > >       SMART_SUSPEND or the current runtime status.
> >
> > And if the device was not in active use before suspend (as per its usage
> > counter) or MAY_SKIP_RESUME is unset for at least one of its descendants (or
> > dependent devices in general).
> 
> And analogously here, so what I really should have written is:
> 
> And if the device was not in active use before suspend (as per its
> usage counter) or MAY_SKIP_RESUME or power.may_skip_resume is unset
> for at least one of its descendants (or dependent devices in general).

In other words, for RESUME transitions you want the MAY_SKIP_RESUME and
power.may_skip_resume restrictions to propagate up from dependent
devices.  And of course, the way to do that is by adding them into the
power.must_resume flag.

How do you want to handle the usage counter restriction.  
Should that also propagate upward?

And how should the result of dev_pm_skip_resume() be affected by 
SMART_SUSPEND for RESUME transitions?

Maybe this is getting confusing because of the way I organized it.  
Let's try like this:

Transition   Conditions for dev_pm_skip_resume() to return "true"
----------   ----------------------------------------------------

RESTORE      Never

THAW         power.must_resume is clear (which requires
               MAY_SKIP_RESUME and power.may_skip_resume to be set and 
               the runtime usage counter to be = 1, and which 
               propagates up from dependent devices)
             SMART_SUSPEND is set,
             runtime status is "suspended"

RESUME       Same as THAW?  Or maybe don't require SMART_SUSPEND?
               (But if SMART_SUSPEND is clear, how could the runtime 
               status be "suspended"?)

I can't really tell what you want, because your comments at various 
times have been inconsistent.

Alan Stern

> > >       At the start of the {resume,thaw,restore}_noirq phase, if
> > >       dev_pm_skip_resume() returns true then the core will set the
> > >       runtime status to "suspended".  Otherwise it will set the
> > >       runtime status to "active".  If this is not what the subsystem
> > >       or driver wants, it must update the runtime status itself.
> >
> > Right.
> >
> > > Comments and differences with respect to the code in your pm-sleep-core
> > > branch:
> > >
> > >       I'm not sure whether we should specify other conditions for
> > >       setting power.must_resume.
> >
> > IMO we should.
> 
> In fact, this is part of the implementation and it helps to
> "propagate" the "must resume" condition to the parent and the
> first-order suppliers of the device (which is sufficient, because
> their power.must_resume "propagates" in the same way and so on).
> 
> IOW, the important piece is what the return value of
> dev_pm_skip_resume() should be in particular conditions and that
> return value is computed with the help of power.must_resume (and it
> might have been computed in a different, possibly less efficient,
> way).
> 
> > Otherwise it is rather hard to catch the case in which one of the
> > device's descendants has MAY_SKIP_RESUME unset (and so the device
> > needs to be resumed).
> >
> > >       dev_pm_skip_resume() doesn't compute the value described
> > >       above.  I'm pretty sure the existing code is wrong.
> >
> > Well, we don't seem to have reached an agreement on some details
> > above ...
> 
> Sorry for failing to be careful enough ...


