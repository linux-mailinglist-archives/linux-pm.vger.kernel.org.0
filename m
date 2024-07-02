Return-Path: <linux-pm+bounces-10333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DDB923B54
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797E3281279
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D715821D;
	Tue,  2 Jul 2024 10:24:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB6154449;
	Tue,  2 Jul 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915845; cv=none; b=C+XnbTCWW9zJ5K3s+LdT9DPWTzmYGQGKSG+60dO1a+35U4FUQZOZKpf8EMbulnOgQWbDv2HHzZtjq0gbVtdo2lBdlt09MarWvTqywpDeQ5/HSi62aUsDfj799YJWLVqhz68vBgjysrr7grciIU6/bC6Inuy463TqynfjPQNsQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915845; c=relaxed/simple;
	bh=ATd5VV0LncNUb8HTNw6yZa2RlrvTq5uy/ZnS4DU0H50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZd3kWu8GPB4pbZ99CarAtOZBbkkSE5MSQVraRpm31sQVUjEzEA2nfA3JQeuOvSxwCgIcHsOr34e8OeZAz5uA/gRLTb8rx8ozNB2rSBxfkQM2BxyhKpAIdsdqWdqxWnDxERx4XJ8HS58/w2xtIa0V+QMgGst41Nk2eMqH2wJl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA864339;
	Tue,  2 Jul 2024 03:24:26 -0700 (PDT)
Received: from [10.1.34.77] (e133649.arm.com [10.1.34.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11BA53F762;
	Tue,  2 Jul 2024 03:23:59 -0700 (PDT)
Message-ID: <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>
Date: Tue, 2 Jul 2024 11:23:58 +0100
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
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240619031250.2936087-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/06/2024 04:12, Tejun Heo wrote:
> sched_ext currently does not integrate with schedutil. When schedutil is the
> governor, frequencies are left unregulated and usually get stuck close to
> the highest performance level from running RT tasks.
> 
> Add CPU performance monitoring and scaling support by integrating into
> schedutil. The following kfuncs are added:
> 
> - scx_bpf_cpuperf_cap(): Query the relative performance capacity of
>    different CPUs in the system.
> 
> - scx_bpf_cpuperf_cur(): Query the current performance level of a CPU
>    relative to its max performance.
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
>   kernel/sched/cpufreq_schedutil.c         |  12 +-
>   kernel/sched/ext.c                       |  83 ++++++++++++-
>   kernel/sched/ext.h                       |   9 ++
>   kernel/sched/sched.h                     |   1 +
>   tools/sched_ext/include/scx/common.bpf.h |   3 +
>   tools/sched_ext/scx_qmap.bpf.c           | 142 ++++++++++++++++++++++-
>   tools/sched_ext/scx_qmap.c               |   8 ++
>   7 files changed, 252 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 972b7dd65af2..12174c0137a5 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -197,7 +197,9 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>   
>   static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>   {
> -	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> +	unsigned long min, max;
> +	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu) +
> +		scx_cpuperf_target(sg_cpu->cpu);
>   
>   	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>   	util = max(util, boost);
> @@ -330,6 +332,14 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>   	unsigned long idle_calls;
>   	bool ret;
>   
> +	/*
> +	 * The heuristics in this function is for the fair class. For SCX, the
> +	 * performance target comes directly from the BPF scheduler. Let's just
> +	 * follow it.
> +	 */
> +	if (scx_switched_all())
> +		return false;
> +
>   	/* if capped by uclamp_max, always update to be in compliance */
>   	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>   		return false;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f814e84ceeb3..04fb0eeee5ec 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -16,6 +16,8 @@ enum scx_consts {
>   	SCX_EXIT_BT_LEN			= 64,
>   	SCX_EXIT_MSG_LEN		= 1024,
>   	SCX_EXIT_DUMP_DFL_LEN		= 32768,
> +
> +	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
>   };
>   
>   enum scx_exit_kind {
> @@ -3520,7 +3522,7 @@ DEFINE_SCHED_CLASS(ext) = {
>   	.update_curr		= update_curr_scx,
>   
>   #ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 0,
> +	.uclamp_enabled		= 1,
>   #endif
>   };
>   

Hi. I know this is a bit late, but the implication of this change here 
can be quite interesting.

With this patch but without switching this knob from 0 to 1, this series 
gives me the perfect opportunity to implement a custom uclamp within 
sched_ext on top of the cpufreq support added. I think this would be 
what some vendors looking at sched_ext would also want. But, if 
.uclamp_enabled == 1, then the mainline uclamp implementation is in 
effect regardless of what ext scheduler is loaded. In fact, 
uclamp_{inc,dec}() are before calling the {enqueue,dequeue}_task() so 
now there's no easy way to circumvent it.

What would be really nice is to have cpufreq support in sched_ext but 
not force uclamp_enabled. But, I also think there will be people who are 
happy with the current uclamp implementation and want to just reuse it. 
The best thing is to let the loaded scheduler decide, somehow, which I 
don't know if there's an easy way to do this yet.

> [...]

