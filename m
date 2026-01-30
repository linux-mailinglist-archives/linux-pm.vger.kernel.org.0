Return-Path: <linux-pm+bounces-41770-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOt0A2KJfGmbNgIAu9opvQ
	(envelope-from <linux-pm+bounces-41770-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:35:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A4B968D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 216FF300EA98
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 10:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE93369960;
	Fri, 30 Jan 2026 10:34:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62C368291;
	Fri, 30 Jan 2026 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769266; cv=none; b=lr2JcrPwYzlb/qQKih9IBKfg4R+awzLWulXPjPlVa2CDSQpZN1h0iHS/QVp7LQXwCH1B7OaQqRjyoXWky1y3pfKDXsbyxOBZdpxyMqbww/BiCl9jGoDhSsKeVZnRNUsZGSAhD/X/LjkNdSWHvxpe8mQXUTfvr8VwlUmElE8idZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769266; c=relaxed/simple;
	bh=+3QWpWNuzXEBiH1ZSLhCH6CUgIbELvaVHHQtplVCAFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOkZk6xBgHqyhmmotiHNYGeDDNFgTkkkdRzSPKBkVCRXzvppJA4j5Nehy/S4Eq9XLxT9/bKawdRFFQzXgWVwiJeXvuue9jCTGhWPyycnRESpr87c0PkRgay2azA5/kLAJGiRVyC1TYlX34j5PCb7bOqEsAGtsbLBz8LqSGwaBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B57153B;
	Fri, 30 Jan 2026 02:34:17 -0800 (PST)
Received: from [10.1.39.37] (e127648.arm.com [10.1.39.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FE83F632;
	Fri, 30 Jan 2026 02:34:22 -0800 (PST)
Message-ID: <98b986a8-f44a-46b4-86d2-0bc747206f2d@arm.com>
Date: Fri, 30 Jan 2026 10:34:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cpuidle: governors: teo: Adjust the classification
 of wakeup events
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <12846604.O9o76ZdvQC@rafael.j.wysocki>
 <5093379.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5093379.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41770-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 7F8A4B968D
X-Rspamd-Action: no action

On 1/29/26 20:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If differences between target residency values of adjacent idle states
> of a given CPU are relatively large, the corresponding idle state bins
> used by the teo governors are large either and the rule by which hits
> are distinguished from intercepts is inaccurate.
> 
> Namely, by that rule, a wakeup event is classified as a hit if the
> sleep length (the time till the closest timer other than the tick)
> and the measured idle duration, adjusted for the entered idle state
> exit latency, fall into the same idle state bin.  However, if that bin
> is large enough, the actual difference between the sleep length and
> the measured idle duration may be significant.  It may in fact be
> significantly greater than the analogous difference for an event where
> the sleep length and the measured idle duration fall into different
> bins.
> 
> For this reason, amend the rule in question with a check that will only
> allow a wakeup event to be counted as a hit if the sleep length is less
> than the "raw" measured idle duration (which means that the wakeup
> appears to have occurred after the anticipated timer event).  Otherwise,
> the event will be counted as an intercept.
> 
> Also update the documentation part explaining the difference between
> "hits" and "intercepts" to take the above change into account.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> 
> v2 -> v3:
>    * Use 1/2 of the entered state exit latency instead of a constant
>      margin in the inequality driving the classification (Christian).
>    * Update code comments and the changelog.
> 
> v1.1 -> v2: No changes
> 
> v1 -> v1.1
>    * Drop the change in teo_select() along with the corresponding
>      part of the changelog (after receiving testing feedback from
>      Christian)
> 
> ---
>  drivers/cpuidle/governors/teo.c |   25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -48,12 +48,11 @@
>   * in accordance with what happened last time.
>   *
>   * The "hits" metric reflects the relative frequency of situations in which the
> - * sleep length and the idle duration measured after CPU wakeup fall into the
> - * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
> - * length).  In turn, the "intercepts" metric reflects the relative frequency of
> - * non-timer wakeup events for which the measured idle duration falls into a bin
> - * that corresponds to an idle state shallower than the one whose bin is fallen
> - * into by the sleep length (these events are also referred to as "intercepts"
> + * sleep length and the idle duration measured after CPU wakeup are close enough
> + * (that is, the CPU appears to wake up "on time" relative to the sleep length).
> + * In turn, the "intercepts" metric reflects the relative frequency of non-timer
> + * wakeup events for which the measured idle duration is significantly different
> + * from the sleep length (these events are also referred to as "intercepts"
>   * below).
>   *
>   * The governor also counts "intercepts" with the measured idle duration below
> @@ -167,6 +166,7 @@ static void teo_decay(unsigned int *metr
>   */
>  static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  {
> +	s64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
>  	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
>  	int i, idx_timer = 0, idx_duration = 0;
>  	s64 target_residency_ns, measured_ns;
> @@ -182,8 +182,6 @@ static void teo_update(struct cpuidle_dr
>  		 */
>  		measured_ns = S64_MAX;
>  	} else {
> -		s64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
> -
>  		measured_ns = dev->last_residency_ns;
>  		/*
>  		 * The delay between the wakeup and the first instruction
> @@ -253,12 +251,17 @@ static void teo_update(struct cpuidle_dr
>  	}
>  
>  	/*
> -	 * If the measured idle duration falls into the same bin as the sleep
> -	 * length, this is a "hit", so update the "hits" metric for that bin.
> +	 * If the measured idle duration (adjusted for the entered state exit
> +	 * latency) falls into the same bin as the sleep length and the latter
> +	 * is less than the "raw" measured idle duration (so the wakeup appears
> +	 * to have occurred after the anticipated timer event), this is a "hit",
> +	 * so update the "hits" metric for that bin.
> +	 *
>  	 * Otherwise, update the "intercepts" metric for the bin fallen into by
>  	 * the measured idle duration.
>  	 */
> -	if (idx_timer == idx_duration) {
> +	if (idx_timer == idx_duration &&
> +	    cpu_data->sleep_length_ns - measured_ns < lat_ns / 2) {
>  		cpu_data->state_bins[idx_timer].hits += PULSE;
>  	} else {
>  		cpu_data->state_bins[idx_duration].intercepts += PULSE;
> 
> 
> 


