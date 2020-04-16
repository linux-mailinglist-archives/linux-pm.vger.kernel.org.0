Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C31AC913
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504093AbgDPPSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 11:18:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34901 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2504089AbgDPPSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 11:18:16 -0400
Received: (qmail 4506 invoked by uid 500); 16 Apr 2020 11:18:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Apr 2020 11:18:15 -0400
Date:   Thu, 16 Apr 2020 11:18:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <1998412.Cp2JyuGtSI@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004161036410.14937-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for all your help straightening this out.  I think the end 
result will be a distinct improvement over the old code.

On Thu, 16 Apr 2020, Rafael J. Wysocki wrote:

> This means that the dev_pm_skip_resume() logic really is relatively
> straightforward:
>  - If the current transition is RESTORE, return "false".
>  - Otherwise, if the current transition is THAW, return the return value
>    of dev_pm_skip_suspend().
>  - Otherwise (so the current transition is RESUME which is the only remaining
>    case), return the logical negation of power.must_resume.
> 
> > Also, it would mean 
> > that a device whose subsystem doesn't know about power.may_skip_resume 
> > would never be allowed to stay in runtime suspend.
> 
> Not really, because I want the core to set power.may_skip_resume for the
> devices for which dev_pm_skip_suspend() returns "true" if the "suspend_late"
> subsystem-level callback is not present.  [It might be more consistent
> to simply set it for all devices for which dev_pm_skip_suspend() returns
> "true" and let the subsystems update it should they want to?  IOW, the
> default value of power.may_skip_resume could be the return value of
> dev_pm_skip_suspend()?]

How about this?  Let's set power.may_skip_resume to "true" for each
device before issuing ->prepare.  The subsystem can set it to "false"
if it wants to during any of the suspend-side callbacks.  Following the
->suspend_noirq callback, the core will do the equivalent of:

	dev->power.may_skip_resume &= dev_pm_skip_suspend(dev);

before propagating the flag.  Any subsystem changes to support this
should be minimal, since only ACPI and PCI currently use
may_skip_resume.

> > What about the runtime PM usage counter?
> 
> Yes, it applies to that too.
> 
> Of course, if dev_pm_skip_suspend() returns "true", the usage counter cannot
> be greater than 1 (for the given device as well as for any dependent devices).

Well, in theory the subsystem could call pm_runtime_get_noresume().  I 
can't imagine why it would want to, though.

So here's what we've got:

> > Transition   Conditions for dev_pm_skip_resume() to return "true"
> > ----------   ----------------------------------------------------
> > 
> > RESTORE      Never
> 
> Right.

>  THAW	         dev_pm_skip_suspend() returns "true".

>  RESUME        power.must_resume is clear (which requires
>                  MAY_SKIP_RESUME and power.may_skip_resume to be set and
>                  the runtime usage counter to be = 1, and which 
>                  propagates up from dependent devices)
> 
> Nothing else is really strictly required IMO.

This seems very clear and simple.  And I will repeat here some of the 
things posted earlier, to make the description more complete:

	During the suspend side, for each of the
	{suspend,freeze,poweroff}_{late,noirq} phases: If
	dev_pm_skip_suspend() returns true then the subsystem should
	not invoke the driver's callback, and if there is no subsystem
	callback then the core will not invoke the driver's callback.

	During the resume side, for each of the
	{resume,thaw,restore}_{early,noirq} phases: If
	dev_pm_skip_resume() returns true then the subsystem should
	not invoke the driver's callback, and if there is no subsystem
	callback then the core will not invoke the driver's callback.

	dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
	set and the device's runtime status is "suspended".

	For dev_pm_skip_resume() and power.must_resume, see above.

	At the start of the {resume,thaw,restore}_noirq phase, if
	dev_pm_skip_resume() returns true then the core will set the
	runtime status to "suspended".  Otherwise it will set the
	runtime status to "active".  If this is not what the subsystem
	or driver wants, it must update the runtime status itself.

For this to work properly, we will have to rely on subsystems/drivers
to call pm_runtime_resume() during the suspend/freeze transition if
SMART_SUSPEND is clear.  Otherwise we could have the following
scenario:

Device A has a child B, and both are runtime suspended when hibernation
starts.  Suppose that the SMART_SUSPEND flag is set for A but not for
B, and suppose that B's subsystem/driver neglects to call
pm_runtime_resume() during the FREEZE transition.  Then during the THAW
transition, dev_pm_skip_resume() will return "true" for A and "false"  
for B.  This will lead to an error when the core tries to set B's
runtime status to "active" while A's status is "suspended".

One way to avoid this is to have the core make the pm_runtime_resume()  
call, but you have said that you don't like that approach.  Any 
suggestions?

Should the core take some special action following ->freeze_noirq if
the runtime status is "suspended" and SMART_SUSPEND is clear?

Alan Stern

