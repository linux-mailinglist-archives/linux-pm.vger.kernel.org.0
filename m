Return-Path: <linux-pm+bounces-22855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3AFA43322
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E7C188BF1F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 02:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1011465B4;
	Tue, 25 Feb 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRu4X9oZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217D450FE;
	Tue, 25 Feb 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450917; cv=none; b=V62ZkNvi/VF1TeGgAQDK0tAwraOaP2s3UIn+y6ww0j4gzjk2wgCfhKShUEBtxhLG2DumWtS61jvZ/yKPMH67aEBbQFmfXvfSNEjsoeZg8Jdo3wP3Gmq/1XOHPvLIw8hz0JmKar05XSWq8xJcQt/W3P5Gc+Z2l/IzkCV3dL/4BTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450917; c=relaxed/simple;
	bh=sOfN/hbIbHyTmlt9gE+BG8G4oM3+WPCwJ0wjCX397WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=up4varoDyZFNCGv0w9D1am09eatzBMM2DUdp6nzlgKi3qhujTCyF6UJa12Bg1UoDW0MZoSwZuNif5lfy35P35HEw0449HltJd4oHIdRiC9sAGlrafBLRFpxzGkQT6k5nOnPg2qbgB2CnJW8VoOOVd/jNfOeYAiun3S9IT7qoUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRu4X9oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C5BC4CEE8;
	Tue, 25 Feb 2025 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450917;
	bh=sOfN/hbIbHyTmlt9gE+BG8G4oM3+WPCwJ0wjCX397WE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZRu4X9oZBqZiWWXCi29UFBuhOE45ar2nTyjlUkABKLRIXjOSnE3XE0zQTZaBm8ohJ
	 BotLJKF7FYx3U12SQvQWm79K1vt4gIDUta4vIW4R56QrdnniOk+wgxaucrawRFwmjn
	 6yHP7h2Kd/n8tpseo3RXRDLKvI9tUB9jXwO2AKdVfglnsKCK6kXmM+GVx7zo3Acg04
	 33CtEe+fpExBCmAjKcG9UVLqqZc6h26lRj5Rw4n3CVAVOs0KGhfKvnqlWSsNJeiE5F
	 o9fb9XOiPrU50/0FLo6Qrjm0Eg78Ome4LOAvAIVo05oMFtlmmkkUEdAT7X3ycsRDmH
	 fE7VBzQKZhShA==
Message-ID: <767f4c49-7183-4aef-940f-3a811319eb11@kernel.org>
Date: Mon, 24 Feb 2025 17:59:10 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] cpufreq/amd-pstate: Rework CPPC enabling
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-18-superm1@kernel.org>
 <59c1fb63-1342-4aed-8b4d-f07c263cc74f@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <59c1fb63-1342-4aed-8b4d-f07c263cc74f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +	/* Enable autonomous mode for EPP */
>> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
>> +		/* Set desired perf as zero to allow EPP firmware control */
>> +		perf_ctrls.desired_perf = 0;
>> +		ret = cppc_set_perf(policy->cpu, &perf_ctrls);
> 
> I'm thinking do we need this "setting of desired_perf" as a part of shmem_cppc_enable,
> one thing is we're not doing it in the "msr_" counterpart
> also, I guess this would be taken care as part of amd_pstate_epp_set_policy()->amd_pstate_epp_update_limit()->amd_pstate_update_perf()

Great point, agreed will drop it.

