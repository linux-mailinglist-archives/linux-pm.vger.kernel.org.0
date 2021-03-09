Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D345B333029
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 21:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhCIUog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 15:44:36 -0500
Received: from foss.arm.com ([217.140.110.172]:59886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhCIUoV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 15:44:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0360A1FB;
        Tue,  9 Mar 2021 12:44:21 -0800 (PST)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED06E3F73C;
        Tue,  9 Mar 2021 12:44:19 -0800 (PST)
Subject: Re: [PATCH 5/5] powercap/drivers/dtpm: Scale the power with the load
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <20210301212149.22877-5-daniel.lezcano@linaro.org>
 <c30701f5-c1f8-cb5c-8791-f4068fb1bc14@arm.com>
 <e1dac038-2100-abdb-2ffe-d0d93952ca21@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a9275548-1555-ce96-51c8-67942d757119@arm.com>
Date:   Tue, 9 Mar 2021 20:44:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e1dac038-2100-abdb-2ffe-d0d93952ca21@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/9/21 7:03 PM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> thanks for your comments, one question below.
> 
> On 09/03/2021 11:01, Lukasz Luba wrote:
> 
> [ ... ]
> 
>>>    +static u64 scale_pd_power_uw(struct cpumask *cpus, u64 power)
>>
>> renamed 'cpus' into 'pd_mask', see below
>>
>>> +{
>>> +    unsigned long max, util;
>>> +    int cpu, load = 0;
>>
>> IMHO 'int load' looks odd when used with 'util' and 'max'.
>> I would put in the line above to have them all the same type and
>> renamed to 'sum_util'.
>>
>>> +
>>> +    for_each_cpu(cpu, cpus) {
>>
>> I would avoid the temporary CPU mask in the get_pd_power_uw()
>> with this modified loop:
>>
>> for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
>>
>>
>>> +        max = arch_scale_cpu_capacity(cpu);
>>> +        util = sched_cpu_util(cpu, max);
>>> +        load += ((util * 100) / max);
>>
>> Below you can find 3 optimizations. Since we are not in the hot
>> path here, it's up to if you would like to use all/some of them
>> or just ignore.
>>
>> 1st optimization.
>> If we use 'load += (util << 10) / max' in the loop, then
>> we could avoid div by 100 and use a right shift:
>> (power * load) >> 10
>>
>> 2nd optimization.
>> Since we use EM CPU mask, which span all CPUs with the same
>> arch_scale_cpu_capacity(), you can avoid N divs inside the loop
>> and do it once, below the loop.
>>
>> 3rd optimization.
>> If we just simply add all 'util' into 'sum_util' (no mul or div in
>> the loop), then we might just have simple macro
>>
>> #define CALC_POWER_USAGE(power, sum_util, max) \
>>      (((power * (sum_util << 10)) / max) >> 10)
> 
> I don't understand the 'max' division, I was expecting here something
> like: ((sum_util << 10) / sum_max) >> 10)
> 
> no ?
> 

No, it should be single 'max', which is in range 0..1024.
We would like to calculate the power for the whole perf domain, e.g.
4 CPUs almost fully utilized would have util ~1000, then total power
should be around ~4 * EM_table[i].power. This '~4' is coming from
4 utils divided by one max util
4000 / 1024


The 'max' in the equation can be put before the bracket, as well as
'power'.

If we had floating point number, simple power for cpu1, cpu2, cpuN
would be just:
power_1 = power * util_1 / max
power_2 = power * util_2 / max
power_N = power * util_N / max
(since they have the same 'max' capacity and the same EM 'power')

The total domain power would be:
total_power = power_1 + power_2 + ... + power_N
which is:
total_power = (power * util_1 / max) + (power * util_2 / max) + ... +
               + (power * util_N / max)

put the 'power' and 'max' before the bracket:
total_power = power * (util_1 + util_2 + ... + util_N) * (1/max)

introduce the 'sum_util':
sum_util = util_1 + util_2 + ... + util_N
then:
total_power = power * sum_util / max

Unfortunately, we don't use floating point, so temporary fixed point
tricks, thus the '<< 10' and '>> 10' avoid some errors



