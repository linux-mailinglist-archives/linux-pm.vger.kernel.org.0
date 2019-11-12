Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E7F96B7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLRLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 12:11:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfKLRLj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 12:11:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2474130E;
        Tue, 12 Nov 2019 09:11:38 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AC0C3F534;
        Tue, 12 Nov 2019 09:11:35 -0800 (PST)
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e6687868-835b-0d01-5e00-c3eaec1cd62c@arm.com>
Date:   Tue, 12 Nov 2019 17:11:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112150544.GA3664@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

I didn't see anything in that reply, was that just a spurious email?

On 12/11/2019 15:05, Vincent Guittot wrote:
> Le Tuesday 12 Nov 2019 à 15:48:13 (+0100), Vincent Guittot a écrit :
>> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
>> which might be inefficient when cpufreq driver has rate limitation.
>>
>> When a task is attached on a CPU, we have call path:
>>
>> update_blocked_averages()
>>   update_cfs_rq_load_avg()
>>     cfs_rq_util_change -- > trig frequency update
>>   attach_entity_load_avg()
>>     cfs_rq_util_change -- > trig frequency update
>>
>> The 1st frequency update will not take into account the utilization of the
>> newly attached task and the 2nd one might be discard because of rate
>> limitation of the cpufreq driver.
>>
>> update_cfs_rq_load_avg() is only called by update_blocked_averages()
>> and update_load_avg() so we can move the call to
>> {cfs_rq,cpufreq}_util_change() into these 2 functions. It's also
>> interesting to notice that update_load_avg() already calls directly
>> cfs_rq_util_change() for !SMP case.
>>
>> This changes will also ensure that cpufreq_update_util() is called even
>> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
>> irq, rt or dl pelt signals.
>>
>> Reported-by: Doug Smythies <dsmythies@telus.net>
>> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>
>> ---
>>
>> I have just rebased the patch on latest tip/sched/core and made it a proper
>> patchset after Doug reported that the problem has diseappeared according to
>> his 1st results but tests results are not all based on the same v5.4-rcX
>> and with menu instead of teo governor.
>>
>>  kernel/sched/fair.c | 33 +++++++++++++++++++++------------
>>  1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e458f52..c93d534 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>>  	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>>  #endif
>>  
>> -	if (decayed)
>> -		cfs_rq_util_change(cfs_rq, 0);
>> -
>>  	return decayed;
>>  }
>>  
>> @@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>  		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
>>  		update_tg_load_avg(cfs_rq, 0);
>>  
>> -	} else if (decayed && (flags & UPDATE_TG))
>> -		update_tg_load_avg(cfs_rq, 0);
>> +	} else if (decayed) {
>> +		cfs_rq_util_change(cfs_rq, 0);
>> +
>> +		if (flags & UPDATE_TG)
>> +			update_tg_load_avg(cfs_rq, 0);
>> +	}
>>  }
>>  
>>  #ifndef CONFIG_64BIT
>> @@ -7484,6 +7485,7 @@ static void update_blocked_averages(int cpu)
>>  	const struct sched_class *curr_class;
>>  	struct rq_flags rf;
>>  	bool done = true;
>> +	int decayed = 0;
>>  
>>  	rq_lock_irqsave(rq, &rf);
>>  	update_rq_clock(rq);
>> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
>>  	 * that RT, DL and IRQ signals have been updated before updating CFS.
>>  	 */
>>  	curr_class = rq->curr->sched_class;
>> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>> -	update_irq_load_avg(rq, 0);
>> +	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>> +	decayed |= update_irq_load_avg(rq, 0);
>>  
>>  	/* Don't need periodic decay once load/util_avg are null */
>>  	if (others_have_blocked(rq))
>> @@ -7529,6 +7531,9 @@ static void update_blocked_averages(int cpu)
>>  	}
>>  
>>  	update_blocked_load_status(rq, !done);
>> +
>> +	if (decayed)
>> +		cpufreq_update_util(rq, 0);
>>  	rq_unlock_irqrestore(rq, &rf);
>>  }
>>  
>> @@ -7585,6 +7590,7 @@ static inline void update_blocked_averages(int cpu)
>>  	struct cfs_rq *cfs_rq = &rq->cfs;
>>  	const struct sched_class *curr_class;
>>  	struct rq_flags rf;
>> +	int decayed = 0;
>>  
>>  	rq_lock_irqsave(rq, &rf);
>>  	update_rq_clock(rq);
>> @@ -7594,13 +7600,16 @@ static inline void update_blocked_averages(int cpu)
>>  	 * that RT, DL and IRQ signals have been updated before updating CFS.
>>  	 */
>>  	curr_class = rq->curr->sched_class;
>> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>> -	update_irq_load_avg(rq, 0);
>> +	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>> +	decayed |= update_irq_load_avg(rq, 0);
>>  
>> -	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
>> +	decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
>>  
>>  	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
>> +
>> +	if (decayed)
>> +		cpufreq_update_util(rq, 0);
>>  	rq_unlock_irqrestore(rq, &rf);
>>  }
>>  
>> -- 
>> 2.7.4
>>
