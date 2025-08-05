Return-Path: <linux-pm+bounces-31967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2220FB1B4ED
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 15:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96C13BD899
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBF26A0B9;
	Tue,  5 Aug 2025 13:32:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D629D0E;
	Tue,  5 Aug 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400774; cv=none; b=Twn6+S+T0crMaCo4sHi9L7RMVyHM0aUX5xf78MI60eb1H+/WUmTcR9arX8cvQDmpA/+thlG2lEb/Nbb3dhr/D4YqGGHckWVuOy+MWJnEtE1Uow3g8m/XDY7U2QPv7GzlCUhVn3Ml8YOXbrJ8p58d7VVLJ+jnx/uOWgMoxW0gOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400774; c=relaxed/simple;
	bh=XKBAXK7JLLnQW5yVRYLW12qbWYJDi3sJQeRWu7PBKZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o6vahMyGEqF3AHOpJos5Mf9xrSeCJWMr62pJ5kltk+mhLfx0XhrUVLLj48R6C2frHf6JQGJfldIr9hJ3QPsqqbhHVsru4MrufFkdxW6uXznGyYkUMYlYeY7GKXzLLPf6GttR8Imq2FJa7BYUJs72SppNN2Ebk8e2clsKeihFzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bxDkZ54MSz14MHM;
	Tue,  5 Aug 2025 21:27:50 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C040180487;
	Tue,  5 Aug 2025 21:32:46 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Aug
 2025 21:32:45 +0800
Message-ID: <7586dd30-74b5-4e23-9ee2-bb82d3cb8bd4@huawei.com>
Date: Tue, 5 Aug 2025 21:32:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cpufreq: Add a new function to get cpufreq policy
 without checking if the CPU is online
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <viresh.kumar@linaro.org>,
	<beata.michalska@arm.com>, <sudeep.holla@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>
References: <20250805093330.3715444-1-zhenglifeng1@huawei.com>
 <20250805093330.3715444-3-zhenglifeng1@huawei.com>
 <CAJZ5v0h3XKXAGHSrx50vt1Aho3uchiJ2kjQa7qCM8jCr03YKTA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0h3XKXAGHSrx50vt1Aho3uchiJ2kjQa7qCM8jCr03YKTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/8/5 20:57, Rafael J. Wysocki wrote:

> On Tue, Aug 5, 2025 at 11:34 AM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
>> policy->cpus mask, which means the CPU is already online. But in some
>> cases, the policy is needed before the CPU is added to cpus mask. Add a
>> function to get the policy in these cases.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>>  include/linux/cpufreq.h   |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index fc7eace8b65b..2de76a072893 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -198,6 +198,17 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>>
>> +struct cpufreq_policy *cpufreq_cpu_get_raw_no_check(unsigned int cpu)
> 
> This is not a particularly nice name.  Maybe call it cpufreq_cpu_policy()?

Thanks for giving a better one.

> 
>> +{
>> +       struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>> +
>> +       if (policy)
>> +               return policy;
>> +
>> +       return NULL;
> 
> This could just be a one-liner with this statement in the function body:
> 
>   return per_cpu(cpufreq_cpu_data, cpu);
> 
> Can't it?
> 
> In which case it can be called in all places reading cpufreq_cpu_data
> for a given CPU.

Yes, it can be done in one line. Thanks.

> 
>> +}
>> +EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw_no_check);
>> +
>>  unsigned int cpufreq_generic_get(unsigned int cpu)
>>  {
>>         struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 95f3807c8c55..02ad8173dc10 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -205,6 +205,7 @@ struct cpufreq_freqs {
>>
>>  #ifdef CONFIG_CPU_FREQ
>>  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
>> +struct cpufreq_policy *cpufreq_cpu_get_raw_no_check(unsigned int cpu);
>>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
>>  void cpufreq_cpu_put(struct cpufreq_policy *policy);
>>  #else
>> --
> 


