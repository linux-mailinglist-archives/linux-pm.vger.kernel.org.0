Return-Path: <linux-pm+bounces-38860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BAC90D02
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 05:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD54E5307
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 04:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7472DF152;
	Fri, 28 Nov 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OCVuDER3"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BA2DC345;
	Fri, 28 Nov 2025 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764302590; cv=none; b=UUTP63AiTSv18PlHmSymUGhV/QrNWrN072ahLzcZfcUnz8XMlo8OSU0Mge5Fl60Mpg8R0lcYYANGzR6itLrtC9TjvsW5GCEppy1fD/w3XwhXyyyCbwCkffbO+L72ScGbAxaGkmZKt3EXG3l1My+v91+EczQ9Enr6d+yXodGv2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764302590; c=relaxed/simple;
	bh=y1yxwBqoYzCm7Qv8bkk1HE89PVsRPmrzPr0yomRdUAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jiJex787GtBU+MR77Q/tcuCELH8xc+2KGTrErkYAwEreBNjcJQ+9Fv5tihUxjEqM5PHww7PJcF1O9MzNJQlgDx5LPrrrgqIMYPLjBncMrqR9FVZsYZxtV9Si+bRZxBo+itqcjl6cD9dQJL3rdIS70vSetOpIejlnWUOk/b88TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OCVuDER3; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8MAvUW4rV8G0L/xgam721c+vsNUeLWAth3J2R5V0TkM=;
	b=OCVuDER3rywZwGDf+qnHHpeOnLrGn2Dfch8wI1XKZVcdLmfg0AmrQo6UsKkfhHeNzKNFCm+lX
	H815frAASLDYBbEh0/XQBrdJbbjAUT3Q5y97r1fIckHrXgdH082MJ33EjxKYt2UbEFwtZW4W4+2
	nQEf9zEoLjhpbTzfN+O8UGE=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dHfjb64GMzmV79;
	Fri, 28 Nov 2025 12:01:07 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 072731A0174;
	Fri, 28 Nov 2025 12:02:57 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Nov
 2025 12:02:56 +0800
Message-ID: <2dbbb205-5a04-457a-b643-e965aaa2a14e@huawei.com>
Date: Fri, 28 Nov 2025 12:02:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Return -EINVAL if no policy is boost supported
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20251126031916.3641176-1-zhenglifeng1@huawei.com>
 <wnnfdvp3r3bg5wztazoijei2uji5xypl4b4wlvlxuwxaizu6g7@2xxyrk7kdxhf>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <wnnfdvp3r3bg5wztazoijei2uji5xypl4b4wlvlxuwxaizu6g7@2xxyrk7kdxhf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/11/26 14:29, Viresh Kumar wrote:
> On 26-11-25, 11:19, Lifeng Zheng wrote:
>> In cpufreq_boost_trigger_state(), if all the policies are boost
>> unsupported, policy_set_boost() will not be called and this function will
>> return 0. But it is better to return an error to indicate that the platform
>> doesn't support boost.
> 
> I am not sure if it is a good idea. If boost isn't supported by any policy then
> the driver shouldn't enable it at all.

Yes. So I think return an error is more reasonable when try to 'echo 1 >
boost' in this situation.

> Also, cpufreq_table_validate_and_sort()
> sets boost supported only if at least one policy supports it.

Sorry, I don't see any connection to cpufreq_table_validate_and_sort().

> 
> We can still have this case where the policy that supports boost is offline, but
> we shouldn't be returning error there and confuse userspace.

Make sense. But it is also confusing when setting 1 to global boost success
but the platform doesn't support boost at all. It seems like there is no
way to distinguish between these two scenarios: the platform does not
support turbo or the turbo-supporting cores are not yet online.

> 
> Having said that, there are a few things I would like to point.
> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index e8d7544b77b8..2df714b24074 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2806,7 +2806,9 @@ static int cpufreq_boost_trigger_state(int state)
>>  {
>>  	struct cpufreq_policy *policy;
>>  	unsigned long flags;
>> -	int ret = 0;
> 
> In the current code, `ret` isn't required to be initialized to 0.
> 
>> +
>> +	/* Return -EINVAL if no policy is boost supported. */
>> +	int ret = -EINVAL;
>>  
>>  	/*
>>  	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
>> @@ -2824,14 +2826,12 @@ static int cpufreq_boost_trigger_state(int state)
>>  
>>  		ret = policy_set_boost(policy, state);
>>  		if (ret)
>> -			goto err_reset_state;
>> +			break;
>>  	}
>>  	cpus_read_unlock();
>>  
>> -	return 0;
>> -
>> -err_reset_state:
>> -	cpus_read_unlock();
> 
> It was a bad idea to mix two things in a single patch. You should have avoided
> optimizing the use of cpus_read_unlock() in this patch.

OK. I'll split that to another patch in the next version. Thanks!

> 
>> +	if (!ret)
>> +		return 0;
>>  
>>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>>  	cpufreq_driver->boost_enabled = !state;
>> -- 
>> 2.33.0
> 


