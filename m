Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DBD293690
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgJTIPn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgJTIPk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 04:15:40 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5921C0613D1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 01:15:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e19so873595qtq.17
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=Tc7Bz9gy61qOrfg1fSZV7f1gZUivwPbNWorgjp0wz0E=;
        b=iRLHFNyNGpxy+Zr6d0oSqreOdjz9Vhf85U05YEjRE+UJaPbBKihYGDY8pwhkaebKI8
         yYxzBe/49PdJ3wLF7K34s4N4R4KgfyP/V0piYq0QJHduMwjZhZK0Blo7QA9hWYQ0jtuA
         lRQZRlUB/a3fEuZYFh2Zku8FD4TAZCg0czC9Z0I3opIqwUwquceC+8CyzM8LWeSWMJJs
         rKTOxpKr/mZ4aT6D4XTvX2ATCDUDYV52fbaKRDmHjrI8SmC/fG+vxRh8+9TpX396r76M
         5TNYTJQGDkDRpwmvVfTSQ/eAKcLa9enYiFp1Dwp3ty0PwJwP1QCuTg5P9xttSHVU3zZJ
         9Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=Tc7Bz9gy61qOrfg1fSZV7f1gZUivwPbNWorgjp0wz0E=;
        b=cw9OA9uKvVmkZsjEtK/PlCTcijlqTb4AbqWINx+tTrI70uFx4TBIE8UtrD4jy/OxCk
         zAzBarR3cpuNAPnyW6PNS8cFfZiNGvNhpUojfFXJ1lXNcCTf42nGahyllRTiv6wPc5YB
         GSDivb+K5XkI8meYeWP9IsVQYg/ZD7iEPRKahVN6vTgNFVFj1nVk2LMbqlM+Fz3ksyi+
         4zzFera6OSP8Pln6z/DEwgHWSEQP82ImvIR1axn7/Hahpgyw+ZbZubvF3z9eZGkQpvxD
         9unEA4kKdKtK6fHX6M3ri/z2Ay2eckrYsFTOXupP9tSLWYywvlzOhv5q6LNx4CN+2zNP
         7oEw==
X-Gm-Message-State: AOAM533tzfYdkl9kZ2MOUcN/EBR71jix1AjQ9qobnbN2eyBZE8vS7xp/
        P7FhPQONGezxHW940LyQECzMIIN+NtP9EtSn
X-Google-Smtp-Source: ABdhPJzEJgW5uEZOYEmXPnD9/vBOPhbDyExODRo14aZXYPsM3kKJ4njYM7nHILkgpuHSellbiV+DoofEtZhHfc8n
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:ad4:48c6:: with SMTP id
 v6mr2058351qvx.11.1603181737974; Tue, 20 Oct 2020 01:15:37 -0700 (PDT)
Message-ID: <000000000000011a8805b215d69a@google.com>
Date:   Tue, 20 Oct 2020 08:15:38 +0000
Subject: [PATCH] power: suspend: Add suspend timeout handler
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Tue, Oct 20, 2020 at 02:22:26PM +0800, Joseph Jang wrote:
> > Add sleep timer and timeout handler to prevent device stuck during  
> suspend/
> > resume process. The timeout handler will dump disk sleep task at first
> > round timeout and trigger kernel panic at second round timeout.
> > The default timer for each round is defined in
> > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> >
> > Signed-off-by: Joseph Jang <josephjang@google.com>
> > ---
> >  MAINTAINERS                   |  2 +
> >  include/linux/console.h       |  1 +
> >  include/linux/suspend_timer.h | 90 +++++++++++++++++++++++++++++++++++

> Why is this file in include/linux/ if you only ever call it from one .c
> file?

I just refer to include/linux/suspend.h and create a new header file in the  
same folder.
If you have a better location for the new header file, please feel free to  
let me know.

