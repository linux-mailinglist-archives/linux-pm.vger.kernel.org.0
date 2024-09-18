Return-Path: <linux-pm+bounces-14390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3629F97B84B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 09:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E871C20D23
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695214A0A4;
	Wed, 18 Sep 2024 07:01:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D619BBA;
	Wed, 18 Sep 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642906; cv=none; b=NDrpB+hf9jcP7L6AmKcRU8xJzqt3h3O2EaQLcXXDNKmmX5jUxh+gXmEmqDl0BK/VLXoWtlB01KNpV2aYd5gf5KAzywn9m2kIRI8J2WLdXwQzs7kCKnK5bm2PiX4B0EDSvHv/xGYH+jzD2mq22tKQABe+KeA6S6XTBEQ5vlGDuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642906; c=relaxed/simple;
	bh=J1ON/IpARutUpo6pKq64h+EGHbWcG6oQbqP+qRDYxZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXElECbP3KSVA0cwJ1MiLaoX/vK9+udcHiofpReXIf9lvoGpX723Gu910CNC14sgrQG4lP+Yx26ayciY7IpnhznJIrLjoamjpSrSFL9EinupkdoeG0oeygTa54RSa/YF38R+Kwk5lj6R5ZBdwTVW6lN8IZuQ0FEjYDYAaMNE3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D351FEC;
	Wed, 18 Sep 2024 00:02:12 -0700 (PDT)
Received: from [10.1.47.44] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A04D63F66E;
	Wed, 18 Sep 2024 00:01:40 -0700 (PDT)
Message-ID: <7806add6-8b3b-4dc6-b36c-4e7e23493a26@arm.com>
Date: Wed, 18 Sep 2024 09:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/16] sched/pelt: Add new waiting_avg to record when
 runnable && !running
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-13-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240820163512.1096301-13-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 18:35, Qais Yousef wrote:
> This info will be useful to understand how long tasks end up waiting
> behind other tasks. This info is recorded for tasks only, and
> added/subtracted from root cfs_rq on __update_load_avg_se().
> 
> It also helps to decouple util_avg which indicates tasks computational
> demand from the fact that the CPU might need to run faster to reduce the
> waiting time. It has been a point of confusion in the past while
> discussing uclamp and util_avg and the fact that not keeping freq high
> means tasks will take longer to run and cause delays. Isolating the
> source of delay into its own signal would be a better way to take this
> source of delay into account when making decisions independently of
> task's/CPU's computational demands.
> 
> It is not used now. But will be used later to help drive DVFS headroom.
> It could become a helpful metric to help us manage waiting latencies in
> general, for example in load balance.
> 
> TODO: waiting_avg should use rq_clock_task() as it doesn't care about
> invariance. Waiting time should reflect actual wait in realtime as this
> is the measure of latency that users care about.

Since you use PELT for the update, you're bound to use rq_clock_pelt().
If we could have PELT with two time values, then we could have
'util_avg' and 'invariant util_avg' to cure the slow ramp-up on tiny CPU
and/or low OPPs and we wouldn't have to add all of this extra code.

[...]

> @@ -4744,8 +4760,15 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	 * Track task load average for carrying it to new CPU after migrated, and
>  	 * track group sched_entity load average for task_h_load calculation in migration
>  	 */
> -	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> +	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD)) {
> +		bool update_rq_waiting_avg = entity_is_task(se) && se_runnable(se);
> +
> +		if (update_rq_waiting_avg)
> +			sub_waiting_avg(&rq_of(cfs_rq)->cfs, se);
>  		__update_load_avg_se(now, cfs_rq, se);
> +		if (update_rq_waiting_avg)
> +			add_waiting_avg(&rq_of(cfs_rq)->cfs, se);
> +	}

That's a pretty convoluted design. util_est-style attach/detach within
the PELT update but only for tasks and not all se's.

Doesn't 'p->se.avg.runnable_avg - p->se.avg.util_avg' give you what you
want? It's invariant but so is this here.

Commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
utilization") uses some of it already.

+ /*
+  * To avoid underestimate of task utilization, skip updates of EWMA if
+  * we cannot grant that thread got all CPU time it wanted.
+  */
+  if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
+          goto done;

[...]

> @@ -6786,6 +6814,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * estimated utilization, before we update schedutil.
>  	 */
>  	util_est_enqueue(&rq->cfs, p);
> +	add_waiting_avg(&rq->cfs, se);

This would also have to be checked against the new p->se.sched_delayed
thing.

>  	/*
>  	 * If in_iowait is set, the code below may not trigger any cpufreq
> @@ -6874,6 +6903,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	bool was_sched_idle = sched_idle_rq(rq);
>  
>  	util_est_dequeue(&rq->cfs, p);
> +	sub_waiting_avg(&rq->cfs, se);
                                  ^^
This won't compile. se vs. &p->se

[...]

