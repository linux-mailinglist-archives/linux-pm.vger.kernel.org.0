Return-Path: <linux-pm+bounces-3896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80244854376
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 08:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C361C21DC0
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5011706;
	Wed, 14 Feb 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRT39Jxz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579B10A2C
	for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895981; cv=none; b=G/LesZr7hlwCY/agEXGOmPFhWyBkaM0h25O9QfX6AkR0Uatfp2HwuY6t2q52fwcN+ZA9LFA1V6xrCWCDRclnxxL19y1vYWEoMmjkItC6mz2FHKbcMIVWkuOgsCDRqYdie23L8u00WFLWt0TIuODqhxj2XzlF6BawwoEvxYbNew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895981; c=relaxed/simple;
	bh=36WbyCkbWrg/nfe+Tc0vdVJCRsu6UskPWW7v6ONBzMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7cz3+feq3r3ZawPsLMTaonXA3Sk4heJW5TpgN7DYB27y2L+jpqbvtRVNZ/s1ae+wgEFp54T2DcY3bfeR9hLOIOLDeqbEvsverFDFWY5ZzrgdPxqHBGppZhzDCccPicszTAr3AY0yZduvflFdw8JRCrBGSYhoMa0+1FCqM/K8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RRT39Jxz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4003874a12.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 23:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707895979; x=1708500779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YBngkeH2DGERQyxUc36yd+ovNmKq2/mr4MzSwVfzgs=;
        b=RRT39Jxzudo7vXmQ2u9bI7hdfXSKFKsjXi3pRgnDT0xnnHW16qnqZ7X0Dx2L8JKQk9
         39B1j1qT91KfSSXWZnU6x1d9bivcDuiiFO/VV48+lDOqgI5oS41ujT0uuwDQxtu3vxzw
         rxfu4ERQYvPqoFFs/xZ3Xz7MmRPLCUrAp7accUpprvUVBrnrGA3d1weiIqiVDPo0g1a7
         Ymbcd6819Zljzl8MhvnREVyJfKYFgUq+DVvSUiU2WVYWgsdn9LIPT3x8solcK7B0g8x3
         8Jj0H02k16243Ag9dC88HI41tscz42S8xxJYwceu5VUno385n4qof/dwZdK9kD/cJxII
         iZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707895979; x=1708500779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YBngkeH2DGERQyxUc36yd+ovNmKq2/mr4MzSwVfzgs=;
        b=OyMyxzO/3qai3eC3ZacLhUq3oaHwn/o9PxrBU1swzVniS9oVOwTMTJSqLxqkLM2XqJ
         wH7n2NbrfBTl7lxZbyrmvTYQ3Gwq/602Avf8K15bQAmOZXDMDp8mj+hhNSz/dy22jyW7
         foW27eYf7FFodojOkCe0EeWZJCNV5RoTOlQlkIYWV9SSiuq+NU8PZpgC8iIIXERJiaFJ
         OSuOTAnLKnjI+DspzwVuvNr64nlmjfo+MFQgX6UuqxDhQxGzpAcjNxw26q7kunQhsylR
         oz0b9S6h5q+sAbk+r8J7jLYfv4AT7XxugmO9fwZwhf792x4Sa7Mmsk4A/7coXUoy9lVh
         2t+w==
X-Forwarded-Encrypted: i=1; AJvYcCXqVP2Rm+AT/PrkqFvKEmxychp1XP1cb6mpmkEQaQNjgfkDsOWn0Ba8OdKgROhqYdac13jG1PHBQOCf2wqhVzkkH6agCxkQ3kI=
X-Gm-Message-State: AOJu0Yx9l4wlJvDH28lQqOUZaBgkfEiWQMqxi7Idri4dGL0aUIy7mmrx
	z5kKroG0tcYbl1Z/KDrjvaMRjxQc28mzRdbNuwkdG2GzhtyhL7j3JMb05kFBIiIBlc/JumsrGMz
	W3CxUGZmoibBLosDlYhkmKwLtGFpzVI2d9LkP8A==
X-Google-Smtp-Source: AGHT+IGIfDZrWI6cKodqGWitaimhi0cCo8kGPRq5w3majNtqc80qOTjGmrIqpkHpsRlJBcRv/uNvKnAvqE5CHsyt8og=
X-Received: by 2002:a17:90b:1906:b0:296:5b68:45b8 with SMTP id
 mp6-20020a17090b190600b002965b6845b8mr1626530pjb.24.1707895978816; Tue, 13
 Feb 2024 23:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205022006.2229877-1-qyousef@layalina.io>
In-Reply-To: <20240205022006.2229877-1-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Feb 2024 08:32:47 +0100
Message-ID: <CAKfTPtBoapJtwD3DByd06CE07MD3eGhfJVyZ01cRLyKLO8fJ7w@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 03:20, Qais Yousef <qyousef@layalina.io> wrote:
>
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.

The renaming makes sense.

>
> Also move it to sched.h. This function relies on updating util signal

I don't see the benefit of moving it the sched.h as it is only used by
cpufreq_schedutil()


> appropriately to give a headroom to grow. This is more of a scheduler
> functionality than cpufreq. Move it to sched.h where all the other util
> handling code belongs.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched/cpufreq.h    |  5 -----
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/sched.h             | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..d01755d3142f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
>  {
>         return freq * util / cap;
>  }
> -
> -static inline unsigned long map_util_perf(unsigned long util)
> -{
> -       return util + (util >> 2);
> -}
>  #endif /* CONFIG_CPU_FREQ */
>
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..abbd1ddb0359 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>                                  unsigned long max)
>  {
>         /* Add dvfs headroom to actual utilization */
> -       actual = map_util_perf(actual);
> +       actual = apply_dvfs_headroom(actual);
>         /* Actually we don't need to target the max performance */
>         if (actual < max)
>                 max = actual;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..0da3425200b1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>                                  unsigned long min,
>                                  unsigned long max);
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
> +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> +{
> +       return util + (util >> 2);
> +}
>
>  /*
>   * Verify the fitness of task @p to run on @cpu taking into account the
> --
> 2.34.1
>

