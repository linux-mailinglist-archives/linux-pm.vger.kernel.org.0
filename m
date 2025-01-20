Return-Path: <linux-pm+bounces-20689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F6A16C0D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9BE3A2661
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237ED1DF968;
	Mon, 20 Jan 2025 12:08:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43041B87EE;
	Mon, 20 Jan 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374908; cv=none; b=t+/nUmdLEpUTR3aANKJ9ziik+AjXZeXIATRgzHkf+q3Y/QPoXi9OxXmq8N9t9wpmyeOmYF5aIP8O1Q++dbj1lw6mrHRdKhIJj2/fHiOmF7NWbfJ2xXuMKgVB941FF9ZoW8POQjPpb7pgPK9Auaw+BtPasaP96+l5QdVxmgXBBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374908; c=relaxed/simple;
	bh=Qs+lK/VgC1sCiMxRCvcZ6zWcXJPj835RXZ1kuMbioi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmbgkoNfTsD9+A21a5BXQ8XHfcfrOIDokG9I7HuEDlze9vCQ4KDJTa6rowPqczDkQ9/Gpsj+aAlCqSa5oPg0c5xSosZxhzO96vs+VTE51cNOmhPFvLUF8XQplhgCNpJqqyWXE1pf+o5VfL6LRGadaRt85glbKjVSScg28+bWVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330271007;
	Mon, 20 Jan 2025 04:08:53 -0800 (PST)
Received: from [192.168.3.143] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99A173F66E;
	Mon, 20 Jan 2025 04:08:23 -0800 (PST)
Message-ID: <f1f6fe0e-6d6f-442b-87d2-dd15d2e022bc@arm.com>
Date: Mon, 20 Jan 2025 12:08:10 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] cpuidle: teo: Skip getting the sleep length is
 wakeups are very frequent
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <3851791.kQq0lBPeGt@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3851791.kQq0lBPeGt@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

Title has a typo: s/is/if

> Commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length()
> call in some cases") attempted to reduce the governor overhead in some
> cases by making it avoid obtaining the sleep length (the time till the
> next timer event) which may be costly.
> 
> Among other things, after the above commit, tick_nohz_get_sleep_length()
> was not called any more when idle state 0 was to be returned, which
> turned out to be problematic and the previous behavior in that respect
> was restored by commit 4b20b07ce72f ("cpuidle: teo: Don't count non-
> existent intercepts").
> 
> However, commit 6da8f9ba5a87 also caused the governor to avoid calling
> tick_nohz_get_sleep_length() on systems where idle state 0 is a "polling"
> one (that is, it is not really an idle state, but a loop continuously
> executed by the CPU) when the target residency of the idle state to be
> returned was low enough, so there was no practical need to refine the
> idle state selection in any way.  This change was not removed by the
> other commit, so now on systems where idle state 0 is a "polling" one,
> tick_nohz_get_sleep_length() is called when idle state 0 is to be
> returned, but it is not called when a deeper idle state with
> sufficiently low target residency is to be returned.  That is arguably
> confusing and inconsistent.
> 
> Moreover, there is no specific reason why the behavior in question
> should depend on whether or not idle state 0 is a "polling" one.
> 
> One way to address this would be to make the governor always call
> tick_nohz_get_sleep_length() to obtain the sleep length, but that would
> effectively mean reverting commit 6da8f9ba5a87 and restoring the latency
> issue that was the reason for doing it.  This approach is thus not
> particularly attractive.
> 
> To address it differently, notice that if a CPU is woken up very often,
> this is not likely to be caused by timers in the first place (user space
> has a default timer slack of 50 us and there are relatively few timers
> with a deadline shorter than several microseconds in the kernel) and
> even if it were the case, the potential benefit from using a deep idle
> state would then be questionable for latency reasons.  Therefore, if the
> majority of CPU wakeups occur within several microseconds, it can be
> assumed that all wakeups in that range are non-timer and the sleep
> length need not be determined.
> 
> Accordingly, introduce a new metric for counting wakeups with the
> measured idle duration below RESIDENCY_THRESHOLD_NS and modify the idle
> state selection to skip the tick_nohz_get_sleep_length() invocation if
> idle state 0 has been selected or the target residency of the candidate
> idle state is below RESIDENCY_THRESHOLD_NS and the value of the new
> metric is at least 1/2 of the total event count.
> 
> Since the above requires the measured idle duration to be determined
> every time, except for the cases when one of the safety nets has
> triggered in which the wakeup is counted as a hit in the deepest
> idle state idle residency range, update the handling of those cases
> to avoid skipping the idle duration computation when the CPU wakeup
> is "genuine".
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   58 ++++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -129,6 +129,7 @@
>   * @state_bins: Idle state data bins for this CPU.
>   * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
>   * @tick_intercepts: "Intercepts" before TICK_NSEC.
> + * @short_idle: Wakeups after short idle periods.
>   */
>  struct teo_cpu {
>  	s64 time_span_ns;
> @@ -136,6 +137,7 @@
>  	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
>  	unsigned int total;
>  	unsigned int tick_intercepts;
> +	unsigned int short_idle;

Maybe call these short_idles?

>  };
>  
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> @@ -152,12 +154,12 @@
>  	s64 target_residency_ns;
>  	u64 measured_ns;
>  
> -	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
> +	cpu_data->short_idle -= cpu_data->short_idle >> DECAY_SHIFT;
> +
> +	if (cpu_data->time_span_ns < 0) {
>  		/*
> -		 * This causes the wakeup to be counted as a hit regardless of
> -		 * regardless of the real idle duration which doesn't need to be
> -		 * computed because the wakeup has been close enough to an
> -		 * anticipated timer.
> +		 * If one of the safety nets has triggered, assume that this
> +		 * might have been a long sleep.
>  		 */
>  		measured_ns = U64_MAX;
>  	} else {
> @@ -177,10 +179,14 @@
>  		 * time, so take 1/2 of the exit latency as a very rough
>  		 * approximation of the average of it.
>  		 */
> -		if (measured_ns >= lat_ns)
> +		if (measured_ns >= lat_ns) {
>  			measured_ns -= lat_ns / 2;
> -		else
> +			if (measured_ns < RESIDENCY_THRESHOLD_NS)
> +				cpu_data->short_idle += PULSE;
> +		} else {
>  			measured_ns /= 2;
> +			cpu_data->short_idle += PULSE;
> +		}
>  	}
>  
>  	cpu_data->total = 0;
> @@ -419,27 +425,35 @@
>  	if (idx > constraint_idx)
>  		idx = constraint_idx;
>  
> -	if (!idx) {
> -		/*
> -		 * Query the sleep length to be able to count the wakeup as a
> -		 * hit if it is caused by a timer.
> -		 */
> -		cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
> -		goto out_tick;
> -	}
> -
>  	/*
> -	 * If state 0 is a polling one, check if the target residency of
> -	 * the current candidate state is low enough and skip the timers
> -	 * check in that case too.
> +	 * If either the candidate state is state 0 or its target residency is
> +	 * low enough, there is basically nothing more to do, but if the sleep
> +	 * length is not updated, the subsequent wakeup will be counted as an
> +	 * "intercept" which may be problematic in the cases when timer wakeups
> +	 * are dominant.  Namely, it may effectively prevent deeper idle states
> +	 * from being selected at one point even if no imminent timers are
> +	 * scheduled.
> +	 *
> +	 * However, frequent timers in the RESIDENCY_THRESHOLD_NS range on one
> +	 * CPU are unlikely (user space has a default 50 us slack value for
> +	 * hrtimers and there are relatively few timers with a lower deadline
> +	 * value in the kernel), and even if they did happene, the potential

s/happene/happen

> +	 * benefit from using a deep idle state in that case would be
> +	 * questionable anyway for latency reasons.  Thus if the measured idle
> +	 * duration falls into that range in the majority of cases, assume
> +	 * non-timer wakeups to be dominant and skip updating the sleep length
> +	 * to reduce latency.
>  	 */
> -	if ((drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
> -	    drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)
> +	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
> +	    2 * cpu_data->short_idle >= cpu_data->total)
>  		goto out_tick;
>  
>  	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
>  	cpu_data->sleep_length_ns = duration_ns;
>  
> +	if (!idx)
> +		goto out_tick;
> +
>  	/*
>  	 * If the closest expected timer is before the target residency of the
>  	 * candidate state, a shallower one needs to be found.
> @@ -501,7 +515,7 @@
>  	if (dev->poll_time_limit ||
>  	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC)) {
>  		dev->poll_time_limit = false;
> -		cpu_data->time_span_ns = cpu_data->sleep_length_ns;
> +		cpu_data->time_span_ns = KTIME_MIN;
>  	} else {
>  		cpu_data->time_span_ns = local_clock() - cpu_data->time_span_ns;
>  	}
> 

Thanks, I like this approach.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>


