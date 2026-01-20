Return-Path: <linux-pm+bounces-41143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F33D3BCC0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 02:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897A83041A5B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C221EFF93;
	Tue, 20 Jan 2026 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="RDcEvIb4"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58451DE4E1;
	Tue, 20 Jan 2026 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871393; cv=none; b=lAVZOTHq5iVGSs2NeZwnT0TvmdYYK55fJhXMur6cjmD4RQQLgF6i+i7JZOsT3gr9Ak2pVZ1tZ3Ftf2U9d6BtsjXxedqSMk4+X2bhEUqXQVUtHPvdlwrcPMGtsY9lzmfZ+1pfM+zL4Cb1070OEHc8qY29TcmbJGZ+h+72HPhBvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871393; c=relaxed/simple;
	bh=7sFxBBNxDcOZJTnHajHi+T0Mwp7mSh3I01BydKtWtkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ti1nUVLzenUyEi0+LNsfEHqNWKdNxzQGuEwqcPJ2UcRjbonczRcOqa3NoLt47dKenu5uqPWNDNXI/lDS0+NlXPS7+LxD1UjTIhIi8++Q6RS3NMfq2D5j1M378u4xDEood9hSnwfYrS3CumL5Mvue4ZJJv9HEaN/DZsJ7P0LuoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=RDcEvIb4; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/UMW3P7hcG1wLv09HSL9t5EbN9hDkAdQkyIJvzcPwwo=;
	b=RDcEvIb4ytCUvO6iN0mLZH+lwzigmnSsEOtbMj1nMJz9gegjGsTuvwafRrexUge6mmcvCgu1M
	H00Q4BA6BgnhqY+4nfkAxuBsTeVn9xYWe/aXe9Z/TPIG4efj6+EFHc/RI3A+rIh8au+EaX9ywmK
	vVIVDE8J/vULI7md/GWbD/g=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dw8KK5KHmz1cyTB;
	Tue, 20 Jan 2026 09:06:13 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC14402AB;
	Tue, 20 Jan 2026 09:09:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 09:09:36 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 20 Jan
 2026 09:09:35 +0800
Message-ID: <7ee9b7a2-db18-48f1-804a-8a4c8a8d05a3@huawei.com>
Date: Tue, 20 Jan 2026 09:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpufreq: userspace: make scaling_setspeed return the
 actual requested frequency
To: Viresh Kumar <viresh.kumar@linaro.org>, Pengjie Zhang
	<zhangpengjie2@huawei.com>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <linhongye@h-partners.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260116094623.2980031-1-zhangpengjie2@huawei.com>
 <ny7npyivbpk3zaf3dm6h3ves4azp75hzmrqmpiex3nauuzrzmt@zf3rto3vrjbq>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <ny7npyivbpk3zaf3dm6h3ves4azp75hzmrqmpiex3nauuzrzmt@zf3rto3vrjbq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 1/19/2026 4:28 PM, Viresh Kumar wrote:
> On 16-01-26, 17:46, Pengjie Zhang wrote:
>> According to the Linux kernel ABI documentation for 'scaling_setspeed':
>>    "It returns the last frequency requested by the governor (in kHz) or
>>     can be written to in order to set a new frequency for the policy."
>>
>> However, the current implementation of show_speed() returns 'policy->cur'.
>> 'policy->cur' represents the frequency after the driver has
>> resolved the request against the hardware frequency table and applied
>> policy limits (min/max).
>>
>> This creates a discrepancy between the documentation/user expectation and
>> the actual code behavior. For instance:
>>
>> 1. User writes a value to 'scaling_setspeed' that is not in the OPP table
>>     (e.g., user asks for A, driver rounds it to B).
>> 2. User reads 'scaling_setspeed'.
>> 3. Code returns B ('policy->cur').
>> 4. User expects A (the "frequency requested"), but gets B.
>>
>> This patch changes show_speed() to return 'userspace->setspeed', which
>> stores the actual value last requested by the user. This restores the
>> read/write symmetry of the attribute and aligns the code with the ABI
>> description.
>>
>> The effective frequency can still be observed via 'scaling_cur_freq' or
>> 'cpuinfo_cur_freq', preserving the distinction between "what was
>> requested" (setspeed) and "what is effective" (cur_freq).
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>>   drivers/cpufreq/cpufreq_userspace.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
>> index 77d62152cd38..4bd62e6c5c51 100644
>> --- a/drivers/cpufreq/cpufreq_userspace.c
>> +++ b/drivers/cpufreq/cpufreq_userspace.c
>> @@ -49,7 +49,9 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
>>   
>>   static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
>>   {
>> -	return sprintf(buf, "%u\n", policy->cur);
>> +	struct userspace_policy *userspace = policy->governor_data;
>> +
>> +	return sprintf(buf, "%u\n", userspace->setspeed);
>>   }
>>   
>>   static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
> Looks okay to me.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
This fix is more reasonable. Each interface has its own responsibility 
and no repeat.
Acked-by: lihuisong@huawei.com

