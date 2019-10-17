Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A7DA9DA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 12:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392708AbfJQKWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 06:22:44 -0400
Received: from [217.140.110.172] ([217.140.110.172]:38356 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJQKWn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 06:22:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70DC1BF7;
        Thu, 17 Oct 2019 03:22:18 -0700 (PDT)
Received: from [10.1.195.43] (unknown [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DB13F718;
        Thu, 17 Oct 2019 03:22:17 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/6] sched/cpufreq: Attach perf domain to sugov
 policy
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-3-douglas.raillard@arm.com>
 <4ebf6419-c8e0-3998-41e0-3f7b49b34084@arm.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <686407a7-3074-0fa2-e041-a9931f467aea@arm.com>
Date:   Thu, 17 Oct 2019 11:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4ebf6419-c8e0-3998-41e0-3f7b49b34084@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dietmar,

On 10/17/19 9:57 AM, Dietmar Eggemann wrote:
> On 11/10/2019 15:44, Douglas RAILLARD wrote:
> 
> [...]
> 
>> @@ -66,6 +70,38 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>>   
>>   /************************ Governor internals ***********************/
>>   
>> +#ifdef CONFIG_ENERGY_MODEL
>> +static void sugov_policy_attach_pd(struct sugov_policy *sg_policy)
>> +{
>> +	struct em_perf_domain *pd;
>> +	struct cpufreq_policy *policy = sg_policy->policy;
> 
> Shouldn't always order local variable declarations from longest to
> shortest line?

Can't find any reference to that rule in the coding style, although I'm happy to change order
if that's deemed useful.

> 
>> +
>> +	sg_policy->pd = NULL;
>> +	pd = em_cpu_get(policy->cpu);
>> +	if (!pd)
>> +		return;
>> +
>> +	if (cpumask_equal(policy->related_cpus, to_cpumask(pd->cpus)))
>> +		sg_policy->pd = pd;
>> +	else
>> +		pr_warn("%s: Not all CPUs in schedutil policy %u share the same perf domain, no perf domain for that policy will be registered\n",
>> +			__func__, policy->cpu);
> 
> Maybe {} because of 2 lines?

+1

>> +}
>> +
>> +static struct em_perf_domain *sugov_policy_get_pd(
>> +						struct sugov_policy *sg_policy)
> 
> 
> Maybe this way? This format is already used in this file.
> 
> static struct em_perf_domain *
> sugov_policy_get_pd(struct sugov_policy *sg_policy)
> 

I also prefer this kind of non-indented form that always stays indented across renames :)

>> +{
>> +	return sg_policy->pd;
>> +}
>> +#else /* CONFIG_ENERGY_MODEL */
>> +static void sugov_policy_attach_pd(struct sugov_policy *sg_policy) {}
>> +static struct em_perf_domain *sugov_policy_get_pd(
>> +						struct sugov_policy *sg_policy)
>> +{
>> +	return NULL;
>> +}
>> +#endif /* CONFIG_ENERGY_MODEL */
>> +
>>   static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>>   {
>>   	s64 delta_ns;
>> @@ -859,6 +895,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>>   							sugov_update_shared :
>>   							sugov_update_single);
>>   	}
>> +
>> +	sugov_policy_attach_pd(sg_policy);
>> +
>>   	return 0;
>>   }
> 
> A sugov_policy_detach_pd() called from sugov_stop() (doing for instance
> the g_policy->pd = NULL) is not needed?

 From what I could see, sugov_stop() will always be followed by sugov_start() before
it's used again, so that does not seem more risky than not de-initializing sg_cpu's
for example.
