Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625992935DC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgJTHfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 03:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgJTHfJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 03:35:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F7A22242;
        Tue, 20 Oct 2020 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603179308;
        bh=7c5tNsP80/p2MClrPz8smyz815OvdBDNUOhglxHODvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZSegkpU99bRsYcoFQZmQHiAVZDempjfzTfMwRIwl4Zd/OyHWPrBQiyYydB2/KD2T
         BzvwmjFvWMrWimgcuMuM+Mw953HpzZ3HVlRJGWF72uR/B0iTCeW5EbajwHxQh8y29+
         ICPk6CLLt8B9IpOQm6Ni+oCaXkJq+M1oCNmR8hl0=
Date:   Tue, 20 Oct 2020 09:35:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Add sleep timer and timeout handler
Message-ID: <20201020073551.GD3803984@kroah.com>
References: <20201020062226.1457732-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020062226.1457732-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 02:22:26PM +0800, Joseph Jang wrote:
> Add sleep timer and timeout handler to prevent device stuck during suspend/
> resume process. The timeout handler will dump disk sleep task at first
> round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> 
> Signed-off-by: Joseph Jang <josephjang@google.com>
> ---
>  MAINTAINERS                   |  2 +
>  include/linux/console.h       |  1 +
>  include/linux/suspend_timer.h | 90 +++++++++++++++++++++++++++++++++++

Why is this file in include/linux/ if you only ever call it from one .c
file?

> --- /dev/null
> +++ b/include/linux/suspend_timer.h
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
> +#else
> +#define DECLARE_SLEEP_TIMER(st)
> +#define init_sleep_timer(x, y)
> +#define start_sleep_timer(x)
> +#define stop_sleep_timer(x)
> +#endif
> +
> +#endif /* _LINUX_SLEEP_TIMER_H */
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..9e2b274db0c1 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -207,6 +207,21 @@ config PM_SLEEP_DEBUG
>  	def_bool y
>  	depends on PM_DEBUG && PM_SLEEP
>  
> +config PM_SLEEP_MONITOR
> +	bool "Linux kernel suspend/resume process monitor"
> +	depends on PM_SLEEP
> +	help
> +	This option will enable sleep timer to prevent device stuck
> +	during suspend/resume process. Sleep timeout handler will dump
> +	disk sleep task at first round timeout and trigger kernel panic
> +	at second round timeout. The timer for each round is defined in
> +	CONFIG_PM_SLEEP_TIMER_TIMEOUT.

I thought we already had a watchdog for all of this, why not just always
add this to that code, for that config option?

And why isn't the watchdog sufficient for you?  Why are you "open
coding" a watchdog timer logic here at all???

thanks,

greg k-h
