Return-Path: <linux-pm+bounces-12698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C995ACC0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 07:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E971F214C2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6B46556;
	Thu, 22 Aug 2024 05:09:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CE43AC4;
	Thu, 22 Aug 2024 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724303364; cv=none; b=LCjhrCauNTegpqP20qPRlh6NoPkxRFz2idewohnCYnCSwjvvqQMhufmkYFI1dfrxgzs1bOUPFM4ux4yMrSrwz8yXdC9VVJ7DhC2gw2wfjl2/DnPNl0RE5KwxXZirP6/NzIph55A71B5/c/I4OsxLTJi4RiNn5ooVzO0PW7qY0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724303364; c=relaxed/simple;
	bh=4BohM4unqcz+QMGbDy/FyqZD1iDOmZ0pEIkVb96uQew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3C5Ug/E0TVfIBxCF1uFdhvdwZAD3Q6wyF1GAhpEUMSXdUHCOvJJbqARKL32W033GsGPYusg237fXSxfs+zfAc/65/4SpEop+E3X2LnAhSVjYY9NJOOIOOEPk55kYUTLKI/qrz3uSViRJGxwqOEEFZ/NDn1n/1AAWSzYwL1F/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093472356dso240695a34.0;
        Wed, 21 Aug 2024 22:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724303362; x=1724908162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUJHXMxjViKrDRkpIgP/6Ftfa7fylJAO2t0N4RwzwyM=;
        b=LE4RRh/6qwmJbg/lkoPDjvFI+GyPqRAr1hRvrjObDGBlB6+c7Dz/xFV8S5A9J/LbqI
         l9Mh2epKCGADjVzANrhLhkD7XFTGZGIFm43VXPyM4AITI+gegdKDZmgjcNnq1IQCEM2o
         pZV0tkP66r01uuiG72tl4hN1AdQmGFja2wZNT98ikhGHKVsaJqfIPKuwUIidtcL5R8Rk
         VimYvxM0i9adP6tRV7erEh1qghCTrUz/mJuq+G6nfNpH+JtOSBqxPXImbBnyiwWBg6Zs
         NBIxOYe9ye74h96rkMFxjrSfckQxyPMMpLIkSWuDkI8op6SADOi066oCkbU13ZO1b+7Q
         tQwA==
X-Forwarded-Encrypted: i=1; AJvYcCVObmgA0XBHnhIbrGeou933Hfz8kt2sre7xHBgsLCM1cakr4PvYKVGY3kVtNK1eU4116ZVtdPVh0Yk=@vger.kernel.org, AJvYcCWF3OeRKQOGsYpld1ldUb/lZiJftXTyPxa6/uxNjuStlzkIN4yPkpWDNy9BqS/u3NYRdqncFbSUzUDCep4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fEDI7ewg4K6ZYpMaFaKatXlgaQsdgxPuXvpaoDqWrLlhNikP
	Dkt6qQafbGi+nnfP5oZS3KyHsPw3WdByNQ3L3SWaGQ5m3lz69N9AVzyzXwBCKLk=
X-Google-Smtp-Source: AGHT+IEg24FBbgBM+r2H8SVB5Jc5vggpp9DXZ6n1LLhvvL0fDkmOW8E+upWhtXZkPgX9pc+ZoE4/gg==
X-Received: by 2002:a05:6830:4124:b0:703:5cde:3a1f with SMTP id 46e09a7af769-70df872f8e5mr4039515a34.1.1724303361613;
        Wed, 21 Aug 2024 22:09:21 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03b5e84asm159067a34.54.2024.08.21.22.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 22:09:21 -0700 (PDT)
Date: Wed, 21 Aug 2024 22:09:16 -0700
From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/16] sched/fair: Remove magic hardcoded margin in
 fits_capacity()
Message-ID: <ZsbH_EtbOPxtLMU0@sultan-box.localdomain>
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-5-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820163512.1096301-5-qyousef@layalina.io>

Hi Qais,

