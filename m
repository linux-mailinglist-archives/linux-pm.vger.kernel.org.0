Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54736196C04
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgC2JRB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 05:17:01 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39338 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgC2JRB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 05:17:01 -0400
Received: by mail-ot1-f42.google.com with SMTP id x11so14733722otp.6;
        Sun, 29 Mar 2020 02:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xykCpromuQR95NLU7MsG8/68KlGhBUSrihEYbjYys3U=;
        b=J7GlxKU8UHuhTHaNCk1VJETO0wKdIpx9hfg7TgLpZoPwcMOMBAySLf4C6c6JYQj24X
         kuRIIl245cC1d66zghPAJVndkHqJr6movngQga955kmA7JnmSYWqCBEP8qNkWWNfWAnw
         HuTgdK6UHhSOn4MW3BvGcFzV+mo/uKSxO2AuWlF2Ddb3Dvmk4zBpjT4Fih6DCj3tpq22
         RZgdy5zvIExViO9HrERTqdiWvNSRHc2P+7ZBBcOED+Q7d1B0CEQ7lLpI2MJBzzhlqwEX
         IQDNm8KmRaCLfZSztITb5+Mppw5jvU6zn2+9e+aq1/uwlHOB5UmkOc9caQXJOUDeAYEs
         f+tg==
X-Gm-Message-State: ANhLgQ3bzwkB/S7AmLjVHM4l3LZvlQwGU5c6n/6fGm7Xbk69ze/sOcr7
        tsjnrmZGDgAJGDIFPdUr5wry5zjTOAqHPO9dDudDjRlu
X-Google-Smtp-Source: ADFU+vt9jzZatB0LI4JqEaCdSDfChawOZgGlZabSZph+/MZPMSSZYFuXWoqFdD1isg3VrB0LcPl73LEIOY6QJO+7DlU=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr4955234otm.167.1585473419648;
 Sun, 29 Mar 2020 02:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <10243663.e30Z2V8kAt@kreacher> <Pine.LNX.4.44L0.2003281432130.9749-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2003281432130.9749-100000@netrider.rowland.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 29 Mar 2020 11:16:48 +0200
Message-ID: <CAJZ5v0igUZnqFLcOhruDSNjv0HqCsy64tmYWyTX98xEc9cH14g@mail.gmail.com>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 28, 2020 at 8:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, 28 Mar 2020, Rafael J. Wysocki wrote:
>
> > On Friday, March 27, 2020 9:45:09 PM CET Alan Stern wrote:
>
> > > Raphael, I've been going over the PM core code, trying to figure out
> > > what it's really doing.  It's kind of a mess.
> >
> > Well, sorry about that.
> >
> > > A large part of the problem is related to an inconsistency between the
> > > documentation and the code.  include/linux/pm.h says that
> > > DPM_FLAG_SMART_SUSPEND tells bus types and PM domains about what the
> > > driver wants.  This strongly implies that the PM core will ignore
> > > SMART_SUSPEND.  But in fact the core does check that flag and takes its
> > > own actions if the device has no subsystem-level callbacks!
> >
> > Right, which is because in those cases there is no "middle layer" between
> > the driver and the core and if you want the driver to work both with
> > something like genpd or the ACPI PM domain and without anything like that,
> > the core needs to take those actions for consistency.
>
> Sure, the core is acting as a proxy for the missing subsystem
> callbacks.  Still, it should be documented properly.
>
> Also, couldn't we simplify the behavior?  Right now the core checks
> that there are no subsystem-level callbacks for any of _early, _late,
> and _noirq variants before skipping a callback.  Couldn't we forget
> about all that checking and simply skip the device-level callbacks?
> (Yes, I realize this could lead to inconsistent behavior if the
> subsystem has some callbacks defined but not others -- but subsystems
> should never do that, at least, not if it would lead to trouble.)

In quite a few cases the middle layer has nothing specific to do in a
given phase of suspend/resume, but the driver may.

Subsystems haven't been required to provide callbacks for all phases
so far, so this change would require some modifications in there.

I actually prefer the core to do more, even if that means more
complexity in it, to avoid possible subtle differences in behavior
between subsystems.

> Another issue is that the documentation exists in two separate places:
> include/linux/pm.h and Documentation/driver-api/devices.rst (plus a
> brief mention in Documentation/power/runtime_pm.rst).  This leads to
> incompleteness and inconsistencies.  Ideally there would be a complete
> explanation in one place (probably the devices.rst file) and the others
> would refer to it.

OK

