Return-Path: <linux-pm+bounces-939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F880E975
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA091C20AEB
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD81D5C910;
	Tue, 12 Dec 2023 10:47:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABB869F;
	Tue, 12 Dec 2023 02:47:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EFC143D;
	Tue, 12 Dec 2023 02:48:09 -0800 (PST)
Received: from [10.1.35.59] (e133649.arm.com [10.1.35.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187593F762;
	Tue, 12 Dec 2023 02:47:20 -0800 (PST)
Message-ID: <d73ea0ed-ecd8-4c70-b02e-f6fcd2cd7538@arm.com>
Date: Tue, 12 Dec 2023 10:47:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
 Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231208015242.385103-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2023 01:52, Qais Yousef wrote:
> Due to the way code is structured, it makes a lot of sense to trigger
> cpufreq_update_util() from update_load_avg(). But this is too aggressive
> as in most cases we are iterating through entities in a loop to
> update_load_avg() in the hierarchy. So we end up sending too many
> request in an loop as we're updating the hierarchy.

Do you mean the for_each_sched_entity(se) loop? I think we update CPU 
frequency only once at the root CFS?

> Combine this with the rate limit in schedutil, we could end up
> prematurely send up a wrong frequency update before we have actually
> updated all entities appropriately.
> 
> Be smarter about it by limiting the trigger to perform frequency updates
> after all accounting logic has done. This ended up being in the
> following points:
> 
> 1. enqueue/dequeue_task_fair()
> 2. throttle/unthrottle_cfs_rq()
> 3. attach/detach_task_cfs_rq()
> 4. task_tick_fair()
> 5. __sched_group_set_shares()
> 
> This is not 100% ideal still due to other limitations that might be
> a bit harder to handle. Namely we can end up with premature update
> request in the following situations:
> 
> a. Simultaneous task enqueue on the CPU where 2nd task is bigger and
>     requires higher freq. The trigger to cpufreq_update_util() by the
>     first task will lead to dropping the 2nd request until tick. Or
>     another CPU in the same policy trigger a freq update.
> 
> b. CPUs sharing a policy can end up with the same race in a but the
>     simultaneous enqueue happens on different CPUs in the same policy.
> 
> The above though are limitations in the governor/hardware, and from
> scheduler point of view at least that's the best we can do. The
> governor might consider smarter logic to aggregate near simultaneous
> request and honour the higher one.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>   kernel/sched/fair.c | 55 ++++++++++++---------------------------------
>   1 file changed, 14 insertions(+), 41 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b83448be3f79..f99910fc6705 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3997,29 +3997,6 @@ static inline void update_cfs_group(struct sched_entity *se)
>   }
>   #endif /* CONFIG_FAIR_GROUP_SCHED */
>   
> -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> -{
> -	struct rq *rq = rq_of(cfs_rq);
> -
> -	if (&rq->cfs == cfs_rq) {

Here. I think this restricts frequency updates to the root CFS?

> -		/*
> -		 * There are a few boundary cases this might miss but it should
> -		 * get called often enough that that should (hopefully) not be
> -		 * a real problem.
> -		 *
> -		 * It will not get called when we go idle, because the idle
> -		 * thread is a different class (!fair), nor will the utilization
> -		 * number include things like RT tasks.
> -		 *
> -		 * As is, the util number is not freq-invariant (we'd have to
> -		 * implement arch_scale_freq_capacity() for that).
> -		 *
> -		 * See cpu_util_cfs().
> -		 */
> -		cpufreq_update_util(rq, flags);
> -	}
> -}
> -
>   #ifdef CONFIG_SMP
>   static inline bool load_avg_is_decayed(struct sched_avg *sa)
>   {
> [...]

