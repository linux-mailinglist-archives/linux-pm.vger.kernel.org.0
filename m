Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55144A9A0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbhKIIte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 03:49:34 -0500
Received: from foss.arm.com ([217.140.110.172]:58496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242854AbhKIItd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 03:49:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81E42B;
        Tue,  9 Nov 2021 00:46:47 -0800 (PST)
Received: from [10.57.26.224] (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0953F7F5;
        Tue,  9 Nov 2021 00:46:43 -0800 (PST)
Subject: Re: [PATCH v3 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure
 update function
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        Steev Klimaszewski <steev@kali.org>
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <20211103161020.26714-5-lukasz.luba@arm.com>
 <c4a2618f-71ee-b688-6268-08256a8edf10@linaro.org>
 <02468805-f626-1f61-7f7f-73ed7dfad034@arm.com>
 <af73cc0a-4dd2-832f-13b0-08807df64ce2@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e4907877-6cfe-57fe-74b4-6d4efeb1d25a@arm.com>
Date:   Tue, 9 Nov 2021 08:46:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <af73cc0a-4dd2-832f-13b0-08807df64ce2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/8/21 9:23 PM, Thara Gopinath wrote:
> 
> 
> On 11/8/21 9:12 AM, Lukasz Luba wrote:
> ...snip
> 
>>>
>>>
>>
>> Well, I think the issue is broader. Look at the code which
>> calculate this 'capacity'. It's just a multiplication & division:
>>
>> max_capacity = arch_scale_cpu_capacity(cpu); // =1024 in our case
>> capacity = mult_frac(max_capacity, throttled_freq,
>>          policy->cpuinfo.max_freq);
>>
>> In the reported by Steev output from sysfs cpufreq we know
>> that the value of 'policy->cpuinfo.max_freq' is:
>> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:2956800
>>
>> so when we put the values to the equation we get:
>> capacity = 1024 * 2956800 / 2956800; // =1024
>> The 'capacity' will be always <= 1024 and this check won't
>> be triggered:
>>
>> /* Don't pass boost capacity to scheduler */
>> if (capacity > max_capacity)
>>      capacity = max_capacity;
>>
>>
>> IIUC you original code, you don't want to have this boost
>> frequency to be treated as 1024 capacity. The reason is because
>> the whole capacity machinery in arch_topology.c is calculated based
>> on max freq value = 2841600,
>> so the max capacity 1024 would be pinned to that frequency
>> (according to Steeve's log:
>> [   22.552273] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) 
>> for CPUs [4-7] )
> 
> Hi Lukasz,
> 
> Yes you are right in that I was using policy->cpuinfo.max_freq where as 
> I should have used freq_factor. So now that you are using freq_factor, 
> it makes sense to cap the capacity at the max capacity calulated by the 
> scheduler.
> 
> I agree that the problem is complex because at some point we should look 
> at rebuilding the topology based on changes to policy->cpuinfo.max_freq.
> 

I probably cannot fix your driver easily right now. What I can do and is
actually required for this new API arch_update_thermal_pressure() is to
accept boost frequencies (values which are higher that 'freq_factor')
without triggering a warning and just setting the thermal pressure to 0
(since we are told that the frequency capping is completely removed even
for boost values).

The next step would be to perform longer investigation how the boost
frequencies are accepted then triggered/used by scheduler and other
involved machinery.

I've asked Steev for help with setting up this Rockchip RK3399 new boost
frequency which actually is used. I want to understand why that platform
is able to use the boost freq and this Qcom SoC is not able to use it.

I agree with you that at some point we might need to try rebuilding the
topology information based on these policy->cpuinfo.max_freq changes.

I hope it would take only a few steps to fix these issues completely,
without destroying a lot of existing code...

Regards,
Lukasz
