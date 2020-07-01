Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12421099D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgGAKqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgGAKqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 06:46:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D4C061755
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 03:46:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so9760454pls.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FP3q9Hc118M+PIpoZ3gBkp91qt3AttuGKhN6mO4qL+M=;
        b=XD6YuGM9iKVfQi3Z/Eo2YIh+67TKz1FOxI2pMbOF2fdzKj4x/ZrHc9lj3PEa44zkE9
         QI1LjHA9Gl9WjM0zzyeXn3ZqB5HXWdcaPvr7/zgbHq5KhfCvICfkN4MHr8FAkIPlLvzN
         KkUTwTbPWFRUKcJDisqBoSnbKPWPXwrfGiBYGZKP8E0Ln2fdfJBpIpyPYbMb/iJqfT3N
         sYjp9VizzuwtgSIAyGNq/9Tg6cUu439NE4bnoMfswrxOvG9M5B28Nnh5+nMRXCicapP1
         +wAaRVvT0+tsZZ9iKrFyRSSyvbxcwBYHJyrkVxq8CAA8e8OjTYnNRbudWl8MOkuvIOlH
         7gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FP3q9Hc118M+PIpoZ3gBkp91qt3AttuGKhN6mO4qL+M=;
        b=gHGtlV9M6AklvcLzog+/c0tDqqKAbo+Cq/TZedf0taapFoY+ZxuPtC6y4qyIYcoTub
         42xGYGbHang/OErpivbHRybOsPWVZoHUSgsymv0qqLjnOuocBNbzXwc/9zMi7o2HYHqs
         0e+HympYACauqjRdD6uA/oolTDZ4vBpeB6fswCTUuiHTn6WJNFhl2b6lEze8+YO1nvKD
         DVgIabxuxBbJgJV14nMHyUM8296JFUM4fRuOhT6IlgzJzqVyVRIAAoAruLzihOYUCEgL
         S/mRaLoHyLCgS/tsyUhr8cfW5poNwSj211XNHoQN6czVfWZdZnAHzOPvCVEQhJtK89/3
         p0iQ==
X-Gm-Message-State: AOAM533g7kEY5wJHfUJe6aZjGVGC7EL2feGk10nEhZdQyGjWMqHUeGwG
        dBizgqbAi96X8qiOFRbeZpvyYg==
X-Google-Smtp-Source: ABdhPJwLv9We7Z/3I+LHoShx7LVt8N7F9Lsqh+Ev8MHD230A5RWIRxuOzFuIs+m6GJAlvS45fezEeg==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr29109520pjb.190.1593600381864;
        Wed, 01 Jul 2020 03:46:21 -0700 (PDT)
Received: from localhost ([122.172.81.75])
        by smtp.gmail.com with ESMTPSA id r13sm5547968pfr.181.2020.07.01.03.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 03:46:21 -0700 (PDT)
Date:   Wed, 1 Jul 2020 16:16:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] cpufreq: move invariance setter calls in cpufreq core
Message-ID: <20200701095219.gxrkowtukosnfmwp@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701090751.7543-3-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 10:07, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> To properly scale its per-entity load-tracking signals, the task scheduler
> needs to be given a frequency scale factor, i.e. some image of the current
> frequency the CPU is running at. Currently, this scale can be computed
> either by using counters (APERF/MPERF on x86, AMU on arm64), or by
> piggy-backing on the frequency selection done by cpufreq.
> 
> For the latter, drivers have to explicitly set the scale factor
> themselves, despite it being purely boiler-plate code: the required
> information depends entirely on the kind of frequency switch callback
> implemented by the driver, i.e. either of: target_index(), target(),
> fast_switch() and setpolicy().
> 
> The fitness of those callbacks with regard to driving the Frequency
> Invariance Engine (FIE) is studied below:
> 
> target_index()
> ==============
> Documentation states that the chosen frequency "must be determined by
> freq_table[index].frequency". It isn't clear if it *has* to be that
> frequency, or if it can use that frequency value to do some computation
> that ultimately leads to a different frequency selection. All drivers
> go for the former, while the vexpress-spc-cpufreq has an atypical
> implementation.
> 
> Thefore, the hook works on the asusmption the core can use
> freq_table[index].frequency.
> 
> target()
> =======
> This has been flagged as deprecated since:
> 
>   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> 
> It also doesn't have that many users:
> 
>   cpufreq-nforce2.c:371:2:	.target = nforce2_target,
>   cppc_cpufreq.c:416:2:		.target = cppc_cpufreq_set_target,
>   pcc-cpufreq.c:573:2:		.target = pcc_cpufreq_target,
> 
> Should we care about drivers using this hook, we may be able to exploit
> cpufreq_freq_transition_{being, end}(). Otherwise, if FIE support is
> desired in their current state, arch_set_freq_scale() could still be
> called directly by the driver, while CPUFREQ_CUSTOM_SET_FREQ_SCALE
> could be used to mark support for it.
> 
> fast_switch()
> =============
> This callback *has* to return the frequency that was selected.
> 
> setpolicy()
> ===========
> This callback does not have any designated way of informing what was the
> end choice. But there are only two drivers using setpolicy(), and none
> of them have current FIE support:
> 
>   drivers/cpufreq/longrun.c:281:	.setpolicy	= longrun_set_policy,
>   drivers/cpufreq/intel_pstate.c:2215:	.setpolicy	= intel_pstate_set_policy,
> 
> The intel_pstate is known to use counter-driven frequency invariance.

Same for acpi-cpufreq driver as well ?

And I think we should do the freq-invariance thing for all the above categories
nevertheless.

> If FIE support is desired in their current state, arch_set_freq_scale()
> could still be called directly by the driver, while
> CPUFREQ_CUSTOM_SET_FREQ_SCALE could be used to mark support for it.
> 
> Conclusion
> ==========
> 
> Given that the significant majority of current FIE enabled drivers use
> callbacks that lend themselves to triggering the setting of the FIE scale
> factor in a generic way, move the invariance setter calls to cpufreq core,
> while filtering drivers that flag custom support using
> CPUFREQ_CUSTOM_SET_FREQ_SCALE.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0128de3603df..83b58483a39b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2046,9 +2046,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  					unsigned int target_freq)
>  {
> +	unsigned int freq;
> +
>  	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +	freq = cpufreq_driver->fast_switch(policy, target_freq);
> +

> +	if (freq && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
> +		arch_set_freq_scale(policy->related_cpus, freq,
> +				    policy->cpuinfo.max_freq);

This needs to be a separate function.

>  
> -	return cpufreq_driver->fast_switch(policy, target_freq);
> +	return freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>  
> @@ -2140,7 +2147,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>  			    unsigned int relation)
>  {
>  	unsigned int old_target_freq = target_freq;
> -	int index;
> +	int index, retval;
>  
>  	if (cpufreq_disabled())
>  		return -ENODEV;
> @@ -2171,7 +2178,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>  
>  	index = cpufreq_frequency_table_target(policy, target_freq, relation);
>  
> -	return __target_index(policy, index);
> +	retval = __target_index(policy, index);
> +
> +	if (!retval && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
> +		arch_set_freq_scale(policy->related_cpus,
> +				    policy->freq_table[index].frequency,

policy->cur gets updated for both target and target_index type drivers. You can
use that safely. It gets updated after the postchange notification.

> +				    policy->cpuinfo.max_freq);
> +
> +	return retval;
>  }
>  EXPORT_SYMBOL_GPL(__cpufreq_driver_target);

-- 
viresh
