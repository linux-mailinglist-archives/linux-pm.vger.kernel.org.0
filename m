Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7245F97E6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 07:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJJFkR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 01:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJJFkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 01:40:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AD27B1C
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 22:40:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 204so9862816pfx.10
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2022 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ78B9lwdLkovaz295APFEjTaXdB7+w4Q6n9/7I5XLg=;
        b=ZEGeAZxoGqdaCUJZRQZ/zthcIq5Ie1ERQn63T3FzyLHxLMnjT4TpgOHbNUXt9fEOfZ
         l5PygcYexYxmbtj7UA1Y1NuwuZQhmlUKixPAQSI3B6B3xugEtzefXIBBeK+ak9/YmH9K
         6e/IefMe3F38bYh8+UXGU8pvTzJStom24a51Rgfxd2Ak73j3Uk4kcFR6Ih3MewND2ekk
         quIJanddvcy5Pek+pnN87xF2swDkoknTxh+EN86Ay0/6W2+6DPOpxiGvynTiaWPXwJnW
         RHr/S7CYgYwFVTvx5VtqkkHyLWYm9JfbQkX3YSJOKTiPWH1mlshZR9FQGsjLkovUVQXy
         FN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ78B9lwdLkovaz295APFEjTaXdB7+w4Q6n9/7I5XLg=;
        b=Roi7m5VpLizr/e2EbMz/mRRkrv+j3Z5P0Q/oT4AUzNM9l/HXiXV3KJ2Tnq9ji0Ttjl
         v/xGd4fc4aM8e7wGNRwIS6KS4QyGGSFrqlA3LUymB71MuhMN042zRbWgqmSO3Tse2Nrv
         ozH/2tm4OliHCvNhnkHNBZxgfqP67Iprc+4CqTgUmeYP1ybXkZzzGTO+6FWB3nUO3l+O
         REse77qN6TDrKjufAVmn3hCAKk3CNxo3/Am4leIXyG02cr/XXSj/ED2D61ysZNC//MZc
         yfsqGr21NxUkLi8n9Lx3xqOi+TY5Yt98cLIvj0FzLr7uzkcKZiDfezUcFwDcvojee71f
         OL9g==
X-Gm-Message-State: ACrzQf1WNNBXMuCa3aNTQyaTN/+3qvfmbO/i+xrRH8CZGEJR3CB7+kkZ
        6+XAKhD2hUudXv+ite6BLKs7amgzVGUCew==
X-Google-Smtp-Source: AMsMyM4JhEXKGbxb590RdT5FAf3NWJuyaHs14isxCTWjUKuNLFPGbXWfIDRFPd4bnL460cn+do980g==
X-Received: by 2002:aa7:8687:0:b0:560:3299:a6c0 with SMTP id d7-20020aa78687000000b005603299a6c0mr17944385pfo.81.1665380345261;
        Sun, 09 Oct 2022 22:39:05 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a0c8100b002037a4e913bsm8382838pja.44.2022.10.09.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:39:04 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:09:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, peterz@infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in
 store_scaling_max_freq()
Message-ID: <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20220930094821.31665-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930094821.31665-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Would be good to always CC Scheduler maintainers for such a patch.

On 30-09-22, 10:48, Lukasz Luba wrote:
> When the new max frequency value is stored, the task scheduler must
> know about it. The scheduler uses the CPUs capacity information in the
> task placement. Use the existing mechanism which provides information
> about reduced CPU capacity to the scheduler due to thermal capping.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1f8b93f42c76..205d9ea9c023 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/thermal.h>
>  #include <linux/tick.h>
>  #include <linux/units.h>
>  #include <trace/events/power.h>
> @@ -718,6 +719,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  static ssize_t store_scaling_max_freq
>  (struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> +	unsigned int frequency;
> +	struct cpumask *cpus;
>  	unsigned long val;
>  	int ret;
>  
> @@ -726,7 +729,20 @@ static ssize_t store_scaling_max_freq
>  		return -EINVAL;
>  
>  	ret = freq_qos_update_request(policy->max_freq_req, val);
> -	return ret >= 0 ? count : ret;
> +	if (ret >= 0) {
> +		/*
> +		 * Make sure that the task scheduler sees these CPUs
> +		 * capacity reduction. Use the thermal pressure mechanism
> +		 * to propagate this information to the scheduler.
> +		 */
> +		cpus = policy->related_cpus;

No need of this, just use related_cpus directly.

> +		frequency = __resolve_freq(policy, val, CPUFREQ_RELATION_HE);
> +		arch_update_thermal_pressure(cpus, frequency);

I wonder if using the thermal-pressure API here is the right thing to
do. It is a change coming from User, which may or may not be
thermal-related.

> +
> +		ret = count;
> +	}
> +
> +	return ret;
>  }
>  
>  static ssize_t store_scaling_min_freq
> -- 
> 2.17.1

-- 
viresh
