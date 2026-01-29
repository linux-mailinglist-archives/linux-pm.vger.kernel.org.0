Return-Path: <linux-pm+bounces-41672-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMQYMiIme2nXBgIAu9opvQ
	(envelope-from <linux-pm+bounces-41672-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:19:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6059FAE10C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4083A3014416
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380063793C0;
	Thu, 29 Jan 2026 09:19:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753237BE71;
	Thu, 29 Jan 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678367; cv=none; b=UONpGoTRSQe/Cs0dpi37ihe0YRe8s+Mkgi7PqgxDExVu7qdkSEWWHsrR37ioo3J8e/18G7CViWmo+TGFsLMoaT9gt4ocPo7AJlPgAQnsXajZihPOYkYAoWr2eQJakBT+KbbsDlRlN6qWQLMODXnsG3cXlkbDp3vOt4UnpgoOZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678367; c=relaxed/simple;
	bh=ffB8XeTKYvB2t0zmetW6C4zhH2U9zMjVEHHsMnqTsN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rkmz/UG/PjcErJWsEzUZsuZTinqF+Zxemkta9A4o/p+27DWQRvhJYXjscT/8yN18Af2rkFkcUrfDCrhHoQhZw2dD+8GvL8llk8fjSS81mqM2D534XIJTqXNSZ3lTU7zfyhX6+wtWtkdqtnhBoevFKJwfN7NtkpL2ezfXwhF/sr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1B71516;
	Thu, 29 Jan 2026 01:19:18 -0800 (PST)
Received: from [10.1.33.27] (e127648.arm.com [10.1.33.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD233F73F;
	Thu, 29 Jan 2026 01:19:23 -0800 (PST)
Message-ID: <a44aa54e-cfcf-4f3f-a832-da09cd9be70e@arm.com>
Date: Thu, 29 Jan 2026 09:19:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpuidle: governors: teo: Refine intercepts-based
 idle state lookup
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <12831359.O9o76ZdvQC@rafael.j.wysocki>
 <1951534.tdWV9SEqCh@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1951534.tdWV9SEqCh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41672-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6059FAE10C
X-Rspamd-Action: no action

On 1/26/26 19:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are cases in which decisions made by the teo governor are
> arguably overly conservative.
> 
> For instance, suppose that there are 4 idle states and the values of
> the intercepts metric for the first 3 of them are 400, 250, and 251,
> respectively.  If the total sum computed in teo_update() is 1000, the
> governor will select idle state 1 (provided that all idle states are
> enabled and the scheduler tick has not been stopped) although arguably
> idle state 0 would be a better choice because the likelihood of getting
> an idle duration below the target residency of idle state 1 is greater
> than the likelihood of getting an idle duration between the target
> residency of idle state 1 and the target residency of idle state 2.
> 
> To address this, refine the candidate idle state lookup based on
> intercepts to start at the state with the maximum intercepts metric,
> below the deepest enabled one, to avoid the cases in which the search
> may stop before reaching that state.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * Multiple fixes related to the handling of cases in which some states
>      are disabled.
>    * Fixes in new comments (there was some confusion in those comments
>      regarding the direction of idle states table traversal).
>    * Fixed typos in new comments.
> 
> ---
>  drivers/cpuidle/governors/teo.c |   50 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -73,12 +73,17 @@
>   *      than the candidate one (it represents the cases in which the CPU was
>   *      likely woken up by a non-timer wakeup source).
>   *
> + *    Also find the idle state with the maximum intercepts metric (if there are
> + *    multiple states with the maximum intercepts metric, choose the one with
> + *    the highest index).
> + *
>   * 2. If the second sum computed in step 1 is greater than a half of the sum of
>   *    both metrics for the candidate state bin and all subsequent bins (if any),
>   *    a shallower idle state is likely to be more suitable, so look for it.
>   *
>   *    - Traverse the enabled idle states shallower than the candidate one in the
> - *      descending order.
> + *      descending order, starting at the state with the maximum intercepts
> + *      metric found in step 1.
>   *
>   *    - For each of them compute the sum of the "intercepts" metrics over all
>   *      of the idle states between it and the candidate one (including the
> @@ -307,8 +312,10 @@ static int teo_select(struct cpuidle_dri
>  	ktime_t delta_tick = TICK_NSEC / 2;
>  	unsigned int idx_intercept_sum = 0;
>  	unsigned int intercept_sum = 0;
> +	unsigned int intercept_max = 0;
>  	unsigned int idx_hit_sum = 0;
>  	unsigned int hit_sum = 0;
> +	int intercept_max_idx = -1;
>  	int constraint_idx = 0;
>  	int idx0 = 0, idx = -1;
>  	s64 duration_ns;
> @@ -339,17 +346,32 @@ static int teo_select(struct cpuidle_dri
>  	if (!dev->states_usage[0].disable)
>  		idx = 0;
>  
> -	/* Compute the sums of metrics for early wakeup pattern detection. */
> +	/*
> +	 * Compute the sums of metrics for early wakeup pattern detection and
> +	 * look for the state bin with the maximum intercepts metric below the
> +	 * deepest enabled one (if there are multiple states with the maximum
> +	 * intercepts metric, choose the one with the highest index).
> +	 */
>  	for (i = 1; i < drv->state_count; i++) {
>  		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
> +		unsigned int prev_intercepts = prev_bin->intercepts;
>  		struct cpuidle_state *s = &drv->states[i];
>  
>  		/*
>  		 * Update the sums of idle state metrics for all of the states
>  		 * shallower than the current one.
>  		 */
> -		intercept_sum += prev_bin->intercepts;
>  		hit_sum += prev_bin->hits;
> +		intercept_sum += prev_intercepts;
> +		/*
> +		 * Check if this is the bin with the maximum number of
> +		 * intercepts so far and in that case update the index of
> +		 * the state with the maximum intercepts metric.
> +		 */
> +		if (prev_intercepts >= intercept_max) {
> +			intercept_max = prev_intercepts;
> +			intercept_max_idx = i - 1;
> +		}
>  
>  		if (dev->states_usage[i].disable)
>  			continue;
> @@ -413,9 +435,22 @@ static int teo_select(struct cpuidle_dri
>  		}
>  
>  		/*
> -		 * Look for the deepest idle state whose target residency had
> -		 * not exceeded the idle duration in over a half of the relevant
> -		 * cases in the past.
> +		 * If the minimum state index is greater than or equal to the
> +		 * index of the state with the maximum intercepts metric and
> +		 * the corresponding state is enabled, there is no need to look
> +		 * at the deeper states.
> +		 */
> +		if (min_idx >= intercept_max_idx &&
> +		    !dev->states_usage[min_idx].disable) {
> +			idx = min_idx;
> +			goto constraint;
> +		}
> +
> +		/*
> +		 * Look for the deepest enabled idle state, at most as deep as
> +		 * the one with the maximum intercepts metric, whose target
> +		 * residency had not been greater than the idle duration in over
> +		 * a half of the relevant cases in the past.
>  		 *
>  		 * Take the possible duration limitation present if the tick
>  		 * has been stopped already into account.
> @@ -427,7 +462,8 @@ static int teo_select(struct cpuidle_dri
>  				continue;
>  
>  			idx = i;
> -			if (2 * intercept_sum > idx_intercept_sum)
> +			if (2 * intercept_sum > idx_intercept_sum &&
> +			    i <= intercept_max_idx)

Should this be i >= intercept_max_idx?

>  				break;
>  		}
>  	}
> 
> 
> 


