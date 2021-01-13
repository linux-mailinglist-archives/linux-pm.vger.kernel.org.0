Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570152F4FC1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 17:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbhAMQTt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 11:19:49 -0500
Received: from foss.arm.com ([217.140.110.172]:38832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbhAMQTt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Jan 2021 11:19:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53BBD6E;
        Wed, 13 Jan 2021 08:18:57 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674733F66E;
        Wed, 13 Jan 2021 08:18:57 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:18:56 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210113161855.GA32402@arm.com>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
 <28ade070dd80f6f22d6e8fce5db5f0142b428fa9.1608030508.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ade070dd80f6f22d6e8fce5db5f0142b428fa9.1608030508.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I focused for now on the design of the solution and mostly on the
generic code in arch_topology.c, as that will then impact the arm64
code. 

On Tuesday 15 Dec 2020 at 16:46:35 (+0530), Viresh Kumar wrote:
[..]
>  
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index de8587cc119e..07774fb47bc4 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -21,17 +21,65 @@
>  #include <linux/sched.h>
>  #include <linux/smp.h>
>  
> +static DEFINE_PER_CPU(struct scale_freq_tick_data *, sft_data);
> +static struct cpumask scale_freq_tick_mask;
> +
> +static bool supports_scale_freq_tick(const struct cpumask *cpus)
> +{
> +	return cpumask_subset(cpus, &scale_freq_tick_mask);
> +}
> +
>  bool topology_scale_freq_invariant(void)
>  {
>  	return cpufreq_supports_freq_invariance() ||
> -	       arch_freq_counters_available(cpu_online_mask);
> +	       supports_scale_freq_tick(cpu_online_mask);
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I think the names that involve "scale_freq_tick" are unfortunate and
unclear here. arch_scale_freq_tick() is a good wrapper as it refers to
some work being done for FIE on the tick, but for other functions and
structures here, any similar naming makes things unclear.

Basically all FIE related activity on the tick involves counters that
need regular sampling. So I'd suggest to keep to names that give a hint
about the source of information for frequency invariance, as it makes it
more clear what are the options you're choosing between for FIE.

s/supports_scale_freq_tick/supports_scale_freq_counters
s/scale_freq_tick_data/scale_freq_data
s/topology_set_scale_freq_tick/topology_set_scale_freq_source
s/topology_clear_scale_freq_tick/topology_clear_scale_freq_source
s/scale_freq_tick_mask/scale_freq_counters_mask

.. or similar.

> +}
> +
> +void topology_set_scale_freq_tick(struct scale_freq_tick_data *data,
> +				  const struct cpumask *cpus)
> +{
> +	struct scale_freq_tick_data *sftd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpus) {
> +		sftd = per_cpu(sft_data, cpu);
> +
> +		/* Use AMU counters whenever possible */
> +		if (!sftd || sftd->source != SCALE_FREQ_SOURCE_AMU) {

I don't think the arch_topology driver should know anything about AMUs, as
they are an arm64 feature. SCALE_FREQ_SOURCE_ARCH might be better.
This way any architecture that uses the arch topology driver can register
some architected method which should take priority over all other
methods (at least until someone shows up wanting otherwise).

> +			per_cpu(sft_data, cpu) = data;
> +			cpumask_set_cpu(cpu, &scale_freq_tick_mask);
> +		}
> +	}
>  }
> +EXPORT_SYMBOL_GPL(topology_set_scale_freq_tick);
>  
> -__weak bool arch_freq_counters_available(const struct cpumask *cpus)
> +void topology_clear_scale_freq_tick(enum scale_freq_tick_source source,
> +				    const struct cpumask *cpus)
>  {
> -	return false;
> +	struct scale_freq_tick_data *sftd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpus) {
> +		sftd = per_cpu(sft_data, cpu);
> +
> +		if (sftd && sftd->source == source) {
> +			per_cpu(sft_data, cpu) = NULL;
> +			cpumask_clear_cpu(cpu, &scale_freq_tick_mask);
> +		}
> +	}
>  }
> +EXPORT_SYMBOL_GPL(topology_clear_scale_freq_tick);
> +
> +void topology_scale_freq_tick(void)
> +{
> +	struct scale_freq_tick_data *sftd = *this_cpu_ptr(&sft_data);
> +
> +	if (sftd)
> +		sftd->scale_freq();
> +}

What do you think about having a single topology function that handles
all sources of invariance (cpufreq, arch counters, platform counters)?

Snippet of possible code:

