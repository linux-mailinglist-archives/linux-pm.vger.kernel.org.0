Return-Path: <linux-pm+bounces-4181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D7485D17A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6CB1C239D0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5A3AC12;
	Wed, 21 Feb 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCM52Wk/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91624B57
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500919; cv=none; b=Jmcc+yzi1zf4wpp105msaP7j/Uay3jBdtQYBsL+AmpGVKfFS9iM2LXGrlv7l+yArrogMZJAX1k2218UXpHSg5oclHO/GdtuQHFH3ZfY/o1dqRSvy1s8cD+nhuQOQiw3LfFtqqKA1yzjV2l18ddTZwIlARO13L2vO+kbnxBGEwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500919; c=relaxed/simple;
	bh=i5Sx85wmsctPs2/SldKw+W2TXiIuxqDh80PQGqdlem0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM4K0kz+gEEqv4/bbm/RzTv+5HAsSU/wQtl5coe1KuVKxCKDw7+U4SyxqFCivd8PZQForvTbM1Yzeo59r8cYHbYbi4hl2NxzMWhkwoezEcZ0vNdZyT9I/wE+OtPwprPTf738eAODjxRSiEsJjrEOFVTZrQnQYFPPgJa9OExI+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCM52Wk/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3848261a12.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708500916; x=1709105716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmIOqBg1/8WHQOr613NChMcnfIzd4pmzronJgXlBxNw=;
        b=lCM52Wk/CDoH1ctptopF4UM6eZld/BixeX54ztPdMY4QDvO+n8XvrTTy0bXvOTbNR9
         FLBFKKm8CwhnqBbe139T+UoZ2Dz1t0DF6aMDHDhMfmuFVF5cJ3qmgfbrGLtJIP/js19+
         MhWMUSowMV3wt39NeGMZsjkY8jrgeNdJODo+4k0k0q2KXRE99IM6XI/x7MZp+Kiu30G7
         AJOmIuzsYcbpNvLlmLVo7YD/Ms2xtD/x8yU04BtYbNJP7ZTKeufiBDvc1tF1puvBcKIO
         QwVk7Y+jL7gDZ1PLJ88G/zAHC8lyvp/syQfNzZo39Z3O4mSxa49n5+7EIaZGDANyk4jC
         vzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500916; x=1709105716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmIOqBg1/8WHQOr613NChMcnfIzd4pmzronJgXlBxNw=;
        b=Woz+8VNhBIjxd26Q3SorI7vj6l+Foqfi1JjBxqYwWPKmDO9DUucy92YHKYhwYdapi5
         cJeLOfrtkB8/Qtxgh5AC7+KYgdC2qEH1WbL97TmFizXbDiGK4DkRtv8iJr38x0vEH4OM
         qNgTOEE2uux7xN+cLOE/EYYZvoiqmN2JQXXgmWJfMyDy85jOWcYPJon70eq+j5bISGQR
         S/jMrcF9aEObxbiEZ9kLHxvWgak1PaZK75kuUGt9Tk3qLPVLd7XFfXwJZDn2rwKNGK46
         O7oHenXpS23KWgjda6Wpr5GRGFCg7mkkjOYYrJZo3gPMYXX+eABzL1oh4oUgDBQu2iit
         QlVA==
X-Forwarded-Encrypted: i=1; AJvYcCVkADVc6adrUHUwIHDZ/V0lo0AoXWSOUOCAoW8ZYxvaatdQsriWlqNZDy90rjlkRsARTqnzA7iaO9TRP0P1D5umRHFIsvQXHLQ=
X-Gm-Message-State: AOJu0YxsUZVewcd15gLd/mKcMvQPhjdX1YL5vhzbdw28ztc+6MyXJv9d
	FaXpzZIiuGk6DOJBGcCWM0M8JLNq6byQTUc8no3F8ptyb2v9KSkmSDq2l0CUrLAky3IvsArcH6A
	Wedu1zof6XblzqgpIKaGynf8mi0PDHER8e2bFUn/d6Nrkmlma
X-Google-Smtp-Source: AGHT+IEyfoGtlAAp8JSHXSGnVPdzKYbAy+h9ELuMYVkP7dMmdJMLjD22VuOCWasVIiW5Xy2n1mWGUbmmePwJtG1WB18=
X-Received: by 2002:a17:90a:5b06:b0:29a:2349:4d1e with SMTP id
 o6-20020a17090a5b0600b0029a23494d1emr477974pji.23.1708500916001; Tue, 20 Feb
 2024 23:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220180820.2597581-1-qyousef@layalina.io>
In-Reply-To: <20240220180820.2597581-1-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 21 Feb 2024 08:35:04 +0100
Message-ID: <CAKfTPtDO1r+_htQWTB3V-iXChozFtPCRMQpaRY8ecsMu1QDacA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 19:08, Qais Yousef <qyousef@layalina.io> wrote:
>
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
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> Changes in v2:
>
>         1. Add Acked-by from Viresh and Raphael (Thanks!)
>         2. Move the function to cpufreq_schedutil.c instead of sched.h
>         3. Name space the function with sugov_ to indicate it is special to
>            this governor only and not generic.
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
> index eece6244f9d2..575df3599813 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
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
> +       return util + (util >> 2);
> +}
> +
>  unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>                                  unsigned long min,
>                                  unsigned long max)
>  {
>         /* Add dvfs headroom to actual utilization */
> -       actual = map_util_perf(actual);
> +       actual = sugov_apply_dvfs_headroom(actual);
>         /* Actually we don't need to target the max performance */
>         if (actual < max)
>                 max = actual;
> --
> 2.34.1
>