On Tue, Aug 20, 2024 at 05:35:00PM +0100, Qais Yousef wrote:
> Replace hardcoded margin value in fits_capacity() with better dynamic
> logic.
> 
> 80% margin is a magic value that has served its purpose for now, but it
> no longer fits the variety of systems that exist today. If a system is
> over powered specifically, this 80% will mean we leave a lot of capacity
> unused before we decide to upmigrate on HMP system.
> 
> On many systems the little cores are under powered and ability to
> migrate faster away from them is desired.
> 
> Redefine misfit migration to mean the utilization threshold at which the
> task would become misfit at the next load balance event assuming it
> becomes an always running task.
> 
> To calculate this threshold, we use the new approximate_util_avg()
> function to find out the threshold, based on arch_scale_cpu_capacity()
> the task will be misfit if it continues to run for a TICK_USEC which is
> our worst case scenario for when misfit migration will kick in.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++--------
>  kernel/sched/sched.h |  1 +
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6d35c48239be..402ee4947ef0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8266,6 +8266,7 @@ void __init sched_init(void)
>  		rq->sd = NULL;
>  		rq->rd = NULL;
>  		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> +		rq->fits_capacity_threshold = SCHED_CAPACITY_SCALE;
>  		rq->balance_callback = &balance_push_callback;
>  		rq->active_balance = 0;
>  		rq->next_balance = jiffies;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..e5e986af18dc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -95,11 +95,15 @@ int __weak arch_asym_cpu_priority(int cpu)
>  }
>  
>  /*
> - * The margin used when comparing utilization with CPU capacity.
> - *
> - * (default: ~20%)
> + * fits_capacity() must ensure that a task will not be 'stuck' on a CPU with
> + * lower capacity for too long. This the threshold is the util value at which
> + * if a task becomes always busy it could miss misfit migration load balance
> + * event. So we consider a task is misfit before it reaches this point.
>   */
> -#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
> +static inline bool fits_capacity(unsigned long util, int cpu)
> +{
> +	return util < cpu_rq(cpu)->fits_capacity_threshold;
> +}
>  
>  /*
>   * The margin used when comparing CPU capacities.
> @@ -4978,14 +4982,13 @@ static inline int util_fits_cpu(unsigned long util,
>  				unsigned long uclamp_max,
>  				int cpu)
>  {
> -	unsigned long capacity = capacity_of(cpu);
>  	unsigned long capacity_orig;
>  	bool fits, uclamp_max_fits;
>  
>  	/*
>  	 * Check if the real util fits without any uclamp boost/cap applied.
>  	 */
> -	fits = fits_capacity(util, capacity);
> +	fits = fits_capacity(util, cpu);
>  
>  	if (!uclamp_is_used())
>  		return fits;
> @@ -9592,12 +9595,33 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
>  	unsigned long capacity = scale_rt_capacity(cpu);
>  	struct sched_group *sdg = sd->groups;
> +	struct rq *rq = cpu_rq(cpu);
> +	u64 limit;
>  
>  	if (!capacity)
>  		capacity = 1;
>  
> -	cpu_rq(cpu)->cpu_capacity = capacity;
> -	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> +	rq->cpu_capacity = capacity;
> +	trace_sched_cpu_capacity_tp(rq);
> +
> +	/*
> +	 * Calculate the util at which the task must be considered a misfit.
> +	 *
> +	 * We must ensure that a task experiences the same ramp-up time to
> +	 * reach max performance point of the system regardless of the CPU it
> +	 * is running on (due to invariance, time will stretch and task will
> +	 * take longer to achieve the same util value compared to a task
> +	 * running on a big CPU) and a delay in misfit migration which depends
> +	 * on TICK doesn't end up hurting it as it can happen after we would
> +	 * have crossed this threshold.
> +	 *
> +	 * To ensure that invaraince is taken into account, we don't scale time
> +	 * and use it as-is, approximate_util_avg() will then let us know the
> +	 * our threshold.
> +	 */
> +	limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;

Perhaps it makes more sense to use `capacity` here instead of
`arch_scale_cpu_capacity(cpu)`? Seems like reduced capacity due to HW pressure
(and IRQs + RT util) should be considered, e.g. for a capacity inversion due to
HW pressure on a mid core that results in a little core being faster.

Also, multiplying by the PELT period (1024 us) rather than USEC_PER_MSEC would
be more accurate.

> +	limit -= TICK_USEC; /* sd->balance_interval is more accurate */

I think `limit` could easily wrap here, especially with a 100 Hz tick, and make
it seem like an ultra-slow core (e.g. due to HW pressure) can suddenly fit any
task.

How about `lsub_positive(&limit, TICK_USEC)` instead?

> +	rq->fits_capacity_threshold = approximate_util_avg(0, limit);
>  
>  	sdg->sgc->capacity = capacity;
>  	sdg->sgc->min_capacity = capacity;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 47f158b2cdc2..ab4672675b84 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1093,6 +1093,7 @@ struct rq {
>  	struct sched_domain __rcu	*sd;
>  
>  	unsigned long		cpu_capacity;
> +	unsigned long		fits_capacity_threshold;
>  
>  	struct balance_callback *balance_callback;
>  
> -- 
> 2.34.1
> 

Cheers,
Sultan

