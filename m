Return-Path: <linux-pm+bounces-9616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D990F577
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64DF281EDA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907915623B;
	Wed, 19 Jun 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="E4tTfNEZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338B558B7
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819364; cv=none; b=PZPmr/vSkBaXd1NyR7je3yR0lmW3w3kfKJaNZZBuK9wxdvJ3zuzL3828sBwXQl1nL+kKo3gu4DmhtltPiSku2zcBxlXNrve6hjK35JymmpyiveFfhhgOrnqWOT6koOv3ioMNWqm5IUciw6YaP0lSJkeeUR+xTSg5IPF8hOnxFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819364; c=relaxed/simple;
	bh=6xxfeUFnO7LJEwMuMIPyYVGPc+4ACVEwF+0UDvqiDrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL/KGJH9sPBCEY25x/KKh9ulVk/UBBcHg1HsOVZe1sH/wFp3oEbGeNYAc8pa46cGCsEO/49RIkkLNY2orRggJxCgefOykjQLzotsR9ZT1UJdCMRIXKUdHiT0RdeAN75ECcmCbmvGnIMRdWKEyhJEoqg01ScIkO8sBzMY0Vjw6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=E4tTfNEZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3608e6d14b6so37951f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718819360; x=1719424160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AcgCXysYZmu4JkRhRx5+C2+O9+46llduZMYrbpK6E64=;
        b=E4tTfNEZarhc1hqBLiY4kCgRms2Xr+zfvZHQvos6kSHGPpngWg55bXtnuX1TF3DNjZ
         lX2Ad+TAlycIH6s1S3otDsiayheiFeBA0LrGOJ3dgc70kmqfnBPEzfjO84KevkiUC+ml
         XxjKq6bZZP4stui60YniwOr2gqPVrb1idt0ZzptGoVP5pUKsrZcaYFYiBJkbU24hRe+5
         OpJmMz+oZqiT/6ghBOtWl0AkrlQ9XokM7xHxZwlN09Lhk3j7LiVfpM87weC8iVP0Fiwe
         2gND+wZl/qsqnVhMzUumLyMBkR9FPC1MXOyF0DeHOfkg/aWO46kCeIvyb8E3AGAQJBsY
         afnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819360; x=1719424160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcgCXysYZmu4JkRhRx5+C2+O9+46llduZMYrbpK6E64=;
        b=Q4j053E0y1TkdBmbxXcDhCntB5nDdpkl5CsvZb9ouRgZ4x+1xpcXT+yULhQB2JNMO7
         AfgbhhXsALXLZqAltZEWzqiUMOFlVefawPnDxexFYSbUGMiFR0AKCsVOVB2Hcom+hIzR
         iLTCgXuhK55B0+uG5iafCck8cJWSj8WfHEq90YWJ1vnrbUYfn/PLuRj/b8wpuReg5nu6
         q24b+29H23Gu/KLP/9cfDP0YVM//xbJqc7jVn/g28QGzKVth2lUgxmi4usm/3LMDQOgu
         k4Q+rKwdqRo0h7BVnUOosYDmnMSvGe+aAuTwd5VgN9fDKsqtyk6j7o+lFtur+XzD5F5q
         TH9A==
X-Gm-Message-State: AOJu0YyE23BfM2rf3kUsIZUW8YUqU0K5BFNQfBZrIyPmUPkqra4uidGQ
	qgOQSMZ4byL1+pxEL1obWL5feIDoVH6e9+kz4jHvNSlJxuwDwOsVRgnPq9oBTMQ=
X-Google-Smtp-Source: AGHT+IF5IlDkRZXF1XjfR1r1SLWhQ0DOyVD1EiVInzg/dE7DUYs2wPlpovVQokLy1DHtIxqR8DkWAg==
X-Received: by 2002:adf:ea01:0:b0:35f:1bc3:50b0 with SMTP id ffacd0b85a97d-36319a855bamr2372465f8f.63.1718819360179;
        Wed, 19 Jun 2024 10:49:20 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a633sm238320665e9.43.2024.06.19.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:49:19 -0700 (PDT)
Date: Wed, 19 Jun 2024 18:49:18 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, vincent.guittot@linaro.org, peterz@infradead.org,
	daniel.lezcano@linaro.org, ulf.hansson@linaro.org,
	anna-maria@linutronix.de, kajetan.puchalski@arm.com,
	lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCHv2 1/3] Revert: "cpuidle: teo: Introduce util-awareness"
Message-ID: <20240619174918.6lqytbncdjihlwfe@airbuntu>
References: <20240611112413.1241352-1-christian.loehle@arm.com>
 <20240611112413.1241352-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611112413.1241352-2-christian.loehle@arm.com>

On 06/11/24 12:24, Christian Loehle wrote:
> This reverts commit 9ce0f7c4bc64d820b02a1c53f7e8dba9539f942b.
> 
> Util-awareness was reported to be too aggressive in selecting shallower
> states. Additionally a single threshold was found to not be suitable
> for reasoning about sleep length as, for all practical purposes,
> almost arbitrary sleep lengths are still possible for any load value.
> 
> Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> Reported-by: Qais Yousef <qyousef@layalina.io>
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>

Thanks!

--
Qais Yousef

