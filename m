Return-Path: <linux-pm+bounces-11659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79E9941024
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915AFB20F76
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8765198A29;
	Tue, 30 Jul 2024 10:59:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933F19580B;
	Tue, 30 Jul 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337187; cv=none; b=QfvaRSi7g67U3sroskaXN734iCKEgWIvOTLaPzg2AI1IHYlnRtBz1tg3kxzUQPpcYN/4THpk2eeuvaT0kOk1B0+lEF8fuA2zXB223YlPe+Lcek1eiKeap57jM7Xpo6F+s/r893rgKutjzYiD1CW0+FSFNVMxN+VB+uDGiIicDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337187; c=relaxed/simple;
	bh=URK6QI3vDLa0iyefj6vXokhC9wnouOKyd1mziAgOj8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKXD6bQgkagtOt52RQq8GxaJD6fwJtkaHwBBacn1403Xa7GW7c1ivdodiQiCAvk0MgRCAkBKqtKlHx2HJ7n5D3vHgciprAfaI3Fg47w38nQSjJvHk09antvhE199EETU7ENCuQBeFSixLOBzOGgglCSULrFxiUq13Pur5aMCWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BE71007;
	Tue, 30 Jul 2024 04:00:10 -0700 (PDT)
Received: from [10.34.111.173] (e126645.nice.Arm.com [10.34.111.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 259F33F5A1;
	Tue, 30 Jul 2024 03:59:43 -0700 (PDT)
Message-ID: <15ad6e0f-a285-4c52-9ce4-d89b9cb371b6@arm.com>
Date: Tue, 30 Jul 2024 12:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: sched/schedutil: Remove LATENCY_MULTIPLIER
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240728192659.58115-1-qyousef@layalina.io>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240728192659.58115-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
Just to provide some background, there was a previous thread on the same topic at:
   https://lore.kernel.org/lkml/20240205022500.2232124-1-qyousef@layalina.io/

Regards,
Pierre

On 7/28/24 21:26, Qais Yousef wrote:
> The current LATENCY_MULTIPLIER which has been around for nearly 20 years
> causes rate_limit_us to be always in ms range.
> 
> On M1 mac mini I get 50 and 56us transition latency, but due to the 1000
> multiplier we end up setting rate_limit_us to 50 and 56ms, which gets
> capped into 2ms and was 10ms before e13aa799c2a6 ("cpufreq: Change
> default transition delay to 2ms")
> 
> On Intel I5 system transition latency is 20us but due to the multiplier
> we end up with 20ms that again is capped to 2ms.
> 
> Given how good modern hardware and how modern workloads require systems
> to be more responsive to cater for sudden changes in workload (tasks
> sleeping/wakeup/migrating, uclamp causing a sudden boost or cap) and
> that 2ms is quarter of the time of 120Hz refresh rate system, drop the
> old logic in favour of providing 50% headroom.
> 
> 	rate_limit_us = 1.5 * latency.
> 
> I considered not adding any headroom which could mean that we can end up
> with infinite back-to-back requests.
> 
> I also considered providing a constant headroom (e.g: 100us) assuming
> that any h/w or f/w dealing with the request shouldn't require a large
> headroom when transition_latency is actually high.
> 
> But for both cases I wasn't sure if h/w or f/w can end up being
> overwhelmed dealing with the freq requests in a potentially busy system.
> So I opted for providing 50% breathing room.
> 
> This is expected to impact schedutil only as the other user,
> dbs_governor, takes the max(2*tick, transition_delay_us) and the former
> was at least 2ms on 1ms TICK, which is equivalent to the max_delay_us
> before applying this patch. For systems with TICK of 4ms, this value
> would have almost always ended up with 8ms sampling rate.
> 
> For systems that report 0 transition latency, we still default to
> returning 1ms as transition delay.
> 
> This helps in eliminating a source of latency for applying requests as
> mentioned in [1]. For example if we have a 1ms tick, most systems will
> miss sending an update at tick when updating the util_avg for a task/CPU
> (rate_limit_us will be 2ms for most systems).
> 
> [1] https://lore.kernel.org/lkml/20240724212255.mfr2ybiv2j2uqek7@airbuntu/
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>   drivers/cpufreq/cpufreq.c | 27 ++++-----------------------
>   include/linux/cpufreq.h   |  6 ------
>   2 files changed, 4 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..f98c9438760c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -575,30 +575,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>   		return policy->transition_delay_us;
>   
>   	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> -	if (latency) {
> -		unsigned int max_delay_us = 2 * MSEC_PER_SEC;
> +	if (latency)
> +		/* Give a 50% breathing room between updates */
> +		return latency + (latency >> 1);
>   
> -		/*
> -		 * If the platform already has high transition_latency, use it
> -		 * as-is.
> -		 */
> -		if (latency > max_delay_us)
> -			return latency;
> -
> -		/*
> -		 * For platforms that can change the frequency very fast (< 2
> -		 * us), the above formula gives a decent transition delay. But
> -		 * for platforms where transition_latency is in milliseconds, it
> -		 * ends up giving unrealistic values.
> -		 *
> -		 * Cap the default transition delay to 2 ms, which seems to be
> -		 * a reasonable amount of time after which we should reevaluate
> -		 * the frequency.
> -		 */
> -		return min(latency * LATENCY_MULTIPLIER, max_delay_us);
> -	}
> -
> -	return LATENCY_MULTIPLIER;
> +	return USEC_PER_MSEC;
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
>   
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d4d2f4d1d7cb..e0e19d9c1323 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -577,12 +577,6 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
>   #define CPUFREQ_POLICY_POWERSAVE	(1)
>   #define CPUFREQ_POLICY_PERFORMANCE	(2)
>   
> -/*
> - * The polling frequency depends on the capability of the processor. Default
> - * polling frequency is 1000 times the transition latency of the processor.
> - */
> -#define LATENCY_MULTIPLIER		(1000)
> -
>   struct cpufreq_governor {
>   	char	name[CPUFREQ_NAME_LEN];
>   	int	(*init)(struct cpufreq_policy *policy);

