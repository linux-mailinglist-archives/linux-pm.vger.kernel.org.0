Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C171AE7DD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 23:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgDQVyX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 17:54:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65504 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgDQVyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 17:54:23 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 678169856faca4dd; Fri, 17 Apr 2020 23:54:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Fri, 17 Apr 2020 23:54:18 +0200
Message-ID: <3462492.idEHzggvYf@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2004171129430.30344-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004171129430.30344-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, April 17, 2020 6:10:19 PM CEST Alan Stern wrote:
> On Fri, 17 Apr 2020, Rafael J. Wysocki wrote:
> 
> > On Thursday, April 16, 2020 5:18:15 PM CEST Alan Stern wrote:
> 

[cut]

> > > So here's what we've got:
> > > 
> > > > > Transition   Conditions for dev_pm_skip_resume() to return "true"
> > > > > ----------   ----------------------------------------------------
> > > > > 
> > > > > RESTORE      Never
> > > > 
> > > > Right.
> > > 
> > > >  THAW	         dev_pm_skip_suspend() returns "true".
> > > 
> > > >  RESUME        power.must_resume is clear (which requires
> > > >                  MAY_SKIP_RESUME and power.may_skip_resume to be set and
> > > >                  the runtime usage counter to be = 1, and which 
> > > >                  propagates up from dependent devices)
> > > > 
> > > > Nothing else is really strictly required IMO.
> > > 
> > > This seems very clear and simple.  And I will repeat here some of the 
> > > things posted earlier, to make the description more complete:
> > > 
> > > 	During the suspend side, for each of the
> > > 	{suspend,freeze,poweroff}_{late,noirq} phases: If
> > > 	dev_pm_skip_suspend() returns true then the subsystem should
> > > 	not invoke the driver's callback, and if there is no subsystem
> > > 	callback then the core will not invoke the driver's callback.
> > > 
> > > 	During the resume side, for each of the
> > > 	{resume,thaw,restore}_{early,noirq} phases: If
> > > 	dev_pm_skip_resume() returns true then the subsystem should
> > > 	not invoke the driver's callback, and if there is no subsystem
> > > 	callback then the core will not invoke the driver's callback.
> > > 
> > > 	dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
> > > 	set and the device's runtime status is "suspended".
> > > 
> > > 	For dev_pm_skip_resume() and power.must_resume, see above.
> > > 
> > > 	At the start of the {resume,thaw,restore}_noirq phase, if
> > > 	dev_pm_skip_resume() returns true then the core will set the
> > > 	runtime status to "suspended".  Otherwise it will set the
> > > 	runtime status to "active".  If this is not what the subsystem
> > > 	or driver wants, it must update the runtime status itself.

There is one detail here that I missed, sorry about that.

Actually, the core can only set the runtime status to "active" for
devices where dev_pm_skip_suspend() returns 'true'.

First, if the device is not "suspended", its status is "active" already
anyway.

Second, if the device has SMART_SUSPEND clear, the driver may not expect
its runtime status to change from "suspended" to "active" during system-wide
resume-type transitions (the driver's system-wide PM callbacks may use
the runtime status to determine what to do and changing the status this
way may confuse that).

[Actually, the drivers that set neither SMART_SUSPEND nor MAY_SKIP_RESUME
 may not expect the runtime status to change during system-wide resume-type
 transitions at all, but there is the corner case when the driver can set
 MAY_SKIP_RESUME without setting SMART_SUSPEND.  In that case its "noirq"
 and "early" resume callbacks may be skipped and then it should expect
 the runtime status to sometimes change from "active" to "suspended" during
 RESUME transitions, but it may still not expect to see changes the other way
 around, as in that case all of its callbacks are going to be invoked and
 apply the internal runtime status handling mentioned above.]

So overall:

  At the start of the {resume,thaw,restore}_noirq phase, if
  dev_pm_skip_resume() returns true ,then the core will set the
  runtime status to "suspended".  Otherwise, if dev_pm_skip_suspend()
  also returns true, then the core will set the runtime status to "active".
  If this is not what the subsystem or driver wants, it must update the
  runtime status itself.

> > > For this to work properly, we will have to rely on subsystems/drivers
> > > to call pm_runtime_resume() during the suspend/freeze transition if
> > > SMART_SUSPEND is clear.
> > 
> > That has been the case forever, though.
> 
> I'm not so sure about that.  The existing PM core code doesn't ever get
> into a situation where it tries to set a device's runtime status to
> "active" while the parent's status is "suspended".

I'm assuming that you refer to the scenario below.

> > > Otherwise we could have the following scenario:
> > > 
> > > Device A has a child B, and both are runtime suspended when hibernation
> > > starts.  Suppose that the SMART_SUSPEND flag is set for A but not for
> > > B, and suppose that B's subsystem/driver neglects to call
> > > pm_runtime_resume() during the FREEZE transition.  Then during the THAW
> > > transition, dev_pm_skip_resume() will return "true" for A and "false"  
> > > for B.  This will lead to an error when the core tries to set B's
> > > runtime status to "active" while A's status is "suspended".

That cannot happen, because dev_pm_smart_suspend() also returns 'false' for B
and so its runtime status will not be changed to "active".

> > > One way to avoid this is to have the core make the pm_runtime_resume()  
> > > call, but you have said that you don't like that approach.  Any 
> > > suggestions?
> > 
> > Because the core has not been calling pm_runtime_resume() during system-wide
> > suspend for devices with SMART_SUSPEND clear, that should not be changed or
> > we'll see regressions.
> > 
> > I know for a fact that some drivers expect the core to be doing nothing
> > with respect to that.
> > 
> > > Should the core take some special action following ->freeze_noirq if
> > > the runtime status is "suspended" and SMART_SUSPEND is clear?
> > 
> > Again, anything like that would change the current behavior which may
> > not be expected by at least some drivers, so I wouldn't change that.
> > 
> > IOW, SMART_SUSPEND clear means to the core that *it* need not care about
> > the suspend side at all (because somebody else will do that).
> 
> But the core _does_ need to care, because if somebody else fails to
> take care of the suspend side then the core would trigger the WARN() in
> pm_runtime_enable() for the parent device.  I guess we could consider
> such a WARN() to be a symptom of a bug in the driver or subsystem,
> rather than in the core; is that how you want to handle the scenario
> above?
> 
> This approach doesn't seem robust.  I can easily imagine cases where
> the parent's driver is aware of SMART_SUSPEND but the child's driver
> isn't.  Currently we don't require the child's driver to call 
> pm_runtime_resume().  Do you really want to consider all such cases to 
> be bugs?
> 
> Basically, I'm saying that if the core allows things to arrive at a
> situation where we can come out of THAW with a runtime-suspended parent
> and a runtime-active child, it really should be considered to be the
> core's fault.

AFAICS, this particular one is not an issue.

BTW, I have updated my pm-sleep-core branch to reflect what appears to be
the current state-of-the-art to me.

I'm going to post a v2 of this patch series over the weekend for reference.

Cheers!



