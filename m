Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3452901E2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394894AbgJPJbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395000AbgJPJbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 05:31:07 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E442C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 02:31:07 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a12so1377550ybg.9
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NylHuy2E9sMbdJrVABlQaT4XeLNozdHw6RfbvRR5x24=;
        b=pSeuX7n+ql5pmA2CqwoEws6FiilusK46SL66ehTK12MaFiYhJ7ZDMTkEsFL9qIUwNV
         iiyus8EGXdE5Ambpz1dRlwGiOjA4gW5t9FV0MnBNJ2xshfPdA741ua288CSFG7I5DBeV
         07KKhmwVrfgj32WVzg3WHo5mpdLXYLQ/HVYuyQz8I6cNVpxMsVekCYaNpHogBDgM5u2J
         0rWIQvrG1Pv/bQy1MR70rDis38vsOWD/zEw5KQ1JE0w4gVc/e/8kF5KeBPFx8yYHIYCl
         Cq2Y/Br2LT+Yd5Mvu2w1gv1bTCL9w9DQw8LTTDV6oUtNNE/ZfplnZB3pzHjYxQKv6fJt
         dcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NylHuy2E9sMbdJrVABlQaT4XeLNozdHw6RfbvRR5x24=;
        b=tSeN9OStR0jBbGLaUOFj7a96A160yqs86MutQJrIz/TR4uycjMhmgf7AsCrj8OVfWc
         DkTGjFfGahsC7qvO4nNSjW8BoUzHPltanMIIogqo5Vi3FIsf2ALmuz/CKmEMD/q8t4qG
         VA41FHpULq8lMNOwaHGe/fJMnS/K0JxW68Iiet2FGeYrpYzi0SXfoeG/ICXsCPMU/Hxf
         +f6c62PwbKIFCmUcEz0BURDbBTr8/FyQK1vUSZz9y+yY6B7pRYhcbdYtn/xXv5POg+Z9
         eRwS2U4p/KgezSzi6KeYXYYXuuEI61TfxdWotW5w1fShZ93/3AwV46AR4cbSt8P+Dwcf
         b93Q==
X-Gm-Message-State: AOAM532pdbJdbp5uA7cHTi2zCGI7SNL78zZnQi/shaf1s4DDdX3GfcL/
        g3X/nWZ8IrwVPbfTpSb/vCgpuFRQvcqGuWOygfAT/g==
X-Google-Smtp-Source: ABdhPJxB2pEHqrtTuWbvpHNLtGKE7lTZOuuB2h0H5EnRb+ST/yI1M/SvNr5TVR/sCRV6KCpjyDGQqf9IlIT78ZU9cNA=
X-Received: by 2002:a25:2155:: with SMTP id h82mr3759273ybh.321.1602840666169;
 Fri, 16 Oct 2020 02:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201016035109.3952356-1-josephjang@google.com>
 <20201016054412.GB155953@kroah.com> <CAPaOXERGzo8uF9gh4aAoicEAi_TtHn1M2Yno5LAWQPcWmq_evQ@mail.gmail.com>
In-Reply-To: <CAPaOXERGzo8uF9gh4aAoicEAi_TtHn1M2Yno5LAWQPcWmq_evQ@mail.gmail.com>
From:   Joseph Jang <josephjang@google.com>
Date:   Fri, 16 Oct 2020 17:30:54 +0800
Message-ID: <CAPaOXETzVfh-HPDMdUMQBvTh6ob8gGZ79huaqDYFzKsFq3GFGw@mail.gmail.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jonglin Lee <jonglin@google.com>,
        Woody Lin <woodylin@google.com>,
        Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you Greg's promptly reply.

let me try to explain detail in following. Sorry I forgot to switch to
plain text mode in gmail.

On Fri, Oct 16, 2020 at 11:51:09AM +0800, Joseph Jang wrote:
> From: josephjang <josephjang@google.com>

Please use your name as spelled out like you did above in the email
header.

Sure, I will update the patch again like following.

From b3afca8f3ee1d587c188b830d94c683fe66cbfb3 Mon Sep 17 00:00:00 2001
From: Joseph Jang <josephjang@google.com>
Date: Fri, 16 Oct 2020 16:31:38 +0800
Subject: [PATCH] power: suspend: Add suspend timeout handler

Add suspend timeout handler to prevent device stuck during suspend/
resume process. Suspend timeout handler will dump disk sleep task
at first round timeout and trigger kernel panic at second round timeout.
The default timer for each round is 30 seconds.


>
> Add suspend timeout handler to prevent device stuck during suspend/
> resume process. Suspend timeout handler will dump disk sleep task
> at first round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is 30 seconds.
>
> Note: Can use following command to simulate suspend hang for testing.
>     adb shell echo 1 > /sys/power/pm_hang
>     adb shell echo mem > /sys/power/state
> Signed-off-by: josephjang <josephjang@google.com>

Need a blank line before the signed-off-by: and again, spell your name
the same way.

Sure, I will update the patch again like following.

Note: Can use following command to simulate suspend hang for testing.
    adb shell echo 1 > /sys/power/pm_hang
    adb shell echo mem > /sys/power/state

Signed-off-by: Joseph Jang <josephjang@google.com>
---


