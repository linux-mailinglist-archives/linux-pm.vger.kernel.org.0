Return-Path: <linux-pm+bounces-3370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE98494AD
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 08:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614E42861FB
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AE11190;
	Mon,  5 Feb 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEuTR9PW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1010A17
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118890; cv=none; b=L0cly+4OyzZLvx5neEQ57tIIYiwR5gQu9r5zLhrvV2oKeaErCEkmLT+I3h/MDPaVTeLhVG7pgMkC/7EUyg6u58g7cMT9BhvwjVK8vHPZmHKDLxmwRGWCbeqaZ+9ztPH/AGxpp0ysvpeIP96oErj4BGpynVXg0BCokiq+v/WwPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118890; c=relaxed/simple;
	bh=wzCEaWKeZ+08cCEOZbavhBle93w9eW1ks7Z+cJZ7Ruo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeO9BvdlbX9p5z4HOTWHcfh+UcZAO3cH49ky0ROKsiZv8tN1UbzEXBe4s0YqoopJU3fFlx8bfg0X2qeX/Uop1Vs3+oWYoi+NV8IpLd3HA5y7wdc584Ftdd2YXBId2Z9uWbTSDNlhRRadMKCYWPvTzBArd9QblIZjKByGd0Ws3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEuTR9PW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd72353d9fso3206202b6e.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 23:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707118887; x=1707723687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytTM21K5fui0gXJKAC6fg4Q/JeWcZkF90c68bDoDRdY=;
        b=GEuTR9PWQNRuzxryX94lMkWhn8Xzhnt2RkOkY9UStI+NlfHwFxZfeZWtlOBbAUamf9
         U9IgELwyR0EJklp1FSw/xlrCyQkbOeE03L2KmEnaiRGriOqysFFnQP6FCMTSzHRbR4S4
         lJgEolFMHgt86Swq3uyXBUaD2gBvFoMGrLbD6hT6hnrqBuASwKBTOlLbh6ED+YyIAvti
         O5qGPIY43jqd3DpeTVnRY4WCxB3iCcKjY9h7N7XkBdup/oxGthNpgVb4ciQWyk2Tb6TH
         mbQoIHYmihNf5VZyyXPRficUunYnSXxvhJhcrkyQTtRadX3FEK+wIuQfzJn/bg/GEw1y
         3NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118887; x=1707723687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytTM21K5fui0gXJKAC6fg4Q/JeWcZkF90c68bDoDRdY=;
        b=CGdk5bnve9a09RahnT+R9bWc5mZnoResJJ3yZ+Y8+vurIWWDJWpmE3zze9SWPfRTdN
         1dDiZW5QMc5WFNHOMIIt65bde1IuIHAkS/f3jL9+2DvB0A/kSbD1IN7FSP/ImUIwvmDw
         mBvWlkdK4vv+j+1IXKYCmDIi6hEDTFSb1zAOficvCN3mp15EukYig/6WkVEOsPBGiLtk
         JXlHwA4q66RyDYQPsOsha+LVelIGETcbLcxzgrAjSgCeMkHMxUkVIPJ4MR8uP1OanBOX
         eQmBpw4sWAGD7PAhoUdZ3j1fdG4pXCS8J+JwvRJVngEEkzXZcQsXJglQMdbJx6AXd1kK
         W5+A==
X-Gm-Message-State: AOJu0YwfboIS6j6AGiPKLAauVE25rEdELSzjAtiSmhPFGSMTTArM619d
	PXolv1y8tdoep3lTelr1WAyHBdPfP2EGpjMGyiE0ywJSi2kEE54tFly02QgqCnQ=
X-Google-Smtp-Source: AGHT+IE2O0xDDxihhECYsW3qb/W46K0ABn22sqbyOyNiXHtNB9U6UngEDRBLqF/ORSb1cPosVdWwpA==
X-Received: by 2002:a05:6808:30a9:b0:3bf:ddad:569f with SMTP id bl41-20020a05680830a900b003bfddad569fmr2840107oib.48.1707118887215;
        Sun, 04 Feb 2024 23:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWV/qDRZfbQiCpRvAz/H6Dsbu0tGFPzrjyJxsXhit91P01KLfTIwQ4Nym9ej2Pl+Yz6FG7XAEdLc+5NkQ7/T9LKVB08R2H7CkwgpsvtECj5jN4wd4YLciaI0uyKDWENH7F3oI2AMzNDYRzUlP2j3FY4Pld0JmWfaeZOKuZK2ilMEUJAV6xAHAbfdGhvAjUkugziwruikcVG6uAyL7LDTpMFl/UACUEhhho/1sfLBDdtuWDGiGqoUx9uWutQyKr4uWIPTMjfCsLeDDk0ZjoP0O7xbviJtwU8Rsz6cokJXtU=
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a000be200b006e04b1b0f96sm764905pfu.69.2024.02.04.23.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:41:26 -0800 (PST)
Date: Mon, 5 Feb 2024 13:11:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
Message-ID: <20240205074124.sgmjjyfkjb7ozche@vireshk-i7>
References: <20240205022006.2229877-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205022006.2229877-1-qyousef@layalina.io>

On 05-02-24, 02:20, Qais Yousef wrote:
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.
> 
> Also move it to sched.h. This function relies on updating util signal
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
>  	return freq * util / cap;
>  }
> -
> -static inline unsigned long map_util_perf(unsigned long util)
> -{
> -	return util + (util >> 2);
> -}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..abbd1ddb0359 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  				 unsigned long max)
>  {
>  	/* Add dvfs headroom to actual utilization */
> -	actual = map_util_perf(actual);
> +	actual = apply_dvfs_headroom(actual);
>  	/* Actually we don't need to target the max performance */
>  	if (actual < max)
>  		max = actual;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..0da3425200b1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  				 unsigned long min,
>  				 unsigned long max);
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
> +	return util + (util >> 2);
> +}
>  
>  /*
>   * Verify the fitness of task @p to run on @cpu taking into account the

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

