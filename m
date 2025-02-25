Return-Path: <linux-pm+bounces-22856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE5A43323
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C368189FA33
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A714830F;
	Tue, 25 Feb 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGTp0Qbm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637713C9B8;
	Tue, 25 Feb 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450917; cv=none; b=Oq//3Vu9Wt7802uknZFWZswvMOoRAC1pOvryy8k35GxsVypp2Nkwbxdm8dBUdLY4mfIuUCF3GQkt21dL7oih3Yo/0MSqMnwBIX+c5v2/rLlWBBzQ5tPkTmyzBOXDTKFIVdhMx2fMWBFbsJEAG/OOX5tMxNtFigUYCDS2wF95Zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450917; c=relaxed/simple;
	bh=x1K6c8DwZ/iqkKf52ZklxqWa27mXEskdG4g9qoiRsUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1r9pCYdFZeeGsrpnaLSKAvYm++DDwk8hAplUSmXDkm+irYK01sJc75iT8B9eBf+1npJnN1EVM6PWK7SlFagadknSVC9pfdMnMq4+nlclia7XX4jlgGYCNSTKnyP0/UMcBgt8pAJDgKucuB7DIGeMzgPvW1UzWbGq0LOKgdLPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGTp0Qbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50903C4CEE9;
	Tue, 25 Feb 2025 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450917;
	bh=x1K6c8DwZ/iqkKf52ZklxqWa27mXEskdG4g9qoiRsUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lGTp0Qbmbib+R32XgVIRpvyyuSKp14khrzIVOEBdpnfAegOkZkrMuKvxTvxx5ewtQ
	 8+gfUDYL6CLRPMaeax4rfRi7KCCXjGXV1UBVVVyANhXs/rxRg4czH06OXVzrYFvTwr
	 EaXMVioAU82383GTffdmiz2nAk/r5Stmv/BOiWpVUY2FWvE2h67QavBKhLrLQ4e1S2
	 0BqhzosRZXq53rDdTXE5JyAQ71YWH0sJvB9QLgBEnqdMeLfrorMR1o0GyjVUbeNwM9
	 TEk2358txwdcRaSKYIap29fwHWzwhQ5RlSEQmcDFJYj83bQ7w6VTZ4PAP0p1XtuNaJ
	 MT8KQfcFZhTew==
Message-ID: <5a5b00ae-f5e7-4642-8ba2-e5f2f472a794@kernel.org>
Date: Mon, 24 Feb 2025 18:05:10 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL
 enums
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-10-superm1@kernel.org>
 <086f6284-46b8-4cb1-8b19-009ee0e10af3@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <086f6284-46b8-4cb1-8b19-009ee0e10af3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/2025 00:05, Dhananjay Ugwekar wrote:
> On 2/20/2025 2:32 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Enums are effectively used as a boolean and don't show
>> the return value of the failing call.
>>
>> Instead of using enums switch to returning the actual return
>> code from the unit test.
>>
> 
> One query below, apart from that LGTM,
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks!

> 
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c | 143 ++++++++++++--------------------
>>   1 file changed, 55 insertions(+), 88 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index 0f0b867e271cc..028527a0019ca 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -32,30 +32,20 @@
>>   
>>   #include "amd-pstate.h"
>>   
>> -/*
>> - * Abbreviations:
>> - * amd_pstate_ut: used as a shortform for AMD P-State unit test.
>> - * It helps to keep variable names smaller, simpler
>> - */
>> -enum amd_pstate_ut_result {
>> -	AMD_PSTATE_UT_RESULT_PASS,
>> -	AMD_PSTATE_UT_RESULT_FAIL,
>> -};
>>   
>>   struct amd_pstate_ut_struct {
>>   	const char *name;
>> -	void (*func)(u32 index);
>> -	enum amd_pstate_ut_result result;
>> +	int (*func)(u32 index);
>>   };
>>   
>>   /*
>>    * Kernel module for testing the AMD P-State unit test
>>    */
>> -static void amd_pstate_ut_acpi_cpc_valid(u32 index);
>> -static void amd_pstate_ut_check_enabled(u32 index);
>> -static void amd_pstate_ut_check_perf(u32 index);
>> -static void amd_pstate_ut_check_freq(u32 index);
>> -static void amd_pstate_ut_check_driver(u32 index);
>> +static int amd_pstate_ut_acpi_cpc_valid(u32 index);
>> +static int amd_pstate_ut_check_enabled(u32 index);
>> +static int amd_pstate_ut_check_perf(u32 index);
>> +static int amd_pstate_ut_check_freq(u32 index);
>> +static int amd_pstate_ut_check_driver(u32 index);
>>   
>>   static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>>   	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
>> @@ -78,51 +68,46 @@ static bool get_shared_mem(void)
>>   /*
>>    * check the _CPC object is present in SBIOS.
>>    */
>> -static void amd_pstate_ut_acpi_cpc_valid(u32 index)
>> +static int amd_pstate_ut_acpi_cpc_valid(u32 index)
>>   {
>> -	if (acpi_cpc_valid())
>> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>> -	else {
>> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>> +	if (!acpi_cpc_valid()) {
>>   		pr_err("%s the _CPC object is not present in SBIOS!\n", __func__);
>> +		return -EINVAL;
>>   	}
>> +
>> +	return 0;
>>   }
>>   
>> -static void amd_pstate_ut_pstate_enable(u32 index)
>> +/*
>> + * check if amd pstate is enabled
>> + */
>> +static int amd_pstate_ut_check_enabled(u32 index)
>>   {
>> -	int ret = 0;
>>   	u64 cppc_enable = 0;
>> +	int ret;
>> +
>> +	if (get_shared_mem())
>> +		return 0;
> 
> What do you think about adding a "cppc_get_enable()" function in acpi_cppc.c so that we can
> run this check for shared mem systems as well ?
> 

I think it's a good idea.  Would you mind working that out for after 
this series lands?

> Thanks,
> Dhananjay
> 
>>   
>>   	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
>>   	if (ret) {
>> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>   		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
>> -		return;
>> +		return ret;
>>   	}
>> -	if (cppc_enable)
>> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>> -	else {
>> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>> +
>> +	if (!cppc_enable) {
>>   		pr_err("%s amd pstate must be enabled!\n", __func__);
>> +		return -EINVAL;
>>   	}
>> -}
>>   
>> -/*
>> - * check if amd pstate is enabled
>> - */
>> -static void amd_pstate_ut_check_enabled(u32 index)
>> -{
>> -	if (get_shared_mem())
>> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>> -	else
>> -		amd_pstate_ut_pstate_enable(index);
>> +	return 0;
>>   }
>>   
>>   /*
>>    * check if performance values are reasonable.
>>    * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
>>    */
>> -static void amd_pstate_ut_check_perf(u32 index)
>> +static int amd_pstate_ut_check_perf(u32 index)
>>   {
>>   	int cpu = 0, ret = 0;
>>   	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
> [Snip]


