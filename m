Return-Path: <linux-pm+bounces-22261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5ADA38DD4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3A7A23CB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325DC23875A;
	Mon, 17 Feb 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSdMCVRW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02222226545;
	Mon, 17 Feb 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826419; cv=none; b=hizw+G6X1a8Zq7JzDzmVGys0Puqja6cht9A0tCRnpp1EOFg6KUTifcXIZG3kysZ7p2sxsSplX1auCpD154YkIUAxk2T/ZK3enC3/dAMy59XBolxO1eM6oIgf0+fqC6Ao7ez0n/LKMfX8hhN3nkMkN6f6WKW+xYsUNzyYDbYHR64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826419; c=relaxed/simple;
	bh=XBiZ9M6VH2FsYZ+jANHvMHi9akZFIZce1Nh6SBYvdYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiTzsMVpnm6ydfUQ6sGN6OKgdWFLKekiW0aL5pl3oT4mWmdYJ3BmiPu0y+gTLMMDvqeFc9nj0lyoqwa+zyS7BXh1XQTI9eG7u26HhhYkeshWOjGDgtUgqAZR22v0YdDnZwcwAdGA/nJMM+HAO1HGf67mieHB8vY5GROtMW47e9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSdMCVRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A28C4CED1;
	Mon, 17 Feb 2025 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739826418;
	bh=XBiZ9M6VH2FsYZ+jANHvMHi9akZFIZce1Nh6SBYvdYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LSdMCVRW/1ceh83iJtXPcXh6CajmXy5DEIHnWeAadVc3KlpvKanX94pfsiffM56uC
	 ZoxrnZQ+eU4dWCDzv1jm1nJD19eBvcVSZx9h9YtwV1ZEteIUNKtrZf9qDZGI5xpDel
	 Vf/DagYv9SSXZPSVAsrFWqLvbYsqnv3Mc34qfeJH5ta2VmrnrWHPeavDyaQKqfJ2R4
	 LYyLJ/FQLSR36iGI1r6JAxpqqvjUPRxNo7tJxRlGfjH3V4RaWIwfbabiT7ehv1psMx
	 D4TO5E1hcO4qsNU2Kc/7Jd2orrI4MnQMkjwwI5lyj+ajVXwyXkZbIiOT8hEjURlazM
	 agMSXDylJ76Fg==
Message-ID: <8d909900-daee-4925-8d5a-2aa46275240d@kernel.org>
Date: Mon, 17 Feb 2025 15:06:57 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] cpufreq/amd-pstate: Drop min and max cached
 frequencies
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-3-superm1@kernel.org>
 <Z7LZg8oq3LqfKZID@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z7LZg8oq3LqfKZID@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/2025 00:38, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Fri, Feb 14, 2025 at 06:52:29PM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Use the perf_to_freq helpers to calculate this on the fly.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> --
>> v2:
>>   * Keep cached limits
>> ---
> 
> [..snip..]
> 
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
>> @@ -901,35 +901,25 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
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
> 
> So cpudata->nominal_freq will be in KHz here.
> 
> 
>> -	WRITE_ONCE(cpudata->min_freq, min_freq);
>> -
>> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
>> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>>   
>> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>> -	WRITE_ONCE(cpudata->max_freq, max_freq);
>> +	if (quirks && quirks->lowest_freq) {
>> +		min_freq = quirks->lowest_freq;
>> +	} else
>> +		min_freq = cppc_perf.lowest_freq;
>>
> 
> Since cppc_perf exposes the frequency values in MHz, min_freq is in MHz.
> 
>>   	/**
>>   	 * Below values need to be initialized correctly, otherwise driver will fail to load
>> @@ -937,12 +927,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
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
> 
> Since lowest_nonlinear_freq will be computed using cpudata->nominal_freq, the former will be in KHz.
> 
>> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>> +
>>   	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> And thus since lowest_nonlinear_freq is in KHz and min_freq is in MHz, this check will always be true.
> 
> Shouldn't the min_freq be multiplied by 1000 ?
>     

Yup, I think you're right.  Great catch!
I'll spin this for v3.

> 
>>   		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>>   			lowest_nonlinear_freq, min_freq, nominal_freq);
> 
> 


