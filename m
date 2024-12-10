Return-Path: <linux-pm+bounces-18899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342619EADE2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E2118889F2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5C2080C2;
	Tue, 10 Dec 2024 10:20:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DD23DEB5;
	Tue, 10 Dec 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826048; cv=none; b=li6cybmmteS14q7j/4GUH8SY67ebgZLL/mdmrQSO2252SEz0Pd/FZ/RiaQz8qWYWX4fy4XKUtANzhArx8Wf0n3GL3EvN/9En0HIfPY96jRNtAIKXozbVkDks2iqXcbqhi8L75hblNFv1787RWqOJ6ZOWBJHcfPUNMsmx4JOGtwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826048; c=relaxed/simple;
	bh=HFMBzk/3OHtaxGCN7f0imP3Rl1I2jxN8hDs0RGXi31A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY0ygWErTNJeaVsvGkuvNjUzBvTCAQysK2eD/CHNkgt9oZ6icgLy8F6NQTzuYjxM2whqdicJrMVyprPNGk+R8kEwUrGf2BdhleRlc8/kXn+lCX8hBvk2MFjRdsenP5XMKKpJSK8sH/v2cjrpDfmlWZwOiDnULlzkRgSkq/quJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01449113E;
	Tue, 10 Dec 2024 02:21:13 -0800 (PST)
Received: from [10.1.31.84] (e127648.arm.com [10.1.31.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D8E3F58B;
	Tue, 10 Dec 2024 02:20:42 -0800 (PST)
Message-ID: <a3a4852f-5d22-4440-ac0c-f24f97d3b3d4@arm.com>
Date: Tue, 10 Dec 2024 10:20:40 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpufreq: userspace: Add fast-switch support for
 userspace
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, guohua.yan@unisoc.com, ke.wang@unisoc.com
References: <20241209081429.1871-1-xuewen.yan@unisoc.com>
 <09acd46b-ec63-46ec-a239-e792c3061e52@arm.com>
 <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/24 03:27, Xuewen Yan wrote:
> On Mon, Dec 9, 2024 at 6:36 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 12/9/24 08:14, Xuewen Yan wrote:
>>> Now, the userspace governor does not support userspace,
>>> if the driver only use the fast-switch and not add target_index(),
>>
>> Which driver does that? Is that actually valid?
>> No mainline driver from what I can see.
>>
> 
> Yes, indeed no mainline driver, It's on our own driver.

Fair enough. 
There seems to be handling for that case in cpufreq anyway.

> 
>>> it will cause uerspace not work.
>>
>> s/uerspace/userspace
>> to not work?
>>
>>> So add fast-switch support for userspace governor.
>>>
>>> Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
>>> Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>> ---
>>>  drivers/cpufreq/cpufreq_userspace.c | 35 +++++++++++++++++++++++++----
>>>  1 file changed, 31 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
>>> index 2c42fee76daa..3a99197246ed 100644
>>> --- a/drivers/cpufreq/cpufreq_userspace.c
>>> +++ b/drivers/cpufreq/cpufreq_userspace.c
>>> @@ -21,6 +21,30 @@ struct userspace_policy {
>>>       struct mutex mutex;
>>>  };
>>>
>>> +static int cpufreq_userspace_target_freq(struct cpufreq_policy *policy,
>>> +                     unsigned int target_freq, unsigned int relation)
>>> +{
>>> +     int ret;
>>
>> not really necessary
> 
> In cpufreq_set(), we need the return value.

Sorry for not being clear enough, I suggested rewriting it
like this, although personal preference.

---
static int cpufreq_userspace_target_freq(struct cpufreq_policy *policy,
			unsigned int target_freq, unsigned int relation)
{
	unsigned int idx;

	if (!policy->fast_switch_enabled)
		return __cpufreq_driver_target(policy, target_freq, relation);

	target_freq = clamp_val(target_freq, policy->min, policy->max);
	if (!policy->freq_table)
		return target_freq;

	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
	policy->cached_resolved_idx = idx;
	policy->cached_target_freq = target_freq;
	return !cpufreq_driver_fast_switch(policy, policy->freq_table[idx].frequency);
}


