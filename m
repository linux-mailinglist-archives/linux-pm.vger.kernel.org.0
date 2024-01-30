Return-Path: <linux-pm+bounces-2926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616E841771
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 01:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE24B225CF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875314A98;
	Tue, 30 Jan 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YUdrdMAL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BD2F56
	for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574419; cv=none; b=JtFZSEi7nsK7ZRe+f9QROMdBWDoOZZXSQPKY6jGDoOoXifgWGQoaxmv9QVneQZSDsTOBz0Kte7yvF/MDvJHxTqZcmTl9+ujyNmXkPpI99qNk+mAwvjr04H/l4iSklYPzQu9JVPg1MkLR3LEVPicWer4nKw9yk8VJ9rTUbAeMVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574419; c=relaxed/simple;
	bh=z2PvlQJy6oSu55Ar0+qrueOuia9IRx4cYjiHsPmCbKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLCNx5IY7IqwKz3Eoqh+vUl62kXKLks1pic+u1EA6/iuYmJOOHSjUBoQLzj27YcetCWXDeYOdCDai1nGpb5HFedIyY89M1X9oa6rgUtFFTPKkvVXi3X/DekbA+/W9TSoSNO3loGxXrxiaj0ylPqbEOichSfMclT2vLBvCbk4RV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=YUdrdMAL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40eec4984acso26841995e9.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706574415; x=1707179215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoTHTB8+351LtvZp8jPnaErRIgkgUFGS9zCIdeKBry0=;
        b=YUdrdMALuXpNIHKmT4M3EsL/YH2dZ+m9DtlR2YqiKEEb36ldg/NK+ZIq2/cJqenI1Q
         DCxLwqMJ/m++FxV627exZ2pn1xQtLWB4IXWb9Ail+rnrzpWygPokCQ2pTID1EV6gqBPj
         wb2grmh/v/j2zhCggjO9uVhwgHBW+DvjLbR8lrbZ2NPZ2iY9dtv8iRtmrssnaWp8OJ75
         C5HETPoTAlcW9CfszEZyvs5ns3UF9w2ii0Vy0biLZRjVVfd2H8syyh+P4wMC+c8YTR21
         8R1C9Pct7+xEiJA1CBsdTzuAAVnY4IB1bKkZ2O+ieYZCgWwU2gw6vfgJBX5Magmex6px
         3o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574415; x=1707179215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoTHTB8+351LtvZp8jPnaErRIgkgUFGS9zCIdeKBry0=;
        b=rlRxw/v6zm2oIKPe4+Gsl1VYZzD1EpPT2kc/YkyLG1vyoLpsII9PJjpF+QnnAVw54Z
         iHxBmmPG1sMvo/CgVgimUl7KVuL8EleXzPsIBLRZNzZ9iVXHj68vWScxqVILoXYyqglC
         wDWbQbYZ6L80mmhFi/aIT/in+/SaPKZAB6669dy6VnqO7FYLSJcTzjWKs1DStFx/Vfs+
         b3ymGAjqFF2SsoAIXfbWrKyB1h4BYe2R1WNZaa1lyaxWkKcur5Dg5HihRgoH+LLo4fQc
         6rplSdBsvb5Da0MGMT7pnBHQCB0K+kEyAaBNWIf1PE0gop1VCKLdRvL7Ho0m7uEKAPXF
         if+Q==
X-Gm-Message-State: AOJu0YwgG0sWhX9LdDp8Yho89C2gQ6TxpuLWrr+F77ja5UgX2UWRjm+o
	B5uAQhet94y21xRFyiNb6KYfzOADevtm81sXdC4bEcIZKHdd6Wq/kqRpygGSJrI=
X-Google-Smtp-Source: AGHT+IErDNsPgM+53jLYQa1JKmwsqFgEKm+SIF4elZJgJyMfY1ZqEXDjNiAXRyQHViZAKn/wfHl2FA==
X-Received: by 2002:a5d:6691:0:b0:33a:e8be:51bd with SMTP id l17-20020a5d6691000000b0033ae8be51bdmr3789565wru.51.1706574415100;
        Mon, 29 Jan 2024 16:26:55 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm6611757wrp.20.2024.01.29.16.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:26:54 -0800 (PST)
Date: Tue, 30 Jan 2024 00:26:52 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] sched: Take cpufreq feedback into account
Message-ID: <20240130002652.ipdyqs3sjy6qqt6t@airbuntu>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-3-vincent.guittot@linaro.org>

On 01/09/24 17:46, Vincent Guittot wrote:
> Aggregate the different pressures applied on the capacity of CPUs and
> create a new function that returns the actual capacity of the CPU:
>   get_actual_cpu_capacity()
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9cc20855dc2b..e54bbf8b4936 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4910,13 +4910,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	trace_sched_util_est_se_tp(&p->se);
>  }
>  
> +static inline unsigned long get_actual_cpu_capacity(int cpu)
> +{
> +	unsigned long capacity = arch_scale_cpu_capacity(cpu);
> +
> +	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));

Does cpufreq_get_pressure() reflect thermally throttled frequency, or just the
policy->max being capped by user etc? I didn't see an update to cpufreq when we
topology_update_hw_pressure(). Not sure if it'll go through another path.

maxing with thermal_load_avg() will change the behavior below where we used to
compare against instantaneous pressure. The concern was that it not just can
appear quickly, but disappear quickly too. thermal_load_avg() will decay
slowly, no?  This means we'll lose a lot of opportunities for better task
placement until this decays which can take relatively long time.

So maxing handles the direction where a pressure suddenly appears. But it
doesn't handle where it disappears.

