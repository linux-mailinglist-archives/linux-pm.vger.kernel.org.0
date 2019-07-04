Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2665F668
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGDKOH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 06:14:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59358 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfGDKOH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 06:14:07 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id daa413db94795919; Thu, 4 Jul 2019 12:14:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle/drivers/mobile: Add new governor for mobile/embedded systems
Date:   Thu, 04 Jul 2019 12:14:05 +0200
Message-ID: <8334994.XHaO1tGd4f@kreacher>
In-Reply-To: <20190620115826.4897-1-daniel.lezcano@linaro.org>
References: <20190620115826.4897-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, June 20, 2019 1:58:08 PM CEST Daniel Lezcano wrote:
> The objective is the same for all the governors: save energy, but at
> the end the governors menu, ladder and teo aim to improve the
> performances with an acceptable energy drop for some workloads which
> are identified for servers and desktops (with the help of a firmware).
> 
> The ladder governor is designed for server with a periodic tick
> configuration.
> 
> The menu governor does not behave nicely with the mobile platform and
> the energy saving for the multimedia workloads is worst than picking
> up randomly an idle state.
> 
> The teo governor acts efficiently, it promotes shallower state for
> performances which is perfect for the servers / desktop but inadequate
> for mobile because the energy consumed is too high.
> 
> It is very difficult to do changes in these governors for embedded
> systems without impacting performances on servers/desktops or ruin the
> optimizations for the workloads on these platforms.
> 
> The mobile governor is a new governor targeting embedded systems
> running on battery where the energy saving has a higher priority than
> servers or desktops. This governor aims to save energy as much as
> possible but with a performance degradation tolerance.
> 
> In this way, we can optimize the governor for specific mobile workload
> and more generally embedded systems without impacting other platforms.
> 
> The mobile governor is built on top of the paradigm 'separate the wake
> up sources signals and analyze them'. Three categories of wake up
> signals are identified:
>  - deterministic : timers
>  - predictable : most of the devices interrupt
>  - unpredictable : IPI rescheduling, random signals
> 
> The latter needs an iterative approach and the help of the scheduler
> to give more input to the governor.
> 
> The governor uses the irq timings where we predict the next interrupt
> occurrences on the current CPU and the next timer. It is well suited
> for mobile and more generally embedded systems where the interrupts
> are usually pinned on one CPU and where the power is more important
> than the performances.
> 
> The multimedia applications on the embedded system spawn multiple
> threads which are migrated across the different CPUs and waking
> between them up. In order to catch this situation we have also to
> track the idle task rescheduling duration with a relative degree of
> confidence as the scheduler is involved in the task migrations. The
> resched information is in the scope of the governor via the reflect
> callback.
> 
> The governor begins with a clean foundation basing the prediction on
> the irq behavior returned by the irq timings, the timers and the idle
> task rescheduling. The advantage of the approach is we have a full
> view of the wakeup sources as we identify them separately and then we
> can control the situation without relying on biased heuristics.
> 
> This first iteration provides a basic prediction but improves on some
> mobile platforms better energy for better performance for multimedia
> workloads.
> 
> The scheduling aspect will be optimized iteratively with non
> regression testing for previous identified workloads on an Android
> reference platform.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Note that there are build issues reported by 0-day that need to be fixed.

Also, IMO this really should be documented better in the tree, not just in the changelog.
At least the use case to be covered by this governor should be clearly documented and
it would be good to describe the algorithm.

