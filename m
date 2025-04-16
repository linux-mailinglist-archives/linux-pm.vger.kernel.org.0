Return-Path: <linux-pm+bounces-25562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278BA90722
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 17:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C24917C5B1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC861FBCAF;
	Wed, 16 Apr 2025 15:00:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41B1B87E2;
	Wed, 16 Apr 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815651; cv=none; b=XeBBhX0OqguLOk0KQKeFBIuLgt56w7szpIMs8xzBowqlXeAQSG9Vqi/ArdQuO6jsCFQiroWy9klrK2zWHZuBd96ccuV7kVsO6Atl11MBSmwl2qEaHWsGl3W0n4+cUK+Ym0TYLNic5d9gaLi/M1eoZyEhWQgBOvXxaS4ZCi8LuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815651; c=relaxed/simple;
	bh=PsQV6HzJBQfKm0PbaYU4jGJbSIq3nTtrpbyvcMbd1iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6UCY33wkdcmdQ7/7oRoWvCeJ/1BFewDTxiOWVzsYMEfqJ2K8qZkWHRnIfkgCAW/zhwulfhBaV5PLIPaZ48EcHYdTEJjtFEmna63+dEgs4Yyd/vkxqpnAUrCMvZlkU39Po5dKtfY2C294Tx41CjrdUyvvSg3R1Xwwb7ew1Bfe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5111F1692;
	Wed, 16 Apr 2025 08:00:47 -0700 (PDT)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 213E73F66E;
	Wed, 16 Apr 2025 08:00:47 -0700 (PDT)
Message-ID: <1c0c6caa-e56c-454a-a976-81303dee1852@arm.com>
Date: Wed, 16 Apr 2025 16:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cpuidle: teo: Refine handling of short idle
 intervals
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <4661520.LvFx2qVVIh@rjwysocki.net>
 <2239639.irdbgypaU6@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2239639.irdbgypaU6@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 20:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make teo take all recent wakeups (both timer and non-timer) into
> account when looking for a new candidate idle state in the cases
> when the majority of recent idle intervals are within the
> LATENCY_THRESHOLD_NS range or the latency limit is within the
> LATENCY_THRESHOLD_NS range.
> 
> Since the tick_nohz_get_sleep_length() invocation is likely to be
> skipped in those cases, timer wakeups should arguably be taken into
> account somehow in case they are significant while the current code
> mostly looks at non-timer wakeups under the assumption that frequent
> timer wakeups are unlikely in the given idle duration range which
> may or may not be accurate.
> 
> The most natural way to do that is to add the "hits" metric to the
> sums used during the new candidate idle state lookup which effectively
> means the above.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hi Rafael,
I might be missing something so bare with me.
Quoting the cover-letter too:
"In those cases, timer wakeups are not taken into account when they are
within the LATENCY_THRESHOLD_NS range and the idle state selection may
be based entirely on non-timer wakeups which may be rare.  This causes
the prediction accuracy to be low and too much energy may be used as
a result.

The first patch is preparatory and it is not expected to make any
functional difference.

The second patch causes teo to take timer wakeups into account if it
is about to skip the tick_nohz_get_sleep_length() invocation, so they
get a chance to influence the idle state selection."

If the timer wakeups are < LATENCY_THRESHOLD_NS we will not do

cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);                              

but

cpu_data->sleep_length_ns = KTIME_MAX;

therefore
idx_timer = drv->state_count - 1
idx_duration = some state with residency < LATENCY_THRESHOLD_NS

