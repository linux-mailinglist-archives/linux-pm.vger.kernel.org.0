Return-Path: <linux-pm+bounces-9580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58E90EFB2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206A31C22B8B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37231514C6;
	Wed, 19 Jun 2024 14:07:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49461509BE;
	Wed, 19 Jun 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806078; cv=none; b=Awj4QVm/hrGzzA6fgHMDbcCS86crt47XYLEKTLqwtqhFU8MpADjm8DD+D7rcuXAPB3aatYDaUqw6RSpBqCfZotlX46jzbLNwJ6bq+sTdkVdNDFf42xO/isQMmtJVzK0Ft2aaEa1GCJiKIwb6TVTshn1k30iEufNkcTpQSgenEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806078; c=relaxed/simple;
	bh=/GeAzgFgTEL+Mkv2D0OwJr+Gtr7uGUR1FjMqEWN4V3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnfUAi4hcZ6+FyYTUpGM11skAqRHynb+oUuqpaQu0kW5lzXRIzonqZaRczbPC316Zyyb5XmJiAgU78OvnGH7dAwVNnrSEhYN3qwC3RGrFE3ZQQMHiSWjH3UzjPUEBMYRhJbcLeLkcr8TH12GAjznPgFkb+vD20/OiRTaXdrgPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01AD31042;
	Wed, 19 Jun 2024 07:08:21 -0700 (PDT)
Received: from [10.1.27.54] (e127648.arm.com [10.1.27.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 842713F6A8;
	Wed, 19 Jun 2024 07:07:53 -0700 (PDT)
Message-ID: <b32a658d-27fd-4f61-8f6f-58fa71af30c8@arm.com>
Date: Wed, 19 Jun 2024 15:07:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, void@manifault.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@redhat.com,
 peterz@infradead.org, David Vernet <dvernet@meta.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240619031250.2936087-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 04:12, Tejun Heo wrote:
> sched_ext currently does not integrate with schedutil. When schedutil is the
> governor, frequencies are left unregulated and usually get stuck close to
> the highest performance level from running RT tasks.
> 
> Add CPU performance monitoring and scaling support by integrating into
> schedutil. The following kfuncs are added:
> 
> - scx_bpf_cpuperf_cap(): Query the relative performance capacity of
>   different CPUs in the system.
> 
> - scx_bpf_cpuperf_cur(): Query the current performance level of a CPU
>   relative to its max performance.
> 
> - scx_bpf_cpuperf_set(): Set the current target performance level of a CPU.
> 
> This gives direct control over CPU performance setting to the BPF scheduler.
> The only changes on the schedutil side are accounting for the utilization
> factor from sched_ext and disabling frequency holding heuristics as it may
> not apply well to sched_ext schedulers which may have a lot weaker
> connection between tasks and their current / last CPU.
> 
> With cpuperf support added, there is no reason to block uclamp. Enable while
> at it.
> 
> A toy implementation of cpuperf is added to scx_qmap as a demonstration of
> the feature.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c         |  12 +-
>  kernel/sched/ext.c                       |  83 ++++++++++++-
>  kernel/sched/ext.h                       |   9 ++
>  kernel/sched/sched.h                     |   1 +
>  tools/sched_ext/include/scx/common.bpf.h |   3 +
>  tools/sched_ext/scx_qmap.bpf.c           | 142 ++++++++++++++++++++++-
>  tools/sched_ext/scx_qmap.c               |   8 ++
>  7 files changed, 252 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 972b7dd65af2..12174c0137a5 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -197,7 +197,9 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  
>  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
> -	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> +	unsigned long min, max;
> +	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu) +
> +		scx_cpuperf_target(sg_cpu->cpu);

What does cpu_util_cfs_boost() contain if scx is active?
NIT: reverse xmas

>  
>  	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>  	util = max(util, boost);
> @@ -330,6 +332,14 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>  	unsigned long idle_calls;
>  	bool ret;
>  
> +	/*
> +	 * The heuristics in this function is for the fair class. For SCX, the
> +	 * performance target comes directly from the BPF scheduler. Let's just
> +	 * follow it.
> +	 */
> +	if (scx_switched_all())
> +		return false;
> +
> [SNIP]


