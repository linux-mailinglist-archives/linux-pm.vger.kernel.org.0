Return-Path: <linux-pm+bounces-7703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FEB8C1CC3
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 05:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BE9280F1D
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD4148846;
	Fri, 10 May 2024 03:06:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934714882B;
	Fri, 10 May 2024 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310417; cv=none; b=D37B++FTzF1ixfrF0ytYj2JoZ4QYRXf0PbWY9DfiVRYIAw2CUHN/IhUdMIOlUYb/5c8QjMXMI1GAACoG5bTCzpOJpkBCxRUPmEDDdt4iDRUQusNV3cZzeVgPJo9189PhYkqB1NSIRT7of8XDBzc+knh9qR4e5yQ/uvSviL8DfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310417; c=relaxed/simple;
	bh=dIqiVjHurELLJ7PCOwbTi79bOof0c/G+LGiyT31FLJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f06yNH8zCGiziOxmVzFqR52Eefs8qeTxM333yGg9otyTfpAq8ilRd63RJvmOacBur6o8BkWutOuOOtC0gM5cyXE6msWukhZ1KjP8wfpHZsJu9QYV6V/6lqw2NVuXUMtC0/jr17mKa3F9mz0y8bwv/Z0XXP6UoGcmUPZeEWD66nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VbDKJ0K7czCrWj;
	Fri, 10 May 2024 11:05:40 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id E558C18007A;
	Fri, 10 May 2024 11:06:51 +0800 (CST)
Received: from [10.174.178.96] (10.174.178.96) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:06:51 +0800
Message-ID: <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
Date: Fri, 10 May 2024 11:06:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
To: Ionela Voinescu <ionela.voinescu@arm.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Beata Michalska <beata.michalska@arm.com>, Vanshidhar Konda
	<vanshikonda@os.amperecomputing.com>, <rafael@kernel.org>,
	<al.stone@linaro.org>, <ashwin.chaugule@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>, <liaoyu15@huawei.com>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7> <ZjoBrF4bAK5ukm7H@arm.com>
From: "liwei (JK)" <liwei728@huawei.com>
In-Reply-To: <ZjoBrF4bAK5ukm7H@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)

Hello,

Thanks for for your reply.

Maybe my description has caused you some misunderstandings, please allow 
me to supplement the description

在 2024/5/7 18:25, Ionela Voinescu 写道:
> Hi,
> 
> Thanks for adding me to this.
> 
> On Monday 29 Apr 2024 at 16:19:45 (+0530), Viresh Kumar wrote:
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
>>> 	...
>>> 	cppc_cpufreq_cpu_init()
>>> 		cppc_get_perf_caps()
>>> 		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
>>> 			cppc_set_perf(highest_perf) // set highest_perf
>>> 			policy->cur = cpufreq_driver->get() // if cur == policy->max
>>> 	cpufreq_init_policy()
>>> 		...
>>> 		cpufreq_start_governor() // governor: performance
>>> 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
>>> 			if (policy->cur != new_freq)
>>> 			cpufreq_out_of_sync(policy, new_freq)
>>> 				...
>>> 				policy->cur = new_freq
> I believe the problem is here   ^^^^^^^^^^^^^^^^^^^^^^.
> 
> cpufreq_verify_current_freq() should not update policy->cur unless a
> request to change frequency has actually reached the driver. I believe
> policy->cur should always reflect the request, not the actual current
> frequency of the CPU.
> 
> Given that new_freq is the current (hardware) frequency of the CPU,
> obtained via .get(), it can be the nominal frequency, as it is in your
> case, or any frequency, if there is any firmware/hardware capping in
> place.
> 
> This causes the issue in your scenario, in which __cpufreq_driver_target()
> filters the request from the governor as it finds it equal to policy->cur,
> and it believes it's already set by hardware.
> 
> This causes another issue in which scaling_cur_freq, which for some
> systems returns policy->cur, ends up returning the hardware frequency of
> the CPUs, and not the last frequency request, as it should:
> 
> "scaling_cur_freq
> Current frequency of all of the CPUs belonging to this policy (in kHz).
> 
> In the majority of cases, this is the frequency of the last P-state
> requested by the scaling driver from the hardware using the scaling
> interface provided by it, which may or may not reflect the frequency
> the CPU is actually running at (due to hardware design and other
> limitations)." [1]
> 
> Therefore policy->cur gets polluted with the hardware frequency of the
> CPU sampled at that one time, and this affects governor decisions, as
> in your case, and scaling_cur_freq feedback as well. This bad value will
> not change until there's another .target() or cpufreq_out_of_sync()
> call, which will never happen for fixed frequency governors like the
> performance governor.
> 
> Thanks,
> Ionela.
> 

In the above function calling process, the frequency is obtained twice. 
The first time is in cpufreq_online(), and the second time is in 
cpufreq_verify_current_freq().

When the frequency configuration takes effect slowly, the kernel cannot 
sense when the frequency configuration takes effect. It may take effect 
before the frequency is read twice, between the frequencies read twice, 
or after the frequency is read twice.

|------------------|--------------------|---------------------|
set highest_freq  get()               get()                target()

If it takes effect before two read operations, there will be no problem.

If it takes effect between two read operations, policy->cur will be 
updated in cpufreq_verify_current_freq(), the execution path is as follows:
new_freq = cpufreq_driver->get() //  new_freq = turbo_freq
	if (policy->cur != new_freq)
		cpufreq_out_of_sync(policy, new_freq)
			...
			policy->cur = new_freq // cur = turbo_freq
...
__cpufreq_driver_target(policy->max)
	cppc_set_perf(target) // policy->cur!=target

Reconfigure frequency to policy->max.

If policy->cur is not set to turbo_freq after two read operations, 
policy->cur will not be updated in cpufreq_verify_current_freq(), the 
execution path is as follows:
new_freq = cpufreq_driver->get() //  new_freq == policy->cur
	if (policy->cur != new_freq)
...
__cpufreq_driver_target(policy->max)
	ret // policy->cur==target

Configured frequency will remain at turbo-freq.

When reading scaling_cur_freq, the frequency value that may be read is 
policy->cur. If arch does not implement arch_freq_get_on_cpu(), and the 
registered cpufreq_driver does not define setpolicy()/get(), the 
frequency will not be obtained through the get() and will directly feed 
back policy->cur. If the above problem occurs, no exception will be 
detected when reading scaling_cur_freq. But reading cpuinfo_cur_freq 
will reacquire the frequency through the get() interface and feedback 
the newly acquired frequency value.

Thanks
liwei

> 
> [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
> 
>>> 			...
>>> 			policy->governor->limits()
>>> 				__cpufreq_driver_target(policy->max)
>>> 					if (policy->cur==target)
>>> 					// generate error, keep set highest_perf
>>> 						ret
>>> 					cppc_set_perf(target)
>>>
>>> Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().
>>>
>>> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
>>> Signed-off-by: liwei <liwei728@huawei.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 64420d9cfd1e..db04a82b8a97 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>   	if (caps->highest_perf > caps->nominal_perf)
>>>   		boost_supported = true;
>>>   
>>> -	/* Set policy->cur to max now. The governors will adjust later. */
>>> -	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>> -	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>>> +	/* Set policy->cur to norm now. */
>>> +	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
>>> +	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
>>>   
>>>   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>   	if (ret) {
>>>   		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> -			 caps->highest_perf, cpu, ret);
>>> +			 caps->nominal_perf, cpu, ret);
>>>   		goto out;
>>>   	}
>>>   
>>> -- 
>>> 2.25.1
>>
>> -- 
>> viresh

