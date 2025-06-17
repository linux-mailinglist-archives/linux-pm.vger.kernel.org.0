Return-Path: <linux-pm+bounces-28863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E8ADBEF4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 04:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEC43A6EDE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 02:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532451FBEA8;
	Tue, 17 Jun 2025 02:14:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978884A35;
	Tue, 17 Jun 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126493; cv=none; b=AhF3smDo/PGZNNZA+FRgT9lkf0AmQKR/UHJa8H1WI5lALEpEY4r/naQokFw2x4H/tT2EdkmSXfEUP+O4SdL7CvdBtoD5YgzO5ExFv6WPROr5IYDaRFnjILFLkUSSU1pxDewBj5auLzSc5/vm4E2AeHGbI+qk66F/Q8i/Ac0/RQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126493; c=relaxed/simple;
	bh=mSTJGcHMk23jn9UCX9Cjixb88Ca0uGp9MTScxMCw8nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gHOp2gsbJ3+5cqgs65kL0rWxLrCcKIyJvsBO8CK5m75kpaSxnvUSpHaVDBphl7NcyzBwNe+fqoUlyoGnCZ+mMycbAE6wDPkfJpBWzoRsqpxxwaXk5VH8odxwuSZ8Ud6GC2xmFvFDSh67IVuij68sKCqKMr3M71d2nQyNRDmoGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bLr253hfQz2CffJ;
	Tue, 17 Jun 2025 10:10:53 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 507F61A0188;
	Tue, 17 Jun 2025 10:14:47 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Jun
 2025 10:14:46 +0800
Message-ID: <4b551b8c-6572-4fd1-9bd8-6669aaf69271@huawei.com>
Date: Tue, 17 Jun 2025 10:14:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: Robin Murphy <robin.murphy@arm.com>, Christian Loehle
	<christian.loehle@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
 <34651625-08eb-46df-8075-4c5a08d15c18@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <34651625-08eb-46df-8075-4c5a08d15c18@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/6/17 3:10, Robin Murphy wrote:
> On 2025-06-16 6:25 pm, Christian Loehle wrote:
>> The boost_enabled early return in policy_set_boost() caused
>> the boost disabled at initialization to not actually set the
>> initial policy->max, therefore effectively enabling boost while
>> it should have been enabled.
>>
>> Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")
> 
> I think it's a bit older than that - I noticed this with 6.15 stable, prior to that refactoring, and from a poke through the history the underlying logic appears to date back to dd016f379ebc ("cpufreq: Introduce a more generic way to set default per-policy boost flag"). Hopefully someone can figure out the appropriate stable backport.
> 
> I can at least confirm that equivalently hacking out the "&& policy->boost_enabled != cpufreq_boost_enabled()" condition previously here does have the desired effect for me of initialising scaling_max_freq correctly at boot, but I'm not sure that's entirely correct on its own...
> 
> Thanks,
> Robin.
> 
>> Reported-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d7426e1d8bdd..e85139bd0436 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
>>        */
>>       if (cpufreq_driver->set_boost && policy->boost_supported &&
>>           (new_policy || !cpufreq_boost_enabled())) {
>> -        ret = policy_set_boost(policy, cpufreq_boost_enabled());
>> +        ret = cpufreq_driver->set_boost(policy, cpufreq_boost_enabled());
>>           if (ret) {
>>               /* If the set_boost fails, the online operation is not affected */
>>               pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
> 
> 

I don't quite understand what problem you've met. It semms like you guys
propose that set_boost() should be called no matter what
policy->boost_enabled is. Having more details would help to clarify things,
such as which driver you use and what you expect but not be achieved.


