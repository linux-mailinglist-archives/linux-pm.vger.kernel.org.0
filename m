Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6629A6DC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444472AbgJ0IrI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:47:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:49696 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395489AbgJ0IrH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Oct 2020 04:47:07 -0400
IronPort-SDR: AzEJ2m8Q/gXlzkLPlsfi8IR2T66Hfn/vze5I/L2abBytfbkOyzMVOK2HQlQv8Uep5flw+dJNWO
 T+n8bnJ9Wq8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="185785440"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="185785440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:47:07 -0700
IronPort-SDR: pkB0yZgBu4yrbBvF/VdPfd24RDOD1EXaLC5jcnqqXO/+KplfTJP5kBgA7CuGBvMx435HyxF/GG
 LFHOthsbjGpw==
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="525812017"
Received: from zzhao15-mobl1.ccr.corp.intel.com ([10.255.30.125])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:47:05 -0700
Message-ID: <c4ee77a4c25788a4b65b6e081c61d4ac1933c08f.camel@intel.com>
Subject: Re: [PATCH v2 2/4] cpufreq: intel_pstate: Avoid missing HWP max
 updates in passive mode
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Tue, 27 Oct 2020 16:47:02 +0800
In-Reply-To: <3212190.yEXfVNHMLB@kreacher>
References: <2183878.gTFULuzKx9@kreacher> <3212190.yEXfVNHMLB@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-10-23 at 17:35 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the cpufreq policy max limit is changed when intel_pstate operates
> in the passive mode with HWP enabled and the "powersave" governor is
> used on top of it, the HWP max limit is not updated as appropriate.
> 
> Namely, in the "powersave" governor case, the target P-state
> is always equal to the policy min limit, so if the latter does
> not change, intel_cpufreq_adjust_hwp() is not invoked to update
> the HWP Request MSR due to the "target_pstate != old_pstate" check
> in intel_cpufreq_update_pstate(), so the HWP max limit is not
> updated as a result.
> 
> Also, if the CPUFREQ_NEED_UPDATE_LIMITS flag is not set for the
> driver and the target frequency does not change along with the
> policy max limit, the "target_freq == policy->cur" check in
> __cpufreq_driver_target() prevents the driver's ->target() callback
> from being invoked at all, so the HWP max limit is not updated.
> 
> To prevent that occurring, set the CPUFREQ_NEED_UPDATE_LIMITS flag
> in the intel_cpufreq driver structure if HWP is enabled and modify
> intel_cpufreq_update_pstate() to do the "target_pstate != old_pstate"
> check only in the non-HWP case and let intel_cpufreq_adjust_hwp()
> always run in the HWP case (it will update HWP Request only if the
> cached value of the register is different from the new one including
> the limits, so if neither the target P-state value nor the max limit
> changes, the register write will still be avoided).
> 
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode
> with HWP enabled")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I have confirmed that the problem is gone with this patch series
applied.
The HWP register is updated after changing the scaling_max_freq sysfs
attribute, with powersave governor.

Tested-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
> 
> The v2 is just the intel_pstate changes (without the core changes)
> and setting
> the new flag.
> 
> ---
>  drivers/cpufreq/intel_pstate.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2550,14 +2550,12 @@ static int intel_cpufreq_update_pstate(s
>  	int old_pstate = cpu->pstate.current_pstate;
>  
>  	target_pstate = intel_pstate_prepare_request(cpu,
> target_pstate);
> -	if (target_pstate != old_pstate) {
> +	if (hwp_active) {
> +		intel_cpufreq_adjust_hwp(cpu, target_pstate,
> fast_switch);
> +		cpu->pstate.current_pstate = target_pstate;
> +	} else if (target_pstate != old_pstate) {
> +		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate,
> fast_switch);
>  		cpu->pstate.current_pstate = target_pstate;
> -		if (hwp_active)
> -			intel_cpufreq_adjust_hwp(cpu, target_pstate,
> -						 fast_switch);
> -		else
> -			intel_cpufreq_adjust_perf_ctl(cpu,
> target_pstate,
> -						      fast_switch);
>  	}
>  
>  	intel_cpufreq_trace(cpu, fast_switch ?
> INTEL_PSTATE_TRACE_FAST_SWITCH :
> @@ -3014,6 +3012,7 @@ static int __init intel_pstate_init(void
>  			hwp_mode_bdw = id->driver_data;
>  			intel_pstate.attr = hwp_cpufreq_attrs;
>  			intel_cpufreq.attr = hwp_cpufreq_attrs;
> +			intel_cpufreq.flags |=
> CPUFREQ_NEED_UPDATE_LIMITS;
>  			if (!default_driver)
>  				default_driver = &intel_pstate;
>  
> 
> 
> 

