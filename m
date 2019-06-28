Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E351859E6E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1PJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 11:09:04 -0400
Received: from foss.arm.com ([217.140.110.172]:49774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1PJD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 11:09:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D32B62B;
        Fri, 28 Jun 2019 08:09:02 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 989CD3F706;
        Fri, 28 Jun 2019 08:09:01 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:08:59 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 4/5] sched/cpufreq: Introduce sugov_cpu_ramp_boost
Message-ID: <20190628150859.e6dhb2hxnmtshpwb@e110439-lin>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190627171603.14767-5-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627171603.14767-5-douglas.raillard@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Douglas,

On 27-Jun 18:16, Douglas RAILLARD wrote:
> Use the utilization signals dynamic to detect when the utilization of a
> set of tasks starts increasing because of a change in tasks' behavior.
> This allows detecting when spending extra power for faster frequency
> ramp up response would be beneficial to the reactivity of the system.
> 
> This ramp boost is computed as the difference
> util_avg-util_est_enqueued. This number somehow represents a lower bound
> of how much extra utilization this tasks is actually using, compared to
> our best current stable knowledge of it (which is util_est_enqueued).

Maybe it's worth to call out here that at rq-level we don't have an
EWMA. However, the enqueued estimated utilization is derived by
considering the _task_util_est() which factors in the moving average
of tasks and thus makes the signal more stable even in case of tasks
switching between big and small activations.

> When the set of runnable tasks changes, the boost is disabled as the
> impact of blocked utilization on util_avg will make the delta with
> util_est_enqueued not very informative.
> 
> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7ffc6fe3b670..3eabfd815195 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -60,6 +60,9 @@ struct sugov_cpu {
>  	unsigned long		bw_dl;
>  	unsigned long		max;
>  
> +	unsigned long		ramp_boost;
> +	unsigned long		util_est_enqueued;
> +
>  	/* The field below is for single-CPU policies only: */
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned long		saved_idle_calls;
> @@ -174,6 +177,41 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>  	}
>  }
>  
> +static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
> +{
> +	return READ_ONCE(sg_cpu->ramp_boost);
> +}
> +
> +static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu,
> +						 unsigned long util)
> +{
> +	struct rq *rq = cpu_rq(sg_cpu->cpu);

Since you don't really need the rq below, maybe better:

        struct sched_avg *sa = &cpu_rq(sg_cpu->cpu)->cfs.avg;

?

> +	unsigned long util_est_enqueued;
> +	unsigned long util_avg;
> +	unsigned long boost = 0;
> +
> +	util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);
> +	util_avg = READ_ONCE(rq->cfs.avg.util_avg);
> +
> +	/*
> +	 * Boost when util_avg becomes higher than the previous stable
> +	 * knowledge of the enqueued tasks' set util, which is CPU's
> +	 * util_est_enqueued.
> +	 *
> +	 * We try to spot changes in the workload itself, so we want to
> +	 * avoid the noise of tasks being enqueued/dequeued. To do that,
> +	 * we only trigger boosting when the "amount of work' enqueued
> +	 * is stable.
> +	 */
> +	if (util_est_enqueued == sg_cpu->util_est_enqueued
> +	    && util_avg > util_est_enqueued)
> +		 boost = util_avg - util_est_enqueued;

The above should be:


 	if (util_est_enqueued == sg_cpu->util_est_enqueue &&
            util_avg > util_est_enqueued) {
 		 boost = util_avg - util_est_enqueued;
        }

but perhaps you can also go for a fast bailout with something like:

        if (util_avg <= util_est_enqueued)
                return 0;
        if (util_est_enqueued == sg_cpu->util_est_enqueue)
                boost = util_avg - util_est_enqueued;


Moreover: could it make sense to add a threshold on a minimal boost
value to return non zero?

> +
> +	sg_cpu->util_est_enqueued = util_est_enqueued;
> +	WRITE_ONCE(sg_cpu->ramp_boost, boost);
> +	return boost;

You don't seem to use this returned value: should be void?

> +}
> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -504,6 +542,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	busy = sugov_cpu_is_busy(sg_cpu);
>  
>  	util = sugov_get_util(sg_cpu);
> +	sugov_cpu_ramp_boost_update(sg_cpu, util);
>  	max = sg_cpu->max;
>  	util = sugov_iowait_apply(sg_cpu, time, util, max);
>  	next_f = get_next_freq(sg_policy, util, max);
> @@ -544,6 +583,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		unsigned long j_util, j_max;
>  
>  		j_util = sugov_get_util(j_sg_cpu);
> +		if (j_sg_cpu == sg_cpu)
> +			sugov_cpu_ramp_boost_update(sg_cpu, j_util);
>  		j_max = j_sg_cpu->max;
>  		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
>  
> @@ -553,6 +594,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		}
>  	}
>  
> +
>  	return get_next_freq(sg_policy, util, max);
>  }


Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
