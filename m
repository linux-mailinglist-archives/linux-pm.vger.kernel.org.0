Return-Path: <linux-pm+bounces-48-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2F57F3432
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 17:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45461C21D02
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B851C3E;
	Tue, 21 Nov 2023 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="gaHcTXh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5340E100
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 08:48:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so23660805e9.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700585324; x=1701190124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl6jzCpJc5F+w+WFK8foUYFSJQiUHkYrw+vDeVrDCAo=;
        b=gaHcTXh3pJK+6m2qUIAgeAzOsA3X6F0eZlaQdFAyjXoxqrpQO8So/F5uwUUWLXHDJC
         J+7aQG13G/WcCLdxPCmuJWVESaCa3qPcnhIporslDPpBPax3+cNknQafkNW5H0X/NeNX
         kNummQht3z5Pm/XxWIOvI7zfzVJV+owBVcwWnTpnz0Nzeu9Yj+YPcHMQ2GuQlaqQSpOS
         nCVBFSaYGPQhgAo19eqnFSVYzHR6mKTEMzAfWjtcUuIl0fc3SP9T3REKgl8eU1Qt3F+d
         as4rXPOSYXY0fDb8dVBvdsVovyIhW+vO6whK5bFDwpnOgCpOfDaIrPCvFl0kGK5I85Yg
         YWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700585324; x=1701190124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl6jzCpJc5F+w+WFK8foUYFSJQiUHkYrw+vDeVrDCAo=;
        b=fjsMWJasr7EopBYV/I/9Iy+KDltadKZUVx0A09nCTqwmmBJsjxXZqxnMXRlDC/ceLq
         Q3Y01eX4ACw8gPFw6txAttLCkrrBlhnjnrCGLAYCXPAGCDR85GpUO7XIzVjMPWDRJECn
         8ijMa6dceybazapfFgm2kkicang2UQ73CEoeOFZfuTteIBalItO/qp78qldP4ZaqcbzO
         X76euntBg+YQe/jgedcMfiNiZLVgsHZjVs/56yYEpNZIgWBckgOxAgV/cv90GGcUSgK8
         i2L3D27osXkyI41ByMVrB+Vczfo5wCRBHH7p40OMN5LYokfVHBLgZ3ej02JyzRzDRpEh
         C12w==
X-Gm-Message-State: AOJu0YzhbYvJ7k84ydqJZwhiR9Owrhxo2sKTO7km0L/6hyU0QTQPni+N
	NilWbvH2Q9W/nMHQXxsCrXn/hQ==
X-Google-Smtp-Source: AGHT+IG4dX7H/wqKA+5EWhJPHEt3WhqgO8tiLLdqJWn9aVJj7sNqBLUK1KzJFtvHSv6RGb7mUmrDJQ==
X-Received: by 2002:a05:600c:a4c:b0:40a:4609:9c90 with SMTP id c12-20020a05600c0a4c00b0040a46099c90mr9626807wmq.29.1700585323529;
        Tue, 21 Nov 2023 08:48:43 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b0040a43d458c9sm21640037wml.25.2023.11.21.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:48:43 -0800 (PST)
Date: Tue, 14 Nov 2023 20:59:38 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 2/2] sched/schedutil: Rework iowait boost
Message-ID: <20231114205938.kspmq6rtidwdsu4f@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103131821.1176294-3-vincent.guittot@linaro.org>
X-Spam-Level: *

On 11/03/23 14:18, Vincent Guittot wrote:
> Use the max value that has already been computed inside sugov_get_util()
> to cap the iowait boost and remove dependency with uclamp_rq_util_with()
> which is not used anymore.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>

I didn't get a chance to reproduce the original issue I've seen with iowait
boost to test this, but will do and confirm back.


Thanks!

--
Qais Yousef

