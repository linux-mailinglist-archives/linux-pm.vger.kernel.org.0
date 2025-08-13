Return-Path: <linux-pm+bounces-32354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF8B253B9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38881B64596
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FB309DAF;
	Wed, 13 Aug 2025 19:13:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D881CD1F;
	Wed, 13 Aug 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112412; cv=none; b=j6JF7IOl1Rq/FjrLR6VESHyr69/V2gUqPYKrhdwYpV6Rmaw393LTWPr6NialQRKSeWAKn9EUkpTyQr4bzRK76ZhhCoa7zWfFQxtqXZJp6At7EYm/W4QFQW6UKzk80Mvv4pWwZZ25gznwLyrS4oZuZ1X2fOuYILJajAxKnCOPJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112412; c=relaxed/simple;
	bh=SDoJ2outeCJSC9UNYQ9AJNWOM9YgPLCuczdptsJ3k5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USAR/9OPwO31DBPnSwBz6uThBo9BQJu0PPI1pm4s+IFHS9k5NhegQQabA3SPlhOtx+xmfm810QowfEh7kaTtuPddQOrNX9aXyT1Sdt1PtPEBc8km38fxZpB+P7IMUsAf08uy4HBNHJV7U3YoHPxuF5JNYQ+CLhGqizgG6Ix9HIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9FE14BF;
	Wed, 13 Aug 2025 12:13:21 -0700 (PDT)
Received: from [10.1.31.42] (e127648.arm.com [10.1.31.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 329723F738;
	Wed, 13 Aug 2025 12:13:27 -0700 (PDT)
Message-ID: <0da8086f-2b6c-46e3-92ca-e156b9374a2a@arm.com>
Date: Wed, 13 Aug 2025 20:13:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states
 with too much latency
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <5043159.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5043159.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 11:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Occasionally, the exit latency of the idle state selected by the menu
> governor may exceed the PM QoS CPU wakeup latency limit.  Namely, if the
> scheduler tick has been stopped already and predicted_ns is greater than
> the tick period length, the governor may return an idle state whose exit
> latency exceeds latency_req because that decision is made before
> checking the current idle state's exit latency.
> 
> For instance, say that there are 3 idle states, 0, 1, and 2.  For idle
> states 0 and 1, the exit latency is equal to the target residency and
> the values are 0 and 5 us, respectively.  State 2 is deeper and has the
> exit latency and target residency of 200 us and 2 ms (which is greater
> than the tick period length), respectively.
> 
> Say that predicted_ns is equal to TICK_NSEC and the PM QoS latency
> limit is 20 us.  After the first two iterations of the main loop in
> menu_select(), idx becomes 1 and in the third iteration of it the target
Can drop "of it" here?

> residency of the current state (state 2) is greater than predicted_ns.
> State 2 is not a polling one and predicted_ns is not less than TICK_NSEC,
> so the check on whether or not the tick has been stopped is done.  Say
> that the tick has been stopped already and there are no imminent timers
> (that is, delta_tick is greater than the target residency of state 2).
> In that case, idx becomes 2 and it is returned immediately, but the exit
> latency of state 2 exceeds the latency limit.
> 
> Address this issue by modifying the code to compare the exit latency of
> the current idle state (idle state i) with the latency limit before
> comparing its target residecy with predicted_ns, which allows one
residency

> more exit_latency_ns check that becomes redundant to be dropped.
> 
> However, after the above change, latency_req cannot take the predicted_ns
> value any more, which takes place after commit 38f83090f515 ("cpuidle:
> menu: Remove iowait influence"), because it may cause a polling state
> to be returned prematurely.
> 
> In the context of the previous example say that predicted_ns is 3000 and
> the PM QoS latency limit is still 20 us.  Additionally, say that idle
> state 0 is a polling one.  Moving the exit_latency_ns check before the
> target_residency_ns one causes the loop to terminate in the second
> iteration, before the target_residency_ns check, so idle state 0 will be
> returned even though previously state 1 would be returned if there were
> no imminent timers.
> 
> For this reason, remove the assignment of the predicted_ns value to
> latency_req from the code.
> 
> Fixes: 5ef499cd571c ("cpuidle: menu: Handle stopped tick more aggressively")
> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -287,20 +287,15 @@
>  		return 0;
>  	}
>  
> -	if (tick_nohz_tick_stopped()) {
> -		/*
> -		 * If the tick is already stopped, the cost of possible short
> -		 * idle duration misprediction is much higher, because the CPU
> -		 * may be stuck in a shallow idle state for a long time as a
> -		 * result of it.  In that case say we might mispredict and use
> -		 * the known time till the closest timer event for the idle
> -		 * state selection.
> -		 */
> -		if (predicted_ns < TICK_NSEC)
> -			predicted_ns = data->next_timer_ns;
> -	} else if (latency_req > predicted_ns) {
> -		latency_req = predicted_ns;
> -	}
> +	/*
> +	 * If the tick is already stopped, the cost of possible short idle
> +	 * duration misprediction is much higher, because the CPU may be stuck
> +	 * in a shallow idle state for a long time as a result of it.  In that
> +	 * case, say we might mispredict and use the known time till the closest
> +	 * timer event for the idle state selection.
> +	 */
> +	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> +		predicted_ns = data->next_timer_ns;
>  
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
> @@ -316,13 +311,15 @@
>  		if (idx == -1)
>  			idx = i; /* first enabled state */
>  
> +		if (s->exit_latency_ns > latency_req)
> +			break;
> +
>  		if (s->target_residency_ns > predicted_ns) {
>  			/*
>  			 * Use a physical idle state, not busy polling, unless
>  			 * a timer is going to trigger soon enough.
>  			 */
>  			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    s->exit_latency_ns <= latency_req &&
>  			    s->target_residency_ns <= data->next_timer_ns) {
>  				predicted_ns = s->target_residency_ns;
>  				idx = i;
> @@ -354,8 +351,6 @@
>  
>  			return idx;
>  		}
> -		if (s->exit_latency_ns > latency_req)
> -			break;
>  
>  		idx = i;
>  	}
> 
> 
> 

Good catch!
Reviewed-by: Christian Loehle <christian.loehle@arm.com>


