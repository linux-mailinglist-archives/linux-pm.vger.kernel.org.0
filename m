Return-Path: <linux-pm+bounces-38289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F14C72F13
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EFBCF2B123
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC530CD87;
	Thu, 20 Nov 2025 08:45:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CCA3054E8;
	Thu, 20 Nov 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628314; cv=none; b=efNgyRPDZvSP7Ytf72KqJ8dS8hiYKJ45mg+XlSgoP8kGGV2w7I8h4lSqVtIIt72Qlj5UxvGIfrnOu9If5VN3PykBdxc92LAVLEg1SYrKmu+CSmxec4hD3/ipeKhi8ANQcB4++SuJ0jS0nZnRR6wUby669evokGeDaE9qavGFp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628314; c=relaxed/simple;
	bh=o+J/c3gGPwL6dd0RBbGodfkkgwNwDdQK17W+Wdfq9UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieJqPfUto9U3mKXBSHboIL5QsZgvKyLr6SuWe1jHSQN3PxpOrJWjjaE9bUdGyEP93B08SKx+qx5LoSpGFEZzNiw5WkZqmhQNmm+wl1rAZjr33vCJOgwctc0FcHBsmi2n02D8dNWJIvXv9bKaRoQni3m8ev5XdCEXlQH6YsG1eUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4199C2B;
	Thu, 20 Nov 2025 00:45:04 -0800 (PST)
Received: from [10.57.69.158] (unknown [10.57.69.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4FC13F740;
	Thu, 20 Nov 2025 00:45:10 -0800 (PST)
Message-ID: <1fcc8368-7a21-418e-8c42-aae96272beee@arm.com>
Date: Thu, 20 Nov 2025 08:45:08 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cpuidle: governors: teo: Simplify intercepts-based
 state lookup
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <12810244.O9o76ZdvQC@rafael.j.wysocki>
 <2418792.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2418792.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 12:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Simplify the loop looking up a candidate idle state in the case when an
> intercept is likely to occur by adding a search for the state index limit
> if the tick is stopped before it.
> 
> First, call tick_nohz_tick_stopped() just once and if it returns true,
> look for the shallowest state index below the current candidate one with
> target residency at least equal to the tick period length.
> 
> Next, simply look for a state that is not shallower than the one found
> in the previous step and, ideally, satisfies the intercepts majority
> condition.

NIT: The ideally is a bit handwavy, maybe:
Next, look for the deepest state that satisfies the intercepts majority
condition but select no shallower state than the one from the previous step.

Sounds a bit verbose I guess.

> 
> Since teo_state_ok() has no callers any more after the above changes,
> drop it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   62 ++++++++++------------------------------
>  1 file changed, 16 insertions(+), 46 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -256,12 +256,6 @@ static void teo_update(struct cpuidle_dr
>  	}
>  }
>  
> -static bool teo_state_ok(int i, struct cpuidle_driver *drv)
> -{
> -	return !tick_nohz_tick_stopped() ||
> -		drv->states[i].target_residency_ns >= TICK_NSEC;
> -}
> -
>  /**
>   * teo_find_shallower_state - Find shallower idle state matching given duration.
>   * @drv: cpuidle driver containing state data.
> @@ -383,7 +377,18 @@ static int teo_select(struct cpuidle_dri
>  	 * better choice.
>  	 */
>  	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> -		int first_suitable_idx = idx;
> +		int min_idx = idx0;
> +
> +		if (tick_nohz_tick_stopped()) {
> +			/*
> +			 * Look for the shallowest idle state below the current
> +			 * candidate one whose target residency is not below the
> +			 * tick period length.
> +			 */

NIT: s/not below/above
or just use >= in the comment?

> +			while (min_idx < idx &&
> +			       drv->states[min_idx].target_residency_ns < TICK_NSEC)
> +				min_idx++;
> +		}
>  
>  		/*
>  		 * Look for the deepest idle state whose target residency had
> @@ -393,49 +398,14 @@ static int teo_select(struct cpuidle_dri
>  		 * Take the possible duration limitation present if the tick
>  		 * has been stopped already into account.
>  		 */
> -		intercept_sum = 0;
> -
> -		for (i = idx - 1; i >= 0; i--) {
> -			struct teo_bin *bin = &cpu_data->state_bins[i];
> -
> -			intercept_sum += bin->intercepts;
> -
> -			if (2 * intercept_sum > idx_intercept_sum) {
> -				/*
> -				 * Use the current state unless it is too
> -				 * shallow or disabled, in which case take the
> -				 * first enabled state that is deep enough.
> -				 */
> -				if (teo_state_ok(i, drv) &&
> -				    !dev->states_usage[i].disable) {
> -					idx = i;
> -					break;
> -				}
> -				idx = first_suitable_idx;
> -				break;
> -			}
> +		for (i = idx - 1, intercept_sum = 0; i >= min_idx; i--) {
> +			intercept_sum += cpu_data->state_bins[i].intercepts;
>  
>  			if (dev->states_usage[i].disable)
>  				continue;
>  
> -			if (teo_state_ok(i, drv)) {
> -				/*
> -				 * The current state is deep enough, but still
> -				 * there may be a better one.
> -				 */
> -				first_suitable_idx = i;
> -				continue;
> -			}
> -
> -			/*
> -			 * The current state is too shallow, so if no suitable
> -			 * states other than the initial candidate have been
> -			 * found, give up (the remaining states to check are
> -			 * shallower still), but otherwise the first suitable
> -			 * state other than the initial candidate may turn out
> -			 * to be preferable.
> -			 */
> -			if (first_suitable_idx == idx)
> +			idx = i;
> +			if (2 * intercept_sum > idx_intercept_sum)
>  				break;
>  		}
>  	}

Thanks, that is indeed a nice simplification. I'll get test results out on Monday,
sorry!

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

