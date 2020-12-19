Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD52DED26
	for <lists+linux-pm@lfdr.de>; Sat, 19 Dec 2020 06:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLSFVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Dec 2020 00:21:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:56415 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgLSFVY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Dec 2020 00:21:24 -0500
IronPort-SDR: IAk/BJPNyvyLmcK+Nk31RXDp4McbCrzHHeHQd3UReN0ZxUGDxIo/wxiVVvMSUhodaCwRpPhZ58
 YkuwJG8j4p+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="193963134"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; 
   d="scan'208";a="193963134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 21:19:39 -0800
IronPort-SDR: AE+E2LV0skps5EhbtDDXuDXQcg/4bNLCviO87GQtjzOZpIlGjU9C2r+6EYITtfMBBA95UQ56fx
 +18eW4zgs2DA==
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; 
   d="scan'208";a="371001050"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 21:19:38 -0800
Message-ID: <dffbe4d3d56f29a985d84dcb9e48c7f6fba0514c.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use most recent guaranteed
 performance values
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Date:   Fri, 18 Dec 2020 21:19:38 -0800
In-Reply-To: <4600970.KDbqdY64fy@kreacher>
References: <4600970.KDbqdY64fy@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-12-17 at 20:17 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When turbo has been disabled by the BIOS, but HWP_CAP.GUARANTEED is
> changed later, user space may want to take advantage of this
> increased
> guaranteed performance.
> 
> HWP_CAP.GUARANTEED is not a static value.  It can be adjusted by an
> out-of-band agent or during an Intel Speed Select performance level
> change.  The HWP_CAP.MAX is still the maximum achievable performance
> with turbo disabled by the BIOS, so HWP_CAP.GUARANTEED can still
> change as long as it remains less than or equal to HWP_CAP.MAX.
> 
> When HWP_CAP.GUARANTEED is changed, the sysfs base_frequency
> attribute shows the most recent guaranteed frequency value. This
> attribute can be used by user space software to update the scaling
> min/max limits of the CPU.
> 
> Currently, the ->setpolicy() callback already uses the latest
> HWP_CAP values when setting HWP_REQ, but the ->verify() callback will
> restrict the user settings to the to old guaranteed performance value
> which prevents user space from making use of the extra CPU capacity
> theoretically available to it after increasing HWP_CAP.GUARANTEED.
> 
> To address this, read HWP_CAP in intel_pstate_verify_cpu_policy()
> to obtain the maximum P-state that can be used and use that to
> confine the policy max limit instead of using the cached and
> possibly stale pstate.max_freq value for this purpose.
> 
> For consistency, update intel_pstate_update_perf_limits() to use the
> maximum available P-state returned by intel_pstate_get_hwp_max() to
> compute the maximum frequency instead of using the return value of
> intel_pstate_get_max_freq() which, again, may be stale.
> 
> This issue is a side-effect of fixing the scaling frequency limits in
> commit eacc9c5a927e ("cpufreq: intel_pstate: Fix
> intel_pstate_get_hwp_max()
> for turbo disabled") which currected 
corrected

Thanks,
Srinivas

> the setting of the reduced scaling
> frequency values, but caused stale HWP_CAP.GUARANTEED to be used in
> the case at hand.
> 
> Fixes: eacc9c5a927e ("cpufreq: intel_pstate: Fix
> intel_pstate_get_hwp_max() for turbo disabled")
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com
> >
> Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2207,9 +2207,9 @@ static void intel_pstate_update_perf_lim
>  					    unsigned int policy_min,
>  					    unsigned int policy_max)
>  {
> -	int max_freq = intel_pstate_get_max_freq(cpu);
>  	int32_t max_policy_perf, min_policy_perf;
>  	int max_state, turbo_max;
> +	int max_freq;
>  
>  	/*
>  	 * HWP needs some special consideration, because on BDX the
> @@ -2223,6 +2223,7 @@ static void intel_pstate_update_perf_lim
>  			cpu->pstate.max_pstate : cpu-
> >pstate.turbo_pstate;
>  		turbo_max = cpu->pstate.turbo_pstate;
>  	}
> +	max_freq = max_state * cpu->pstate.scaling;
>  
>  	max_policy_perf = max_state * policy_max / max_freq;
>  	if (policy_max == policy_min) {
> @@ -2325,9 +2326,18 @@ static void intel_pstate_adjust_policy_m
>  static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
>  					   struct cpufreq_policy_data
> *policy)
>  {
> +	int max_freq;
> +
>  	update_turbo_state();
> -	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     intel_pstate_get_max_freq(cpu));
> +	if (hwp_active) {
> +		int max_state, turbo_max;
> +
> +		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
> &max_state);
> +		max_freq = max_state * cpu->pstate.scaling;
> +	} else {
> +		max_freq = intel_pstate_get_max_freq(cpu);
> +	}
> +	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> max_freq);
>  
>  	intel_pstate_adjust_policy_max(cpu, policy);
>  }
> 
> 
> 

