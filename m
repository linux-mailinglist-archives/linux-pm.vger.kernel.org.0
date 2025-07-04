Return-Path: <linux-pm+bounces-30116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A19AF8E67
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF26800A3A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E512F271C;
	Fri,  4 Jul 2025 09:16:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8F2EFD89;
	Fri,  4 Jul 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620580; cv=none; b=pKQAVsTNwnUaV55EkzcDNJ4Nx/P4I2l+j/I76bJWDZjH3xuyxqzCpnnlGlKT83/zxwx2YNwea7uTMHj8w1yPOzEUO09l4e++3wATfvuuxQK9k0lCOmjU2ANbQ7+4+jY7mZV6bleaNiLcEpkB1YOpnT5rfsx3VVG8nGLQldoB+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620580; c=relaxed/simple;
	bh=MpUbnIYKlBAUil3Thq/LzCLGjaTmHfYdzlw5yOQJwF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FJINuljfwhOgDNkb8HHW2N4U7szV8fH5YGCwZsOV4L05PXwYDebb/wuGFqEuD7a7FOtgQTyQ3+Wd5QMIAjXGXk+x8Mhvh/qvg15g93PipbG6dLTk/In4KSxzePA8raXUQJ4K3q69aKbhN610BD96y7fmxB7J1g17pE/WSnOVFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bYScx3mc5z2SSrH;
	Fri,  4 Jul 2025 17:14:25 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C9A7140278;
	Fri,  4 Jul 2025 17:16:14 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 17:16:13 +0800
Message-ID: <3c51a0b3-9027-4397-9912-8c7635989dc6@huawei.com>
Date: Fri, 4 Jul 2025 17:16:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] cpufreq: Move the check of cpufreq_driver->get into
 cpufreq_verify_current_freq()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-6-zhenglifeng1@huawei.com>
 <CAJZ5v0jz9Bc82AnpcuGLyiu4zC4J6CzHVj7YRmaqhz71S4NEYg@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0jz9Bc82AnpcuGLyiu4zC4J6CzHVj7YRmaqhz71S4NEYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/6/23 23:35, Rafael J. Wysocki wrote:

> On Mon, Jun 23, 2025 at 3:34 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Move the check of cpufreq_driver->get into cpufreq_verify_current_freq() in
>> case of calling it without check.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index c4891bf5dc84..9b2578b905a5 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1800,6 +1800,9 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>  {
>>         unsigned int new_freq;
>>
>> +       if (!cpufreq_driver->get)
>> +               return 0;
>> +
> 
> This will duplicate the check in cpufreq_policy_refresh(), won't it?

Yes, the check will duplicate but I think it's OK. If remove the check in
cpufreq_policy_refresh(), the logic will be changed.

> 
>>         new_freq = cpufreq_driver->get(policy->cpu);
>>         if (!new_freq)
>>                 return 0;
>> @@ -1922,10 +1925,7 @@ unsigned int cpufreq_get(unsigned int cpu)
>>
>>         guard(cpufreq_policy_read)(policy);
>>
>> -       if (cpufreq_driver->get)
>> -               return __cpufreq_get(policy);
>> -
>> -       return 0;
>> +       return __cpufreq_get(policy);
>>  }
>>  EXPORT_SYMBOL(cpufreq_get);
>>
>> @@ -2479,8 +2479,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
>>
>>         pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>>
>> -       if (cpufreq_driver->get)
>> -               cpufreq_verify_current_freq(policy, false);
>> +       cpufreq_verify_current_freq(policy, false);
>>
>>         if (policy->governor->start) {
>>                 ret = policy->governor->start(policy);
>> --
>> 2.33.0
>>


