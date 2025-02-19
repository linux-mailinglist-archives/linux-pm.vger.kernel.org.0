Return-Path: <linux-pm+bounces-22459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B75A3C63C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E9B3A9049
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFCD2144BE;
	Wed, 19 Feb 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoITrMkC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056421423C;
	Wed, 19 Feb 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986185; cv=none; b=ufEHRc6ZuYa2rzsnDyurc6iDI7kmqrQJLmsy12c+dKnZrRpJVx4tdqB6j+xOyHWELztq9/eTTuhjr+j71qo6eTwN+t1POvyk3moTXTi3TFIfcJ/i0fbPfYVCP6SHTUw3k7BL8qjB8X1j5/pA4BfnwGK+GVGMZtU4hRzkV8pVH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986185; c=relaxed/simple;
	bh=z83ueweR+RlrtVXKdG4SNso1GhHBkFmUl/Da6H9R1kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfhTniEk/jsYZsl0ivTJltznTanDZctbK63xSqG4C1v+nrBznDxeo3OmVPQ9q12kyq2F5DZ2JADSmUzAk4CjLlT16lrxuZicU4q4zu4PrlD2+PCd5wlvbA4tKnF4bXbiBW5wD2bxapmQFjlmhfjbWs5w3ZYZao+le7lnVUSqdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoITrMkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23819C4CED1;
	Wed, 19 Feb 2025 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986184;
	bh=z83ueweR+RlrtVXKdG4SNso1GhHBkFmUl/Da6H9R1kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CoITrMkCD6vV2f4sc9dvYR2ngbo5pYU7zcC+2Zx+f3YPayA6Hf4hcAsZ2RN3oskXC
	 MBl4UzMrOIZQGNVJSOafrl+5mmGZQhCwFix/RP2MgdboedUITge/B7hhY+qyFwuL1C
	 1cQOweU0aBJAQ7sHKCwD/wNxP31udV4VmdK+r2dDIgM+R+OIe6uOP1lAoV6t6EUg5e
	 0GZj1aIpDdH0ugQQif9ddKjF6A95ud5KvbcRAzSq6Sd9MZpZsrtvv+x8sHiQLpdJC/
	 QuBXpK6N/bCUYiG2s3ckIQ1FyIE8HACOMJdH1vEF/NdZ5spoob9evsdaW4hoYiE1v1
	 5vDlVrluEHBcw==
Message-ID: <f11f3eae-76cc-4e77-93fb-3ee60003e127@kernel.org>
Date: Wed, 19 Feb 2025 11:29:43 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/18] cpufreq/amd-pstate: Drop min and max cached
 frequencies
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-4-superm1@kernel.org>
 <87a59577-3b66-49ff-a0b5-0cddaa670a27@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <87a59577-3b66-49ff-a0b5-0cddaa670a27@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/2025 02:00, Dhananjay Ugwekar wrote:
> On 2/18/2025 3:36 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Use the perf_to_freq helpers to calculate this on the fly.
> 
> Can we call out the below change (in the -1550,7 +1525,8 code chunk) in
> the commit message, or split it out to different patch
> 
> * Adding the if check in amd_pstate_epp_update_limit()
> 
Yeah will add to commit meesage.

