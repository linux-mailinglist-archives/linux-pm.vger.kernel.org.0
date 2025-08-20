Return-Path: <linux-pm+bounces-32667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9932B2D190
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AE37A749E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 01:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF4267B94;
	Wed, 20 Aug 2025 01:50:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6670823;
	Wed, 20 Aug 2025 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654655; cv=none; b=hOihbFL8uwo2+8quOjUulEga3xha5C+iZA+bjoUZw/ujiVqgARsn2x14fVjWAtBvEQdk3b53LEAZBOJQyHxQxyNoosb/VdG0anfbCHpY6nXuONY5qkCZvQ4RIm/I/Nii9zoki7JgWpToyEC/anFwQJ4GUxb5CJ+96FqIECYhtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654655; c=relaxed/simple;
	bh=9ZrnOO89IuC8LPdiduICMO3xfuw1wR8CVeXVoOzYVQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c5zteU6b52Hdn2EjSojyIZCLOVUxegbS2YQ6SudHQotlu4tuAllCAOalD+TQLCzKBtIfwkVKpYMGiW8cL7DR0JO3R9qLpITPQoOtE3TXixrS+ywvgKyhF+3fOvQfPptimYoJE7+WRc/iJBLasmNrqCi/pke3F7d7MX9CLTk9yWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c68Zd4WySz27j7S;
	Wed, 20 Aug 2025 09:51:53 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 59FCF140277;
	Wed, 20 Aug 2025 09:50:48 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 09:50:47 +0800
Message-ID: <cbecda55-db03-409a-b892-65171e00f6bc@huawei.com>
Date: Wed, 20 Aug 2025 09:50:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cpufreq: Add a new function to get cpufreq policy
 without checking if the CPU is online
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <viresh.kumar@linaro.org>,
	<beata.michalska@arm.com>, <sudeep.holla@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <linhongye@h-partners.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
 <20250819072931.1647431-3-zhenglifeng1@huawei.com>
 <CAJZ5v0i7g8i8m9GPi9=-Y0x36491Ng3akUfVP2vPOBS-OAEg=w@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0i7g8i8m9GPi9=-Y0x36491Ng3akUfVP2vPOBS-OAEg=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/8/20 3:05, Rafael J. Wysocki wrote:

> On Tue, Aug 19, 2025 at 9:30 AM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
>> policy->cpus mask, which means the CPU is already online. But in some
>> cases, the policy is needed before the CPU is added to cpus mask. Add a
>> function to get the policy in these cases.
> 
> I'd prefer the subject to be somewhat shorter.  For instance, something like
> 
> cpufreq: Add new helper function returning cpufreq policy
> 
> would suffice because the changelog explains the details.
> 
> With that addressed
> 
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Thanks! Will shorten it in the next version.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 6 ++++++
>>  include/linux/cpufreq.h   | 5 +++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index fc7eace8b65b..78ca68ea754d 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -198,6 +198,12 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>>
>> +struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
>> +{
>> +       return per_cpu(cpufreq_cpu_data, cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(cpufreq_cpu_policy);
>> +
>>  unsigned int cpufreq_generic_get(unsigned int cpu)
>>  {
>>         struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 95f3807c8c55..26b3c3310d5b 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -205,6 +205,7 @@ struct cpufreq_freqs {
>>
>>  #ifdef CONFIG_CPU_FREQ
>>  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
>> +struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu);
>>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
>>  void cpufreq_cpu_put(struct cpufreq_policy *policy);
>>  #else
>> @@ -212,6 +213,10 @@ static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>>  {
>>         return NULL;
>>  }
>> +static inline struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
>> +{
>> +       return NULL;
>> +}
>>  static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>>  {
>>         return NULL;
>> --
>> 2.33.0
>>
>>
> 


