Return-Path: <linux-pm+bounces-8126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75B8CF690
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 00:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D28281710
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2024 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D90E13A3E2;
	Sun, 26 May 2024 22:52:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A00139D11;
	Sun, 26 May 2024 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716763967; cv=none; b=UdcoXmVwkJc61HOpidxyseYZpSK9SeBLNBY64UKbeiH5H+F8wqcn58+zgNpofTg7d4TrMb4LEDthDKNdah6agZ1wfeceNCKPPN6qHPPXMX+FlKmKDWS2p+6znoYvTrOsmdvP3kzvYMMyvYgOuroYiz69Hh7Fro3rxpFsUycfOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716763967; c=relaxed/simple;
	bh=p6ANkU/eii2uK5pbt89UmMb0wLVbZXGjdA18ltQfyKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sR55we5c9RdtAoTxTDCCVRj4YILMQTiqrFBnowQPxr3bTMmKc01MoE14tMNwzTByBXtE03zq4kd39DwDpK+DMvxZXPPDnuO1GAShYQsJmtjZxDy+u31wfpj2cwFSdFt0MXaCMeAQ77KtpqMChaIvaOAsvZatHjrVBMJDy/624ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1CC0DA7;
	Sun, 26 May 2024 15:53:08 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02D473F641;
	Sun, 26 May 2024 15:52:41 -0700 (PDT)
Message-ID: <a1adc985-056f-4fac-9b2d-d140c3ee9e9b@arm.com>
Date: Mon, 27 May 2024 00:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/6] sched/fair: Use util biases for utilization
 and frequency
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <f0be5911214d2f6f7ea92c6c3eed37270215c590.1715082714.git.hongyan.xia2@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <f0be5911214d2f6f7ea92c6c3eed37270215c590.1715082714.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 14:50, Hongyan Xia wrote:
> Use the new util_avg_bias for task and runqueue utilization. We also
> maintain separate util_est and util_est_uclamp signals.
> 
> Now that we have the sum aggregated CFS util value, we do not need to

There is the work uclamp missing somehow here.

> consult uclamp buckets to know how the frequency should be clamped. We
> simply look at the aggregated top level rq->cfs.avg.util_avg +
> rq->cfs.avg.util_avg_bias and rq->cfs.avg.util_est_uclamp to know what
> frequency to choose and how to place tasks.

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 571c8de59508..14376f23a8b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4819,14 +4819,14 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
>  
>  static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
>  
> -static inline unsigned long task_util(struct task_struct *p)
> +static inline unsigned long task_runnable(struct task_struct *p)
>  {
> -	return READ_ONCE(p->se.avg.util_avg);
> +	return READ_ONCE(p->se.avg.runnable_avg);
>  }
>  
> -static inline unsigned long task_runnable(struct task_struct *p)
> +static inline unsigned long task_util(struct task_struct *p)
>  {
> -	return READ_ONCE(p->se.avg.runnable_avg);
> +	return READ_ONCE(p->se.avg.util_avg);
>  }
>  
>  static inline unsigned long _task_util_est(struct task_struct *p)
> @@ -4839,6 +4839,52 @@ static inline unsigned long task_util_est(struct task_struct *p)
>  	return max(task_util(p), _task_util_est(p));
>  }

IMHO, we now have two complete hierarchies of util signals:

       (a)                         (b) (uclamp version of (a))

(1) task_util()                 task_util_uclamp() (+ task_util_bias())

(2) _task_util_est()            _task_util_est_uclamp()

(3) task_util_est()             task_util_est_uclamp()

(4) cpu_util()                  cpu_util_uclamp()

(5) cpu_util_cfs()              cpu_util_cfs_uclamp()

(6) cpu_util_cfs_boost()        cpu_util_cfs_boost_uclamp()


For (4), (5), (6) we now have:

---		                   cpu_util()	  cpu_util_uclamp()
			
eenv_pd_busy_time()			x

eenv_pd_max_util()					x

