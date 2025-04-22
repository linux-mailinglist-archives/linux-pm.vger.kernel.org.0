Return-Path: <linux-pm+bounces-25896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37BA96889
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E6E3B0263
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74FA27C84B;
	Tue, 22 Apr 2025 12:05:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB8151985;
	Tue, 22 Apr 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323545; cv=none; b=H6iuIf60iKAfC6eIDRjKjP93Wo+w95Gb4Rv2PP06LwvIC3nnkuuA8ROZrqs2fMtG0dMjc5DeiXlZPvpTdHANYxjN7U/1x1oJWdXq3L8SG+OPihGMEfLaE6dLY8YrE9qOTbXgS79+qh+Q801smrVQc7BUwSpYqrebcaKqW9K4tLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323545; c=relaxed/simple;
	bh=p06Jthaaa6RvehgVSB4tMaeficvnnOmuncPUt3uLm08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pNeN5KeqmT/xkhzEawuCERSAPQibIydtMBAfAo4aqKSRk298XIvaaRbdCHi1/G/lTg42LdL4aiMaZekc0HTFSMguFBo3QJkSCrmMQB+aAehd+bGvH5A+uFB1Kv4y22mw1AjVopo/YzvKzuqWMkUSLkf3jJrXjj/+z/sXtRRk3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zhgs62g2Mz13LBt;
	Tue, 22 Apr 2025 20:04:42 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CE3F1400D4;
	Tue, 22 Apr 2025 20:05:40 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:05:39 +0800
Message-ID: <6f0ae81a-78a1-4584-b2dd-2f88aff598ef@huawei.com>
Date: Tue, 22 Apr 2025 20:05:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Nicholas Chin
	<nic.c3.14@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
	<vincent.guittot@linaro.org>
References: <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
 <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
 <20250421113753.lwukxhi45bnmqbpq@vireshk-i7>
 <794278e8-633d-4fd7-affa-9e89ba9719bd@huawei.com>
 <20250422094128.wlmr7u4qitwxiniz@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250422094128.wlmr7u4qitwxiniz@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/22 17:41, Viresh Kumar wrote:

> On 21-04-25, 21:36, zhenglifeng (A) wrote:
>> On 2025/4/21 19:37, Viresh Kumar wrote:
>>> +static int policy_set_boost(struct cpufreq_policy *policy, bool enable, bool forced)
>>> +{
>>> +       if (!forced && (policy->boost_enabled == enable))
>>> +               return 0;
>>> +
>>> +       policy->boost_enabled = enable;
>>> +
>>> +       ret = cpufreq_driver->set_boost(policy, enable);
>>> +       if (ret)
>>> +               policy->boost_enabled = !policy->boost_enabled;
>>
>> This may cause boost_enabled becomes false but actually boosted when forced
>> is true and trying to set boost_enabled from true to true.
> 
> Can't do much in case of failure. And this is the current behavior
> anyway. This was just some code cleanup, doesn't change the behavior
> of the code.

If forced is true, this may change the behavior. But I see you gave up this
parameter in new version, so I think it's OK now.

> 
>>>  static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
>>> @@ -1617,16 +1624,17 @@ static int cpufreq_online(unsigned int cpu)
>>>         if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>>>                 policy->cdev = of_cpufreq_cooling_register(policy);
>>>
>>> -       /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>>> +       /*
>>> +        * Let the per-policy boost flag mirror the cpufreq_driver boost during
>>> +        * initialization for a new policy. For an existing policy, maintain the
>>> +        * previous boost value unless global boost is disabled now.
>>> +        */
>>>         if (cpufreq_driver->set_boost && policy->boost_supported &&
>>> -           policy->boost_enabled != cpufreq_boost_enabled()) {
>>> -               policy->boost_enabled = cpufreq_boost_enabled();
>>> -               ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
>>> +           (new_policy || !cpufreq_boost_enabled())) {
>>> +               ret = policy_set_boost(policy, cpufreq_boost_enabled(), false);
>>
>> I think forced here should be true. If new_policy and
>> !cpufreq_boost_enabled() but the cpu is actually boosted by some other
>> reason (like what we met in acpi-cpufreq), set_boost() should be forcibly
>> executed to make the cpu unboost.
> 
> The problem is that setting boost may be time consuming for some
> platforms and we may not want to do that unnecessarily. ACPI cpufreq
> should be fixed separately for that.

Makes sense.

> 
> I am sending a series now to fix them all, please review that.
> 


