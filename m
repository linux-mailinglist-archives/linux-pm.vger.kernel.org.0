Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFC15A817
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgBLLnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 06:43:19 -0500
Received: from foss.arm.com ([217.140.110.172]:59864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBLLnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 06:43:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1EF30E;
        Wed, 12 Feb 2020 03:43:18 -0800 (PST)
Received: from [10.37.12.187] (unknown [10.37.12.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 487C53F68F;
        Wed, 12 Feb 2020 03:43:14 -0800 (PST)
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        sudeep.holla@arm.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
 <a24aa6c86e7a565b6269f48d4026bca2@kernel.org>
 <289c6110-b7ea-1d61-d795-551723263803@arm.com>
 <f01a6384e7297de87a434e83bd1479d8@kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b7b0f4c6-cf59-e390-a67b-cfe3ff50a61f@arm.com>
Date:   Wed, 12 Feb 2020 11:43:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f01a6384e7297de87a434e83bd1479d8@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/12/20 11:10 AM, Marc Zyngier wrote:
> On 2020-02-12 10:55, Lukasz Luba wrote:
>> On 2/12/20 10:12 AM, Marc Zyngier wrote:
>>> On 2020-02-12 10:01, Lukasz Luba wrote:
>>>> Hi Ionela, Valentin
>>>>
>>>> On 2/11/20 6:45 PM, Ionela Voinescu wrote:
>>>>> From: Valentin Schneider <valentin.schneider@arm.com>
>>>>>
>>>>> Using an arch timer with a frequency of less than 1MHz can result 
>>>>> in an
>>>>> incorrect functionality of the system which assumes a reasonable rate.
>>>>>
>>>>> One example is the use of activity monitors for frequency invariance
>>>>> which uses the rate of the arch timer as the known rate of the 
>>>>> constant
>>>>> cycle counter in computing its ratio compared to the maximum frequency
>>>>> of a CPU. For arch timer frequencies less than 1MHz this ratio could
>>>>> end up being 0 which is an invalid value for its use.
>>>>>
>>>>> Therefore, warn if the arch timer rate is below 1MHz which contravenes
>>>>> the recommended architecture interval of 1 to 50MHz.
>>>>>
>>>>> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>>> ---
>>>>>   drivers/clocksource/arm_arch_timer.c | 18 +++++++++++++++---
>>>>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clocksource/arm_arch_timer.c 
>>>>> b/drivers/clocksource/arm_arch_timer.c
>>>>> index 9a5464c625b4..4faa930eabf8 100644
>>>>> --- a/drivers/clocksource/arm_arch_timer.c
>>>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>>>> @@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned 
>>>>> int cpu)
>>>>>       return 0;
>>>>>   }
>>>>>   +static int validate_timer_rate(void)
>>>>> +{
>>>>> +    if (!arch_timer_rate)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    /* Arch timer frequency < 1MHz can cause trouble */
>>>>> +    WARN_ON(arch_timer_rate < 1000000);
>>>>
>>>> I don't see a big value of having a patch just to add one extra 
>>>> warning,
>>>> in a situation which we handle in our code with in 6/7 with:
>>>>
>>>> +    if (!ratio) {
>>>> +        pr_err("System timer frequency too low.\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>>
>>>> Furthermore, the value '100000' here is because of our code and
>>>> calculation in there, so it does not belong to arch timer. Someone
>>>> might ask why it's not 200000 or a define in our header...
>>>> Or questions asking why do you warn when that arch timer and cpu is not
>>>> AMU capable...
>>>
>>> Because, as the commit message outlines it, such a frequency is terribly
>>> out of spec?
>>
>> I don't see in the RM that < 1MHz is terribly out of spec.
>> 'Frequency
>> Increments at a fixed frequency, typically in the range 1-50MHz.
>> Can support one or more alternative operating modes in which it
>> increments by larger amounts at a
>> lower frequency, typically for power-saving.'
> 
> Hint: constant apparent frequency.
> 
>> There is even an example how to operate at 20kHz and increment by 500.
>>
>> I don't know the code if it's supported, thought.
> 
> You're completely missing the point, I'm afraid. Nobody has to know that
> this is happening. For all intent and purposes, the counter has always
> the same frequency, even if the HW does fewer ticks of larger increments.

Fair enough. As I said I don't know details of that code.

> 
> 
> [...]
> 
>>>> Lastly, this is arch timer.
>>>> To increase chances of getting merge soon, I would recommend to drop
>>>> the patch from this series.
>>>
>>> And? It seems to address a potential issue where the time frequency
>>> is out of spec, and makes sure we don't end up with additional problems
>>> in the AMU code.
>>
>> This patch just prints warning, does not change anything in booting or
>> in any code related to AMU.
> 
> It seems to solve an issue with an assumption made in the AMU driver,
> and would help debugging the problem on broken systems. Are you saying
> that this is not the case and that the AMU code can perfectly cope with
> the frequency being less than 1MHz?

What I was saying is that patch 6/7 has the code which checks the rate
and reacts, so it does not need this patch. In case of helping with
debugging, the patch 6/7 also prints error
"System timer frequency too low" and bails out.
The commit message could have better emphasize it.

Regards,
Lukasz
