Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCD1AE1E3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgDQQKU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 12:10:20 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44081 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729654AbgDQQKU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 12:10:20 -0400
Received: (qmail 9640 invoked by uid 500); 17 Apr 2020 12:10:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2020 12:10:19 -0400
Date:   Fri, 17 Apr 2020 12:10:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <2040116.cccRbkeLkK@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004171129430.30344-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 17 Apr 2020, Rafael J. Wysocki wrote:

> On Thursday, April 16, 2020 5:18:15 PM CEST Alan Stern wrote:

> > >   IOW, the
> > > default value of power.may_skip_resume could be the return value of
> > > dev_pm_skip_suspend()?]
> > 
> > How about this?  Let's set power.may_skip_resume to "true" for each
> > device before issuing ->prepare.
> 
> Yes, it can be set to 'true' by default for all devices.
> 
> It doesn't need to be before ->prepare, it can be before ->suspend (as it
> is now).

I suggested doing it before ->prepare so that subsystems can clear
power.may_skip_resume in their ->prepare callbacks.  If you think the
ability to do that isn't important then fine, initialize the flag
before ->suspend.

> > The subsystem can set it to "false"
> > if it wants to during any of the suspend-side callbacks.  Following the
> > ->suspend_noirq callback, the core will do the equivalent of:
> > 
> > 	dev->power.may_skip_resume &= dev_pm_skip_suspend(dev);
> > 
> > before propagating the flag.  Any subsystem changes to support this
> > should be minimal, since only ACPI and PCI currently use
> > may_skip_resume.
> 
> IMO it can be simpler even.
> 
> Because power.may_skip_resume is taken into account along with
> MAY_SKIP_RESUME and the driver setting the latter must be prepared
> for skipping its resume callbacks regardless of the suspend side of
> things, they may always be skipped (and the device may be left in
> suspend accordingly) if there is a reason to avoid doing that.
> 
> The core doesn't know about those reasons, so it has no reason to
> touch power.may_skip_resume after setting it at the outset and then
> whoever sees a reason why these callbacks should run (the subsystem
> or the driver) needs to clear power.may_skip_resume (and clearing it
> more than once obviously makes no difference).

I was trying to implement your suggestion of making the default for
power.may_skip_resume be the return value of dev_pm_skip_suspend().  
However, making the default value be "true" is indeed simpler, and I
think it would work okay.

> > So here's what we've got:
> > 
> > > > Transition   Conditions for dev_pm_skip_resume() to return "true"
> > > > ----------   ----------------------------------------------------
> > > > 
> > > > RESTORE      Never
> > > 
> > > Right.
> > 
> > >  THAW	         dev_pm_skip_suspend() returns "true".
> > 
> > >  RESUME        power.must_resume is clear (which requires
> > >                  MAY_SKIP_RESUME and power.may_skip_resume to be set and
> > >                  the runtime usage counter to be = 1, and which 
> > >                  propagates up from dependent devices)
> > > 
> > > Nothing else is really strictly required IMO.
> > 
> > This seems very clear and simple.  And I will repeat here some of the 
> > things posted earlier, to make the description more complete:
> > 
> > 	During the suspend side, for each of the
> > 	{suspend,freeze,poweroff}_{late,noirq} phases: If
> > 	dev_pm_skip_suspend() returns true then the subsystem should
> > 	not invoke the driver's callback, and if there is no subsystem
> > 	callback then the core will not invoke the driver's callback.
> > 
> > 	During the resume side, for each of the
> > 	{resume,thaw,restore}_{early,noirq} phases: If
> > 	dev_pm_skip_resume() returns true then the subsystem should
> > 	not invoke the driver's callback, and if there is no subsystem
> > 	callback then the core will not invoke the driver's callback.
> > 
> > 	dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
> > 	set and the device's runtime status is "suspended".
> > 
> > 	For dev_pm_skip_resume() and power.must_resume, see above.
> > 
> > 	At the start of the {resume,thaw,restore}_noirq phase, if
> > 	dev_pm_skip_resume() returns true then the core will set the
> > 	runtime status to "suspended".  Otherwise it will set the
> > 	runtime status to "active".  If this is not what the subsystem
> > 	or driver wants, it must update the runtime status itself.
> > 
> > For this to work properly, we will have to rely on subsystems/drivers
> > to call pm_runtime_resume() during the suspend/freeze transition if
> > SMART_SUSPEND is clear.
> 
> That has been the case forever, though.

I'm not so sure about that.  The existing PM core code doesn't ever get
into a situation where it tries to set a device's runtime status to
"active" while the parent's status is "suspended".

> > Otherwise we could have the following scenario:
> > 
> > Device A has a child B, and both are runtime suspended when hibernation
> > starts.  Suppose that the SMART_SUSPEND flag is set for A but not for
> > B, and suppose that B's subsystem/driver neglects to call
> > pm_runtime_resume() during the FREEZE transition.  Then during the THAW
> > transition, dev_pm_skip_resume() will return "true" for A and "false"  
> > for B.  This will lead to an error when the core tries to set B's
> > runtime status to "active" while A's status is "suspended".
> > 
> > One way to avoid this is to have the core make the pm_runtime_resume()  
> > call, but you have said that you don't like that approach.  Any 
> > suggestions?
> 
> Because the core has not been calling pm_runtime_resume() during system-wide
> suspend for devices with SMART_SUSPEND clear, that should not be changed or
> we'll see regressions.
> 
> I know for a fact that some drivers expect the core to be doing nothing
> with respect to that.
> 
> > Should the core take some special action following ->freeze_noirq if
> > the runtime status is "suspended" and SMART_SUSPEND is clear?
> 
> Again, anything like that would change the current behavior which may
> not be expected by at least some drivers, so I wouldn't change that.
> 
> IOW, SMART_SUSPEND clear means to the core that *it* need not care about
> the suspend side at all (because somebody else will do that).

But the core _does_ need to care, because if somebody else fails to
take care of the suspend side then the core would trigger the WARN() in
pm_runtime_enable() for the parent device.  I guess we could consider
such a WARN() to be a symptom of a bug in the driver or subsystem,
rather than in the core; is that how you want to handle the scenario
above?

This approach doesn't seem robust.  I can easily imagine cases where
the parent's driver is aware of SMART_SUSPEND but the child's driver
isn't.  Currently we don't require the child's driver to call 
pm_runtime_resume().  Do you really want to consider all such cases to 
be bugs?

Basically, I'm saying that if the core allows things to arrive at a
situation where we can come out of THAW with a runtime-suspended parent
and a runtime-active child, it really should be considered to be the
core's fault.

Alan Stern