"""
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index be6a53ba3e2d..d9b7221b8ea9 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -19,7 +19,7 @@ int pcibus_to_node(struct pci_bus *bus);
 void update_freq_counters_refs(void);
 
 /* Replace task scheduler's default frequency-invariance scale factor setting */
-#define arch_scale_freq_tick topology_scale_freq_tick
+#define arch_scale_freq_tick() topology_set_freq_scale(NULL, 0, 0)
 
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_set_freq_scale topology_set_freq_scale
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 07774fb47bc4..a669963e7b01 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -70,38 +70,27 @@ void topology_clear_scale_freq_tick(enum scale_freq_tick_source source,
 }
 EXPORT_SYMBOL_GPL(topology_clear_scale_freq_tick);
 
-void topology_scale_freq_tick(void)
-{
-	struct scale_freq_tick_data *sftd = *this_cpu_ptr(&sft_data);
-
-	if (sftd)
-		sftd->scale_freq();
-}
-
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 EXPORT_SYMBOL_GPL(freq_scale);
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
 {
+	struct scale_freq_tick_data *sftd;
 	unsigned long scale;
 	int i;
 
-	if (WARN_ON_ONCE(!cur_freq || !max_freq))
-		return;
-
-	/*
-	 * If the use of counters for FIE is enabled, just return as we don't
-	 * want to update the scale factor with information from CPUFREQ.
-	 * Instead the scale factor will be updated from arch_scale_freq_tick.
-	 */
-	if (supports_scale_freq_tick(cpus))
-		return;
-
-	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
-
-	for_each_cpu(i, cpus)
-		per_cpu(freq_scale, i) = scale;
+	/* Retrieve provided method for scale factor setting for current CPU */
+	if (!cpus) {
+		sftd = *this_cpu_ptr(&sft_data);
+		if (sftd)
+			sftd->scale_freq();
+	} else if (cur_freq && max_freq) {
+		/* Use arguments to compute and set scale factor for CPUs */
+		scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
+		for_each_cpu(i, cpus)
+			per_cpu(freq_scale, i) = scale;
+	}
 }
 
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 09205b584ca5..9b41a90fc955 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -44,7 +44,6 @@ struct scale_freq_tick_data {
 	void (*scale_freq)(void);
 };
 
-void topology_scale_freq_tick(void);
 void topology_set_scale_freq_tick(struct scale_freq_tick_data *data, const struct cpumask *cpus);
 void topology_clear_scale_freq_tick(enum scale_freq_tick_source source, const struct cpumask *cpus);
 
"""

This basically says that if there is a method registered for a certain
CPU to set the scale factor, that method should be used. Otherwise,
rely on this default math of obtaining the scale factor based on the
current and maximum frequency arguments, if they are provided.

This could get us rid of supports_scale_freq_tick() and possibly
even the scale_freq_tick_mask. topology_set_scale_freq_tick() and
topology_clear_scale_freq_tick() could also be used to enable and
disable system level invariance (through a static key) so we don't have
to do cpumask checks in topology_scale_freq_invariant().

We might then add a static key to prevent those useless conditions being
evaluated on the tick. But we'll see possible optimisations later.

> +
>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_SYMBOL_GPL(freq_scale);
>  
>  void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
>  			     unsigned long max_freq)
> @@ -47,7 +95,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
>  	 * want to update the scale factor with information from CPUFREQ.
>  	 * Instead the scale factor will be updated from arch_scale_freq_tick.
>  	 */
> -	if (arch_freq_counters_available(cpus))
> +	if (supports_scale_freq_tick(cpus))
>  		return;
>  
>  	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 0f6cd6b73a61..b2422ebef2dd 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -34,7 +34,18 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
>  			     unsigned long max_freq);
>  bool topology_scale_freq_invariant(void);
>  
> -bool arch_freq_counters_available(const struct cpumask *cpus);
> +enum scale_freq_tick_source {
> +	SCALE_FREQ_SOURCE_AMU,
> +};
> +
> +struct scale_freq_tick_data {
> +	enum scale_freq_tick_source source;
> +	void (*scale_freq)(void);
> +};

s/scale_freq/set_freq_scale?

Hope it helps,
Ionela.

> +
> +void topology_scale_freq_tick(void);
> +void topology_set_scale_freq_tick(struct scale_freq_tick_data *data, const struct cpumask *cpus);
> +void topology_clear_scale_freq_tick(enum scale_freq_tick_source source, const struct cpumask *cpus);
>  
>  DECLARE_PER_CPU(unsigned long, thermal_pressure);
>  
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