> ---
>  include/linux/console.h |   1 +
>  kernel/power/Kconfig    |   9 +++
>  kernel/power/main.c     |  66 ++++++++++++++++
>  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c  |   5 ++
>  5 files changed, 243 insertions(+)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 0670d3491e0e..ac468c602c0b 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
>  { }
>  #endif
>  extern bool console_suspend_enabled;
> +extern int is_console_suspended(void);

For global functions, how about:
        bool console_is_suspended(void);
?

Agree, I will update like following.
 extern bool console_suspend_enabled;
+extern int console_is_suspended(void);



>
>  /* Suspend and resume console messages over PM events */
>  extern void suspend_console(void);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..52b7a181b6d8 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
>       def_bool y
>       depends on PM_DEBUG && PM_SLEEP
>
> +config PM_SLEEP_MONITOR
> +     bool "Linux kernel suspend/resume process monitor"
> +     depends on PM_SLEEP
> +     help
> +     This option will enable suspend/resume monitor to prevent device
> +     stuck during suspend/resume process. Suspend timeout handler will
> +     dump disk sleep task at first round timeout and trigger kernel pani=
c
> +     at second round timeout. The default timer for each round is 30 sec=
onds.

Ouch, are you sure you want to panic?

Yes, we would like to trigger kernel panic to reboot system and
prevent system hang there.


