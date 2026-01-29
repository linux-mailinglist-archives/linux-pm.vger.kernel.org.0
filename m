Return-Path: <linux-pm+bounces-41671-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMR9DWsle2nXBgIAu9opvQ
	(envelope-from <linux-pm+bounces-41671-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:16:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42C7AE091
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78FCF301453C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA2E37F8BD;
	Thu, 29 Jan 2026 09:16:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98837F8A9;
	Thu, 29 Jan 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678173; cv=none; b=p7p+ELMf9CW70D28cdbGfo73fZYZ4zPttc1evDrZwAUHoGVKHZmFLl8HEh8ZO+jEpK49pyDo2dy/a9K6N7l/ocFpXHReullakutjU6mU6o/pDZgomMlqeMov+uJTK+6+vEPA9l6Y1tfZHOImRTuBI4uvM7c9UGwYQCbuAWELyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678173; c=relaxed/simple;
	bh=yysg48hJVtkntgBWDj6KpaqsjSKSaBJBPPMari3IL3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzrW4KSLo029MLVWbx0vPHlNWUsPQ+n/dvWU/FzOCV/yAMpdjEmxWoze4Y4S72zEy8DD9WNPUcY416bpZqNb4BdsoW+ko+h4PGiBLtzPGlQVNOe/rLEOnV6MVy7g96GzthoDeL/D1T3FQZV8xd5aw9p1gQbNmk1BFJjJFcuWLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD2711516;
	Thu, 29 Jan 2026 01:15:56 -0800 (PST)
Received: from [10.1.33.27] (e127648.arm.com [10.1.33.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5763B3F73F;
	Thu, 29 Jan 2026 01:16:02 -0800 (PST)
Message-ID: <44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com>
Date: Thu, 29 Jan 2026 09:16:00 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpuidle: governors: teo: Adjust the classification
 of wakeup events
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <12831359.O9o76ZdvQC@rafael.j.wysocki>
 <5079287.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5079287.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41671-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C42C7AE091
X-Rspamd-Action: no action

On 1/26/26 19:45, Rafael J. Wysocki wrote:
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
> For this reason, amend the rule in question with a check that will
> only allow a wakeup event to be counted as a hit if the difference
> between the sleep length and the measured idle duration is less than
> LATENCY_THRESHOLD_NS (which means that the difference between the
> sleep length and the raw measured idle duration is below the sum of
> LATENCY_THRESHOLD_NS and 1/2 of the entered idle state exit latency).
> Otherwise, the event will be counted as an intercept.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1.1 -> v2: No changes
> 
> v1 -> v1.1
>    * Drop the change in teo_select() along with the corresponding
>      part of the changelog (after receiving testing feedback from
>      Christian)
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/4707705.LvFx2qVVIh@rafael.j.wysocki/
> 
> It applies on top of the first three patches from
> 
> https://lore.kernel.org/linux-pm/2257365.irdbgypaU6@rafael.j.wysocki/
> 
> ---
>  drivers/cpuidle/governors/teo.c |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -48,13 +48,11 @@
>   * in accordance with what happened last time.
>   *
>   * The "hits" metric reflects the relative frequency of situations in which the
> - * sleep length and the idle duration measured after CPU wakeup fall into the
> - * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
> - * length).  In turn, the "intercepts" metric reflects the relative frequency of
> - * non-timer wakeup events for which the measured idle duration falls into a bin
> - * that corresponds to an idle state shallower than the one whose bin is fallen
> - * into by the sleep length (these events are also referred to as "intercepts"
> - * below).
> + * sleep length and the idle duration measured after CPU wakeup are close enough
> + * (that is, the CPU appears to wake up "on time" relative to the sleep length).
> + * In turn, the "intercepts" metric reflects the relative frequency of non-timer
> + * wakeup events for which the measured idle duration is measurably less than
> + * the sleep length (these events are also referred to as "intercepts" below).
>   *
>   * The governor also counts "intercepts" with the measured idle duration below
>   * the tick period length and uses this information when deciding whether or not
> @@ -253,12 +251,16 @@ static void teo_update(struct cpuidle_dr
>  	}
>  
>  	/*
> -	 * If the measured idle duration falls into the same bin as the sleep
> -	 * length, this is a "hit", so update the "hits" metric for that bin.
> +	 * If the measured idle duration falls into the same bin as the
> +	 * sleep length and the difference between them is less than
> +	 * LATENCY_THRESHOLD_NS, this is a "hit", so update the "hits"
> +	 * metric for that bin.
> +	 *
>  	 * Otherwise, update the "intercepts" metric for the bin fallen into by
>  	 * the measured idle duration.
>  	 */
> -	if (idx_timer == idx_duration) {
> +	if (idx_timer == idx_duration &&
> +	    cpu_data->sleep_length_ns - measured_ns < LATENCY_THRESHOLD_NS) {

So it needs to be within 7.5us here.
Can we always expect that to be true?
Especially since measured_ns does this "infer average from worst-case exit
latency" handling.
On deeper states this
measured_ns -= lat_ns / 2;
is an order of magnitude higher than our threshold.

So it should probably be something like
exit_latency / 2 + LATENCY_THRESHOLD_NS?
Or just exit_latency and allow the error to both sides?

>  		cpu_data->state_bins[idx_timer].hits += PULSE;
>  	} else {
>  		cpu_data->state_bins[idx_duration].intercepts += PULSE;
> 
> 
> 