For any reasonable system therefore idx_timer != idx_duration
(i.e. there's an idle state deeper than LATENCY_THRESHOLD_NS).
So hits will never be incremented?
How would adding hits then help this case?

> ---
>  drivers/cpuidle/governors/teo.c |   99 ++++++++++++++++++++++------------------
>  1 file changed, 55 insertions(+), 44 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -261,11 +261,12 @@
>  
>  static int teo_get_candidate(struct cpuidle_driver *drv,
>  			     struct cpuidle_device *dev,
> -			     struct teo_cpu *cpu_data,
> -			     int idx, unsigned int idx_intercepts)
> +			     struct teo_cpu *cpu_data, int constraint_idx,
> +			     int idx, unsigned int idx_events,
> +			     bool count_all_events)
>  {
>  	int first_suitable_idx = idx;
> -	unsigned int intercepts = 0;
> +	unsigned int events = 0;
>  	int i;
>  
>  	/*
> @@ -277,8 +278,11 @@
>  	 * has been stopped already into account.
>  	 */
>  	for (i = idx - 1; i >= 0; i--) {
> -		intercepts += cpu_data->state_bins[i].intercepts;
> -		if (2 * intercepts > idx_intercepts) {
> +		events += cpu_data->state_bins[i].intercepts;
> +		if (count_all_events)
> +			events += cpu_data->state_bins[i].hits;
> +
> +		if (2 * events > idx_events) {
>  			/*
>  			 * Use the current state unless it is too
>  			 * shallow or disabled, in which case take the
> @@ -316,6 +320,12 @@
>  		if (first_suitable_idx == idx)
>  			break;
>  	}
> +	/*
> +	 * If there is a latency constraint, it may be necessary to select an
> +	 * idle state shallower than the current candidate one.
> +	 */
> +	if (idx > constraint_idx)
> +		return constraint_idx;
>  
>  	return idx;
>  }
> @@ -410,49 +420,50 @@
>  	}
>  
>  	/*
> -	 * If the sum of the intercepts metric for all of the idle states
> -	 * shallower than the current candidate one (idx) is greater than the
> -	 * sum of the intercepts and hits metrics for the candidate state and
> -	 * all of the deeper states, a shallower idle state is likely to be a
> -	 * better choice.
> -	 */
> -	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum)
> -		idx = teo_get_candidate(drv, dev, cpu_data, idx, idx_intercept_sum);
> -
> -	/*
> -	 * If there is a latency constraint, it may be necessary to select an
> -	 * idle state shallower than the current candidate one.
> -	 */
> -	if (idx > constraint_idx)
> -		idx = constraint_idx;
> -
> -	/*
> -	 * If either the candidate state is state 0 or its target residency is
> -	 * low enough, there is basically nothing more to do, but if the sleep
> -	 * length is not updated, the subsequent wakeup will be counted as an
> -	 * "intercept" which may be problematic in the cases when timer wakeups
> -	 * are dominant.  Namely, it may effectively prevent deeper idle states
> -	 * from being selected at one point even if no imminent timers are
> -	 * scheduled.
> -	 *
> -	 * However, frequent timers in the RESIDENCY_THRESHOLD_NS range on one
> -	 * CPU are unlikely (user space has a default 50 us slack value for
> -	 * hrtimers and there are relatively few timers with a lower deadline
> -	 * value in the kernel), and even if they did happen, the potential
> -	 * benefit from using a deep idle state in that case would be
> -	 * questionable anyway for latency reasons.  Thus if the measured idle
> -	 * duration falls into that range in the majority of cases, assume
> -	 * non-timer wakeups to be dominant and skip updating the sleep length
> -	 * to reduce latency.
> +	 * If the measured idle duration has fallen into the
> +	 * RESIDENCY_THRESHOLD_NS range in the majority of recent cases, it is
> +	 * likely to fall into that range next time, so it is better to avoid
> +	 * adding latency to the idle state selection path.  Accordingly, aim
> +	 * for skipping the sleep length update in that case.
>  	 *
>  	 * Also, if the latency constraint is sufficiently low, it will force
>  	 * shallow idle states regardless of the wakeup type, so the sleep
> -	 * length need not be known in that case.
> +	 * length need not be known in that case either.
>  	 */
> -	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
> -	    (2 * cpu_data->short_idles >= cpu_data->total ||
> -	     latency_req < LATENCY_THRESHOLD_NS))
> -		goto out_tick;
> +	if (2 * cpu_data->short_idles >= cpu_data->total ||
> +	    latency_req < LATENCY_THRESHOLD_NS) {
> +		/*
> +		 * Look for a new candidate idle state and use all events (both
> +		 * "intercepts" and "hits") because the sleep length update is
> +		 * likely to be skipped and timer wakeups need to be taken into
> +		 * account in a different way in case they are significant.
> +		 */
> +		idx = teo_get_candidate(drv, dev, cpu_data, idx, constraint_idx,
> +					idx_intercept_sum + idx_hit_sum, true);
> +		/*
> +		 * If the new candidate state is state 0 or its target residency
> +		 * is low enough, return it right away without stopping the
> +		 * scheduler tick.
> +		 */
> +		if (!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)
> +			goto out_tick;
> +	} else if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> +		/*
> +		 * Look for a new candidate state because the current one is
> +		 * likely too deep, but use the "intercepts" metric only because
> +		 * the sleep length is going to be determined later and for now
> +		 * it is only necessary to find a state that will be suitable
> +		 * in case the CPU is "intercepted".
> +		 */
> +		idx = teo_get_candidate(drv, dev, cpu_data, idx, constraint_idx,
> +					idx_intercept_sum, false);
> +	} else if (idx > constraint_idx) {
> +		/*
> +		 * The current candidate state is too deep for the latency
> +		 * constraint at hand, so change it to a suitable one.
> +		 */
> +		idx = constraint_idx;
> +	}
>  
>  	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
>  	cpu_data->sleep_length_ns = duration_ns;
> 
> 
> 


