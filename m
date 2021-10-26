Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0D43B794
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhJZQxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 12:53:22 -0400
Received: from foss.arm.com ([217.140.110.172]:34910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhJZQxP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Oct 2021 12:53:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB061FB;
        Tue, 26 Oct 2021 09:50:50 -0700 (PDT)
Received: from [192.168.185.184] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34BA03F70D;
        Tue, 26 Oct 2021 09:50:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-2-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <431230a5-00e9-0211-0731-035eab5fa3f6@arm.com>
Date:   Tue, 26 Oct 2021 18:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015144550.23719-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2021 16:45, Lukasz Luba wrote:
> The thermal pressure is a mechanism which is used for providing
> information about reduced CPU performance to the scheduler. Usually code
> has to convert the value from frequency units into capacity units,
> which are understandable by the scheduler. Create a common conversion code
> which can be just used via a handy API.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm/include/asm/topology.h   |  1 +
>  arch/arm64/include/asm/topology.h |  1 +
>  drivers/base/arch_topology.c      | 36 ++++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h     |  3 +++
>  include/linux/sched/topology.h    |  7 ++++++
>  5 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 470299ee2fba..aee6c456c085 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -24,6 +24,7 @@
>  /* Replace task scheduler's default thermal pressure API */
>  #define arch_scale_thermal_pressure topology_get_thermal_pressure
>  #define arch_set_thermal_pressure   topology_set_thermal_pressure
> +#define arch_thermal_pressure_update	topology_thermal_pressure_update
>  
>  #else
>  
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index ec2db3419c41..c997015402bc 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -33,6 +33,7 @@ void update_freq_counters_refs(void);
>  /* Replace task scheduler's default thermal pressure API */
>  #define arch_scale_thermal_pressure topology_get_thermal_pressure
>  #define arch_set_thermal_pressure   topology_set_thermal_pressure
> +#define arch_thermal_pressure_update	topology_thermal_pressure_update

s/thermal_pressure_update/update_thermal_pressure ?

The scheme seems to be {arch|topology}_*foo*_thermal_pressure

But ...

>  
>  #include <asm-generic/topology.h>
>  
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 43407665918f..1fa28b5afdb2 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -25,6 +25,7 @@
>  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
> +static DEFINE_PER_CPU(u32, freq_factor) = 1;
>  
>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
>  {
> @@ -168,6 +169,40 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
>  }
>  EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
>  
> +/**
> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
> + * @cpus	: The related CPUs for which capacity has been reduced
> + * @capped_freq	: The maximum allowed frequency that CPUs can run at
> + *
> + * Update the value of thermal pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq must be less or equal to the max possible frequency and
> + * reflects the currently allowed max CPUs frequency due to thermal capping.
> + * The @capped_freq must be provided in kHz.
> + */
> +void topology_thermal_pressure_update(const struct cpumask *cpus,
> +				      unsigned long capped_freq)
> +{

... why not just s/unsigned long th_pressure/unsigned long capped_freq
in existing topology_set_thermal_pressure() and move code the
frequency/capacity conversion in there? The patch set will become
considerably smaller.

 void topology_set_thermal_pressure(const struct cpumask *cpus,
-                              unsigned long th_pressure)
+                              unsigned long capped_freq)
 {
+       unsigned long max_capacity, capacity;
        int cpu;

-       for_each_cpu(cpu, cpus)
-               WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+       if (!cpus)
+               return;
+
+       cpu = cpumask_first(cpus);
+       max_capacity = arch_scale_cpu_capacity(cpu);
+
+       /* Convert to MHz scale which is used in 'freq_factor' */
+       capped_freq /= 1000;
+
+       capacity = mult_frac(capped_freq, max_capacity,
+                            per_cpu(freq_factor, cpu));
+
+       for_each_cpu(cpu, cpus) {
+               WRITE_ONCE(per_cpu(thermal_pressure, cpu),
+                          max_capacity - capacity);
+       }
 }
 EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);

And a user like [drivers/thermal/cpufreq_cooling.c] can call
arch_set_thermal_pressure(cpus, frequency).

[...]