> +
>  config DPM_WATCHDOG
>       bool "Device suspend/resume watchdog"
>       depends on PM_DEBUG && PSTORE && EXPERT
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 40f86ec4ab30..f25b8a47583e 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -575,6 +575,69 @@ void __pm_pr_dbg(bool defer, const char *fmt, ...)
>  static inline void pm_print_times_init(void) {}
>  #endif /* CONFIG_PM_SLEEP_DEBUG */
>
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +/* If set, devices will stuck at suspend for verification */
> +static bool pm_hang_enabled;
> +
> +static int pm_notify_test(struct notifier_block *nb,
> +                          unsigned long mode, void *_unused)
> +{
> +     pr_info("Jump into infinite loop now\n");

Why do you have debugging code still enabled?

Because we want to make sure system hang was cause by our test code here.


> +
> +     /* Suspend thread stuck at a loop forever */
> +     for (;;)
> +             ;
> +

Don't busy spin, that will burn power.

Okay, I will add msleep() to prevent system burn power during testing.

+static int pm_notify_test(struct notifier_block *nb,
+     unsigned long mode, void *_unused)
+{
+ pr_info("Jump into infinite loop now\n");
+
+ /* Suspend thread stuck at a loop forever */
+ for (;;)
+ msleep(100);
+
+ pr_info("Fail to stuck at loop\n");
+
+ return 0;
+}


> +     pr_info("Fail to stuck at loop\n");

And how can this happen?

I think we should not see this log unless the for loop has problem.


Sure, I add some description in the document like following.
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -420,3 +420,18 @@ Description:
  disables it.  Reads from the file return the current value.
  The default is "1" if the build-time "SUSPEND_SKIP_SYNC" config
  flag is unset, or "0" otherwise.
+
+What: /sys/power/pm_hang
+Date: Oct 2020
+Contact: Joseph Jang <josephjang@google.com>
+Description:
+ The /sys/power/pm_hang file controls the variable pm_hang_enabled
+ which controls whether you need to simulate system hang during
+ suspend.
+
+ Writing a "1" to this file will set the pm_hang_enabled to "1" and
+ register a pm_notify function pm_notify_test() to simulate system
+ hang during suspend.
+ Writing a "0" to this file will set the pm_hang_enabled to "0" and
+ unregister a pm_notify function pm_notify_test().
+ Reads from this file return the current value of pm_hang_enabled.

> +#endif
>  #endif
>  #ifdef CONFIG_FREEZER
>       &pm_freeze_timeout_attr.attr,
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -30,6 +30,12 @@
>  #include <trace/events/power.h>
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +#include <linux/sched/debug.h>
> +#include <linux/kthread.h>
> +#include <linux/sched.h>
> +#include <uapi/linux/sched/types.h>
> +#endif

Don't #ifdef include files.

And why the uapi file?


I refer to linux-stable/kernel/rcu/tree.c source code.
In order to prevent build error for MAX_RT_PRIO, I need to include
this header file
<uapi/linux/sched/types.h>.

>
>  #include "power.h"
>
> @@ -61,6 +67,133 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +/* Suspend monitor thread toggle reason */
> +enum toggle_reason {
> +     TOGGLE_NONE,
> +     TOGGLE_START,
> +     TOGGLE_STOP,
> +};
> +
> +#define SUSPEND_TIMER_TIMEOUT_MS 30000
> +static struct task_struct *ksuspend_mon_tsk;
> +static DECLARE_WAIT_QUEUE_HEAD(power_suspend_waitqueue);
> +static enum toggle_reason suspend_mon_toggle;
> +static DEFINE_MUTEX(suspend_mon_lock);
> +
> +static void start_suspend_mon(void)
> +{
> +     mutex_lock(&suspend_mon_lock);
> +     suspend_mon_toggle =3D TOGGLE_START;
> +     mutex_unlock(&suspend_mon_lock);

Why do you need a lock for a single integer?

Since we have two kernel thread may reference variable "suspend_mon_toggle"=
,
one is suspend thread, another is suspend_monitor_kthread. We use it
to start/stop
suspend monitor.

Yes, in order to notify user this kernel panic was triggered by
suspend_timeout(), I add debug code to prevent confused.


> +
> +     /* Trigger a NULL pointer dereference */
> +     *null_pointer =3D 'a';

Are you sure this will work on all platforms?  We do have a panic
function if you really want to do that.

I agree to change to use panic() like following.
+static void suspend_timeout(int timeout_count)
+{
+ pr_info("Suspend monitor timeout (timer is %d seconds)\n",
+ (SUSPEND_TIMER_TIMEOUT_MS/1000));
+
+ show_state_filter(TASK_UNINTERRUPTIBLE);
+
+ if (timeout_count < 2)
+ return;
+
+ if (console_is_suspended())
+ resume_console();
+
+ /* Trigger a NULL pointer dereference */
+ panic("suspend timeout and panic");
+}

> +
> +     /* Should not reach here */
> +     pr_err("Trigger panic failed!\n");
> +}
> +
> +static int suspend_monitor_kthread(void *arg)
> +{
> +     long err;
> +     struct sched_param param =3D {.sched_priority
> +             =3D MAX_RT_PRIO-1};

Ick, no, call the scheduler functions properly, don't do this "by hand"

ever.
I refer to kernel/sched/core.c and they use MAX_RT_PRIO as thread
priority directly.
If you have other suggestion, I am willing to try.


> +     static int timeout_count;
> +     static long timeout;
> +
> +     pr_info("Init ksuspend_mon thread\n");

Again, debugging code :(

In order to make sure ksuspend_mon thread has been initialize, I add log he=
re.
If you think that is not necessary, I can remove it.

Sure, I got it, could you help to review if we can use IS_ENABLED()
like following?
+ if (IS_ENABLED(CONFIG_PM_SLEEP_MONITOR))
+ stop_suspend_mon();
+


Thank you,
Joseph.


Joseph Jang <josephjang@google.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Thank you Greg's promptly reply.
>
> let me try to explain detail in following.
>
> On Fri, Oct 16, 2020 at 11:51:09AM +0800, Joseph Jang wrote:
> > From: josephjang <josephjang@google.com>
>
> Please use your name as spelled out like you did above in the email
> header.
>
> Sure, I will update the patch again like following.
>
> From b3afca8f3ee1d587c188b830d94c683fe66cbfb3 Mon Sep 17 00:00:00 2001
> From: Joseph Jang <josephjang@google.com>
> Date: Fri, 16 Oct 2020 16:31:38 +0800
> Subject: [PATCH] power: suspend: Add suspend timeout handler
>
> Add suspend timeout handler to prevent device stuck during suspend/
> resume process. Suspend timeout handler will dump disk sleep task
> at first round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is 30 seconds.
>
>
> >
> > Add suspend timeout handler to prevent device stuck during suspend/
> > resume process. Suspend timeout handler will dump disk sleep task
> > at first round timeout and trigger kernel panic at second round timeout=
.
> > The default timer for each round is 30 seconds.
> >
> > Note: Can use following command to simulate suspend hang for testing.
> >     adb shell echo 1 > /sys/power/pm_hang
> >     adb shell echo mem > /sys/power/state
> > Signed-off-by: josephjang <josephjang@google.com>
>
> Need a blank line before the signed-off-by: and again, spell your name
> the same way.
>
> Sure, I will update the patch again like following.
>
> Note: Can use following command to simulate suspend hang for testing.
>     adb shell echo 1 > /sys/power/pm_hang
>     adb shell echo mem > /sys/power/state
>
> Signed-off-by: Joseph Jang <josephjang@google.com>
> ---
>
>
> > ---
> >  include/linux/console.h |   1 +
> >  kernel/power/Kconfig    |   9 +++
> >  kernel/power/main.c     |  66 ++++++++++++++++
> >  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/printk/printk.c  |   5 ++
> >  5 files changed, 243 insertions(+)
> >
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index 0670d3491e0e..ac468c602c0b 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
> >  { }
> >  #endif
> >  extern bool console_suspend_enabled;
> > +extern int is_console_suspended(void);
>
> For global functions, how about:
>         bool console_is_suspended(void);
> ?
>
> Agree, I will update like following.
>  extern bool console_suspend_enabled;
> +extern int console_is_suspended(void);
>
>
>
> >
> >  /* Suspend and resume console messages over PM events */
> >  extern void suspend_console(void);
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index a7320f07689d..52b7a181b6d8 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
> >       def_bool y
> >       depends on PM_DEBUG && PM_SLEEP
> >
> > +config PM_SLEEP_MONITOR
> > +     bool "Linux kernel suspend/resume process monitor"
> > +     depends on PM_SLEEP
> > +     help
> > +     This option will enable suspend/resume monitor to prevent device
> > +     stuck during suspend/resume process. Suspend timeout handler will
> > +     dump disk sleep task at first round timeout and trigger kernel pa=
nic
> > +     at second round timeout. The default timer for each round is 30 s=
econds.
>
> Ouch, are you sure you want to panic?
>
> Yes, we would like to trigger kernel panic to reboot system and prevent s=
ystem hang there.
>
>
> > +
> >  config DPM_WATCHDOG
> >       bool "Device suspend/resume watchdog"
> >       depends on PM_DEBUG && PSTORE && EXPERT
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 40f86ec4ab30..f25b8a47583e 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -575,6 +575,69 @@ void __pm_pr_dbg(bool defer, const char *fmt, ...)
> >  static inline void pm_print_times_init(void) {}
> >  #endif /* CONFIG_PM_SLEEP_DEBUG */
> >
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +/* If set, devices will stuck at suspend for verification */
> > +static bool pm_hang_enabled;
> > +
> > +static int pm_notify_test(struct notifier_block *nb,
> > +                          unsigned long mode, void *_unused)
> > +{
> > +     pr_info("Jump into infinite loop now\n");
>
> Why do you have debugging code still enabled?
>
> Because we want to make sure system hang was cause by our test code here.
>
>
> > +
> > +     /* Suspend thread stuck at a loop forever */
> > +     for (;;)
> > +             ;
> > +
>
> Don't busy spin, that will burn power.
>
> Okay, I will add msleep() to prevent system burn power during testing.
>
> +static int pm_notify_test(struct notifier_block *nb,
> +     unsigned long mode, void *_unused)
> +{
> + pr_info("Jump into infinite loop now\n");
> +
> + /* Suspend thread stuck at a loop forever */
> + for (;;)
> + msleep(100);
> +
> + pr_info("Fail to stuck at loop\n");
> +
> + return 0;
> +}
>
>
> > +     pr_info("Fail to stuck at loop\n");
>
> And how can this happen?
>
> I think we should not see this log unless the for loop has problem.
>
>
>
> > +
> > +     return 0;
> > +}
> > +
> > +static struct notifier_block pm_notify_nb =3D {
> > +     .notifier_call =3D pm_notify_test,
> > +};
> > +
> > +static ssize_t pm_hang_show(struct kobject *kobj, struct kobj_attribut=
e *attr,
> > +                          char *buf)
> > +{
> > +     return snprintf(buf, 10, "%d\n", pm_hang_enabled);
> > +}
> > +
> > +static ssize_t pm_hang_store(struct kobject *kobj, struct kobj_attribu=
te *attr,
> > +                           const char *buf, size_t n)
> > +{
> > +     unsigned long val;
> > +     int result;
> > +
> > +     if (kstrtoul(buf, 10, &val))
> > +             return -EINVAL;
> > +
> > +     if (val > 1)
> > +             return -EINVAL;
> > +
> > +     pm_hang_enabled =3D !!val;
> > +
> > +     if (pm_hang_enabled =3D=3D true) {
> > +
> > +             result =3D register_pm_notifier(&pm_notify_nb);
> > +             if (result)
> > +                     pr_warn("Can not register suspend notifier, retur=
n %d\n",
> > +                             result);
> > +
> > +     } else {
> > +
> > +             result =3D unregister_pm_notifier(&pm_notify_nb);
> > +             if (result)
> > +                     pr_warn("Can not unregister suspend notifier, ret=
urn %d\n",
> > +                             result);
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +power_attr(pm_hang);
> > +#endif
> > +
> >  struct kobject *power_kobj;
> >
> >  /**
> > @@ -909,6 +972,9 @@ static struct attribute * g[] =3D {
> >       &pm_wakeup_irq_attr.attr,
> >       &pm_debug_messages_attr.attr,
> >  #endif
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +     &pm_hang_attr.attr,
>
> You added a sysfs file, but no Documentation/ABI/ update?  That's not
> ok.
>
>
> Sure, I add some description in the document like following.
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -420,3 +420,18 @@ Description:
>   disables it.  Reads from the file return the current value.
>   The default is "1" if the build-time "SUSPEND_SKIP_SYNC" config
>   flag is unset, or "0" otherwise.
> +
> +What: /sys/power/pm_hang
> +Date: Oct 2020
> +Contact: Joseph Jang <josephjang@google.com>
> +Description:
> + The /sys/power/pm_hang file controls the variable pm_hang_enabled
> + which controls whether you need to simulate system hang during
> + suspend.
> +
> + Writing a "1" to this file will set the pm_hang_enabled to "1" and
> + register a pm_notify function pm_notify_test() to simulate system
> + hang during suspend.
> + Writing a "0" to this file will set the pm_hang_enabled to "0" and
> + unregister a pm_notify function pm_notify_test().
> + Reads from this file return the current value of pm_hang_enabled.
>
> > +#endif
> >  #endif
> >  #ifdef CONFIG_FREEZER
> >       &pm_freeze_timeout_attr.attr,
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -30,6 +30,12 @@
> >  #include <trace/events/power.h>
> >  #include <linux/compiler.h>
> >  #include <linux/moduleparam.h>
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +#include <linux/sched/debug.h>
> > +#include <linux/kthread.h>
> > +#include <linux/sched.h>
> > +#include <uapi/linux/sched/types.h>
> > +#endif
>
> Don't #ifdef include files.
>
> And why the uapi file?
>
>
> I refer to linux-stable/kernel/rcu/tree.c source code.
> In order to prevent build error for MAX_RT_PRIO, I need to include this h=
eader file
> <uapi/linux/sched/types.h>.
>
> >
> >  #include "power.h"
> >
> > @@ -61,6 +67,133 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
> >  enum s2idle_states __read_mostly s2idle_state;
> >  static DEFINE_RAW_SPINLOCK(s2idle_lock);
> >
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +/* Suspend monitor thread toggle reason */
> > +enum toggle_reason {
> > +     TOGGLE_NONE,
> > +     TOGGLE_START,
> > +     TOGGLE_STOP,
> > +};
> > +
> > +#define SUSPEND_TIMER_TIMEOUT_MS 30000
> > +static struct task_struct *ksuspend_mon_tsk;
> > +static DECLARE_WAIT_QUEUE_HEAD(power_suspend_waitqueue);
> > +static enum toggle_reason suspend_mon_toggle;
> > +static DEFINE_MUTEX(suspend_mon_lock);
> > +
> > +static void start_suspend_mon(void)
> > +{
> > +     mutex_lock(&suspend_mon_lock);
> > +     suspend_mon_toggle =3D TOGGLE_START;
> > +     mutex_unlock(&suspend_mon_lock);
>
> Why do you need a lock for a single integer?
>
> Since we have two kernel thread may reference variable "suspend_mon_toggl=
e",
> one is suspend thread, another is suspend_monitor_kthread. We use it to s=
tart/stop
> suspend monitor.
>
>
>
> > +     wake_up(&power_suspend_waitqueue);
> > +}
> > +
> > +static void stop_suspend_mon(void)
> > +{
> > +     mutex_lock(&suspend_mon_lock);
> > +     suspend_mon_toggle =3D TOGGLE_STOP;
> > +     mutex_unlock(&suspend_mon_lock);
> > +     wake_up(&power_suspend_waitqueue);
> > +}
> > +
> > +static void suspend_timeout(int timeout_count)
> > +{
> > +     char *null_pointer =3D NULL;
> > +
> > +     pr_info("Suspend monitor timeout (timer is %d seconds)\n",
> > +             (SUSPEND_TIMER_TIMEOUT_MS/1000));
> > +
> > +     show_state_filter(TASK_UNINTERRUPTIBLE);
> > +
> > +     if (timeout_count < 2)
> > +             return;
> > +
> > +     if (is_console_suspended())
> > +             resume_console();
> > +
> > +     pr_info("Trigger a panic\n");
>
> Again, debugging code?
>
> Yes, in order to notify user this kernel panic was triggered by
> suspend_timeout(), I add debug code to prevent confused.
>
>
> > +
> > +     /* Trigger a NULL pointer dereference */
> > +     *null_pointer =3D 'a';
>
> Are you sure this will work on all platforms?  We do have a panic
> function if you really want to do that.
>
> I agree to change to use panic() like following.
> +static void suspend_timeout(int timeout_count)
> +{
> + pr_info("Suspend monitor timeout (timer is %d seconds)\n",
> + (SUSPEND_TIMER_TIMEOUT_MS/1000));
> +
> + show_state_filter(TASK_UNINTERRUPTIBLE);
> +
> + if (timeout_count < 2)
> + return;
> +
> + if (console_is_suspended())
> + resume_console();
> +
> + /* Trigger a NULL pointer dereference */
> + panic("suspend timeout and panic");
> +}
>
> > +
> > +     /* Should not reach here */
> > +     pr_err("Trigger panic failed!\n");
> > +}
> > +
> > +static int suspend_monitor_kthread(void *arg)
> > +{
> > +     long err;
> > +     struct sched_param param =3D {.sched_priority
> > +             =3D MAX_RT_PRIO-1};
>
> Ick, no, call the scheduler functions properly, don't do this "by hand"
>
> ever.
> I refer to kernel/sched/core.c and they use MAX_RT_PRIO as thread priorit=
y directly.
> If you have other suggestion, I am willing to try.
>
>
> > +     static int timeout_count;
> > +     static long timeout;
> > +
> > +     pr_info("Init ksuspend_mon thread\n");
>
> Again, debugging code :(
>
> In order to make sure ksuspend_mon thread has been initialize, I add log =
here.
> If you think that is not necessary, I can remove it.
>
>
>
>
> > +
> > +     sched_setscheduler(current, SCHED_FIFO, &param);
> > +
> > +     timeout_count =3D 0;
> > +     timeout =3D MAX_SCHEDULE_TIMEOUT;
> > +
> > +     do {
> > +             /* Wait suspend timer timeout */
> > +             err =3D wait_event_interruptible_timeout(
> > +                     power_suspend_waitqueue,
> > +                     (suspend_mon_toggle !=3D TOGGLE_NONE),
> > +                     timeout);
> > +
> > +             mutex_lock(&suspend_mon_lock);
> > +             /* suspend monitor state change */
> > +             if (suspend_mon_toggle !=3D TOGGLE_NONE) {
> > +                     if (suspend_mon_toggle =3D=3D TOGGLE_START) {
> > +                             timeout =3D msecs_to_jiffies(
> > +                                     SUSPEND_TIMER_TIMEOUT_MS);
> > +                             pr_info("Start suspend monitor\n");
> > +                     } else if (suspend_mon_toggle =3D=3D TOGGLE_STOP)=
 {
> > +                             timeout =3D MAX_SCHEDULE_TIMEOUT;
> > +                             timeout_count =3D 0;
> > +                             pr_info("Stop suspend monitor\n");
> > +                     }
> > +                     suspend_mon_toggle =3D TOGGLE_NONE;
> > +                     mutex_unlock(&suspend_mon_lock);
> > +                     continue;
> > +             }
> > +             mutex_unlock(&suspend_mon_lock);
> > +
> > +             /* suspend monitor event handler */
> > +             if (err =3D=3D 0) {
> > +                     timeout_count++;
> > +                     suspend_timeout(timeout_count);
> > +             } else if (err =3D=3D -ERESTARTSYS) {
> > +                     pr_info("Exit ksuspend_mon!");
> > +                     break;
> > +             }
> > +     } while (1);
> > +
> > +     return 0;
> > +}
> > +
> > +static void init_suspend_monitor_thread(void)
> > +{
> > +     int ret;
> > +
> > +     ksuspend_mon_tsk =3D kthread_create(suspend_monitor_kthread,
> > +             NULL, "ksuspend_mon");
> > +     if (IS_ERR(ksuspend_mon_tsk)) {
> > +             ret =3D PTR_ERR(ksuspend_mon_tsk);
> > +             ksuspend_mon_tsk =3D NULL;
> > +             pr_err("Create suspend_monitor_kthread failed! ret =3D %d=
\n",
> > +                     ret);
> > +             return;
> > +     }
> > +
> > +     suspend_mon_toggle =3D TOGGLE_NONE;
> > +     wake_up_process(ksuspend_mon_tsk);
> > +
> > +}
> > +#endif
> > +
> >  /**
> >   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default=
 suspend.
> >   *
> > @@ -89,6 +222,10 @@ static void s2idle_enter(void)
> >  {
> >       trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, =
true);
> >
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +     stop_suspend_mon();
> > +#endif
>
> Do not put #ifdef in .c files, that's not the proper kernel coding
> style.  Especially for single function calls.
>
> Sure, I got it, could you help to review if we can use IS_ENABLED() like =
following?
> + if (IS_ENABLED(CONFIG_PM_SLEEP_MONITOR))
> + stop_suspend_mon();
> +
>
>
> Thank you,
> Joseph.
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E6=96=BC 2020=E5=B9=B410=
=E6=9C=8816=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:43=E5=AF=AB=E9=
=81=93=EF=BC=9A
>>
>> On Fri, Oct 16, 2020 at 11:51:09AM +0800, Joseph Jang wrote:
>> > From: josephjang <josephjang@google.com>
>>
>> Please use your name as spelled out like you did above in the email
>> header.
>>
>> >
>> > Add suspend timeout handler to prevent device stuck during suspend/
>> > resume process. Suspend timeout handler will dump disk sleep task
>> > at first round timeout and trigger kernel panic at second round timeou=
t.
>> > The default timer for each round is 30 seconds.
>> >
>> > Note: Can use following command to simulate suspend hang for testing.
>> >     adb shell echo 1 > /sys/power/pm_hang
>> >     adb shell echo mem > /sys/power/state
>> > Signed-off-by: josephjang <josephjang@google.com>
>>
>> Need a blank line before the signed-off-by: and again, spell your name
>> the same way.
>>
>>
>>
>> > ---
>> >  include/linux/console.h |   1 +
>> >  kernel/power/Kconfig    |   9 +++
>> >  kernel/power/main.c     |  66 ++++++++++++++++
>> >  kernel/power/suspend.c  | 162 +++++++++++++++++++++++++++++++++++++++=
+
>> >  kernel/printk/printk.c  |   5 ++
>> >  5 files changed, 243 insertions(+)
>> >
>> > diff --git a/include/linux/console.h b/include/linux/console.h
>> > index 0670d3491e0e..ac468c602c0b 100644
>> > --- a/include/linux/console.h
>> > +++ b/include/linux/console.h
>> > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
>> >  { }
>> >  #endif
>> >  extern bool console_suspend_enabled;
>> > +extern int is_console_suspended(void);
>>
>> For global functions, how about:
>>         bool console_is_suspended(void);
>> ?
>>
>> >
>> >  /* Suspend and resume console messages over PM events */
>> >  extern void suspend_console(void);
>> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> > index a7320f07689d..52b7a181b6d8 100644
>> > --- a/kernel/power/Kconfig
>> > +++ b/kernel/power/Kconfig
>> > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
>> >       def_bool y
>> >       depends on PM_DEBUG && PM_SLEEP
>> >
>> > +config PM_SLEEP_MONITOR
>> > +     bool "Linux kernel suspend/resume process monitor"
>> > +     depends on PM_SLEEP
>> > +     help
>> > +     This option will enable suspend/resume monitor to prevent device
>> > +     stuck during suspend/resume process. Suspend timeout handler wil=
l
>> > +     dump disk sleep task at first round timeout and trigger kernel p=
anic
>> > +     at second round timeout. The default timer for each round is 30 =
seconds.
>>
>> Ouch, are you sure you want to panic?
>>
>>
>> > +
>> >  config DPM_WATCHDOG
>> >       bool "Device suspend/resume watchdog"
>> >       depends on PM_DEBUG && PSTORE && EXPERT
>> > diff --git a/kernel/power/main.c b/kernel/power/main.c
>> > index 40f86ec4ab30..f25b8a47583e 100644
>> > --- a/kernel/power/main.c
>> > +++ b/kernel/power/main.c
>> > @@ -575,6 +575,69 @@ void __pm_pr_dbg(bool defer, const char *fmt, ...=
)
>> >  static inline void pm_print_times_init(void) {}
>> >  #endif /* CONFIG_PM_SLEEP_DEBUG */
>> >
>> > +#ifdef CONFIG_PM_SLEEP_MONITOR
>> > +/* If set, devices will stuck at suspend for verification */
>> > +static bool pm_hang_enabled;
>> > +
>> > +static int pm_notify_test(struct notifier_block *nb,
>> > +                          unsigned long mode, void *_unused)
>> > +{
>> > +     pr_info("Jump into infinite loop now\n");
>>
>> Why do you have debugging code still enabled?
>>
>> > +
>> > +     /* Suspend thread stuck at a loop forever */
>> > +     for (;;)
>> > +             ;
>> > +
>>
>> Don't busy spin, that will burn power.
>>
>>
>> > +     pr_info("Fail to stuck at loop\n");
>>
>> And how can this happen?
>>
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static struct notifier_block pm_notify_nb =3D {
>> > +     .notifier_call =3D pm_notify_test,
>> > +};
>> > +
>> > +static ssize_t pm_hang_show(struct kobject *kobj, struct kobj_attribu=
te *attr,
>> > +                          char *buf)
>> > +{
>> > +     return snprintf(buf, 10, "%d\n", pm_hang_enabled);
>> > +}
>> > +
>> > +static ssize_t pm_hang_store(struct kobject *kobj, struct kobj_attrib=
ute *attr,
>> > +                           const char *buf, size_t n)
>> > +{
>> > +     unsigned long val;
>> > +     int result;
>> > +
>> > +     if (kstrtoul(buf, 10, &val))
>> > +             return -EINVAL;
>> > +
>> > +     if (val > 1)
>> > +             return -EINVAL;
>> > +
>> > +     pm_hang_enabled =3D !!val;
>> > +
>> > +     if (pm_hang_enabled =3D=3D true) {
>> > +
>> > +             result =3D register_pm_notifier(&pm_notify_nb);
>> > +             if (result)
>> > +                     pr_warn("Can not register suspend notifier, retu=
rn %d\n",
>> > +                             result);
>> > +
>> > +     } else {
>> > +
>> > +             result =3D unregister_pm_notifier(&pm_notify_nb);
>> > +             if (result)
>> > +                     pr_warn("Can not unregister suspend notifier, re=
turn %d\n",
>> > +                             result);
>> > +     }
>> > +
>> > +     return n;
>> > +}
>> > +
>> > +power_attr(pm_hang);
>> > +#endif
>> > +
>> >  struct kobject *power_kobj;
>> >
>> >  /**
>> > @@ -909,6 +972,9 @@ static struct attribute * g[] =3D {
>> >       &pm_wakeup_irq_attr.attr,
>> >       &pm_debug_messages_attr.attr,
>> >  #endif
>> > +#ifdef CONFIG_PM_SLEEP_MONITOR
>> > +     &pm_hang_attr.attr,
>>
>> You added a sysfs file, but no Documentation/ABI/ update?  That's not
>> ok.
>>
>>
>> > +#endif
>> >  #endif
>> >  #ifdef CONFIG_FREEZER
>> >       &pm_freeze_timeout_attr.attr,
>> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> > index 8b1bb5ee7e5d..6f2679cfd9d1 100644
>> > --- a/kernel/power/suspend.c
>> > +++ b/kernel/power/suspend.c
>> > @@ -30,6 +30,12 @@
>> >  #include <trace/events/power.h>
>> >  #include <linux/compiler.h>
>> >  #include <linux/moduleparam.h>
>> > +#ifdef CONFIG_PM_SLEEP_MONITOR
>> > +#include <linux/sched/debug.h>
>> > +#include <linux/kthread.h>
>> > +#include <linux/sched.h>
>> > +#include <uapi/linux/sched/types.h>
>> > +#endif
>>
>> Don't #ifdef include files.
>>
>> And why the uapi file?
>>
>> >
>> >  #include "power.h"
>> >
>> > @@ -61,6 +67,133 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>> >  enum s2idle_states __read_mostly s2idle_state;
>> >  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>> >
>> > +#ifdef CONFIG_PM_SLEEP_MONITOR
>> > +/* Suspend monitor thread toggle reason */
>> > +enum toggle_reason {
>> > +     TOGGLE_NONE,
>> > +     TOGGLE_START,
>> > +     TOGGLE_STOP,
>> > +};
>> > +
>> > +#define SUSPEND_TIMER_TIMEOUT_MS 30000
>> > +static struct task_struct *ksuspend_mon_tsk;
>> > +static DECLARE_WAIT_QUEUE_HEAD(power_suspend_waitqueue);
>> > +static enum toggle_reason suspend_mon_toggle;
>> > +static DEFINE_MUTEX(suspend_mon_lock);
>> > +
>> > +static void start_suspend_mon(void)
>> > +{
>> > +     mutex_lock(&suspend_mon_lock);
>> > +     suspend_mon_toggle =3D TOGGLE_START;
>> > +     mutex_unlock(&suspend_mon_lock);
>>
>> Why do you need a lock for a single integer?
>>
>> > +     wake_up(&power_suspend_waitqueue);
>> > +}
>> > +
>> > +static void stop_suspend_mon(void)
>> > +{
>> > +     mutex_lock(&suspend_mon_lock);
>> > +     suspend_mon_toggle =3D TOGGLE_STOP;
>> > +     mutex_unlock(&suspend_mon_lock);
>> > +     wake_up(&power_suspend_waitqueue);
>> > +}
>> > +
>> > +static void suspend_timeout(int timeout_count)
>> > +{
>> > +     char *null_pointer =3D NULL;
>> > +
>> > +     pr_info("Suspend monitor timeout (timer is %d seconds)\n",
>> > +             (SUSPEND_TIMER_TIMEOUT_MS/1000));
>> > +
>> > +     show_state_filter(TASK_UNINTERRUPTIBLE);
>> > +
>> > +     if (timeout_count < 2)
>> > +             return;
>> > +
>> > +     if (is_console_suspended())
>> > +             resume_console();
>> > +
>> > +     pr_info("Trigger a panic\n");
>>
>> Again, debugging code?
>>
>> > +
>> > +     /* Trigger a NULL pointer dereference */
>> > +     *null_pointer =3D 'a';
>>
>> Are you sure this will work on all platforms?  We do have a panic
>> function if you really want to do that.
>>
>> > +
>> > +     /* Should not reach here */
>> > +     pr_err("Trigger panic failed!\n");
>> > +}
>> > +
>> > +static int suspend_monitor_kthread(void *arg)
>> > +{
>> > +     long err;
>> > +     struct sched_param param =3D {.sched_priority
>> > +             =3D MAX_RT_PRIO-1};
>>
>> Ick, no, call the scheduler functions properly, don't do this "by hand"
>> ever.
>>
>> > +     static int timeout_count;
>> > +     static long timeout;
>> > +
>> > +     pr_info("Init ksuspend_mon thread\n");
>>
>> Again, debugging code :(
>>
>> > +
>> > +     sched_setscheduler(current, SCHED_FIFO, &param);
>> > +
>> > +     timeout_count =3D 0;
>> > +     timeout =3D MAX_SCHEDULE_TIMEOUT;
>> > +
>> > +     do {
>> > +             /* Wait suspend timer timeout */
>> > +             err =3D wait_event_interruptible_timeout(
>> > +                     power_suspend_waitqueue,
>> > +                     (suspend_mon_toggle !=3D TOGGLE_NONE),
>> > +                     timeout);
>> > +
>> > +             mutex_lock(&suspend_mon_lock);
>> > +             /* suspend monitor state change */
>> > +             if (suspend_mon_toggle !=3D TOGGLE_NONE) {
>> > +                     if (suspend_mon_toggle =3D=3D TOGGLE_START) {
>> > +                             timeout =3D msecs_to_jiffies(
>> > +                                     SUSPEND_TIMER_TIMEOUT_MS);
>> > +                             pr_info("Start suspend monitor\n");
>> > +                     } else if (suspend_mon_toggle =3D=3D TOGGLE_STOP=
) {
>> > +                             timeout =3D MAX_SCHEDULE_TIMEOUT;
>> > +                             timeout_count =3D 0;
>> > +                             pr_info("Stop suspend monitor\n");
>> > +                     }
>> > +                     suspend_mon_toggle =3D TOGGLE_NONE;
>> > +                     mutex_unlock(&suspend_mon_lock);
>> > +                     continue;
>> > +             }
>> > +             mutex_unlock(&suspend_mon_lock);
>> > +
>> > +             /* suspend monitor event handler */
>> > +             if (err =3D=3D 0) {
>> > +                     timeout_count++;
>> > +                     suspend_timeout(timeout_count);
>> > +             } else if (err =3D=3D -ERESTARTSYS) {
>> > +                     pr_info("Exit ksuspend_mon!");
>> > +                     break;
>> > +             }
>> > +     } while (1);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static void init_suspend_monitor_thread(void)
>> > +{
>> > +     int ret;
>> > +
>> > +     ksuspend_mon_tsk =3D kthread_create(suspend_monitor_kthread,
>> > +             NULL, "ksuspend_mon");
>> > +     if (IS_ERR(ksuspend_mon_tsk)) {
>> > +             ret =3D PTR_ERR(ksuspend_mon_tsk);
>> > +             ksuspend_mon_tsk =3D NULL;
>> > +             pr_err("Create suspend_monitor_kthread failed! ret =3D %=
d\n",
>> > +                     ret);
>> > +             return;
>> > +     }
>> > +
>> > +     suspend_mon_toggle =3D TOGGLE_NONE;
>> > +     wake_up_process(ksuspend_mon_tsk);
>> > +
>> > +}
>> > +#endif
>> > +
>> >  /**
>> >   * pm_suspend_default_s2idle - Check if suspend-to-idle is the defaul=
t suspend.
>> >   *
>> > @@ -89,6 +222,10 @@ static void s2idle_enter(void)
>> >  {
>> >       trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE,=
 true);
>> >
>> > +#ifdef CONFIG_PM_SLEEP_MONITOR
>> > +     stop_suspend_mon();
>> > +#endif
>>
>> Do not put #ifdef in .c files, that's not the proper kernel coding
>> style.  Especially for single function calls.
>>
>> I've stopped here...
>>
>> greg k-h
>
>
>
> --
> Embedded Software engineer



--=20
Embedded Software engineer
