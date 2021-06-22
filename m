Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517BE3B0261
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 13:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFVLJe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 07:09:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFVLJe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 07:09:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D6B31B;
        Tue, 22 Jun 2021 04:07:18 -0700 (PDT)
Received: from [10.57.7.129] (unknown [10.57.7.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2503F694;
        Tue, 22 Jun 2021 04:07:16 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, Chris.Redpath@arm.com,
        Beata.Michalska@arm.com, rjw@rjwysocki.net, amit.kachhap@gmail.com
References: <20210622075925.16189-1-lukasz.luba@arm.com>
 <20210622075925.16189-4-lukasz.luba@arm.com>
 <20210622093258.lddlznwsndpw5mju@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a5d5d6b8-f358-d1d6-86d0-750af76b0cfb@arm.com>
Date:   Tue, 22 Jun 2021 12:07:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210622093258.lddlznwsndpw5mju@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/22/21 10:32 AM, Viresh Kumar wrote:
> Not commenting on the idea itself but just the code changes here.
> 
> On 22-06-21, 08:59, Lukasz Luba wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 802abc925b2a..d79cb9310572 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -14,6 +14,7 @@
>>   
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>> +#include <linux/active_stats.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpufreq.h>
>>   #include <linux/cpu_cooling.h>
>> @@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>>   
>>   		cpufreq_stats_record_transition(policy, freqs->new);
>>   		policy->cur = freqs->new;
>> +
>> +		active_stats_cpu_freq_change(policy->cpu, freqs->new);
>>   	}
>>   }
>>   
>> @@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>>   			    policy->cpuinfo.max_freq);
>>   	cpufreq_stats_record_transition(policy, freq);
>>   
>> +	active_stats_cpu_freq_fast_change(policy->cpu, freq);
>> +
> 
> It would have been better if you would have modified
> cpufreq_stats_record_transition() instead, since that is there for
> similar kind of stats.

That cpufreq_stats_record_transition() is present only if
CONFIG_CPU_FREQ_STAT is set. I didn't wanted to be dependent on
this config.

> 
> Plus don't you need to record this for all policy->cpus instead of
> just policy->cpu ?
> 

It will be accounted for all cpus in that freq domain. The
active_stats_cpu_freq_fast_change() implementation uses
a shared structure (single for whole domain) 'shared_ast':
_active_stats_cpu_freq_change(ast->shared_ast, freq, ts)
(from patch 1/4)
