Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD163389F7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 11:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhCLKWl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 05:22:41 -0500
Received: from foss.arm.com ([217.140.110.172]:50900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233314AbhCLKWe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 05:22:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C391FB;
        Fri, 12 Mar 2021 02:22:33 -0800 (PST)
Received: from [10.57.17.106] (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 177C23F70D;
        Fri, 12 Mar 2021 02:22:31 -0800 (PST)
Subject: Re: [PATCH v3 1/5] powercap/drivers/dtpm: Encapsulate even more the
 code
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
 <d8d3c50c-fee6-6f31-c085-d1ebce5297da@arm.com>
 <aa1ecdaa-3f91-c886-ce1e-45557d01991a@linaro.org>
 <c35d7d49-3772-a231-1690-bbea2af3f4f4@arm.com>
Message-ID: <2f149f7f-5a69-2f0a-07f7-f01644e09c53@arm.com>
Date:   Fri, 12 Mar 2021 10:22:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c35d7d49-3772-a231-1690-bbea2af3f4f4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/12/21 10:11 AM, Lukasz Luba wrote:
> 
> 
> On 3/11/21 10:57 AM, Daniel Lezcano wrote:
>> On 11/03/2021 11:15, Lukasz Luba wrote:
>>> Hi Daniel,
>>>
>>> On 3/10/21 11:02 AM, Daniel Lezcano wrote:
>>>> In order to increase the self-encapsulation of the dtpm generic code,
>>>> the following changes are adding a power update ops to the dtpm
>>>> ops. That allows the generic code to call directly the dtpm backend
>>>> function to update the power values.
>>>>
>>>> The power update function does compute the power characteristics when
>>>> the function is invoked. In the case of the CPUs, the power
>>>> consumption depends on the number of online CPUs. The online CPUs mask
>>>> is not up to date at CPUHP_AP_ONLINE_DYN state in the tear down
>>>> callback. That is the reason why the online / offline are at separate
>>>> state. As there is already an existing state for DTPM, this one is
>>>> only moved to the DEAD state, so there is no addition of new state
>>>> with these changes. The dtpm node is not removed when the cpu is
>>>> unplugged.
>>>>
>>>> That simplifies the code for the next changes and results in a more
>>>> self-encapsulated code.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>> V2:
>>>>    - Updated the changelog with the CPU node not being removed
>>>>    - Commented the cpu hotplug callbacks to explain why there are two
>>>> callbacks
>>>>    - Changed 'upt_power_uw' to 'update_power_uw'
>>>>    - Removed unused cpumask variable
>>>> ---
>>>>    drivers/powercap/dtpm.c     |  54 ++++++-------
>>>>    drivers/powercap/dtpm_cpu.c | 148 
>>>> ++++++++++++++++--------------------
>>>>    include/linux/cpuhotplug.h  |   2 +-
>>>>    include/linux/dtpm.h        |   3 +-
>>>>    4 files changed, 97 insertions(+), 110 deletions(-)
>>>>
>>>
>>> [snip]
>>>
>>>> @@ -210,27 +175,20 @@ static int cpuhp_dtpm_cpu_online(unsigned int 
>>>> cpu)
>>>>        for_each_cpu(cpu, policy->related_cpus)
>>>>            per_cpu(dtpm_per_cpu, cpu) = dtpm;
>>>>    -    sprintf(name, "cpu%d", dtpm_cpu->cpu);
>>>> +    sprintf(name, "cpu%d-cpufreq", dtpm_cpu->cpu);
>>>
>>> We should be safe in normal platforms, since there is less than
>>> < 300 cores. although, I would use 2x CPUFREQ_NAME_LEN array.
>>
>> I'm counting 9999 cores.
>>
>> We have:
>> #define CPUFREQ_NAME_LEN 16
>>
>> "cpu-cpufreq\0" counts 12 characters.
>>
>> There are 4 characters left, 9999 max then, no ?
> 
> Yes, my '< 300' was referring to some server platforms,
> which IIRC had 2 sockets, each with 128 cores. I don't
> know about future, though.
> 
>>
>> The code is designed for cpufreq with the energy model which targets
>> ARM64 architecture and AFAICT we are far away of having so many cores on
>> our phones.
> 
> True, otherwise with such big number of cores in mobile, we would face
> probably more hard to investigate issues, than this simple one ;)
> 
>>
>> Except I'm wrong, I would prefer to keep the current CPUFREQ_NAME_LEN to
>> not introduce subtle bugs (like stack overflow) if the length is
>> increased in cpufreq.h.
>>
>> What do you think ?
> 
> Agree, please skip my former comment and just take the reviewed tag.

What you could do, though, is to use:

snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);

just to play safe.
