Return-Path: <linux-pm+bounces-7515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01AE8BC5CD
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 04:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6E28176C
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 02:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB610A26;
	Mon,  6 May 2024 02:39:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DC181;
	Mon,  6 May 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714963168; cv=none; b=Z+C5vjfLa3AsBstpJFYYmqRJ3ZacOD+nmlq6A7l0ODufhrBicMLiEAzSr+1jcIxVDuOwJtN7csd62YWJsi4QGX4nOrW5kO9UCqjFU52L8xIFVT2fF9G/HOPZhu4RVF22QmbSdfU8czcHYCf24bQj8A3NqrXaFs5E2VrtZK743E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714963168; c=relaxed/simple;
	bh=yUj4FVG11bJferK/7H08PTUjooXrvrHykqiMmLpF/3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CX2ltAIweM8QLA9yoRWb9CRIelGsYwgjh5PrsUOUkz6RGAMoSKYI8osVjxPtovnUK2+vvnrxQC2YTYPZFgknJZe0hm1pvcEHf76vz8RVASrgXTXnQ5z2uAxA0blF7VKgsgtf0vIBHR8FnSXzth5sYNWoAnBTvwImFmHV7pJYqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VXlWL6T2sz1HBjZ;
	Mon,  6 May 2024 10:20:46 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DDFE1402D0;
	Mon,  6 May 2024 10:22:01 +0800 (CST)
Received: from [10.174.178.96] (10.174.178.96) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:22:00 +0800
Message-ID: <5c7426ab-71ef-4279-8235-69f5646af8f9@huawei.com>
Date: Mon, 6 May 2024 10:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
To: Pierre Gondois <pierre.gondois@arm.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Beata
 Michalska <beata.michalska@arm.com>, Vanshidhar Konda
	<vanshikonda@os.amperecomputing.com>
CC: <rafael@kernel.org>, <al.stone@linaro.org>, <ashwin.chaugule@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>, <liaoyu15@huawei.com>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <06e3fd1a-a4c0-4be5-840c-e5ba276fe253@arm.com>
From: "liwei (JK)" <liwei728@huawei.com>
In-Reply-To: <06e3fd1a-a4c0-4be5-840c-e5ba276fe253@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500018.china.huawei.com (7.185.36.111)



在 2024/5/3 22:19, Pierre Gondois 写道:
> Hello Liwei,
> The change itself seems ok, but I'm not sure I understand what the
> issue is exactly.
> 
> On 4/29/24 12:49, Viresh Kumar wrote:
>> CC'ing few folks who are working with the driver.
>>
>> On 28-04-24, 17:28, liwei wrote:
>>> When turning on turbo, if frequency configuration takes effect slowly,
>>> the updated policy->cur may be equal to the frequency configured in
>>> governor->limits(), performance governor will not adjust the frequency,
>>> configured frequency will remain at turbo-freq.
>>>
>>> Simplified call stack looks as follows:
>>> cpufreq_register_driver(&cppc_cpufreq_driver)
>>>     ...
>>>     cppc_cpufreq_cpu_init()
>>>         cppc_get_perf_caps()
>>>         policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
>>>             cppc_set_perf(highest_perf) // set highest_perf
>>>             policy->cur = cpufreq_driver->get() // if cur == policy->max
> 
> During the driver initialization, we have:
> cppc_cpufreq_cpu_init()
> \-policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
> \-policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
> \-cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
> \-cppc_set_perf(cpu, &cpu_data->perf_ctrls); // set freq to highest_perf
> so here:
> policy->max = nominal_freq
> policy->cur = highest_freq
> 
> 
> And then for the cpufreq framework:
> cpufreq_online()
> // IIUC there is some delay here, so policy->cur = nominal_freq ?
> // i.e. the freq. was requested to change to the highest_freq,
> // but the change is not effective yet ?
> \-policy->cur = cpufreq_driver->get(policy->cpu);
> \-cpufreq_init_policy()
>    \-cpufreq_set_policy()
>      \-cpufreq_start_governor()
>        \-cpufreq_verify_current_freq()
>          \-new_freq = cpufreq_driver->get(policy->cpu); // new_freq = 
> nominal_freq ?
>          \-if (policy->cur != new_freq)
>          \-  cpufreq_out_of_sync()
>            \- policy->cur = new_freq;
>      \-cpufreq_start_governor()
>        \-cpufreq_gov_performance_limits()
>          \-__cpufreq_driver_target(target_freq=policy->max) // with 
> policy->max = nominal_freq ?
>            \-if (target_freq == policy->cur)
>            \-  // do nothing
> 
> I am not sure I understand when you are turning the turbo on with:
> # echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> Or do you mean that turbo is available but not turned on ?
> 

Sorry, my description is not clear enough. The scenario described above 
is during the kernel initialization process, turbo is available but 
boost is not turned on.

I found this problem is to read 
/sys/devices/system/cpu/cpufreq/policyX/cpuinfo_cur_freq directly after 
OS startup, and found that some frequencies are in turbo state and 
/sys/devices/system/cpu/cpufreq/boost has not been modified, its value 
is still 0.

LiWei
> 
> Regards,
> Pierre
> 
>>>     cpufreq_init_policy()
>>>         ...
>>>         cpufreq_start_governor() // governor: performance
>>>             new_freq = cpufreq_driver->get() // if new_freq == 
>>> policy->max
>>>             if (policy->cur != new_freq)
>>>             cpufreq_out_of_sync(policy, new_freq)
>>>                 ...
>>>                 policy->cur = new_freq
>>>             ...
>>>             policy->governor->limits()
>>>                 __cpufreq_driver_target(policy->max)
>>>                     if (policy->cur==target)
>>>                     // generate error, keep set highest_perf
>>>                         ret
>>>                     cppc_set_perf(target)
>>>
>>> Fix this by changing highest_perf to nominal_perf in 
>>> cppc_cpufreq_cpu_init().
>>>
>>> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with 
>>> CPPC")
>>> Signed-off-by: liwei <liwei728@huawei.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 64420d9cfd1e..db04a82b8a97 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       if (caps->highest_perf > caps->nominal_perf)
>>>           boost_supported = true;
>>> -    /* Set policy->cur to max now. The governors will adjust later. */
>>> -    policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>> -    cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>>> +    /* Set policy->cur to norm now. */
>>> +    policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
>>> +    cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
>>>       ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>       if (ret) {
>>>           pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> -             caps->highest_perf, cpu, ret);
>>> +             caps->nominal_perf, cpu, ret);
>>>           goto out;
>>>       }
>>> -- 
>>> 2.25.1
>>