> > --- /dev/null
> > +++ b/include/linux/suspend_timer.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_SLEEP_TIMER_H
> > +#define _LINUX_SLEEP_TIMER_H
> > +
> > +#include <linux/sched/debug.h>
> > +
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +struct sleep_timer {
> > +     struct task_struct      *tsk;
> > +     struct timer_list       timer;
> > +};
> > +
> > +#define DECLARE_SLEEP_TIMER(st) > > +     struct sleep_timer st
> > +
> > +/**
> > + * init_sleep_timer - Initialize sleep timer.
> > + * @st: Sleep timer to initialize.
> > + * @func: Sleep timer timeout handler.
> > + */
> > +static void init_sleep_timer(struct sleep_timer *st, void (*func))
> > +{
> > +     struct timer_list *timer = &st->timer;
> > +
> > +     timer_setup(timer, func, 0);
> > +}
> > +
> > +/**
> > + * start_sleep_timer - Enable sleep timer to monitor suspend thread.
> > + * @st: Sleep timer to enable.
> > + */
> > +static void start_sleep_timer(struct sleep_timer *st)
> > +{
> > +     struct timer_list *timer = &st->timer;
> > +
> > +     st->tsk = current;
> > +
> > +     /* use same timeout value for both suspend and resume */
> > +     timer->expires = jiffies + HZ * CONFIG_PM_SLEEP_TIMER_TIMEOUT;
> > +     add_timer(timer);
> > +}
> > +
> > +/**
> > + * stop_sleep_timer - Disable sleep timer.
> > + * @st: sleep timer to disable.
> > + */
> > +static void stop_sleep_timer(struct sleep_timer *st)
> > +{
> > +     struct timer_list *timer = &st->timer;
> > +
> > +     del_timer_sync(timer);
> > +}
> > +
> > +/**
> > + * sleep_timeout_handler - sleep timer timeout handler.
> > + * @t: The timer list that sleep timer depends on.
> > + *
> > + * Called when suspend thread has timeout suspending or resuming.
> > + * Dump all uninterruptible tasks' call stack and call panic() to
> > + * reboot system in second round timeout.
> > + */
> > +static void sleep_timeout_handler(struct timer_list *t)
> > +{
> > +     struct sleep_timer *st = from_timer(st, t, timer);
> > +     static int timeout_count;
> > +
> > +     pr_info("Sleep timeout (timer is %d seconds)\n",
> > +             (CONFIG_PM_SLEEP_TIMER_TIMEOUT));
> > +     show_stack(st->tsk, NULL, KERN_EMERG);
> > +     show_state_filter(TASK_UNINTERRUPTIBLE);
> > +
> > +     if (timeout_count < 1) {
> > +             timeout_count++;
> > +             start_sleep_timer(st);
> > +             return;
> > +     }
> > +
> > +     if (console_is_suspended())
> > +             resume_console();
> > +
> > +     panic("Sleep timeout and panic\n");
> > +}
> > +#else
> > +#define DECLARE_SLEEP_TIMER(st)
> > +#define init_sleep_timer(x, y)
> > +#define start_sleep_timer(x)
> > +#define stop_sleep_timer(x)
> > +#endif
> > +
> > +#endif /* _LINUX_SLEEP_TIMER_H */
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index a7320f07689d..9e2b274db0c1 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -207,6 +207,21 @@ config PM_SLEEP_DEBUG
> >       def_bool y
> >       depends on PM_DEBUG && PM_SLEEP
> >
> > +config PM_SLEEP_MONITOR
> > +     bool "Linux kernel suspend/resume process monitor"
> > +     depends on PM_SLEEP
> > +     help
> > +     This option will enable sleep timer to prevent device stuck
> > +     during suspend/resume process. Sleep timeout handler will dump
> > +     disk sleep task at first round timeout and trigger kernel panic
> > +     at second round timeout. The timer for each round is defined in
> > +     CONFIG_PM_SLEEP_TIMER_TIMEOUT.

> I thought we already had a watchdog for all of this, why not just always
> add this to that code, for that config option?


Yes, we already have DPM_WATCHDOG to monitor device power management.
But we really hit the suspend hang issue that DPM_WATCHDOG cannot cover.
We propose a wide coverage debug feature like PM_SLEEP_MONITOR which
not only covers PM but also core PM hang issues.

And DPM_WATCHDOG is for device driver power management in  
drivers/base/power/main.c
and PM_SLEEP_MONITOR locate is for core power management in  
kernel/power/suspend.c.
I think it is fine for users to select whether they need device PM only or  
not.


> And why isn't the watchdog sufficient for you?  Why are you "open
> coding" a watchdog timer logic here at all???


Yes, we refer to DPM_WATCHDOG to extend the watchdog debugging for core PM.
Because we really hit a real case that was not covered by DPM_WATCHDOG.
I think PM_SLEEP_MONITOR is an extension debug feature from DPM_WATCHDOG.


> thanks,

> greg k-h


Thank you,
Joseph.
