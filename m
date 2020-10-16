Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C629005C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394143AbgJPJBM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 05:01:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391070AbgJPJBL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 05:01:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602838869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvmgJYrPfDkJmNrTnzLB9ylTxrjfM8Kvwfsy9nroC+8=;
        b=WZcljI8PQ7btAvIS1SycIt5IezMG5DIVCZtvLDiP1y8o+dZgwJrCEVQeMBulntEDiO0pA0
        ph/uqT12pS9UQh5kyqt0jGbhsSOY5zi/vvVGeFMJCrrJGzmnnDpPif2qdtgpbYorE18DSt
        gUxubKk2nwWjs0T9toKHMaj5JBM3wjs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CE67ADE4;
        Fri, 16 Oct 2020 09:01:09 +0000 (UTC)
Date:   Fri, 16 Oct 2020 11:01:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joseph Jang <josephjang@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
Message-ID: <20201016090108.GG8871@alley>
References: <20201016035109.3952356-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016035109.3952356-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 2020-10-16 11:51:09, Joseph Jang wrote:
> From: josephjang <josephjang@google.com>
> 
> Add suspend timeout handler to prevent device stuck during suspend/
> resume process. Suspend timeout handler will dump disk sleep task
> at first round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is 30 seconds.

A better solution would be to resume instead of panic().

> Note: Can use following command to simulate suspend hang for testing.
>     adb shell echo 1 > /sys/power/pm_hang

This looks dangerous. It adds a simple way to panic() the system.

First, it should get enabled separately. e.g.
CONFIG_TEST_PM_SLEEP_MONITOR.

Second, I would add it as a module that might get loaded
and unloaded.

> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> +static int suspend_monitor_kthread(void *arg)
> +{
> +	long err;
> +	struct sched_param param = {.sched_priority
> +		= MAX_RT_PRIO-1};
> +	static int timeout_count;
> +	static long timeout;
> +
> +	pr_info("Init ksuspend_mon thread\n");
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

Using kthread looks like an overkill to me. I wonder how this actually
works when the kthreads get freezed. It might be enough to implement
just a timer callback. Start the timer in start_suspend_mon() and
delete it in stop_suspend_mon(). Or do I miss anything?

Anyway, the kthread implementation looks a but hairy. If you really
need to use kthread, I suggest to use kthread_worker API. You would
need to run an init work to setup the RT scheduling. Then you
could just call kthread_queue_delayed_work(()
and kthread_cancel_delayed_work_sync() to start and stop
the monitor.


> @@ -114,6 +251,10 @@ static void s2idle_enter(void)
>  	s2idle_state = S2IDLE_STATE_NONE;
>  	raw_spin_unlock_irq(&s2idle_lock);
>  
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +	start_suspend_mon();
> +#endif

It is better to solve this by defining start_suspend_mon() as empty
function when the config option is disabled. For example, see
how  vgacon_text_force() is defined in console.h.

Best Regards,
Petr