find_energy_efficient_cpu()		x		x <-- (A)

cpu_util_without()			x

---			    cpu_util_cfs()	 cpu_util_cfs_uclamp()

cpu_overutilized()			x		x <-- (B)

update_sg_lb_stats()			x

update_numa_stats()			x

sched_cpu_util()			x

---                     cpu_util_cfs_boost() cpu_util_cfs_boost_uclamp()

sched_balance_find_src_rq()		x

sugov_get_util()					x

uclamp version falls back to mon-uclamp version for !CONFIG_UCLAMP_TASK.
So it looks like taht in this case we calculate the same cpu utilization
value twice in (A) and (B).

[...]

> @@ -4970,134 +5026,29 @@ static inline unsigned long get_actual_cpu_capacity(int cpu)
>  }
>  
>  static inline int util_fits_cpu(unsigned long util,
> -				unsigned long uclamp_min,
> -				unsigned long uclamp_max,
> +				unsigned long util_uclamp,
>  				int cpu)
>  {
>  	unsigned long capacity = capacity_of(cpu);
> -	unsigned long capacity_orig;
> -	bool fits, uclamp_max_fits;
> -
> -	/*
> -	 * Check if the real util fits without any uclamp boost/cap applied.
> -	 */
> -	fits = fits_capacity(util, capacity);
> -
> -	if (!uclamp_is_used())
> -		return fits;
> -
> -	/*
> -	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
> -	 * uclamp_max. We only care about capacity pressure (by using
> -	 * capacity_of()) for comparing against the real util.
> -	 *
> -	 * If a task is boosted to 1024 for example, we don't want a tiny
> -	 * pressure to skew the check whether it fits a CPU or not.
> -	 *
> -	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
> -	 * should fit a little cpu even if there's some pressure.
> -	 *
> -	 * Only exception is for HW or cpufreq pressure since it has a direct impact
> -	 * on available OPP of the system.
> -	 *
> -	 * We honour it for uclamp_min only as a drop in performance level
> -	 * could result in not getting the requested minimum performance level.
> -	 *
> -	 * For uclamp_max, we can tolerate a drop in performance level as the
> -	 * goal is to cap the task. So it's okay if it's getting less.
> -	 */
> -	capacity_orig = arch_scale_cpu_capacity(cpu);
>  
> -	/*
> -	 * We want to force a task to fit a cpu as implied by uclamp_max.
> -	 * But we do have some corner cases to cater for..
> -	 *
> -	 *
> -	 *                                 C=z
> -	 *   |                             ___
> -	 *   |                  C=y       |   |
> -	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
> -	 *   |      C=x        |   |      |   |
> -	 *   |      ___        |   |      |   |
> -	 *   |     |   |       |   |      |   |    (util somewhere in this region)
> -	 *   |     |   |       |   |      |   |
> -	 *   |     |   |       |   |      |   |
> -	 *   +----------------------------------------
> -	 *         CPU0        CPU1       CPU2
> -	 *
> -	 *   In the above example if a task is capped to a specific performance
> -	 *   point, y, then when:
> -	 *
> -	 *   * util = 80% of x then it does not fit on CPU0 and should migrate
> -	 *     to CPU1
> -	 *   * util = 80% of y then it is forced to fit on CPU1 to honour
> -	 *     uclamp_max request.
> -	 *
> -	 *   which is what we're enforcing here. A task always fits if
> -	 *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> -	 *   the normal upmigration rules should withhold still.
> -	 *
> -	 *   Only exception is when we are on max capacity, then we need to be
> -	 *   careful not to block overutilized state. This is so because:
> -	 *
> -	 *     1. There's no concept of capping at max_capacity! We can't go
> -	 *        beyond this performance level anyway.
> -	 *     2. The system is being saturated when we're operating near
> -	 *        max capacity, it doesn't make sense to block overutilized.
> -	 */
> -	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> -	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> -	fits = fits || uclamp_max_fits;
> +	if (fits_capacity(util_uclamp, capacity))
> +		return 1;
>  
> -	/*
> -	 *
> -	 *                                 C=z
> -	 *   |                             ___       (region a, capped, util >= uclamp_max)
> -	 *   |                  C=y       |   |
> -	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
> -	 *   |      C=x        |   |      |   |
> -	 *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
> -	 *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
> -	 *   |     |   |       |   |      |   |
> -	 *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
> -	 *   +----------------------------------------
> -	 *         CPU0        CPU1       CPU2
> -	 *
> -	 * a) If util > uclamp_max, then we're capped, we don't care about
> -	 *    actual fitness value here. We only care if uclamp_max fits
> -	 *    capacity without taking margin/pressure into account.
> -	 *    See comment above.
> -	 *
> -	 * b) If uclamp_min <= util <= uclamp_max, then the normal
> -	 *    fits_capacity() rules apply. Except we need to ensure that we
> -	 *    enforce we remain within uclamp_max, see comment above.
> -	 *
> -	 * c) If util < uclamp_min, then we are boosted. Same as (b) but we
> -	 *    need to take into account the boosted value fits the CPU without
> -	 *    taking margin/pressure into account.
> -	 *
> -	 * Cases (a) and (b) are handled in the 'fits' variable already. We
> -	 * just need to consider an extra check for case (c) after ensuring we
> -	 * handle the case uclamp_min > uclamp_max.
> -	 */
> -	uclamp_min = min(uclamp_min, uclamp_max);
> -	if (fits && (util < uclamp_min) &&
> -	    (uclamp_min > get_actual_cpu_capacity(cpu)))
> +	if (fits_capacity(util, capacity))
>  		return -1;
>  
> -	return fits;
> +	return 0;

The possible return values stay the same it seems: 1 if uclamp (and so
util_avg) fit, -1 if util_avg fit and 0 if uclamp and uclamp don't fit.

[...]

> @@ -6914,6 +6861,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  			"0 tasks on CFS of CPU %d, but util_avg_bias is %d\n",
>  			rq->cpu, rq->cfs.avg.util_avg_bias);
>  		WRITE_ONCE(rq->cfs.avg.util_avg_bias, 0);
> +		WARN_ONCE(rq->cfs.avg.util_est_uclamp,
> +			"0 tasks on CFS of CPU %d, but util_est_uclamp is %u\n",
> +			rq->cpu, rq->cfs.avg.util_est_uclamp);
> +		WRITE_ONCE(rq->cfs.avg.util_est_uclamp, 0);

