Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8337C2D26A0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgLHIwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 03:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgLHIwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 03:52:36 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115AC061749
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 00:51:50 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g18so11606969pgk.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 00:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4EpXoHXL4k0cYEYjbXCM3qqNNX/ao/lS1FFGU2tbAsI=;
        b=npafHANG5pXcGj4u2NdXisvah9MRC0V7E4vMXhflCDTzfT9Qe0koYZDXIDRY6Y05mt
         hEfBYI7dpxRFVMEvBVY9TZhBWiM3Lro1HfeWmMpoksUFutBn0sDFqAEsMV7F4Kz+LGBd
         jqDlXEoMkuHatGoik1tgSb4zyBTj3ujruNA/Cw41TOye5EX/9m9sf3yAG9aknrsWOVX2
         CmySvEeotBmGCZpwmOTgb9I2TtO+TLQryAryqm6YV/JA7nPOKZE1RrSieFZRqmfaf7QV
         n3eDQJUXilGaKFbL2+MIkj7KpG2Q5YYt38+euySILQmt1Icx7qYL8ScvZSMt9HtSAVNF
         1VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4EpXoHXL4k0cYEYjbXCM3qqNNX/ao/lS1FFGU2tbAsI=;
        b=eCxBZqizV2pz/Ip+KKowFKwSyE7Vj4OPXffZwKdgVPZ6OjrM2Kv8T8WgOugPNNf0sf
         v0CxY7URTLZwbFzJHmlN+zqbgZHMFF7RyHECJbSW1tN+kBBfTEsXtK+xOBhip5m65eBZ
         d/YUmifNvm2o3demXR5JGuOwXDcwfI+7ktFyygWJ67QkyEi5yJMRnOM/X3s2us9PvZQs
         XCVZdTaP3O/IcS6wkZaKlLNwLEJ2LlSrP2j1GymweQTXDsrLUDy1iTMdGaYnVWcJYPVV
         cu4yPugH3WbG0oNFHbHGLmTqS7X607PtyVGxVo+sx/ugOl/gDqOTpqRqHiLqEag+/Xrq
         1piw==
X-Gm-Message-State: AOAM530o3LuCjYrlubUGhDC9jd+TcfLEPlesfhQcnyxk1/naNRNxY2pR
        wpr4Ynd9Z84qfPaUltnWpywdgQ==
X-Google-Smtp-Source: ABdhPJzIUxxjW1A8LrW3wOYE5e6yVtI0yhINTYPuqVh3vPFj1BR1ngHnYCPJKiFEdfhzAJGCY1cfuQ==
X-Received: by 2002:a17:90a:6f42:: with SMTP id d60mr3298129pjk.44.1607417509662;
        Tue, 08 Dec 2020 00:51:49 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id e29sm14173828pfj.174.2020.12.08.00.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 00:51:48 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:21:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 2/4] cpufreq: schedutil: Adjust utilization instead of
 frequency
Message-ID: <20201208085146.pzem6t3mt44xwxkm@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <1916732.tSaCp9PeQq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1916732.tSaCp9PeQq@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-12-20, 17:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When avoiding reduction of the frequency after the target CPU has
> been busy since the previous frequency update, adjust the utilization
> instead of adjusting the frequency, because doing so is more prudent
> (it is done to counter a possible utilization deficit after all) and
> it will allow some code to be shared after a subsequent change.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -437,7 +437,7 @@ static void sugov_update_single(struct u
>  {
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> -	unsigned int cached_freq = sg_policy->cached_raw_freq;
> +	unsigned long prev_util = sg_cpu->util;
>  	unsigned int next_f;
>  
>  	sugov_iowait_boost(sg_cpu, time, flags);
> @@ -451,17 +451,14 @@ static void sugov_update_single(struct u
>  	sugov_get_util(sg_cpu);
>  	sugov_iowait_apply(sg_cpu, time);
>  
> -	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
>  	/*
>  	 * Do not reduce the frequency if the CPU has not been idle
>  	 * recently, as the reduction is likely to be premature then.
>  	 */
> -	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> -		next_f = sg_policy->next_freq;
> +	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> +		sg_cpu->util = prev_util;
>  
> -		/* Restore cached freq as next_freq has changed */
> -		sg_policy->cached_raw_freq = cached_freq;
> -	}
> +	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);

I don't think we can replace freq comparison by util, or at least it will give
us a different final frequency and the behavior is changed.

Lets take an example, lets say current freq is 1 GHz and max is 1024.

Round 1: Lets say util is 1000

next_f = 1GHz * 1.25 * 1000/1024 = 1.2 GHz

Round 2: Lets say util has come down to 900 here,

before the patch:

next_f = 1.2 GHz * 1.25 * 900/1024 = 1.31 GHz

after the patch:

next_f = 1.2 GHz * 1.25 * 1000/1024 = 1.45 GHz

Or did I make a mistake here ?

-- 
viresh
