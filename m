Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B421ADA9A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgDQJ6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 05:58:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55670 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDQJ6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 05:58:00 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 58873dd5037093b4; Fri, 17 Apr 2020 11:57:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Fri, 17 Apr 2020 11:57:55 +0200
Message-ID: <2040116.cccRbkeLkK@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2004161036410.14937-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004161036410.14937-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, April 16, 2020 5:18:15 PM CEST Alan Stern wrote:
> Thanks for all your help straightening this out.  I think the end 
> result will be a distinct improvement over the old code.

Yes, I believe so.

> On Thu, 16 Apr 2020, Rafael J. Wysocki wrote:
> 
> > This means that the dev_pm_skip_resume() logic really is relatively
> > straightforward:
> >  - If the current transition is RESTORE, return "false".
> >  - Otherwise, if the current transition is THAW, return the return value
> >    of dev_pm_skip_suspend().
> >  - Otherwise (so the current transition is RESUME which is the only remaining
> >    case), return the logical negation of power.must_resume.
> > 
> > > Also, it would mean 
> > > that a device whose subsystem doesn't know about power.may_skip_resume 
> > > would never be allowed to stay in runtime suspend.
> > 
> > Not really, because I want the core to set power.may_skip_resume for the
> > devices for which dev_pm_skip_suspend() returns "true" if the "suspend_late"
> > subsystem-level callback is not present.  [It might be more consistent
> > to simply set it for all devices for which dev_pm_skip_suspend() returns
> > "true" and let the subsystems update it should they want to?  IOW, the
> > default value of power.may_skip_resume could be the return value of
> > dev_pm_skip_suspend()?]
> 
> How about this?  Let's set power.may_skip_resume to "true" for each
> device before issuing ->prepare.

Yes, it can be set to 'true' by default for all devices.

It doesn't need to be before ->prepare, it can be before ->suspend (as it
is now).

> The subsystem can set it to "false"
> if it wants to during any of the suspend-side callbacks.  Following the
> ->suspend_noirq callback, the core will do the equivalent of:
> 
> 	dev->power.may_skip_resume &= dev_pm_skip_suspend(dev);
> 
> before propagating the flag.  Any subsystem changes to support this
> should be minimal, since only ACPI and PCI currently use
> may_skip_resume.

IMO it can be simpler even.

Because power.may_skip_resume is taken into account along with
MAY_SKIP_RESUME and the driver setting the latter must be prepared
for skipping its resume callbacks regardless of the suspend side of
things, they may always be skipped (and the device may be left in
suspend accordingly) if there is a reason to avoid doing that.

The core doesn't know about those reasons, so it has no reason to
touch power.may_skip_resume after setting it at the outset and then
whoever sees a reason why these callbacks should run (the subsystem
or the driver) needs to clear power.may_skip_resume (and clearing it
more than once obviously makes no difference).

> > > What about the runtime PM usage counter?
> > 
> > Yes, it applies to that too.
> > 
> > Of course, if dev_pm_skip_suspend() returns "true", the usage counter cannot
> > be greater than 1 (for the given device as well as for any dependent devices).
> 
> Well, in theory the subsystem could call pm_runtime_get_noresume().  I 
> can't imagine why it would want to, though.

Indeed.

> So here's what we've got:
> 
> > > Transition   Conditions for dev_pm_skip_resume() to return "true"
> > > ----------   ----------------------------------------------------
> > > 
> > > RESTORE      Never
> > 
> > Right.
> 
> >  THAW	         dev_pm_skip_suspend() returns "true".
> 
> >  RESUME        power.must_resume is clear (which requires
> >                  MAY_SKIP_RESUME and power.may_skip_resume to be set and
> >                  the runtime usage counter to be = 1, and which 
> >                  propagates up from dependent devices)
> > 
> > Nothing else is really strictly required IMO.
> 
> This seems very clear and simple.  And I will repeat here some of the 
> things posted earlier, to make the description more complete:
> 
> 	During the suspend side, for each of the
> 	{suspend,freeze,poweroff}_{late,noirq} phases: If
> 	dev_pm_skip_suspend() returns true then the subsystem should
> 	not invoke the driver's callback, and if there is no subsystem
> 	callback then the core will not invoke the driver's callback.
> 
> 	During the resume side, for each of the
> 	{resume,thaw,restore}_{early,noirq} phases: If
> 	dev_pm_skip_resume() returns true then the subsystem should
> 	not invoke the driver's callback, and if there is no subsystem
> 	callback then the core will not invoke the driver's callback.
> 
> 	dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
> 	set and the device's runtime status is "suspended".
> 
> 	For dev_pm_skip_resume() and power.must_resume, see above.
> 
> 	At the start of the {resume,thaw,restore}_noirq phase, if
> 	dev_pm_skip_resume() returns true then the core will set the
> 	runtime status to "suspended".  Otherwise it will set the
> 	runtime status to "active".  If this is not what the subsystem
> 	or driver wants, it must update the runtime status itself.
> 
> For this to work properly, we will have to rely on subsystems/drivers
> to call pm_runtime_resume() during the suspend/freeze transition if
> SMART_SUSPEND is clear.

That has been the case forever, though.

> Otherwise we could have the following scenario:
> 
> Device A has a child B, and both are runtime suspended when hibernation
> starts.  Suppose that the SMART_SUSPEND flag is set for A but not for
> B, and suppose that B's subsystem/driver neglects to call
> pm_runtime_resume() during the FREEZE transition.  Then during the THAW
> transition, dev_pm_skip_resume() will return "true" for A and "false"  
> for B.  This will lead to an error when the core tries to set B's
> runtime status to "active" while A's status is "suspended".
> 
> One way to avoid this is to have the core make the pm_runtime_resume()  
> call, but you have said that you don't like that approach.  Any 
> suggestions?

Because the core has not been calling pm_runtime_resume() during system-wide
suspend for devices with SMART_SUSPEND clear, that should not be changed or
we'll see regressions.

I know for a fact that some drivers expect the core to be doing nothing
with respect to that.

> Should the core take some special action following ->freeze_noirq if
> the runtime status is "suspended" and SMART_SUSPEND is clear?

Again, anything like that would change the current behavior which may
not be expected by at least some drivers, so I wouldn't change that.

IOW, SMART_SUSPEND clear means to the core that *it* need not care about
the suspend side at all (because somebody else will do that).



