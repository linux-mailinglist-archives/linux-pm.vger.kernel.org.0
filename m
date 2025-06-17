Return-Path: <linux-pm+bounces-28903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E08ADCC13
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A53A6B92
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8E02E3389;
	Tue, 17 Jun 2025 12:56:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CFE2E2EF1;
	Tue, 17 Jun 2025 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165003; cv=none; b=Aqctyq9K63I8uyKHxhqMx9LJ68/RncCECc2ZUn/ExJz6c5nS8KRWCI7odhTriOPPryLKuGHbGt6CEdYRtrLOyS7wnrHRGFHJLHoImQP2YHTHr6pTwPx9mB/OmMkKdG3sezoWmDRevG+b3H0UdeQAe98dsCXvVTFy4YP4MHHlIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165003; c=relaxed/simple;
	bh=1bfgQo9mR1ETUyRu4Bf4IbeGVR6ggw/u+CitXdXSyeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jDMmqg3AIcKuT1TrxSC1ndHDE+d/bL9MICK+ClxJ3OvO4ThXRBODN1i1AD4rTjGatzMiE+X+4CPKh+mYkCoq8To7YFJJwrkSQlVeDFHLnTRSvT/n+Kr0O5pXWChMVftheXxVpcL8BRPdY3MrLanKXSDOx5LIm4krmCXGJQskXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6BD1595;
	Tue, 17 Jun 2025 05:56:20 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85B123F673;
	Tue, 17 Jun 2025 05:56:40 -0700 (PDT)
Message-ID: <9710acf3-9ffd-4b29-a51a-21d91cbbdf5e@arm.com>
Date: Tue, 17 Jun 2025 13:56:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: Christian Loehle <christian.loehle@arm.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
 <34651625-08eb-46df-8075-4c5a08d15c18@arm.com>
 <4b551b8c-6572-4fd1-9bd8-6669aaf69271@huawei.com>
 <e9fc6154-7199-4709-b428-3f848f1597e8@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <e9fc6154-7199-4709-b428-3f848f1597e8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/06/2025 9:20 am, Christian Loehle wrote:
> On 6/17/25 03:14, zhenglifeng (A) wrote:
>> On 2025/6/17 3:10, Robin Murphy wrote:
>>> On 2025-06-16 6:25 pm, Christian Loehle wrote:
>>>> The boost_enabled early return in policy_set_boost() caused
>>>> the boost disabled at initialization to not actually set the
>>>> initial policy->max, therefore effectively enabling boost while
>>>> it should have been enabled.
>>>>
>>>> Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")
>>>
>>> I think it's a bit older than that - I noticed this with 6.15 stable, prior to that refactoring, and from a poke through the history the underlying logic appears to date back to dd016f379ebc ("cpufreq: Introduce a more generic way to set default per-policy boost flag"). Hopefully someone can figure out the appropriate stable backport.
>>>
>>> I can at least confirm that equivalently hacking out the "&& policy->boost_enabled != cpufreq_boost_enabled()" condition previously here does have the desired effect for me of initialising scaling_max_freq correctly at boot, but I'm not sure that's entirely correct on its own...
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> Reported-by: Robin Murphy <robin.murphy@arm.com>
>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>> ---
>>>>    drivers/cpufreq/cpufreq.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>> index d7426e1d8bdd..e85139bd0436 100644
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
>>>>         */
>>>>        if (cpufreq_driver->set_boost && policy->boost_supported &&
>>>>            (new_policy || !cpufreq_boost_enabled())) {
>>>> -        ret = policy_set_boost(policy, cpufreq_boost_enabled());
>>>> +        ret = cpufreq_driver->set_boost(policy, cpufreq_boost_enabled());
>>>>            if (ret) {
>>>>                /* If the set_boost fails, the online operation is not affected */
>>>>                pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
>>>
>>>
>>
>> I don't quite understand what problem you've met. It semms like you guys
>> propose that set_boost() should be called no matter what
>> policy->boost_enabled is. Having more details would help to clarify things,
>> such as which driver you use and what you expect but not be achieved.
>>
> 
> so calling policy_set_boost(policy, enable) is a noop here if
> policy->boost_enabled == cpufreq_boost_enabled():
> 
> 	if (policy->boost_enabled == enable)
> 		return 0;
> 
> We have policy->boost_enabled == false on boot, thus never actually
> setting policy->max up ever, which leads to the following:

And for clarity, this is with the cpufreq_dt driver (at least in my case).

Thanks,
Robin.

> # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies
> 2016000
> # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
> 2016000
> # cat /sys/devices/system/cpu/cpufreq/boost
> 0
> # echo 1 > /sys/devices/system/cpu/cpufreq/boost
> # echo 0 > /sys/devices/system/cpu/cpufreq/boost
> # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies
> 1800000
> 
> Anyway I'll bisect some more to find the actual first bad commit and
> resend.

