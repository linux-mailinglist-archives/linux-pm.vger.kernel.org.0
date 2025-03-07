Return-Path: <linux-pm+bounces-23643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B540A56E66
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86BA07A1ECD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79023A58F;
	Fri,  7 Mar 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWNkQ+qK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EC21859D;
	Fri,  7 Mar 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366524; cv=none; b=XVIKmFgjAS12Cbx4b5V+epx+FkJBiZwL9ODm922UUgVRtM3SmE3llr5AYcI1J7CqzIS3zVQLAxM9oZdnODtMYt/dhp1H8mGb+3eNvlg0SttYRxTzHfEuTOc+8jqfteICmNZPBTOTE/hd+dnNOQ59ChuBlEZ1XWgWt3gnCgjs9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366524; c=relaxed/simple;
	bh=prwkqekrCMpSZcoR8i0PEp3Wo+pTRG6L2v9vSdds6fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn98hsGh7bnS1a2667BoHM3irgZQiprq7XLkvLN2fcGpSASWmQmqz1EsJq7E6bfkfeTbkxHmI8KyYyqfPx5fTKLDh1Xe7hdq5B+oSQEyifQTqAGpnsyWynEjULeGBOg2Twkizu84QHy/IWkdsaombeJ0ix80B9mxc/bLUbGk5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWNkQ+qK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AEEC4CED1;
	Fri,  7 Mar 2025 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366524;
	bh=prwkqekrCMpSZcoR8i0PEp3Wo+pTRG6L2v9vSdds6fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWNkQ+qKmE5wBpLYFiBY5zUbwjjDltlTZG1Keiqt+Ty7OURixd547OqBeX9BY3m7Q
	 A++vvHt7Pj7uHP58bhfU142/g3ZYyywqApgZcC34Y+0M+S3NoCoFXi4enqTYEi4dU2
	 eqEUmr79uaPqkzXJPsc2mxtrNpo8VDD3euT8U44EwxaCEruMjYhCYHj0bJFxEzRVWs
	 R7XwZ0FnNlPIwTZQjjgF/Q5E0AwaQtU/cnPSdcogHfNUrSGyAqSYTeORt/rmdx6iBe
	 UF3xl0a+2tHbUvnKT2XmApNLjE35a6zN+28EKrDGPsHvaop075VoZy/cOvCjj07x4S
	 ZST4Q9TvXKidA==
Message-ID: <969ca809-c630-46e3-9bc2-6cf340bc66e3@kernel.org>
Date: Fri, 7 Mar 2025 10:55:21 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-4-superm1@kernel.org>
 <Z8sdREywSKVb4xx7@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z8sdREywSKVb4xx7@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/2025 10:22, Gautham R. Shenoy wrote:
> On Tue, Mar 04, 2025 at 09:23:25AM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The platform profile core allows multiple drivers and devices to
>> register platform profile support.
>>
>> When the legacy platform profile interface is used all drivers will
>> adjust the platform profile as well.
>>
>> Add support for registering every CPU with the platform profile handler
>> when dynamic EPP is enabled.
>>
>> The end result will be that changing the platform profile will modify
>> EPP accordingly.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>>   drivers/cpufreq/Kconfig.x86                 |   1 +
>>   drivers/cpufreq/amd-pstate.c                | 142 +++++++++++++++++---
>>   drivers/cpufreq/amd-pstate.h                |  10 ++
>>   4 files changed, 140 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index 8424e7119dd7e..36950fb6568c0 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -321,7 +321,9 @@ Whether this behavior is enabled by default with the kernel config option
>>   at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
>>   
>>   When set to enabled, the driver will select a different energy performance
>> -profile when the machine is running on battery or AC power.
>> +profile when the machine is running on battery or AC power. The driver will
>> +also register with the platform profile handler to receive notifications of
>> +user desired power state and react to those.
>>   When set to disabled, the driver will not change the energy performance profile
>>   based on the power source and will not react to user desired power state.
>>   
>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>> index c5ef92634ddf4..905eab998b836 100644
>> --- a/drivers/cpufreq/Kconfig.x86
>> +++ b/drivers/cpufreq/Kconfig.x86
>> @@ -40,6 +40,7 @@ config X86_AMD_PSTATE
>>   	select ACPI_PROCESSOR
>>   	select ACPI_CPPC_LIB if X86_64
>>   	select CPU_FREQ_GOV_SCHEDUTIL if SMP
>> +	select ACPI_PLATFORM_PROFILE
>>   	help
>>   	  This driver adds a CPUFreq driver which utilizes a fine grain
>>   	  processor performance frequency control range instead of legacy
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 9911808fe0bcf..28c02edf6e40b 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -105,6 +105,7 @@ static struct quirk_entry *quirks;
>>    *	2		balance_performance
>>    *	3		balance_power
>>    *	4		power
>> + *	5		custom (for raw EPP values)
>>    */
>>   enum energy_perf_value_index {
>>   	EPP_INDEX_DEFAULT = 0,
>> @@ -112,6 +113,7 @@ enum energy_perf_value_index {
>>   	EPP_INDEX_BALANCE_PERFORMANCE,
>>   	EPP_INDEX_BALANCE_POWERSAVE,
>>   	EPP_INDEX_POWERSAVE,
>> +	EPP_INDEX_CUSTOM,
>>   };
>>   
>>   static const char * const energy_perf_strings[] = {
>> @@ -120,6 +122,7 @@ static const char * const energy_perf_strings[] = {
>>   	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>>   	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>>   	[EPP_INDEX_POWERSAVE] = "power",
>> +	[EPP_INDEX_CUSTOM] = "custom",
>>   	NULL
>>   };
>>   
>> @@ -1073,6 +1076,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>>   	if (event != PSY_EVENT_PROP_CHANGED)
>>   		return NOTIFY_OK;
>>   
>> +	/* dynamic actions are only applied while platform profile is in balanced */
>> +	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
>> +		return 0;
>> +
>>   	epp = amd_pstate_get_balanced_epp(policy);
>>   
>>   	ret = amd_pstate_set_epp(policy, epp);
>> @@ -1081,14 +1088,84 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>>   
>>   	return NOTIFY_OK;
>>   }
>> -static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>> +
>> +static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
>> +{
>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>> +
>> +	return 0;
>> +}
>> +
>> +static int amd_pstate_profile_get(struct device *dev,
>> +				  enum platform_profile_option *profile)
>> +{
>> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
>> +
>> +	*profile = cpudata->current_profile;
>> +
>> +	return 0;
>> +}
>> +
>> +static int amd_pstate_profile_set(struct device *dev,
>> +				  enum platform_profile_option profile)
>> +{
>> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
>> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
>> +	int ret;
>> +
>> +	switch (profile) {
>> +	case PLATFORM_PROFILE_LOW_POWER:
>> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
>> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> 
> So prior to the patch, cpudata->policy is supposed to mirror
> policy->policy.  With this patch, this assumption is no longer
> true. So it is possible for the user to again override the choice of
> EPP set via platform profile by changing the cpufreq governor ?
> 
> Is this the expected behaviour?
> 
> The bigger concern is, if the governor was previously "performance"
> and then the platform profile requested "low power", "cat
> /sys/devices/system/cpu/cpuX/cpufreq/scaling_governor" would still
> show "performance", which is inconsistent with the behaviour.
> 
> 

This ties back to the previous patches for dynamic EPP.  My expectation 
was that when dynamic EPP is enabled that users can't manually set the 
EPP anymore (it will return -EBUSY) and likewise turning on dynamic EPP
should keep the governor as powersave.

I'll double check all those are properly enforced; but that's at least 
the intent.

IMO this "should" all work because turning on Dynamic EPP sysfs file 
forces the driver to go through a state transition that it will tear 
everything down and back up.  The policy will come back up in 
"powersave" even if it was previously in "performance" when the dynamic 
EPP sysfs file was turned on.

Longer term; I also envision the scheduler influencing EPP values when 
dynamic_epp is turned on.  The "platform profile" would be an "input" to 
that decision making process (maybe giving a weighting?), not the only 
lever.

I haven't given any serious look at how to do this with the scheduler, I 
wanted to lay the foundation first being dynamic EPP and raw EPP.

So even if dynamic_epp isn't interesting "right now" for server because 
the focus is around behavior for AC/DC, don't write it off just yet.