> 
>>   	}
>>   
>> -	cppc_enabled = enable;
>>   	return ret;
>>   }
>>   
>>   DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>>   
>> -static inline int amd_pstate_cppc_enable(bool enable)
>> +static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>>   {
>> -	return static_call(amd_pstate_cppc_enable)(enable);
>> +	return static_call(amd_pstate_cppc_enable)(policy);
>>   }
>>   
>>   static int msr_init_perf(struct amd_cpudata *cpudata)
>> @@ -1115,28 +1060,6 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>   	kfree(cpudata);
>>   }
>>   
>> -static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
>> -{
>> -	int ret;
>> -
>> -	ret = amd_pstate_cppc_enable(true);
>> -	if (ret)
>> -		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
>> -
>> -	return ret;
>> -}
>> -
>> -static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>> -{
>> -	int ret;
>> -
>> -	ret = amd_pstate_cppc_enable(false);
>> -	if (ret)
>> -		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
>> -
>> -	return ret;
>> -}
>> -
>>   /* Sysfs attributes */
>>   
>>   /*
>> @@ -1228,8 +1151,10 @@ static ssize_t show_energy_performance_available_preferences(
>>   static ssize_t store_energy_performance_preference(
>>   		struct cpufreq_policy *policy, const char *buf, size_t count)
>>   {
>> +	struct amd_cpudata *cpudata = policy->driver_data;
>>   	char str_preference[21];
>>   	ssize_t ret;
>> +	u8 epp;
>>   
>>   	ret = sscanf(buf, "%20s", str_preference);
>>   	if (ret != 1)
>> @@ -1239,7 +1164,29 @@ static ssize_t store_energy_performance_preference(
>>   	if (ret < 0)
>>   		return -EINVAL;
>>   
>> -	ret = amd_pstate_set_energy_pref_index(policy, ret);
>> +	if (!ret)
>> +		epp = cpudata->epp_default;
>> +	else
>> +		epp = epp_values[ret];
>> +
>> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>> +		pr_debug("EPP cannot be set under performance policy\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (trace_amd_pstate_epp_perf_enabled()) {
>> +		union perf_cached perf = cpudata->perf;
>> +
>> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>> +					  epp,
>> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
>> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
>> +					  policy->boost_enabled,
>> +					  FIELD_GET(AMD_CPPC_EPP_PERF_MASK,
>> +						    cpudata->cppc_req_cached) != epp);
> 
> We are doing the tracing in amd_pstate_set_epp() as well right?, Isnt this one redundant?

Yup! Great catch.

> 
>> +	}
>> +
>> +	ret = amd_pstate_set_epp(policy, epp);
>>   
>>   	return ret ? ret : count;
>>   }
>> @@ -1272,7 +1219,6 @@ static ssize_t show_energy_performance_preference(
>>   
>>   static void amd_pstate_driver_cleanup(void)
>>   {
>> -	amd_pstate_cppc_enable(false);
>>   	cppc_state = AMD_PSTATE_DISABLE;
>>   	current_pstate_driver = NULL;
>>   }
>> @@ -1306,14 +1252,6 @@ static int amd_pstate_register_driver(int mode)
>>   
>>   	cppc_state = mode;
>>   
>> -	ret = amd_pstate_cppc_enable(true);
>> -	if (ret) {
>> -		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
>> -		       ret);
>> -		amd_pstate_driver_cleanup();
>> -		return ret;
>> -	}
>> -
>>   	/* at least one CPU supports CPB */
>>   	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
>>   
>> @@ -1553,11 +1491,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
>>   							      cpudata->nominal_freq,
>>   							      perf.highest_perf);
>> +	policy->driver_data = cpudata;
>> +
>> +	ret = amd_pstate_cppc_enable(policy);
> 
> I think we missed cppc_enable in "amd_pstate_cpu_init". Confirmed this by booting with "amd_pstate=passive"

Yeah; true.  I will add this.

> 
> Also, one weird behavior I saw while testing this part, if we boot with "amd_pstate=passive"
> initially, the MSR_AMD_CPPC_ENABLE register is 0. But after I run the amd-pstate-ut (which fails
> the check_amd_pstate_enabled() test the first time) the MSR_AMD_CPPC_ENABLE gets set to 1. But I
> didnt see any code in amd-pstate-ut that sets it. We can ignore this quirk for now, just
> mentioned to see if you have any idea about this.

amd-pstate-ut will change modes, so I expect this is the reason it 
happens.  It's also the reason I didn't catch it.  I always started in 
active when I was testing switching to passive.