> > > Furthermore, the PM core's actions don't seem to make sense.  If the
> > > flag is set and the device is runtime-suspended when the system sleep
> > > begins, the core will skip issuing the suspend_late and suspend_noirq
> > > callbacks to the driver.  But it doesn't skip issuing the suspend
> > > callback!  I can't figure that out.
> >
> > That's because if the core gets to executing ->suspend_late, PM-runtime has
> > been disabled for the device and if the device is runtime-suspended at that
> > point, so (at least if SMART_SUSPEND is set for the device) there is no reason
> > to do anything more to it.
>
> But if SMART_SUSPEND is set and the device is runtime-suspended, why
> issue the ->suspend callback?

The driver itself or the middle-layer may want to resume the device.

Arguably, it may do that in ->prepare() too, but see below.

> Why not just do pm_runtime_disable()
> then (to prevent the device from resuming) and skip the callback?

Because another driver may want to runtime-resume that device in order
to use it for something before ->suspend_late().  Of course, you may
argue that this means a missing device link or similar, so it is not
clear-cut.

The general rule is that "synchronous" PM-runtime can be expected to
work before ->suspend_late(), so ->suspend() callbacks should be able
to use it safely in all cases in principle.

That expectation goes against direct_complete in some cases, so
drivers need to set NEVER_SKIP (or whatever it will be called in the
future) to avoid that problem.

> > > Furthermore, the decisions about
> > > whether to skip the resume_noirq, resume_early, and resume callbacks
> > > are based on different criteria from the decisions on the suspend side.
> >
> > Right, because there are drivers that don't want devices to stay in suspend
> > after system resume even though they have been left in suspend by it.
>
> This suggests that sometimes we may want to issue non-matching
> callbacks.  For example, ->resume_noirq, ->resume_early, and ->resume
> but not ->suspend, ->suspend_late, or ->suspend_noirq.  Is that what
> you are saying?

Yes.

As per devices.rst:

"the driver must be prepared to
cope with the invocation of its system-wide resume callbacks back-to-back with
its ``->runtime_suspend`` one (without the intervening ``->runtime_resume`` and
so on) and the final state of the device must reflect the "active" runtime PM
status in that case."

> > Arguably, they could be left in suspend and then resumed after the completion
> > of system suspend, but that would add quite a bit of latency if the device
> > needs to be accessed right after the system suspend is complete.
> >
> > > That's not all: The SMART_SUSPEND decisions completely ignore the value
> > > of DPM_FLAG_NEVER_SKIP!  NEVER_SKIP affects only the direct_completion
> > > pathway.
> >
> > As documented AFAICS.
>
> But highly confusing.  Maybe we can change the name to, say,
> DPM_FLAG_NO_DIRECT_COMPLETE.

Sure, if that helps. :-)

> > > SMART_SUSPEND seems to have two different meanings.  (1) If the device
> > > is already in runtime suspend when a system sleep starts, skip the
> > > suspend_late and suspend_noirq callbacks.  (2) Under certain (similar)
> > > circumstances, skip the resume callbacks.  The documentation only
> > > mentions (1) but the code also handles (2).
> >
> > That's because (2) is the THAW case and I was distracted before I got
> > to documenting it properly.  Sorry.
> >
> > The problem is that if you leave the device in runtime suspend, calling
> > ->freeze_late() or ->freeze_noirq() on it is not useful and if you have
> > skipped those, running the corresponding "thaw" callbacks is not useful
> > either (what would they do, specifically?).
> >
> > There is a whole problem of whether or not devices should be left in
> > runtime suspend during hibernation and I have not had a chance to get
> > to the bottom of that yet.
>
> Not only that.  The distinction between SMART_SUSPEND and
> direct_complete is rather subtle, and it doesn't seem to be carefully
> explained anywhere.  In fact, I'm not sure I understand it myself.  :-)
> For example, the direct_complete mechanism is very careful about not
> leaving a device in runtime suspend if a descendant (or other dependent
> device) will remain active.  Does SMART_SUSPEND behave similarly?  If
> so, it isn't documented.

