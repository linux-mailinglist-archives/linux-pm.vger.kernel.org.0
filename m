Return-Path: <linux-pm+bounces-2999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC28842B19
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 18:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EE1C2431D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9114E2CB;
	Tue, 30 Jan 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiTXz43a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B4128368
	for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636310; cv=none; b=i3XliHK8K4kS+AL7SB9FrGJ1nKCCzjnWJjyPgjuu5iT2hBS+qoTmvT5kYsOoXnH0+zenikYrrh2xMvGr0JtQYGjmoYtYtQwHzcW6q/2Lag3zJXivc8nqQvqq5x5Uk7ULqKURYcSLR58Cg4xF4ZlRbgEN+2dZvtFs9ooGkckH2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636310; c=relaxed/simple;
	bh=2TbTvOJDPGl5d3FAMeuXChO1S+7u/Pw2Z2DravzPzBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udRBWrtXB/njR0L8u+jLTrGZ6BfEZWoXT8cfzIx8PgyyjPgJELtHq4r8O2Wb0HyuiexydZmk8Kex6uqLPL7kT8xzKtVn7lIe+KyXajIdefyg3HdLGc4g6Xkn7wT+9UTic8hZMawH7H02q1nvYkOs8UeI938p5pqE2x8ALTj/UM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EiTXz43a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e775695c6so37834445e9.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706636305; x=1707241105; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pzbZS1rtphhJPpoCmxByVYIAa2guEhJDVA86rKB8OU=;
        b=EiTXz43aw+stFfu8UyFqurZk/sozBETkffT9QL0b2BOc8z/9CuPeQM2k0uji+jepc6
         Gplg6meU8XfcM1UTOBk5TJE9DO1b6BB5ZBLuv+Cudp9CaTav8QmQmziqw4zxaX5UUV/8
         Xs9/YiBQ+etubNQznBJ1DfpHkAZ6Y5mzNvyiPqhOoLbGPlHlmersFDtITpDlToptmKJS
         uKto5eZZXbyww35IsVwckVDjSunbNhGZA8Kyy9UJ0K4XbvNz1QphLIdOVIjmaZKHSCxr
         +0m1y/aKQ0AmiOueNqExPJem7C+OgzmkNUkP7e1r4XU4FdMKqNCl7ZYwFI2C6BcosVPX
         lgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706636305; x=1707241105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pzbZS1rtphhJPpoCmxByVYIAa2guEhJDVA86rKB8OU=;
        b=vh2crt04DavS1Blj+iTyaUGnC8KSKg5ljsR+qnl45Rn8WnRbcvogNiC+lpDU/umVB7
         QwPBogKJtcCRCP4GqySDyiyn72KVd6MkqHlacHM8e54yQHClEGGiJMPIqO30WQGclg4w
         rdEOq3v7hX5p4CwkSJOXboyKlr79ZPqemaXHPkPUftOSGxv8ktWebhFh1mPGG4LU+Yld
         wvjL8XeNE9wracmxpfHNrCqpy/ru1G3EiXeTFGkkS01fzz8LtFoDOfg9s0yEZSgwdhwV
         8W6umyanEaWvQXuZa5xYx0xP00sCBp2e1DUIaVPo/HWvzYWnxGP3LFSPc5qNTUqYgtjA
         FPkQ==
X-Gm-Message-State: AOJu0YyD+N+Ckrgorbh6ThwrxR09Q3vtR4ScQiGgEPykFPO+t+bwiQCJ
	gQn7nsRobTP96GwGDJXONf+TAXj1H5tyiU3yGigmy1WozOxYsAjAmGSYwl7YyU8=
X-Google-Smtp-Source: AGHT+IEaW4n1rmtcE9DmqPQvrMZTDGxN+PVahTKeK5HCkpW0Fmf6FowWbWl2bkSbDWbIWv4Wtg2EUg==
X-Received: by 2002:adf:ee48:0:b0:33a:fce6:4d9d with SMTP id w8-20020adfee48000000b0033afce64d9dmr1640095wro.60.1706636305299;
        Tue, 30 Jan 2024 09:38:25 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:513a:c1da:4bd6:228])
        by smtp.gmail.com with ESMTPSA id by5-20020a056000098500b0033afef9bdfbsm502634wrb.8.2024.01.30.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:38:24 -0800 (PST)
Date: Tue, 30 Jan 2024 18:38:22 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Message-ID: <Zbk0DhibX0oDLk1s@vingu-book>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208002342.367117-9-qyousef@layalina.io>

