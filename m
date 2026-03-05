Return-Path: <linux-pm+bounces-43672-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIlQHL1fqWlc6QAAu9opvQ
	(envelope-from <linux-pm+bounces-43672-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:49:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E378320FF6D
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9850E303FF24
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D6382F1B;
	Thu,  5 Mar 2026 10:45:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D341382368;
	Thu,  5 Mar 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707510; cv=none; b=evFCZEubQ/T6jqchVhUkEzocnNw7sd+dH9uRWZC3ESxK0csFvI5PAHiFzb0HWv5qofEko32zXFA0obhmTOB+MLb/WPZWuulGDMkSzzBJRCSLgKtvh6EYWrWz4+ZSjkpGrhdO69tQdTjVNabXpISIYfLvXkLl/I+SZYyYvHmG1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707510; c=relaxed/simple;
	bh=cp7M0amZMG8VXemTzT/YT4j3UYVhVjUnnBuFTxD/0oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g60kaJap6AFoVGpz47lFR/53+EqKApeelkXZ4HCvdh7roRBmoXTbc9FF9yRgouZF1RLnDyIbV8kDbwzzT9PUBcXUOFZSEI3WNKof8t0pqNrpAGmFqS2VCke98lyPtBhB6pM3gO6MQAiwimQ4uUHNBvSBAvhYbCnE3hL86b5Ws6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360B3339;
	Thu,  5 Mar 2026 02:45:01 -0800 (PST)
Received: from [10.1.38.68] (unknown [10.1.38.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A53423F694;
	Thu,  5 Mar 2026 02:45:06 -0800 (PST)
Message-ID: <ecbe0643-ce7f-4e67-a07c-01d8e6fc758c@arm.com>
Date: Thu, 5 Mar 2026 10:45:05 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpuidle: governors: menu: Refine stopped tick
 handling
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
References: <3693525.iIbC2pHGDl@rafael.j.wysocki>
 <3341782.5fSG56mABF@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3341782.5fSG56mABF@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E378320FF6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,telus.net,linux.ibm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-43672-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid,arm.com:email]
X-Rspamd-Action: no action

On 2/23/26 15:38, Rafael J. Wysocki wrote:
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
> Update the menu governor in accordance with the above and use twice
> the tick period length as the "safe timer range" for allowing the
> original predicted_ns value to be used even if the tick has been
> stopped.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: No changes
> 
> ---
>  drivers/cpuidle/governors/gov.h  |    5 +++++
>  drivers/cpuidle/governors/menu.c |   15 +++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> --- a/drivers/cpuidle/governors/gov.h
> +++ b/drivers/cpuidle/governors/gov.h
> @@ -10,5 +10,10 @@
>   * check the time till the closest expected timer event.
>   */
>  #define RESIDENCY_THRESHOLD_NS	(15 * NSEC_PER_USEC)
> +/*
> + * If the closest timer is in this range, the governor idle state selection need
> + * not be adjusted after the scheduler tick has been stopped.
> + */
> +#define SAFE_TIMER_RANGE_NS	(2 * TICK_NSEC)
>  
>  #endif /* __CPUIDLE_GOVERNOR_H */
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -261,13 +261,16 @@ static int menu_select(struct cpuidle_dr
>  		predicted_ns = min((u64)timer_us * NSEC_PER_USEC, predicted_ns);
>  		/*
>  		 * If the tick is already stopped, the cost of possible short
> -		 * idle duration misprediction is much higher, because the CPU
> -		 * may be stuck in a shallow idle state for a long time as a
> -		 * result of it.  In that case, say we might mispredict and use
> -		 * the known time till the closest timer event for the idle
> -		 * state selection.
> +		 * idle duration misprediction is higher because the CPU may get
> +		 * stuck in a shallow idle state then.  To avoid that, if
> +		 * predicted_ns is small enough, say it might be mispredicted
> +		 * and use the known time till the closest timer for idle state
> +		 * selection unless that timer is going to trigger within
> +		 * SAFE_TIMER_RANGE_NS in which case it can be regarded as a
> +		 * sufficient safety net.
>  		 */
> -		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> +		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC &&
> +		    data->next_timer_ns > SAFE_TIMER_RANGE_NS)
>  			predicted_ns = data->next_timer_ns;
>  	} else {
>  		/*
> 
> 
> 

So FWIW both patches look sane to me, I'm still trying to get some test setup
to see what this looks like and should look like, but for now:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

