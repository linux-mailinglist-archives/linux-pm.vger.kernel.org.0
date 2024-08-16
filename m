Return-Path: <linux-pm+bounces-12365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB816954E12
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1731C21DFB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B06C1BDA95;
	Fri, 16 Aug 2024 15:44:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E561DDF5;
	Fri, 16 Aug 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823092; cv=none; b=FmFlhBuzBCTFZ/3Z4bA2yrRxgMUTcg+TRAokNEFaxzpYVyhyeECN1b3MatI15lQn12wQvstOhh+FSFBpDBcl+SSwEDdbhyDyXRlylgQBx7Fqea4VM1B1Ge0zgmCmwnBVKrOos/leN1/spSpf5VYRqnnxohMScSuGCbndcr58OfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823092; c=relaxed/simple;
	bh=tBkKjcb3zR9bau/RBNoINSy1AhjiSC4Ke/3cqsPMH2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWMp+iz+AcwYOXXrje4cmKwwJBd/FbwagqdCNVAmoDwBjVJMRV6RRA2Zq+kA+Ib9MdcMHktvIcVQ/EHNy3lihbj6MgkUNlommRyP4TCLFGfGIX4wxUjJ93Ug7BdcucsEZkyiemYzAjJ3oHKeU+7rotHvNR4qO6NVolmUp0QiwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF5713D5;
	Fri, 16 Aug 2024 08:45:15 -0700 (PDT)
Received: from [10.1.27.66] (e127648.arm.com [10.1.27.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B802A3F6A8;
	Fri, 16 Aug 2024 08:44:47 -0700 (PDT)
Message-ID: <bfcedd2d-6459-4611-8c4a-08cfdbdfbc5c@arm.com>
Date: Fri, 16 Aug 2024 16:44:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched: cpufreq: Rename map_util_perf to
 sugov_apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240808234415.554937-1-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240808234415.554937-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 00:44, Qais Yousef wrote:
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.
> 
> Also move it to cpufreq_schedutil.c. This function relies on updating
> util signal appropriately to give a headroom to grow. This is tied to
> schedutil and scheduler and not something that can be shared with other
> governors.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
> 
> Changes in v3:
> 
> 	1. Add Reviewed-by from Vincent
> 
> Changes in v2:
> 
> 	1. Add Acked-by from Viresh and Raphael (Thanks!)
> 	2. Move the function to cpufreq_schedutil.c instead of sched.h
> 	3. Name space the function with sugov_ to indicate it is special to
> 	   this governor only and not generic.
> 
>  include/linux/sched/cpufreq.h    |  5 -----
>  kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..d01755d3142f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
>  {
>  	return freq * util / cap;
>  }
> -
> -static inline unsigned long map_util_perf(unsigned long util)
> -{
> -	return util + (util >> 2);
> -}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..575df3599813 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> +/*
> + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> + * continue to grow, which means it could need to run at a higher frequency
> + * before the next decision point was reached. IOW, we can't follow the util as
> + * it grows immediately, but there's a delay before we issue a request to go to
> + * higher frequency. The headroom caters for this delay so the system continues
> + * to run at adequate performance point.
> + *
> + * This function provides enough headroom to provide adequate performance
> + * assuming the CPU continues to be busy.
> + *
> + * At the moment it is a constant multiplication with 1.25.
> + */
> +static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
> +{
> +	return util + (util >> 2);
> +}
> +
>  unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  				 unsigned long min,
>  				 unsigned long max)
>  {
>  	/* Add dvfs headroom to actual utilization */
> -	actual = map_util_perf(actual);
> +	actual = sugov_apply_dvfs_headroom(actual);

Maybe you can even get rid of the comment above now.
sugov_apply_dvfs_headroom(actual) is pretty self-explanatory.

Anyway
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

>  	/* Actually we don't need to target the max performance */
>  	if (actual < max)
>  		max = actual;


