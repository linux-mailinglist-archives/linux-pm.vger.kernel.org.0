Return-Path: <linux-pm+bounces-21856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E720EA314D3
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 20:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F3C167C31
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE21E4929;
	Tue, 11 Feb 2025 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjICzJks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6126156C;
	Tue, 11 Feb 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301445; cv=none; b=hnEh6S77Uvv0sfgpSLJPi1FdKhVC+33jUJaOkpmPQZIzJz/bnBkYpWhdudDNOCcj64cDgB+M/OFtAAHHkHA1gKcWLWfkjN7bdGZ37OdYiuISdkx7KyZlsI9r8G8/BGrHVcBM3CsAobYPTfF5W3ipGr8Nnbv7QZ9L/CKn//lCAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301445; c=relaxed/simple;
	bh=12w062tpfDRKW1JwdoBmtHTuoGJx2tIAPRufd2zsBPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvOuOmrkZF2dsOoiI8rkUKpGpTc1UrBtNYVEYbsZxFLfDQknvYVMrsJ77r6UWfHR7rUWwav+is1QfRhMhVGBjhuYINK/AI5T+DDgGMLTqd30/G8gZ3pAYZ6xRTkxWzyr3U7EuVWD44LHZrr9hXYA5TcD5qeNh9vVdhp0cXiitWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjICzJks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F020BC4CEDD;
	Tue, 11 Feb 2025 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301444;
	bh=12w062tpfDRKW1JwdoBmtHTuoGJx2tIAPRufd2zsBPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rjICzJks/D9d/j5EPSm2GKAZfp24kPfkvvynB8AD0TbYETvk5zWjG0tC96cL2uu72
	 6+Br2JVNsj34pH4NY3AEbYt3fI1Fb2BwXnDlYeMTanv4jvuROpRDplA6bLbWGXvBNl
	 HEP8W3X+U6J4tQqp5IdqeUdyBr+2ay4LcwaMbZzYm/TQz6sIcxeM8uJbfOjR1dGIpY
	 E+6QEgZ+ko+/JaE/DW0icGR0y2NaFj3Es0ohamkMQDnTzAxUviwmv1JVsjhFT422Ay
	 rPn7MjWPQdIKsCkvu78c1Dzsf7Uxj9/5FusRs7w9j8gn6zW/LJWDiMh8tNIKEp++9o
	 U6dFLmmaTHL6A==
Message-ID: <2877ad66-0148-483e-83b3-fab5da5dbe1f@kernel.org>
Date: Tue, 11 Feb 2025 13:17:23 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] cpufreq/amd-pstate: Cache a pointer to policy in
 cpudata
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-13-superm1@kernel.org>
 <a3d10f58-3d69-40e8-b0ea-53f4ed9ce31a@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <a3d10f58-3d69-40e8-b0ea-53f4ed9ce31a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/2025 07:13, Dhananjay Ugwekar wrote:
> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> In order to access the policy from a notification block it will
>> need to be stored in cpudata.
> 
> This might break the cpufreq_policy ref counting right?, if we cache the pointer
> and use it independent of the ref counting framework.

Would it be reasonable to bump the ref count when we take the pointer?

I'm not sure if this will work properly.

> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 13 +++++++------
>>   drivers/cpufreq/amd-pstate.h |  3 ++-
>>   2 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 689de385d06da..5945b6c7f7e56 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -388,7 +388,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>>   	else
>>   		epp = epp_values[pref_index];
>>   
>> -	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
>> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>>   		pr_debug("EPP cannot be set under performance policy\n");
>>   		return -EBUSY;
>>   	}
>> @@ -689,7 +689,7 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>   	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
>>   	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>>   
>> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>>   		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>>   
>>   	WRITE_ONCE(cpudata->perf, perf);
>> @@ -1042,6 +1042,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   		return -ENOMEM;
>>   
>>   	cpudata->cpu = policy->cpu;
>> +	cpudata->policy = policy;
>>   
>>   	mutex_init(&cpudata->lock);
>>   	guard(mutex)(&cpudata->lock);
>> @@ -1224,9 +1225,8 @@ static ssize_t show_energy_performance_available_preferences(
>>   {
>>   	int i = 0;
>>   	int offset = 0;
>> -	struct amd_cpudata *cpudata = policy->driver_data;
>>   
>> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>>   		return sysfs_emit_at(buf, offset, "%s\n",
>>   				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
>>   
>> @@ -1543,6 +1543,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   		return -ENOMEM;
>>   
>>   	cpudata->cpu = policy->cpu;
>> +	cpudata->policy = policy;
>>   
>>   	mutex_init(&cpudata->lock);
>>   	guard(mutex)(&cpudata->lock);
>> @@ -1632,7 +1633,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>   
>>   	amd_pstate_update_min_max_limit(policy);
>>   
>> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>>   		epp = 0;
>>   	else
>>   		epp = READ_ONCE(cpudata->epp_cached);
>> @@ -1651,7 +1652,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>   	if (!policy->cpuinfo.max_freq)
>>   		return -ENODEV;
>>   
>> -	cpudata->policy = policy->policy;
>> +	cpudata->policy = policy;
>>   
>>   	ret = amd_pstate_epp_update_limit(policy);
>>   	if (ret)
>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index 7501d30db9953..16ce631a6c3d5 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -97,9 +97,10 @@ struct amd_cpudata {
>>   
>>   	struct mutex	lock;
>>   
>> +	struct cpufreq_policy *policy;
>> +
>>   	/* EPP feature related attributes*/
>>   	u8	epp_cached;
>> -	u32	policy;
>>   	bool	suspended;
>>   	u8	epp_default;
>>   };
> 


