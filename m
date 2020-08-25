Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8342B25120B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHYG1N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgHYG1M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:27:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB5C061755
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:27:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so2996435pgd.12
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVidM+DTa0etm3AdB499M4hN2vodf8rh2Ljj9uw0z7w=;
        b=WJ4xE0+05+VByQbjmot5kNsbm7bZGg6lj81AFRHK95Fkp0+aFDNuEDl0+4mKwBQ82d
         +A2avI/67HMg1FCAyvcq9BneT3FKjrITQA6KJXJUnBd43Q01jLuENoz07uWNG5dig6QI
         DdvaF+WTIdZiFKTxCqepZeyb5ql4KsQFC1H3aldrP719oPwetaAwXtDS6DaBu2esGRJW
         J8GbCV/xuioQ/QLuaPdeSsenETyW9jMM14kbif3wSe6PNIunt4giPYcG+sZCR7zx0KJx
         L1lbiOBVxLu8kFfcNllVvGfSHoMEWwGTtkQTHY57gcXIUzEz2rykGSLfZG+8BbFBADjD
         JdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVidM+DTa0etm3AdB499M4hN2vodf8rh2Ljj9uw0z7w=;
        b=AyHV/tuhppZkGY9Nk+TW2cUP0Br5CgJh0lIr5uoNZridGN3QaIP4maR1+2qauwMj4Q
         7kZFeilhXI3146bqqbWFeFXSeLOpssbCY5GiYQY6EIHhWFAo+DV7NQcf35Lch5t2W+LP
         wMrGrRkDDRBiczLORdVEYB9uHsewzfG3ImY8nENqycPRT7/nT1A+mmphYfjQJXo5/ugg
         tEMG2UIzN0wvNS2AjIELT62/KckflW+3vd9jRCnfZGd0lk2cABE2NM+WSTias/jisDRi
         9XO1ln6TuK7wGe6xIiFOaXdNjm+KWRw+k1jKcc0AYqrXjsXkRFzTEgIm0EvGstjW0Wth
         m/6w==
X-Gm-Message-State: AOAM533+px9UVpOt+kkS8DOi3dtaPmvLEnL7K5RzHPWkGpCCF/8rADAm
        9hvWCEyeS63J75iHIe8r10jQozpY+xoCxw==
X-Google-Smtp-Source: ABdhPJzxwLpBt4+mvsJPGhodUcukL4Y7V1aT4eUKLqhOBUlSiwsvS3bsUWPl9DLeqI55m+1ECA5pqg==
X-Received: by 2002:a62:6186:: with SMTP id v128mr6845818pfb.211.1598336831944;
        Mon, 24 Aug 2020 23:27:11 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id g129sm13763084pfb.33.2020.08.24.23.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 23:27:11 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:57:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200825062709.dlzztu547idco7zw@vireshk-i7>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824210252.27486-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 22:02, Ionela Voinescu wrote:
> Now that the update of the FI scale factor is done in cpufreq core for
> selected functions - target(), target_index() and fast_switch(),
> we can provide feedback to the task scheduler and architecture code
> on whether cpufreq supports FI.
> 
> For this purpose provide an external function to expose whether the
> cpufreq drivers support FI, by using a static key.
> 
> The logic behind the enablement of cpufreq-based invariance is as
> follows:
>  - cpufreq-based invariance is disabled by default
>  - cpufreq-based invariance is enabled if any of the callbacks
>    above is implemented while the unsupported setpolicy() is not
> 
> The cpufreq_supports_freq_invariance() function only returns whether
> cpufreq is instrumented with the arch_set_freq_scale() calls that
> result in support for frequency invariance. Due to the lack of knowledge
> on whether the implementation of arch_set_freq_scale() actually results
> in the setting of a scale factor based on cpufreq information, it is up
> to the architecture code to ensure the setting and provision of the
> scale factor to the scheduler.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 20 ++++++++++++++++++++
>  include/linux/cpufreq.h   |  5 +++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 34533c6b3bd0..b3a7d1cc5e92 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  
> +/* Mark support for the scheduler's frequency invariance engine */
> +static DEFINE_STATIC_KEY_FALSE(cpufreq_freq_invariance);
> +
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>  
> @@ -69,6 +72,20 @@ static inline bool has_target(void)
>  	return cpufreq_driver->target_index || cpufreq_driver->target;
>  }
>  
> +static inline
> +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> +{
> +	if (!driver->setpolicy) {
> +		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
> +		pr_debug("supports frequency invariance");
> +	}
> +}
> +

I would rather open-code this int the cpufreq_register_driver() routine as
that's what is done in cpufreq_unregister_driver() as well.

> +bool cpufreq_supports_freq_invariance(void)
> +{
> +	return static_branch_likely(&cpufreq_freq_invariance);
> +}
> +

And would keep the definition of the static key with this routine at a single
place.

>  /* internal prototypes */
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
>  static int cpufreq_init_governor(struct cpufreq_policy *policy);
> @@ -2721,6 +2738,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  	cpufreq_driver = driver_data;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> +	enable_cpufreq_freq_invariance(cpufreq_driver);
> +
>  	if (driver_data->setpolicy)
>  		driver_data->flags |= CPUFREQ_CONST_LOOPS;
>  
> @@ -2790,6 +2809,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  	cpus_read_lock();
>  	subsys_interface_unregister(&cpufreq_interface);
>  	remove_boost_sysfs_file();
> +	static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
>  	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 8f141d4c859c..091df9968945 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -217,6 +217,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
>  bool have_governor_per_policy(void);
> +bool cpufreq_supports_freq_invariance(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> @@ -237,6 +238,10 @@ static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
>  {
>  	return 0;
>  }
> +static inline bool cpufreq_supports_freq_invariance(void)
> +{
> +	return false;
> +}
>  static inline void disable_cpufreq(void) { }
>  #endif
>  
> -- 
> 2.17.1

-- 
viresh