> ---
>  drivers/cpuidle/Kconfig            |  11 ++-
>  drivers/cpuidle/governors/Makefile |   1 +
>  drivers/cpuidle/governors/mobile.c | 151 +++++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpuidle/governors/mobile.c
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index a4ac31e4a58c..e2376d85e288 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -5,7 +5,7 @@ config CPU_IDLE
>  	bool "CPU idle PM support"
>  	default y if ACPI || PPC_PSERIES
>  	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
> -	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO
> +	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO && !CPU_IDLE_GOV_MOBILE
>  	help
>  	  CPU idle is a generic framework for supporting software-controlled
>  	  idle processor power management.  It includes modular cross-platform
> @@ -33,6 +33,15 @@ config CPU_IDLE_GOV_TEO
>  	  Some workloads benefit from using it and it generally should be safe
>  	  to use.  Say Y here if you are not happy with the alternatives.
>  
> +config CPU_IDLE_GOV_MOBILE
> +	bool "Mobile governor"
> +	select IRQ_TIMINGS
> +	help
> +	  The mobile governor is based on irq timings measurements and
> +	  pattern research combined with the next timer. This governor
> +	  suits very well on embedded systems where the interrupts are
> +	  grouped on a single core and the power is the priority.
> +
>  config DT_IDLE_STATES
>  	bool
>  
> diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
> index 42f44cc610dd..f09da7178670 100644
> --- a/drivers/cpuidle/governors/Makefile
> +++ b/drivers/cpuidle/governors/Makefile
> @@ -6,3 +6,4 @@
>  obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
>  obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
>  obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
> +obj-$(CONFIG_CPU_IDLE_GOV_MOBILE) += mobile.o
> diff --git a/drivers/cpuidle/governors/mobile.c b/drivers/cpuidle/governors/mobile.c
> new file mode 100644
> index 000000000000..8fda0f9b960b
> --- /dev/null
> +++ b/drivers/cpuidle/governors/mobile.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019, Linaro Ltd
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + */
> +#include <linux/cpuidle.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/tick.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched/clock.h>
> +
> +struct mobile_device {
> +	u64 idle_ema_avg;
> +	u64 idle_total;
> +	unsigned long last_jiffies;
> +};
> +
> +#define EMA_ALPHA_VAL		64
> +#define EMA_ALPHA_SHIFT		7
> +#define MAX_RESCHED_INTERVAL_MS	100
> +
> +static DEFINE_PER_CPU(struct mobile_device, mobile_devices);
> +
> +static int mobile_ema_new(s64 value, s64 ema_old)
> +{
> +	if (likely(ema_old))
> +		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
> +				  EMA_ALPHA_SHIFT);
> +	return value;
> +}
> +
> +static void mobile_reflect(struct cpuidle_device *dev, int index)
> +{
> +        struct mobile_device *mobile_dev = this_cpu_ptr(&mobile_devices);
> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +	struct cpuidle_state *s = &drv->states[index];
> +	int residency;
> +
> +	/*
> +	 * The idle task was not rescheduled since
> +	 * MAX_RESCHED_INTERVAL_MS, let's consider the duration is
> +	 * long enough to clear our stats.
> +	 */
> +	if (time_after(jiffies, mobile_dev->last_jiffies +
> +		       msecs_to_jiffies(MAX_RESCHED_INTERVAL_MS)))
> +		mobile_dev->idle_ema_avg = 0;

Why jiffies?  Any particular reason?

> +
> +	/*
> +	 * Sum all the residencies in order to compute the total
> +	 * duration of the idle task.
> +	 */
> +	residency = dev->last_residency - s->exit_latency;
> +	if (residency > 0)
> +		mobile_dev->idle_total += residency;
> +
> +	/*
> +	 * We exited the idle state with the need_resched() flag, the
> +	 * idle task will be rescheduled, so store the duration the
> +	 * idle task was scheduled in an exponential moving average and
> +	 * reset the total of the idle duration.
> +	 */
> +	if (need_resched()) {
> +		mobile_dev->idle_ema_avg = mobile_ema_new(mobile_dev->idle_total,
> +						      mobile_dev->idle_ema_avg);
> +		mobile_dev->idle_total = 0;
> +		mobile_dev->last_jiffies = jiffies;
> +	}
> +}
> +
> +static int mobile_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> +		       bool *stop_tick)
> +{
> +	struct mobile_device *mobile_dev = this_cpu_ptr(&mobile_devices);
> +	int latency_req = cpuidle_governor_latency_req(dev->cpu);
> +	int i, index = 0;
> +	ktime_t delta_next;
> +	u64 now, irq_length, timer_length;
> +	u64 idle_duration_us;
> +
> +	/*
> +	 * Get the present time as reference for the next steps
> +	 */
> +	now = local_clock();
> +
> +	/*
> +	 * Get the next interrupt event giving the 'now' as a
> +	 * reference, if the next event appears to have already
> +	 * expired then we get the 'now' returned which ends up with a
> +	 * zero duration.
> +	 */
> +	irq_length = irq_timings_next_event(now) - now;
> +
> +	/*
> +	 * Get the timer duration before expiration.
> +	 */

This comment is rather redundant and the one below too. :-)

> +	timer_length = ktime_to_ns(tick_nohz_get_sleep_length(&delta_next));
> +
> +	/*
> +	 * Get the smallest duration between the timer and the irq next event.
> +	 */
> +	idle_duration_us = min_t(u64, irq_length, timer_length) / NSEC_PER_USEC;
> +
> +	/*
> +	 * Get the idle task duration average if the information is
> +	 * available.

IMO it would be good to explain this step in more detail, especially the purpose of it.

> +	 */
> +	if (mobile_dev->idle_ema_avg)
> +		idle_duration_us = min_t(u64, idle_duration_us,
> +					 mobile_dev->idle_ema_avg);
> +
> +	for (i = 0; i < drv->state_count; i++) {
> +		struct cpuidle_state *s = &drv->states[i];
> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
> +
> +		if (s->disabled || su->disable)
> +			continue;
> +
> +		if (s->exit_latency > latency_req)
> +			break;
> +
> +		if (idle_duration_us > s->exit_latency)
> +			idle_duration_us = idle_duration_us - s->exit_latency;

Why do you want this?

It only causes you to miss an opportunity to select a deeper state sometimes,
so what's the reason?

Moreover, I don't think you should update idle_duration_us here, as the updated
value will go to the next step if the check below doesn't trigger.

> +
> +		if (s->target_residency > idle_duration_us)
> +			break;
> +
> +		index = i;
> +	}
> +
> +	if (!index)
> +		*stop_tick = false;

Well, this means that the tick is stopped for all idle states deeper than state 0.

If there are any states between state 0 and the deepest one and they are below
the tick boundary, you may very well suffer the "powernightmares" problem
because of this.

> +
> +	return index;
> +}
> +
> +static struct cpuidle_governor mobile_governor = {
> +	.name =		"mobile",
> +	.rating =	20,
> +	.select =	mobile_select,
> +	.reflect =	mobile_reflect,
> +};
> +
> +static int __init init_governor(void)
> +{
> +	irq_timings_enable();
> +	return cpuidle_register_governor(&mobile_governor);
> +}
> +
> +postcore_initcall(init_governor);
> 




