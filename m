Return-Path: <linux-pm+bounces-20530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D661A13551
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 09:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816891887EB4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701119F40A;
	Thu, 16 Jan 2025 08:30:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20930157E88;
	Thu, 16 Jan 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016244; cv=none; b=VbjUlg5n+iWvZi25Lm6KhK+W+VNpcl5U28QRYbvU1EUDCGy2RottAtORYqJ5yr//dPmIrXfjsMwws9b8GahEU27wcYcuB70X8V+jTpjP/jcRenIHlEQD1dKQGgiSNUryxNtspll8oEVVyobGQjMjkof2KNAI1bYOJ5Q+YpyRd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016244; c=relaxed/simple;
	bh=ThHTbKqhHspxKB8L7fR5uEbmaTonukIR1yzoqR0WKkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HgpZNl8i61VRc5y8c2mLDQ6skpXgXuj+oKuyGf0eDIUDqQF59ShemV0R0xb4b2niKRgVLHS1WYr7faqA/e/uYQs12A0WpV9zgvyPUWSBJPp7fWDTfNd1tdG3dUvVTrzL/53mc3GlMezyRzhTZ51FMTK9yBIE6czrmO92vSh32RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YYbZt0cHTz11SV7;
	Thu, 16 Jan 2025 16:27:34 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 69E0E140159;
	Thu, 16 Jan 2025 16:30:37 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jan
 2025 16:30:36 +0800
Message-ID: <17c7ed77-21f1-4093-91fc-f3eaa863d312@huawei.com>
Date: Thu, 16 Jan 2025 16:30:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: Introduce a more generic way to set default
 per-policy boost flag
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
 <20250115100123.241110-3-zhenglifeng1@huawei.com>
 <20250116065408.kjifylpgse5f3k3h@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250116065408.kjifylpgse5f3k3h@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/16 14:54, Viresh Kumar wrote:

> On 15-01-25, 18:01, Lifeng Zheng wrote:
>> In cpufreq_online() of cpufreq.c, the per-policy boost flag is already set
>> to mirror the cpufreq_driver boost during init but using freq_table to
>> judge if the policy has boost frequency. There are two drawbacks to this
>> approach:
>>
>> 1. It doesn't work for the cpufreq drivers that do not use a frequency
>> table. For now, acpi-cpufreq and amd-pstate have to enable boost in policy
>> initialization. And cppc_cpufreq never set policy to boost when going
>> online no matter what the cpufreq_driver boost flag is.
>>
>> 2. If the cpu goes offline when cpufreq_driver boost enabled and then goes
>> online when cpufreq_driver boost disabled, the per-policy boost flag will
>> unreasonably remain true.
> 
> Yeah, this is a problem. I agree. If the global boost is disabled,
> then boost shouldn't be allowed for any of the policies.
> 
>> Running set_boost at the end of the online process is a more generic way
>> for all cpufreq drivers.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 03ae879d50b9..867bda3decfd 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1409,10 +1409,6 @@ static int cpufreq_online(unsigned int cpu)
>>  			goto out_free_policy;
>>  		}
>>  
>> -		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>> -		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
>> -			policy->boost_enabled = true;
>> -
>>  		/*
>>  		 * The initialization has succeeded and the policy is online.
>>  		 * If there is a problem with its frequency table, take it
>> @@ -1576,6 +1572,18 @@ static int cpufreq_online(unsigned int cpu)
>>  	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>>  		policy->cdev = of_cpufreq_cooling_register(policy);
>>  
>> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>> +	if (cpufreq_boost_supported()) {
>> +		policy->boost_enabled = cpufreq_boost_enabled();
>> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> 
> Maybe we can optimize here and not call set_boost() if policy's
> boost_enabled is not changing at all.
>         if (policy->boost_enabled != cpufreq_boost_enabled()) {
>                 policy->boost_enabled = cpufreq_boost_enabled();
>                 ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
>                 ...
>         }

Makes sense. Thanks.

> 
> After this patch, maybe you should simplify the drivers as well, which
> take care of enabling/boost at boot time or setting this flag ?

OK. I'll try to.

> 
>> +		if (ret) {
>> +			/* If the set_boost fails, the online operation is not affected */
>> +			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
>> +				policy->boost_enabled ? "enable" : "disable");
>> +			policy->boost_enabled = !policy->boost_enabled;
>> +		}
>> +	}
>> +
>>  	pr_debug("initialization complete\n");
>>  
>>  	return 0;
> 


