Return-Path: <linux-pm+bounces-20691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3EA16C38
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 13:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50A43A59AF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EAF1DF743;
	Mon, 20 Jan 2025 12:16:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEB1993A3;
	Mon, 20 Jan 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375410; cv=none; b=ObRTFr8aJG2GEb76V8WHc1AAVV0SemyJ65TjnTo4jKpbqJCMoJSPKuZEEdYfR7NztXRlA3dBazL5cMMfeFor3Us3pJO9TitSB9Z93hpQM8/vAMwTRzVxTpWdxO1BQ/mH0hMswdD+VJSJ4E5FPKb4QP4xVO/w+PKEmpLOVJvD3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375410; c=relaxed/simple;
	bh=ew2g4KlRUBdsxCBF8LWRT0rkfrRgjxP8MZUdqD/YzXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gp/S20nfs2J5G97uN51seYB01NMeqYHmVEk6+CR517qpZpmMgYHX+9I1u/f5g5DwFvxRHTCmpFuJ3ARIOIua2qz1drnHbuQpJ4zYS54AdDZa5NY1FsnO+FpHFNwXo39Oujc5OfNIXR95X8tf+kPyLbG9taipW8YjNMC1MdUKaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC35106F;
	Mon, 20 Jan 2025 04:17:16 -0800 (PST)
Received: from [192.168.3.143] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068383F66E;
	Mon, 20 Jan 2025 04:16:46 -0800 (PST)
Message-ID: <c55e5fa8-a747-4a77-8889-93b4f42bd5c3@arm.com>
Date: Mon, 20 Jan 2025 12:16:45 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] cpuidle: teo: Replace time_span_ns with a flag
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <6010475.MhkbZ0Pkbq@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6010475.MhkbZ0Pkbq@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent updates, the time_span_ns field in struct teo_cpu has
> become an indicator on whether or not the most recent wakeup has been
> "genuine" which may as well be indicated by a bool field without
> calling local_clock(), so update the code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -124,20 +124,20 @@
>  
>  /**
>   * struct teo_cpu - CPU data used by the TEO cpuidle governor.
> - * @time_span_ns: Time between idle state selection and post-wakeup update.
>   * @sleep_length_ns: Time till the closest timer event (at the selection time).
>   * @state_bins: Idle state data bins for this CPU.
>   * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
>   * @tick_intercepts: "Intercepts" before TICK_NSEC.
>   * @short_idle: Wakeups after short idle periods.
> + * @artificial_wakeup: Set if the wakeup has been triggered by a safety net.
>   */
>  struct teo_cpu {
> -	s64 time_span_ns;
>  	s64 sleep_length_ns;
>  	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
>  	unsigned int total;
>  	unsigned int tick_intercepts;
>  	unsigned int short_idle;
> +	bool artificial_wakeup;
>  };
>  
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> @@ -156,7 +156,7 @@
>  
>  	cpu_data->short_idle -= cpu_data->short_idle >> DECAY_SHIFT;
>  
> -	if (cpu_data->time_span_ns < 0) {
> +	if (cpu_data->artificial_wakeup) {
>  		/*
>  		 * If one of the safety nets has triggered, assume that this
>  		 * might have been a long sleep.
> @@ -165,13 +165,6 @@
>  	} else {
>  		u64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
>  
> -		/*
> -		 * The computations below are to determine whether or not the
> -		 * (saved) time till the next timer event and the measured idle
> -		 * duration fall into the same "bin", so use last_residency_ns
> -		 * for that instead of time_span_ns which includes the cpuidle
> -		 * overhead.
> -		 */
>  		measured_ns = dev->last_residency_ns;
>  		/*
>  		 * The delay between the wakeup and the first instruction
> @@ -286,7 +279,6 @@
>  		dev->last_state_idx = -1;
>  	}
>  
> -	cpu_data->time_span_ns = local_clock();
>  	/*
>  	 * Set the sleep length to infitity in case the invocation of

You're not touching this here, but might as well fix the infitity
typo with the series.

>  	 * tick_nohz_get_sleep_length() below is skipped, in which case it won't
> @@ -504,17 +496,16 @@
>  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>  
>  	dev->last_state_idx = state;
> -	/*
> -	 * If the wakeup was not "natural", but triggered by one of the safety
> -	 * nets, assume that the CPU might have been idle for the entire sleep
> -	 * length time.
> -	 */
>  	if (dev->poll_time_limit ||
>  	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC)) {
> +		/*
> +		 * The wakeup was not "geniune", but triggered by one of the

s/geniune/genuine

> +		 * safety nets.
> +		 */
>  		dev->poll_time_limit = false;
> -		cpu_data->time_span_ns = KTIME_MIN;
> +		cpu_data->artificial_wakeup = true;
>  	} else {
> -		cpu_data->time_span_ns = local_clock() - cpu_data->time_span_ns;
> +		cpu_data->artificial_wakeup = false;
>  	}

You could rewrite this without the else by just setting it to false before the if.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

