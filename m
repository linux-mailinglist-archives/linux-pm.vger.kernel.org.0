Return-Path: <linux-pm+bounces-21989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE4A331E3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 23:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85CE7A33BD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 22:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A342036E3;
	Wed, 12 Feb 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBpUsG1j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88A1EBA0C;
	Wed, 12 Feb 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397820; cv=none; b=GN9lGSRmwP7Kvsmh4hxjTBjhd/cse3eym037zxf4xjyRiOMWmb5zv1I0KVOJ9zSdeU+psNlnkABSKBnfHmPcf5CHf40I4/d15J6Fe9u8cF032GYBXbFoTwuseNn5/X7F84FeckdlxtUgXvs5fQtDLDuPMkO2zbY/Vy7o+C+iq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397820; c=relaxed/simple;
	bh=1jS15T5LSSoxX9KSNY9N6nC/C71diAYS7K/Tu3QXNJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZewYGbrUenUbrSG+5vGFIvRPv7CDYYRkczyAT/tWj5Nk1kOXTXzfNCFP2u8otD5PBYeHl7mfJTY2qvHnB9/Z9NPn/zYR8QGD/K4Ymdj+LZ8Pxk6giIesd+YluAXLENqdW9Dr0/c5dVj3b/cx/QVMSZCKSdCqlsxUUvVXrEXIZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBpUsG1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F761C4CEDF;
	Wed, 12 Feb 2025 22:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739397820;
	bh=1jS15T5LSSoxX9KSNY9N6nC/C71diAYS7K/Tu3QXNJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XBpUsG1j8cUoX/90J8BADWbntcMSO1HQkNRFjrQTyUx5H8rlMUOiBWI3+VS7lgmPk
	 9Q2rG84/WMSYmu8bGIovbOXY+aiqBFkgw3tQ2sq508e9ZLK7gF6qKsVJ6jULZ3hNvc
	 hBFnfo2VIVsB8tOtiyC2N5lc1VMlEkE3nR6PsXbCArxm4IVN+r39vDkCkyPObP9Pdp
	 1CWRSA6eiuqznpsu/oicLhsxn5eE3eRgQgT2nGzLU+wfm2rw43aipJ4RuLbuoz3qf0
	 vP7vbCEJb+7x8ZZvBCnLH4bYTOOu74/1lz7Y/1JhsCzXt3VWED1pGdQZPdAf5+4Mgs
	 LKBlwXX1OYuww==
Message-ID: <0e93db03-5b1f-4c18-b8da-03cdf82492be@kernel.org>
Date: Wed, 12 Feb 2025 16:03:37 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] cpufreq/amd-pstate: Move perf values into a union
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-4-superm1@kernel.org>
 <5577e2ad-6cd0-4fe8-a8e8-28199491ca3a@amd.com>
 <9b38a679-875c-436a-9383-8b0d8a1b67af@kernel.org>
 <4d7dca2e-4245-44a3-96a7-0c9e1ef363fb@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <4d7dca2e-4245-44a3-96a7-0c9e1ef363fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/2025 00:31, Dhananjay Ugwekar wrote:
> On 2/12/2025 3:44 AM, Mario Limonciello wrote:
>> On 2/10/2025 07:38, Dhananjay Ugwekar wrote:
>>> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> By storing perf values in a union all the writes and reads can
>>>> be done atomically, removing the need for some concurrency protections.
>>>>
>>>> While making this change, also drop the cached frequency values,
>>>> using inline helpers to calculate them on demand from perf value.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
> [Snip]
>>>>      static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>>>>                      unsigned int target_freq, bool fast_switch)
>>>>    {
>>>>        struct cpufreq_freqs freqs;
>>>> -    struct amd_cpudata *cpudata = policy->driver_data;
>>>> +    struct amd_cpudata *cpudata;
>>>> +    union perf_cached perf;
>>>>        u8 des_perf;
>>>>          amd_pstate_update_min_max_limit(policy);
>>>>    +    cpudata = policy->driver_data;
>>>
>>> Any specific reason why we moved this dereferencing after amd_pstate_update_min_max_limit() ?
>>
>> Closer to the first use.
>>
>>>
>>>> +    perf = READ_ONCE(cpudata->perf);
>>>> +
>>>>        freqs.old = policy->cur;
>>>>        freqs.new = target_freq;
>>>>    -    des_perf = freq_to_perf(cpudata, target_freq);
>>>> +    des_perf = freq_to_perf(perf, cpudata->nominal_freq, target_freq);
>>>
>>> Personally I preferred the earlier 2 argument format for the helper functions, as the helper
>>> function handled the common dereferencing part, (i.e. cpudata->perf and cpudata->nominal_freq)
>>
>> Something like this?
>>
>> static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
>> {
>>      union perf_cached perf = READ_ONCE(cpudata->perf);
>>      u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, cpudata->nominal_freq);
>>
>>      return clamp_t(u8, perf_val, perf.lowest_perf, perf.highest_perf);
>> }
>>
>> As an example in practice of what that turns into with inline code it should be:
>>
>> static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>> {
>>      struct amd_cpudata *cpudata = policy->driver_data;
>>      union perf_cached perf = READ_ONCE(cpudata->perf);
>>      union perf_cached perf2 = READ_ONCE(cpudata->perf);
>>      union perf_cached perf3 = READ_ONCE(cpudata->perf);
>>      u8 val1 = DIV_ROUND_UP_ULL((u64)policy->max * perf2.nominal_perf, cpudata->nominal_freq);
>>      u8 val2 = DIV_ROUND_UP_ULL((u64)policy->min * perf2.nominal_perf, cpudata->nominal_freq);
>>
>>      perf.max_limit_perf = clamp_t(u8, val1, perf2.lowest_perf, perf2.highest_perf);
>>      perf.min_limit_perf = clamp_t(u8, val2, perf3.lowest_perf, perf3.highest_perf);
>> .
>> .
>> .
>>
>> So now that's 3 reads for cpudata->perf in every use.
> 
> Yea, right, its a tradeoff, in clean looking code vs less computations.
> I'll leave it upto you, I'm okay either way.
> 

OK - I think I'll leave it like it is now for the next spin, and let 
Gautham be the tie breaker when he reviews it if he doesn't like it.

