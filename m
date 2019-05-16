Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC90C20761
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEPMz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 08:55:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44838 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfEPMz4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 08:55:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10B41715;
        Thu, 16 May 2019 05:55:55 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9997F3F703;
        Thu, 16 May 2019 05:55:54 -0700 (PDT)
Date:   Thu, 16 May 2019 13:55:52 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     douglas.raillard@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 6/7] sched/cpufreq: Improve sugov_cpu_is_busy accuracy
Message-ID: <20190516125552.hol3rasllhveekxq@e110439-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-7-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508174301.4828-7-douglas.raillard@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-May 18:43, douglas.raillard@arm.com wrote:
> From: Douglas RAILLARD <douglas.raillard@arm.com>
> 
> Avoid assuming a CPU is busy when it has begun being idle before
> get_next_freq() is called. This is achieved by making sure the CPU will
> not be detected as busy by other CPUs whenever its utilization is
> decreasing.

If I understand it correctly, what you are after here is a "metric"
which tells you (in a shared performance domain) if a CPU has been
busy for a certain amount of time.
You do that by reworking the way idle_calls are accounted for the
sugov_update_single() case.

That approach could work but it looks a bit convoluted in the way it's
coded and it's also difficult to exclude there could be corner cases
with wired behaviors.
Isn't that why you "fix" the saved_idle_calls counter after all?

What about a different approach where we:

1. we annotate the timestamp a CPU wakes up from IDLE (last_wakeup_time)

2. we use that annotated last_wake_time and the rq->nr_running to
   define the "cpu is busy" heuristic.

Looking at a sibling CPU, I think we can end up with two main cases:

1. CPU's nr_running is == 0
   then we don't consider busy that CPU

2. CPU's nr_running is  > 0
   then the CPU is busy iff
      (current_time - last_wakeup_tim) >= busy_threshold

Notice that, when a CPU is active, its rq clock is periodically
updated, at least once per tick. Thus, provided a tick time is not too
long to declare busy a CPU, then the above logic should work.

Perhaps the busy_threshold can also be defined considering the PELT
dynamics and starting from an expected utilization increase converted
in time.

Could something like to above work or am I missing something?

> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 42 ++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a12b7e5bc028..ce4b90cafbb5 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -62,6 +62,7 @@ struct sugov_cpu {
>  	/* The field below is for single-CPU policies only: */
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned long		saved_idle_calls;
> +	unsigned long		previous_util;
>  #endif
>  };
>  
> @@ -181,14 +182,35 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
>  	return ret;
>  }
>  
> -static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu)
> +static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu,
> +				     unsigned long util)
>  {
>  	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
>  	sg_cpu->saved_idle_calls = idle_calls;
> +
> +	/*
> +	 * Make sure that this CPU will not be immediately considered as busy in
> +	 * cases where the CPU has already entered an idle state. In that case,
> +	 * the number of idle_calls will not vary anymore until it exits idle,
> +	 * which would lead sugov_cpu_is_busy() to say that this CPU is busy,
> +	 * because it has not (re)entered idle since the last time we looked at
> +	 * it.
> +	 * Assuming cpu0 and cpu1 are in the same policy, that will make sure
> +	 * this sequence of events leads to right cpu1 business status from
> +	 * get_next_freq(cpu=1)
> +	 * cpu0: [enter idle] -> [get_next_freq] -> [doing nothing] -> [wakeup]
> +	 * cpu1:                ...              -> [get_next_freq] ->   ...
> +	 */
> +	if (util <= sg_cpu->previous_util)
> +		sg_cpu->saved_idle_calls--;
> +
> +	sg_cpu->previous_util = util;
>  }
>  #else
>  static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> -static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu) {}
> +static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu
> +				     unsigned long util)
> +{}
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  /**
> @@ -507,10 +529,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	if (!sugov_should_update_freq(sg_policy, time))
>  		return;
>  
> -	busy = sugov_cpu_is_busy(sg_cpu);
> -	sugov_cpu_is_busy_update(sg_cpu);
> -
>  	util = sugov_get_util(sg_cpu);
> +	busy = sugov_cpu_is_busy(sg_cpu);
> +	sugov_cpu_is_busy_update(sg_cpu, util);
>  	max = sg_cpu->max;
>  	util = sugov_iowait_apply(sg_cpu, time, util, max);
>  	next_f = get_next_freq(sg_policy, util, max);
> @@ -545,12 +566,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned long util = 0, max = 1;
>  	unsigned int j;
> +	unsigned long sg_cpu_util = 0;
>  
>  	for_each_cpu(j, policy->cpus) {
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>  		unsigned long j_util, j_max;
>  
>  		j_util = sugov_get_util(j_sg_cpu);
> +		if (j_sg_cpu == sg_cpu)
> +			sg_cpu_util = j_util;
>  		j_max = j_sg_cpu->max;
>  		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
>  
> @@ -560,6 +584,14 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		}
>  	}
>  
> +	/*
> +	 * Only update the business status if we are looking at the CPU for
> +	 * which a utilization change triggered a call to get_next_freq(). This
> +	 * way, we don't affect the "busy" status of CPUs that don't have any
> +	 * change in utilization.
> +	 */
> +	sugov_cpu_is_busy_update(sg_cpu, sg_cpu_util);
> +
>  	return get_next_freq(sg_policy, util, max);
>  }
>  
> -- 
> 2.21.0
> 

-- 
#include <best/regards.h>

Patrick Bellasi
