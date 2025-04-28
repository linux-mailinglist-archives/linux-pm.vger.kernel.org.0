Return-Path: <linux-pm+bounces-26310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F592A9E5E3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 03:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EB93B7C04
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 01:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4714AD2B;
	Mon, 28 Apr 2025 01:44:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCAE3211;
	Mon, 28 Apr 2025 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804668; cv=none; b=KR+brbKmmB3KMgLariSAhB67tngye57HGBw3bKzytgQ7lRkW6erxrvx/B+GUiGMEU4bgnIvzZeTBIPeWxUionnEQvIZFOHGH0NMNBjETRHEvAKoIFEQiXzUAQpk7hOxXhOrMgXPRR9oEenzpkvSROG6xgaxobI7/HWkGDTyRHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804668; c=relaxed/simple;
	bh=6yidVzjYmwPuLcSRZ87m2YYDPaydS1ngk9JJx+nd7xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZZTk5P/FvxclQMzpBZ26SBD1bu2p4TGaaJYp5OiitgqHM2Tt406HLf2B7UJQLpYW5/8WMBNFz8pOilsIerorXG/fjkW00M4yfjQG8hmyAKC080nexK+6eKfRPQqoiq9LDXB/W0yyZOxwQA/LRgVjsyprytvw5uoHDwOmiP9LAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zm5k528XGz5vMt;
	Mon, 28 Apr 2025 09:40:29 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B1EE9180B50;
	Mon, 28 Apr 2025 09:44:22 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Apr
 2025 09:44:17 +0800
Message-ID: <3ac90a52-f4ad-4aec-a4f5-0e80ab9d9dc5@huawei.com>
Date: Mon, 28 Apr 2025 09:44:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Fix setting policy limits when frequency
 tables are used
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, Christian Loehle <christian.loehle@arm.com>, LKML
	<linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>, Stephan
 Gerhold <stephan.gerhold@linaro.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
References: <5896780.DvuYhMxLoT@rjwysocki.net>
 <2fd8c27d-7206-4af6-b30b-d8f786827d94@huawei.com>
 <CAJZ5v0hTbdTaos9gc8ubPNdjq+K-pBwYpAvT8Rm887EZpSm1bw@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0hTbdTaos9gc8ubPNdjq+K-pBwYpAvT8Rm887EZpSm1bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)



On 2025/4/27 19:41, Rafael J. Wysocki wrote:
> On Sun, Apr 27, 2025 at 4:26 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
>>
>> On 2025/4/25 19:36, Rafael J. Wysocki wrote:
>>
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
>>> policy->max") overlooked the fact that policy->min and policy->max were
>>> accessed directly in cpufreq_frequency_table_target() and in the
>>> functions called by it.  Consequently, the changes made by that commit
>>> led to problems with setting policy limits.
>>>
>>> Address this by passing the target frequency limits to __resolve_freq()
>>> and cpufreq_frequency_table_target() and propagating them to the
>>> functions called by the latter.
>>>
>>> Fixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and policy->max")
>>> Link: https://lore.kernel.org/linux-pm/aAplED3IA_J0eZN0@linaro.org/
>>> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> The v1 is here: https://lore.kernel.org/linux-pm/12665363.O9o76ZdvQC@rjwysocki.net/
>>>
>>> v1 -> v2:
>>>    * Do clamp_val(target_freq, min, max) before checking freq_table against
>>>      NULL in __resolve_freq().
>>>    * Update comment in cpufreq_frequency_table_target() to match the new code.
>>>
>>> ---
>>>  drivers/cpufreq/cpufreq.c          |   22 ++++++---
>>>  drivers/cpufreq/cpufreq_ondemand.c |    3 -
>>>  drivers/cpufreq/freq_table.c       |    6 +-
>>>  include/linux/cpufreq.h            |   83 ++++++++++++++++++++++++-------------
>>>  4 files changed, 73 insertions(+), 41 deletions(-)
>>>
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -491,14 +491,18 @@
>>>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>>>
>>>  static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>> -             unsigned int target_freq, unsigned int relation)
>>> +                                unsigned int target_freq,
>>> +                                unsigned int min, unsigned int max,
>>> +                                unsigned int relation)
>>>  {
>>>       unsigned int idx;
>>>
>>> +     target_freq = clamp_val(target_freq, min, max);
>>> +
>>>       if (!policy->freq_table)
>>>               return target_freq;
>>>
>>> -     idx = cpufreq_frequency_table_target(policy, target_freq, relation);
>>> +     idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
>>>       policy->cached_resolved_idx = idx;
>>>       policy->cached_target_freq = target_freq;
>>>       return policy->freq_table[idx].frequency;
>>> @@ -532,8 +536,7 @@
>>>       if (unlikely(min > max))
>>>               min = max;
>>>
>>> -     return __resolve_freq(policy, clamp_val(target_freq, min, max),
>>> -                           CPUFREQ_RELATION_LE);
>>> +     return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
>>>  }
>>>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>>>
>>> @@ -2351,8 +2354,8 @@
>>>       if (cpufreq_disabled())
>>>               return -ENODEV;
>>>
>>> -     target_freq = clamp_val(target_freq, policy->min, policy->max);
>>> -     target_freq = __resolve_freq(policy, target_freq, relation);
>>> +     target_freq = __resolve_freq(policy, target_freq, policy->min,
>>> +                                  policy->max, relation);
>>>
>>>       pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
>>>                policy->cpu, target_freq, relation, old_target_freq);
>>> @@ -2650,8 +2653,11 @@
>>>        * compiler optimizations around them because they may be accessed
>>>        * concurrently by cpufreq_driver_resolve_freq() during the update.
>>>        */
>>> -     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
>>> -     new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
>>> +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
>>> +                                            new_data.min, new_data.max,
>>> +                                            CPUFREQ_RELATION_H));
>>> +     new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
>>> +                                   new_data.max, CPUFREQ_RELATION_L);
>>>       WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
>>
>> It might be better like:
>>
>> -       WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
>> -       new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
>> -       WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
>> +       WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
>> +                                              new_data.min, new_data.max,
>> +                                              CPUFREQ_RELATION_H));
>> +       WRITE_ONCE(policy->min, __resolve_freq(policy, new_data.min,
>> +                                              new_data.min, policy->max,
>> +                                              CPUFREQ_RELATION_L));
>>
> 
> Not really because policy->max may be less than new_data.min at this
> point AFAICS.

I see.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>


