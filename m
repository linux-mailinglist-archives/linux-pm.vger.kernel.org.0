Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3295285810
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 07:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgJGFMk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 01:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgJGFMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 01:12:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185CCC0613D2
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 22:12:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s19so411521plp.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 22:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqTaxytWvoQI4ISZ9BZG2giK3+8JEgCqbQGbQ3XkJqk=;
        b=LGoPU1XO1ohz1/7KKRrz8tPn+DnsThHNrteOQsE3QbHsBUw3YADJGr8EvvRcMqQgmo
         DNC2+EPoJhQ1Yj7kNjHG3aeDND1FDRI6d95oHKGoBCfCnpcMMNAQ9QtgPs6QYtHoPa3P
         RdILhLbu7q1FIRXcqT2f5u/S7xJkBu6na1OBHwZ9f3rinykP2rNiAEGv0Z/ligd4haab
         A7dohGfhUjxOwrKZz7S8YjwUl1uwQIqEKI5eZ8h5evcz7miTXX9cbDdPa1s2atGA41W0
         cmkmY17f+i+JzRtZVBQW8yHeWEfGmCPv/zxxuzjl6o5DEPaU39cteup81PkE/TLyVVyu
         aT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqTaxytWvoQI4ISZ9BZG2giK3+8JEgCqbQGbQ3XkJqk=;
        b=TOMBRvOYuJsisSyb5rO446SuQXEV4GxqVK01QEgNM0C2gD8lwAMJhXxZoFuSjN+KMg
         JDyVfUPVoGL0EtIS2Y1OTpDpbQvu3/BodIjMYKbJXPbSHh2w88A6QCxCkfFFtoenQlDY
         Jds9N6U/JzrRIyi4Gys86NdI1S0pMOzNMgiqEpozpof6g/UrQ7BcPlAEpx38xNEKhIo2
         o/Cuab/Lgba67H1yWMP/y3BEcZNxfK1QMxBiNTLyn8gv0heTKqdIakL8ALslZfd/l6Ow
         xEaFY6VA3BFJ+WQ3xk+eKJWdpS3GUYmf3kMPKwDB23XVXW/w8CTE/JA3PMZRflvOvf6T
         Qbmw==
X-Gm-Message-State: AOAM531tlr+ZDza4qp4yD8l3aiUDXlkwzLV9nfJW3S0yo2VYK9ogUuC2
        Q+/aK5y80tZBWZLCSE8Z4m2EaQ==
X-Google-Smtp-Source: ABdhPJyuzER3yXOIM1ovZ2IILulDTv2B2tmy94ezorWOc4BP5IEFS/rdo7QZ9htpC8TeUs0pYb5nJQ==
X-Received: by 2002:a17:90a:fa97:: with SMTP id cu23mr1382812pjb.149.1602047559573;
        Tue, 06 Oct 2020 22:12:39 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id y13sm1032771pfl.166.2020.10.06.22.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 22:12:38 -0700 (PDT)
Date:   Wed, 7 Oct 2020 10:42:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq,arm,arm64: restructure definitions of
 arch_set_freq_scale()
Message-ID: <20201007051236.yszspqcx4preezs4@vireshk-i7>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
 <20200924123016.13427-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924123016.13427-2-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-09-20, 13:30, Ionela Voinescu wrote:
> Compared to other arch_* functions, arch_set_freq_scale() has an atypical
> weak definition that can be replaced by a strong architecture specific
> implementation.
> 
> The more typical support for architectural functions involves defining
> an empty stub in a header file if the symbol is not already defined in
> architecture code. Some examples involve:
>  - #define arch_scale_freq_capacity	topology_get_freq_scale
>  - #define arch_scale_freq_invariant	topology_scale_freq_invariant
>  - #define arch_scale_cpu_capacity	topology_get_cpu_scale
>  - #define arch_update_cpu_topology	topology_update_cpu_topology
>  - #define arch_scale_thermal_pressure	topology_get_thermal_pressure
>  - #define arch_set_thermal_pressure	topology_set_thermal_pressure
> 
> Bring arch_set_freq_scale() in line with these functions by renaming it to
> topology_set_freq_scale() in the arch topology driver, and by defining the
> arch_set_freq_scale symbol to point to the new function for arm and arm64.
> 
> While there are other users of the arch_topology driver, this patch defines
> arch_set_freq_scale for arm and arm64 only, due to their existing
> definitions of arch_scale_freq_capacity. This is the getter function of the
> frequency invariance scale factor and without a getter function, the
> setter function - arch_set_freq_scale() has not purpose.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm/include/asm/topology.h   |  1 +
>  arch/arm64/include/asm/topology.h |  1 +
>  drivers/base/arch_topology.c      |  4 ++--
>  drivers/cpufreq/cpufreq.c         |  7 -------
>  include/linux/arch_topology.h     |  2 ++
>  include/linux/cpufreq.h           | 11 ++++++++---
>  6 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 9219e67befbe..e5e3d5ce4d55 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -8,6 +8,7 @@
>  #include <linux/arch_topology.h>
>  
>  /* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_set_freq_scale topology_set_freq_scale
>  #define arch_scale_freq_capacity topology_get_freq_scale
>  #define arch_scale_freq_invariant topology_scale_freq_invariant
>  
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 7cb519473fbd..11a465243f66 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -26,6 +26,7 @@ void topology_scale_freq_tick(void);
>  #endif /* CONFIG_ARM64_AMU_EXTN */
>  
>  /* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_set_freq_scale topology_set_freq_scale
>  #define arch_scale_freq_capacity topology_get_freq_scale
>  #define arch_scale_freq_invariant topology_scale_freq_invariant
>  
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1705c772c273..ae5a596bcf86 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -33,8 +33,8 @@ __weak bool arch_freq_counters_available(const struct cpumask *cpus)
>  }
>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>  
> -void arch_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
> -			 unsigned long max_freq)
> +void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
> +			     unsigned long max_freq)
>  {
>  	unsigned long scale;
>  	int i;
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2ea245a6c0c0..f34d3a3d5ba6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -160,13 +160,6 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
>  }
>  EXPORT_SYMBOL_GPL(get_cpu_idle_time);
>  
> -__weak void arch_set_freq_scale(const struct cpumask *cpus,
> -				unsigned long cur_freq,
> -				unsigned long max_freq)
> -{
> -}
> -EXPORT_SYMBOL_GPL(arch_set_freq_scale);
> -
>  /*
>   * This is a generic cpufreq init() routine which can be used by cpufreq
>   * drivers of SMP systems. It will do following:
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 083df331a3c9..0f6cd6b73a61 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -30,6 +30,8 @@ static inline unsigned long topology_get_freq_scale(int cpu)
>  	return per_cpu(freq_scale, cpu);
>  }
>  
> +void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
> +			     unsigned long max_freq);
>  bool topology_scale_freq_invariant(void);
>  
>  bool arch_freq_counters_available(const struct cpumask *cpus);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9f779fbdbe7b..fa37b1c66443 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1011,9 +1011,14 @@ static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
>  extern void arch_freq_prepare_all(void);
>  extern unsigned int arch_freq_get_on_cpu(int cpu);
>  
> -extern void arch_set_freq_scale(const struct cpumask *cpus,
> -				unsigned long cur_freq,
> -				unsigned long max_freq);
> +#ifndef arch_set_freq_scale
> +static __always_inline
> +void arch_set_freq_scale(const struct cpumask *cpus,
> +			 unsigned long cur_freq,
> +			 unsigned long max_freq)
> +{
> +}
> +#endif
>  
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
