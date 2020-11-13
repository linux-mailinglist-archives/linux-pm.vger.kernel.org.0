Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74A2B1BDB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 14:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMN0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 08:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMN0u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Nov 2020 08:26:50 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224582085B;
        Fri, 13 Nov 2020 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605274010;
        bh=4D0ahYLTZxsJtWjIbinnoD0UIw6jAVKTgLXRj5ERKV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVOrcj+e2KMk9DGMATlljUKvkwErHI6ryG5wzpLUZDo/9UWrd1ZRCxAqcGiMR7cVT
         qoHvCC/8xbbfaDmPUeo7mkFslZp/Y6Pq/KVN+EWxipEUDsPt2o60xKOsZmcrrE5Wq5
         QuDyq6nR65GMLYXzAMsqZnKSpkDN3KzIFdgcyxWI=
Date:   Fri, 13 Nov 2020 14:27:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH v3] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
Message-ID: <X66J0plvSKqFbDIy@kroah.com>
References: <20201023060417.517246-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023060417.517246-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 02:04:17PM +0800, Joseph Jang wrote:
> Since dpm_watchdog just cover device power management, we proposed to
> move it to core power suspend.c to cover not only device power management
> hang issues, but also core power management hand issues.
> 
> Since dpm_watchdog stands for device pm, we propose to use new name sleep
> timer and new timeout handler to cover more sleep hang issues. The new
> timeout handler will dump disk sleep task at first round timeout and
> trigger kernel panic at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> 
> Signed-off-by: Joseph Jang <josephjang@google.com>

It still seems odd you can't use a watchdog for this, as you really have
just implemented the same thing here, but "open coded" the logic.

I'll let Rafael chime in here too, as he knows this area much better
than I as to if this is viable or not.

Some coding comments:

> diff --git a/include/linux/console.h b/include/linux/console.h
> index 0670d3491e0e..5436d8dc600f 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
>  { }
>  #endif
>  extern bool console_suspend_enabled;
> +extern int console_is_suspended(void);

Why do you care about the console?  This feels like it should be
separate and agreed upon by others as to if this is ok to get access to
or not.

