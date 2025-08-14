Return-Path: <linux-pm+bounces-32401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438FB26918
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446EDAA39A6
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC666215793;
	Thu, 14 Aug 2025 14:09:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BB1FF60A;
	Thu, 14 Aug 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180561; cv=none; b=s9bjm+CEkYUlNVjpAJclfoGqcQi2a2r7ckhgqF6tsGJKI2XbIQ6ZqvvyA5jUBi8LEB5GyFqF+Ru54MwUrLh0AhMRVOjOrbGR8kHh/3WxkIGKsDIvL1KoPjKmTKSwwmnBO/bZE7FMpSggD9jA+w2RZwYVgGI0qqBxlA5vl5lXrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180561; c=relaxed/simple;
	bh=u6UoCMTz7eI4baHzDu8yRdrQGijNFLhgrdCAkBIXgfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk/NlQ4KhhhNhEVFSFeOQEjv2Itsc9Sqp1/XDIguSSJIMjrirDLInSc40wIvg0VhtePpL761fP6JnMPu5Arxbye9BMreoNGIVJzKZaoViuIuyqEp5WFbebMSsh0wtJuxoXUWdBamb6Z5ZpX/DV5VMH2Y9Pech9/d5V8hvT/xkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A909168F;
	Thu, 14 Aug 2025 07:09:10 -0700 (PDT)
Received: from [10.1.38.46] (e127648.arm.com [10.1.38.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A67B63F738;
	Thu, 14 Aug 2025 07:09:17 -0700 (PDT)
Message-ID: <9104c434-9025-4365-8127-28014ddddc8d@arm.com>
Date: Thu, 14 Aug 2025 15:09:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full
 CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <2244365.irdbgypaU6@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2244365.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 11:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When the menu governor runs on a nohz_full CPU and there are no user
> space timers in the workload on that CPU, it ends up selecting idle
> states with target residency values above TICK_NSEC all the time due to
> a tick_nohz_tick_stopped() check designed for a different use case.
> Namely, on nohz_full CPUs the fact that the tick has been stopped does
> not actually mean anything in particular, whereas in the other case it
> indicates that previously the CPU was expected to be idle sufficiently
> long for the tick to be stopped, so it is not unreasonable to expect
> it to be idle beyond the tick period length again.
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
>  
>  	/*
> 
> 
> 

OTOH the behaviour with $SUBJECT possibly means that we use predicted_ns from
get_typical_interval() (which may suggest picking a shallow state based on
previous wakeup patterns) only then to never wake up again?

