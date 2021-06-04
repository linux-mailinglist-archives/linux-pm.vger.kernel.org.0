Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5639BF66
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFDSPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 14:15:47 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43928 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 14:15:45 -0400
Received: by mail-pl1-f174.google.com with SMTP id v12so5060784plo.10
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EKbfOFKWeO1l8LjTWTu79/aW7eSLAjA4B68qVQL/awo=;
        b=FjF9M6my3zJ6ZZIR/PuNY82QYh2IP3BMfVB4BgPWpN1GVSWyEDLiV/OhK0qwoSR8S9
         obh6EdC9BJ2FIW3ANpDdgmDXErs9PXZLXx2G2kki3uFj7wEHhHNYmgKWvr09CfmzVA8L
         Ocbqq492yiZ5UuWsp41D+Y688kbJ4/f68ilSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKbfOFKWeO1l8LjTWTu79/aW7eSLAjA4B68qVQL/awo=;
        b=VPq3XWoLAWvmSdmXR3d16ttadnmk4VuetuT4FcfyznyhWDexqw6utIavdaZM5Mp/FX
         yMLm6b/EqBnuqzQEx+cWqc+ftT7gSfa1pI5j6wl64iwavwUnL1S9PSewm9yIRZ//eoxO
         0HH83QPq/AMPyJQWih7jKh1geX/5GIMhzvKOU9Ep6k6hs7RN8SDulWlPBZA7/V5RlLtC
         H/Tb1O3tkcPib995opiJbkPdrwsGI29t4iMQKZB7Qh9luVO41IsC0Je4jePlX72qMX34
         4lGfqcT3hqIH//NFW58grxvSleU7Ctvhb0dKMQgY3mZLttyIiqp4Wvs6ECcm3xX+GPWO
         A1OQ==
X-Gm-Message-State: AOAM531Lp47hjZIaVO+BW0B7teANuaZk1fKa6OCOXN030uvLDp/lXhZJ
        LOeF2iDM1aWeyRZ63rqHqK5YyA==
X-Google-Smtp-Source: ABdhPJyuSUhVMSGsH+9mUNvbRLIjCOTK7r+kQLPUtlmc8Cr9G+kdV6MbDhDnQ05Z+CASTm3lRJ82iQ==
X-Received: by 2002:a17:902:b94a:b029:10d:6f56:eeac with SMTP id h10-20020a170902b94ab029010d6f56eeacmr5562141pls.54.1622830364886;
        Fri, 04 Jun 2021 11:12:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id y20sm2269473pfn.164.2021.06.04.11.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:12:44 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:12:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 2/6] PM / EM: Mark inefficient states
Message-ID: <YLptG5LfKAHlLSkn@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-3-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622804761-126737-3-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:05:57PM +0100, Vincent Donnefort wrote:
> Some SoCs, such as the sd855 have OPPs within the same performance domain,
> whose cost is higher than others with a higher frequency. Even though
> those OPPs are interesting from a cooling perspective, it makes no sense
> to use them when the device can run at full capacity. Those OPPs handicap
> the performance domain, when choosing the most energy-efficient CPU and
> are wasting energy. They are inefficient.
> 
> Hence, add support for such OPPs to the Energy Model. The table can now
> be read skipping inefficient performance states (and by extension,
> inefficient OPPs).
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 757fc60..2531325 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -17,13 +17,25 @@
>   *		device). It can be a total power: static and dynamic.
>   * @cost:	The cost coefficient associated with this level, used during
>   *		energy calculation. Equal to: power * max_frequency / frequency
> + * @flags:	see "em_perf_state flags" description below.
>   */
>  struct em_perf_state {
>  	unsigned long frequency;
>  	unsigned long power;
>  	unsigned long cost;
> +	unsigned long flags;
>  };
>  
> +/*
> + * em_perf_state flags:
> + *
> + * EM_PERF_STATE_INEFFICIENT: The performance state is inefficient. There is
> + * in this em_perf_domain, another performance state with a higher frequency
> + * but a lower or equal power cost. Such inefficient states are ignored when
> + * using em_pd_get_efficient_*() functions.
> + */
> +#define EM_PERF_STATE_INEFFICIENT BIT(0)
> +
>  /**
>   * em_perf_domain - Performance domain
>   * @table:		List of performance states, in ascending order
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index c4871a8..30ab73a 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -2,7 +2,7 @@
>  /*
>   * Energy Model of devices
>   *
> - * Copyright (c) 2018-2020, Arm ltd.
> + * Copyright (c) 2018-2021, Arm ltd.
>   * Written by: Quentin Perret, Arm ltd.
>   * Improvements provided by: Lukasz Luba, Arm ltd.
>   */
> @@ -42,6 +42,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
>  	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
>  	debugfs_create_ulong("power", 0444, d, &ps->power);
>  	debugfs_create_ulong("cost", 0444, d, &ps->cost);
> +	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
>  }
>  
>  static int em_debug_cpus_show(struct seq_file *s, void *unused)
> @@ -160,6 +161,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		table[i].cost = div64_u64(fmax * table[i].power,
>  					  table[i].frequency);
>  		if (table[i].cost >= prev_cost) {
> +			table[i].flags = EM_PERF_STATE_INEFFICIENT;
>  			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
>  				table[i].frequency);
>  		} else {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Please ignore my nit about the curly braces on patch [1/6].
