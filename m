Return-Path: <linux-pm+bounces-21552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A17A2C85A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBC188A7CC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B023C8C5;
	Fri,  7 Feb 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKxfScMf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DD10F1;
	Fri,  7 Feb 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944948; cv=none; b=YQTf06tzdCabOJb8iJsKLmZlPV/OQRnskIPbrbx8dkUIedwEA6iMr9lHVfWf5bVkoGokBZiAGOPuHmbkXnbul9ddHeWjYdOnXv/hciIVR9GV9qXKzoYlMCdijMfZV1kKuI/lN4FRNiyu1S301MjakYjDEZI9IB7AEbPbAa61yZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944948; c=relaxed/simple;
	bh=w0jy7r2yhYa1fCB+/gaqKE/eMIzOTefS7gNLVaptUrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM3bRRTFNAIySZcvfMPQAmOwWceCFPno7p1WFpkt6L4umxEf1Yflo8y1+F/uWX5+otqn+LlLBLbE5PhtLgiWGrY1zJRa58VMtRI1Sjickkqe5AGRiKltB1Q+zGWTe5XmOK0yBR9Jz9GLDkdU0LWsGtK0QmNSbYmyxsdO4dyBJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKxfScMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59881C4CED1;
	Fri,  7 Feb 2025 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738944947;
	bh=w0jy7r2yhYa1fCB+/gaqKE/eMIzOTefS7gNLVaptUrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KKxfScMfPJY+HSVpkWpRNv2NEbh2fuHod9OfQat9d0QheyIL36P99sHJRB/urGSBO
	 WqfS5eU0C35s2LjzmQjZn4R0Lm1QGH/6Hvg9O8VjRnNzrs9g48AyO7ey/oCotukXnR
	 yhOIxAk7Q00AMMBPsCr+i19p2xg3lRBOe6AoDIex+0PWW/GMz4ut/VLCCNs/km60zk
	 s4NOCVDWjpjZteHbs8kABHr1B0/ZrZuITWyX+PS8k+syj+IuebKbdI1xXmJWLcBtMi
	 ZAIvpB7RbrZ5bzYagXvzwng2225GJdelI0m/AcGWcEU8cwSdApRzso7HYFa5pI/3S+
	 Ay2h5lox4K4Zg==
Message-ID: <e297cb9c-0fc9-4cfb-89c8-6bad5ca9c9e9@kernel.org>
Date: Fri, 7 Feb 2025 10:15:46 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] cpufreq/amd-pstate: Drop min and max cached
 frequencies
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-3-superm1@kernel.org>
 <2dbded5a-b353-480c-a2ea-ed246f5c0b27@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2dbded5a-b353-480c-a2ea-ed246f5c0b27@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/2025 04:44, Dhananjay Ugwekar wrote:
> Hello Mario,
> 
> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Use the perf_to_freq helpers to calculate this on the fly.
> 
> I think there is a benefit to having the min/max_limit_freq values cached.
> These values help us avoid unnecessary amd_pstate_update_min_max_limit() calls in
> majority of cases (where the policy->min/max values didnt change).
> 
> For the cpudata->min/max_freq values, I think there is little value in caching them,
> i.e. only used in amd_pstate_cpu_boost_update() and show_amd_pstate_max_freq(), which
> are not supposed to be called very frequently.
> 
> So, I propose we keep the cpudata->min/max_limit_freq variables and remove the
> cpudata->min/max_freq ones. Thoughts?

Yeah I can see this argument making sense and worthwhile keeping the 
caching.  I'll modify it for the next version.

> 
> Thanks,
> Dhananjay
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c | 14 +++----
>>   drivers/cpufreq/amd-pstate.c    | 74 ++++++++++-----------------------
>>   drivers/cpufreq/amd-pstate.h    |  8 ----
>>   3 files changed, 29 insertions(+), 67 deletions(-)
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
>> index 573643654e8d6..668377f55b630 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -615,8 +615,6 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>   
>>   	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>>   	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>> -	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>> -	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
>>   
>>   	return 0;
>>   }
>> @@ -628,8 +626,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	u8 des_perf;
>>   
>> -	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>> -		amd_pstate_update_min_max_limit(policy);
>> +	amd_pstate_update_min_max_limit(policy);
>>   
>>   	freqs.old = policy->cur;
>>   	freqs.new = target_freq;
>> @@ -684,8 +681,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>   
>>   	cpudata = policy->driver_data;
>>   
>> -	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>> -		amd_pstate_update_min_max_limit(policy);
>> +	amd_pstate_update_min_max_limit(policy);
>>   
>>   	cap_perf = READ_ONCE(cpudata->highest_perf);
>>   	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
>> @@ -717,7 +713,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>>   	int ret = 0;
>>   
>>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>> -	max_freq = READ_ONCE(cpudata->max_freq);
>> +	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
>>   
>>   	if (on)
>>   		policy->cpuinfo.max_freq = max_freq;
>> @@ -901,35 +897,25 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
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
>>   
>> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
>> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>> -
>> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>> -	WRITE_ONCE(cpudata->max_freq, max_freq);
>> +	if (quirks && quirks->lowest_freq) {
>> +		min_freq = quirks->lowest_freq;
>> +	} else
>> +		min_freq = cppc_perf.lowest_freq;
>>   
>>   	/**
>>   	 * Below values need to be initialized correctly, otherwise driver will fail to load
>> @@ -937,12 +923,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>>   	 * Check _CPC in ACPI table objects if any values are incorrect
>>   	 */
>> -	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
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
>> @@ -954,9 +943,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
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
>> @@ -987,17 +976,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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
>> @@ -1021,9 +1004,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   		goto free_cpudata2;
>>   	}
>>   
>> -	cpudata->max_limit_freq = max_freq;
>> -	cpudata->min_limit_freq = min_freq;
>> -
>>   	policy->driver_data = cpudata;
>>   
>>   	if (!current_pstate_driver->adjust_perf)
>> @@ -1081,14 +1061,10 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
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
>> @@ -1446,10 +1422,10 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
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
>> @@ -1480,19 +1456,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index 19d405c6d805e..472044a1de43b 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -44,10 +44,6 @@ struct amd_aperf_mperf {
>>    * 		  priority.
>>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
>> - * @min_limit_freq: Cached value of policy->min (in khz)
>> - * @max_limit_freq: Cached value of policy->max (in khz)
>> - * @max_freq: the frequency (in khz) that mapped to highest_perf
>> - * @min_freq: the frequency (in khz) that mapped to lowest_perf
>>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>>    * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>>    * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
>> @@ -77,11 +73,7 @@ struct amd_cpudata {
>>   	u8	prefcore_ranking;
>>   	u8	min_limit_perf;
>>   	u8	max_limit_perf;
>> -	u32     min_limit_freq;
>> -	u32     max_limit_freq;
>>   
>> -	u32	max_freq;
>> -	u32	min_freq;
>>   	u32	nominal_freq;
>>   	u32	lowest_nonlinear_freq;
>>   
> 