The difference is that SMART_SUSPEND allows the ->suspend callback to
be invoked which may decide to resume the device (or reconfigure it
for system wakeup if that doesn't require resuming it).  IOW, this
means "I can cope with a runtime-suspended device going forward".
[But if the device is still runtime-suspended during ->suspend_late(),
its configuration is regarded as "final".]

In turn, direct_complete means something like "if this device is
runtime-suspended, leave it as is and don't touch it during the whole
suspend-resume cycle".

> Besides, it seems like a mistake to try controlling (1) and (2)
> together (i.e., with one flag).  Can we do a better job of
> separating the functions of SMART_SUSPEND and LEAVE_SUSPENDED?
>
> > > Other things in there also seem strange.  device_prepare() does a
> > > WARN_ON if either SMART_SUSPEND or LEAVE_SUSPENDED is set and the
> > > device is not runtime-PM-enabled.  That's understandable, but it's also
> > > racy.
> >
> > I guess you mean the check in device_prepare().
> >
> > > A system sleep can begin at any time; how can a driver know when
> > > it is safe to disable a device's runtime PM briefly?
> >
> > Well, fair enough, but then I'm not sure if there is a good place for this
> > check at all, because drivers can briefly disable PM-runtime at any time in
> > theory.
>
> There probably isn't a good place for it.  We could just get rid of the
> WARN.  I've never heard of it triggering.

OK

> > > When device_prepare() calculates the power.direct_complete flag, it
> > > checks to see whether the device is currently in runtime suspend in
> > > some cases but not in others, as in the code added by your commit
> > > c62ec4610c40 ("PM / core:  Fix direct_complete handling for devices
> > > with no callbacks").  Since the runtime-PM state is going to checked in
> > > __device_suspend() anyway, we shouldn't need to check it here at all.
> >
> > I guess the point is that in theory the device can be runtime-suspended
> > between device_prepare() and _device_suspend(), is by checking the status
> > in the former, we lose the opportunity to leave it in suspend if that
> > happens.
> >
> > OK, fair enough.
> >
> > > At a couple of points in the code, THAW and RESTORE events are each
> > > treatedly specially, with no explanation.
> >
> > Right, which is related to the kind of work in progress situation regarding
> > the flags and hibernation mentioned above.  Again, sorry about that.
>
> I haven't thought about those issues as much as you have.  Still, it
> seems obvious that the FREEZE/THAW phases should be very happy to leave
> devices in runtime suspend throughout (without even worrying about
> wakeup settings), and the RESTORE phase should always bring everything
> back out of runtime suspend.

These were exactly my original thoughts, but then when I started to
consider possible interactions the restore kernel (which also carries
out the "freeze" transition before jumping into the image kernel), it
became less clear.

The concerns is basically whether or not attempting to power on
devices that are already powered on can always be guaranteed to work.

> What to do during the POWEROFF phase isn't so clear, because it depends
> on how the platform handles the poweroff transition.

POWEROFF is exactly analogous to SUSPEND AFAICS.

> > > The power.may_skip_resume flag is used in only one place, when
> > > LEAVE_SUSPENDED is set and there are subsystem-level callbacks.  In
> > > particular, it is _not_ used by dev_pm_may_skip_resume().  That seems
> > > highly suspicious at best.
> >
> > That's because it's for the middle-layer (subsystem-level) code to let the
> > core know that skipping the resume would be OK.
> >
> > The core doesn't need that flag when it decides by itself.
>
> This may be another situation where changing a name would make things
> clearer.  One doesn't immediately recognize that
> dev_pm_may_skip_resume() applies only in cases where there is no
> subsystem-level callback.

Fair enough.

> > > I think it would be worthwhile to expend some serious effort
> > > straightening all this stuff out.  Perhaps we could start with a more
> > > explicit description of what is supposed to happen at each step.
> > > (Things to be careful about include phrases like "leave suspended",
> > > which is not the same as "don't call the resume callbacks", even though
> > > the two are easily conflated.)
> > >
> > > What do you think?
> >
> > I am certainly not going to reject any help. :-)
> >
> > Also, I'm not against clarifying anything that is not clear enough.
>
> Okay, let's start with direct_complete.  The direct_complete mechanism
> is applied to the SUSPEND and RESUME phases under the following
> conditions:
>
>         DPM_FLAG_NEVER_SKIP (or better, DPM_FLAG_NO_DIRECT_COMPLETE)
>         is clear;  [Incidentally, since a driver can set this flag
>         whenever its ->prepare routine returns 0, why do we need
>         DPM_FLAG_SMART_PREPARE?]

Because the former allows the driver to avoid providing a ->prepare
callback always returning 1.

>         Either the device has no system-PM callbacks at all or else the
>         ->prepare callback returns a positive value;

Why so?

>         All of the device's descendants and dependents also want to use
>         direct_complete;

Yes.

>         Neither the device nor any of its descendants/dependents is
>         enabled for wakeup;

Yes.

>         The device is runtime suspended just before the ->suspend
>         callback would normally be issued.

Yes.

> When the mechanism applies, none of the suspend or resume callbacks (in
> any of their normal, _early, _late, or _noirq variants) are issued,
> only ->complete.  Consequently the device remains in runtime suspend
> throughout the system sleep.
>
> Currently, direct_complete is never applied during any of the system
> hibernation phases (FREEZE, THAW, POWEROFF, RESTORE).  This may change
> in the future.
>
> Is this description correct and complete?

It is mostly. :-)

> Can you give a similarly
> succinct outline for how SMART_SUSPEND and LEAVE_SUSPENDED should work?
> And also describe how they differ from direct_complete and how they
> interact with it?  (For example, how does setting both flags differ
> from returning a positive value from ->prepare?)

I will, but I need some time to do that.  Stay tuned.

Cheers!
