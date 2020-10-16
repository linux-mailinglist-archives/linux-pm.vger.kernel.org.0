Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD04B28FDC0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 07:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbgJPFnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 01:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390443AbgJPFno (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 01:43:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4992067D;
        Fri, 16 Oct 2020 05:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602827020;
        bh=IRrFRbZI5qYoYRzLPdVfZx3tw+122IyP0qzYKSh+JO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEWDmSaeRkotEPQfhdz4FnjUz0fh7GotsEXVEu/Hwr8YVMf/0hW/ERRq4n8OZwWBD
         8B9oPADJLspug3YlPQMDvqA2N9n8P0rqaZtigTDLwT48SIXus7pjtn1HU+e2ozyfqO
         NvqtoCvY5RwqxqyjToEtNmPobPAYFZUOpmMiexp4=
Date:   Fri, 16 Oct 2020 07:44:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
Message-ID: <20201016054412.GB155953@kroah.com>
References: <20201016035109.3952356-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016035109.3952356-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 11:51:09AM +0800, Joseph Jang wrote:
> From: josephjang <josephjang@google.com>

Please use your name as spelled out like you did above in the email
header.

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

>  
>  /* Suspend and resume console messages over PM events */
>  extern void suspend_console(void);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..52b7a181b6d8 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
>  	def_bool y
>  	depends on PM_DEBUG && PM_SLEEP
>  
> +config PM_SLEEP_MONITOR
> +	bool "Linux kernel suspend/resume process monitor"
> +	depends on PM_SLEEP
> +	help
> +	This option will enable suspend/resume monitor to prevent device
> +	stuck during suspend/resume process. Suspend timeout handler will
> +	dump disk sleep task at first round timeout and trigger kernel panic
> +	at second round timeout. The default timer for each round is 30 seconds.

Ouch, are you sure you want to panic?


> +
>  config DPM_WATCHDOG
>  	bool "Device suspend/resume watchdog"
>  	depends on PM_DEBUG && PSTORE && EXPERT
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
> +			     unsigned long mode, void *_unused)
> +{
> +	pr_info("Jump into infinite loop now\n");

Why do you have debugging code still enabled?

> +
> +	/* Suspend thread stuck at a loop forever */
> +	for (;;)
> +		;
> +

Don't busy spin, that will burn power.


> +	pr_info("Fail to stuck at loop\n");

And how can this happen?

> +
> +	return 0;
> +}
> +
> +static struct notifier_block pm_notify_nb = {
> +	.notifier_call = pm_notify_test,
> +};
> +
> +static ssize_t pm_hang_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	return snprintf(buf, 10, "%d\n", pm_hang_enabled);
> +}
> +
> +static ssize_t pm_hang_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			      const char *buf, size_t n)
> +{
> +	unsigned long val;
> +	int result;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	pm_hang_enabled = !!val;
> +
> +	if (pm_hang_enabled == true) {
> +
> +		result = register_pm_notifier(&pm_notify_nb);
> +		if (result)
> +			pr_warn("Can not register suspend notifier, return %d\n",
> +				result);
> +
> +	} else {
> +
> +		result = unregister_pm_notifier(&pm_notify_nb);
> +		if (result)
> +			pr_warn("Can not unregister suspend notifier, return %d\n",
> +				result);
> +	}
> +
> +	return n;
> +}
> +
> +power_attr(pm_hang);
> +#endif
> +
>  struct kobject *power_kobj;
>  
>  /**
> @@ -909,6 +972,9 @@ static struct attribute * g[] = {
>  	&pm_wakeup_irq_attr.attr,
>  	&pm_debug_messages_attr.attr,
>  #endif
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +	&pm_hang_attr.attr,

You added a sysfs file, but no Documentation/ABI/ update?  That's not
ok.


> +#endif
>  #endif
>  #ifdef CONFIG_FREEZER
>  	&pm_freeze_timeout_attr.attr,
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
> +	TOGGLE_NONE,
> +	TOGGLE_START,
> +	TOGGLE_STOP,
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
> +	mutex_lock(&suspend_mon_lock);
> +	suspend_mon_toggle = TOGGLE_START;
> +	mutex_unlock(&suspend_mon_lock);

Why do you need a lock for a single integer?

> +	wake_up(&power_suspend_waitqueue);
> +}
> +
> +static void stop_suspend_mon(void)
> +{
> +	mutex_lock(&suspend_mon_lock);
> +	suspend_mon_toggle = TOGGLE_STOP;
> +	mutex_unlock(&suspend_mon_lock);
> +	wake_up(&power_suspend_waitqueue);
> +}
> +
> +static void suspend_timeout(int timeout_count)
> +{
> +	char *null_pointer = NULL;
> +
> +	pr_info("Suspend monitor timeout (timer is %d seconds)\n",
> +		(SUSPEND_TIMER_TIMEOUT_MS/1000));
> +
> +	show_state_filter(TASK_UNINTERRUPTIBLE);
> +
> +	if (timeout_count < 2)
> +		return;
> +
> +	if (is_console_suspended())
> +		resume_console();
> +
> +	pr_info("Trigger a panic\n");

Again, debugging code?

> +
> +	/* Trigger a NULL pointer dereference */
> +	*null_pointer = 'a';

