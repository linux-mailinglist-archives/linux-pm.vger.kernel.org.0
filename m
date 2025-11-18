Return-Path: <linux-pm+bounces-38163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28483C693AA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D7EDB2A97E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE73350D41;
	Tue, 18 Nov 2025 12:00:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24739320A30
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467216; cv=none; b=kBYwg7Ne3GgPq1Z2RAChAjzKB3tB23rYIGBZx0RnWhNLAidPhby+fmlnmlmYxUGHNlkeXNpJteF9hXTrMXbdLkXK/QpnG6eIuDbmD/AZ//IwpF1RMGF9RMLwkIXnysR6vauXNrnJhsqOD+XklPBupqrr9xIsK/b3t7Tu2b9NE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467216; c=relaxed/simple;
	bh=2evcxDax+lgGSF5gzZlNfr6xV20D9HRdjtzaNhXDF3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIyCKWQ0RyIp6Bt2ZcK2GoerSIjwADpyOfXGdxbkCCpCHQYVybfsf7uIX1u4bmx8U1vsTdOWDt+LKLQ+Pg08FZT1SC3KPQaU0Ooruw6NUWp3Wh6VUYYQ12eci4h1u3oHeIyx7Ge40r2ulAucYNuasFfp7YOA4IJvz/3CtMaCQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91328FEC;
	Tue, 18 Nov 2025 04:00:05 -0800 (PST)
Received: from [10.57.38.203] (unknown [10.57.38.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B3A3F740;
	Tue, 18 Nov 2025 04:00:12 -0800 (PST)
Message-ID: <242f6e83-fca0-4225-a196-e573202c2a95@arm.com>
Date: Tue, 18 Nov 2025 12:00:56 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: use cashed resolved frequency
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
References: <20251118064606.2777035-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251118064606.2777035-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kaushlendra,

s/cashed/cached/

On 11/18/25 06:46, Kaushlendra Kumar wrote:
> Return a previously resolved frequency when the requested target
> matches the policy cache to avoid repeated frequency-table lookups
> This implementation reuses the existing cached_target_freq and
> cached_resolved_idx fields maintained by __resolve_freq() and does not
> introduce new state.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   drivers/cpufreq/cpufreq.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..d90dcffac953 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -527,6 +527,15 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>   	unsigned int min = READ_ONCE(policy->min);
>   	unsigned int max = READ_ONCE(policy->max);

You've probably missed those two potentially changed values behind
your back...

>   
> +	/* If we recently resolved this target, return cached value.
> +	 * This avoids repeated frequency table searches.
> +	 */
> +	if (likely(policy->cached_target_freq == target_freq &&
> +		   policy->cached_resolved_idx != UINT_MAX &&
> +		   policy->freq_table)) {
> +		return policy->freq_table[policy->cached_resolved_idx].frequency;
> +	}
> +

I'm not that sure if this is a wise shortcut to make.

What if the 'target_freq' is the same as 'cached_target_freq' but
in the meantime the 'policy->max' has been updated and your
'target_freq' should be clamped (like it's in the
__resolve_freq() ?

IMO it would introduce be a potential bug, isn't it?

>   	/*
>   	 * If this function runs in parallel with cpufreq_set_policy(), it may
>   	 * read policy->min before the update and policy->max after the update

Look at the cut comment above and go to the code to see better. This
code runs in parallel with cpufreq_set_policy() and special care should
be takes to those values.

Maybe it could be solve with checking:
target_freq = clamp_val(target_freq, min, max);

Although, I'm not sure about the state of the 'relation' variable in
calling __resolve_freq(). It's hard-coded to CPUFREQ_RELATION_LE
but I would like to see Rafael's or Viresh's opinion about that
potential assumption.


Regards,
Lukasz

