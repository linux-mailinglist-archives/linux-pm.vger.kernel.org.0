Return-Path: <linux-pm+bounces-10051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A8918205
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27E32869CB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D507188CCF;
	Wed, 26 Jun 2024 13:10:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C21836FE;
	Wed, 26 Jun 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407405; cv=none; b=GaQNJ82I+V3MhmAW17eASWSJu6w86hRXWk35QEFqhbkFWkUeayD+oDM1wXIi+4EOS0sLtMjOy0dtZAnUHuSO1uaqTjkmqdIcHtvMgJ4qq5HzLt44QyOZwLtkLXPo0CBEPjqDRcfqq4r9r3qKdRlWIJG7SNX2R6RDn0RVKiigkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407405; c=relaxed/simple;
	bh=fbyEDTduMIiV7ATd0/mO/o39aMMcYcfKWmIo8CJP4ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDj2EFAQoV2jm+S1KZp4B0yZ+MWKDoMWRMEKWCQ1Y1+D9Xwulfh8iAaF0KJBLgHMfgIeSz2dcHLBb1/CCCXMoamElIjgwRmytQT3dpzRzuXekCcc28OhKDtZE35Cqjynh40bTng+2Cus4bpASBR4vUKFp/T7PKif7IeC8S4wDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B660F339;
	Wed, 26 Jun 2024 06:10:25 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103273F73B;
	Wed, 26 Jun 2024 06:09:58 -0700 (PDT)
Message-ID: <99518a43-8347-4f62-aaf6-de6ce68eca0c@arm.com>
Date: Wed, 26 Jun 2024 15:09:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] cpuidle: teo: Don't count non-existent intercepts
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240611112413.1241352-1-christian.loehle@arm.com>
 <20240611112413.1241352-4-christian.loehle@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240611112413.1241352-4-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 13:24, Christian Loehle wrote:
> When bailing out early, teo will not query the sleep length anymore
> since commit 6da8f9ba5a87 ("cpuidle: teo:
> Skip tick_nohz_get_sleep_length() call in some cases") with an
> expected sleep_length_ns value of KTIME_MAX.
> This lead to state0 accumulating lots of 'intercepts' because
> the actually measured sleep length was < KTIME_MAX, so count KTIME_MAX
> as a hit (we have to count them as something otherwise we are stuck)
> and therefore teo taking too long to recover from intercept-heavy
> scenarios.
> 
> Fundamentally we can only do one of the two:
> 1. Skip sleep_length_ns query when we think intercept is likely

Isn't this what we do right now? Skip tick_nohz_get_sleep_length() for
state0 and set cpu_data->sleep_length_ns to KTIME_MAX in teo_select()
and then count this as an 'intercept' in teo_update().

> 2. Have accurate data if sleep_length_ns is actually intercepted when
> we believe it is currently intercepted.
> 
> This patch chooses the latter as I've found the additional time it
> takes to query the sleep length to be negligible and the variants of
> option 1 (count all unknowns as misses or count all unknown as hits)
> had significant regressions (as misses had lots of too shallow idle
> state selections and as hits had terrible performance in
> intercept-heavy workloads).

IMHO, you do 2 things here:

(1) Set 'cpu_data->sleep_length_ns != KTIME_MAX' for '!idx &&
    prev_intercept_idx' in teo_select().

(2) Force an update with 'cpu_data->sleep_length_ns == KTIME_MAX' to be
    counted as a 'hit' rather an 'intercept' in teo_update().

Can't really see how this matches the explanatory text exactly.


> 
> Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index cc7df59f488d..1e4b40474f49 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -231,8 +231,13 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 * length, this is a "hit", so update the "hits" metric for that bin.
>  	 * Otherwise, update the "intercepts" metric for the bin fallen into by
>  	 * the measured idle duration.
> +	 * If teo_select() bailed out early, we have to count this as a hit as
> +	 * we don't know what the true sleep length would've been. Otherwise
> +	 * we accumulate lots of intercepts at the shallower state (especially
> +	 * state0) even though there weren't any intercepts due to us
> +	 * anticipating one.
>  	 */
> -	if (idx_timer == idx_duration)
> +	if (idx_timer == idx_duration || cpu_data->sleep_length_ns == KTIME_MAX)
>  		cpu_data->state_bins[idx_timer].hits += PULSE;
>  	else
>  		cpu_data->state_bins[idx_duration].intercepts += PULSE;
> @@ -292,7 +297,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	unsigned int hit_sum = 0;
>  	int constraint_idx = 0;
>  	int idx0 = 0, idx = -1;
> -	bool alt_intercepts, alt_recent;
> +	int prev_intercept_idx;
>  	s64 duration_ns;
>  	int i;
>  
> @@ -370,6 +375,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	 * all of the deeper states a shallower idle state is likely to be a
>  	 * better choice.
>  	 */
> +	prev_intercept_idx = idx;
>  	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>  		int first_suitable_idx = idx;
>  
> @@ -421,6 +427,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  			first_suitable_idx = i;
>  		}
>  	}
> +	if (!idx && prev_intercept_idx) {
> +		/*
> +		 * We have to query the sleep length here otherwise we don't
> +		 * know after wakeup if our guess was correct.
> +		 */
> +		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> +		cpu_data->sleep_length_ns = duration_ns;
> +	}
>  
>  	/*
>  	 * If there is a latency constraint, it may be necessary to select an


