Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969AD19D3E0
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbgDCJiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 05:38:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51617 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCJiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 05:38:24 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 76b677d628e2c161; Fri, 3 Apr 2020 11:38:22 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, robh@kernel.org,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/4] powercap/drivers/idle_inject: Specify idle state max latency
Date:   Fri, 03 Apr 2020 11:38:22 +0200
Message-ID: <2577452.sm1PKieV59@kreacher>
In-Reply-To: <20200329220324.8785-1-daniel.lezcano@linaro.org>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, March 30, 2020 12:03:17 AM CEST Daniel Lezcano wrote:
> Currently the idle injection framework uses the play_idle() function
> which puts the current CPU in an idle state. The idle state is the
> deepest one, as specified by the latency constraint when calling the
> subsequent play_idle_precise() function with the INT_MAX.
> 
> The idle_injection is used by the cpuidle_cooling device which
> computes the idle / run duration to mitigate the temperature by
> injecting idle cycles. The cooling device has no control on the depth
> of the idle state.
> 
> Allow finer control of the idle injection mechanism by allowing to
> specify the latency for the idle state. Thus the cooling device has
> the ability to have a guarantee on the exit latency of the idle states
> it is injecting.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And I'm assuming that you will take care of the series yourself.

> ---
>   - V2:
>     - Remove the get_latency helper
> 
> ---
>  drivers/powercap/idle_inject.c | 16 +++++++++++++++-
>  include/linux/idle_inject.h    |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..49f42c475620 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -61,12 +61,14 @@ struct idle_inject_thread {
>   * @timer: idle injection period timer
>   * @idle_duration_us: duration of CPU idle time to inject
>   * @run_duration_us: duration of CPU run time to allow
> + * @latency_us: max allowed latency
>   * @cpumask: mask of CPUs affected by idle injection
>   */
>  struct idle_inject_device {
>  	struct hrtimer timer;
>  	unsigned int idle_duration_us;
>  	unsigned int run_duration_us;
> +	unsigned int latency_us;
>  	unsigned long int cpumask[0];
>  };
>  
> @@ -138,7 +140,8 @@ static void idle_inject_fn(unsigned int cpu)
>  	 */
>  	iit->should_run = 0;
>  
> -	play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
> +			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
>  }
>  
>  /**
> @@ -169,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>  
> +/**
> + * idle_inject_set_latency - set the maximum latency allowed
> + * @latency_us: set the latency requirement for the idle state
> + */
> +void idle_inject_set_latency(struct idle_inject_device *ii_dev,
> +			     unsigned int latency_us)
> +{
> +	WRITE_ONCE(ii_dev->latency_us, latency_us);
> +}
> +
>  /**
>   * idle_inject_start - start idle injections
>   * @ii_dev: idle injection control device structure
> @@ -297,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>  	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>  	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	ii_dev->timer.function = idle_inject_timer_fn;
> +	ii_dev->latency_us = UINT_MAX;
>  
>  	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>  
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index a445cd1a36c5..91a8612b8bf9 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -26,4 +26,8 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  				 unsigned int *run_duration_us,
>  				 unsigned int *idle_duration_us);
> +
> +void idle_inject_set_latency(struct idle_inject_device *ii_dev,
> +			     unsigned int latency_ns);
> +
>  #endif /* __IDLE_INJECT_H__ */
> 




