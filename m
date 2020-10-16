Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809E2290424
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405129AbgJPLfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405097AbgJPLfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 07:35:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2923AC061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 04:35:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b25so2218326ybj.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=mLnefFqm4XNTGAZuh8SK08mNoT3kzEMqh/Bo6hfoNX8=;
        b=FUY+fl9sehf8Cts35O5qD6B4/4VRsmeL9zQ+BgZ/ixGdFkYD+3II74+OjF+ARL05IA
         2q89lac5cmJGJYbia8xPn48g/GGXeqmZ1i0EJwvTeEMJD1KAg0tgV5Vj88jDYIX5l0TE
         N5L+yFJCUju4Hwf3/QMg+DE6iRsXvP6DExET4ZhjCX0uSkRXIJA3ecjm/LJriM5VMHXt
         qtB5WgJ6m/kty/2uI5cuiRrZ0VBbCDftnJu25JY09jzbTis7Rr/FtZOpRfZOnDLWi/wl
         3PmY/MgG8Arhs6ltbQupvgaFArQYbjCePWU/776NWpnZdkZxsg/14WAEHjywnuqoTGD2
         vP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=mLnefFqm4XNTGAZuh8SK08mNoT3kzEMqh/Bo6hfoNX8=;
        b=NqbgHb/rAALyPt/N3+98sB51IYtQfJEyji2j+9DI9bhNAynGWFW7YGjzEAM7XPFcfQ
         +yCsL06/Gr3SzjBcu7GSfVRLgNAbfNvdY9Wb8oOqcDXNts4OOpvCt3as0rdj1MJzzTZF
         cvOgPsRQDk7Cs6K4ie5AXI+Aw0N5ILnc6i2MyNdraDllRTWoeHwwNZj934wk4a2dWQOK
         Z6m15n954V3QL2u6psls6Qfgzu49gVl7xulMaZ3g4nfJrflgcqe68NToWYo7oZ5am/UT
         Xx+uPxKkeVeD8/Qc1vccGAEWkOVqYRP7QPsubEn0GCtoRPDR4ZdlJpPfAbITdp4l5nMu
         FPUA==
X-Gm-Message-State: AOAM533bSPoRRxaSci2KhMqzu92/fIhWNIrU5r1TohjDz+HGtnBvlEVC
        +vmANrE8J4R0/GbvVobqWe5LgWQhuAJfvVYu
X-Google-Smtp-Source: ABdhPJyh/bL4xzjWOOTBFsC9+iPVPMAs1+Flf9gozKyEepyJ1BJnn73FjaUzDXXUJ+x5NKJVnbnHNw90CpDhvmKS
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a25:b709:: with SMTP id
 t9mr4054316ybj.182.1602848113293; Fri, 16 Oct 2020 04:35:13 -0700 (PDT)
Message-ID: <0000000000006c8bd705b1c82896@google.com>
Date:   Fri, 16 Oct 2020 11:35:13 +0000
Subject: [PATCH] power: suspend: Add suspend timeout handler
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you Greg's promptly reply.

let me try to explain detail in following.

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


> Add suspend timeout handler to prevent device stuck during suspend/
> resume process. Suspend timeout handler will dump disk sleep task
> at first round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is 30 seconds.

> Note: Can use following command to simulate suspend hang for testing.
>      adb shell echo 1 > /sys/power/pm_hang
>      adb shell echo mem > /sys/power/state
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
>   include/linux/console.h |   1 +
>   kernel/power/Kconfig    |   9 +++
>   kernel/power/main.c     |  66 ++++++++++++++++
>   kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
>   kernel/printk/printk.c  |   5 ++
>   5 files changed, 243 insertions(+)

> diff --git a/include/linux/console.h b/include/linux/console.h
> index 0670d3491e0e..ac468c602c0b 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
>   { }
>   #endif
>   extern bool console_suspend_enabled;
> +extern int is_console_suspended(void);

For global functions, how about:
         bool console_is_suspended(void);
?

Agree, I will update like following.
  extern bool console_suspend_enabled;
+extern int console_is_suspended(void);



>   /* Suspend and resume console messages over PM events */
>   extern void suspend_console(void);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..52b7a181b6d8 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
>        def_bool y
>        depends on PM_DEBUG && PM_SLEEP

> +config PM_SLEEP_MONITOR
> +     bool "Linux kernel suspend/resume process monitor"
> +     depends on PM_SLEEP
> +     help
> +     This option will enable suspend/resume monitor to prevent device
> +     stuck during suspend/resume process. Suspend timeout handler will
> +     dump disk sleep task at first round timeout and trigger kernel panic
> +     at second round timeout. The default timer for each round is 30  
> seconds.

Ouch, are you sure you want to panic?
Yes, we would like to trigger kernel panic to reboot system and prevent  
system hang there.

> +
>   config DPM_WATCHDOG
>        bool "Device suspend/resume watchdog"
>        depends on PM_DEBUG && PSTORE && EXPERT
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 40f86ec4ab30..f25b8a47583e 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -575,6 +575,69 @@ void __pm_pr_dbg(bool defer, const char *fmt, ...)
>   static inline void pm_print_times_init(void) {}
>   #endif /* CONFIG_PM_SLEEP_DEBUG */

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
>   #endif
>   #ifdef CONFIG_FREEZER
>        &pm_freeze_timeout_attr.attr,
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -30,6 +30,12 @@
>   #include <trace/events/power.h>
>   #include <linux/compiler.h>
>   #include <linux/moduleparam.h>
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +#include <linux/sched/debug.h>
> +#include <linux/kthread.h>
> +#include <linux/sched.h>
> +#include <uapi/linux/sched/types.h>
> +#endif

Don't #ifdef include files.

And why the uapi file?

I refer to linux-stable/kernel/rcu/tree.c source code.
In order to prevent build error for MAX_RT_PRIO, I need to include this  
header file
<uapi/linux/sched/types.h>.

>   #include "power.h"

> @@ -61,6 +67,133 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>   enum s2idle_states __read_mostly s2idle_state;
>   static DEFINE_RAW_SPINLOCK(s2idle_lock);

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
> +     suspend_mon_toggle = TOGGLE_START;
> +     mutex_unlock(&suspend_mon_lock);

Why do you need a lock for a single integer?
Since we have two kernel thread may reference variable "suspend_mon_toggle",
one is suspend thread, another is suspend_monitor_kthread. We use it to  
start/stop
suspend monitor.
Yes, in order to notify user this kernel panic was triggered by
suspend_timeout(), I add debug code to prevent confused.

> +
> +     /* Trigger a NULL pointer dereference */
> +     *null_pointer = 'a';

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
> +     struct sched_param param = {.sched_priority
> +             = MAX_RT_PRIO-1};

Ick, no, call the scheduler functions properly, don't do this "by hand"
ever.
I refer to kernel/sched/core.c and they use MAX_RT_PRIO as thread priority  
directly.
If you have other suggestion, I am willing to try.

> +     static int timeout_count;
> +     static long timeout;
> +
> +     pr_info("Init ksuspend_mon thread\n");

Again, debugging code :(
In order to make sure ksuspend_mon thread has been initialize, I add log  
here.
If you think that is not necessary, I can remove it.
Sure, I got it, could you help to review if we can use IS_ENABLED() like  
following?
+ if (IS_ENABLED(CONFIG_PM_SLEEP_MONITOR))
+ stop_suspend_mon();
+

Thank you,
Joseph.
