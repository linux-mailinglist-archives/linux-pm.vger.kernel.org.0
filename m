Return-Path: <linux-pm+bounces-22376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330CA3AFBF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16C27A45D1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD2188938;
	Wed, 19 Feb 2025 02:43:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99218BB8E
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932986; cv=none; b=oA1PmZhTjcTc1FNvJGOtu0IhQCGqJmyU3ez4NfG2gZbWmdwIdXtjHcFjeD1acLle+Fz5W6ddHVe32CnGlQd1rwdW0y7fzlNaQd7Hn7s5Vd2QlCPzwDYq2mCYGKrJo67I+NPPBiruO6RACZMPoNxcDiulMtEcWV8r1e92bzusR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932986; c=relaxed/simple;
	bh=/yF0QXSDDAEyGW3V64TMk/uKgpcNoAYy6YqoXJOdxUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZOWOQAZzYwsXmwTTv7uSOr+kF4Yn/NFW70kwbrucKrrIwd+vKIvGmrQnwlbI23rQqejF10W1GUWrNk8zxUB6e2Ymuocs5vOIh3Z7Hb5uO3eXRtl8Jb0k5Xbrk3hz0oNNQaSujpuwAYPok8CFwVK+Xk5MiwY150v0J5VpsAs9TSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YyLDG40RVzjYDm;
	Wed, 19 Feb 2025 10:38:22 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 7052D1800DB;
	Wed, 19 Feb 2025 10:42:58 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Feb
 2025 10:42:57 +0800
Message-ID: <63b99f2f-9446-3119-a653-6ed50ddcf961@hisilicon.com>
Date: Wed, 19 Feb 2025 10:42:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<yu.c.chen@intel.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <wanghuiqiang@huawei.com>,
	<fanghao11@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250213035510.2402076-1-zhanjie9@hisilicon.com>
 <3965c9ee-c136-bdf2-8384-ed361fc601c1@hisilicon.com>
 <CAJZ5v0jLTi_nZ8ek-MYtthZtD4oEszhvP=ZBzJmTb7NkB=_rGA@mail.gmail.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAJZ5v0jLTi_nZ8ek-MYtthZtD4oEszhvP=ZBzJmTb7NkB=_rGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Yeah, no problem!  Just in case it's missed.

Thanks.

