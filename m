Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75227454DD3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 20:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKQT2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 14:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKQT2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 14:28:30 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392FC061570;
        Wed, 17 Nov 2021 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=YkneOjORI6FrURlrv+SQ8OZvWiyxno4QJH7uReiSLO0=; b=HRPU
        UV3UU6dZ5n+4q/WD/aPWIiGQmVE4t6PMHzULIJ79eVqN9ZMaVVErqIyFvpOzm43wRPyCoamzndAEE
        /mmFWCiwiWSpJPQMzdren2qSaeSLFUEXZAR+XxzU2i42a7q4sK/67/G8AyAqJgSTINiYXFRRUk/5y
        ROr2fC9HxHy+XAvp78j8PiqN9LCO2Djhqtee5u7bQWaqr8hAjCQYNXcaxs54ImhaN/KXXAt45J6bB
        AXie7FmEWXNSYeovhRXLm3M4qcgviDIRAy10AxAgSzLqDJnpmR8x1T0GLoaYviu7psFgfqH11UV3W
        lHnNfsgxwpZKxz6Ej9+avQSWie51xw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mnQYb-0004T4-FQ; Wed, 17 Nov 2021 19:25:21 +0000
Date:   Wed, 17 Nov 2021 19:25:20 +0000
From:   John Keeping <john@metanate.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PM: runtime: avoid priority inversion on PREEMPT_RT
Message-ID: <20211117192520.6b085a1e.john@metanate.com>
In-Reply-To: <CAJZ5v0hgL6O6mCA4wf5NtmWi7kzA0Lyop4wH0TGDLMricdpiqA@mail.gmail.com>
References: <20211117183709.1832925-1-john@metanate.com>
        <CAJZ5v0hgL6O6mCA4wf5NtmWi7kzA0Lyop4wH0TGDLMricdpiqA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 19:53:47 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Nov 17, 2021 at 7:37 PM John Keeping <john@metanate.com> wrote:
> >
> > With PREEMPT_RT the cpu_relax() loops in rpm_suspend and rpm_resume can
> > cause unbounded latency if they preempt an asynchronous suspend.  The
> > main scenario where this can happen is when a realtime thread resumes a
> > device while it is asynchronously suspending on a worker thread.
> >
> > I'm not convinced this can actually happen in the rpm_suspend case, or
> > at least it's a lot less likely for a synchronous suspend to run at the
> > same time as an asynchronous suspend, but both functions are updated
> > here for symmetry.
> >
> > For devices setting power.irq_safe, it is possible that RPM functions
> > will be called with a spinlock held (for example in
> > pl330_issue_pending()).  This means a normal call to schedule() can't be
> > used, but to avoid the priority inversion it is necessary to wait and
> > schedule.  schedule_rtlock() is only available when CONFIG_PREEMPT_RT is
> > defined, so even though the logic is correct without any preprocessor
> > guards around schedule_rtlock(), they are necessary for compilation.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> > Changes since v1:
> > - Use schedule_rtlock() instead of schedule() for PREEMPT_RT & irq_safe
> > - Rewritten commit description
> >
> >  drivers/base/power/runtime.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index f3de7bfc7f5b..fdf461bfae8c 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -596,7 +596,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >                         goto out;
> >                 }
> >
> > -               if (dev->power.irq_safe) {
> > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {  
> 
> Please add a helper to avoid code duplication related to this (even
> though there is a small amount of it).

Ack.  I'd like some feedback on the schedule_rtlock() approach from the
scheduler & RT people, so I'll wait a bit before sending a v3.
