Return-Path: <linux-pm+bounces-28869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3616ADC496
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407281888ACB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD728A406;
	Tue, 17 Jun 2025 08:21:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72E28FA93;
	Tue, 17 Jun 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148463; cv=none; b=gd55GQoSDqzks1hHZt0xqUKxtuO9SHQKhhifNUmNV5XoHop7YYtL+Djr/3hxALfdEnA+NKLZsn/tTWsZexbD7ixQLX0rr1Zu9djtQXPmOy6oCdixbKzBE5M+ziJryKoPeDFv50V0N0QaPdz+r0n5ee8E+01q9YZdqTwCIY4cjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148463; c=relaxed/simple;
	bh=KWccvLWqTHB9iiyN0K7aDR/grSYdB7ZrDc4yUUlsGuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jTym8r1VNSpEw6NujD5nVonaH4Oj0l1OFMfOL2mkP9oLtTIex6FKwndnomvwjjSCqL5HOSRHFGsaJrWKPIez6ia2UK9LIiXXNkkGwa1omToGI3Sr5oxmiczmFRdZgcT/rwH+RGThikPQEU1K3iOKLSmbMh7SN7V4MuDOGRyBsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA60715A1;
	Tue, 17 Jun 2025 01:20:33 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3BE13F673;
	Tue, 17 Jun 2025 01:20:53 -0700 (PDT)
Message-ID: <e9fc6154-7199-4709-b428-3f848f1597e8@arm.com>
Date: Tue, 17 Jun 2025 09:20:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
 <34651625-08eb-46df-8075-4c5a08d15c18@arm.com>
 <4b551b8c-6572-4fd1-9bd8-6669aaf69271@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4b551b8c-6572-4fd1-9bd8-6669aaf69271@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/25 03:14, zhenglifeng (A) wrote:
> On 2025/6/17 3:10, Robin Murphy wrote:
>> On 2025-06-16 6:25 pm, Christian Loehle wrote:
>>> The boost_enabled early return in policy_set_boost() caused
>>> the boost disabled at initialization to not actually set the
>>> initial policy->max, therefore effectively enabling boost while
>>> it should have been enabled.
>>>
>>> Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")
>>
>> I think it's a bit older than that - I noticed this with 6.15 stable, prior to that refactoring, and from a poke through the history the underlying logic appears to date back to dd016f379ebc ("cpufreq: Introduce a more generic way to set default per-policy boost flag"). Hopefully someone can figure out the appropriate stable backport.
>>
>> I can at least confirm that equivalently hacking out the "&& policy->boost_enabled != cpufreq_boost_enabled()" condition previously here does have the desired effect for me of initialising scaling_max_freq correctly at boot, but I'm not sure that's entirely correct on its own...
>>
>> Thanks,
>> Robin.
>>
>>> Reported-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>> ---
>>>   drivers/cpufreq/cpufreq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index d7426e1d8bdd..e85139bd0436 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
>>>        */
>>>       if (cpufreq_driver->set_boost && policy->boost_supported &&
>>>           (new_policy || !cpufreq_boost_enabled())) {
>>> -        ret = policy_set_boost(policy, cpufreq_boost_enabled());
>>> +        ret = cpufreq_driver->set_boost(policy, cpufreq_boost_enabled());
>>>           if (ret) {
>>>               /* If the set_boost fails, the online operation is not affected */
>>>               pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
>>
>>
> 
> I don't quite understand what problem you've met. It semms like you guys
> propose that set_boost() should be called no matter what
> policy->boost_enabled is. Having more details would help to clarify things,
> such as which driver you use and what you expect but not be achieved.
> 

so calling policy_set_boost(policy, enable) is a noop here if
policy->boost_enabled == cpufreq_boost_enabled():

	if (policy->boost_enabled == enable)
		return 0;

We have policy->boost_enabled == false on boot, thus never actually
setting policy->max up ever, which leads to the following:

# cat /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies
2016000 
# cat /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
2016000 
# cat /sys/devices/system/cpu/cpufreq/boost
0
# echo 1 > /sys/devices/system/cpu/cpufreq/boost
# echo 0 > /sys/devices/system/cpu/cpufreq/boost
# cat /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies
1800000

Anyway I'll bisect some more to find the actual first bad commit and
resend.

