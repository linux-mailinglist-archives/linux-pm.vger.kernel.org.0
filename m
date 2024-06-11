Return-Path: <linux-pm+bounces-8947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B600903D92
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E04281170
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6717C7AC;
	Tue, 11 Jun 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdMk31pY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727347F7A
	for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113046; cv=none; b=IxdhHCuQMNpSSy/1In14PR3pEocWKPkwJzFt4L3/R8RNhWbDv11W7rCDnX4n+GhOR6qt2a8duUWhwjW8rPfRc5PZViLZa9cuoCUU7+RLDeHthtdZ1hSab1gWuUH+eIfN4NEsA/DnTFMspDTCgmpAkSaZUWAYY9oOZssz5hKfJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113046; c=relaxed/simple;
	bh=uClWVkm9RxsLs+EfbggJIY5JpBEtxoQIUWpWC/sz2K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgOvfuQTjaV/5JHT0DFqMW1qDD9F1+/Td0PsEc6oBPpGoonLdJIasyvbyvKrkoSo/M6eaQHONzj+ferQGaY71fbuvsXh5lVfwqx/FI69F8lx0baPw4bsAyfwYtPmsBmXFmM10R21k6dndiI692EELXDm43nIzaE4qOsaDYhsEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdMk31pY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6e40d54e4a3so2951970a12.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718113044; x=1718717844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAcDNalbfcX/SooAz1XjppInJxW8mD6aEySBf2LPSno=;
        b=hdMk31pYtLGSlgRi7MR3YBa6zWjH0WJRD7vPxC1b+83+jWvfGz0EaJsnRpjbUETTQS
         rUYbzhVppsG7ZZfEarzZ+QyC5tqf+SZtRlqIOoJivYURivTH2knTHfaCEw5UU8VCDpNi
         NRhtZUoe5bcCLoh0I+HzpLya63BuT118p3+rImAKQW+Q7h+DO/8aYGjWrI4nW9QoDTo9
         CpL7eOTvkTx2X+ZnLGNwcYTyEzgj/sSJkGoS/sQslc05OUJfNwGvLnSk++tz7XNiQjvT
         xycnwr3G3GuwTaU8KhRavJK3gkErjJcHP6GSphk9nVzk4w7lU+f/bmfGm5OwC8l9130d
         cVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718113044; x=1718717844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAcDNalbfcX/SooAz1XjppInJxW8mD6aEySBf2LPSno=;
        b=Nuy9P/mbzFnNCm5MG6sXRXQaRQfuam7YR5y0Yx5qV5BKfbXz1oxEm5sGvDq+cRm5+K
         y0+OTCwHREejlImUwgB6cWTd7yLq3PkleUo2WocNkXWCRxpC4Y6+qHAJU663knLWboJQ
         qaDOZZDo9lBqoIizEhH24ZkUcWcY0YR+nP8TvbgE6rIyBkmVG37/EqN8T9WmuY9dJtl7
         0llRM0hHuYJpahaejqJufZCnZmeNM58j6kdcQf7Y6+q6PqMd9JxmonTrno47e4SuCfqH
         0L9jseVVoQK/4VHcw0YQzTsnLlpmWOz6Oa5kT3GzR+8YjnYMmpm/7YtASr2o4qS+5QLx
         UP5Q==
X-Gm-Message-State: AOJu0YybA9Js4i88lDU+bRthyOu7pzqasreainreypuAY430vqKdDAUa
	BK5PLwI2j3pfMkWRbFpbxKKccnEb347ge/FrAvA4LUf8lxg6SaO3IJtTT6V16YZ/Z9VIKWXm5na
	8PgG7YcHTxodA7E4TYO89PSXAeCD6XY1uDPulpw==
X-Google-Smtp-Source: AGHT+IFs979EGmIWLmkusI/d7SBFQhTqweYDqCK3mffDdw6Ftoj9EB//VarfNSLmbqnD3uT08/vi0tbvTUuy9HnmxdI=
X-Received: by 2002:a17:90a:d397:b0:2c2:bd1a:4f84 with SMTP id
 98e67ed59e1d1-2c2bd1a4fb0mr11352008a91.10.1718113044480; Tue, 11 Jun 2024
 06:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611112413.1241352-1-christian.loehle@arm.com> <20240611112413.1241352-2-christian.loehle@arm.com>