Maybe better:

		if (WARN_ONCE(...
			WRITE_ONCE(rq->cfs.avg.util_est_uclamp, 0);

How can this happen, that there are 0 tasks on rq->cfs hierarcy and
rq->cfs.avg.util_est_uclamp is !0 ? Is there a specific code path when
this happens?

>  	}
>  #endif
>  }
> @@ -7485,7 +7436,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  static int
>  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> -	unsigned long task_util, util_min, util_max, best_cap = 0;
> +	unsigned long task_util, task_util_uclamp, best_cap = 0;
>  	int fits, best_fits = 0;
>  	int cpu, best_cpu = -1;
>  	struct cpumask *cpus;
> @@ -7494,8 +7445,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>  
>  	task_util = task_util_est(p);
> -	util_min = uclamp_eff_value(p, UCLAMP_MIN);
> -	util_max = uclamp_eff_value(p, UCLAMP_MAX);
> +	task_util_uclamp = task_util_est_uclamp(p);

select_idle_sibling() could pass task_util and task_util_uclamp into
select_idle_capacity(). This way we would save these calls to
task_util_est() and task_util_est_uclamp() here.

>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		unsigned long cpu_cap = capacity_of(cpu);
> @@ -7503,7 +7453,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
>  			continue;
>  
> -		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> +		fits = util_fits_cpu(task_util, task_util_uclamp, cpu);
>  
>  		/* This CPU fits with all requirements */
>  		if (fits > 0)

[...]


