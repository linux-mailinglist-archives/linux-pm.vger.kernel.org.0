Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49E2936F4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392107AbgJTIpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 04:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389334AbgJTIpS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 04:45:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BFF22282;
        Tue, 20 Oct 2020 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603183517;
        bh=nZPBSqGFITHDBHC7PkHXCt0i4AkPkbIfzCM2ZB+bAiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7WYJbKlKFN1JmKHR1df7R/iHVwzg833RzmoBWT2dnxonCd5WOBWMCdswwIYupNjk
         PVJjUlWfLBoRVgcnU2U8pLXreARQO8rxvW75I9yNLpbjAtbLrra13fPgRnSiESBWAM
         +W9pXSgzwBBmzoc90y2rAizDDR09nyYw7JZBLin4=
Date:   Tue, 20 Oct 2020 10:46:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     josephjang@google.com
Cc:     rafael@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
Message-ID: <20201020084600.GA3838202@kroah.com>
References: <000000000000011a8805b215d69a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000011a8805b215d69a@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 08:15:38AM +0000, josephjang@google.com wrote:
> > On Tue, Oct 20, 2020 at 02:22:26PM +0800, Joseph Jang wrote:
> > > Add sleep timer and timeout handler to prevent device stuck during
> > suspend/
> > > resume process. The timeout handler will dump disk sleep task at first
> > > round timeout and trigger kernel panic at second round timeout.
> > > The default timer for each round is defined in
> > > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> > >
> > > Signed-off-by: Joseph Jang <josephjang@google.com>
> > > ---
> > >  MAINTAINERS                   |  2 +
> > >  include/linux/console.h       |  1 +
> > >  include/linux/suspend_timer.h | 90 +++++++++++++++++++++++++++++++++++
> 
> > Why is this file in include/linux/ if you only ever call it from one .c
> > file?
> 
> I just refer to include/linux/suspend.h and create a new header file in the
> same folder.
> If you have a better location for the new header file, please feel free to
> let me know.

Only put .h files that are needed by different .c files in the
include/linux/ directory.  Otherwise it should be local to where the .c
file is.

> > > --- /dev/null
> > > +++ b/include/linux/suspend_timer.h
> > > @@ -0,0 +1,90 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_SLEEP_TIMER_H
> > > +#define _LINUX_SLEEP_TIMER_H
> > > +
> > > +#include <linux/sched/debug.h>
> > > +
> > > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > > +struct sleep_timer {
> > > +     struct task_struct      *tsk;
> > > +     struct timer_list       timer;
> > > +};
> > > +
> > > +#define DECLARE_SLEEP_TIMER(st) > > +     struct sleep_timer st
> > > +
> > > +/**
> > > + * init_sleep_timer - Initialize sleep timer.
> > > + * @st: Sleep timer to initialize.
> > > + * @func: Sleep timer timeout handler.
> > > + */
> > > +static void init_sleep_timer(struct sleep_timer *st, void (*func))
> > > +{
> > > +     struct timer_list *timer = &st->timer;
> > > +
> > > +     timer_setup(timer, func, 0);
> > > +}
> > > +
> > > +/**
> > > + * start_sleep_timer - Enable sleep timer to monitor suspend thread.
> > > + * @st: Sleep timer to enable.
> > > + */
> > > +static void start_sleep_timer(struct sleep_timer *st)
> > > +{
> > > +     struct timer_list *timer = &st->timer;
> > > +
> > > +     st->tsk = current;
> > > +
> > > +     /* use same timeout value for both suspend and resume */
> > > +     timer->expires = jiffies + HZ * CONFIG_PM_SLEEP_TIMER_TIMEOUT;
> > > +     add_timer(timer);
> > > +}
> > > +
> > > +/**
> > > + * stop_sleep_timer - Disable sleep timer.
> > > + * @st: sleep timer to disable.
> > > + */
> > > +static void stop_sleep_timer(struct sleep_timer *st)
> > > +{
> > > +     struct timer_list *timer = &st->timer;
> > > +
> > > +     del_timer_sync(timer);
> > > +}
> > > +
> > > +/**
> > > + * sleep_timeout_handler - sleep timer timeout handler.
> > > + * @t: The timer list that sleep timer depends on.
> > > + *
> > > + * Called when suspend thread has timeout suspending or resuming.
> > > + * Dump all uninterruptible tasks' call stack and call panic() to
> > > + * reboot system in second round timeout.
> > > + */
> > > +static void sleep_timeout_handler(struct timer_list *t)
> > > +{
> > > +     struct sleep_timer *st = from_timer(st, t, timer);
> > > +     static int timeout_count;
> > > +
> > > +     pr_info("Sleep timeout (timer is %d seconds)\n",
> > > +             (CONFIG_PM_SLEEP_TIMER_TIMEOUT));
> > > +     show_stack(st->tsk, NULL, KERN_EMERG);
> > > +     show_state_filter(TASK_UNINTERRUPTIBLE);
> > > +
> > > +     if (timeout_count < 1) {
> > > +             timeout_count++;
> > > +             start_sleep_timer(st);
> > > +             return;
> > > +     }
> > > +
> > > +     if (console_is_suspended())
> > > +             resume_console();
> > > +
> > > +     panic("Sleep timeout and panic\n");
> > > +}
> > > +#else
> > > +#define DECLARE_SLEEP_TIMER(st)
> > > +#define init_sleep_timer(x, y)
> > > +#define start_sleep_timer(x)
> > > +#define stop_sleep_timer(x)
> > > +#endif
> > > +
> > > +#endif /* _LINUX_SLEEP_TIMER_H */
> > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > index a7320f07689d..9e2b274db0c1 100644
> > > --- a/kernel/power/Kconfig
> > > +++ b/kernel/power/Kconfig
> > > @@ -207,6 +207,21 @@ config PM_SLEEP_DEBUG
> > >       def_bool y
> > >       depends on PM_DEBUG && PM_SLEEP
> > >
> > > +config PM_SLEEP_MONITOR
> > > +     bool "Linux kernel suspend/resume process monitor"
> > > +     depends on PM_SLEEP
> > > +     help
> > > +     This option will enable sleep timer to prevent device stuck
> > > +     during suspend/resume process. Sleep timeout handler will dump
> > > +     disk sleep task at first round timeout and trigger kernel panic
> > > +     at second round timeout. The timer for each round is defined in
> > > +     CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> 
> > I thought we already had a watchdog for all of this, why not just always
> > add this to that code, for that config option?
> 
> 
> Yes, we already have DPM_WATCHDOG to monitor device power management.

Great, use that!

> But we really hit the suspend hang issue that DPM_WATCHDOG cannot cover.

What issue is that?

> We propose a wide coverage debug feature like PM_SLEEP_MONITOR which
> not only covers PM but also core PM hang issues.
> 
> And DPM_WATCHDOG is for device driver power management in
> drivers/base/power/main.c
> and PM_SLEEP_MONITOR locate is for core power management in
> kernel/power/suspend.c.
> I think it is fine for users to select whether they need device PM only or
> not.

How will a user know which they should use?

Why not just fix whatever is wrong with the watchdog code instead of
creating a new one?

> > And why isn't the watchdog sufficient for you?  Why are you "open
> > coding" a watchdog timer logic here at all???
> 
> Yes, we refer to DPM_WATCHDOG to extend the watchdog debugging for core PM.
> Because we really hit a real case that was not covered by DPM_WATCHDOG.

Then fix that!

> I think PM_SLEEP_MONITOR is an extension debug feature from DPM_WATCHDOG.

Please just fix the watchdog, as obviously it is not working properly.
Don't create something new because of that.

thanks,

greg k-h