In-Reply-To: <20240611112413.1241352-2-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 11 Jun 2024 15:37:12 +0200
Message-ID: <CAKfTPtC4GZ1LJsGZJ7wie9tus=+hmg1Rg=RaBtwXZxKGL17N9A@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] Revert: "cpuidle: teo: Introduce util-awareness"
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	qyousef@layalina.io, peterz@infradead.org, daniel.lezcano@linaro.org, 
	ulf.hansson@linaro.org, anna-maria@linutronix.de, kajetan.puchalski@arm.com, 
	lukasz.luba@arm.com, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 13:24, Christian Loehle <christian.loehle@arm.com> wrote:
>
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

The spurious wakeups that I reported on my rb5, are gone with this patchset

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
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
>         s64 time_span_ns;
> @@ -198,28 +157,10 @@ struct teo_cpu {
>         int next_recent_idx;
>         int recent_idx[NR_RECENT];
>         unsigned int tick_hits;
> -       unsigned long util_threshold;
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
> -       return sched_cpu_util(cpu) > cpu_data->util_threshold;
> -}
> -#else
> -static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> -{
> -       return false;
> -}
> -#endif
> -
>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -386,7 +327,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         int constraint_idx = 0;
>         int idx0 = 0, idx = -1;
>         bool alt_intercepts, alt_recent;
> -       bool cpu_utilized;
>         s64 duration_ns;
>         int i;
>
> @@ -411,32 +351,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         if (!dev->states_usage[0].disable)
>                 idx = 0;
>
> -       cpu_utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> -       /*
> -        * If the CPU is being utilized over the threshold and there are only 2
> -        * states to choose from, the metrics need not be considered, so choose
> -        * the shallowest non-polling state and exit.
> -        */
> -       if (drv->state_count < 3 && cpu_utilized) {
> -               /*
> -                * If state 0 is enabled and it is not a polling one, select it
> -                * right away unless the scheduler tick has been stopped, in
> -                * which case care needs to be taken to leave the CPU in a deep
> -                * enough state in case it is not woken up any time soon after
> -                * all.  If state 1 is disabled, though, state 0 must be used
> -                * anyway.
> -                */
> -               if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
> -                   teo_state_ok(0, drv)) || dev->states_usage[1].disable) {
> -                       idx = 0;
> -                       goto out_tick;
> -               }
> -               /* Assume that state 1 is not a polling one and use it. */
> -               idx = 1;
> -               duration_ns = drv->states[1].target_residency_ns;
> -               goto end;
> -       }
> -
>         /* Compute the sums of metrics for early wakeup pattern detection. */
>         for (i = 1; i < drv->state_count; i++) {
>                 struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
> @@ -560,18 +474,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         if (idx > constraint_idx)
>                 idx = constraint_idx;
>
> -       /*
> -        * If the CPU is being utilized over the threshold, choose a shallower
> -        * non-polling state to improve latency, unless the scheduler tick has
> -        * been stopped already and the shallower state's target residency is
> -        * not sufficiently large.
> -        */
> -       if (cpu_utilized) {
> -               i = teo_find_shallower_state(drv, dev, idx, KTIME_MAX, true);
> -               if (teo_state_ok(i, drv))
> -                       idx = i;
> -       }
> -
>         /*
>          * Skip the timers check if state 0 is the current candidate one,
>          * because an immediate non-timer wakeup is expected in that case.
> @@ -667,11 +569,9 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>                              struct cpuidle_device *dev)
>  {
>         struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> -       unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
>         int i;
>
>         memset(cpu_data, 0, sizeof(*cpu_data));
> -       cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
>
>         for (i = 0; i < NR_RECENT; i++)
>                 cpu_data->recent_idx[i] = -1;
> --
> 2.34.1
>

