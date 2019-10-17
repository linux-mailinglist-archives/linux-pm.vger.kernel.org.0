Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3826FDAB10
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbfJQLUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 07:20:25 -0400
Received: from [217.140.110.172] ([217.140.110.172]:39708 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbfJQLUZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 07:20:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A73C1BB2;
        Thu, 17 Oct 2019 04:19:58 -0700 (PDT)
Received: from [10.1.195.43] (unknown [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEB5F3F718;
        Thu, 17 Oct 2019 04:19:56 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-5-douglas.raillard@arm.com>
 <87e6ce4f-af41-c585-7b48-81b5c7f45ef0@arm.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <18a910f3-261e-18fb-931e-e024b2a20f0b@arm.com>
Date:   Thu, 17 Oct 2019 12:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87e6ce4f-af41-c585-7b48-81b5c7f45ef0@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/17/19 9:57 AM, Dietmar Eggemann wrote:
> On 11/10/2019 15:44, Douglas RAILLARD wrote:
> 
> [...]
> 
>> @@ -181,6 +185,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>>   	}
>>   }
>>   
>> +static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
>> +{
>> +	return READ_ONCE(sg_cpu->ramp_boost);
>> +}
>> +
>> +static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
>> +{
>> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
>> +	unsigned long util_est_enqueued;
>> +	unsigned long util_avg;
>> +	unsigned long boost = 0;
>> +
>> +	util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);
>> +	util_avg = READ_ONCE(rq->cfs.avg.util_avg);
>> +
>> +	/*
>> +	 * Boost when util_avg becomes higher than the previous stable
>> +	 * knowledge of the enqueued tasks' set util, which is CPU's
>> +	 * util_est_enqueued.
>> +	 *
>> +	 * We try to spot changes in the workload itself, so we want to
>> +	 * avoid the noise of tasks being enqueued/dequeued. To do that,
>> +	 * we only trigger boosting when the "amount of work' enqueued
> 
> s/"amount of work'/"amount of work" or 'amount of work'
> 
> [...]
> 
>> @@ -552,6 +593,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>>   		unsigned long j_util, j_max;
>>   
>>   		j_util = sugov_get_util(j_sg_cpu);
>> +		if (j_sg_cpu == sg_cpu)
>> +			sugov_cpu_ramp_boost_update(sg_cpu);
> 
> Can you not call this already in sugov_update_shared(), like in the
> sugov_update_single() case?

The next commit in the series needs to aggregate the ramp_boost of all CPUs in the policy,
so this call will end up here anyway, unless we want to set the value at previous level and
query it back again in the loop. I don't mind either way, but since no option seem
faster than the other, I went for clustering the ramp boost code rather than spreading it at
all levels.


> diff --git a/kernel/sched/cpufreq_schedutil.c
> b/kernel/sched/cpufreq_schedutil.c
> index e35c20b42780..4c53f63a537d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -595,8 +595,6 @@ static unsigned int sugov_next_freq_shared(struct
> sugov_cpu *sg_cpu, u64 time)
>                  unsigned long j_util, j_max;
> 
>                  j_util = sugov_get_util(j_sg_cpu);
> -               if (j_sg_cpu == sg_cpu)
> -                       sugov_cpu_ramp_boost_update(sg_cpu);
>                  j_max = j_sg_cpu->max;
>                  j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
> 
> @@ -625,6 +623,7 @@ sugov_update_shared(struct update_util_data *hook,
> u64 time, unsigned int flags)
>          ignore_dl_rate_limit(sg_cpu, sg_policy);
> 
>          if (sugov_should_update_freq(sg_policy, time)) {
> +               sugov_cpu_ramp_boost_update(sg_cpu);
>                  next_f = sugov_next_freq_shared(sg_cpu, time);
> 
> [...]
> 
