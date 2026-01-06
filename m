Return-Path: <linux-pm+bounces-40332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F2CFACC5
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801BF3158159
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC39034D385;
	Tue,  6 Jan 2026 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c02Ax4OS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D763090CC;
	Tue,  6 Jan 2026 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727808; cv=none; b=jkOeXuwi10Yq7or1PF5nVD3Mwe+3M6Ls5IQ9crmU8Nea+UTD0J0AV8MNfA5Ak3+ripBhoDQWh4EtpypTy7HNxyRptqcMPTeIDTFNU5J671+micfQn7gBnesvTQWoPGyMt6g/+4Ws2mb7U1ey4jatsTcPVIHOlrGTaRJ7q3vlu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727808; c=relaxed/simple;
	bh=65FHEdsl3qmcecvbhDm3fIBYqduzHPc/HW3W3tCWGy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXT88+PahT1rtkgmz8tz11l+V2f/duLMfhOKZkJqaBuIrlscYeR3R+hfGxKb2yoKCmsDKooFJToMD/dnTJYTIJgYlsUc9DAaY98aR7l9/FV+ol7rjEuGBajV5VNmavpXWTJ/8qe2Vjzux7cY98Lx8DEp6SGy7lvWn5MktMeI01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c02Ax4OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B3BC116C6;
	Tue,  6 Jan 2026 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767727808;
	bh=65FHEdsl3qmcecvbhDm3fIBYqduzHPc/HW3W3tCWGy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c02Ax4OSO7PWuHseTtEYhimqqy4A2Uy/5B9Hj46+HbUDjcsL0oaKYzq6HGDj+csby
	 dDkopt5hVgF8hQd2zLS12o6hHi4YlzQYgmU8ONm9YJrgi+LJ+NBoTOHgmuY1ykk07W
	 e2MaKRWcGDEckzc+hPZfknezOw4dw8iaMjhmExxscYme1QjalFS9hXTid9wvWrmkjG
	 LDRtfZSTBzOkjKNBABrvhiLZW4CfTTkqUdEksBcuChsavuR/GJ8/UOoxUjAM1qTvJh
	 kLEcNxQQb75YIyogHge3yt8yoNEpEmjTSjvRdjElRG+6f8iTAnFeM5SqK8TDJr7KMw
	 b055YYTBDeOMQ==
Message-ID: <8fb99491-093e-44e6-9227-8254ac8b51a6@kernel.org>
Date: Tue, 6 Jan 2026 13:30:04 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Perry Yuan <perry.yuan@amd.com>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
 <20260106073608.278644-2-kprateek.nayak@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260106073608.278644-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/2026 1:36 AM, K Prateek Nayak wrote:
> All callers of amd_pstate_update() already have a reference to the
> cpufreq_policy object.
> 
> Pass the entire policy object and grab the cpudata using
> "policy->driver_data" instead of passing the cpudata and unnecessarily
> grabbing another read-side reference to the cpufreq policy object when
> it is already available in the caller.
> 
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c45bc98721d2..5818a92d96b9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -565,15 +565,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   	return true;
>   }
>   
> -static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
> +static void amd_pstate_update(struct cpufreq_policy *policy, u8 min_perf,
>   			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>   {
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   
> -	if (!policy)
> -		return;
> -
>   	/* limit the max perf when core performance boost feature is disabled */
>   	if (!cpudata->boost_supported)
>   		max_perf = min_t(u8, perf.nominal_perf, max_perf);
> @@ -675,7 +672,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>   	if (!fast_switch)
>   		cpufreq_freq_transition_begin(policy, &freqs);
>   
> -	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
> +	amd_pstate_update(policy, perf.min_limit_perf, des_perf,
>   			  perf.max_limit_perf, fast_switch,
>   			  policy->governor->flags);
>   
> @@ -737,7 +734,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (max_perf < min_perf)
>   		max_perf = min_perf;
>   
> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> +	amd_pstate_update(policy, min_perf, des_perf, max_perf, true,
>   			policy->governor->flags);
>   }
>   