> 
>> +	if (ret)
>> +		goto free_cpudata1;
>>   
>>   	/* It will be updated by governor */
>>   	policy->cur = policy->cpuinfo.min_freq;
>>   
>> -	policy->driver_data = cpudata;
>>   
>>   	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>>   
>> @@ -1649,31 +1591,21 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>   	return 0;
>>   }
>>   
>> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>> -{
>> -	int ret;
>> -
>> -	ret = amd_pstate_cppc_enable(true);
>> -	if (ret)
>> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>> -
>> -
>> -	return amd_pstate_epp_update_limit(policy);
>> -}
>> -
>>   static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	int ret;
>>   
>> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>> +	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
>>   
>> -	ret = amd_pstate_epp_reenable(policy);
>> +	ret = amd_pstate_cppc_enable(policy);
>>   	if (ret)
>>   		return ret;
>> +
>>   	cpudata->suspended = false;
> 
> Do we need this here?, shouldn't only resume() have this statement?

The reason I had in mind for it was this sequence:
* Suspend
* CPU goes offline
* CPU goes online
* Resume

But I don't think that's realistic even with parallel boot.  I will drop 
this.

> 
>>   
>>   	return 0;
>> +
>>   }
>>   
>>   static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>> @@ -1691,11 +1623,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>>   static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>> -	int ret;
>> -
>> -	/* avoid suspending when EPP is not enabled */
>> -	if (cppc_state != AMD_PSTATE_ACTIVE)
>> -		return 0;
>>   
>>   	/* invalidate to ensure it's rewritten during resume */
>>   	cpudata->cppc_req_cached = 0;
>> @@ -1703,11 +1630,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>>   	/* set this flag to avoid setting core offline*/
>>   	cpudata->suspended = true;
>>   
>> -	/* disable CPPC in lowlevel firmware */
>> -	ret = amd_pstate_cppc_enable(false);
>> -	if (ret)
>> -		pr_err("failed to suspend, return %d\n", ret);
>> -
>>   	return 0;
>>   }
>>   
>> @@ -1716,8 +1638,12 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   
>>   	if (cpudata->suspended) {
>> +		int ret;
>> +
>>   		/* enable amd pstate from suspend state*/
>> -		amd_pstate_epp_reenable(policy);
>> +		ret = amd_pstate_epp_update_limit(policy);
>> +		if (ret)
>> +			return ret;
>>   
>>   		cpudata->suspended = false;
>>   	}
>> @@ -1732,8 +1658,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>>   	.fast_switch    = amd_pstate_fast_switch,
>>   	.init		= amd_pstate_cpu_init,
>>   	.exit		= amd_pstate_cpu_exit,
>> -	.suspend	= amd_pstate_cpu_suspend,
>> -	.resume		= amd_pstate_cpu_resume,
>>   	.set_boost	= amd_pstate_set_boost,
>>   	.update_limits	= amd_pstate_update_limits,
>>   	.name		= "amd-pstate",
>> @@ -1748,8 +1672,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>>   	.exit		= amd_pstate_epp_cpu_exit,
>>   	.offline	= amd_pstate_epp_cpu_offline,
>>   	.online		= amd_pstate_epp_cpu_online,
>> -	.suspend	= amd_pstate_epp_suspend,
>> -	.resume		= amd_pstate_epp_resume,
>> +	.suspend        = amd_pstate_epp_suspend,
>> +	.resume         = amd_pstate_epp_resume,
> 
> Spurious whitespace change?
> 
>>   	.update_limits	= amd_pstate_update_limits,
>>   	.set_boost	= amd_pstate_set_boost,
>>   	.name		= "amd-pstate-epp",
>> @@ -1900,7 +1824,6 @@ static int __init amd_pstate_init(void)
>>   
>>   global_attr_free:
>>   	cpufreq_unregister_driver(current_pstate_driver);
>> -	amd_pstate_cppc_enable(false);
>>   	return ret;
>>   }
>>   device_initcall(amd_pstate_init);
> 


