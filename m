Return-Path: <linux-pm+bounces-27327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 251ABABB9B8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A441B62D39
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED02701CF;
	Mon, 19 May 2025 09:29:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE622701CE;
	Mon, 19 May 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646969; cv=none; b=YDsXs7G+k/95W5lI/DBusbU+2I8byGdfRvhr8N/8e4EMZKGzS3aJGHcQyFzJrjJhl2e5TSYpUCdL4dIc1/wUIF19gV6me5AgNwQX7XlXgWPNS7+aIQwqsBYNH36w8qV3RyH/MWjcXirRGfAj6PzrPRtI0UsGDqJzODP/6xlXYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646969; c=relaxed/simple;
	bh=5c2Ku1wig+ZbqHNf0CWd4HEo00taToj/2izTVObVMQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dUXIT1bVvedfeEcTB4YFzbeOkAqBYlfZ9HnRqA8ZKac6ACEd8hrtcyq49yOq/+gm5Om16ZAN8UfdoF2HBA1etQBh+ZOtmmB5PbFMSvLOVpVZ0Zc06fxbQFGuTokyxP+nTutfSrg361P+qhE0mGcJsyLq3U8G5j/i5Fpg/N1zfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b1C8M5DMWz27hTJ;
	Mon, 19 May 2025 17:30:11 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 70F301402C3;
	Mon, 19 May 2025 17:29:23 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 May
 2025 17:29:22 +0800
Message-ID: <4c4b0140-9126-4586-92f8-f7c9fd7a4a34@huawei.com>
Date: Mon, 19 May 2025 17:29:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <pierre.gondois@arm.com>, <sumitg@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <mario.limonciello@amd.com>,
	<yumpusamongus@gmail.com>, <srinivas.pandruvada@linux.intel.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <cenxinghai@h-partners.com>, <yubowen8@huawei.com>,
	<hepeng68@huawei.com>
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
 <20250519081850.7ycbcw56jzpiwkth@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250519081850.7ycbcw56jzpiwkth@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/5/19 16:18, Viresh Kumar wrote:
> On 07-05-25, 11:19, Lifeng Zheng wrote:
>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>> driver.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> Sumit, can you provide your tag if it looks fine to you ?
> 
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 206079d3bd5b..37065e1b8ebc 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>>  		This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>  		drivers are in use.
>>  
>> +What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_select
> 
> Is the path correct? Should this be cpufreq/policyN/auto_select ?

cpufreq/policyN/ is linked to cpuX/cpufreq/, both paths correct. The
description of freqdomain_cpus uses cpuX/cpufreq/, so I followed.

> 
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index b3d74f9adcf0..3c3d00cec298 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -808,10 +808,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>  
>>  	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>  }
>> +
>> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>> +{
>> +	bool val;
>> +	int ret;
>> +
>> +	ret = cppc_get_auto_sel(policy->cpu, &val);
>> +
>> +	/* show "<unsupported>" when this register is not supported by cpc */
> 
> s/cpc/cppc/ ?

It means Continuous Performance Control, you can see that in ACPI 6.5,
s8.4.6.1 _CPC (Continuous Performance Control). Use "_CPC" might be better.


