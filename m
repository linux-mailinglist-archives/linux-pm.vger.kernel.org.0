Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFB398EC3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFBPhO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 11:37:14 -0400
Received: from foss.arm.com ([217.140.110.172]:48010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhFBPhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Jun 2021 11:37:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C4A711FB;
        Wed,  2 Jun 2021 08:35:30 -0700 (PDT)
Received: from [10.57.1.174] (unknown [10.57.1.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 253A23F719;
        Wed,  2 Jun 2021 08:35:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/fair: Take thermal pressure into account while
 estimating energy
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com
References: <20210602135609.10867-1-lukasz.luba@arm.com>
 <20210602135609.10867-2-lukasz.luba@arm.com> <YLedIMNFlZ5eu2Oe@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ce1751d6-4b23-3588-a050-2c30cd3ec9dc@arm.com>
Date:   Wed, 2 Jun 2021 16:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YLedIMNFlZ5eu2Oe@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin,

On 6/2/21 4:00 PM, Quentin Perret wrote:
> Hi Lukasz,
> 
> On Wednesday 02 Jun 2021 at 14:56:08 (+0100), Lukasz Luba wrote:
>>   compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>>   {
>>   	struct cpumask *pd_mask = perf_domain_span(pd);
>> -	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>> +	unsigned long _cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>>   	unsigned long max_util = 0, sum_util = 0;
>> +	unsigned long cpu_cap = _cpu_cap;
>>   	int cpu;
>>   
>>   	/*
>> @@ -6558,6 +6559,14 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>>   				cpu_util_next(cpu, p, -1) + task_util_est(p);
>>   		}
>>   
>> +		/*
>> +		 * Take the thermal pressure from non-idle CPUs. They have
>> +		 * most up-to-date information. For idle CPUs thermal pressure
>> +		 * signal is not updated so often.
>> +		 */
>> +		if (!idle_cpu(cpu))
>> +			cpu_cap = _cpu_cap - thermal_load_avg(cpu_rq(cpu));
> 
> This messes up the irq time scaling no? Maybe move the capping in this

You are talking about scale_irq_capacity() which shrinks the util by
some percentage of irq time. It might be different, by some fraction
(e.g. 8/9 vs 9/10) compared to SchedUtil view, which passes 'raw' arch
capacity. It then adds the irq part, but still to this slightly
different base util.

> function instead of relying on effective_cpu_util() to do it for you?

Agree, since it would be more 'aligned' with how SchedUtil calls
effective_cpu_util(). I will clamp the returned value.

Thanks for pointing this out.

Regards,
Lukasz
