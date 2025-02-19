Return-Path: <linux-pm+bounces-22457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFCA3C603
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 18:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BF1178266
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431551FDA93;
	Wed, 19 Feb 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddjY5H2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFE286284;
	Wed, 19 Feb 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985668; cv=none; b=CNF96jRmBMPzxABAltJ06ptpXjKAVKwSnihRu+N8UQtWIXNfW5uxtZ6tOfU++00rX43FewsSopPKT0qnHS88KojO9ePkKPr4TxRwxUvv0nOVZ8I00+UtsIVY1eUG6l+1CyrpLuDwgtw1HsDrVZzuaMj+hxaJIQLbSnDhbsTkUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985668; c=relaxed/simple;
	bh=ov+u5w/5fC+8oMPN7+g0AbEGhh+S1mUoX5U15HsZ72o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tn/IGmrLLWIbHs34UqDccWGWiP2ab5WC3Y40zFJhDC/Bgyy0R+Jh2eod/oPJuf4FVRuXlO7oiu1numFKLviVRx9Vw9P7MHFAugac72KjPjS0WygbjzwbhVVhzbSV9ouPaLK/g0xnCyjJVQMYCMagqSKXofNA0p9X5d/z8oxqVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddjY5H2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA7C4CED1;
	Wed, 19 Feb 2025 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985667;
	bh=ov+u5w/5fC+8oMPN7+g0AbEGhh+S1mUoX5U15HsZ72o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ddjY5H2gWfTW5YwRCxyJV9CWSepJjZTICyTk07K9DUtj+yeVFHNvc6fOag0o9SUJ+
	 I+wuk1RwlU5tiP8cbZp++09mdD30s89q2UjmifyxpMtk6J7/VZ5jOP6PfFFuMGjSzK
	 dib1HPv1FSWr2c3KeFtrc9RaOgKnK7vqDtyNu8Hqe6sgVfZygvpY9ViAE6jjbSjYS/
	 bLOwmWsD+xD2KCyuPqicoLbEJsz06yMKT54QvpIxgytMphAwMMZki/BDqk/kCbS/Ug
	 yeg7pc7SE1yFntGZUToQph+lp+xLc5zUbSkrMw5G51oJqm/krY4VkjmTaKIN8PI6b6
	 I+V2qN3M/NW1A==
Message-ID: <740725e2-0580-4a52-baa1-44e722d4ce35@kernel.org>
Date: Wed, 19 Feb 2025 11:21:05 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] cpufreq/amd-pstate: Invalidate cppc_req_cached
 during suspend
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Miroslav Pavleski <miroslav@pavleski.net>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-2-superm1@kernel.org>
 <Z7VrADfrrPB7GtfX@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z7VrADfrrPB7GtfX@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/2025 23:24, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> 
> On Mon, Feb 17, 2025 at 04:06:50PM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> During resume it's possible the firmware didn't restore the CPPC request MSR
>> but the kernel thinks the values line up. This leads to incorrect performance
>> after resume from suspend.
>>
>> To fix the issue invalidate the cached value at suspend. During resume use
>> the saved values programmed as cached limits.
>>
>> Reported-by: Miroslav Pavleski <miroslav@pavleski.net>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index f425fb7ec77d7..12fb63169a24c 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1611,7 +1611,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>>   					  max_perf, policy->boost_enabled);
>>   	}
> 
> You can also remove the tracing code from amd_pstate_epp_reenable(), i.e,
> 
> 	if (trace_amd_pstate_epp_perf_enabled()) {
> 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> 					  cpudata->epp_cached,
> 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> 					  max_perf, policy->boost_enabled);
> 	}
> 
> Since amd_pstate_epp_update_limit() also has the the tracing code.

Yeah; the tracing code gets updated later in the series.
My plan is this commit is a minimal fix, and will go to 6.14, the rest 
will be in 6.15.

> 
> The patch looks good to me otherwise.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> 

Thanks!

