Return-Path: <linux-pm+bounces-22461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE91BA3C6FE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089E21886317
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113662116F9;
	Wed, 19 Feb 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaEJREB5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99068F7D;
	Wed, 19 Feb 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988359; cv=none; b=OUZm9FpScON5texNSrpLNfCwW1z0jy5hVr0rfGnDOMMuICWLZOpcqnprFQS8QlLpd0gSPQgPncJp5H//sT0eIBFWBcWn+nBU36jYZCIDx5XyJZ7EOYsVLjulC1vTVZwjmMvvrsMMjODgEN/6H7Q3yQQ8vOv3DoL3Uyl0o3GcFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988359; c=relaxed/simple;
	bh=rmLqgVZ46zmjfiZfRiXtm3hs21qb1OdC4OcV8JEeWnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+2jsVQx0OFu27NIpWeim+9DFXQRBCOYI3xRBnp01sXPmxxZpg48EB2F5wkhHzBGfvdjsuWJgcypUe3OfKoYZolRVjraeAJYgIFxtLQJFqsUBBDbol/r5p6BCJiT5zrmv3pS7pdxc/P4KTaKwcF2ldrc82F7eZB0Zd4GqNEJGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaEJREB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47B3C4CED1;
	Wed, 19 Feb 2025 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988358;
	bh=rmLqgVZ46zmjfiZfRiXtm3hs21qb1OdC4OcV8JEeWnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SaEJREB58NeGeSjmBxg/0nExTiXpnh6Q84pUBcA7IvrHNnkEVRwT/Pj9xCBkrPrkj
	 D6arsBGguM/OYTfXJia8UXH/64lz9ZWjbH0ueSX45WDZMEgbpdtlFlKReN6xB44cCk
	 gjMzRRyGrWue4wu1goWEVdxIyCZLZ0pZWv5XfNaKtJB12FJroAj0nU1uKxxp/6x88f
	 emItFemMnYov45SvrZUpgnTutciuUiRSCdt6EDAx8eyWDOZNHilGwlM8q8Vugl2WXI
	 dohAHFlC0MCrYcO+FyUCxZh8VI0RWaR6Zx+IJ+A6UnNdjXtreAKvjJVC8RAn+4lsx2
	 CjCecO1xN9W4g==
Message-ID: <fe9b5d8d-5cbb-4d0c-bd12-b15a8d44062d@kernel.org>
Date: Wed, 19 Feb 2025 12:05:57 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/18] cpufreq/amd-pstate: Rework CPPC enabling
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-18-superm1@kernel.org>
 <Z7X4BfEAbRwCg2Dg@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z7X4BfEAbRwCg2Dg@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/2025 09:25, Gautham R. Shenoy wrote:
> On Mon, Feb 17, 2025 at 04:07:06PM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The CPPC enable register is configured as "write once".  That is
>> any future writes don't actually do anything.
>>
>> Because of this, all the cleanup paths that currently exist for
>> CPPC disable are non-effective.
>>
>> Rework CPPC enable to only enable after all the CAP registers have
>> been read to avoid enabling CPPC on CPUs with invalid _CPC or
>> unpopulated MSRs.
>>
>> As the register is write once, remove all cleanup paths as well.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3:
>>   * Fixup for suspend/resume issue
>> ---
> [..snip..]
> 
>>   
>> -static int shmem_cppc_enable(bool enable)
>> +static int shmem_cppc_enable(struct cpufreq_policy *policy)
>>   {
>> -	int cpu, ret = 0;
>> +	struct amd_cpudata *cpudata = policy->driver_data;
>>   	struct cppc_perf_ctrls perf_ctrls;
>> +	int ret;
>>   
>> -	if (enable == cppc_enabled)
>> -		return 0;
>> +	ret = cppc_set_enable(cpudata->cpu, 1);
>> +	if (ret)
>> +		return ret;
>>   
>> -	for_each_present_cpu(cpu) {
>> -		ret = cppc_set_enable(cpu, enable);
>> +	/* Enable autonomous mode for EPP */
>> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
>> +		/* Set desired perf as zero to allow EPP firmware control */
>> +		perf_ctrls.desired_perf = 0;
>> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
>>   		if (ret)
>>   			return ret;
> 
> We don't need the if condition here. There is nothing following this
> inside the if block and the function return "ret" soon after coming
> out of this if block.
> 
> 
>> -
>> -		/* Enable autonomous mode for EPP */
>> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
>> -			/* Set desired perf as zero to allow EPP firmware control */
>> -			perf_ctrls.desired_perf = 0;
>> -			ret = cppc_set_perf(cpu, &perf_ctrls);
>> -			if (ret)
>> -				return ret;
>> -		}
>>   	}
>>   
>> -	cppc_enabled = enable;
>>   	return ret;
>>   }
>>   
>>   DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>>   
>> -static inline int amd_pstate_cppc_enable(bool enable)
> [..snip..]
> 
>>   
>> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>> +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>>   	int ret;
>>   
>> -	ret = amd_pstate_cppc_enable(true);
>> -	if (ret)
>> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>> -
>> -
>> -	return amd_pstate_epp_update_limit(policy);
>> -}
>> +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>>   
>> -static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>> -{
>> -	struct amd_cpudata *cpudata = policy->driver_data;
>> -	int ret;
>> +	ret = amd_pstate_cppc_enable(policy);
>> +	if (ret)
>> +		return ret;
>>   
>> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>>   
>> -	ret = amd_pstate_epp_reenable(policy);
>> +	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> 
> Previously, when a CPU came online, the callpath would be
> amd_pstate_epp_cpu_online(policy)
> --> amd_pstate_epp_reenable(policy)
>       --> amd_pstate_epp_update_limit(policy)
>            --> amd_pstate_epp_update_limit(policy)
> 
> which reevaluates the min_perf_limit and max_perf_limit based on
> policy->min and policy->max and then calls
> 
>        amd_pstate_update_perf(policy, min_limit_perf, 0, max_limit_perf, epp, false)
> 
> With this patch, we call
> 
>        amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> 
> which would set CPPC.min_perf to 0.
> 
> I guess this should be ok since cpufreq_online() would eventually call
> amd_pstate_verify() and amd_pstate_epp_set_policy() which should
> re-initialize the the min_limit_perf and max_limit_perf. Though I
> haven't verified if the behaviour changes with this patch when the CPU
> is offlined and brought back online.

I'll double check with removing amd_pstate_update_perf() call from 
amd_pstate_epp_cpu_online().  I think it will be clearer to let it get 
set from the amd_pstate_epp_set_policy() call.


