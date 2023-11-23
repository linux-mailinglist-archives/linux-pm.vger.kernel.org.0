Return-Path: <linux-pm+bounces-123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738227F5FD1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22F4B21420
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220F24B47;
	Thu, 23 Nov 2023 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB83D64;
	Thu, 23 Nov 2023 05:12:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C871042;
	Thu, 23 Nov 2023 05:13:16 -0800 (PST)
Received: from [10.57.4.190] (unknown [10.57.4.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25DA43F6C4;
	Thu, 23 Nov 2023 05:12:28 -0800 (PST)
Message-ID: <3a381307-81a2-40ab-a2bf-f899e3fd7c80@arm.com>
Date: Thu, 23 Nov 2023 13:13:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, rafael@kernel.org,
 qyousef@layalina.io, mgorman@suse.de, bsegall@google.com,
 rostedt@goodmis.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231122140119.472110-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 14:01, Vincent Guittot wrote:
> It has been reported that thread's util_est can significantly decrease as
> a result of sharing the CPU with other threads. The use case can be easily
> reproduced with a periodic task TA that runs 1ms and sleeps 100us.
> When the task is alone on the CPU, its max utilization and its util_est is
> around 888. If another similar task starts to run on the same CPU, TA will
> have to share the CPU runtime and its maximum utilization will decrease
> around half the CPU capacity (512) then TA's util_est will follow this new
> maximum trend which is only the result of sharing the CPU with others
> tasks. Such situation can be detected with runnable_avg wich is close or
> equal to util_avg when TA is alone but increases above util_avg when TA
> shares the CPU with other threads and wait on the runqueue.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> This patch implements what I mentioned in [1]. I have been able to
> reproduce such pattern with rt-app.
> 
> [1] https://lore.kernel.org/lkml/CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com/#t

Thanks Vincet for looking at it! I didn't have to to come
back to this issue.

> 
>   kernel/sched/fair.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857698..eeb505d28905 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4774,6 +4774,11 @@ static inline unsigned long task_util(struct task_struct *p)
>   	return READ_ONCE(p->se.avg.util_avg);
>   }
>   
> +static inline unsigned long task_runnable(struct task_struct *p)
> +{
> +	return READ_ONCE(p->se.avg.runnable_avg);
> +}
> +
>   static inline unsigned long _task_util_est(struct task_struct *p)
>   {
>   	struct util_est ue = READ_ONCE(p->se.avg.util_est);
> @@ -4892,6 +4897,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
>   		return;
>   
> +	/*
> +	 * To avoid underestimate of task utilization, skip updates of ewma if
> +	 * we cannot grant that thread got all CPU time it wanted.
> +	 */
> +	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> +		goto done;
> +
> +
>   	/*
>   	 * Update Task's estimated utilization
>   	 *

That looks reasonable to do. I cannot test it right now on my pixel6.
It should do the trick to the task util that we need in bigger apps
than rt-app as well.

Reviewed-by: Lukasz luba <lukasz.luba@arm.com>

