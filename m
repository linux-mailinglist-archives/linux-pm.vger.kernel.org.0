Return-Path: <linux-pm+bounces-11380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40CF93B99B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 01:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1E01C23562
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 23:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A6149001;
	Wed, 24 Jul 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DVi2e6CH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C70446DB
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864734; cv=none; b=a32aEKnIUfYbwjsceaExq24STqEpLeIZmFRbvWJ8Dw36LRYNZJlFVDUSd8ZZ/rI+9LrNNLJM4g7ipvHi3JCtc85sO3Q4V2XW4gLQOGsxG9+rK6USWJP1rCBGCeNiwmBEKHQMebwkcRGf4X+Vo0CiINQLjF2MdEWcSSsC4O5/QTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864734; c=relaxed/simple;
	bh=XV0IFg6ce/9ihho5ZDpm6q/TQySjTi95S5bZjrr/V1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAZsmJEDzp/S3mtVPpLuz+cZiKk59csc7Yjv03sl41kZynVVUTt7w2BS+VoYqNSYxzG+e9RUr0hD4iTuiQX2hdP1WSsmRP4dVVOxBzGKlsmBlx9thsjHPAX1p4HBdfwvThUjogX5m0m3Cu/kx5uDUYPT07UGEmnIF3cVldlf1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DVi2e6CH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so2046225e9.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1721864730; x=1722469530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaYWOjAtC8IyqRjHwGJsqiJg8rWJ2bPCwf6+z8osDbQ=;
        b=DVi2e6CHxIK1FX/VC4Yqg3myvSn74z9Ovr+QZ8RJ+J6o36K33DirdW9PzqIOrHYS8d
         aZ1x3aNuTyD/MnWRZr+eWNoS/9Oflpuqn3xhUx0f71u6BkjtgYyMSp07eD3E8xfwjuiT
         ro+bMiVm+ot4QW3HDTBKk1i04AJZiyaTWsZmzggomue2j+E83hVnYCSs10HlitiBo7+V
         HUoxlEbu89XYldsbYLL0B9atzJCiSPL70dYP1S8KjP+Hu47vzTlz4xV8uZNb/clZlug6
         wOgfdcdDVpL4nbjSIcICYpp/xUnT59uQBVwAMbJSeks6TTXQJLgqCAewpBRHvZ3YBzyd
         cY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721864730; x=1722469530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaYWOjAtC8IyqRjHwGJsqiJg8rWJ2bPCwf6+z8osDbQ=;
        b=q9mvioM4jkTuA1wvfHSRZ6z1fN5HlwSUq58UXe3abpVsN5C+IpjVbLm/HYc3+Bxamu
         ekT1bq0OlJIpr34qBgbAyfLrJPNq8IifNC2xFa8IdEIr5c4MeXufFCEVbwJG5I9wN8dW
         LTvkHt2rXoBSsEbeRSxv94hQLUpX5HZTF2s6TsZkE+LXZdyzIPeSRnIvdtprEzoL6LFb
         pbVqrA6eoJjj5UhkIwmIe1Ne5i7hjU5Ar+UXtpLk0cGlsQzMwR8yKUmB3LYLL9H5vsOi
         8lOsCrJdvfOf+eOsNokokTHzxFiZ/dRLGrtzMvKKnqvin/EY6aVfZbAzr9i1P5fPhBwo
         HKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMBj7qh0QVjOZotI6LzlFI6qY3CsYaHTZoKO1ZSHpCxelP2e3KblGaLw3lKM4UMDxTTPgQoJi3xm71jvX8NpdOwpQTGuHUzl0=
X-Gm-Message-State: AOJu0YzmVmFDBKGXAoXxsmj+FO1bqaOOR5PSJOs7WuxLao51f/Sn5k9p
	oxwpQMsk0vTZWWjIRxh58mVJTrMKQSLFLPnnocb3wrmcezoevNVphAKBR5ybRK8=
X-Google-Smtp-Source: AGHT+IFRJ3H1Cftppo2qqAdqI7NZkly6LFO5tZDqqk5kEw/TE4vU0gs4vFW3BQ2yO7botJfZnDHxcg==
X-Received: by 2002:a5d:6181:0:b0:368:5d2:9e58 with SMTP id ffacd0b85a97d-36b35ff25b5mr143556f8f.0.1721864729500;
        Wed, 24 Jul 2024 16:45:29 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e52sm6943055e9.4.2024.07.24.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 16:45:29 -0700 (PDT)
Date: Thu, 25 Jul 2024 00:45:27 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
Message-ID: <20240724234527.6m43t36puktdwn2g@airbuntu>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619031250.2936087-3-tj@kernel.org>

On 06/18/24 17:12, Tejun Heo wrote:
> sched_ext currently does not integrate with schedutil. When schedutil is the
> governor, frequencies are left unregulated and usually get stuck close to
> the highest performance level from running RT tasks.

Have you tried to investigate why is that? By default RT run at max frequency.
Only way to prevent them from doing that is by using uclamp

	https://kernel.org/doc/html/latest/scheduler/sched-util-clamp.html#sched-util-clamp-min-rt-default

If that's not the cause, then it's likely something else is broken.

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

What is exactly the problem you're seeing? You shouldn't need to set
performance directly. Are you trying to fix a problem, or add a new feature?

> 
> This gives direct control over CPU performance setting to the BPF scheduler.

Why would we need to do that?  schedutil is supposed to operate in utilization
signal. Overriding it with custom unknown changes makes it all random governor
based on what's current bpf sched_ext is loaded? This make bug reports and
debugging problems a lot harder.

