Return-Path: <linux-pm+bounces-9947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6C91687C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BD288E0F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE0158A15;
	Tue, 25 Jun 2024 12:58:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29291158A03;
	Tue, 25 Jun 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320327; cv=none; b=lLPRYiaLpKBWvgkkN2Vo8N/jWzpyHD9xVBRaCR/YojiliCHxcgzBiMs0bdrMbrvYjZQAEWfIOPv/q3M0HhYIlzzTA0DxPa98T8hKcB69uCHTyCX0vXhj1VMX3TEk5TQHKg/yJeTjNrSwFTOOvxZITlNsNAiJ6hz1ZgJfrErjZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320327; c=relaxed/simple;
	bh=Y/iduQbEcuoMn84TlKhRVzYgE9StZF5R4m4fm5jyoUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2rm/KXEppdpmFhHa9c2nce8IKHqWC89V9Fe+E3HnvcPtJZqUGqdsSMsHVFdc/zk1X78K9me2I8j99FyWBNcK/6TJJin3NlvMP5BHQABTz4gRtW8ap5TllGtfor7yOd1xVWPZwQE5FD9FByxmNenyUx02b0RnlgoWhp44At+uY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C43A339;
	Tue, 25 Jun 2024 05:59:09 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4C283F73B;
	Tue, 25 Jun 2024 05:58:41 -0700 (PDT)
Message-ID: <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
Date: Tue, 25 Jun 2024 14:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240619201409.2071728-1-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240619201409.2071728-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 22:14, Qais Yousef wrote:

[...]

> 1. context_switch()
> 2. task_tick_fair()
> 3. update_blocked_averages()

Nit: Got recently renamed to sched_balance_update_blocked_averages(). (*)

> 4. on syscall that changes policy or uclamp values

sched_setscheduler() ?

> 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> 
> The update at context switch should help guarantee that DL and RT get
> the right frequency straightaway when they're RUNNING. As mentioned
> though the update will happen slightly after enqueue_task(); though in
> an ideal world these tasks should be RUNNING ASAP and this additional
> delay should be negligible. For fair tasks we need to make sure we send
> a single update for every decay for the root cfs_rq. Any changes to the
> rq will be deferred until the next task is ready to run, or we hit TICK.
> But we are guaranteed the task is running at a level that meets its
> requirements after enqueue.
> 
> To guarantee RT and DL tasks updates are never missed, we add a new
> SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> already running at the right freq, the governor will end up doing
> nothing, but we eliminate the risk of the task ending up accidentally
> running at the wrong freq due to rate_limit_us.
> 
> Similarly for iowait boost, we ignore rate limits. We also handle a case
> of a boost reset prematurely by adding a guard in sugov_iowait_apply()
> to reduce the boost after 1ms which seems iowait boost mechanism relied
> on rate_limit_us and cfs_rq.decay preventing any updates to happen soon

s/cfs_rq.decay/cfs_rq.decayed

> after iowait boost.
> 
> The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> time stamps otherwise we can end up delaying updates for normal
> requests.
> 
> As a simple optimization, we avoid sending cpufreq updates when
> switching from RT to another RT as RT tasks run at max freq by default.
> If CONFIG_UCLAMP_TASK is enabled, we can do a simple check to see if
> uclamp_min is different to avoid unnecessary cpufreq update as most RT
> tasks are likely to be running at the same performance level, so we can
> avoid unnecessary overhead of forced updates when there's nothing to do.
> 
> We also ensure to ignore cpufreq udpates for sugov workers at context
> switch. It doesn't make sense for the kworker that applies the frequency
> update (which is a DL task) to trigger a frequency update itself.
> 
> The update at task_tick_fair will guarantee that the governor will

Nit: s/task_tick_fair/task_tick_fair()

> follow any updates to load for tasks/CPU or due to new enqueues/dequeues
> to the rq. Since DL and RT always run at constant frequencies and have
> no load tracking, this is only required for fair tasks.
> 
> The update at update_blocked_averages() will ensure we decay frequency

(*)

> as the CPU becomes idle for long enough.
> 
> If the currently running task changes its policy or uclamp values, we
> ensure we follow up with cpufreq update to ensure we follow up with any
> potential new perf requirements based on the new change.
> 
> To handle systems with long TICK where tasks could end up enqueued but
> no preemption happens until TICK, we add an update in
> check_preempt_wakeup_fair() if wake up preemption fails. This will send
> special SCHED_CPUFREQ_TASK_ENQUEUED cpufreq update to tell the governor
> that the state of the CPU has changed and it can consider an update if
> it deems worthwhile. In schedutil this will do an update if no update
> was done since sysctl_sched_base_slice which is our ideal slice length
> for context switch.
> 
> Since we now DL tasks always ignore rate limit, remove

s/we//?

[...]

> @@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
>  
>  #endif
>  
> +static __always_inline void
> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> +{
> +#ifdef CONFIG_CPU_FREQ
> +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> +		/* Sugov just did an update, don't be too aggressive */
> +		return;
> +	}
> +
> +	/*
> +	 * RT and DL should always send a freq update. But we can do some
> +	 * simple checks to avoid it when we know it's not necessary.
> +	 *
> +	 * iowait_boost will always trigger a freq update too.
> +	 *
> +	 * Fair tasks will only trigger an update if the root cfs_rq has
> +	 * decayed.
> +	 *
> +	 * Everything else should do nothing.
> +	 */
> +	switch (current->policy) {
> +	case SCHED_NORMAL:
> +	case SCHED_BATCH:

What about SCHED_IDLE tasks?

> +		if (unlikely(current->in_iowait)) {
> +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> +			return;
> +		}
> +
> +#ifdef CONFIG_SMP
> +		if (unlikely(rq->cfs.decayed)) {
> +			rq->cfs.decayed = false;
> +			cpufreq_update_util(rq, 0);
> +			return;
> +		}
> +#else
> +		cpufreq_update_util(rq, 0);
> +#endif

We can have !CONFIG_SMP and CONFIG_FAIR_GROUP_SCHED systems. Does this
mean on those systems we call cpufreq_update_util() for each cfs_rq of
the hierarchy where on CONFIG_SMP we only do this for the root cfs_rq?

[...]

> @@ -4744,8 +4716,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
>  		__update_load_avg_se(now, cfs_rq, se);
>  
> -	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> -	decayed |= propagate_entity_load_avg(se);
> +	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
> +	cfs_rq->decayed |= propagate_entity_load_avg(se);
>  
>  	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>  
> @@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		 */
>  		detach_entity_load_avg(cfs_rq, se);
>  		update_tg_load_avg(cfs_rq);
> -	} else if (decayed) {
> -		cfs_rq_util_change(cfs_rq, 0);
> -
> -		if (flags & UPDATE_TG)
> -			update_tg_load_avg(cfs_rq);
> +	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> +		update_tg_load_avg(cfs_rq);
>  	}
>  }

You set cfs_rq->decayed for each taskgroup level but you only reset it
for the root cfs_rq in __update_cpufreq_ctx_switch() and task_tick_fair()?

[...]

> @@ -8418,6 +8378,14 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (pick_eevdf(cfs_rq) == pse)
>  		goto preempt;
>  
> +nopreempt:
> +#ifdef CONFIG_SMP
> +	if (rq->cfs.decayed && rq->cfs.h_nr_running > 1)
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);

Why don't you set rq->cfs.decayed to false here as well?

Is it because the request might fail in sugov_should_update_freq() in
case 'delta_ns < sysctl_sched_base_slice'?

[...]

