Return-Path: <linux-pm+bounces-21993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DCFA33489
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 02:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364A7164626
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544043597D;
	Thu, 13 Feb 2025 01:21:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8178F26
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409671; cv=none; b=XiLC6gCzxdAJ+6louejbXJ+IgDN06g7fTGwytBTJMtRRvaEPY+IjEoErPR8Fd7tYYfBPVVV3GfVwwmiP+H/uDNEkSTzBAp9EOrB4aNoJhk/tl8v6BbFjs1ussCXvWYopx6YmPSO8rXZVz64NJwXtMXOFDg5JkNQCrJP/znbTv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409671; c=relaxed/simple;
	bh=4JLWCn7tcl/RkXPsTSFFVVqcKpQU5PPEo14n/3cDed0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FocKcnmrLRawLz2FuLDrVfU8EF1lFMDbHMSv3n9MaWutXgp4ZhpqTY6D67VfSqdtyvdtZ1Bz0pJ/mNuUsmrQcd7APNd0raCznlOhtK5DKg+Zx47jXK/hz2wjhGJxDnzvC3uQQUFRw3BnxZSMUP+aUl48lF232KJ3x78V+17lxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YtchZ16Drz11Pyd;
	Thu, 13 Feb 2025 09:16:30 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 371F518032E;
	Thu, 13 Feb 2025 09:20:58 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 09:20:57 +0800
Message-ID: <924fad06-c840-28d4-912e-542f659d19b4@hisilicon.com>
Date: Thu, 13 Feb 2025 09:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<yu.c.chen@intel.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <wanghuiqiang@huawei.com>,
	<fanghao11@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250212081438.1294503-1-zhanjie9@hisilicon.com>
 <CAJZ5v0jBs-qNyz2kSkVVh2qmWqfsx_Hs9=V1+JXkd0LHEBA8bQ@mail.gmail.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAJZ5v0jBs-qNyz2kSkVVh2qmWqfsx_Hs9=V1+JXkd0LHEBA8bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 13/02/2025 03:49, Rafael J. Wysocki wrote:
> On Wed, Feb 12, 2025 at 9:22 AM Jie Zhan <zhanjie9@hisilicon.com> wrote:
>>
>> We observed an issue that the cpu frequency can't raise up with a 100% cpu
>> load when nohz is off and the 'conservative' governor is selected.
> 
> NOHZ

Cool.

> 
>>
>> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy()
>> when nohz is off.  This was found and explained in commit 9485e4ca0b48
>> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
>>
>> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detection
>> logic in load calculation") introduced a comparison between 'idle_time' and
>> 'samling_rate' to detect a long idle interval.  While 'idle_time' is
>> converted to int before comparison, it's actually promoted to unsigned
>> again when compared with an unsigned 'sampling_rate'.  Hence, this leads to
>> wrong idle interval detection when it's in fact 100% busy and sets
>> policy_dbs->idle_periods to a very large value.  'conservative' adjusts the
>> frequency to minimum because of the large 'idle_periods', such that the
>> frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_periods
>> so it fortunately avoids the issue.
>>
>> Correct negative 'idle_time' to 0 before any use of it in dbs_update().
>>
>> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic in load calculation")
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>> v2:
>> - Avoid type conversion, compare current and previous idle time before
>>   obtaining 'idle_time'.
>> - Update the explanation in comments.
>>
>> Discussions:
>> v1: https://lore.kernel.org/linux-pm/20250210130659.3533182-1-zhanjie9@hisilicon.com/
>> ---
>>  drivers/cpufreq/cpufreq_governor.c | 42 ++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index af44ee6a6430..c140e3f8d4f9 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -145,7 +145,20 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>                 time_elapsed = update_time - j_cdbs->prev_update_time;
>>                 j_cdbs->prev_update_time = update_time;
>>
>> -               idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
>> +               /*
>> +                * cur_idle_time could be smaller than j_cdbs->prev_cpu_idle if
>> +                * it's obtained from get_cpu_idle_time_jiffy() when NO_HZ is
>> +                * off, where idle_time is calculated by the difference between
>> +                * time elapsed in jiffies and "busy time" obtained from CPU
>> +                * statistics.  If a CPU is 100% busy, the time elapsed and busy
>> +                * time should grow with the same amount in two consecutive
>> +                * samples, but in practice there could be a tiny difference,
>> +                * making the accumulated idle time decrease sometimes.  Hence,
>> +                * in this case, idle_time should be regarded as 0 in order to
>> +                * make the further process correct.
>> +                */
>> +               idle_time = cur_idle_time > j_cdbs->prev_cpu_idle ?
>> +                           cur_idle_time - j_cdbs->prev_cpu_idle : 0;
> 
> Please avoid using the ternary operator in new code.

Sure. Will fix this here and below. 

> 
>>                 j_cdbs->prev_cpu_idle = cur_idle_time;
>>
>>                 if (ignore_nice) {
>> @@ -162,7 +175,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>                          * calls, so the previous load value can be used then.
>>                          */
>>                         load = j_cdbs->prev_load;
>> -               } else if (unlikely((int)idle_time > 2 * sampling_rate &&
>> +               } else if (unlikely(idle_time > 2 * sampling_rate &&
>>                                     j_cdbs->prev_load)) {
>>                         /*
>>                          * If the CPU had gone completely idle and a task has
>> @@ -189,30 +202,13 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>                         load = j_cdbs->prev_load;
>>                         j_cdbs->prev_load = 0;
>>                 } else {
>> -                       if (time_elapsed >= idle_time) {
>> -                               load = 100 * (time_elapsed - idle_time) / time_elapsed;
>> -                       } else {
>> -                               /*
>> -                                * That can happen if idle_time is returned by
>> -                                * get_cpu_idle_time_jiffy().  In that case
>> -                                * idle_time is roughly equal to the difference
>> -                                * between time_elapsed and "busy time" obtained
>> -                                * from CPU statistics.  Then, the "busy time"
>> -                                * can end up being greater than time_elapsed
>> -                                * (for example, if jiffies_64 and the CPU
>> -                                * statistics are updated by different CPUs),
>> -                                * so idle_time may in fact be negative.  That
>> -                                * means, though, that the CPU was busy all
>> -                                * the time (on the rough average) during the
>> -                                * last sampling interval and 100 can be
>> -                                * returned as the load.
>> -                                */
>> -                               load = (int)idle_time < 0 ? 100 : 0;
>> -                       }
>> +                       load = time_elapsed > idle_time ?
>> +                              100 * (time_elapsed - idle_time) / time_elapsed :
>> +                              0;
>>                         j_cdbs->prev_load = load;
>>                 }
>>
>> -               if (unlikely((int)idle_time > 2 * sampling_rate)) {
>> +               if (unlikely(idle_time > 2 * sampling_rate)) {
>>                         unsigned int periods = idle_time / sampling_rate;
>>
>>                         if (periods < idle_periods)
>> --