I do hope by the way that loading external scheduler does cause the kernel to
be tainted. With these random changes, it's hard to know if it is a problem in
the kernel or with external out of tree entity. Out of tree modules taint the
kernel, so should loading sched_ext.

It should not cause spurious reports, nor prevent us from changing the code
without worrying about breaking out of tree code.

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

Why do you need to totally override? What problems did you find in current util
value and what have you done to try to fix it first rather than override it
completely?

> +
>  	/* if capped by uclamp_max, always update to be in compliance */
>  	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>  		return false;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f814e84ceeb3..04fb0eeee5ec 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -16,6 +16,8 @@ enum scx_consts {
>  	SCX_EXIT_BT_LEN			= 64,
>  	SCX_EXIT_MSG_LEN		= 1024,
>  	SCX_EXIT_DUMP_DFL_LEN		= 32768,
> +
> +	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
>  };
>  
>  enum scx_exit_kind {
> @@ -3520,7 +3522,7 @@ DEFINE_SCHED_CLASS(ext) = {
>  	.update_curr		= update_curr_scx,
>  
>  #ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 0,
> +	.uclamp_enabled		= 1,
>  #endif
>  };
>  
> @@ -4393,7 +4395,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	struct scx_task_iter sti;
>  	struct task_struct *p;
>  	unsigned long timeout;
> -	int i, ret;
> +	int i, cpu, ret;
>  
>  	mutex_lock(&scx_ops_enable_mutex);
>  
> @@ -4442,6 +4444,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	atomic_long_set(&scx_nr_rejected, 0);
>  
> +	for_each_possible_cpu(cpu)
> +		cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
> +
>  	/*
>  	 * Keep CPUs stable during enable so that the BPF scheduler can track
>  	 * online CPUs by watching ->on/offline_cpu() after ->init().
> @@ -5835,6 +5840,77 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
>  		ops_dump_flush();
>  }
>  
> +/**
> + * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
> + * @cpu: CPU of interest
> + *
> + * Return the maximum relative capacity of @cpu in relation to the most
> + * performant CPU in the system. The return value is in the range [1,
> + * %SCX_CPUPERF_ONE]. See scx_bpf_cpuperf_cur().
> + */
> +__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
> +{
> +	if (ops_cpu_valid(cpu, NULL))
> +		return arch_scale_cpu_capacity(cpu);
> +	else
> +		return SCX_CPUPERF_ONE;
> +}

Hmm. This is tricky. It looks fine, but I worry about changing how we want to
handle capacities in the future and then being tied down forever with out of
tree sched_ext not being able to load.

How are we going to protect against such potential changes? Just make it a NOP?

A bit hypothetical but so far these are considered internal scheduler details
that could change anytime with no consequence. With this attaching to this info
changing them will become a lot harder as there's external dependencies that
will fail to load or work properly. And what is the regression rule in this
case?

You should make all functions return an error to future proof them against
suddenly disappearing.

> +
> +/**
> + * scx_bpf_cpuperf_cur - Query the current relative performance of a CPU
> + * @cpu: CPU of interest
> + *
> + * Return the current relative performance of @cpu in relation to its maximum.
> + * The return value is in the range [1, %SCX_CPUPERF_ONE].
> + *
> + * The current performance level of a CPU in relation to the maximum performance
> + * available in the system can be calculated as follows:
> + *
> + *   scx_bpf_cpuperf_cap() * scx_bpf_cpuperf_cur() / %SCX_CPUPERF_ONE
> + *
> + * The result is in the range [1, %SCX_CPUPERF_ONE].
> + */
> +__bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
> +{
> +	if (ops_cpu_valid(cpu, NULL))
> +		return arch_scale_freq_capacity(cpu);
> +	else
> +		return SCX_CPUPERF_ONE;
> +}
> +
> +/**
> + * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
> + * @cpu: CPU of interest
> + * @perf: target performance level [0, %SCX_CPUPERF_ONE]
> + * @flags: %SCX_CPUPERF_* flags
> + *
> + * Set the target performance level of @cpu to @perf. @perf is in linear
> + * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
> + * schedutil cpufreq governor chooses the target frequency.
> + *
> + * The actual performance level chosen, CPU grouping, and the overhead and
> + * latency of the operations are dependent on the hardware and cpufreq driver in
> + * use. Consult hardware and cpufreq documentation for more information. The
> + * current performance level can be monitored using scx_bpf_cpuperf_cur().
> + */
> +__bpf_kfunc void scx_bpf_cpuperf_set(u32 cpu, u32 perf)
> +{
> +	if (unlikely(perf > SCX_CPUPERF_ONE)) {
> +		scx_ops_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
> +		return;
> +	}
> +
> +	if (ops_cpu_valid(cpu, NULL)) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		rq->scx.cpuperf_target = perf;
> +
> +		rcu_read_lock_sched_notrace();
> +		cpufreq_update_util(cpu_rq(cpu), 0);
> +		rcu_read_unlock_sched_notrace();
> +	}
> +}

Is the problem that you break how util signal works in sched_ext? Or you want
the fine control? We expect user application to use uclamp to set their perf
requirement. And sched_ext should not break util signal, no? If it does and
there's a good reason for it, then it is not compatible with schedutil, as the
name indicates it operates on util signal as defined in PELT.

You can always use min_freq/max_freq in sysfs to force min and max frequencies
without hacking the governor. I don't advise it though and I'd recommend trying
to be compatible with schedutil as-is rather than modify it. Consistency is
a key.


Thanks

--
Qais Yousef

