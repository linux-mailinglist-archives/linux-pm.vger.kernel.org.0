Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376043B0827
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFVPFO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 11:05:14 -0400
Received: from foss.arm.com ([217.140.110.172]:50728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFVPFO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 11:05:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1863AED1;
        Tue, 22 Jun 2021 08:02:58 -0700 (PDT)
Received: from [10.57.7.129] (unknown [10.57.7.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0B243F718;
        Tue, 22 Jun 2021 08:02:55 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
References: <20210622075925.16189-1-lukasz.luba@arm.com>
 <20210622075925.16189-4-lukasz.luba@arm.com>
 <CAJZ5v0iVwpn0_wCZOh43DOeR2mudWYJyseMdtMsZGR-sjQ1X9Q@mail.gmail.com>
 <4e5476a6-fa9f-a9ef-ff26-8fa1b4bb90c0@arm.com>
 <CAJZ5v0i0KQwTWzbEPbs=0B-j7MkE6C1XP=mZaU1hhQm9HyZGJg@mail.gmail.com>
 <851205af-39d6-3864-bd28-ae84528946c4@arm.com>
 <CAJZ5v0jiu=HpyGt7JpbFsS3dA1MWp9pi7K+wgP5gh+Xn3Jx9kA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ac5bc899-fc68-3aae-3d41-439dc37d2c92@arm.com>
Date:   Tue, 22 Jun 2021 16:02:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jiu=HpyGt7JpbFsS3dA1MWp9pi7K+wgP5gh+Xn3Jx9kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/22/21 3:51 PM, Rafael J. Wysocki wrote:
> On Tue, Jun 22, 2021 at 4:09 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 6/22/21 2:51 PM, Rafael J. Wysocki wrote:
>>> On Tue, Jun 22, 2021 at 3:42 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/22/21 1:28 PM, Rafael J. Wysocki wrote:
>>>>> On Tue, Jun 22, 2021 at 9:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>
>>>>>> The Active Stats framework tracks and accounts the activity of the CPU
>>>>>> for each performance level. It accounts the real residency, when the CPU
>>>>>> was not idle, at a given performance level. This patch adds needed calls
>>>>>> which provide the CPU frequency transition events to the Active Stats
>>>>>> framework.
>>>>>>
>>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>> ---
>>>>>>     drivers/cpufreq/cpufreq.c | 5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>>> index 802abc925b2a..d79cb9310572 100644
>>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>>> @@ -14,6 +14,7 @@
>>>>>>
>>>>>>     #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>>>>
>>>>>> +#include <linux/active_stats.h>
>>>>>>     #include <linux/cpu.h>
>>>>>>     #include <linux/cpufreq.h>
>>>>>>     #include <linux/cpu_cooling.h>
>>>>>> @@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>>>>>>
>>>>>>                    cpufreq_stats_record_transition(policy, freqs->new);
>>>>>>                    policy->cur = freqs->new;
>>>>>> +
>>>>>> +               active_stats_cpu_freq_change(policy->cpu, freqs->new);
>>>>>>            }
>>>>>>     }
>>>>>>
>>>>>> @@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>>>>>>                                policy->cpuinfo.max_freq);
>>>>>>            cpufreq_stats_record_transition(policy, freq);
>>>>>>
>>>>>> +       active_stats_cpu_freq_fast_change(policy->cpu, freq);
>>>>>> +
>>>>>
>>>>> This is quite a bit of overhead and so why is it needed in addition to
>>>>> the code below?
>>>>
>>>> The code below is tracing, which is good for post-processing. We use in
>>>> our tool LISA, when we analyze the EAS decision, based on captured
>>>> trace data.
>>>>
>>>> This new code is present at run time, so subsystems like our thermal
>>>> governor IPA can use it and get better estimation about CPU used power
>>>> for any arbitrary period, e.g. 50ms, 100ms, 300ms, ...
>>>
>>> So can it be made not run when the IPA is not using it?
>>
>> I can make a Kconfig for IPA to select this ACTIVE_STATS.
>> Also, I can add description that this framework is mostly needed
>> for IPA, so don't enable it if you don't use IPA (default is 'n'
>> so it shouldn't harm others).
>>
>> This Active Stats shouldn't be stopped when thermal zone is switching
>> between governors at run time, e.g. IPA -> step_wise -> IPA
>> because when IPA is set next time, it might not have correct CPU
>> stats (what is the current frequency and for how long it has been
>> actively used).
> 
> But after a while it will collect enough useful data I suppose?

True, it will get enough data after a first freq switch made by
cpufreq governor. I don't want to race with schedutil and check
the current freq, but I will check that option too.

> 
>> Beside, switching governors at run time is not a good idea
>> (apart from stress testing them ;) ).
>>
>>>
>>>>>
>>>>> And pretty much the same goes for the idle loop change.  There is
>>>>> quite a bit of instrumentation in that code already and it avoids
>>>>> adding new locking for a reason.  Why is it a good idea to add more
>>>>> locking to that code?
>>>>
>>>> This active_stats_cpu_freq_fast_change() doesn't use the locking, it
>>>> relies on schedutil lock in [1].
>>>
>>> Ah, OK.
>>>
>>> But it still adds overhead AFAICS.
>>
>> Agree, it's an extra code. For platforms which use IPA it's a
>> justifiable cost, weighted by better estimation thanks to this calls.
>> For other platforms, this framework will be set to default 'n' option.
> 
> A general problem with build-time configuration is for distros that
> want to ship one kernel binary to run on multiple hardware platforms.
> They need to enable those options anyway and then get the full cost on
> the platforms that don't need it, but want to use the common binary
> kernel.

I see your point. Fair enough.

> 
> Again, please consider making this new code run only when it is needed
> even if configured in and if it runs, make it as low-overhead as
> possible.
> 

Sure thing. I'll improve this.
