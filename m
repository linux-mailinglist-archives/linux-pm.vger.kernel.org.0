Return-Path: <linux-pm+bounces-20726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F1A175D6
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 02:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AF61886F02
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994611BF24;
	Tue, 21 Jan 2025 01:45:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089038B;
	Tue, 21 Jan 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423941; cv=none; b=aBrTLuxdgo4oER0U7jTxxieiGZud81EGHj+tw+CmoJhLzXmatydEwmsHrsYsylmvS0en5fLjCB3lUYBxXCAMnTCRyv88dQY2euFCRcz2QN3VDq0FoCOOC0ufdxWBCRL3tnY2npxEIN0qBPim8AoDgQ0uJYrZQ2yClY2cDH6tDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423941; c=relaxed/simple;
	bh=375nvZnUmo/ZXtzmXpbmPcVNjfzcG6ZqCHCx+K9cXuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CgzYEbfmt6Cr6yR846hc9ZACfuaBSAcn9RtVEGV20sVm5Ns8erFyZRUpMJCVT9VaIh8ZMkZNtIK/bQIFX8jd65eKq+ghPdvWM1E/S33dTjkkicjFX0CXRvuNJ8MufMuc4g+rwNJ7f9bY1rdgmMVVmBtseLOr/mhyeZLpJxMydGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YcVM42c2Qzgc2V;
	Tue, 21 Jan 2025 09:42:24 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 22EE91400CD;
	Tue, 21 Jan 2025 09:45:35 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 09:45:34 +0800
Message-ID: <0c910772-368b-4e30-9ce2-1f68510703c4@huawei.com>
Date: Tue, 21 Jan 2025 09:45:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
 <20250120090102.erm2ffkbnwa5vraa@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250120090102.erm2ffkbnwa5vraa@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/20 17:01, Viresh Kumar wrote:

> On 17-01-25, 18:14, Lifeng Zheng wrote:
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
>>
>> Running set_boost at the end of the online process is a more generic way
>> for all cpufreq drivers.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 5882d7f5e3c1..5a3566c2eb8d 100644
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
>> @@ -1573,6 +1569,18 @@ static int cpufreq_online(unsigned int cpu)
>>  	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>>  		policy->cdev = of_cpufreq_cooling_register(policy);
>>  
>> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>> +	if (policy->boost_enabled != cpufreq_boost_enabled()) {
>> +		policy->boost_enabled = cpufreq_boost_enabled();
>> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> 
> I though you agreed to do some optimization here ?

Sorry. Do I miss something here?

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
>> -- 
>> 2.33.0
> 