>  kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
>  kernel/sched/sched.h             | 60 --------------------------------
>  2 files changed, 14 insertions(+), 75 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 38accd8c854b..068c895517fb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -174,11 +174,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  	return max(min, max);
>  }
>  
> -static void sugov_get_util(struct sugov_cpu *sg_cpu)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
>  	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
>  
>  	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> +	util = max(util, boost);
>  	sg_cpu->bw_min = map_util_perf(min);
>  	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>  }
> @@ -271,18 +272,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * This mechanism is designed to boost high frequently IO waiting tasks, while
>   * being more conservative on tasks which does sporadic IO operations.
>   */
> -static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  			       unsigned long max_cap)
>  {
> -	unsigned long boost;
> -
>  	/* No boost currently required */
>  	if (!sg_cpu->iowait_boost)
> -		return;
> +		return 0;
>  
>  	/* Reset boost if the CPU appears to have been idle enough */
>  	if (sugov_iowait_reset(sg_cpu, time, false))
> -		return;
> +		return 0;
>  
>  	if (!sg_cpu->iowait_boost_pending) {
>  		/*
> @@ -291,7 +290,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  		sg_cpu->iowait_boost >>= 1;
>  		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
>  			sg_cpu->iowait_boost = 0;
> -			return;
> +			return 0;
>  		}
>  	}
>  
> @@ -301,10 +300,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  	 * sg_cpu->util is already in capacity scale; convert iowait_boost
>  	 * into the same scale so we can compare.
>  	 */
> -	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
> -	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
> -	if (sg_cpu->util < boost)
> -		sg_cpu->util = boost;
> +	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -334,6 +330,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  					      u64 time, unsigned long max_cap,
>  					      unsigned int flags)
>  {
> +	unsigned long boost;
> +
>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
> @@ -342,8 +340,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>  		return false;
>  
> -	sugov_get_util(sg_cpu);
> -	sugov_iowait_apply(sg_cpu, time, max_cap);
> +	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
> +	sugov_get_util(sg_cpu, boost);
>  
>  	return true;
>  }
> @@ -444,9 +442,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  
>  	for_each_cpu(j, policy->cpus) {
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> +		unsigned long boost;
>  
> -		sugov_get_util(j_sg_cpu);
> -		sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		sugov_get_util(j_sg_cpu, boost);
>  
>  		util = max(j_sg_cpu->util, util);
>  	}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 302b451a3fd8..e3cb8e004bd1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3025,59 +3025,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
>  	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
>  }
>  
> -/**
> - * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
> - * @rq:		The rq to clamp against. Must not be NULL.
> - * @util:	The util value to clamp.
> - * @p:		The task to clamp against. Can be NULL if you want to clamp
> - *		against @rq only.
> - *
> - * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
> - *
> - * If sched_uclamp_used static key is disabled, then just return the util
> - * without any clamping since uclamp aggregation at the rq level in the fast
> - * path is disabled, rendering this operation a NOP.
> - *
> - * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
> - * will return the correct effective uclamp value of the task even if the
> - * static key is disabled.
> - */
> -static __always_inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -				  struct task_struct *p)
> -{
> -	unsigned long min_util = 0;
> -	unsigned long max_util = 0;
> -
> -	if (!static_branch_likely(&sched_uclamp_used))
> -		return util;
> -
> -	if (p) {
> -		min_util = uclamp_eff_value(p, UCLAMP_MIN);
> -		max_util = uclamp_eff_value(p, UCLAMP_MAX);
> -
> -		/*
> -		 * Ignore last runnable task's max clamp, as this task will
> -		 * reset it. Similarly, no need to read the rq's min clamp.
> -		 */
> -		if (uclamp_rq_is_idle(rq))
> -			goto out;
> -	}
> -
> -	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
> -	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
> -out:
> -	/*
> -	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
> -	 * RUNNABLE tasks with _different_ clamps, we can end up with an
> -	 * inversion. Fix it now when the clamps are applied.
> -	 */
> -	if (unlikely(min_util >= max_util))
> -		return min_util;
> -
> -	return clamp(util, min_util, max_util);
> -}
> -
>  /* Is the rq being capped/throttled by uclamp_max? */
>  static inline bool uclamp_rq_is_capped(struct rq *rq)
>  {
> @@ -3115,13 +3062,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
>  	return SCHED_CAPACITY_SCALE;
>  }
>  
> -static inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -				  struct task_struct *p)
> -{
> -	return util;
> -}
> -
>  static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
>  
>  static inline bool uclamp_is_used(void)
> -- 
> 2.34.1
> 

