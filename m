Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6D1A4D89
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 04:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDKClO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 22:41:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54033 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726683AbgDKClO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 22:41:14 -0400
Received: (qmail 1139 invoked by uid 500); 10 Apr 2020 22:41:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Apr 2020 22:41:14 -0400
Date:   Fri, 10 Apr 2020 22:41:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <3100919.FSIbSBgRSq@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004102231270.30859-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Okay, this is my attempt to summarize what we have been discussing.  
But first: There is a dev_pm_skip_resume() helper routine which
subsystems can call to see whether resume-side _early and _noirq driver
callbacks should be skipped.  But there is no corresponding
dev_pm_skip_suspend() helper routine.  Let's add one, or rename
dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().

Given that, here's my understanding of what should happen.  (I'm
assuming the direct_complete mechanism is not being used.)  This tries
to describe what we _want_ to happen, which is not always the same as
what the current code actually _does_.

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

	power.must_resume gets set following the suspend-side _noirq
	phase if power.usage_count > 1 (indicating the device was
	in active use before the start of the sleep transition) or
	power.must_resume is set for any of the device's dependents.

	dev_pm_skip_resume() will return "false" if the current
	transition is RESTORE or power.must_resume is set.  Otherwise:
	It will return true if the current transition is THAW,
	SMART_SUSPEND is set, and the device's runtime status is
	"suspended".  It will return "true" if the current transition is
	RESUME, SMART_SUSPEND and MAY_SKIP_RESUME are both set, and
	the device's runtime status is "suspended".  For a RESUME
	transition, it will also return "true" if MAY_SKIP_RESUME and
	power.may_skip_resume are both set, regardless of
	SMART_SUSPEND or the current runtime status.

	At the start of the {resume,thaw,restore}_noirq phase, if
	dev_pm_skip_resume() returns true then the core will set the
	runtime status to "suspended".  Otherwise it will set the
	runtime status to "active".  If this is not what the subsystem
	or driver wants, it must update the runtime status itself.

Comments and differences with respect to the code in your pm-sleep-core
branch:

	I'm not sure whether we should specify other conditions for
	setting power.must_resume.

	dev_pm_skip_resume() doesn't compute the value described
	above.  I'm pretty sure the existing code is wrong.

	device_resume_noirq() checks
	dev_pm_smart_suspend_and_suspended() before setting the
	runtime PM status to "active", contrary to the text above.
	The difference shows up in the case where SMART_SUSPEND is
	clear but the runtime PM status is "suspended".  Don't we want
	to set the status to "active" in this case?  Or is there some 
	need to accomodate legacy drivers here?  In any case, wouldn't
	it be good enough to check just the SMART_SUSPEND flag?

	__device_suspend_late() sets power.may_skip_resume, contrary
	to the comment in include/linux/pm.h: That flag is supposed to
	be set by subsystems, not the core.

	I'm not at all sure that this algorithm won't run into trouble
	at some point when it tries to set a device's runtime status
	to "active" but the parent's status is set to "suspended".
	And I'm not sure this problem can be fixed by adjusting
	power.must_resume.

Alan Stern

