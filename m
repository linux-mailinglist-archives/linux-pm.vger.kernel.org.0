Return-Path: <linux-pm+bounces-7934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6228C853D
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 13:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150741F22E31
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413F13B78B;
	Fri, 17 May 2024 11:06:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82AA3AC2F;
	Fri, 17 May 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944014; cv=none; b=o9h7UuFLwclua4HHETKcjNOpFZtRZ5j8eRoZqRSf+1jmdLN67y9uVyte4PnYZN7px7dnbdO7T98BHFMue6bwSBnKrvkug9lhRjNWec3xpQpSXFD1iIZd/Evq/bJuf+oShecvqycBcNnszPcsE1VNS6z9wqEV2S4HFhRc4fWteqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944014; c=relaxed/simple;
	bh=Iflwst1YHxCba42648JKAgwhZA6cooCNF0L2d6gxE9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kI4UlyDuwfgw87NPZisBT9QXmk3h8GEbybXPfSY/0Iox+rO+MY/C62HgYiLiw36LMcDhqjEpNwDHy1R4rR5ZHMtER/Lz8f2P8QP11/kiAvRvWTLv+WXkfeoxvW31JVcqQy0W1kLtZ5uq7bWYXH7WwpgswWgKTIW9aYEfzP89U10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA791424;
	Fri, 17 May 2024 04:07:13 -0700 (PDT)
Received: from [10.57.3.11] (unknown [10.57.3.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA2F3F7A6;
	Fri, 17 May 2024 04:06:47 -0700 (PDT)
Message-ID: <b4036b48-7d04-4bba-b405-f64ee309e874@arm.com>
Date: Fri, 17 May 2024 12:06:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240516204802.846520-1-qyousef@layalina.io>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240516204802.846520-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2024 21:48, Qais Yousef wrote:
> Improve the interaction with cpufreq governors by making the
> cpufreq_update_util() calls more intentional.
> 
> At the moment we send them when load is updated for CFS, bandwidth for
> DL and at enqueue/dequeue for RT. But this can lead to too many updates
> sent in a short period of time and potentially be ignored at a critical
> moment due to the rate_limit_us in schedutil.
> 
> For example, simultaneous task enqueue on the CPU where 2nd task is
> bigger and requires higher freq. The trigger to cpufreq_update_util() by
> the first task will lead to dropping the 2nd request until tick. Or
> another CPU in the same policy triggers a freq update shortly after.
> 
> Updates at enqueue for RT are not strictly required. Though they do help
> to reduce the delay for switching the frequency and the potential
> observation of lower frequency during this delay. But current logic
> doesn't intentionally (at least to my understanding) try to speed up the
> request.
> 
> To help reduce the amount of cpufreq updates and make them more
> purposeful, consolidate them into these locations:
> 
> 1. context_switch()
> 2. task_tick_fair()
> 3. update_blocked_averages()
> 4. on syscall that changes policy or uclamp values
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
> follow any updates to load for tasks/CPU or due to new enqueues/dequeues
> to the rq. Since DL and RT always run at constant frequencies and have
> no load tracking, this is only required for fair tasks.
> 
> The update at update_blocked_averages() will ensure we decay frequency
> as the CPU becomes idle for long enough.
> 
> If the currently running task changes its policy or uclamp values, we
> ensure we follow up with cpufreq update to ensure we follow up with any
> potential new perf requirements based on the new change.
> 
> [...]
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..2d0a45aba16f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -8,7 +8,8 @@
>    * Interface between cpufreq drivers and the scheduler:
>    */
>   
> -#define SCHED_CPUFREQ_IOWAIT	(1U << 0)
> +#define SCHED_CPUFREQ_IOWAIT		(1U << 0)
> +#define SCHED_CPUFREQ_FORCE_UPDATE	(1U << 1) /* ignore transition_delay_us */
>   
>   #ifdef CONFIG_CPU_FREQ
>   struct cpufreq_policy;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a914388144a..d0c97a66627a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -152,6 +152,9 @@ const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
>   
>   __read_mostly int scheduler_running;
>   
> +static __always_inline void
> +update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev);
> +
>   #ifdef CONFIG_SCHED_CORE
>   
>   DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
> @@ -1958,7 +1961,7 @@ static bool uclamp_reset(const struct sched_attr *attr,
>   	return false;
>   }
>   
> -static void __setscheduler_uclamp(struct task_struct *p,
> +static void __setscheduler_uclamp(struct rq *rq, struct task_struct *p,
>   				  const struct sched_attr *attr)
>   {
>   	enum uclamp_id clamp_id;
> @@ -1980,7 +1983,6 @@ static void __setscheduler_uclamp(struct task_struct *p,
>   			value = uclamp_none(clamp_id);
>   
>   		uclamp_se_set(uc_se, value, false);
> -
>   	}
>   
>   	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> @@ -1997,6 +1999,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
>   		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>   			      attr->sched_util_max, true);
>   	}
> +
> +	/*
> +	 * Updating uclamp values has impact on freq, ensure it is taken into
> +	 * account.
> +	 */
> +	if (task_current(rq, p))
> +		update_cpufreq_ctx_switch(rq, NULL);

Do we care about updating the frequency here? p is dequeued during the 
__setscheduler_uclamp() call, so I think it's better to do this after 
the uclamp() call and after enqueue_task(), so that uclamp_rq_inc() 
comes into effect.

Also, do we want to limit the update to task_current()? Updating a 
uclamp_min of a task on this rq (even though it is not current) should 
raise the minimum OPP for the whole rq. An example is that if a 
uclamp_min task gets enqueued, the uclamp_min should kick in even if 
this task isn't immediately run and the current task isn't this task.

>   }
>   
>   static void uclamp_fork(struct task_struct *p)
> [...]