>  
>  /* Suspend and resume console messages over PM events */
>  extern void suspend_console(void);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..fa021837473b 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -207,21 +207,20 @@ config PM_SLEEP_DEBUG
>  	def_bool y
>  	depends on PM_DEBUG && PM_SLEEP
>  
> -config DPM_WATCHDOG
> -	bool "Device suspend/resume watchdog"
> -	depends on PM_DEBUG && PSTORE && EXPERT
> +config PM_SLEEP_MONITOR
> +	bool "Linux kernel suspend/resume process monitor"
> +	depends on PM_SLEEP
>  	help
> -	  Sets up a watchdog timer to capture drivers that are
> -	  locked up attempting to suspend/resume a device.
> -	  A detected lockup causes system panic with message
> -	  captured in pstore device for inspection in subsequent
> -	  boot session.
> -
> -config DPM_WATCHDOG_TIMEOUT
> -	int "Watchdog timeout in seconds"
> -	range 1 120
> -	default 120
> -	depends on DPM_WATCHDOG
> +	This option will enable sleep timer to prevent device stuck
> +	during suspend/resume process. Sleep timeout handler will dump
> +	disk sleep task at first round timeout and trigger kernel panic
> +	at second round timeout. The timer for each round is defined in
> +	CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> +
> +config PM_SLEEP_TIMER_TIMEOUT
> +	int "Sleep timer timeout in seconds"
> +	range 30 120
> +	depends on PM_SLEEP_MONITOR
>  
>  config PM_TRACE
>  	bool
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8b1bb5ee7e5d..0272494e0d0e 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -32,6 +32,7 @@
>  #include <linux/moduleparam.h>
>  
>  #include "power.h"
> +#include "suspend_timer.h"
>  
>  const char * const pm_labels[] = {
>  	[PM_SUSPEND_TO_IDLE] = "freeze",
> @@ -61,6 +62,8 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>  
> +DECLARE_SLEEP_TIMER(st);

Why is this not static?  "st" is a very bad name for a global symbol in
the kernel namespace :(


> --- /dev/null
> +++ b/kernel/power/suspend_timer.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SLEEP_TIMER_H
> +#define _LINUX_SLEEP_TIMER_H
> +
> +#include <linux/sched/debug.h>
> +
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +struct sleep_timer {
> +	struct task_struct	*tsk;
> +	struct timer_list	timer;
> +};
> +
> +#define DECLARE_SLEEP_TIMER(st) \
> +	struct sleep_timer st
> +
> +/**
> + * init_sleep_timer - Initialize sleep timer.
> + * @st: Sleep timer to initialize.
> + * @func: Sleep timer timeout handler.
> + */
> +static void init_sleep_timer(struct sleep_timer *st, void (*func))
> +{
> +	struct timer_list *timer = &st->timer;
> +
> +	timer_setup(timer, func, 0);
> +}
> +
> +/**
> + * start_sleep_timer - Enable sleep timer to monitor suspend thread.
> + * @st: Sleep timer to enable.
> + */
> +static void start_sleep_timer(struct sleep_timer *st)
> +{
> +	struct timer_list *timer = &st->timer;
> +
> +	st->tsk = current;
> +
> +	/* use same timeout value for both suspend and resume */
> +	timer->expires = jiffies + HZ * CONFIG_PM_SLEEP_TIMER_TIMEOUT;
> +	add_timer(timer);
> +}
> +
> +/**
> + * stop_sleep_timer - Disable sleep timer.
> + * @st: sleep timer to disable.
> + */
> +static void stop_sleep_timer(struct sleep_timer *st)
> +{
> +	struct timer_list *timer = &st->timer;
> +
> +	del_timer_sync(timer);
> +}
> +
> +/**
> + * sleep_timeout_handler - sleep timer timeout handler.
> + * @t: The timer list that sleep timer depends on.
> + *
> + * Called when suspend thread has timeout suspending or resuming.
> + * Dump all uninterruptible tasks' call stack and call panic() to
> + * reboot system in second round timeout.
> + */
> +static void sleep_timeout_handler(struct timer_list *t)
> +{
> +	struct sleep_timer *st = from_timer(st, t, timer);
> +	static int timeout_count;
> +
> +	pr_info("Sleep timeout (timer is %d seconds)\n",
> +		(CONFIG_PM_SLEEP_TIMER_TIMEOUT));
> +	show_stack(st->tsk, NULL, KERN_EMERG);
> +	show_state_filter(TASK_UNINTERRUPTIBLE);
> +
> +	if (timeout_count < 1) {
> +		timeout_count++;
> +		start_sleep_timer(st);
> +		return;
> +	}
> +
> +	if (console_is_suspended())
> +		resume_console();
> +
> +	panic("Sleep timeout and panic\n");
> +}

You have a lot of logic in a .h file, that should all be in a .c file.

Just put the function prototypes in here and put the real logic in a .c
file, and only link that in if the config option is enabled.  As it is,
this isn't ok no matter what.


> +#else
> +#define DECLARE_SLEEP_TIMER(st)
> +#define init_sleep_timer(x, y)
> +#define start_sleep_timer(x)
> +#define stop_sleep_timer(x)

Use inline functions so you get proper type checking, not #define.


> +#endif
> +
> +#endif /* _LINUX_SLEEP_TIMER_H */
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9b75f6bfc333..488cbc9abaaf 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2259,6 +2259,11 @@ module_param_named(console_suspend, console_suspend_enabled,
>  MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
>  	" and hibernate operations");
>  
> +int console_is_suspended(void)
> +{
> +	return console_suspended;
> +}

Again, I don't think this is ok.  What happens if this changes _right_
after you check it?  Why does it matter?

thanks,

greg k-h
