Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18A21099E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgGAKq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgGAKqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 06:46:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7565C061755
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 03:46:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so9754015plo.7
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c180/7FwpKvGEyHWGqPQnUSjW+5tKdGdhB+WYAhbUtw=;
        b=yAcy24wDSVycHCzzXqdHmHO383EIfzESnJ5+e9LLU3voHw5/kFs0ctGT/VIwI7ayvG
         tV93akfWqwN7WxIay8trsTgXmPB+DH2XsxW50DMZ0eb1M1HCrpb0DwpIvOqumbuPrMkM
         CV4dGl3lc2UjH5cmSSoEJp63ZvleACcUSg+kROiS4uBe72vXBmTNOeJgF4lvlt79CQKH
         Yr+1PkElWMcMaz6AfW//aZE/4Tmy0X/EQW0QxMBX7P95piPN4yEhIxnX/rog964qex4v
         FqshgQRASz0dyR/kL1C9PcAsWjw7vhb5pK+m737nX+QRnL4mXJpBaxPUv4LGZ3jKCnUC
         VFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c180/7FwpKvGEyHWGqPQnUSjW+5tKdGdhB+WYAhbUtw=;
        b=Q8Q74mbbTeir6udXfEJIgTqravIf2hT2l3xJBGtfz53hphRNHbwOjxA78CCjdwah3u
         yMy1I/mexk/AunwzJ92a52523a232243WAw4waZ9PzfHew+5/mx45qOTcTp02v6ylEe6
         wEUgImR0/++ueHNzOn61VItoto0OMp6hBvv9RafWSEIeiTOlgel3qyiUxoWL3StN5MV+
         42x2TFo3KisLf717lVbdPkUDGg6rY6Sv0Z6E0+X3ojETdgnxkkA+V7jl2m1Pw8rWSxVe
         cp5Xgld0yOPxdZzdoGZiAyrRlUHXW4yIzp2QJ7BGAIbMbH7hfu+qrOpxxq9wg3y6t5sC
         edFA==
X-Gm-Message-State: AOAM532kw63320fO7XQ2drku/YD93jXgGWM86J9epPgcpTBJOU4QrCMJ
        F75GmflzUBr4czAqJku4b3CtmQ==
X-Google-Smtp-Source: ABdhPJxb/cvAYrJDaZ7c/DxEM5reEp4PZNjRsWCCJf8rgvWFDpZGsfjETYJx1oHhez60juA7xprI8g==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr21110617plc.226.1593600384493;
        Wed, 01 Jul 2020 03:46:24 -0700 (PDT)
Received: from localhost ([122.172.81.75])
        by smtp.gmail.com with ESMTPSA id h6sm5425478pfo.123.2020.07.01.03.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 03:46:22 -0700 (PDT)
Date:   Wed, 1 Jul 2020 16:16:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] cpufreq: report whether cpufreq supports Frequency
 Invariance (FI)
Message-ID: <20200701104620.lxhxty7gymjlagp6@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-6-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701090751.7543-6-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 10:07, Ionela Voinescu wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 83b58483a39b..60b5272c5d80 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -59,6 +59,9 @@ static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  
> +/* Mark support for the scheduler's frequency invariance engine */
> +static DEFINE_STATIC_KEY_FALSE(cpufreq_set_freq_scale);
> +
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>  
> @@ -67,6 +70,26 @@ static inline bool has_target(void)
>  	return cpufreq_driver->target_index || cpufreq_driver->target;
>  }
>  
> +static inline
> +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> +{
> +	if ((driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE) ||
> +	    ((driver->target_index || driver->fast_switch)
> +	     && !(driver->target || driver->setpolicy))) {

This will get simplified with the way I suggested it I believe.

> +
> +		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> +		pr_debug("%s: Driver %s can provide frequency invariance.",
> +			 __func__, driver->name);
> +	} else
> +		pr_err("%s: Driver %s cannot provide frequency invariance.",
> +		__func__, driver->name);
> +}
> +
> +bool cpufreq_sets_freq_scale(void)
> +{
> +	return static_branch_likely(&cpufreq_set_freq_scale);
> +}
> +
>  /* internal prototypes */
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
>  static int cpufreq_init_governor(struct cpufreq_policy *policy);
> @@ -2713,6 +2736,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  	cpufreq_driver = driver_data;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> +	enable_cpufreq_freq_invariance(cpufreq_driver);
> +
>  	if (driver_data->setpolicy)
>  		driver_data->flags |= CPUFREQ_CONST_LOOPS;
>  
> @@ -2782,6 +2807,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  	cpus_read_lock();
>  	subsys_interface_unregister(&cpufreq_interface);
>  	remove_boost_sysfs_file();
> +	static_branch_disable_cpuslocked(&cpufreq_set_freq_scale);
>  	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 42668588f9f8..8b6369d657bd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -217,6 +217,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
>  bool have_governor_per_policy(void);
> +bool cpufreq_sets_freq_scale(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> @@ -237,6 +238,10 @@ static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
>  {
>  	return 0;
>  }
> +static inline bool cpufreq_sets_freq_scale(void)
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
