Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD21A39EB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDISpt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 14:45:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56789 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDISpt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 14:45:49 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 0829b55dba071591; Thu, 9 Apr 2020 20:45:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Thu, 09 Apr 2020 20:45:45 +0200
Message-ID: <3100919.FSIbSBgRSq@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2004061541080.26186-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004061541080.26186-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 6, 2020 10:25:08 PM CEST Alan Stern wrote:
> On Mon, 6 Apr 2020, Rafael J. Wysocki wrote:
> 
> > In the meantime I have created a git branch with changes to simplify the code,
> > rename some things and clarify the documentation a bit:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  pm-sleep-core
> > 
> > (https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-sleep-core
> > for web access).
> > 
> > I'm going to post these changes as patches soon.
> 
> All right, those are some significant changes.  It'll take me a little 
> while to absorb them.
> 
> > On Friday, April 3, 2020 10:15:09 PM CEST Alan Stern wrote:
> 
> > > Let's put it like this: The resume-side callbacks should have the
> > > overall effect of bringing the device back to its initial state, with
> > > the following exceptions and complications:
> > > 
> > > 	Unless SMART_SUSPEND and LEAVE_SUSPEND are both set, a device
> > > 	that was in runtime suspend before the suspend_late phase 
> > > 	must end up being runtime-active after the matching RESUME.
> > >
> > > 	Unless SMART_SUSPEND is set, a device that was in runtime 
> > > 	suspend before the freeze_late phase must end up being 
> > > 	runtime-active after the matching THAW.
> > 
> > Correct.
> >  
> > > [I'm not so sure about this.  Wouldn't it make more sense to treat
> > > _every_ device as though SMART_SUSPEND was set for FREEZE/THAW
> > > transitions, and require subsystems to do the same?]
> > 
> > Drivers may expect devices to be runtime-active when their suspend
> > callbacks are invoked unless they set SMART_SUSPEND.  IOW, without
> > SMART_SUSPEND set the device should not be left in runtime suspend
> > during system-wide suspend at all unless direct-complete is applied
> > to it.
> 
> [Let's confine this discussion to the not-direct-complete case.]
> 
> Okay, say that SMART_SUSPEND isn't set and the device is initially
> runtime-suspended.  Since the core knows all this, shouldn't the core 
> then call pm_runtime_resume() immediately before ->suspend?  Why leave 
> this up to subsystems or drivers (which can easily get it wrong -- 
> not to mention all the code duplication it would require)?

I would agree in principle, but that has been done by subsystems forever and
(at least in some cases) drivers on bus types like platform on i2c (where
subsystem-level PM callbacks are not provided in general unless there is a PM
domain doing that) don't expect the devices to be resumed and they
decide whether or not to do that themselves.

Making the core resume the runtime-suspended devices during system-wide
suspend, would require those drivers to adapt and it is rather hard to
even estimate how many of them there are.

> Also, doesn't it make sense for some subsystems or drivers to want 
> their devices to remain in runtime suspend throughout a FREEZE/THAW 
> transition but not throughout a SUSPEND/RESUME transition?  With only a 
> single SMART_SUSPEND flag, how can we accomodate this desire?

That's a fair statement, but in general it is more desirable to optimize
suspend/resume than to optimize hibernation, so the latter is not a priority.

I'm not ruling out adding one more flag specific to hibernation or similar
in the future.

> Finally, my description above says that LEAVE_SUSPENDED matters for 
> SUSPEND/RESUME but not for FREEZE/THAW.  Is that really what you have 
> in mind?

Yes, it is.  LEAVE_SUSPENDED really does not apply to hibernation at all.

> > > 	After RESTORE, _every_ device must end up being runtime 
> > > 	active.
> > 
> > Correct.
> > 
> > > 	In general, each resume-side callback should undo the effect
> > > 	of the matching suspend-side callback.  However, because of
> > > 	the requirements mentioned in the preceding sentences,
> > > 	sometimes a resume-side callback will be issued even though
> > > 	the matching suspend-side callback was skipped -- i.e., when
> > > 	a device that starts out runtime-suspended ends up being
> > > 	runtime-active.
> > > 
> > > How does that sound?
> > 
> > It is correct, but in general the other way around is possible too.
> > That is, a suspend-side callback may be issued without the matching
> > resume-side one and the device's PM runtime status may be changed
> > if LEAVE_SUSPENDED is set and SMART_SUSPEND is unset.
> 
> This is inconsistent with what I wrote above (the "Unless SMART_SUSPEND
> and LEAVE_SUSPENDED are both set" part).  Are you saying that text
> should be changed?

Yes, in fact SMART_SUSPEND need not be set for resume callbacks to be skipped.

LEAVE_SUSPENDED must be set for that to happen (except for hibernation) and it
may be sufficient if the subsystem sets power.may_skip_resume in addition.

> > > Are you certain you want the subsystem callback to be responsible for
> > > setting the runtime status to "active"?  Isn't this an example of
> > > something the core could do in order to help simplify subsystems?
> > 
> > The rationale here is that whoever decides whether or not to skip the
> > driver-level callbacks, should also set the PM-runtime status of the
> > device to match that decision.
> 
> Well, that's not really a fair description.  The decision about
> skipping driver-level callbacks is being made right here, by us, now.  
> (Or if you prefer, by the developers who originally added the
> SMART_SUSPEND flag.)  We require subsystems to obey the decisions being
> outlined in this discussion.
> 
> Given that fact, this is again a case of having the core do something 
> rather than forcing subsystems/drivers to do it (possibly getting it 
> wrong and certainly creating a lot of code duplication).
> 
> If a subsystem really wants to override our decision, it can always
> call pm_runtime_set_{active|suspended} to override the core's setting.

OK, fair enough.

I've incorporated this into the changes on the pm-sleep-core branch
mentioned before.

> > > And this brings up another thing the core might do to help simplify
> > > drivers and subsystems: If SMART_SUSPEND isn't set and the device is in
> > > runtime suspend, couldn't the core do a pm_runtime_resume before
> > > issuing the ->suspend or ->suspend_late callback?
> > 
> > It could, but sometimes that is not desirable.  Like when the drivver points its
> > suspend callback to pm_runtime_force_suspend().
> 
> This seems to contradict what you wrote above: "Drivers may expect
> devices to be runtime-active when their suspend callbacks are invoked
> unless they set SMART_SUSPEND.  IOW, without SMART_SUSPEND set the
> device should not be left in runtime suspend during system-wide suspend
> at all unless direct-complete is applied to it."
> 
> If you stand by that statement then drivers should never point their
> suspend callback to pm_runtime_force_suspend() unless they also set
> SMART_SUSPEND.

OK, let me rephrase.

Some drivers that don't use SMART_SUSPEND expect the devices to be runtime-active
when their system-wide PM callbacks run, but the other drivers do not have such
expectations, because the subsystems they work with have never resumed devices
during system-wide suspend.

SMART_SUSPEND is not needed for the latter category of drivers, but it is for
the former and I want the behavior when SMART_SUSPEND *is* set to be consistent
across the core and subsystems, while the other case have never been so.

Cheers!



