Return-Path: <linux-pm+bounces-21824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D0A30C00
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D581649B6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D81F0E32;
	Tue, 11 Feb 2025 12:49:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D21EF0AB
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278150; cv=none; b=j98q50RFlhxAVRPQqmNJCllY7xZuaHLjxz8KwvozIrQda6+7eeHoHLNQ6WMcjfErQSYl7EeFT4JFcJ64ym2H4RVEwg0dxDkr8GGupF0n4D/uECb12+tys1bR50u1cCokpWdUWKPZLOirLflDqCkm0yz0eTEat/hg5zHMstixDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278150; c=relaxed/simple;
	bh=NV1kB6rcPfCaG34YJh0jyzOzVF5pjLjjMPYeFoeoGow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jMJ8qJYBxyCzALTo5be85EpfVBBxNQ/y+jO9+wHuOeJu3Snw4NGii+jsqbJOxQHLmG+FFORj1NU4F7Tagc+IgNI6pHUynV7yDEE/rUCt+VyPAd2ZAO0im+GqtCejvZrdqI5Qt1lmi7YhjDcKfARdan1+9Rdr7su7ja018215WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ysh4N5KFhzkXQY;
	Tue, 11 Feb 2025 20:45:24 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 555BF1402C4;
	Tue, 11 Feb 2025 20:48:56 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Feb
 2025 20:48:55 +0800
Message-ID: <a7e2a98b-4f1e-ce82-7c2e-3d8993137bd1@hisilicon.com>
Date: Tue, 11 Feb 2025 20:48:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] cpufreq: governor: Fix negative 'idle_time' handling in
 dbs_update()
To: "Chen, Yu C" <yu.c.chen@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "zhenglifeng1@huawei.com"
	<zhenglifeng1@huawei.com>, "lihuisong@huawei.com" <lihuisong@huawei.com>,
	"wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>, "fanghao11@huawei.com"
	<fanghao11@huawei.com>, "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
References: <20250210130659.3533182-1-zhanjie9@hisilicon.com>
 <DM4PR11MB6020403B3E3C9741C020C7F7A0F22@DM4PR11MB6020.namprd11.prod.outlook.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <DM4PR11MB6020403B3E3C9741C020C7F7A0F22@DM4PR11MB6020.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Hi Chen Yu,

On 11/02/2025 00:14, Chen, Yu C wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Jie Zhan <zhanjie9@hisilicon.com>
>> Sent: Monday, February 10, 2025 9:07 PM
>> To: rafael@kernel.org; viresh.kumar@linaro.org
>> Cc: linux-pm@vger.kernel.org; Chen, Yu C <yu.c.chen@intel.com>;
>> linuxarm@huawei.com; jonathan.cameron@huawei.com;
>> zhanjie9@hisilicon.com; zhenglifeng1@huawei.com; lihuisong@huawei.com;
>> wanghuiqiang@huawei.com; fanghao11@huawei.com;
>> prime.zeng@hisilicon.com
>> Subject: [PATCH] cpufreq: governor: Fix negative 'idle_time' handling in
>> dbs_update()
>>
>> We observed an issue that the cpu frequency can't raise up with a 100% cpu
>> load when nohz is off and the 'conservative' governor is selected.
>>
>> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy()
>> when nohz is off.  This was found and explained in commit 9485e4ca0b48
>> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
>>
>> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detection
>> logic in load calculation") introduced a comparison between 'idle_time' and
>> 'samling_rate' to detect a long idle interval.  While 'idle_time' is converted to
>> int before comparison, it's actually promoted to unsigned again when
>> compared with an unsigned 'sampling_rate'.  Hence, this leads to wrong idle
>> interval detection when it's in fact 100% busy and sets policy_dbs-
>>> idle_periods to a very large value.  'conservative' adjusts the frequency to
>> minimum because of the large 'idle_periods', such that the frequency can't
>> raise up.  'Ondemand' doesn't use policy_dbs->idle_periods so it fortunately
>> avoids the issue.
>>
>> Modify negative 'idle_time' to 0 before any use of it in dbs_update().
>>
>> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic in load
>> calculation")
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>  drivers/cpufreq/cpufreq_governor.c | 41 ++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_governor.c
>> b/drivers/cpufreq/cpufreq_governor.c
>> index af44ee6a6430..cd045ca2268c 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -147,6 +147,20 @@ unsigned int dbs_update(struct cpufreq_policy
>> *policy)
>>
>>  		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
>>  		j_cdbs->prev_cpu_idle = cur_idle_time;
>> +		/*
>> +		 * idle_time can be negative if cur_idle_time is returned by
>> +		 * get_cpu_idle_time_jiffy() when NO_HZ is off.  In that case
>> +		 * idle_time is roughly equal to the difference between
>> +		 * time_elapsed and "busy time" obtained from CPU statistics.
>> +		 * Then, the "busy time" can end up being greater than
>> +		 * time_elapsed (for example, if jiffies_64 and the CPU
>> +		 * statistics are updated by different CPUs), so idle_time may
>> +		 * in fact be negative.  That means, though, that the CPU was
>> +		 * busy all the time (on the rough average) during the last
>> +		 * sampling interval, so idle_time should be regarded as 0 in
>> +		 * order to make the further process correct.
>> +		 */
>> +		idle_time = (int)idle_time < 0 ? 0 : idle_time;
> 
> Thanks for catching this. I was wondering if it would be safer to be converted into something below:
> idle_time = cur_idle_time  >  j_cdbs->prev_cpu_idle  ? cur_idle_time - j_cdbs->prev_cpu_idle : 0;
> Because I was thinking if comparing (int)idle_time with X (X could be any type)
> is compiler dependent?
> 
> thanks,
> Chenyu

As far as I know, integer literals would be signed int in this case
regardless of the compiler used, but I'm happy to do what you said if
that's less confusing. 

Thanks,
Jie

...

