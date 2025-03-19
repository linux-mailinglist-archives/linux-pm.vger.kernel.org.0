Return-Path: <linux-pm+bounces-24289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF1A69579
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364C519C3C5F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAFE209679;
	Wed, 19 Mar 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfx8+PGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AA1E5B84;
	Wed, 19 Mar 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403019; cv=none; b=OdGYILnpAEidhRK2ERAt29CDCm+vyDi19vXjX1q1TPzzQytZYq3hhUaxxvZ7nkDHFfu25pL0f9paysO+0D9i98WTDWzSqfmLJdWzdsLDp9EB4bkJ8sY1/842nNfR2gRXyQr6La0U5AG/JOhQs+yLi3lvGsYGgdFzeDZ60msrJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403019; c=relaxed/simple;
	bh=w0W+Vhmg4HTW7H48JXQ0/qnZxJb4KW9yQ3M+Ys4N2eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEHJRLmaZv91wVT6foJsPX9q0M94XImijDPPSrqm/XBpik7wI/p/IKLbYtOMEjuoPqMhHFuucXBZ6lpFAr1FSTBfqcH2mNtoVsm0fGkTH1OOVBr2Bve+fuzEOMoBU+9VKiB/rcK8aMltp9z7QSsvgYpDqHvqGiprMDfkk7mTMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfx8+PGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43FCC4CEE4;
	Wed, 19 Mar 2025 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403018;
	bh=w0W+Vhmg4HTW7H48JXQ0/qnZxJb4KW9yQ3M+Ys4N2eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sfx8+PGKRlmsa/iCCAg9PvHSjDpWNGaWLkSw18m1d20Z0Od4ZpAYptWYutoyKPfJg
	 1CY5RN6XSrvUgcjVIsN1/q8AkBANTsUV7X0+qFmbv52QiVg/okRuhZ+beJDEGeKF86
	 CHTM5rCNBzx4kUEUVwUAHXJ6jm5+xjrS46JDysvfAAPpLy9XYLiyoQDmMaMkgMy4ri
	 esP5BT5B2zxY3aBeYZ7RYSpj6gfqNQZFCMnJP+5ECEvOSzrl1dhtWDT3zzMkLuclmX
	 +GTV5PEk0cGiACmga+rcwgzn8mGTRylZD6+txlffGyf6GTHQrEf6xQoM+S7AgSx/Ro
	 mxUWjng7selBQ==
Message-ID: <59a20c51-aa1a-414d-97a6-610a82947472@kernel.org>
Date: Wed, 19 Mar 2025 11:50:16 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
 <8e87fa8c-5254-46d5-a853-46e8c31cbe0e@amd.com>
 <4e0ab8ce-908e-49a1-8445-14129a41afda@kernel.org>
 <5eb7d32e-d251-4536-a4e8-61670aa34869@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5eb7d32e-d251-4536-a4e8-61670aa34869@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/2025 22:43, Dhananjay Ugwekar wrote:
> On 3/19/2025 1:06 AM, Mario Limonciello wrote:
>> On 3/12/2025 07:16, Dhananjay Ugwekar wrote:
>>> On 3/4/2025 8:53 PM, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Dynamic energy performance preference will change the EPP profile
>>>> based on whether the machine is running on AC or DC power.
>>>>
>>>> A notification chain from the power supply core is used to adjust
>>>> EPP values on plug in or plug out events.
>>>>
>>>> For non-server systems:
>>>>       * the default EPP for AC mode is `performance`.
>>>>       * the default EPP for DC mode is `balance_performance`.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v1->v2:
>>>>    * Change defaults to performance (AC) and balance_performance (DC)
>>>>    * Default Kconfig to disabled for now
>>>>    * Rebase on latest branch
>>>> ---
>>>>    Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>>>    drivers/cpufreq/Kconfig.x86                 |  12 ++
>>>>    drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>>>>    drivers/cpufreq/amd-pstate.h                |   5 +-
>>>>    4 files changed, 155 insertions(+), 9 deletions(-)
>>>>
>>> [Snip]
>>>> @@ -1556,6 +1667,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>>>        if (!policy->cpuinfo.max_freq)
>>>>            return -ENODEV;
>>>>    +    /* policy can't be changed to performance policy while dynamic epp is enabled */
>>>> +    if (policy->policy == CPUFREQ_POLICY_PERFORMANCE && cpudata->dynamic_epp)
>>>> +        return -EBUSY;
>>>
>>> We might need to tweak this condition, because if we enable "CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP" in config
>>> and boot with "amd_pstate=active" it lands here (cpufreq_online()->amd_pstate_epp_set_policy()) driver init fails
>>> as the default governor is performance.
>>>
>>
>> The check is important to make sure that you can't go to performance mode after init.
>>
>> I think this is the way I would want to solve it.
>> Set policy to powersave before enabling dynamic epp for amd_pstate_epp_cpu_init().
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 824756ac0010e..4a0f561d0e2d1 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1729,8 +1729,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>                  WRITE_ONCE(cpudata->cppc_req_cached, value);
>>          }
>>
>> -       if (dynamic_epp)
>> +       if (dynamic_epp) {
>> +               policy->policy = CPUFREQ_POLICY_POWERSAVE;
>>                  ret = amd_pstate_set_dynamic_epp(policy);
>> +       }
>>          else
>>                  ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
> 			^^^^^^^^^^^^ (mentioned below)
>>          if (ret)
>>
>> Thoughts?
> 
> Yes, this looks good, because anyway there is no point in having performance governor and dynamic
> epp set at the same time.
> 
> I found one related quirk though, we are setting performance governor for server platforms in
> amd_pstate_epp_cpu_init() and then setting epp at the line highlighted above. We dont have a
> check in *_set_epp() functions for performance governor. This could alter the performance governor
> behavior if we set a "balanced" epp for it. I haven't tested this part yet.

In that case we probably want the "default" ACPI platform profile to be 
"performance" when on a server instead of balanced.

> 
> Thanks,
> Dhananjay
> 
>>
>>>> +
>>>>        cpudata->policy = policy->policy;
>>>>          ret = amd_pstate_epp_update_limit(policy);
>>>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>>> index fbe1c08d3f061..6882876f895de 100644
>>>> --- a/drivers/cpufreq/amd-pstate.h
>>>> +++ b/drivers/cpufreq/amd-pstate.h
>>>> @@ -104,7 +104,10 @@ struct amd_cpudata {
>>>>        /* EPP feature related attributes*/
>>>>        u32    policy;
>>>>        bool    suspended;
>>>> -    u8    epp_default;
>>>> +    u8    epp_default_ac;
>>>> +    u8    epp_default_dc;
>>>> +    bool    dynamic_epp;
>>>> +    struct notifier_block power_nb;
>>>>    };
>>>>      /*
>>>
>>
> 


