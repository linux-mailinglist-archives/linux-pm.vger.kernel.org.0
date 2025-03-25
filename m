Return-Path: <linux-pm+bounces-24487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06405A6E7FF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 02:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C023B4DEE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566C14386D;
	Tue, 25 Mar 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRWg8BfU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C145979;
	Tue, 25 Mar 2025 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742866459; cv=none; b=ni/yFDbG7NW/DgU2S4jMJ3+EYjPFp+109fAvp1s+pAHh3HgFPE9/DA68bfThpA9u4CYiLywOGo5NMkoxoxSE4/+63iRGMmuURLyXP7fVFSecpltEQmYwKchv3LjTuEKTcWD12LAbhusK2dlli0jeieKSXw8Sgiz6jNzp6P05G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742866459; c=relaxed/simple;
	bh=k6YTo4Zr5Qq8YQxTYAb1qPCJ6BxZ9R4fMywb4Roq9EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHnJCdl+8isDM0PQgv8GiMAyKjpB2BCEARBuKKHFqkW9/kmggPiYuCkuwT9VuI1upXF1ov4X9bWnKJL1/rBdvVgvHsMKwv6A7L/EVAA3tUi/+ySx8uILjwN9ZO9Ei0xJOPZz7mhA1fzorEqJNa6Vv1qe0Yypp0awT/VhrQTBB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRWg8BfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A418FC4CEDD;
	Tue, 25 Mar 2025 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742866458;
	bh=k6YTo4Zr5Qq8YQxTYAb1qPCJ6BxZ9R4fMywb4Roq9EY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HRWg8BfUdlcAzZlz488smp25PEXzJ6S6mqALPHJaDq8OqS8BUKoRxTsoA+m0NkeYU
	 XDj1+53wO5Hq6xgUf8hmoapDuw5HpGCyW/mnzguwG9fs0U69UE83du+hzcBTmhkiZ5
	 AXdz9bQAr6Xi46D30fSyhR5jqzwYBO0KOGR5b/rozhKNSDtHTUKcQmDg5sOq+/jfdf
	 44QELlfHbHTLwIVvLgJn/C5A3oHdCQhozRRYnQxcyRK6XvNWfrnpdjWcy2Cxxlv8ve
	 E6EMa2lf16WlriWZzkrwhBcvgCgLPa+MPGf/DL6QqKcgXJvzNrbuiVsmsm63tRmH0k
	 AQLO+qXLwS3nQ==
Message-ID: <784b2e21-10fb-44d8-b874-b6bc2ee238c6@kernel.org>
Date: Mon, 24 Mar 2025 20:34:16 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-2-superm1@kernel.org>
 <4d224956-b4f9-4b0c-b5fb-70abe82e6ab5@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <4d224956-b4f9-4b0c-b5fb-70abe82e6ab5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/2025 04:58, Dhananjay Ugwekar wrote:
> On 3/21/2025 7:58 AM, Mario Limonciello wrote:
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
>> v3->v4:
>>   * Handle Kconfig not being set
>>   * Fix dynamic epp default on server
>> v2-v3:
>>   * Fix typo in Kconfig
>> v1->v2:
>>   * Change defaults to performance (AC) and balance_performance (DC)
>>   * Default Kconfig to disabled for now
>>   * Rebase on latest branch
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>   drivers/cpufreq/Kconfig.x86                 |  12 ++
>>   drivers/cpufreq/amd-pstate.c                | 135 +++++++++++++++++++-
>>   drivers/cpufreq/amd-pstate.h                |   5 +-
>>   4 files changed, 161 insertions(+), 9 deletions(-)
>>
> [snip]
>> @@ -1050,6 +1056,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>   	kfree(cpudata);
>>   }
>>   
>> +static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
>> +{
>> +	struct amd_cpudata *cpudata = policy->driver_data;
>> +
>> +	if (power_supply_is_system_supplied())
>> +		return cpudata->epp_default_ac;
>> +	else
>> +		return cpudata->epp_default_dc;
>> +}
>> +
>> +static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>> +					    unsigned long event, void *data)
>> +{
>> +	struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
>> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> 
> For consistency, we should add "if (!policy)" check I think
> 
>> +	u8 epp;
>> +	int ret;
>> +
>> +	if (event != PSY_EVENT_PROP_CHANGED)
>> +		return NOTIFY_OK;
>> +
>> +	epp = amd_pstate_get_balanced_epp(policy);
>> +
>> +	ret = amd_pstate_set_epp(policy, epp);
>> +	if (ret)
>> +		pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
>> +
>> +	return NOTIFY_OK;
>> +}
> [snip]
>> @@ -1364,6 +1444,32 @@ static ssize_t prefcore_show(struct device *dev,
>>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>>   }
>>   
>> +static ssize_t dynamic_epp_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
>> +}
>> +
>> +static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
>> +				 const char *buf, size_t count)
>> +{
>> +	bool enabled;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &enabled);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (dynamic_epp == enabled)
>> +		return -EINVAL;
>> +
>> +	/* reinitialize with desired dynamic EPP value */
>> +	dynamic_epp = enabled;
>> +	ret = amd_pstate_change_driver_mode(cppc_state);
> 
> I think implicitly changing the driver mode when we write to dynamic_epp file might lead to some confusions.

How about only allowing to write dynamic_epp attribute when in active 
mode already?

> 
>> +
>> +	return ret ? ret : count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);


