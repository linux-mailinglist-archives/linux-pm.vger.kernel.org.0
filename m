Return-Path: <linux-pm+bounces-21852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E248A3141F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 19:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B8F3A25D2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FAC3BB54;
	Tue, 11 Feb 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNOORro/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8926157C;
	Tue, 11 Feb 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298684; cv=none; b=JHEtFq5iV5YkTMD0LFc27b4RQVw9xoOJ80ETrjNdfoAW3Z9WiMUkIdpBsJwYU+rdjdK4zkrvhRtE5Hg+oYXL9+x/UM4yzwxfQEOIISDZb4GFiMvcW8v3zaW1SE4oT9DbKgywYp7nG89Qq7XD25yCs7ErA4mEheq/URN9fiB96fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298684; c=relaxed/simple;
	bh=rD/6ktXyt86w3S/pl+ysMOKcYMTF2SZexD7GbnORnr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8HMRQM3R9c2BZ/SnxJ8xDtgRmE+3jEpWMdDSiVN5i4ZWrzclVOnCpi7V+HD7TwPmXZ9Mf6l5k8W4yio4LnlqH5/23AA5DhMsFoxuEfeRGT88a9iW4F3GxF61rdB5/bW0LHGNmf9g4a1firNB4kV7ncz6ZmAvCqqmfIpVLx+jc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNOORro/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1526C4CEDD;
	Tue, 11 Feb 2025 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739298684;
	bh=rD/6ktXyt86w3S/pl+ysMOKcYMTF2SZexD7GbnORnr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TNOORro/eeGCdc06fo/nAT95eUdT3sfBRtBaBzo0BhfFuj2zKd33/KGIgE3sO7mCq
	 e335jMfCKyI07mJqKBftYC09AHYbckSOsfx27t8fBLB19HHSQHS4Oqej7JujpyPyQ5
	 xB5rBbY0wjcExKCJBNWCMR9tDmr31/uhGEqtkByk0QugIRD8iJB9rgNJ8L4ytSsYSu
	 J5zxbYT84Ey2Wtec+zh1h79ERxqrYr5bqZaP8IuIBgS2hkJHE+/eDcKq7ExEjTuLOp
	 5FLJIlPNShlyj74t2q8sHFccNVQJUYPhXg31y8pjTHZa4xOTyWc+rM4lzI8WoAXrLr
	 XCOclrrSvllBA==
Message-ID: <f43e7708-ebac-48dd-945c-647f8908bc7c@kernel.org>
Date: Tue, 11 Feb 2025 12:31:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros
 with masks
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-8-superm1@kernel.org>
 <21250cdb-e398-448c-be08-e9b3778b3771@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <21250cdb-e398-448c-be08-e9b3778b3771@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/2025 00:16, Dhananjay Ugwekar wrote:
> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Bitfield masks are easier to follow and less error prone.
> 
> Looks good to me, just one suggestion below, apart from that,
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/include/asm/msr-index.h | 18 +++++++++---------
>>   arch/x86/kernel/acpi/cppc.c      |  2 +-
>>   drivers/cpufreq/amd-pstate-ut.c  |  8 ++++----
>>   drivers/cpufreq/amd-pstate.c     | 16 ++++++----------
>>   4 files changed, 20 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 3eadc4d5de837..f77335ebae981 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -700,15 +700,15 @@
>>   #define MSR_AMD_CPPC_REQ		0xc00102b3
>>   #define MSR_AMD_CPPC_STATUS		0xc00102b4
>>   
>> -#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
>> -#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
>> -#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
>> -#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
>> -
>> -#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
>> -#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
>> -#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
>> -#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
>> +#define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
> 
> How about  AMD_CPPC_"CAP"_LOWEST_PERF_MASK and
> 
>> +#define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
>> +#define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
>> +#define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
>> +
>> +#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
> 
> 	   AMD_CPPC_"REQ"_MAX_PERF_MASK, just to indicate these fields
> belong to which register? But we can keep it as is, if you think it
> would be a mouthful, I'll leave it upto you.

I'll split the difference and include a comment around them to indicate 
what they're for.

> 
> Thanks,
> Dhananjay
> 
>> +#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
>> +#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
>> +#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
>>   
>>   /* AMD Performance Counter Global Status and Control MSRs */
>>   #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
>> index d745dd586303c..d68a4cb0168fa 100644
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -149,7 +149,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>>   		if (ret)
>>   			goto out;
>>   
>> -		val = AMD_CPPC_HIGHEST_PERF(val);
>> +		val = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, val);
>>   	} else {
>>   		ret = cppc_get_highest_perf(cpu, &val);
>>   		if (ret)
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index adaa62fb2b04e..2595faa492bf1 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -158,10 +158,10 @@ static void amd_pstate_ut_check_perf(u32 index)
>>   				return;
>>   			}
>>   
>> -			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>> -			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
>> -			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
>> -			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>> +			highest_perf = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1);
>> +			nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
>> +			lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
>> +			lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>>   		}
>>   
>>   		if (highest_perf != READ_ONCE(cpudata->perf.highest_perf) &&
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 71636bd9884c8..cd96443fc117f 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -89,11 +89,6 @@ static bool cppc_enabled;
>>   static bool amd_pstate_prefcore = true;
>>   static struct quirk_entry *quirks;
>>   
>> -#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
>> -#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
>> -#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
>> -#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
>> -
>>   /*
>>    * AMD Energy Preference Performance (EPP)
>>    * The EPP is used in the CCLK DPM controller to drive
>> @@ -445,12 +440,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>>   
>>   	perf.highest_perf = numerator;
>>   	perf.max_limit_perf = numerator;
>> -	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
>> -	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
>> -	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
>> -	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>> +	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>> +	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
>> +	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
>> +	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>>   	WRITE_ONCE(cpudata->perf, perf);
>> -	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
>> +	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
>> +
>>   	return 0;
>>   }
>>   
> 


