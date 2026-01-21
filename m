Return-Path: <linux-pm+bounces-41225-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO4xNiTBcGmKZgAAu9opvQ
	(envelope-from <linux-pm+bounces-41225-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:05:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD95679D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACDCA98417E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F336E490;
	Wed, 21 Jan 2026 11:55:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B83ACA6C;
	Wed, 21 Jan 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996514; cv=none; b=jGsJ1ZZsnqDtJpBCLJsw1O9H/JbxzQbSfK9zzWdS7fZ8BqUqY1+Q6cB8+QSWKnzYFbsB9TZNDaQcD5SYI8dCc70KEfb2IwGgVZSL2idtVulpog4Dz6ytXbbfzpviIv3u807geA2uycV9cCwrX91JYGN1c89oaFct369GAiBA+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996514; c=relaxed/simple;
	bh=mRMudS1zbZN6ftMBL/dMY//gUfo2F4KRmdMkPAiDNHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3tmMCb8b3N1d3+kbZv65HuPUPzHVTOlplipEGt1H/SRZi6fc0u5T6kvFbk+l7GrFrhNMD71U8VvyP3hws2Aa5fCfEp5HxP5GSx8ZDosj3FSbvmvAob2GrJNE/e+/yENsxvo3oEt5NDpEfKAq32nm5pQ5+gWRUnmmPmD9xtWxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7452E1476;
	Wed, 21 Jan 2026 03:55:04 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9813F740;
	Wed, 21 Jan 2026 03:55:09 -0800 (PST)
Message-ID: <a156de2d-a5ad-4e11-8744-24dd07f810a2@arm.com>
Date: Wed, 21 Jan 2026 11:55:07 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpuidle: menu: Add 25% safety margin to short
 predictions when tick is stopped
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
 rafael@kernel.org
Cc: ionut_n2001@yahoo.com, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260120211725.124349-1-sunlightlinux@gmail.com>
 <20260120211725.124349-2-sunlightlinux@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260120211725.124349-2-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[yahoo.com,linaro.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41225-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,arm.com:mid]
X-Rspamd-Queue-Id: 5DAD95679D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 21:17, Ionut Nechita (Sunlight Linux) wrote:
> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> When the tick is already stopped and the predicted idle duration is short
> (< TICK_NSEC), the original code uses next_timer_ns directly. This can be
> too conservative on platforms with high C-state exit latencies.

The other side of the argument is of course that the predicted idle duration
is too short, mostly full of values that are no longer applicable.
Then we're potentially stuck in a too shallow state for a very long time.

> 
> On Intel server platforms (2022+), this causes excessive wakeup latencies
> (~150us) when the actual idle duration is much shorter than next_timer_ns,
> because the governor selects package C-states (PC6) when shallower states
> would be more appropriate.
> 
> Add a 25% safety margin to the prediction instead of using next_timer_ns
> directly, while still clamping to next_timer_ns to avoid selecting
> unnecessarily deep states.

Is this needed?
Why is
min(predicted_ns, data->next_timer_ns);
not enough?
What do the results look like with that?
Again, traces or sysfs dumps pre and post test would be helpful.

> 
> Testing shows this reduces qperf latency from 151us to ~30us on affected
> platforms while maintaining good power efficiency. Platforms with fast
> C-state transitions (Ice Lake: 12us, Skylake: 21us) see minimal impact.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> ---
>  drivers/cpuidle/governors/menu.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 64d6f7a1c776..de1dd46fea7a 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -287,12 +287,20 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	/*
>  	 * If the tick is already stopped, the cost of possible short idle
>  	 * duration misprediction is much higher, because the CPU may be stuck
> -	 * in a shallow idle state for a long time as a result of it.  In that
> -	 * case, say we might mispredict and use the known time till the closest
> -	 * timer event for the idle state selection.
> +	 * in a shallow idle state for a long time as a result of it.
> +	 *
> +	 * Add a 25% safety margin to the prediction to reduce the risk of
> +	 * selecting too shallow state, but clamp to next_timer to avoid
> +	 * selecting unnecessarily deep states.
> +	 *
> +	 * This helps on platforms with high C-state exit latencies (e.g.,
> +	 * Intel server platforms 2022+ with ~150us) where using next_timer
> +	 * directly causes excessive wakeup latency when the actual idle
> +	 * duration is much shorter.
>  	 */
>  	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> -		predicted_ns = data->next_timer_ns;
> +		predicted_ns = min(predicted_ns + (predicted_ns >> 2),
> +				   data->next_timer_ns);
>  
>  	/*
>  	 * Find the idle state with the lowest power while satisfying


