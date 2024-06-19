Return-Path: <linux-pm+bounces-9579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033390EFAE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B22EB236D2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B481509A8;
	Wed, 19 Jun 2024 14:07:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FD15099D;
	Wed, 19 Jun 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806060; cv=none; b=PrwsbCr8xlSrfKPD3ucAxrPeqOdvsgEWdrMXMYufeA2+jr5sEYF1mnMWC+rPyrz2k8QniM+pI67bbUJD2iFcBHdravBv2NZHhokzaACz9cCxl/URi8tsaXBaB1PbUiRToxrAU32bJBKGQ6VROjt0LRVlAs4toY0Z/1Rk6rp7fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806060; c=relaxed/simple;
	bh=2Q4yuKvWndXM8Qy3RAvKx10Ii7y1JROHGaBJL3dGVFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drChtRmtVgbBDojOq0nGHDI/S5UvXuwOw2lMs/qsLmjDmQ2Gha8Kcjgp/bsMRQXJhkx3PrdAM0kpa6lsCyZCIL5Zg8PFCBKNnW0YZnBjcMv2ogMUrmQ6EvLsbGUV3FzpiYbksHpxhGKF9/rhwLBLlfJigS43f5gbyntkya7Ve/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289C11042;
	Wed, 19 Jun 2024 07:08:02 -0700 (PDT)
Received: from [10.1.27.54] (e127648.arm.com [10.1.27.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C673F6A8;
	Wed, 19 Jun 2024 07:07:35 -0700 (PDT)
Message-ID: <0c0073ef-3fe3-4c9f-9a86-5c42336b3da1@arm.com>
Date: Wed, 19 Jun 2024 15:07:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
To: Tejun Heo <tj@kernel.org>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, void@manifault.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@redhat.com,
 peterz@infradead.org, David Vernet <dvernet@meta.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240619031250.2936087-2-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 04:12, Tejun Heo wrote:
> sugov_cpu_is_busy() is used to avoid decreasing performance level while the
> CPU is busy and called by sugov_update_single_freq() and
> sugov_update_single_perf(). Both callers repeat the same pattern to first
> test for uclamp and then the business. Let's refactor so that the tests
> aren't repeated.
> 
> The new helper is named sugov_hold_freq() and tests both the uclamp
> exception and CPU business. No functional changes. This will make adding
> more exception conditions easier.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 38 +++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..972b7dd65af2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -325,16 +325,27 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> -static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> +static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>  {
> -	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> -	bool ret = idle_calls == sg_cpu->saved_idle_calls;
> +	unsigned long idle_calls;
> +	bool ret;
> +
> +	/* if capped by uclamp_max, always update to be in compliance */
> +	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
> +		return false;
> +
> +	/*
> +	 * Maintain the frequency if the CPU has not been idle recently, as
> +	 * reduction is likely to be premature.
> +	 */
> +	idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> +	ret = idle_calls == sg_cpu->saved_idle_calls;
>  
>  	sg_cpu->saved_idle_calls = idle_calls;
>  	return ret;
>  }
>  #else
> -static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> +static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  /*
> @@ -382,14 +393,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>  		return;
>  
>  	next_f = get_next_freq(sg_policy, sg_cpu->util, max_cap);
> -	/*
> -	 * Do not reduce the frequency if the CPU has not been idle
> -	 * recently, as the reduction is likely to be premature then.
> -	 *
> -	 * Except when the rq is capped by uclamp_max.
> -	 */
> -	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> +
> +	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
>  	    !sg_policy->need_freq_update) {
>  		next_f = sg_policy->next_freq;
>  

Not necessarily related to your changes, but in case you're touching this
again, maybe sugov_hold_freq() could be the last condition?
And do we want something like
#ifdef CONFIG_NO_HZ_COMMON                                                      
else
	sg_cpu->saved_idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
#endif
here?

> @@ -436,14 +441,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>  	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
>  		return;
>  
> -	/*
> -	 * Do not reduce the target performance level if the CPU has not been
> -	 * idle recently, as the reduction is likely to be premature then.
> -	 *
> -	 * Except when the rq is capped by uclamp_max.
> -	 */
> -	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> +	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>  		sg_cpu->util = prev_util;
>  
>  	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,

FWIW
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

