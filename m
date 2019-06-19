Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125D54BDE5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFSQTt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 12:19:49 -0400
Received: from foss.arm.com ([217.140.110.172]:47254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfFSQTt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jun 2019 12:19:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2803A344;
        Wed, 19 Jun 2019 09:19:48 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D1D63F246;
        Wed, 19 Jun 2019 09:19:47 -0700 (PDT)
Subject: Re: [RFC PATCH 6/7] sched/cpufreq: Improve sugov_cpu_is_busy accuracy
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-7-douglas.raillard@arm.com>
 <20190516125552.hol3rasllhveekxq@e110439-lin>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <e908b2ab-5c86-5be1-d3f0-36f2b26973c5@arm.com>
Date:   Wed, 19 Jun 2019 17:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516125552.hol3rasllhveekxq@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Patrick,

On 5/16/19 1:55 PM, Patrick Bellasi wrote:
> On 08-May 18:43, douglas.raillard@arm.com wrote:
>> From: Douglas RAILLARD <douglas.raillard@arm.com>
>>
>> Avoid assuming a CPU is busy when it has begun being idle before
>> get_next_freq() is called. This is achieved by making sure the CPU will
>> not be detected as busy by other CPUs whenever its utilization is
>> decreasing.
> 
> If I understand it correctly, what you are after here is a "metric"
> which tells you (in a shared performance domain) if a CPU has been
> busy for a certain amount of time.
> You do that by reworking the way idle_calls are accounted for the
> sugov_update_single() case.
> 
> That approach could work but it looks a bit convoluted in the way it's
> coded and it's also difficult to exclude there could be corner cases
> with wired behaviors.
> Isn't that why you "fix" the saved_idle_calls counter after all?
> 
> What about a different approach where we:
> 
> 1. we annotate the timestamp a CPU wakes up from IDLE (last_wakeup_time)
> 
> 2. we use that annotated last_wake_time and the rq->nr_running to
>     define the "cpu is busy" heuristic.
> 
> Looking at a sibling CPU, I think we can end up with two main cases:
> 
> 1. CPU's nr_running is == 0
>     then we don't consider busy that CPU
> 
> 2. CPU's nr_running is  > 0
>     then the CPU is busy iff
>        (current_time - last_wakeup_tim) >= busy_threshold
> 
> Notice that, when a CPU is active, its rq clock is periodically
> updated, at least once per tick. Thus, provided a tick time is not too
> long to declare busy a CPU, then the above logic should work.
> 
> Perhaps the busy_threshold can also be defined considering the PELT
> dynamics and starting from an expected utilization increase converted
> in time.

After experimenting with quite a few combinations, I managed to get a heuristic
based on util_avg and util_est_enqueued that seems to work better in my case.
Key differences are:
* this new heuristic only really takes into account CFS signals
  (current one based on idle calls takes into account everything that executes
   on a given CPU.)
* it will mark a CPU as busy less often, since it should only trigger when
   there is a change in the utilization of a currently enqueued tasks.
   Util changes due to enqueue/dequeue will not trigger it, which IMHO
   is desirable, since we only want to bias frequency selection
   when we know that we don't have precise utilization values for the
   enqueued tasks (because the task has changed its behavior).

That change will be part of v2 posting of this series.
  
> Could something like to above work or am I missing something?
> 
>> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 42 ++++++++++++++++++++++++++++----
>>   1 file changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index a12b7e5bc028..ce4b90cafbb5 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -62,6 +62,7 @@ struct sugov_cpu {
>>   	/* The field below is for single-CPU policies only: */
>>   #ifdef CONFIG_NO_HZ_COMMON
>>   	unsigned long		saved_idle_calls;
>> +	unsigned long		previous_util;
>>   #endif
>>   };
>>   
>> @@ -181,14 +182,35 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
>>   	return ret;
>>   }
>>   
>> -static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu)
>> +static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu,
>> +				     unsigned long util)
>>   {
>>   	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
>>   	sg_cpu->saved_idle_calls = idle_calls;
>> +
>> +	/*
>> +	 * Make sure that this CPU will not be immediately considered as busy in
>> +	 * cases where the CPU has already entered an idle state. In that case,
>> +	 * the number of idle_calls will not vary anymore until it exits idle,
>> +	 * which would lead sugov_cpu_is_busy() to say that this CPU is busy,
>> +	 * because it has not (re)entered idle since the last time we looked at
>> +	 * it.
>> +	 * Assuming cpu0 and cpu1 are in the same policy, that will make sure
>> +	 * this sequence of events leads to right cpu1 business status from
>> +	 * get_next_freq(cpu=1)
>> +	 * cpu0: [enter idle] -> [get_next_freq] -> [doing nothing] -> [wakeup]
>> +	 * cpu1:                ...              -> [get_next_freq] ->   ...
>> +	 */
>> +	if (util <= sg_cpu->previous_util)
>> +		sg_cpu->saved_idle_calls--;
>> +
>> +	sg_cpu->previous_util = util;
>>   }
>>   #else
>>   static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
>> -static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu) {}
>> +static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu
>> +				     unsigned long util)
>> +{}
>>   #endif /* CONFIG_NO_HZ_COMMON */
>>   
>>   /**
>> @@ -507,10 +529,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>>   	if (!sugov_should_update_freq(sg_policy, time))
>>   		return;
>>   
>> -	busy = sugov_cpu_is_busy(sg_cpu);
>> -	sugov_cpu_is_busy_update(sg_cpu);
>> -
>>   	util = sugov_get_util(sg_cpu);
>> +	busy = sugov_cpu_is_busy(sg_cpu);
>> +	sugov_cpu_is_busy_update(sg_cpu, util);
>>   	max = sg_cpu->max;
>>   	util = sugov_iowait_apply(sg_cpu, time, util, max);
>>   	next_f = get_next_freq(sg_policy, util, max);
>> @@ -545,12 +566,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>>   	struct cpufreq_policy *policy = sg_policy->policy;
>>   	unsigned long util = 0, max = 1;
>>   	unsigned int j;
>> +	unsigned long sg_cpu_util = 0;
>>   
>>   	for_each_cpu(j, policy->cpus) {
>>   		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>>   		unsigned long j_util, j_max;
>>   
>>   		j_util = sugov_get_util(j_sg_cpu);
>> +		if (j_sg_cpu == sg_cpu)
>> +			sg_cpu_util = j_util;
>>   		j_max = j_sg_cpu->max;
>>   		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
>>   
>> @@ -560,6 +584,14 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Only update the business status if we are looking at the CPU for
>> +	 * which a utilization change triggered a call to get_next_freq(). This
>> +	 * way, we don't affect the "busy" status of CPUs that don't have any
>> +	 * change in utilization.
>> +	 */
>> +	sugov_cpu_is_busy_update(sg_cpu, sg_cpu_util);
>> +
>>   	return get_next_freq(sg_policy, util, max);
>>   }
>>   
>> -- 
>> 2.21.0
>>
> 

Thanks,
Douglas