>  drivers/cpuidle/governors/teo.c | 100 --------------------------------
>  1 file changed, 100 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 7244f71c59c5..d8554c20cf10 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -104,56 +104,16 @@
>   *      select the given idle state instead of the candidate one.
>   *
>   * 3. By default, select the candidate state.
> - *
> - * Util-awareness mechanism:
> - *
> - * The idea behind the util-awareness extension is that there are two distinct
> - * scenarios for the CPU which should result in two different approaches to idle
> - * state selection - utilized and not utilized.
> - *
> - * In this case, 'utilized' means that the average runqueue util of the CPU is
> - * above a certain threshold.
> - *
> - * When the CPU is utilized while going into idle, more likely than not it will
> - * be woken up to do more work soon and so a shallower idle state should be
> - * selected to minimise latency and maximise performance. When the CPU is not
> - * being utilized, the usual metrics-based approach to selecting the deepest
> - * available idle state should be preferred to take advantage of the power
> - * saving.
> - *
> - * In order to achieve this, the governor uses a utilization threshold.
> - * The threshold is computed per-CPU as a percentage of the CPU's capacity
> - * by bit shifting the capacity value. Based on testing, the shift of 6 (~1.56%)
> - * seems to be getting the best results.
> - *
> - * Before selecting the next idle state, the governor compares the current CPU
> - * util to the precomputed util threshold. If it's below, it defaults to the
> - * TEO metrics mechanism. If it's above, the closest shallower idle state will
> - * be selected instead, as long as is not a polling state.
>   */
>  
>  #include <linux/cpuidle.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> -#include <linux/sched.h>
>  #include <linux/sched/clock.h>
> -#include <linux/sched/topology.h>
>  #include <linux/tick.h>
>  
>  #include "gov.h"
>  
> -/*
> - * The number of bits to shift the CPU's capacity by in order to determine
> - * the utilized threshold.
> - *
> - * 6 was chosen based on testing as the number that achieved the best balance
> - * of power and performance on average.
> - *
> - * The resulting threshold is high enough to not be triggered by background
> - * noise and low enough to react quickly when activity starts to ramp up.
> - */
> -#define UTIL_THRESHOLD_SHIFT 6
> -
>  /*
>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
>   * is used for decreasing metrics on a regular basis.
> @@ -188,7 +148,6 @@ struct teo_bin {
>   * @next_recent_idx: Index of the next @recent_idx entry to update.
>   * @recent_idx: Indices of bins corresponding to recent "intercepts".
>   * @tick_hits: Number of "hits" after TICK_NSEC.
> - * @util_threshold: Threshold above which the CPU is considered utilized
>   */
>  struct teo_cpu {
>  	s64 time_span_ns;
> @@ -198,28 +157,10 @@ struct teo_cpu {
>  	int next_recent_idx;
>  	int recent_idx[NR_RECENT];
>  	unsigned int tick_hits;
> -	unsigned long util_threshold;
>  };
>  
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>  
> -/**
> - * teo_cpu_is_utilized - Check if the CPU's util is above the threshold
> - * @cpu: Target CPU
> - * @cpu_data: Governor CPU data for the target CPU
> - */
> -#ifdef CONFIG_SMP
> -static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> -{
> -	return sched_cpu_util(cpu) > cpu_data->util_threshold;
> -}
> -#else
> -static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> -{
> -	return false;
> -}
> -#endif
> -
>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -386,7 +327,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	int constraint_idx = 0;
>  	int idx0 = 0, idx = -1;
>  	bool alt_intercepts, alt_recent;
> -	bool cpu_utilized;
>  	s64 duration_ns;
>  	int i;
>  
> @@ -411,32 +351,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	if (!dev->states_usage[0].disable)
>  		idx = 0;
>  
> -	cpu_utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> -	/*
> -	 * If the CPU is being utilized over the threshold and there are only 2
> -	 * states to choose from, the metrics need not be considered, so choose
> -	 * the shallowest non-polling state and exit.
> -	 */
> -	if (drv->state_count < 3 && cpu_utilized) {
> -		/*
> -		 * If state 0 is enabled and it is not a polling one, select it
> -		 * right away unless the scheduler tick has been stopped, in
> -		 * which case care needs to be taken to leave the CPU in a deep
> -		 * enough state in case it is not woken up any time soon after
> -		 * all.  If state 1 is disabled, though, state 0 must be used
> -		 * anyway.
> -		 */
> -		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
> -		    teo_state_ok(0, drv)) || dev->states_usage[1].disable) {
> -			idx = 0;
> -			goto out_tick;
> -		}
> -		/* Assume that state 1 is not a polling one and use it. */
> -		idx = 1;
> -		duration_ns = drv->states[1].target_residency_ns;
> -		goto end;
> -	}
> -
>  	/* Compute the sums of metrics for early wakeup pattern detection. */
>  	for (i = 1; i < drv->state_count; i++) {
>  		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
> @@ -560,18 +474,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	if (idx > constraint_idx)
>  		idx = constraint_idx;
>  
> -	/*
> -	 * If the CPU is being utilized over the threshold, choose a shallower
> -	 * non-polling state to improve latency, unless the scheduler tick has
> -	 * been stopped already and the shallower state's target residency is
> -	 * not sufficiently large.
> -	 */
> -	if (cpu_utilized) {
> -		i = teo_find_shallower_state(drv, dev, idx, KTIME_MAX, true);
> -		if (teo_state_ok(i, drv))
> -			idx = i;
> -	}
> -
>  	/*
>  	 * Skip the timers check if state 0 is the current candidate one,
>  	 * because an immediate non-timer wakeup is expected in that case.
> @@ -667,11 +569,9 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>  			     struct cpuidle_device *dev)
>  {
>  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> -	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
>  	int i;
>  
>  	memset(cpu_data, 0, sizeof(*cpu_data));
> -	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
>  
>  	for (i = 0; i < NR_RECENT; i++)
>  		cpu_data->recent_idx[i] = -1;
> -- 
> 2.34.1
> 

