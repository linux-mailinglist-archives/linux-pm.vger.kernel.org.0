Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBE2C04A1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgKWLeu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 06:34:50 -0500
Received: from foss.arm.com ([217.140.110.172]:43448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgKWLeu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Nov 2020 06:34:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF85530E;
        Mon, 23 Nov 2020 03:34:49 -0800 (PST)
Received: from [10.57.28.98] (unknown [10.57.28.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 228503F70D;
        Mon, 23 Nov 2020 03:34:46 -0800 (PST)
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>, linux-pm@vger.kernel.org
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
 <be46b60a-0304-8fe0-53cf-3c179a8fd04a@arm.com>
 <20201123104119.g46y6idk734pw7fl@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bb7d4b51-d609-b407-4f92-d2bec8273031@arm.com>
Date:   Mon, 23 Nov 2020 11:34:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201123104119.g46y6idk734pw7fl@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/23/20 10:41 AM, Viresh Kumar wrote:
> On 20-11-20, 14:51, Lukasz Luba wrote:
>> On 11/19/20 7:38 AM, Viresh Kumar wrote:
>>> Scenario 1: The CPUs were mostly idle in the previous polling window of
>>> the IPA governor as the tasks were sleeping and here are the details
>>> from traces (load is in %):
>>>
>>>    Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
>>>    New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960
>>>
>>> Here, the "Old" line gives the load and requested_power (dynamic_power
>>> here) numbers calculated using the idle time based implementation, while
>>> "New" is based on the CPU utilization from scheduler.
>>>
>>> As can be clearly seen, the load and requested_power numbers are simply
>>> incorrect in the idle time based approach and the numbers collected from
>>> CPU's utilization are much closer to the reality.
>>
>> It is contradicting to what you have put in 'Scenario 1' description,
>> isn't it?
> 
> At least I didn't think so when I wrote this and am still not sure :)
> 
>> Frequency at 1.2GHz, 75% total_load, power 4W... I'd say if CPUs were
>> mostly idle than 1.3W would better reflect that state.
> 
> The CPUs were idle because the tasks were sleeping, but once the tasks
> resume to work, we need a frequency that matches the real load of the
> tasks. This is exactly what schedutil would ask for as well as it uses
> the same metric and so we should be looking to ask for the same power
> budget..

Yes, agree.

> 
>> What was the IPA period in your setup?
> 
> It is 100 ms by default, though I remember that I tried with 10 ms as
> well.
> 
>> It depends on your platform IPA period (e.g. 100ms) and your current
>> runqueues state (at that sampling point in time). The PELT decay/rise
>> period is different. I am not sure if you observe the system avg load
>> for last e.g. 100ms looking at these signals. Maybe IPA period is too
>> short/long and couldn't catch up with PELT signals?
>> But we won't too short averaging, since 16ms is a display tick.
>>
>> IMHO based on this result it looks like the util could lost older
>> information from the past or didn't converge yet to this low load yet.
>>
>>>
>>> Scenario 2: The CPUs were busy in the previous polling window of the IPA
>>> governor:
>>>
>>>    Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
>>>    New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672
>>>
>>> As can be seen, the idle time based load is 100% for all the CPUs as it
>>> took only the last window into account, but in reality the CPUs aren't
>>> that loaded as shown by the utilization numbers.
>>
>> This is also odd. The ~88% of total_load, looks like started decaying or
>> didn't converge yet to 100% or some task vanished?
> 
> They must have decayed a bit because of the idle period, so looks okay
> that way.
> 

I have experimented with this new estimation and compared with real
power meter and other models. It looks good, better than current
mainline. I will continue experiments, but this patch LGTM and
I will add my reviewed-by today (after finishing it).

It would make more sense to adjust IPA period to util signal then the
opposite. I have to play with this a bit...

Regards,
Lukasz
