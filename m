Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F6A195FF3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 21:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0UpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 16:45:10 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36229 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727352AbgC0UpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 16:45:10 -0400
Received: (qmail 5854 invoked by uid 500); 27 Mar 2020 16:45:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2020 16:45:09 -0400
Date:   Fri, 27 Mar 2020 16:45:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>
cc:     USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <20200326122744.kbtlmev2ravn3wey@e107158-lin>
Message-ID: <Pine.LNX.4.44L0.2003271515480.29819-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Mar 2020, Qais Yousef wrote:

> On 03/25/20 22:28, Rafael J. Wysocki wrote:
> > On Wed, Mar 25, 2020 at 9:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > > Raphael, now that we have the direct_complete mechanism, can we revisit
> > > this?  Should the PM core automatically call pm_runtime_set_active() if
> > > dev->power.direct_complete isn't set?  Perhaps in device_resume_early()
> > > prior to the pm_runtime_enable() call?
> > >
> > > It's possible we discussed this and decided against it at the time when
> > > direct_complete was added, but if so I don't remember what was said.
> > 
> > Me neither. :-)
> > 
> > That said complexity has grown since then and there are the
> > DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED flags that can be
> > used to control that behavior to some extent.
> > 
> > Setting DPM_FLAG_SMART_SUSPEND alone, in particular, causes
> > pm_runtime_set_active() to be called at the noirq stage of device
> > resume either by the core or by bus types (e.g. PCI) etc.
> > 
> > It looks like ohci-platform might use DPM_FLAG_SMART_SUSPEND, but I
> > need to take a closer look at that (possibly later this week).
> 
> Okay I take it this was root caused correctly and now it's a question of which
> is a better fix.

Indeed.

Raphael, I've been going over the PM core code, trying to figure out
what it's really doing.  It's kind of a mess.

A large part of the problem is related to an inconsistency between the
documentation and the code.  include/linux/pm.h says that
DPM_FLAG_SMART_SUSPEND tells bus types and PM domains about what the
driver wants.  This strongly implies that the PM core will ignore
SMART_SUSPEND.  But in fact the core does check that flag and takes its
own actions if the device has no subsystem-level callbacks!

Furthermore, the PM core's actions don't seem to make sense.  If the
flag is set and the device is runtime-suspended when the system sleep
begins, the core will skip issuing the suspend_late and suspend_noirq
callbacks to the driver.  But it doesn't skip issuing the suspend
callback!  I can't figure that out.  Furthermore, the decisions about
whether to skip the resume_noirq, resume_early, and resume callbacks
are based on different criteria from the decisions on the suspend side.

That's not all: The SMART_SUSPEND decisions completely ignore the value
of DPM_FLAG_NEVER_SKIP!  NEVER_SKIP affects only the direct_completion
pathway.

SMART_SUSPEND seems to have two different meanings.  (1) If the device 
is already in runtime suspend when a system sleep starts, skip the 
suspend_late and suspend_noirq callbacks.  (2) Under certain (similar) 
circumstances, skip the resume callbacks.  The documentation only 
mentions (1) but the code also handles (2).

Other things in there also seem strange.  device_prepare() does a
WARN_ON if either SMART_SUSPEND or LEAVE_SUSPENDED is set and the
device is not runtime-PM-enabled.  That's understandable, but it's also
racy.  A system sleep can begin at any time; how can a driver know when
it is safe to disable a device's runtime PM briefly?

When device_prepare() calculates the power.direct_complete flag, it
checks to see whether the device is currently in runtime suspend in
some cases but not in others, as in the code added by your commit
c62ec4610c40 ("PM / core:  Fix direct_complete handling for devices
with no callbacks").  Since the runtime-PM state is going to checked in
__device_suspend() anyway, we shouldn't need to check it here at all.

At a couple of points in the code, THAW and RESTORE events are each
treatedly specially, with no explanation.

The power.may_skip_resume flag is used in only one place, when 
LEAVE_SUSPENDED is set and there are subsystem-level callbacks.  In 
particular, it is _not_ used by dev_pm_may_skip_resume().  That seems 
highly suspicious at best.

I think it would be worthwhile to expend some serious effort
straightening all this stuff out.  Perhaps we could start with a more
explicit description of what is supposed to happen at each step.  
(Things to be careful about include phrases like "leave suspended",
which is not the same as "don't call the resume callbacks", even though
the two are easily conflated.)

What do you think?

Alan Stern

