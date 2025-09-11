Return-Path: <linux-pm+bounces-34482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D4B5350B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDFD164961
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B1212B0A;
	Thu, 11 Sep 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd7oOyA6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31417AE1D;
	Thu, 11 Sep 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600280; cv=none; b=A086FUSIHNKyzwWMj3DsYs3X2Dc198hKmIg7DqaXkitj2iOcvUjKl38HS5EZHc6twGg+6MgtGQ1VMbQndYen1X/Lhmxs0AKB3UV+RUMeIjLI3HDQdSGRkoMphiv0tzQ1FHFpavUUvvnYPYhuOWE2VcS41x30j8/vyG8TBwksZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600280; c=relaxed/simple;
	bh=HblPOjZem8RNfqmFhs/s0Ce09qOoWVvo08EXRTZP8lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABVadueR5SC6x5/gYx3zfEbrNQX6P4SvTiUEcSiQtXlPrynUccfkLNG42Jq8lv1aYWBpZ3FsGX7FHRAltRsWOhtbnX25vtnWe8DM5Dxwl+e904HWjgcu64DyVUegvz/TlxoO0gcx6jVOtaAq3bnoTnHdOK3NMz4ui+9QekdnlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd7oOyA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEF4C4CEF0;
	Thu, 11 Sep 2025 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757600278;
	bh=HblPOjZem8RNfqmFhs/s0Ce09qOoWVvo08EXRTZP8lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fd7oOyA6lgB3Gua29I7OyPMYztxzfY367vujWpHxeNLcandWM3Ft/oKdKT2IrYjcI
	 56bjwqfzsaST/osz2unhU+qycUzEujZmWXFyewCDoODQzMMibpFcSdWqdS/f8tjcon
	 QnZ5jq+iyGALNGWqyyKADC0rXLSRvvQqO5Oad45KuEgX6Jz9U8blnt3UYm7dolYZJO
	 4MjXnhcNw636PWwmSTyPUVuDLZhqb7h8c8yqSZMMkZSlEnQLvbhbMF9lOsLsjTqW5o
	 3vFO1ZLNYt5jamqmaljZF32ECeQPFatPU7MjAqB1orLmOjQT77519yk3fjbulE5CN4
	 7HovARcrM69ig==
Date: Thu, 11 Sep 2025 16:17:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full
 CPUs
Message-ID: <aMLaEwBHwiDhgaWM@localhost.localdomain>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <2244365.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2244365.irdbgypaU6@rafael.j.wysocki>

Le Wed, Aug 13, 2025 at 12:29:51PM +0200, Rafael J. Wysocki a écrit :
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When the menu governor runs on a nohz_full CPU and there are no user
> space timers in the workload on that CPU, it ends up selecting idle
> states with target residency values above TICK_NSEC all the time due to
> a tick_nohz_tick_stopped() check designed for a different use case.
>
> Namely, on nohz_full CPUs the fact that the tick has been stopped does
> not actually mean anything in particular, whereas in the other case it
> indicates that previously the CPU was expected to be idle sufficiently
> long for the tick to be stopped, so it is not unreasonable to expect
> it to be idle beyond the tick period length again.

I understand what you mean but it may be hard to figure out for
reviewers. Can we rephrase it to something like:

When nohz_full is not running, the fact that the tick is stopped
indicates the CPU has been idle for sufficiently long so that
nohz has deferred it to the next timer callback. So it is
not unreasonable to expect the CPU to be idle beyond the tick
period length again.

However when nohz_full is running, the CPU may enter idle with the
tick already stopped. But this doesn't tell anything about the future
CPU's idleness.

>   
> In some cases, this behavior causes latency in the workload to grow
> undesirably.  It may also cause the workload to consume more energy
> than necessary if the CPU does not spend enough time in the selected
> deep idle states.
> 
> Address this by amending the tick_nohz_tick_stopped() check in question
> with a tick_nohz_full_cpu() one to avoid using the time till the next
> timer event as the predicted_ns value all the time on nohz_full CPUs.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -293,8 +293,18 @@
>  	 * in a shallow idle state for a long time as a result of it.  In that
>  	 * case, say we might mispredict and use the known time till the closest
>  	 * timer event for the idle state selection.
> +	 *
> +	 * However, on nohz_full CPUs the tick does not run as a rule and the
> +	 * time till the closest timer event may always be effectively infinite,
> +	 * so using it as a replacement for the predicted idle duration would
> +	 * effectively always cause the prediction results to be discarded and
> +	 * deep idle states to be selected all the time.  That might introduce
> +	 * unwanted latency into the workload and cause more energy than
> +	 * necessary to be consumed if the discarded prediction results are
> +	 * actually accurate, so skip nohz_full CPUs here.
>  	 */
> -	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> +	if (tick_nohz_tick_stopped() && !tick_nohz_full_cpu(dev->cpu) &&
> +	    predicted_ns < TICK_NSEC)
>  		predicted_ns = data->next_timer_ns;

So, when !tick_nohz_full_cpu(dev->cpu), what is the purpose of this tick stopped
special case?

Is it because the next dynamic tick is a better prediction than the typical
interval once the tick is stopped?

Does that mean we might become more "pessimistic" concerning the predicted idle
time for nohz_full CPUs?

I guess too shallow C-states are still better than too deep but there should be
a word about that introduced side effect (if any).

Thanks!

>  	/*
> 
> 
> 

-- 
Frederic Weisbecker
SUSE Labs