On 18/02/2025 20:43, Rafael J. Wysocki wrote:
> On Tue, Feb 18, 2025 at 1:41 PM Jie Zhan <zhanjie9@hisilicon.com> wrote:
>>
>> A kindly ping on this patch.
> 
> I'll get to it in the next few days, I don't think it is urgent.
> 
> Thanks!
> 
>> On 13/02/2025 11:55, Jie Zhan wrote:
>>> We observed an issue that the cpu frequency can't raise up with a 100% cpu
>>> load when NOHZ is off and the 'conservative' governor is selected.
>>>
>>> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy()
>>> when NOHZ is off.  This was found and explained in commit 9485e4ca0b48
>>> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
>>>
>>> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detection
>>> logic in load calculation") introduced a comparison between 'idle_time' and
>>> 'samling_rate' to detect a long idle interval.  While 'idle_time' is
>>> converted to int before comparison, it's actually promoted to unsigned
>>> again when compared with an unsigned 'sampling_rate'.  Hence, this leads to
>>> wrong idle interval detection when it's in fact 100% busy and sets
>>> policy_dbs->idle_periods to a very large value.  'conservative' adjusts the
>>> frequency to minimum because of the large 'idle_periods', such that the
>>> frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_periods
>>> so it fortunately avoids the issue.
>>>
>>> Correct negative 'idle_time' to 0 before any use of it in dbs_update().
>>>
>>> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic in load calculation")
>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
>>> ---
>>> v3:
>>> - Remove ternary operators.
>>>
>>> v2:
>>> - Avoid type conversion, compare current and previous idle time before
>>>   obtaining 'idle_time'.
>>> - Update the explanation in comments.
>>>
>>> Discussions:
>>> v2: https://lore.kernel.org/linux-pm/20250212081438.1294503-1-zhanjie9@hisilicon.com/
>>> v1: https://lore.kernel.org/linux-pm/20250210130659.3533182-1-zhanjie9@hisilicon.com/
>>> ---
>>>  drivers/cpufreq/cpufreq_governor.c | 45 +++++++++++++++---------------
>>>  1 file changed, 23 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>>> index af44ee6a6430..1a7fcaf39cc9 100644
>>> --- a/drivers/cpufreq/cpufreq_governor.c
>>> +++ b/drivers/cpufreq/cpufreq_governor.c
>>> @@ -145,7 +145,23 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>               time_elapsed = update_time - j_cdbs->prev_update_time;
>>>               j_cdbs->prev_update_time = update_time;
>>>
>>> -             idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
>>> +             /*
>>> +              * cur_idle_time could be smaller than j_cdbs->prev_cpu_idle if
>>> +              * it's obtained from get_cpu_idle_time_jiffy() when NOHZ is
>>> +              * off, where idle_time is calculated by the difference between
>>> +              * time elapsed in jiffies and "busy time" obtained from CPU
>>> +              * statistics.  If a CPU is 100% busy, the time elapsed and busy
>>> +              * time should grow with the same amount in two consecutive
>>> +              * samples, but in practice there could be a tiny difference,
>>> +              * making the accumulated idle time decrease sometimes.  Hence,
>>> +              * in this case, idle_time should be regarded as 0 in order to
>>> +              * make the further process correct.
>>> +              */
>>> +             if (cur_idle_time > j_cdbs->prev_cpu_idle)
>>> +                     idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
>>> +             else
>>> +                     idle_time = 0;
>>> +
>>>               j_cdbs->prev_cpu_idle = cur_idle_time;
>>>
>>>               if (ignore_nice) {
>>> @@ -162,7 +178,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>                        * calls, so the previous load value can be used then.
>>>                        */
>>>                       load = j_cdbs->prev_load;
>>> -             } else if (unlikely((int)idle_time > 2 * sampling_rate &&
>>> +             } else if (unlikely(idle_time > 2 * sampling_rate &&
>>>                                   j_cdbs->prev_load)) {
>>>                       /*
>>>                        * If the CPU had gone completely idle and a task has
>>> @@ -189,30 +205,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>                       load = j_cdbs->prev_load;
>>>                       j_cdbs->prev_load = 0;
>>>               } else {
>>> -                     if (time_elapsed >= idle_time) {
>>> +                     if (time_elapsed > idle_time)
>>>                               load = 100 * (time_elapsed - idle_time) / time_elapsed;
>>> -                     } else {
>>> -                             /*
>>> -                              * That can happen if idle_time is returned by
>>> -                              * get_cpu_idle_time_jiffy().  In that case
>>> -                              * idle_time is roughly equal to the difference
>>> -                              * between time_elapsed and "busy time" obtained
>>> -                              * from CPU statistics.  Then, the "busy time"
>>> -                              * can end up being greater than time_elapsed
>>> -                              * (for example, if jiffies_64 and the CPU
>>> -                              * statistics are updated by different CPUs),
>>> -                              * so idle_time may in fact be negative.  That
>>> -                              * means, though, that the CPU was busy all
>>> -                              * the time (on the rough average) during the
>>> -                              * last sampling interval and 100 can be
>>> -                              * returned as the load.
>>> -                              */
>>> -                             load = (int)idle_time < 0 ? 100 : 0;
>>> -                     }
>>> +                     else
>>> +                             load = 0;
>>> +
>>>                       j_cdbs->prev_load = load;
>>>               }
>>>
>>> -             if (unlikely((int)idle_time > 2 * sampling_rate)) {
>>> +             if (unlikely(idle_time > 2 * sampling_rate)) {
>>>                       unsigned int periods = idle_time / sampling_rate;
>>>
>>>                       if (periods < idle_periods)

