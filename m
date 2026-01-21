Return-Path: <linux-pm+bounces-41233-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJeQCorZcGmraQAAu9opvQ
	(envelope-from <linux-pm+bounces-41233-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 14:50:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EA57EA3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 14:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57ED05A98A0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7C36B06A;
	Wed, 21 Jan 2026 13:39:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFB736404E;
	Wed, 21 Jan 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002758; cv=none; b=Mj80M4PA+Ff7lg+szTn2S32vX95cMvI6BKpcQJNvTxf8OJ1vWlezat2OPdAQtlbOI2DeH/yD6YoGk2j3vq0gTvMiiG/1vobZPO+Xy7w7xy/lsp/EmaIGGYlQxPIqKYCU0OCd7e0uT6XQmgHyv5vlZ1r/KXE3Yp91Vdvl7NNC8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002758; c=relaxed/simple;
	bh=DYfNWTL8rvcMagkuN4nv9R7BvStZ8OEovC3L2PhqdQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXsE2M4EEQWYrECbtPBnaoUQ51YzZylW2ZQGtz1E4KKtq9yA5rnSBZIAKNUlWRkFblzrqeJw3bK5nlOZK++7xthTDtDjjJUJwASKasYpPNJWVQhTqa1Aeyz1GmTsjvrOfB3GV/2/JcV8at/KxBSwwuSegSvv2rphAtmWlcpeMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2B201476;
	Wed, 21 Jan 2026 05:39:08 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759E93F632;
	Wed, 21 Jan 2026 05:39:14 -0800 (PST)
Message-ID: <450effef-57e3-4e2d-ba22-d7bf802ac07a@arm.com>
Date: Wed, 21 Jan 2026 13:39:12 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: menu: Always check timers with
 tick stopped
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <5959091.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5959091.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-41233-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: EF1EA57EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 15:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length()
> call in some cases"), if the return value of get_typical_interval()
> multiplied by NSEC_PER_USEC is not greater than RESIDENCY_THRESHOLD_NS,
> the menu governor will skip computing the time till the closest timer.
> If that happens when the tick has been stopped already, the selected
> idle state may be too deep due to the subsequent check comparing
> predicted_ns with TICK_NSEC and causing its value to be replaced with
> the expected time till the closest timer, which is KTIME_MAX in that
> case.  That will cause the deepest enabled idle state to be selected,
> but the time till the closest timer very well may be shorter than the
> target residency of that state, in which case a shallower state should
> be used.
> 
> Address this by making menu_select() always compute the time till the
> closest timer when the tick has been stopped.
> 
> Also move the predicted_ns check mentioned above into the branch in
> which the time till the closest timer is determined because it only
> needs to be done in that case.
> 
> Fixes: 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -239,7 +239,7 @@ static int menu_select(struct cpuidle_dr
>  
>  	/* Find the shortest expected idle interval. */
>  	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
> -	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
> +	if (predicted_ns > RESIDENCY_THRESHOLD_NS || tick_nohz_tick_stopped()) {
>  		unsigned int timer_us;
>  
>  		/* Determine the time till the closest timer. */
> @@ -259,6 +259,16 @@ static int menu_select(struct cpuidle_dr
>  				   RESOLUTION * DECAY * NSEC_PER_USEC);
>  		/* Use the lowest expected idle interval to pick the idle state. */
>  		predicted_ns = min((u64)timer_us * NSEC_PER_USEC, predicted_ns);
> +		/*
> +		 * If the tick is already stopped, the cost of possible short
> +		 * idle duration misprediction is much higher, because the CPU
> +		 * may be stuck in a shallow idle state for a long time as a
> +		 * result of it.  In that case, say we might mispredict and use
> +		 * the known time till the closest timer event for the idle
> +		 * state selection.
> +		 */
> +		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> +			predicted_ns = data->next_timer_ns;
>  	} else {
>  		/*
>  		 * Because the next timer event is not going to be determined
> @@ -285,16 +295,6 @@ static int menu_select(struct cpuidle_dr
>  	}
>  
>  	/*
> -	 * If the tick is already stopped, the cost of possible short idle
> -	 * duration misprediction is much higher, because the CPU may be stuck
> -	 * in a shallow idle state for a long time as a result of it.  In that
> -	 * case, say we might mispredict and use the known time till the closest
> -	 * timer event for the idle state selection.
> -	 */
> -	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> -		predicted_ns = data->next_timer_ns;
> -
> -	/*
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
>  	 */
> 


Seems I forgot about this, sorry!

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

