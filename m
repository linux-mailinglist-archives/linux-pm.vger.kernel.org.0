Return-Path: <linux-pm+bounces-43673-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D8ULuJfqWlc6QAAu9opvQ
	(envelope-from <linux-pm+bounces-43673-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:50:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50620FF91
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 280C93124DCA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFB34D907;
	Thu,  5 Mar 2026 10:45:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382237F759;
	Thu,  5 Mar 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707521; cv=none; b=YIwwVUalPGfvlFuewLEFa821o/5GLQvLpviRy2Op1RcUCnyX8SxxXXR6corZFfZF1wlNBKc4pgHIoiB7Zt2y3S1Y9YkY2ljs2HWk8myvR4lHS3i6VvCrSy52r7bxWlRcqitteplUDOozcFcYTnWVZCHF/V78iJWjD26EuPnTYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707521; c=relaxed/simple;
	bh=j2VbidLMdmkbGfhWLIgyLDnqnkV1xEQqZj945AiqhAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTRRRR1kw6VcgJeII7P8e/bfy7Fj/yGFqI4hxTgLpxz3CI7ZiQz7/uXa6vTuAQiLNvWEbYKcMUXGnBd09YVEkRPHxo5fUjNfskSiV6ltvuSurBbjRFLz+hZFGUybfCWufFkx9Qj9iX+b/RYurKwL126yQRzgMZ+cLyHka1YQEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0C8339;
	Thu,  5 Mar 2026 02:45:13 -0800 (PST)
Received: from [10.1.38.68] (unknown [10.1.38.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B92D43F694;
	Thu,  5 Mar 2026 02:45:18 -0800 (PST)
Message-ID: <b23927de-4183-4490-8a20-a26a8d39cec2@arm.com>
Date: Thu, 5 Mar 2026 10:45:16 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpuidle: governors: teo: Rearrange stopped tick
 handling
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
References: <3693525.iIbC2pHGDl@rafael.j.wysocki>
 <1865078.VLH7GnMWUR@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1865078.VLH7GnMWUR@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F50620FF91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,telus.net,linux.ibm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-43673-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid,arm.com:email,intel.com:email]
X-Rspamd-Action: no action

On 2/23/26 15:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> This change is based on the observation that it is not in fact necessary
> to select a deep idle state every time the scheduler tick has been
> stopped before the idle state selection takes place.  Namely, if the
> time till the closest timer (that is not the tick) is short enough,
> a shallow idle state can be selected because the timer will kick the
> CPU out of that state, so the damage from a possible overly optimistic
> selection will be limited.
> 
> Update the teo governor in accordance with the above in analogy with
> the previous analogous menu governor update.
> 
> Among other things, this will cause the teo governor to call
> tick_nohz_get_sleep_length() every time when the tick has been
> stopped already and only change the original idle state selection
> if the time till the closest timer is beyond SAFE_TIMER_RANGE_NS
> which is way more straightforward than the current code flow.
> 
> Of course, this effectively throws away some of the recent teo governor
> changes made recently, but the resulting simplification is worth it in
> my view.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Take constraint_idx into account when looking for a deeper idle
>           state (Christian)
> 
> ---
>  drivers/cpuidle/governors/teo.c |   81 ++++++++++++++++------------------------
>  1 file changed, 34 insertions(+), 47 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -407,50 +407,13 @@ static int teo_select(struct cpuidle_dri
>  	 * better choice.
>  	 */
>  	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> -		int min_idx = idx0;
> -
> -		if (tick_nohz_tick_stopped()) {
> -			/*
> -			 * Look for the shallowest idle state below the current
> -			 * candidate one whose target residency is at least
> -			 * equal to the tick period length.
> -			 */
> -			while (min_idx < idx &&
> -			       drv->states[min_idx].target_residency_ns < TICK_NSEC)
> -				min_idx++;
> -
> -			/*
> -			 * Avoid selecting a state with a lower index, but with
> -			 * the same target residency as the current candidate
> -			 * one.
> -			 */
> -			if (drv->states[min_idx].target_residency_ns ==
> -					drv->states[idx].target_residency_ns)
> -				goto constraint;
> -		}
> -
> -		/*
> -		 * If the minimum state index is greater than or equal to the
> -		 * index of the state with the maximum intercepts metric and
> -		 * the corresponding state is enabled, there is no need to look
> -		 * at the deeper states.
> -		 */
> -		if (min_idx >= intercept_max_idx &&
> -		    !dev->states_usage[min_idx].disable) {
> -			idx = min_idx;
> -			goto constraint;
> -		}
> -
>  		/*
>  		 * Look for the deepest enabled idle state, at most as deep as
>  		 * the one with the maximum intercepts metric, whose target
>  		 * residency had not been greater than the idle duration in over
>  		 * a half of the relevant cases in the past.
> -		 *
> -		 * Take the possible duration limitation present if the tick
> -		 * has been stopped already into account.
>  		 */
> -		for (i = idx - 1, intercept_sum = 0; i >= min_idx; i--) {
> +		for (i = idx - 1, intercept_sum = 0; i >= idx0; i--) {
>  			intercept_sum += cpu_data->state_bins[i].intercepts;
>  
>  			if (dev->states_usage[i].disable)
> @@ -463,7 +426,6 @@ static int teo_select(struct cpuidle_dri
>  		}
>  	}
>  
> -constraint:
>  	/*
>  	 * If there is a latency constraint, it may be necessary to select an
>  	 * idle state shallower than the current candidate one.
> @@ -472,13 +434,13 @@ constraint:
>  		idx = constraint_idx;
>  
>  	/*
> -	 * If either the candidate state is state 0 or its target residency is
> -	 * low enough, there is basically nothing more to do, but if the sleep
> -	 * length is not updated, the subsequent wakeup will be counted as an
> -	 * "intercept" which may be problematic in the cases when timer wakeups
> -	 * are dominant.  Namely, it may effectively prevent deeper idle states
> -	 * from being selected at one point even if no imminent timers are
> -	 * scheduled.
> +	 * If the tick has not been stopped and either the candidate state is
> +	 * state 0 or its target residency is low enough, there is basically
> +	 * nothing more to do, but if the sleep length is not updated, the
> +	 * subsequent wakeup will be counted as an "intercept".  That may be
> +	 * problematic in the cases when timer wakeups are dominant because it
> +	 * may effectively prevent deeper idle states from being selected at one
> +	 * point even if no imminent timers are scheduled.
>  	 *
>  	 * However, frequent timers in the RESIDENCY_THRESHOLD_NS range on one
>  	 * CPU are unlikely (user space has a default 50 us slack value for
> @@ -494,7 +456,8 @@ constraint:
>  	 * shallow idle states regardless of the wakeup type, so the sleep
>  	 * length need not be known in that case.
>  	 */
> -	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
> +	if (!tick_nohz_tick_stopped() && (!idx ||
> +	     drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
>  	    (2 * cpu_data->short_idles >= cpu_data->total ||
>  	     latency_req < LATENCY_THRESHOLD_NS))
>  		goto out_tick;
> @@ -502,6 +465,30 @@ constraint:
>  	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
>  	cpu_data->sleep_length_ns = duration_ns;
>  
> +	/*
> +	 * If the tick has been stopped and the closest timer is too far away,
> +	 * update the selection to prevent the CPU from getting stuck in a
> +	 * shallow idle state for too long.
> +	 */
> +	if (tick_nohz_tick_stopped() && duration_ns > SAFE_TIMER_RANGE_NS &&
> +	    drv->states[idx].target_residency_ns < TICK_NSEC) {
> +		/*
> +		 * Look for the deepest enabled idle state with exit latency
> +		 * within the PM QoS limit and with target residency within
> +		 * duration_ns.
> +		 */
> +		for (i = constraint_idx; i > idx; i--) {
> +			if (dev->states_usage[i].disable)
> +				continue;
> +
> +			if (drv->states[i].target_residency_ns <= duration_ns) {
> +				idx = i;
> +				break;
> +			}
> +		}
> +		return idx;
> +	}
> +
>  	if (!idx)
>  		goto out_tick;
>  
> 

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

