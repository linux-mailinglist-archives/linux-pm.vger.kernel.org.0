Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9D782021
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 23:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjHTVNZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjHTVNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 17:13:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73A0B3
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 14:13:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee769fcc3so10440295e9.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692565989; x=1693170789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3x4E6fdyGal9eeb7RV36kqljRR1Sd8W3xt608ktoiI=;
        b=W9ql6TAATM+dc9WFTs0B0+cemNnrSxMakEsaFfu73xbUB9YOGlA8OZydwsa5LGRvA/
         6z3xkP78Oz1jj4H4eN+g+bog16i4+LllbnCK3NYameUCKHJeAv64ljX56DtecmcAkPEl
         6IQQJI6aUFPOFt4pxV8oVYeqhdNWqLfnLCSgf/nEwTcxBXkmLuFydH6mrEaXyTlt4q00
         o51pW6djlBMDYuCODpzxwjGAgg66Vplok7YnFJtQb59T6ZrYEBpQUFpOBeUSVWX/Ke+d
         JleWW6PJhku3YoqJrc9Z5chHcOihgJKcvGL+CG8sG9Fj9kmKfz1bzLPZCKyFbUtu12YM
         dhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565989; x=1693170789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3x4E6fdyGal9eeb7RV36kqljRR1Sd8W3xt608ktoiI=;
        b=YQasB6nRyo9pmpnQtPXiA5MdI8ecQUBwDraeAIJzCKooePw/M7KrM3OUfI1XVpZJM5
         +vaKcXrUNCk83sRPF4+wDzrih23xAbgzuIAjbpGceOBlT5bukc5LZ4/e+zYS0IVYvABw
         k79qRK1Si24Y2Z6TCapMYaMpjcc/7dTocCx+N2H9Af0agTrUVIxvAKV1k/cp9+Qap1t8
         ZOgjLM/wzCdP6PNtuppJ5Qe11YwRS/XkLmJpYx+XbBLv7Vp/GJBNe13ffV/HuRMAdR1+
         3AHZd+0L2rJid12NXkWxqHftQoyXJiOb21b4e+1FJq+GbOtS/KPrFEC0nYZrwZ4OLlEP
         M6Mg==
X-Gm-Message-State: AOJu0YycXrRUHPgy6AxYrT7xHLGh9rcrprsZgxQecCKX5Swlxjd3/A46
        gdIOKeO/0BdfMO0dJP4VQi/pSA==
X-Google-Smtp-Source: AGHT+IGf3jgqsylbtYDIH6+PI2b8qDC2s6TZudUAl1u0dpzBPVE7CJPyRx3QTbOoU21aKzOI9hSAzg==
X-Received: by 2002:a1c:7c0d:0:b0:3fe:dd94:2af6 with SMTP id x13-20020a1c7c0d000000b003fedd942af6mr3670993wmc.12.1692565989236;
        Sun, 20 Aug 2023 14:13:09 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id p21-20020a1c7415000000b003feef5b0baesm2450458wmc.26.2023.08.20.14.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:13:08 -0700 (PDT)
Date:   Sun, 20 Aug 2023 22:13:07 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 1/4] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
Message-ID: <20230820211307.p6gypri2jztqwf2o@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-2-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230820210640.585311-2-qyousef@layalina.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/20/23 22:06, Qais Yousef wrote:
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.
> 
> Provide a dummy definition for !CONFIG_CPUFREQ which will be required
> for later patches.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  include/linux/energy_model.h     |  2 +-
>  include/linux/sched/cpufreq.h    | 27 ++++++++++++++++++++++++++-
>  kernel/sched/cpufreq_schedutil.c |  6 +++---
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..6ebde4e69e98 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -243,7 +243,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	scale_cpu = arch_scale_cpu_capacity(cpu);
>  	ps = &pd->table[pd->nr_perf_states - 1];
>  
> -	max_util = map_util_perf(max_util);
> +	max_util = apply_dvfs_headroom(max_util);
>  	max_util = min(max_util, allowed_cpu_cap);
>  	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
>  
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..f0069b354ac8 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -29,10 +29,35 @@ static inline unsigned long map_util_freq(unsigned long util,
>  	return freq * util / cap;
>  }
>  
> -static inline unsigned long map_util_perf(unsigned long util)
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
> + *
> + * TODO: The headroom should be a function of the delay. 25% is too high
> + * especially on powerful systems. For example, if the delay is 500us, it makes
> + * more sense to give a small headroom as the next decision point is not far
> + * away and will follow the util if it continues to rise. On the other hand if
> + * the delay is 10ms, then we need a bigger headroom so the CPU won't struggle
> + * at a lower frequency if it never goes to idle until then.
> + */

I'm happy to drop this TODO if it is controversial. I already have a series
that works in that effect that I will hopefully get a chance to post soon
enough.


Cheers

--
Qais Yousef

> +static inline unsigned long apply_dvfs_headroom(unsigned long util)
>  {
>  	return util + (util >> 2);
>  }
> +#else
> +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> +{
> +	return util;
> +}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4492608b7d7f..916c4d3d6192 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -143,7 +143,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	unsigned int freq = arch_scale_freq_invariant() ?
>  				policy->cpuinfo.max_freq : policy->cur;
>  
> -	util = map_util_perf(util);
> +	util = apply_dvfs_headroom(util);
>  	freq = map_util_freq(util, freq, max);
>  
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> @@ -406,8 +406,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>  	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
>  		sg_cpu->util = prev_util;
>  
> -	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> -				   map_util_perf(sg_cpu->util), max_cap);
> +	cpufreq_driver_adjust_perf(sg_cpu->cpu, apply_dvfs_headroom(sg_cpu->bw_dl),
> +				   apply_dvfs_headroom(sg_cpu->util), max_cap);
>  
>  	sg_cpu->sg_policy->last_freq_update_time = time;
>  }
> -- 
> 2.34.1
> 
