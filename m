Return-Path: <linux-pm+bounces-24732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA571A79626
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95703A50E5
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D71EEA42;
	Wed,  2 Apr 2025 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8VLjEnw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4386A2AF14;
	Wed,  2 Apr 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623840; cv=none; b=ecMmrHnNr5N7v8A6QjwlBv3Bj6z7xmKfTrWj47TnC1+mooF7hMEtDMb/+T5bBQv4FyF4l7dG+bmlkrkVjtsrz8oCz0TTABd1/2fXFS++Xwjs/9XdS5skG+qk3hn/MLPb6EHRHfSxO3rAwAInmIHWeiZHX6jWmpGD7fU5AlNBPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623840; c=relaxed/simple;
	bh=itiUqbRyWCcAqB/OnCayoEuY0XPsKzVujyc14WRDtCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns9EkqAnyptamqmHudrvQW/04otHRaz6ssZX1yS2xALQrDYaehL0fZWBUYz2r/Y00baDkx+Zw2kJDhvYhkoGet5Pk1LoUqUIN7wB1+LIdyhhb2BRfVNLdWeEy6yjOhrHI8jAFsG4U9qjRJmfUW0mV9x7K51ZcMj6dbMcTh/tMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8VLjEnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236DCC4CEDD;
	Wed,  2 Apr 2025 19:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743623839;
	bh=itiUqbRyWCcAqB/OnCayoEuY0XPsKzVujyc14WRDtCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K8VLjEnwftFWTAHCuMGzWuovnB4vJxe3UjPp/W0qkkm4eoIMG87dM8yQ+qCuanGz/
	 JPaqs/0kHfy11K0zVShA7cW5up7W/8WkuDqarU+kHJ2kJsoCiuz4g67aPXnwwpOQeO
	 aPf7CB4z6lRDMVBUtaUmmSR4rwA/klecI3rViPDn2hLyUrW7Rhv4aKNsH7LQNOkOUg
	 sldtow17O6dYCBzcaNe1uNP/poAxtnh5RHEB5QEmq456nGTN/56o+ZPosLX3HqY3cz
	 pTYf91o1IYqfbAftCN5UcqZAiHFGyga97T/qnPIQj9VCG6dyptpRI5S/M8Ji9niUKd
	 Ma+ngw7MSVg6A==
Message-ID: <45eeecc0-cc97-4d87-b650-f45c3aa99a67@kernel.org>
Date: Wed, 2 Apr 2025 14:57:18 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Prefix setup messages with FW_BUG
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250320214132.664522-1-superm1@kernel.org>
 <e75a4f57-37ac-4c43-8385-8b476d3b94db@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <e75a4f57-37ac-4c43-8385-8b476d3b94db@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/2025 2:20 AM, Dhananjay Ugwekar wrote:
> On 3/21/2025 3:11 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> To make it clearer that amd-pstate failing to setup is a problem
>> with the firmware, prefix several messages with FW_BUG.
>>
>> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 024d33d5e3670..0a9d6fe426d1c 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -931,13 +931,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   	 * Check _CPC in ACPI table objects if any values are incorrect
>>   	 */
>>   	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
>> -		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
>> +		pr_err(FW_BUG "min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
>>   			min_freq, max_freq, nominal_freq);
>>   		return -EINVAL;
>>   	}
>>   
>>   	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
>> -		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>> +		pr_err(FW_BUG "lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>>   			lowest_nonlinear_freq, min_freq, nominal_freq);
>>   		return -EINVAL;
>>   	}
>> @@ -1505,7 +1505,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	return 0;
>>   
>>   free_cpudata1:
>> -	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>> +	pr_warn(FW_BUG "Failed to initialize CPU %d: %d\n", policy->cpu, ret);
> 
> Just thinking are we sure that we land here only through a firmware bug?
> 
> If not, we should probably use FW_WARN ?,
> or
> Should we add to the error message the specific firmware issue that might cause
> each of the functions to fail (e.g. amd_pstate_init_perf(), amd_pstate_init_freq(),
> etc).

I looked at the call paths and I'm not convinced that they will all be 
firmware bugs.  In any case I want to know whenever there is a failure 
here so we can evaluate if it's a firmware bug or a software bug.

If it's a software bug we'll obviously work on it, and if it's a 
firmware bug do our best to notify the firmware developer.

So I will abandon this patch, thanks for the great feedback.

> 
> Comments for the macros, for reference,
> 
>   * FW_BUG
>   * Add this to a message where you are sure the firmware is buggy or behaves
>   * really stupid or out of spec. Be aware that the responsible BIOS developer
>   * should be able to fix this issue or at least get a concrete idea of the
>   * problem by reading your message without the need of looking at the kernel
>   * code.
>   *
>   * Use it for definite and high priority BIOS bugs.
>   *
>   * FW_WARN
>   * Use it for not that clear (e.g. could the kernel messed up things already?)
>   * and medium priority BIOS bugs.
> 
>>   	kfree(cpudata);
>>   	return ret;
>>   }
> 


