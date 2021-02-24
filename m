Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C132371A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 07:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhBXGDV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 01:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhBXGDU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 01:03:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D9C06174A
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 22:02:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so610748pjs.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 22:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LG0BhVnu4iz0iyFBpTqgUDFv1szlGALeoWhu9s88OI=;
        b=pStPBhZlG3uqDu09IqRmrBX2CmAUWlU16dzzb3AoOtspcJdh9T+ltKLtdvcy5lx2Yc
         eNQxmycupFYTTrvnhtVYCy4DmMEGvOnMfyYLMKfItegvu+v2VEXI++GLAYY3pWPBBMUw
         ENY4UlETpfHyqe3CZYc/NsCJgFrRgZzxNb4h8aGs6HZ0qKFgwuZ2ExAvEjb7cdov/nbu
         5G7CdN/ajv9/Qhn3S7G40woem9lmTT6K4BA2R+mfEOSpQTb1cY37/ZOZIn6h9IZ5zpg5
         vb92j2IR6ITd0BGl43MZlPbiu9lyq+fghSvrvvm9Ka0YD52lI3RqdL6I1qWX6sHwmc+H
         qAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LG0BhVnu4iz0iyFBpTqgUDFv1szlGALeoWhu9s88OI=;
        b=BZkanrdBnYZ8GXsBAZ+ZMTv9kQWTmkhjghLlrVybSEw4k3mh7rdS50yXgt1Tl9j87F
         ukRjCl+bRGPfx5Z3dz/ZDIpHNsA3h7+q/ze1XtEjdlvoqNPvNJsg4hMR50NI5JHfW7qi
         oXbeL2puGWq2Lx/zfzlzOFmL9OTsbQ9FqUUCGL4MF1QOmcflTXhkKlfubXyAFJ7OyR4R
         moA1Wi0KOA7oVfw1PwcwOMNMZ8NVUSOInlnLWsXRfZ4FJDbTlIKUsmBjerS8KGmGlwEC
         KZIv8dUbbtd1nMAsQa2dtM7W+1YjSpp+ASg2JeDkt/VR+B20VOZ5+dn+p86Aa/lZPLME
         /r8A==
X-Gm-Message-State: AOAM530SfiLPnGcsqXU/7W+Gw8IBria3WcXUGVkmXFSiRO9rQWWD18D5
        0UM3BuDOCs0H13s43JnyaNAqog==
X-Google-Smtp-Source: ABdhPJxmHa2KxrCpl16o3SzE5OINYvcRE9V1xmfGsGQJjERWnl97Q1GZ6CW8y7Zj3IrAsz89X2d5yA==
X-Received: by 2002:a17:90a:4301:: with SMTP id q1mr2674900pjg.57.1614146559264;
        Tue, 23 Feb 2021 22:02:39 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i25sm846441pgb.33.2021.02.23.22.02.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 22:02:38 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:32:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Call sugov_update_next_freq() before
 check to fast_switch_enabled
Message-ID: <20210224060236.xaviwqfsujjvwnne@vireshk-i7>
References: <20210224054232.1222-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224054232.1222-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-21, 13:42, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Note that sugov_update_next_freq() may return false, that means the
> caller sugov_fast_switch() will do nothing except fast switch check.
> 
> Similarly, sugov_deferred_update() also has unnecessary operations
> of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.
> 
> So, let's call sugov_update_next_freq() before the fast switch check
> to avoid unnecessary behaviors above. Update the related interface
> definitions accordingly.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 41e498b..d23e5be 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,19 +114,13 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  	return true;
>  }
>  
> -static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> -			      unsigned int next_freq)
> +static void sugov_fast_switch(struct sugov_policy *sg_policy, unsigned int next_freq)
>  {
> -	if (sugov_update_next_freq(sg_policy, time, next_freq))
> -		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> +	cpufreq_driver_fast_switch(sg_policy->policy, next_freq);

I will call this directly instead, no need of the wrapper anymore.

>  }
>  
> -static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> -				  unsigned int next_freq)
> +static void sugov_deferred_update(struct sugov_policy *sg_policy)
>  {
> -	if (!sugov_update_next_freq(sg_policy, time, next_freq))
> -		return;
> -
>  	if (!sg_policy->work_in_progress) {
>  		sg_policy->work_in_progress = true;
>  		irq_work_queue(&sg_policy->irq_work);
> @@ -368,16 +362,19 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>  		sg_policy->cached_raw_freq = cached_freq;
>  	}
>  
> +	if (!sugov_update_next_freq(sg_policy, time, next_f))
> +		return;
> +
>  	/*
>  	 * This code runs under rq->lock for the target CPU, so it won't run
>  	 * concurrently on two different CPUs for the same target and it is not
>  	 * necessary to acquire the lock in the fast switch case.
>  	 */
>  	if (sg_policy->policy->fast_switch_enabled) {
> -		sugov_fast_switch(sg_policy, time, next_f);
> +		sugov_fast_switch(sg_policy, next_f);
>  	} else {
>  		raw_spin_lock(&sg_policy->update_lock);
> -		sugov_deferred_update(sg_policy, time, next_f);
> +		sugov_deferred_update(sg_policy);
>  		raw_spin_unlock(&sg_policy->update_lock);
>  	}
>  }
> @@ -456,12 +453,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  	if (sugov_should_update_freq(sg_policy, time)) {
>  		next_f = sugov_next_freq_shared(sg_cpu, time);
>  
> +		if (!sugov_update_next_freq(sg_policy, time, next_f))
> +			goto unlock;
> +
>  		if (sg_policy->policy->fast_switch_enabled)
> -			sugov_fast_switch(sg_policy, time, next_f);
> +			sugov_fast_switch(sg_policy, next_f);
>  		else
> -			sugov_deferred_update(sg_policy, time, next_f);
> +			sugov_deferred_update(sg_policy);
>  	}
> -
> +unlock:
>  	raw_spin_unlock(&sg_policy->update_lock);
>  }

-- 
viresh
