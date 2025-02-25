Return-Path: <linux-pm+bounces-22857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B1EA4331E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7BE173C29
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E61624D4;
	Tue, 25 Feb 2025 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujScPUBX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADE1624C7;
	Tue, 25 Feb 2025 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450921; cv=none; b=s4c5rEFza4C1RYuztaAZiuSdp5ZX7H42WlHJX8HyfmGnQM4TFq5eaMML4Ax+YAdRThdUMipSa7peD+bqDbPti8WK/BTlvRHCzDX1ED30rxjpOYcmNqbTWsUyhB5yWPky+aGE3b0M55u0gS6T/s+H7zkssOGj2CCm2cz0kE/nkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450921; c=relaxed/simple;
	bh=yI3U9kFvQuboZ2tG8G24IVcpAGjmPqYpf3KrY/IyXO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zd/7phsUH/ROE2ILvD+O+XqWJD+wt3v5HulXOmV4MrfSWZAQQUFDO4KVpmNUBUVN7rynPQbfqbu552rsEe2wkp0kJvrqsEC7kI27Xyrw8ZLds59As/JBJBE+ZkbpMN3dIvtL9RqsF2ujV90aKV3qg9Dw6W6cb0aBcw2Q8mvqC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujScPUBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5ACC4CEE6;
	Tue, 25 Feb 2025 02:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450921;
	bh=yI3U9kFvQuboZ2tG8G24IVcpAGjmPqYpf3KrY/IyXO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ujScPUBXNG0Hja+fR8/f5QdSCju2RnGIvY1VLPb7JA3kxy6FrlIG/bQbyXDVr2FpI
	 Xa4VDgljHPkmJdPHMyXCGZaQUmmzkT1GGV5jGVDxLpsFd/nNvUoY34TY8AoXKdZ5Af
	 k2k2crtqkpTwwD3pT4r4aniC8LHQGA4ljJO/8m6414C1KoIRFVSl6S2dMgfhf5R40x
	 FLod1Kt7TalcUQHYlICD/WJgEXeFYurKYPwYE/qiRBx4qxwB6Sfiai72H1wZW2PM7s
	 cCmXEj3ZUGaV4cOOz0oalR52PtRDGKxxgPwQz6VJfLsEqBju2hxrUOtB5Ie1zusl9S
	 yEGEz3znia/cg==
Message-ID: <9db9da8f-859d-4e23-94ca-e14905c8c6c7@kernel.org>
Date: Mon, 24 Feb 2025 18:29:05 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] cpufreq/amd-pstate: Move perf values into a
 union
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-5-superm1@kernel.org>
 <ccac287d-5bde-4b0d-a1d6-b1e8b5f4e6cb@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <ccac287d-5bde-4b0d-a1d6-b1e8b5f4e6cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/2025 04:57, Dhananjay Ugwekar wrote:
> On 2/18/2025 3:36 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> By storing perf values in a union all the writes and reads can
>> be done atomically, removing the need for some concurrency protections.
>>
>> While making this change, also drop the cached frequency values,
>> using inline helpers to calculate them on demand from perf value.
>>
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3:
>>   * Pick up tag
>> v2:
>>   * cache perf variable in unit tests
>>   * Drop unnecessary check from amd_pstate_update_min_max_limit()
>>   * Consistency with READ_ONCE()
>>   * Drop unneeded policy checks
>>   * add kdoc
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c |  18 +--
>>   drivers/cpufreq/amd-pstate.c    | 195 ++++++++++++++++++--------------
>>   drivers/cpufreq/amd-pstate.h    |  49 +++++---
>>   3 files changed, 151 insertions(+), 111 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index 445278cf40b61..ba3e06f349c6d 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -129,6 +129,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>>   	struct cppc_perf_caps cppc_perf;
>>   	struct cpufreq_policy *policy = NULL;
>>   	struct amd_cpudata *cpudata = NULL;
>> +	union perf_cached cur_perf;
>>   
>>   	for_each_possible_cpu(cpu) {
>>   		policy = cpufreq_cpu_get(cpu);
>> @@ -162,19 +163,20 @@ static void amd_pstate_ut_check_perf(u32 index)
>>   			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>>   		}
>>   
>> -		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
>> +		cur_perf = READ_ONCE(cpudata->perf);
>> +		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
>>   			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
>> -				__func__, cpu, highest_perf, cpudata->highest_perf);
>> +				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
> 						  Can we use cur_perf.highest_perf here ?

Ack.

> 
>>   			goto skip_test;
>>   		}
>> -		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
>> -			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
>> -			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
>> +		if (nominal_perf != cur_perf.nominal_perf ||
>> +		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
>> +		   (lowest_perf != cur_perf.lowest_perf)) {
>>   			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>   			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
>> -				__func__, cpu, nominal_perf, cpudata->nominal_perf,
>> -				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
>> -				lowest_perf, cpudata->lowest_perf);
>> +				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
>> +				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
>> +				lowest_perf, cpudata->perf.lowest_perf);
> 			          Can we use cur_perf.(nominal/lowest_nonlinear/lowest)_perf here as well ?			

Ack.
			
