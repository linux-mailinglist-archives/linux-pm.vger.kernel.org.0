Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8925391CB6
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhEZQMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhEZQMI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 12:12:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D2C061574;
        Wed, 26 May 2021 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6mUbRP+k/ElQT2NSLhhkCbG5TRmWL7xyAE+qYjqwqUI=; b=vboce95T2IrWbEooOATvKq7aYl
        h7/8w2txIo/eztoCCL+NWWyqpztCL7qv5Rc2yvRYpP7eI34EPsTN0WFPT9pjyuQ4lNuk3KxhUeHXy
        lo+GWFUu+AaOOMzPQ83AHGWdYk7ccRMxvGk0lVwg7NElFtEXYNtb0CRCLhN0zzWwQcHwKEuo8t3gX
        mMpd4q3/wWMOLudD8d/14OuWG3zT2OWRzxbp8Y2VVNXG4egHge/4zTN8xF+0wnh4d59Yz7F74SUQg
        YIreOYBnTSqnI9R/iYbbwT/RTJK9FOFEfQ3PYQMPhvw6vXVhE1/1gTohvecqurQPpXJ4GIkCK0umn
        sHfaLpaw==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llw71-00Fcq9-RQ; Wed, 26 May 2021 16:10:27 +0000
Subject: Re: [PATCH] cpufreq: intel_pstate: hybrid: Fix build with CONFIG_ACPI
 unset
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
References: <4337451.LvFx2qVVIh@kreacher>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4f0f3e94-d42a-a0fd-ced6-bd1edd6d471b@infradead.org>
Date:   Wed, 26 May 2021 09:10:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4337451.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/26/21 8:01 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> One of the previous commits introducing hybrid processor support to
> intel_pstate broke build with CONFIG_ACPI unset.
> 
> Fix that and while at it fix up empty stubs of two functions related
> to ACPI CPPC.
> 
> Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hi Rafael,

I still have this build error:

../drivers/cpufreq/intel_pstate.c: In function ‘show_base_frequency’:
../drivers/cpufreq/intel_pstate.c:950:10: error: implicit declaration of function ‘intel_pstate_get_cppc_guranteed’; did you mean ‘intel_pstate_get_epp’? [-Werror=implicit-function-declaration]
  ratio = intel_pstate_get_cppc_guranteed(policy->cpu);


BTW: s/guranteed/guaranteed/g

Thanks.

> ---
>  drivers/cpufreq/intel_pstate.c |   97 +++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -385,9 +385,14 @@ static int intel_pstate_get_cppc_gurante
>  }
>  
>  #else /* CONFIG_ACPI_CPPC_LIB */
> -static void intel_pstate_set_itmt_prio(int cpu)
> +static inline void intel_pstate_set_itmt_prio(int cpu)
>  {
>  }
> +
> +static inline int intel_pstate_get_cppc_guranteed(int cpu)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif /* CONFIG_ACPI_CPPC_LIB */
>  
>  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
> @@ -470,27 +475,6 @@ static void intel_pstate_exit_perf_limit
>  
>  	acpi_processor_unregister_performance(policy->cpu);
>  }
> -#else /* CONFIG_ACPI */
> -static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
> -{
> -}
> -
> -static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
> -{
> -}
> -
> -static inline bool intel_pstate_acpi_pm_profile_server(void)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_ACPI */
> -
> -#ifndef CONFIG_ACPI_CPPC_LIB
> -static int intel_pstate_get_cppc_guranteed(int cpu)
> -{
> -	return -ENOTSUPP;
> -}
> -#endif /* CONFIG_ACPI_CPPC_LIB */
>  
>  static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
>  {
> @@ -505,6 +489,20 @@ static bool intel_pstate_cppc_perf_caps(
>  
>  	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
>  }
> +#else /* CONFIG_ACPI */
> +static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
> +{
> +}
> +
> +static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
> +{
> +}
> +
> +static inline bool intel_pstate_acpi_pm_profile_server(void)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ACPI */
>  
>  static void intel_pstate_hybrid_hwp_perf_ctl_parity(struct cpudata *cpu)
>  {
> @@ -530,7 +528,6 @@ static void intel_pstate_hybrid_hwp_perf
>   */
>  static void intel_pstate_hybrid_hwp_calibrate(struct cpudata *cpu)
>  {
> -	struct cppc_perf_caps caps;
>  	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
>  	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
>  	int perf_ctl_turbo = pstate_funcs.get_turbo();
> @@ -548,33 +545,39 @@ static void intel_pstate_hybrid_hwp_cali
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
> 
> 
> 


-- 
~Randy

