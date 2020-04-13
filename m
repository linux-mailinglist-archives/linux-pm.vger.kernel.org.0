Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF31A6E58
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbgDMVct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 17:32:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55224 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbgDMVcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 17:32:48 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 40cc3ddfdceb1350; Mon, 13 Apr 2020 23:32:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Mon, 13 Apr 2020 23:32:43 +0200
Message-ID: <6362254.rXp5uA8eak@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2004102231270.30859-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004102231270.30859-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, April 11, 2020 4:41:14 AM CEST Alan Stern wrote:
> Okay, this is my attempt to summarize what we have been discussing.  
> But first: There is a dev_pm_skip_resume() helper routine which
> subsystems can call to see whether resume-side _early and _noirq driver
> callbacks should be skipped.  But there is no corresponding
> dev_pm_skip_suspend() helper routine.  Let's add one, or rename
> dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().

OK

> Given that, here's my understanding of what should happen.  (I'm
> assuming the direct_complete mechanism is not being used.)  This tries
> to describe what we _want_ to happen, which is not always the same as
> what the current code actually _does_.

OK

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

Agreed with the above.

> 	power.must_resume gets set following the suspend-side _noirq
> 	phase if power.usage_count > 1 (indicating the device was
> 	in active use before the start of the sleep transition) or
> 	power.must_resume is set for any of the device's dependents.

Or MAY_SKIP_RESUME is unset (which means that the driver does not
allow its resume callbacks to be skipped), or power.may_skip_resume
is unset (which means that the subsystem does not allow the
driver callbacks to be skipped).

> 	dev_pm_skip_resume() will return "false" if the current
> 	transition is RESTORE or power.must_resume is set.  Otherwise:
> 	It will return true if the current transition is THAW,
> 	SMART_SUSPEND is set, and the device's runtime status is
> 	"suspended".

The other way around.  That is:

dev_pm_skip_resume() will return "true" if the current transition is
THAW and dev_pm_skip_suspend() returns "true" for that device (so
SMART_SUSPEND is set, and the device's runtime status is "suspended",
as per the definition of that function above).

Otherwise, it will return "true" if the current transition is RESTORE
(which means that all devices are resumed) or power.must_resume is not
set (so this particular device need not be resumed).

>  It will return "true" if the current transition is
> 	RESUME, SMART_SUSPEND and MAY_SKIP_RESUME are both set, and
> 	the device's runtime status is "suspended".

Unless MAY_SKIP_RESUME is unset for at least one of its descendants (or
dependent devices).

> 	For a RESUME
> 	transition, it will also return "true" if MAY_SKIP_RESUME and
> 	power.may_skip_resume are both set, regardless of
> 	SMART_SUSPEND or the current runtime status.

And if the device was not in active use before suspend (as per its usage
counter) or MAY_SKIP_RESUME is unset for at least one of its descendants (or
dependent devices in general).

> 	At the start of the {resume,thaw,restore}_noirq phase, if
> 	dev_pm_skip_resume() returns true then the core will set the
> 	runtime status to "suspended".  Otherwise it will set the
> 	runtime status to "active".  If this is not what the subsystem
> 	or driver wants, it must update the runtime status itself.

Right.

> Comments and differences with respect to the code in your pm-sleep-core
> branch:
> 
> 	I'm not sure whether we should specify other conditions for
> 	setting power.must_resume.

IMO we should.

Otherwise it is rather hard to catch the case in which one of the
device's descendants has MAY_SKIP_RESUME unset (and so the device
needs to be resumed).

> 	dev_pm_skip_resume() doesn't compute the value described
> 	above.  I'm pretty sure the existing code is wrong.

Well, we don't seem to have reached an agreement on some details
above ...

Cheers!



