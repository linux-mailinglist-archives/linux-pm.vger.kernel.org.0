Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83A448108
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 15:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhKHOPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 09:15:20 -0500
Received: from foss.arm.com ([217.140.110.172]:50700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238977AbhKHOPU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 09:15:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7B9D6E;
        Mon,  8 Nov 2021 06:12:35 -0800 (PST)
Received: from [10.57.27.158] (unknown [10.57.27.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B173F718;
        Mon,  8 Nov 2021 06:12:31 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <02468805-f626-1f61-7f7f-73ed7dfad034@arm.com>
Date:   Mon, 8 Nov 2021 14:12:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c4a2618f-71ee-b688-6268-08256a8edf10@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thara,

+CC Steev, who discovered this issue with boost
frequency

On 11/5/21 7:12 PM, Thara Gopinath wrote:
> Hi Lukasz,
> 
> 
> On 11/3/21 12:10 PM, Lukasz Luba wrote:
>> Thermal pressure provides a new API, which allows to use CPU frequency
>> as an argument. That removes the need of local conversion to capacity.
>> Use this new API and remove old local conversion code.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 0138b2ec406d..425f351450ad 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -275,10 +275,10 @@ static unsigned int 
>> qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>>   static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>>   {
>> -    unsigned long max_capacity, capacity, freq_hz, throttled_freq;
>>       struct cpufreq_policy *policy = data->policy;
>>       int cpu = cpumask_first(policy->cpus);
>>       struct device *dev = get_cpu_device(cpu);
>> +    unsigned long freq_hz, throttled_freq;
>>       struct dev_pm_opp *opp;
>>       unsigned int freq;
>> @@ -295,17 +295,12 @@ static void qcom_lmh_dcvs_notify(struct 
>> qcom_cpufreq_data *data)
>>       throttled_freq = freq_hz / HZ_PER_KHZ;
>> -    /* Update thermal pressure */
>> -
>> -    max_capacity = arch_scale_cpu_capacity(cpu);
>> -    capacity = mult_frac(max_capacity, throttled_freq, 
>> policy->cpuinfo.max_freq);
>> -
>>       /* Don't pass boost capacity to scheduler */
>> -    if (capacity > max_capacity)
>> -        capacity = max_capacity;
> 
> So, I think this should go into the common 
> topology_update_thermal_pressure in lieu of
> 
> +    if (WARN_ON(max_freq < capped_freq))
> +        return;
> 
> This will fix the issue Steev Klimaszewski has been reporting
> https://lore.kernel.org/linux-arm-kernel/3cba148a-7077-7b6b-f131-dc65045aa348@arm.com/ 
> 
> 
> 

Well, I think the issue is broader. Look at the code which
calculate this 'capacity'. It's just a multiplication & division:

max_capacity = arch_scale_cpu_capacity(cpu); // =1024 in our case
capacity = mult_frac(max_capacity, throttled_freq,
		policy->cpuinfo.max_freq);

In the reported by Steev output from sysfs cpufreq we know
that the value of 'policy->cpuinfo.max_freq' is:
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:2956800

so when we put the values to the equation we get:
capacity = 1024 * 2956800 / 2956800; // =1024
The 'capacity' will be always <= 1024 and this check won't
be triggered:

/* Don't pass boost capacity to scheduler */
if (capacity > max_capacity)
	capacity = max_capacity;


IIUC you original code, you don't want to have this boost
frequency to be treated as 1024 capacity. The reason is because
the whole capacity machinery in arch_topology.c is calculated based
on max freq value = 2841600,
so the max capacity 1024 would be pinned to that frequency
(according to Steeve's log:
[   22.552273] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
CPUs [4-7] )


Having all this in mind, the multiplication and division in your
original code should be done:

capacity = 1024 * 2956800 / 2841600; // = 1065

then clamped to 1024 value.

My change just unveiled this division issue.

With that in mind, I tend to agree that I should have not
rely on passed boost freq value and try to apply your suggestion check.
Let me experiment with that...

Regards,
Lukasz
