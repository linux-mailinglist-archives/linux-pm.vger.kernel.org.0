Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E21AE8A4
	for <lists+linux-pm@lfdr.de>; Sat, 18 Apr 2020 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDQXhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 19:37:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40995 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726036AbgDQXhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 19:37:37 -0400
Received: (qmail 14532 invoked by uid 500); 17 Apr 2020 19:37:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2020 19:37:36 -0400
Date:   Fri, 17 Apr 2020 19:37:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <3462492.idEHzggvYf@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004171928160.13245-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 17 Apr 2020, Rafael J. Wysocki wrote:

> There is one detail here that I missed, sorry about that.
> 
> Actually, the core can only set the runtime status to "active" for
> devices where dev_pm_skip_suspend() returns 'true'.
> 
> First, if the device is not "suspended", its status is "active" already
> anyway.
> 
> Second, if the device has SMART_SUSPEND clear, the driver may not expect
> its runtime status to change from "suspended" to "active" during system-wide
> resume-type transitions (the driver's system-wide PM callbacks may use
> the runtime status to determine what to do and changing the status this
> way may confuse that).
> 
> [Actually, the drivers that set neither SMART_SUSPEND nor MAY_SKIP_RESUME
>  may not expect the runtime status to change during system-wide resume-type
>  transitions at all, but there is the corner case when the driver can set
>  MAY_SKIP_RESUME without setting SMART_SUSPEND.  In that case its "noirq"
>  and "early" resume callbacks may be skipped and then it should expect
>  the runtime status to sometimes change from "active" to "suspended" during
>  RESUME transitions, but it may still not expect to see changes the other way
>  around, as in that case all of its callbacks are going to be invoked and
>  apply the internal runtime status handling mentioned above.]
> 
> So overall:
> 
>   At the start of the {resume,thaw,restore}_noirq phase, if
>   dev_pm_skip_resume() returns true ,then the core will set the
>   runtime status to "suspended".  Otherwise, if dev_pm_skip_suspend()
>   also returns true, then the core will set the runtime status to "active".
>   If this is not what the subsystem or driver wants, it must update the
>   runtime status itself.

Sigh.  The bug which prompted this whole thread was when I forgot to 
set the runtime PM status back to "active" in one of my drivers.  I was 
hoping the core could handle it for me automatically.

I guess the answer is always to set the SMART_SUSPEND flag.


> > > > For this to work properly, we will have to rely on subsystems/drivers
> > > > to call pm_runtime_resume() during the suspend/freeze transition if
> > > > SMART_SUSPEND is clear.
> > > 
> > > That has been the case forever, though.
> > 
> > I'm not so sure about that.  The existing PM core code doesn't ever get
> > into a situation where it tries to set a device's runtime status to
> > "active" while the parent's status is "suspended".
> 
> I'm assuming that you refer to the scenario below.
> 
> > > > Otherwise we could have the following scenario:
> > > > 
> > > > Device A has a child B, and both are runtime suspended when hibernation
> > > > starts.  Suppose that the SMART_SUSPEND flag is set for A but not for
> > > > B, and suppose that B's subsystem/driver neglects to call
> > > > pm_runtime_resume() during the FREEZE transition.  Then during the THAW
> > > > transition, dev_pm_skip_resume() will return "true" for A and "false"  
> > > > for B.  This will lead to an error when the core tries to set B's
> > > > runtime status to "active" while A's status is "suspended".
> 
> That cannot happen, because dev_pm_smart_suspend() also returns 'false' for B
> and so its runtime status will not be changed to "active".

Yes, your change to dev_pm_skip_resume() will prevent the problem from 
arising.


> BTW, I have updated my pm-sleep-core branch to reflect what appears to be
> the current state-of-the-art to me.
> 
> I'm going to post a v2 of this patch series over the weekend for reference.

Okay, I'll check it out.

By the way, if you don't mind I may want to do some editing of 
devices.rst.

Alan Stern


