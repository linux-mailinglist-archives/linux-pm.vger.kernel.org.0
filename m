Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE78391E6D
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhEZRx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhEZRx4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:53:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC1AC061756;
        Wed, 26 May 2021 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=g6r3DhuhcBYHDoF49+6tYePgM2sV3QUuZufCeWucZ2M=; b=XC25l8YqItpv9f6z6JmI3Q8iQy
        8XmQOVYvHomgHSj6hTcKfCSMfkNXgdOSfFR1cyReNDct95+gB47Nb8uqZ2zrt/kAu+CPUaJ3Uza6r
        W3cA4csRROy5cOKpDaWrgoO+QWAQWzGgFNlW6Z2TuzwyJhfTirPofqc4RS/lhcBmOy9XA5G0+5pVR
        P8DEbN9BoDZf21Kentd/oV3N1q+ow8wxU56dN8COUtu/8KmvmXea1U/urN0YnDjnXIceJlif3Z8y9
        5Hqt3S8JHVQ/z0/HIAXETCALcDo+UwIiz1HwKDHvYoX/gd/EehfIfr2BoRkposJs/RYzI3rjjMUlD
        PVHyx+bw==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llxhc-00GGzQ-K0; Wed, 26 May 2021 17:52:20 +0000
Subject: Re: [PATCH v2] cpufreq: intel_pstate: hybrid: Fix build with
 CONFIG_ACPI unset
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
References: <5486161.DvuYhMxLoT@kreacher>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3bbc34e2-d69c-3a1f-2afe-4564329a2c61@infradead.org>
Date:   Wed, 26 May 2021 10:52:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5486161.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/26/21 10:30 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> One of the previous commits introducing hybrid processor support to
> intel_pstate broke build with CONFIG_ACPI unset.
> 
> Fix that and while at it make empty stubs of two functions related
> to ACPI CPPC static inline and fix a spelling mistake in the name of
> one of them.
> 
> Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  drivers/cpufreq/intel_pstate.c |   91 +++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 43 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -369,7 +369,7 @@ static void intel_pstate_set_itmt_prio(i
>  	}
>  }
>  
> -static int intel_pstate_get_cppc_guranteed(int cpu)
> +static int intel_pstate_get_cppc_guaranteed(int cpu)
>  {
>  	struct cppc_perf_caps cppc_perf;
>  	int ret;
> @@ -385,7 +385,7 @@ static int intel_pstate_get_cppc_gurante
>  }
>  
>  #else /* CONFIG_ACPI_CPPC_LIB */
> -static void intel_pstate_set_itmt_prio(int cpu)
> +static inline void intel_pstate_set_itmt_prio(int cpu)
>  {
>  }
>  #endif /* CONFIG_ACPI_CPPC_LIB */
> @@ -470,6 +470,20 @@ static void intel_pstate_exit_perf_limit
>  
>  	acpi_processor_unregister_performance(policy->cpu);
>  }
> +
> +static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
> +{
> +	return perf && perf <= caps->highest_perf && perf >= caps->lowest_perf;
> +}
> +
> +static bool intel_pstate_cppc_perf_caps(struct cpudata *cpu,
> +					struct cppc_perf_caps *caps)
> +{
> +	if (cppc_get_perf_caps(cpu->cpu, caps))
> +		return false;
> +
> +	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
> +}
>  #else /* CONFIG_ACPI */
>  static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
>  {
> @@ -486,26 +500,12 @@ static inline bool intel_pstate_acpi_pm_
>  #endif /* CONFIG_ACPI */
>  
>  #ifndef CONFIG_ACPI_CPPC_LIB
> -static int intel_pstate_get_cppc_guranteed(int cpu)
> +static inline int intel_pstate_get_cppc_guaranteed(int cpu)
>  {
>  	return -ENOTSUPP;
>  }
>  #endif /* CONFIG_ACPI_CPPC_LIB */
>  
> -static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
> -{
> -	return perf && perf <= caps->highest_perf && perf >= caps->lowest_perf;
> -}
> -
> -static bool intel_pstate_cppc_perf_caps(struct cpudata *cpu,
> -					struct cppc_perf_caps *caps)
> -{
> -	if (cppc_get_perf_caps(cpu->cpu, caps))
> -		return false;
> -
> -	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
> -}
> -
>  static void intel_pstate_hybrid_hwp_perf_ctl_parity(struct cpudata *cpu)
>  {
>  	pr_debug("CPU%d: Using PERF_CTL scaling for HWP\n", cpu->cpu);
> @@ -530,7 +530,6 @@ static void intel_pstate_hybrid_hwp_perf
>   */
>  static void intel_pstate_hybrid_hwp_calibrate(struct cpudata *cpu)
>  {
> -	struct cppc_perf_caps caps;
>  	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
>  	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
>  	int perf_ctl_turbo = pstate_funcs.get_turbo();
> @@ -548,33 +547,39 @@ static void intel_pstate_hybrid_hwp_cali
>  	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpu->cpu, cpu->pstate.max_pstate);
>  	pr_debug("CPU%d: HWP_CAP highest = %d\n", cpu->cpu, cpu->pstate.turbo_pstate);
>  
> -	if (intel_pstate_cppc_perf_caps(cpu, &caps)) {
> -		if (intel_pstate_cppc_perf_valid(caps.nominal_perf, &caps)) {
> -			pr_debug("CPU%d: Using CPPC nominal\n", cpu->cpu);
> -
> -			/*
> -			 * If the CPPC nominal performance is valid, it can be
> -			 * assumed to correspond to cpu_khz.
> -			 */
> -			if (caps.nominal_perf == perf_ctl_max_phys) {
> -				intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
> -				return;
> -			}
> -			scaling = DIV_ROUND_UP(cpu_khz, caps.nominal_perf);
> -		} else if (intel_pstate_cppc_perf_valid(caps.guaranteed_perf, &caps)) {
> -			pr_debug("CPU%d: Using CPPC guaranteed\n", cpu->cpu);
> -
> -			/*
> -			 * If the CPPC guaranteed performance is valid, it can
> -			 * be assumed to correspond to max_freq.
> -			 */
> -			if (caps.guaranteed_perf == perf_ctl_max) {
> -				intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
> -				return;
> +#ifdef CONFIG_ACPI
> +	if (IS_ENABLED(CONFIG_ACPI_CPPC_LIB)) {
> +		struct cppc_perf_caps caps;
> +
> +		if (intel_pstate_cppc_perf_caps(cpu, &caps)) {
> +			if (intel_pstate_cppc_perf_valid(caps.nominal_perf, &caps)) {
> +				pr_debug("CPU%d: Using CPPC nominal\n", cpu->cpu);
> +
> +				/*
> +				 * If the CPPC nominal performance is valid, it
> +				 * can be assumed to correspond to cpu_khz.
> +				 */
> +				if (caps.nominal_perf == perf_ctl_max_phys) {
> +					intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
> +					return;
> +				}
> +				scaling = DIV_ROUND_UP(cpu_khz, caps.nominal_perf);
> +			} else if (intel_pstate_cppc_perf_valid(caps.guaranteed_perf, &caps)) {
> +				pr_debug("CPU%d: Using CPPC guaranteed\n", cpu->cpu);
> +
> +				/*
> +				 * If the CPPC guaranteed performance is valid,
> +				 * it can be assumed to correspond to max_freq.
> +				 */
> +				if (caps.guaranteed_perf == perf_ctl_max) {
> +					intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
> +					return;
> +				}
> +				scaling = DIV_ROUND_UP(max_freq, caps.guaranteed_perf);
>  			}
> -			scaling = DIV_ROUND_UP(max_freq, caps.guaranteed_perf);
>  		}
>  	}
> +#endif
>  	/*
>  	 * If using the CPPC data to compute the HWP-to-frequency scaling factor
>  	 * doesn't work, use the HWP_CAP gauranteed perf for this purpose with
> @@ -944,7 +949,7 @@ static ssize_t show_base_frequency(struc
>  	struct cpudata *cpu = all_cpu_data[policy->cpu];
>  	int ratio, freq;
>  
> -	ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
> +	ratio = intel_pstate_get_cppc_guaranteed(policy->cpu);
>  	if (ratio <= 0) {
>  		u64 cap;
>  
> 
> 
> 


-- 
~Randy

