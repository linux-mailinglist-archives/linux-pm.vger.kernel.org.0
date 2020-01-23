Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F73147013
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgAWRw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 12:52:56 -0500
Received: from foss.arm.com ([217.140.110.172]:42864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWRw4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Jan 2020 12:52:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B711FB;
        Thu, 23 Jan 2020 09:52:55 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0673F52E;
        Thu, 23 Jan 2020 09:52:54 -0800 (PST)
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-pm@vger.kernel.org
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
 <20200123161644.GA144523@google.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
Date:   Thu, 23 Jan 2020 17:52:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200123161644.GA144523@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/23/20 4:16 PM, Quentin Perret wrote:
> On Wednesday 22 Jan 2020 at 17:35:35 (+0000), Douglas RAILLARD wrote:
>> @@ -210,9 +211,16 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>>  	struct cpufreq_policy *policy = sg_policy->policy;
>>  	unsigned int freq = arch_scale_freq_invariant() ?
>>  				policy->cpuinfo.max_freq : policy->cur;
>> +	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
>>  
>>  	freq = map_util_freq(util, freq, max);
>>  
>> +	/*
>> +	 * Try to get a higher frequency if one is available, given the extra
>> +	 * power we are ready to spend.
>> +	 */
>> +	freq = em_pd_get_higher_freq(pd, freq, 0);
> 
> I find it sad that the call just below to cpufreq_driver_resolve_freq()
> and cpufreq_frequency_table_target() iterates the OPPs all over again.
> It's especially a shame since most existing users of the EM stuff do
> have a cpufreq frequency table.
> 
> Have you looked at hooking this inside cpufreq_driver_resolve_freq()
> instead ? If we have a well-formed EM available, the call to
> cpufreq_frequency_table_target() feels redundant, so we might want to
> skip it.

We can't really move the call to em_pd_get_higher_freq() into
cpufreq_driver_resolve_freq() since that's a schedutil-specific feature,
and we would loose the !sg_policy->need_freq_update optimization.

Maybe we can add a flag to cpufreq_driver_resolve_freq() that promises
that the frequency is already a valid one. We have to be careful though,
since a number of things can make that untrue:
 - em_pd_get_higher_freq() will return the passed freq verbatim if it's
higher than the max freq, so em_pd_get_higher_freq() will have to set
the flag itself in case that logic changes.
 - policy limits can change the value
 - future things could tinker with the freq and forget to reset the flag.

If you think it's worth it I can make these changes.

> Thoughts ?
> 
> Quentin
> 

Cheers,
Douglas