> 
>>   			goto skip_test;
>>   		}
>>
> [Snip]
>> @@ -888,25 +896,24 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>>   }
>>   
>>   /*
>> - * amd_pstate_init_freq: Initialize the max_freq, min_freq,
>> - *                       nominal_freq and lowest_nonlinear_freq for
>> - *                       the @cpudata object.
>> + * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
>> + *			 for the @cpudata object.
>>    *
>> - *  Requires: highest_perf, lowest_perf, nominal_perf and
>> - *            lowest_nonlinear_perf members of @cpudata to be
>> - *            initialized.
>> + * Requires: all perf members of @cpudata to be initialized.
>>    *
>> - *  Returns 0 on success, non-zero value on failure.
>> + * Returns 0 on success, non-zero value on failure.
>>    */
>>   static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   {
>> -	int ret;
>>   	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>>   	struct cppc_perf_caps cppc_perf;
>> +	union perf_cached perf;
>> +	int ret;
>>   
>>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>   	if (ret)
>>   		return ret;
>> +	perf = READ_ONCE(cpudata->perf);
>>   
>>   	if (quirks && quirks->nominal_freq)
>>   		nominal_freq = quirks->nominal_freq;
>> @@ -918,6 +925,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   
>>   	if (quirks && quirks->lowest_freq) {
>>   		min_freq = quirks->lowest_freq;
>> +		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
> 
> I think we forgot to write back this value to the cpudata->perf variable

Ack, great catch.

> 
>>   	} else
>>   		min_freq = cppc_perf.lowest_freq;
>>   	min_freq *= 1000;
>> @@ -934,7 +942,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   		return -EINVAL;
>>   	}
>>   
>> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>> +	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>>   	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>>   
>>   	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
> [Snip]
>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index 0149933692458..8421c83c07919 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -13,6 +13,34 @@
>>   /*********************************************************************
>>    *                        AMD P-state INTERFACE                       *
>>    *********************************************************************/
>> +
>> +/**
>> + * union perf_cached - A union to cache performance-related data.
>> + * @highest_perf: the maximum performance an individual processor may reach,
>> + *		  assuming ideal conditions
>> + *		  For platforms that do not support the preferred core feature, the
>> + *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> 
> s/highest_pef/highest_perf/
> 
> Also I think this statement is bit confusing, how about,
> 
> "For platforms that support the preferred core feature, the highest_perf value maybe
> configured to any value in the range 166-256 by the firmware (because the preferred
> core ranking is encoded in the highest_perf value). To maintain consistency across
> all platforms, we split the highest_perf and preferred core ranking values into
> cpudata->perf.highest_perf and cpudata->prefcore_ranking."

I like it, thanks.

> 
>> + *		  calculated wrongly. we take the fixed value as the highest_perf.
>> + * @nominal_perf: the maximum sustained performance level of the processor,
>> + *		  assuming ideal operating conditions
>> + * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
>> + *			   savings are achieved
>> + * @lowest_perf: the absolute lowest performance level of the processor
>> + * @min_limit_perf: Cached value of the performance corresponding to policy->min
>> + * @max_limit_perf: Cached value of the performance corresponding to policy->max
>> + */
>> +union perf_cached {
>> +	struct {
>> +		u8	highest_perf;
>> +		u8	nominal_perf;
>> +		u8	lowest_nonlinear_perf;
>> +		u8	lowest_perf;
>> +		u8	min_limit_perf;
>> +		u8	max_limit_perf;
> 
> Just a thought, how about adding the "u8 desired_perf" (last requested) and "u8 prefcore_ranking"
> in this. We can pursue it as a separate patch if you want.
> 
> I think there is value in adding desired_perf atleast, so that when we are caching the
> min, max limits in the perf_cached variable, desired perf level is also atomically
> updated into the shared cpudata structure.

Can you see if there is any performance advantage to caching these?
If there is, can you please do a follow up to my v5 series?

It's going to mean another write in amd_pstate_update() potentially.

> 
> Thanks,
> Dhananjay
> 
>> +	};
>> +	u64	val;
>> +};
>> +
>>   /**
>>    * struct  amd_aperf_mperf
>>    * @aperf: actual performance frequency clock count
>> @@ -30,20 +58,9 @@ struct amd_aperf_mperf {
>>    * @cpu: CPU number
>>    * @req: constraint request to apply
>>    * @cppc_req_cached: cached performance request hints
>> - * @highest_perf: the maximum performance an individual processor may reach,
>> - *		  assuming ideal conditions
>> - *		  For platforms that do not support the preferred core feature, the
>> - *		  highest_pef may be configured with 166 or 255, to avoid max frequency
>> - *		  calculated wrongly. we take the fixed value as the highest_perf.
>> - * @nominal_perf: the maximum sustained performance level of the processor,
>> - *		  assuming ideal operating conditions
>> - * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
>> - *			   savings are achieved
>> - * @lowest_perf: the absolute lowest performance level of the processor
>> + * @perf: cached performance-related data
>>    * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>>    * 		  priority.
>> - * @min_limit_perf: Cached value of the performance corresponding to policy->min
>> - * @max_limit_perf: Cached value of the performance corresponding to policy->max
>>    * @min_limit_freq: Cached value of policy->min (in khz)
>>    * @max_limit_freq: Cached value of policy->max (in khz)
>>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>> @@ -68,13 +85,9 @@ struct amd_cpudata {
>>   	struct	freq_qos_request req[2];
>>   	u64	cppc_req_cached;
>>   
>> -	u8	highest_perf;
>> -	u8	nominal_perf;
>> -	u8	lowest_nonlinear_perf;
>> -	u8	lowest_perf;
>> +	union perf_cached perf;
>> +
>>   	u8	prefcore_ranking;
>> -	u8	min_limit_perf;
>> -	u8	max_limit_perf;
>>   	u32	min_limit_freq;
>>   	u32	max_limit_freq;
>>   	u32	nominal_freq;
> 