Le vendredi 08 d�c. 2023 � 00:23:42 (+0000), Qais Yousef a �crit :
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The new sched_pelt_multiplier boot param allows a user to set a clock
> multiplier to x2 or x4 (x1 being the default). This clock multiplier
> artificially speeds up PELT ramp up/down similarly to use a faster
> half-life than the default 32ms.
> 
>   - x1: 32ms half-life
>   - x2: 16ms half-life
>   - x4: 8ms  half-life
> 
> Internally, a new clock is created: rq->clock_task_mult. It sits in the
> clock hierarchy between rq->clock_task and rq->clock_pelt.
> 
> The param is set as read only and can only be changed at boot time via
> 
> 	kernel.sched_pelt_multiplier=[1, 2, 4]
> 
> PELT has a big impact on the overall system response and reactiveness to
> change. Smaller PELT HF means it'll require less time to reach the
> maximum performance point of the system when the system become fully
> busy; and equally shorter time to go back to lowest performance point
> when the system goes back to idle.
> 
> This faster reaction impacts both dvfs response and migration time
> between clusters in HMP system.
> 
> Smaller PELT values are expected to give better performance at the cost
> of more power. Under powered systems can particularly benefit from
> smaller values. Powerful systems can still benefit from smaller values
> if they want to be tuned towards perf more and power is not the major
> concern for them.
> 
> This combined with respone_time_ms from schedutil should give the user
> and sysadmin a deterministic way to control the triangular power, perf
> and thermals for their system. The default response_time_ms will half
> as PELT HF halves.
> 
> Update approximate_{util_avg, runtime}() to take into account the PELT
> HALFLIFE multiplier.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [Converted from sysctl to boot param and updated commit message]
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/core.c  |  2 +-
>  kernel/sched/pelt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/pelt.h  | 42 +++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  1 +
>  4 files changed, 90 insertions(+), 7 deletions(-)
> 

...

> +__read_mostly unsigned int sched_pelt_lshift;
> +static unsigned int sched_pelt_multiplier = 1;
> +
> +static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_int(val, kp);
> +	if (ret)
> +		goto error;
> +
> +	switch (sched_pelt_multiplier)  {
> +	case 1:
> +		fallthrough;
> +	case 2:
> +		fallthrough;
> +	case 4:
> +		WRITE_ONCE(sched_pelt_lshift,
> +			   sched_pelt_multiplier >> 1);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	sched_pelt_multiplier = 1;
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops sched_pelt_multiplier_ops = {
> +	.set = set_sched_pelt_multiplier,
> +	.get = param_get_int,
> +};
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +/* XXX: should we use sched as prefix? */
> +#define MODULE_PARAM_PREFIX "kernel."
> +module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
> +MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
> +
>  /*
>   * Approximate the new util_avg value assuming an entity has continued to run
>   * for @delta us.

...

> +
>  static inline void
> -update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> +update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
>  
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bbece0eb053a..a7c89c623250 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1029,6 +1029,7 @@ struct rq {
>  	u64			clock;
>  	/* Ensure that all clocks are in the same cache line */
>  	u64			clock_task ____cacheline_aligned;
> +	u64			clock_task_mult;

I'm not sure that we want yet another clock and this doesn't apply for irq_avg.

What about the below is simpler and I think cover all cases ?

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index f951c44f1d52..5cdd147b7abe 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -180,6 +180,7 @@ static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
 		  unsigned long load, unsigned long runnable, int running)
 {
+	int time_shift;
 	u64 delta;

 	delta = now - sa->last_update_time;
@@ -195,12 +196,17 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	/*
 	 * Use 1024ns as the unit of measurement since it's a reasonable
 	 * approximation of 1us and fast to compute.
+	 * On top of this, we can change the half-time period from the default
+	 * 32ms to a shorter value. This is equivalent to left shifting the
+	 * time.
+	 * Merge both right and left shifts in one single right shift
 	 */
-	delta >>= 10;
+	time_shift = 10 - sched_pelt_lshift;
+	delta >>= time_shift;
 	if (!delta)
 		return 0;

-	sa->last_update_time += delta << 10;
+	sa->last_update_time += delta << time_shift;

 	/*
 	 * running is a subset of runnable (weight) so running can't be set if



>  	u64			clock_pelt;
>  	unsigned long		lost_idle_time;
>  	u64			clock_pelt_idle;
> -- 
> 2.34.1
> 

