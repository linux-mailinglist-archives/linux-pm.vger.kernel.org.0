Return-Path: <linux-pm+bounces-24263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F0A67D2C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 20:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14EF3B462A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015261DED62;
	Tue, 18 Mar 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tERJ4Br4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6C1A23B7;
	Tue, 18 Mar 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326572; cv=none; b=Jxw0GFXIjU3HDis3dNmLqz+mFJj4qUM8R8MVBWHsrTKE5vz98+oWN61MIzxrpmfl3Jv0CKslY5CWOZaAky7jXQJ25c3y9D5/l2/Yd1qfUIxNL3Nczniqeztlk1v0gUvdC/sTivYId5lBSHmFbf4V+n+mDzzE2X+7v5M7GtuAUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326572; c=relaxed/simple;
	bh=cy0NsClVUWNdiZbdkyawS7MAWfXRCzGsyvdnyp5DK3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwGbocnRtDIHr6KEWZeaBekhrxW5PS/Czry3maG24UtQwkMLMD4sQ/2LqpR1Es6uyffUoppNBmzuew6SjY2RqBSSD56SwH9/yUvad09uEZRTfazNbqM8R18crxVoiK2jtrNbB4/Qjzmp9Go/LtXEYVACF/ZGkBqwNBMmMKhTayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tERJ4Br4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A9C4CEDD;
	Tue, 18 Mar 2025 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742326572;
	bh=cy0NsClVUWNdiZbdkyawS7MAWfXRCzGsyvdnyp5DK3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tERJ4Br4q8bWQms9AT1dZXjVPzXRMTI6ETQxogcJG6oqoxSfQkbqvjyoZ5VCIXGjO
	 xSOQQrG7MzV0/y1uTjqqFn2CyLBPgi7+pWM+mtJz2xOqwBsrvzNGHOFKoUwiPsV8ov
	 O1g3L7MhmKI29kvwGBY0r4chHZgaFygK0tTQQVJX8UJkNpM/983rB6PJKSfpXxbzzd
	 adEJKV9sRX+U5k/du8QvaTwlGcG4JRFZUhf49jStNL36G5EZei4HL1mHay7J5XJ4hR
	 iOQjinxbVIq2syh0cLYcOR/Jc62xGyFTG5FMirGhCqaoFGBkDAcYfvCDa/vswg1avs
	 X2v7PCRg70wmw==
Message-ID: <4e0ab8ce-908e-49a1-8445-14129a41afda@kernel.org>
Date: Tue, 18 Mar 2025 14:36:10 -0500
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <8e87fa8c-5254-46d5-a853-46e8c31cbe0e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/2025 07:16, Dhananjay Ugwekar wrote:
> On 3/4/2025 8:53 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Dynamic energy performance preference will change the EPP profile
>> based on whether the machine is running on AC or DC power.
>>
>> A notification chain from the power supply core is used to adjust
>> EPP values on plug in or plug out events.
>>
>> For non-server systems:
>>      * the default EPP for AC mode is `performance`.
>>      * the default EPP for DC mode is `balance_performance`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Change defaults to performance (AC) and balance_performance (DC)
>>   * Default Kconfig to disabled for now
>>   * Rebase on latest branch
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>   drivers/cpufreq/Kconfig.x86                 |  12 ++
>>   drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>>   drivers/cpufreq/amd-pstate.h                |   5 +-
>>   4 files changed, 155 insertions(+), 9 deletions(-)
>>
> [Snip]
>> @@ -1556,6 +1667,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>   	if (!policy->cpuinfo.max_freq)
>>   		return -ENODEV;
>>   
>> +	/* policy can't be changed to performance policy while dynamic epp is enabled */
>> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE && cpudata->dynamic_epp)
>> +		return -EBUSY;
> 
> We might need to tweak this condition, because if we enable "CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP" in config
> and boot with "amd_pstate=active" it lands here (cpufreq_online()->amd_pstate_epp_set_policy()) driver init fails
> as the default governor is performance.
> 

The check is important to make sure that you can't go to performance 
mode after init.

I think this is the way I would want to solve it.
Set policy to powersave before enabling dynamic epp for 
amd_pstate_epp_cpu_init().

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 824756ac0010e..4a0f561d0e2d1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1729,8 +1729,10 @@ static int amd_pstate_epp_cpu_init(struct 
cpufreq_policy *policy)
                 WRITE_ONCE(cpudata->cppc_req_cached, value);
         }

-       if (dynamic_epp)
+       if (dynamic_epp) {
+               policy->policy = CPUFREQ_POLICY_POWERSAVE;
                 ret = amd_pstate_set_dynamic_epp(policy);
+       }
         else
                 ret = amd_pstate_set_epp(policy, 
amd_pstate_get_balanced_epp(policy));
         if (ret)

Thoughts?

>> +
>>   	cpudata->policy = policy->policy;
>>   
>>   	ret = amd_pstate_epp_update_limit(policy);
>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index fbe1c08d3f061..6882876f895de 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -104,7 +104,10 @@ struct amd_cpudata {
>>   	/* EPP feature related attributes*/
>>   	u32	policy;
>>   	bool	suspended;
>> -	u8	epp_default;
>> +	u8	epp_default_ac;
>> +	u8	epp_default_dc;
>> +	bool	dynamic_epp;
>> +	struct notifier_block power_nb;
>>   };
>>   
>>   /*
> 