I suspect your thoughts are that if it was transient then thermal_load_avg()
should be small anyway - which I think makes sense.

I think we need a comment to explain these nuance differences.

> +
> +	return capacity;
> +}
> +
>  static inline int util_fits_cpu(unsigned long util,
>  				unsigned long uclamp_min,
>  				unsigned long uclamp_max,
>  				int cpu)
>  {
> -	unsigned long capacity_orig, capacity_orig_thermal;
>  	unsigned long capacity = capacity_of(cpu);
> +	unsigned long capacity_orig;
>  	bool fits, uclamp_max_fits;
>  
>  	/*
> @@ -4948,7 +4957,6 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * goal is to cap the task. So it's okay if it's getting less.
>  	 */
>  	capacity_orig = arch_scale_cpu_capacity(cpu);
> -	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>  
>  	/*
>  	 * We want to force a task to fit a cpu as implied by uclamp_max.
> @@ -5023,7 +5031,8 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * handle the case uclamp_min > uclamp_max.
>  	 */
>  	uclamp_min = min(uclamp_min, uclamp_max);
> -	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> +	if (fits && (util < uclamp_min) &&
> +	    (uclamp_min > get_actual_cpu_capacity(cpu)))
>  		return -1;
>  
>  	return fits;
> @@ -7404,7 +7413,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  		 * Look for the CPU with best capacity.
>  		 */
>  		else if (fits < 0)
> -			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
> +			cpu_cap = get_actual_cpu_capacity(cpu);
>  
>  		/*
>  		 * First, select CPU which fits better (-1 being better than 0).
> @@ -7897,8 +7906,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	struct root_domain *rd = this_rq()->rd;
>  	int cpu, best_energy_cpu, target = -1;
>  	int prev_fits = -1, best_fits = -1;
> -	unsigned long best_thermal_cap = 0;
> -	unsigned long prev_thermal_cap = 0;
> +	unsigned long best_actual_cap = 0;
> +	unsigned long prev_actual_cap = 0;
>  	struct sched_domain *sd;
>  	struct perf_domain *pd;
>  	struct energy_env eenv;
> @@ -7928,7 +7937,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  
>  	for (; pd; pd = pd->next) {
>  		unsigned long util_min = p_util_min, util_max = p_util_max;
> -		unsigned long cpu_cap, cpu_thermal_cap, util;
> +		unsigned long cpu_cap, cpu_actual_cap, util;
>  		long prev_spare_cap = -1, max_spare_cap = -1;
>  		unsigned long rq_util_min, rq_util_max;
>  		unsigned long cur_delta, base_energy;
> @@ -7940,18 +7949,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		if (cpumask_empty(cpus))
>  			continue;
>  
> -		/* Account thermal pressure for the energy estimation */
> +		/* Account external pressure for the energy estimation */
>  		cpu = cpumask_first(cpus);
> -		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> -		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
> +		cpu_actual_cap = get_actual_cpu_capacity(cpu);
>  
> -		eenv.cpu_cap = cpu_thermal_cap;
> +		eenv.cpu_cap = cpu_actual_cap;
>  		eenv.pd_cap = 0;
>  
>  		for_each_cpu(cpu, cpus) {
>  			struct rq *rq = cpu_rq(cpu);
>  
> -			eenv.pd_cap += cpu_thermal_cap;
> +			eenv.pd_cap += cpu_actual_cap;
>  
>  			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>  				continue;
> @@ -8022,7 +8030,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (prev_delta < base_energy)
>  				goto unlock;
>  			prev_delta -= base_energy;
> -			prev_thermal_cap = cpu_thermal_cap;
> +			prev_actual_cap = cpu_actual_cap;
>  			best_delta = min(best_delta, prev_delta);
>  		}
>  
> @@ -8037,7 +8045,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			 * but best energy cpu has better capacity.
>  			 */
>  			if ((max_fits < 0) &&
> -			    (cpu_thermal_cap <= best_thermal_cap))
> +			    (cpu_actual_cap <= best_actual_cap))
>  				continue;
>  
>  			cur_delta = compute_energy(&eenv, pd, cpus, p,
> @@ -8058,14 +8066,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			best_delta = cur_delta;
>  			best_energy_cpu = max_spare_cap_cpu;
>  			best_fits = max_fits;
> -			best_thermal_cap = cpu_thermal_cap;
> +			best_actual_cap = cpu_actual_cap;
>  		}
>  	}
>  	rcu_read_unlock();
>  
>  	if ((best_fits > prev_fits) ||
>  	    ((best_fits > 0) && (best_delta < prev_delta)) ||
> -	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> +	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
>  		target = best_energy_cpu;
>  
>  	return target;
> @@ -9441,8 +9449,8 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>  
>  static unsigned long scale_rt_capacity(int cpu)
>  {
> +	unsigned long max = get_actual_cpu_capacity(cpu);
>  	struct rq *rq = cpu_rq(cpu);
> -	unsigned long max = arch_scale_cpu_capacity(cpu);
>  	unsigned long used, free;
>  	unsigned long irq;
>  
> @@ -9454,12 +9462,9 @@ static unsigned long scale_rt_capacity(int cpu)
>  	/*
>  	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
>  	 * (running and not running) with weights 0 and 1024 respectively.
> -	 * avg_thermal.load_avg tracks thermal pressure and the weighted
> -	 * average uses the actual delta max capacity(load).
>  	 */
>  	used = READ_ONCE(rq->avg_rt.util_avg);
>  	used += READ_ONCE(rq->avg_dl.util_avg);
> -	used += thermal_load_avg(rq);
>  
>  	if (unlikely(used >= max))
>  		return 1;
> -- 
> 2.34.1
> 

