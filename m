Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2930D1A7EA5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbgDNNnR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 09:43:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38104 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgDNNnO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 09:43:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id x21so4199764oic.5;
        Tue, 14 Apr 2020 06:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8OJr7MdmFUiaJqkSUSMNUd1rbCvGu/Jw8zTWMZO2co=;
        b=f9cvEB7q5OX0kjTwNhvMRT8hk6AK6v/Qak4TP4v4iTAkoKPEeu6ULWuwd+lqZLk2xx
         LxhxBA2Iy3L+CgNC3FU03Nw0cqeKhImDkVeK8RBp8ApIL+ASw30AYOZuyNym+BA2G0DD
         KYCqUD4+7HmsUE2Du6zKDlkvP85tFmsMXAri5ZTBrnq8oV3A5+kemmDS56dqINs8iAnz
         HE64FgOtYAahLZx/XW/SzQkPcMRyEWjW+M4wgcrGoKzeDmi0segBj2hZPhS80Bp5s9xs
         QgQxFC4RTEa26whHcD2nHUpbW8XWowybfB1tZum9brcyJljC4wJMZaZD4USgVob0M/XV
         3eMw==
X-Gm-Message-State: AGi0PuZipJHaUSzSJxrrfvj8OC7s/57h3ZV7/kKtQCLI9Wxr7WjS/zaI
        PKmjnt8CZ+7ih7skDCTBV3eWaiqOsBZrbgD1fiE=
X-Google-Smtp-Source: APiQypJt/47quOZ6p2heqG3XjpDgc/jI3rGel706Hqe2lcfGhDVJx//FIXc88SmEIJ2HOzueXC/KMVkE23w7KDup9ls=
X-Received: by 2002:aca:2209:: with SMTP id b9mr15986264oic.103.1586871792611;
 Tue, 14 Apr 2020 06:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.2004102231270.30859-100000@netrider.rowland.org> <6362254.rXp5uA8eak@kreacher>
In-Reply-To: <6362254.rXp5uA8eak@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Apr 2020 15:43:01 +0200
Message-ID: <CAJZ5v0jSMC1FGc2N06B=2VmXRF1XJi4gNyKPkjfBPCEtjm50Yw@mail.gmail.com>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Note to self: avoid replying to technical messages late in the night ...

On Mon, Apr 13, 2020 at 11:32 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Saturday, April 11, 2020 4:41:14 AM CEST Alan Stern wrote:
> > Okay, this is my attempt to summarize what we have been discussing.
> > But first: There is a dev_pm_skip_resume() helper routine which
> > subsystems can call to see whether resume-side _early and _noirq driver
> > callbacks should be skipped.  But there is no corresponding
> > dev_pm_skip_suspend() helper routine.  Let's add one, or rename
> > dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().
>
> OK
>
> > Given that, here's my understanding of what should happen.  (I'm
> > assuming the direct_complete mechanism is not being used.)  This tries
> > to describe what we _want_ to happen, which is not always the same as
> > what the current code actually _does_.
>
> OK
>
> >       During the suspend side, for each of the
> >       {suspend,freeze,poweroff}_{late,noirq} phases: If
> >       dev_pm_skip_suspend() returns true then the subsystem should
> >       not invoke the driver's callback, and if there is no subsystem
> >       callback then the core will not invoke the driver's callback.
> >
> >       During the resume side, for each of the
> >       {resume,thaw,restore}_{early,noirq} phases: If
> >       dev_pm_skip_resume() returns true then the subsystem should
> >       not invoke the driver's callback, and if there is no subsystem
> >       callback then the core will not invoke the driver's callback.
> >
> >       dev_pm_skip_suspend() will return "true" if SMART_SUSPEND is
> >       set and the device's runtime status is "suspended".
>
> Agreed with the above.
>
> >       power.must_resume gets set following the suspend-side _noirq
> >       phase if power.usage_count > 1 (indicating the device was
> >       in active use before the start of the sleep transition) or
> >       power.must_resume is set for any of the device's dependents.
>
> Or MAY_SKIP_RESUME is unset (which means that the driver does not
> allow its resume callbacks to be skipped), or power.may_skip_resume
> is unset (which means that the subsystem does not allow the
> driver callbacks to be skipped).
>
> >       dev_pm_skip_resume() will return "false" if the current
> >       transition is RESTORE or power.must_resume is set.  Otherwise:
> >       It will return true if the current transition is THAW,
> >       SMART_SUSPEND is set, and the device's runtime status is
> >       "suspended".
>
> The other way around.  That is:
>
> dev_pm_skip_resume() will return "true" if the current transition is
> THAW and dev_pm_skip_suspend() returns "true" for that device (so
> SMART_SUSPEND is set, and the device's runtime status is "suspended",
> as per the definition of that function above).

The above is what I wanted to say ->

> Otherwise, it will return "true" if the current transition is RESTORE
> (which means that all devices are resumed) or power.must_resume is not
> set (so this particular device need not be resumed).

-> but this isn't.  In particular, I messed up the RESTORE part, so it
should read:

Otherwise, it will return "true" if the current transition is *not*
RESTORE (in which case all devices would be resumed) *and*
power.must_resume is not set (so this particular device need not be
resumed).

Sorry about that.

> >  It will return "true" if the current transition is
> >       RESUME, SMART_SUSPEND and MAY_SKIP_RESUME are both set, and
> >       the device's runtime status is "suspended".
>
> Unless MAY_SKIP_RESUME is unset for at least one of its descendants (or
> dependent devices).

That should include the power.may_skip_resume flag, so as to read as follows:

Unless MAY_SKIP_RESUME is unset or power.may_skip_resume is unset for
at least one of its descendants (or dependent devices).

> >       For a RESUME
> >       transition, it will also return "true" if MAY_SKIP_RESUME and
> >       power.may_skip_resume are both set, regardless of
> >       SMART_SUSPEND or the current runtime status.
>
> And if the device was not in active use before suspend (as per its usage
> counter) or MAY_SKIP_RESUME is unset for at least one of its descendants (or
> dependent devices in general).

And analogously here, so what I really should have written is:

And if the device was not in active use before suspend (as per its
usage counter) or MAY_SKIP_RESUME or power.may_skip_resume is unset
for at least one of its descendants (or dependent devices in general).

> >       At the start of the {resume,thaw,restore}_noirq phase, if
> >       dev_pm_skip_resume() returns true then the core will set the
> >       runtime status to "suspended".  Otherwise it will set the
> >       runtime status to "active".  If this is not what the subsystem
> >       or driver wants, it must update the runtime status itself.
>
> Right.
>
> > Comments and differences with respect to the code in your pm-sleep-core
> > branch:
> >
> >       I'm not sure whether we should specify other conditions for
> >       setting power.must_resume.
>
> IMO we should.

In fact, this is part of the implementation and it helps to
"propagate" the "must resume" condition to the parent and the
first-order suppliers of the device (which is sufficient, because
their power.must_resume "propagates" in the same way and so on).

IOW, the important piece is what the return value of
dev_pm_skip_resume() should be in particular conditions and that
return value is computed with the help of power.must_resume (and it
might have been computed in a different, possibly less efficient,
way).

> Otherwise it is rather hard to catch the case in which one of the
> device's descendants has MAY_SKIP_RESUME unset (and so the device
> needs to be resumed).
>
> >       dev_pm_skip_resume() doesn't compute the value described
> >       above.  I'm pretty sure the existing code is wrong.
>
> Well, we don't seem to have reached an agreement on some details
> above ...

Sorry for failing to be careful enough ...