Are you sure this will work on all platforms?  We do have a panic
function if you really want to do that.

> +
> +	/* Should not reach here */
> +	pr_err("Trigger panic failed!\n");
> +}
> +
> +static int suspend_monitor_kthread(void *arg)
> +{
> +	long err;
> +	struct sched_param param = {.sched_priority
> +		= MAX_RT_PRIO-1};

Ick, no, call the scheduler functions properly, don't do this "by hand"
ever.

> +	static int timeout_count;
> +	static long timeout;
> +
> +	pr_info("Init ksuspend_mon thread\n");

Again, debugging code :(

> +
> +	sched_setscheduler(current, SCHED_FIFO, &param);
> +
> +	timeout_count = 0;
> +	timeout = MAX_SCHEDULE_TIMEOUT;
> +
> +	do {
> +		/* Wait suspend timer timeout */
> +		err = wait_event_interruptible_timeout(
> +			power_suspend_waitqueue,
> +			(suspend_mon_toggle != TOGGLE_NONE),
> +			timeout);
> +
> +		mutex_lock(&suspend_mon_lock);
> +		/* suspend monitor state change */
> +		if (suspend_mon_toggle != TOGGLE_NONE) {
> +			if (suspend_mon_toggle == TOGGLE_START) {
> +				timeout = msecs_to_jiffies(
> +					SUSPEND_TIMER_TIMEOUT_MS);
> +				pr_info("Start suspend monitor\n");
> +			} else if (suspend_mon_toggle == TOGGLE_STOP) {
> +				timeout = MAX_SCHEDULE_TIMEOUT;
> +				timeout_count = 0;
> +				pr_info("Stop suspend monitor\n");
> +			}
> +			suspend_mon_toggle = TOGGLE_NONE;
> +			mutex_unlock(&suspend_mon_lock);
> +			continue;
> +		}
> +		mutex_unlock(&suspend_mon_lock);
> +
> +		/* suspend monitor event handler */
> +		if (err == 0) {
> +			timeout_count++;
> +			suspend_timeout(timeout_count);
> +		} else if (err == -ERESTARTSYS) {
> +			pr_info("Exit ksuspend_mon!");
> +			break;
> +		}
> +	} while (1);
> +
> +	return 0;
> +}
> +
> +static void init_suspend_monitor_thread(void)
> +{
> +	int ret;
> +
> +	ksuspend_mon_tsk = kthread_create(suspend_monitor_kthread,
> +		NULL, "ksuspend_mon");
> +	if (IS_ERR(ksuspend_mon_tsk)) {
> +		ret = PTR_ERR(ksuspend_mon_tsk);
> +		ksuspend_mon_tsk = NULL;
> +		pr_err("Create suspend_monitor_kthread failed! ret = %d\n",
> +			ret);
> +		return;
> +	}
> +
> +	suspend_mon_toggle = TOGGLE_NONE;
> +	wake_up_process(ksuspend_mon_tsk);
> +
> +}
> +#endif
> +
>  /**
>   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
>   *
> @@ -89,6 +222,10 @@ static void s2idle_enter(void)
>  {
>  	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
>  
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +	stop_suspend_mon();
> +#endif

Do not put #ifdef in .c files, that's not the proper kernel coding
style.  Especially for single function calls.

I've stopped here...

greg k-h
