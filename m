Return-Path: <linux-pm+bounces-24486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE5A6E7F9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 02:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A26816A6F7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6145979;
	Tue, 25 Mar 2025 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGE+m4Ng"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D65BA53;
	Tue, 25 Mar 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742866315; cv=none; b=ZLyXcaN7Jy+kg41L5gRGsLm53L+rGaoFt1pTRmJoc17udL2R6SwTjTVFWzC1/DnzQBv4nSLYr45+NdW80rDdklneTzboxJwL8OynDiG3daF9mJ2pJBUQpFA9L+shbdBe10JxsxxbmvZvumMdqkft3hxJzvl/JJiCTFLedfwckPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742866315; c=relaxed/simple;
	bh=m9o5uIA7KuvW5DNvB+jxx0/ZMRcYVE9NeLZeHBADx4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhKhyba3xLqnqhSODyXfSqX+Mdtx1RZUKftDoETuW/E7HwZSXgDpV+ZaKz0EyVTE7ReAjs25ELrNdKM3miWkwfZQVe1vPNqgC7sGLrbfARPTPPd1IRJ7YYMCMSPYKvZ8k0Fe5Qdl69m+Xkb29khY9qz+SMvCSLUjC9k0gJtNloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGE+m4Ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3BCC4CEDD;
	Tue, 25 Mar 2025 01:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742866314;
	bh=m9o5uIA7KuvW5DNvB+jxx0/ZMRcYVE9NeLZeHBADx4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eGE+m4NgZPGMDWStEwsLiyyEvTPRksiuvO8cI2s7h9i6xhGwEkbtwp1KrLu512EKm
	 dXNtymhU24dfYDw4da8e+7mgFgvKSadupLJ+pl0Z052Zzv/QkJPKU9mBF3SrI3I7GE
	 Wsx9Ze1fyB7KaxRKRxmnlXX3oKWtK1joWdk0Srnez+mVUVi7r6syYtfQwNTQJBh6Nm
	 GvVtjnNBZzegczV3EQgY2Pgb2Of8Vleb3/Ny2P2c27Mm0BfaQ4GwefmtJRUr6KVa9b
	 Bo5YGcx8ITSxVh+r6xYY2NfoAuKwsjnpAwLpenpjUK1AGit3CLIAvT6SSQL7/o/GoZ
	 uwtW/TytbAYJA==
Message-ID: <3dec3def-df4b-49ac-8102-01118b793798@kernel.org>
Date: Mon, 24 Mar 2025 20:31:51 -0500
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
 <186c3fa4-fe85-4989-9edd-fdb6345859a9@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <186c3fa4-fe85-4989-9edd-fdb6345859a9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/2025 03:19, Dhananjay Ugwekar wrote:
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
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index 412423c54f258..2e076650dc77c 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -289,7 +289,7 @@ and user can change current preference according to energy or performance needs
>>   Please get all support profiles list from
>>   ``energy_performance_available_preferences`` attribute, all the profiles are
>>   integer values defined between 0 to 255 when EPP feature is enabled by platform
>> -firmware, if EPP feature is disabled, driver will ignore the written value
>> +firmware, but if the dynamic EPP feature is enabled, driver will block writes.
>>   This attribute is read-write.
>>   
>>   ``boost``
>> @@ -311,6 +311,22 @@ boost or `1` to enable it, for the respective CPU using the sysfs path
>>   Other performance and frequency values can be read back from
>>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>>   
>> +Dynamic energy performance profile
>> +==================================
>> +The amd-pstate driver supports dynamically selecting the energy performance
>> +profile based on whether the machine is running on AC or DC power.
>> +
>> +Whether this behavior is enabled by default with the kernel config option
>> +`CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
>> +at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
> 
> The file is actually located at "/sys/devices/system/cpu/amd_pstate/dynamic_epp"
> 
>> +
>> +When set to enabled, the driver will select a different energy performance
>> +profile when the machine is running on battery or AC power.
>> +When set to disabled, the driver will not change the energy performance profile
>> +based on the power source and will not react to user desired power state.
>> +
>> +Attempting to manually write to the ``energy_performance_preference`` sysfs
>> +file will fail when ``dynamic_epp`` is enabled.
>>   
>>   ``amd-pstate`` vs ``acpi-cpufreq``
>>   ======================================
> [snip]
>> @@ -1502,9 +1611,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   			return ret;
>>   		WRITE_ONCE(cpudata->cppc_req_cached, value);
>>   	}
>> -	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>> +
>> +	if (dynamic_epp) {
>> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> 
> So, we are allowing the dynamic EPP framework to modify the EPP value in performance
> governor as well? Shouldn't we allow dynamic_epp only with powersave governor.

You're right; I was trying to avoid issues in 
amd_pstate_epp_set_policy() but I'll come up with a way to correct this.

> 
>> +		ret = amd_pstate_set_dynamic_epp(policy);
>> +	}
>> +	else
>> +		ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
>>   	if (ret)
>> -		return ret;
>> +		goto free_cpudata1;
>>   
>>   	current_pstate_driver->adjust_perf = NULL;
>>   
>> @@ -1521,6 +1636,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   
>>   	if (cpudata) {
>> +		if (cpudata->dynamic_epp)
>> +			amd_pstate_clear_dynamic_epp(policy);
>>   		kfree(cpudata);
>>   		policy->driver_data = NULL;
>>   	}
>> @@ -1556,6 +1673,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>   	if (!policy->cpuinfo.max_freq)
>>   		return -ENODEV;
>>   
>> +	/* policy can't be changed to powersave policy while dynamic epp is enabled */
>> +	if (policy->policy == CPUFREQ_POLICY_POWERSAVE && cpudata->dynamic_epp)
>> +		return -EBUSY;
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


