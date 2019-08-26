Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407529CCD5
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfHZJvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:51:21 -0400
Received: from foss.arm.com ([217.140.110.172]:55484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfHZJvV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 05:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF0715AD;
        Mon, 26 Aug 2019 02:51:20 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D3CF3F59C;
        Mon, 26 Aug 2019 02:51:18 -0700 (PDT)
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast
 switching
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com
References: <20190807153340.11516-1-douglas.raillard@arm.com>
 <3316959.EEulJYEQYJ@kreacher>
 <20190826094058.GP2369@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cb75ae16-727e-636b-2b79-4f049259c0aa@arm.com>
Date:   Mon, 26 Aug 2019 11:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826094058.GP2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/08/2019 11:40, Peter Zijlstra wrote:
> On Mon, Aug 26, 2019 at 11:10:52AM +0200, Rafael J. Wysocki wrote:
>> On Wednesday, August 7, 2019 5:33:40 PM CEST Douglas RAILLARD wrote:
>>> Fast switching path only emits an event for the CPU of interest, whereas the
>>> regular path emits an event for all the CPUs that had their frequency changed,
>>> i.e. all the CPUs sharing the same policy.
>>>
>>> With the current behavior, looking at cpu_frequency event for a given CPU that
>>> is using the fast switching path will not give the correct frequency signal.
>>>
>>> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
>>> ---
>>>  kernel/sched/cpufreq_schedutil.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>> index 1f82ab108bab..975ccc3de807 100644
>>> --- a/kernel/sched/cpufreq_schedutil.c
>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>> @@ -153,6 +153,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
>>>  			      unsigned int next_freq)
>>>  {
>>>  	struct cpufreq_policy *policy = sg_policy->policy;
>>> +	int cpu;
>>>  
>>>  	if (!sugov_update_next_freq(sg_policy, time, next_freq))
>>>  		return;
>>> @@ -162,7 +163,11 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
>>>  		return;
>>>  
>>>  	policy->cur = next_freq;
>>> -	trace_cpu_frequency(next_freq, smp_processor_id());
>>> +
>>> +	if (trace_cpu_frequency_enabled()) {
>>> +		for_each_cpu(cpu, policy->cpus)
>>> +			trace_cpu_frequency(next_freq, cpu);
>>> +	}
>>>  }
>>>  
>>>  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>>>
>>
>> Peter, any comments here?
> 
> I was thinking this would be a static map and dealing with it would be
> something trivially done in post (or manually while reading), but sure,
> whatever:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I think our EAS tooling expects the behavior of the non-fast-switching
driver (cpufreq.c cpufreq_notify_transition() CPUFREQ_POSTCHANGE). Pixel
3 is the first device with a fast-switching driver we test on.

Not sure about the extra  'if trace_cpu_frequency_enabled()' but I guess
it doesn't hurt.