>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> --
> We need one more hyphen here I think i.e."---", otherwise the version info is
> showing up in the commit message
Ack
> 
>> v3:
>>   * Fix calc error for min_freq
>> v2:
>>   * Keep cached limits
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c | 14 +++----
>>   drivers/cpufreq/amd-pstate.c    | 70 +++++++++++----------------------
>>   drivers/cpufreq/amd-pstate.h    |  9 +----
>>   3 files changed, 32 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index 3a0a380c3590c..445278cf40b61 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -214,14 +214,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>>   			break;
>>   		cpudata = policy->driver_data;
>>   
>> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
>> +		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>>   			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>> -			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>> -			(cpudata->min_freq > 0))) {
>> +			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
>> +			(policy->cpuinfo.min_freq > 0))) {
>>   			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>   			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
>> -				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>> +				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
>> +				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
>>   			goto skip_test;
>>   		}
>>   
>> @@ -233,13 +233,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>>   		}
>>   
>>   		if (cpudata->boost_supported) {
>> -			if ((policy->max == cpudata->max_freq) ||
>> +			if ((policy->max == policy->cpuinfo.max_freq) ||
>>   					(policy->max == cpudata->nominal_freq))
>>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>>   			else {
>>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>   				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>> -					__func__, cpu, policy->max, cpudata->max_freq,
>> +					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
>>   					cpudata->nominal_freq);
>>   				goto skip_test;
>>   			}
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 87c605348a3dc..a7c41f915b46e 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -717,7 +717,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>>   	int ret = 0;
>>   
>>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>> -	max_freq = READ_ONCE(cpudata->max_freq);
>> +	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
>>   
>>   	if (on)
>>   		policy->cpuinfo.max_freq = max_freq;
>> @@ -901,35 +901,26 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>>   static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   {
>>   	int ret;
>> -	u32 min_freq, max_freq;
>> -	u32 nominal_freq, lowest_nonlinear_freq;
>> +	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>>   	struct cppc_perf_caps cppc_perf;
>>   
>>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (quirks && quirks->lowest_freq)
>> -		min_freq = quirks->lowest_freq;
>> -	else
>> -		min_freq = cppc_perf.lowest_freq;
>> -
>>   	if (quirks && quirks->nominal_freq)
>>   		nominal_freq = quirks->nominal_freq;
>>   	else
>>   		nominal_freq = cppc_perf.nominal_freq;
>>   
>> -	min_freq *= 1000;
>>   	nominal_freq *= 1000;
>> -
>>   	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>> -	WRITE_ONCE(cpudata->min_freq, min_freq);
>> -
>> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
>> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>>   
>> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>> -	WRITE_ONCE(cpudata->max_freq, max_freq);
>> +	if (quirks && quirks->lowest_freq) {
> 
> We can avoid the "{" for single line if statement, to keep checkpatch happy

This is one of the reason that I don't like to treat checkpatch as 
gospil.  I added it specficially to avoid back and forth for the new 
patch.  In this case I plan to keep it for that reason.

> 
>> +		min_freq = quirks->lowest_freq;
>> +	} else
>> +		min_freq = cppc_perf.lowest_freq;
>> +	min_freq *= 1000;
> 
> I see that this min_freq part of the code is unchanged, just moved few lines below.
> If the moving is unintended can we avoid it, so that the diff is optimal.

Sure I'll see if I can re-order it a bit to keep it the same.

> 
>>   
>>   	/**
>>   	 * Below values need to be initialized correctly, otherwise driver will fail to load
>> @@ -937,12 +928,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>>   	 * Check _CPC in ACPI table objects if any values are incorrect
>>   	 */
>> -	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> 
> Shouldn't we retain these sanity checks for min_freq and max_freq?

Now that we're using the helpers isn't it impossible to end up with 
negative values?

> 
> Thanks,
> Dhananjay
> 
>> -		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
>> -			min_freq, max_freq, nominal_freq);
>> +	if (nominal_freq <= 0) {
>> +		pr_err("nominal_freq(%d) value is incorrect\n",
>> +			nominal_freq);
>>   		return -EINVAL;
>>   	}
>>   
>> +	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>> +
>>   	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
>>   		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>>   			lowest_nonlinear_freq, min_freq, nominal_freq);
>> @@ -954,9 +948,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   
>>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   {
>> -	int min_freq, max_freq, ret;
>> -	struct device *dev;
>>   	struct amd_cpudata *cpudata;
>> +	struct device *dev;
>> +	int ret;
>>   
>>   	/*
>>   	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
>> @@ -987,17 +981,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   	if (ret)
>>   		goto free_cpudata1;
>>   
>> -	min_freq = READ_ONCE(cpudata->min_freq);
>> -	max_freq = READ_ONCE(cpudata->max_freq);
>> -
>>   	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>>   	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>>   
>> -	policy->min = min_freq;
>> -	policy->max = max_freq;
>> -
>> -	policy->cpuinfo.min_freq = min_freq;
>> -	policy->cpuinfo.max_freq = max_freq;
>> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
>> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
>>   
>>   	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>>   
>> @@ -1021,9 +1009,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   		goto free_cpudata2;
>>   	}
>>   
>> -	cpudata->max_limit_freq = max_freq;
>> -	cpudata->min_limit_freq = min_freq;
>> -
>>   	policy->driver_data = cpudata;
>>   
>>   	if (!current_pstate_driver->adjust_perf)
>> @@ -1081,14 +1066,10 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>>   static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>>   					char *buf)
>>   {
>> -	int max_freq;
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   
>> -	max_freq = READ_ONCE(cpudata->max_freq);
>> -	if (max_freq < 0)
>> -		return max_freq;
>>   
>> -	return sysfs_emit(buf, "%u\n", max_freq);
>> +	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
>>   }
>>   
>>   static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
>> @@ -1446,10 +1427,10 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>>   
>>   static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   {
>> -	int min_freq, max_freq, ret;
>>   	struct amd_cpudata *cpudata;
>>   	struct device *dev;
>>   	u64 value;
>> +	int ret;
>>   
>>   	/*
>>   	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
>> @@ -1480,19 +1461,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	if (ret)
>>   		goto free_cpudata1;
>>   
>> -	min_freq = READ_ONCE(cpudata->min_freq);
>> -	max_freq = READ_ONCE(cpudata->max_freq);
>> -
>> -	policy->cpuinfo.min_freq = min_freq;
>> -	policy->cpuinfo.max_freq = max_freq;
>> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
>> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
>>   	/* It will be updated by governor */
>>   	policy->cur = policy->cpuinfo.min_freq;
>>   
>>   	policy->driver_data = cpudata;
>>   
>> -	policy->min = policy->cpuinfo.min_freq;
>> -	policy->max = policy->cpuinfo.max_freq;
>> -
>>   	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>>   
>>   	/*
>> @@ -1550,7 +1525,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	u8 epp;
>>   
>> -	amd_pstate_update_min_max_limit(policy);
>> +	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>> +		amd_pstate_update_min_max_limit(policy);
>>   
>>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>   		epp = 0;
>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index 19d405c6d805e..0149933692458 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -46,8 +46,6 @@ struct amd_aperf_mperf {
>>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
>>    * @min_limit_freq: Cached value of policy->min (in khz)
>>    * @max_limit_freq: Cached value of policy->max (in khz)
>> - * @max_freq: the frequency (in khz) that mapped to highest_perf
>> - * @min_freq: the frequency (in khz) that mapped to lowest_perf
>>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>>    * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>>    * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
>> @@ -77,11 +75,8 @@ struct amd_cpudata {
>>   	u8	prefcore_ranking;
>>   	u8	min_limit_perf;
>>   	u8	max_limit_perf;
>> -	u32     min_limit_freq;
>> -	u32     max_limit_freq;
>> -
>> -	u32	max_freq;
>> -	u32	min_freq;
>> +	u32	min_limit_freq;
>> +	u32	max_limit_freq;
>>   	u32	nominal_freq;
>>   	u32	lowest_nonlinear_freq;
>>   
> 


