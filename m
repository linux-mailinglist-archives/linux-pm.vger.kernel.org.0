Return-Path: <linux-pm+bounces-25552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB816A8B953
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FD11666AD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C11B960;
	Wed, 16 Apr 2025 12:39:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995EA17BA6;
	Wed, 16 Apr 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807160; cv=none; b=Y5SaJr31w2bK0xOfUs9ThwjNJ2r0QZW39g7ws9p2+oboZOz/nkhrU5A+hHIPP4pzIwDVLM9IUiQQEzZUfYNRz8Hw1pAOsokzIALonP/7r05B0G3fArBm9d+WPNzJqDGxlGqxI/NZUYFDQgikxqfYvVxSuIAX2LDG/K8AsBox5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807160; c=relaxed/simple;
	bh=rSuWRa1vIupLg/d8A28F0xfPJvQox9WpPM5efvX+iDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOPgqyb5FT91Q5wKw/RFvaN+nhuKsv7++7MSrKTCs7LJQeNVFuoCM2IAiA6Oh+6PrHyBU4vEW1nvg4ZGK80Bhtxwzbb5VoC8dziwP9k8LjT4F5BY/0SL8wRGmXAtbiDZBDsbPkvcQyQjBlKWE+EO+yDZESCcdzWZ+2gC+L71yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF301595;
	Wed, 16 Apr 2025 05:39:14 -0700 (PDT)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51C413F694;
	Wed, 16 Apr 2025 05:39:14 -0700 (PDT)
Message-ID: <ce438098-ee9c-4808-b409-bb57b62794f0@arm.com>
Date: Wed, 16 Apr 2025 13:39:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] cpufreq: Avoid using inconsistent policy->min and
 policy->max
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <9458818.CDJkKcVGEf@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <9458818.CDJkKcVGEf@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 11:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_driver_resolve_freq() can run in parallel with
> cpufreq_set_policy() and there is no synchronization between them,
> the former may access policy->min and policy->max while the latter
> is updating them and it may see intermediate values of them due
> to the way the update is carried out.  Also the compiler is free
> to apply any optimizations it wants both to the stores in
> cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> which may result in additional inconsistencies.
> 
> To address this, use WRITE_ONCE() when updating policy->min and
> policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> in cpufreq_set_policy() to avoid storing intermediate values in
> policy->min and policy->max with the help of the observation that
> their new values are expected to be properly ordered upfront.
> 
> Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> ordering of policy->min and policy->max, which may happen depending on
> the ordering of operations when this function and cpufreq_set_policy()
> run concurrently, into account by always honoring the max when it
> turns out to be less than the min (in case it comes from thermal
> throttling or similar).
> 
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Just so I understand, the reason you don't squish 4-6 into one is
because this is the only fix? I do get that, but doesn't the fact
that it could easily be picked for backports make up for the additional
refactor?
Actual changes from patches 4-6 look good to me.

> ---
> 
> v1 -> v2: Minor edit in the subject
> 
> ---
>  drivers/cpufreq/cpufreq.c |   46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -490,14 +490,12 @@
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>  
> -static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
> -					   unsigned int target_freq,
> -					   unsigned int relation)
> +static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> +				   unsigned int target_freq,
> +				   unsigned int relation)
>  {
>  	unsigned int idx;
>  
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> -
>  	if (!policy->freq_table)
>  		return target_freq;
>  
> @@ -507,6 +505,15 @@
>  	return policy->freq_table[idx].frequency;
>  }
>  
> +static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
> +					   unsigned int target_freq,
> +					   unsigned int relation)
> +{
> +	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +
> +	return __resolve_freq(policy, target_freq, relation);
> +}
> +
>  /**
>   * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
>   * one.
> @@ -521,7 +528,22 @@
>  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  					 unsigned int target_freq)
>  {
> -	return clamp_and_resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
> +	unsigned int min = READ_ONCE(policy->min);
> +	unsigned int max = READ_ONCE(policy->max);
> +
> +	/*
> +	 * If this function runs in parallel with cpufreq_set_policy(), it may
> +	 * read policy->min before the update and policy->max after the update
> +	 * or the other way around, so there is no ordering guarantee.
> +	 *
> +	 * Resolve this by always honoring the max (in case it comes from
> +	 * thermal throttling or similar).
> +	 */
> +	if (unlikely(min > max))
> +		min = max;
> +
> +	return __resolve_freq(policy, clamp_val(target_freq, min, max),
> +			      CPUFREQ_RELATION_LE);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>  
> @@ -2632,11 +2654,15 @@
>  	 * Resolve policy min/max to available frequencies. It ensures
>  	 * no frequency resolution will neither overshoot the requested maximum
>  	 * nor undershoot the requested minimum.
> +	 *
> +	 * Avoid storing intermediate values in policy->max or policy->min and
> +	 * compiler optimizations around them because them may be accessed

s/them/they/

> +	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>  	 */
> -	policy->min = new_data.min;
> -	policy->max = new_data.max;
> -	policy->min = clamp_and_resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
> -	policy->max = clamp_and_resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> +	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
> +	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
> +	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
> +
>  	trace_cpu_frequency_limits(policy);
>  
>  	cpufreq_update_pressure(policy);
> 
> 
> 


