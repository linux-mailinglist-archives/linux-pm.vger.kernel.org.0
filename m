Return-Path: <linux-pm+bounces-22854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6EA43321
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F3F1888395
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 02:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32813B29F;
	Tue, 25 Feb 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik1lYWRC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303D1CAB3;
	Tue, 25 Feb 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450917; cv=none; b=GpuD31wLxF0RrMAtLlyKr/W96a6yE8QdX+s0U3yJKhEuSz4qfXRYecsaZ6oD1Xp/xvxxi66I0bH5oS4ve0sEZJHmKTb5BwMN7e1D3LMb3JsosHtjw/HehDwwJZSyZD4vrYLI9BQVL3TvKk9P7VmZpZnRpSBXRy2Dz+ahLEboVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450917; c=relaxed/simple;
	bh=Sf0fMPUGApFdB94WpERkbiF7pKhHtCDahkiUeu03fOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNO1ih/2Hhck5Ua7u8Ji+YpR48UMJoNIWStdMkFjWf4szpe+Ax2qIe3hdRIO/sGuklGjflJIqDu7tznjXMF+S3Lv2eOGW0SKbUG6TR9iXxibItpMq80eqVb+EFWJYCIhkzpwpYqEavWMpopuA/xeh3Fk/jcNbRUYifsC57HClFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik1lYWRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E035C4CED6;
	Tue, 25 Feb 2025 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450916;
	bh=Sf0fMPUGApFdB94WpERkbiF7pKhHtCDahkiUeu03fOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ik1lYWRC6x574dddarPkxjKmXPZCBNb4RSEvYCthIz++1aFpzQIJr9HtxWR/Gla2w
	 d2aBaKxpKdLQvOMO80UXRemQZKrWNEanUs4j+nvo88n8SfLdvvOws1SQtryI9wulAY
	 K+He/8PxXJMdOlFpSvYnqmSlT63+wX/5CtH24F0LuN9ONMni9D2ysQKJ9180cMIaQM
	 edAe1xWHlyKh+eyGtQFysMfbcG/RQun4yB9xhWrFSphbJhw0v4cL1LCg16F+OmNOuF
	 NswiOdGqPhQ6usf3U8VJTjAGaBv6jKwBuaHslmtMp6aSHMEAY9bWumA/HQe7W3lV6y
	 QIKP4FKBkfw9w==
Message-ID: <f194be84-de10-4146-ac58-aab256b28443@kernel.org>
Date: Mon, 24 Feb 2025 17:46:27 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/19] cpufreq/amd-pstate: Drop
 amd_pstate_epp_cpu_offline()
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-20-superm1@kernel.org>
 <32d21c7a-9714-4f53-ad77-22ab81152455@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <32d21c7a-9714-4f53-ad77-22ab81152455@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/2025 03:25, Dhananjay Ugwekar wrote:
> On 2/20/2025 2:33 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When the CPU goes offline there is no need to change the CPPC request
>> because the CPU will go into the deepest C-state it supports already.>
>> Actually changing the CPPC request when it goes offline messes up the
>> cached values and can lead to the wrong values being restored when
>> it comes back.
>>
>> Instead if the CPU comes back online let amd_pstate_epp_set_policy()
>> restore it to expected values.
> 
> Small suggestion below, apart from that LGTM
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks!

> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 408e63aff377a..5068778c1542a 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1610,14 +1610,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>>   
>>   static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>>   {
>> -	struct amd_cpudata *cpudata = policy->driver_data;
>> -	union perf_cached perf = READ_ONCE(cpudata->perf);
>> -
>> -	if (cpudata->suspended)
>> -		return 0;
>> -
>> -	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
>> -				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>> +	return 0;
> 
> Instead of making it an empty "return 0" function, can we remove this
> callback altogether? Didnt check if there are any constraints against
> removing it.
> 
I originally had tried removing it, but the driver won't be able to 
setup properly unless the callback is setup.


