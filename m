Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA119D9B6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404048AbgDCPES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 11:04:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50666 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404025AbgDCPES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 11:04:18 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id b2011cf8bea289e1; Fri, 3 Apr 2020 17:04:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Date:   Fri, 03 Apr 2020 17:04:16 +0200
Message-ID: <2274735.ifPVKiii8o@kreacher>
In-Reply-To: <Pine.LNX.4.44L0.2003291129360.3311-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2003291129360.3311-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, March 29, 2020 6:27:38 PM CEST Alan Stern wrote:
> On Sun, 29 Mar 2020, Rafael J. Wysocki wrote:
> 
> > On Sat, Mar 28, 2020 at 8:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:

[cut]

> > > Can you give a similarly
> > > succinct outline for how SMART_SUSPEND and LEAVE_SUSPENDED should work?
> > > And also describe how they differ from direct_complete and how they
> > > interact with it?  (For example, how does setting both flags differ
> > > from returning a positive value from ->prepare?)
> > 
> > I will, but I need some time to do that.  Stay tuned.
> 
> You bet!

Sorry for the delay, too much distraction nowadays.

I'll address the other points in your message separately.

The rules for SMART_SUSPEND are as follows:

(a) If SMART_SUSPEND is set and the device is runtime-suspended during system
    suspend, it is not expected to be resumed by the core or the middle layer
    (subsystem) code unless the latter has a specific reason to do that (e.g.
    it knows that the device needs to be reconfigured which cannot be done
    without resuming it).

    The device can still be resumed when it is needed to suspend a dependent
    device, but that cannot happen before the "late suspend" phase.

(b) Drivers that set SMART_SUSPEND are allowed to reuse their PM-runtime
    callbacks for system-wide suspend and resume.

    That is, they can point either the ->suspend_late or the ->suspend_noirq
    callback pointer to the same function as ->runtime_suspend and they can
    point either the ->resume_noirq or ->the resume_early callback to the'
    same function as ->runtime_resume.

(c) Drivers that set SMART_SUSPEND are alwo allowed to provide special
    simplified callbacks for the "freeze" and "thaw" transitions during
    hibernation (and restore) and (if they do so) special callbacks for the
    "restore" phase.

[OK, I realize that (b) and (c) are not documented, see the notes below.]

Because of (a), if the device with SMART_SUSPEND set is still runtime-suspended
during the "late" phase of suspend, the core will not invoke the driver's
"late" and "noirq" suspend callbacks directly (*).  Middle layer (subsystem)
code is expected to behave accordingly.

Because of (b), if the "late" and "noirq" driver callbacks were skipped during
the "freeze" transition, the core will also avoid invoking the "noirq" and
"early" callbacks provided by the driver during the "thaw" transition and
the callbacks during the "restore" transition will be executed unconditionally
(**).  Middle layer code is expected to behave accordingly.

Notes:

1. I have considered splitting SMART_SUSPEND into two or even three flags
   so that (a), (b) and (c) are each associated with a separate flag, but
   then I would expect the majority of users to use all of them anyway.

2. LEAVE_SUSPENDED (which may be better renamed to SKIP_RESUME) is kind of
   expected to be used along with SMART_SUSPEND unless there is a good enough
   reason to avoid using it.  I admit that this isn't really straightforward,
   maybe the default behavior should be to skip the resume and there should be
   FORCE_RESUME instead of LEAVE_SUSPENDED.

3. (*) Under the assumption that either ->suspend_late or ->suspend_noirq
   points to the same routine as ->runtime_suspend (and the other is NULL),
   invokig that callback for a runtime-suspended device is technically invalid.
   In turn, under the assumption that either ->resume_early or ->resume_noirq
   points to the same routine as ->runtime_resume (and the other is NULL), it is
   valid to invoke that callback if the late/noirq suspend was skipped.

4. (**) If the "freeze" and "thaw" callbacks are simplified, they cannot be
   run back-to-back with ->runtime_resume and ->runtime_suspend, respectively.
   Thus if "freeze" is skippend, "thaw" must be skipped too.  However,
   "restore" needs to be prepared to be invoked after "freeze" or
   ->runtime_suspend (and the state of the device may not match the
   callback that ran previously), so it must be special.

5. I agree that skipping the driver level of callbacks depending on what is
   provided by the middle layer is inconsistent, but I wanted to take the
   users of pm_runtime_force_suspend/resume() into account by letting those
   things run.

   It would be more consistent to expect middle layer code (bus types, PM
   domains) to provide either all of the noirq/early/late callbacks, or none
   of them and make SMART_SUSPEND and pm_runtime_force_suspend/resume()
   mutually exclusive.

Cheers!



