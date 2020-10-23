Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C37296D5E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462750AbgJWLIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 07:08:45 -0400
Received: from foss.arm.com ([217.140.110.172]:49534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462703AbgJWLIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 07:08:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D0B7113E;
        Fri, 23 Oct 2020 04:08:44 -0700 (PDT)
Received: from [10.57.14.27] (unknown [10.57.14.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0F43F66B;
        Fri, 23 Oct 2020 04:08:40 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        linux-pm@vger.kernel.org
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
 <20201023103407.GK2594@hirez.programming.kicks-ass.net>
 <20201023105452.aivb5o6dws76evc3@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f3ab8761-4507-90e9-54f4-e6843863aa89@arm.com>
Date:   Fri, 23 Oct 2020 12:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201023105452.aivb5o6dws76evc3@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/23/20 11:54 AM, Viresh Kumar wrote:
> On 23-10-20, 12:34, Peter Zijlstra wrote:
>> On Fri, Oct 23, 2020 at 03:50:20PM +0530, Viresh Kumar wrote:
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index d2003a7d5ab5..369ff54d11d4 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -5117,6 +5117,119 @@ struct task_struct *idle_task(int cpu)
>>>   	return cpu_rq(cpu)->idle;
>>>   }
>>>   
>>> +/*
>>> + * This function computes an effective utilization for the given CPU, to be
>>> + * used for frequency selection given the linear relation: f = u * f_max.
>>> + *
>>> + * The scheduler tracks the following metrics:
>>> + *
>>> + *   cpu_util_{cfs,rt,dl,irq}()
>>> + *   cpu_bw_dl()
>>> + *
>>> + * Where the cfs,rt and dl util numbers are tracked with the same metric and
>>> + * synchronized windows and are thus directly comparable.
>>> + *
>>> + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
>>> + * which excludes things like IRQ and steal-time. These latter are then accrued
>>> + * in the irq utilization.
>>> + *
>>> + * The DL bandwidth number otoh is not a measured metric but a value computed
>>> + * based on the task model parameters and gives the minimal utilization
>>> + * required to meet deadlines.
>>> + */
>>> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>>> +				 unsigned long max, enum cpu_util_type type,
>>> +				 struct task_struct *p)
>>> +{
>> 	...
>>> +}
>>> +
>>> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
>>> +			     unsigned long max)
>>> +{
>>> +	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
>>> +				  NULL);
>>> +}
>>
>> Shouldn't all that be: #ifdef CONFIG_SMP ?
> 
> I didn't realize that these matrices are only available in case of SMP
> and that's why schedutil isn't available for !SMP. I wonder what we
> should be doing in cpufreq_cooling now ? Make it depend on SMP ? Or
> calculate load the traditional way (the stuff I just removed) for !SMP
> case ?

IMO the !SMP can leave with the old design, so keeping two
implementations under #ifdef CONFIG_SMP is fair I would say in this
case.

There are popular platforms !SMP (BeagleBone, RPi1, RPiZero) but I
haven't heard anyone was using IPA on them.

Regards,
Lukasz

> 
> :)
> 
