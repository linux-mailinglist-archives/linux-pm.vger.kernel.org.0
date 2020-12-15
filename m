Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9692DA6DE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 04:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgLODbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 22:31:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:43154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgLODbc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Dec 2020 22:31:32 -0500
IronPort-SDR: EFIWLC1l0TGdJiEfuzeZVEkWOYx8sxl7vkys98vMk4R4WT/wEHDSKHeuXuF9m0Mq22g8chd1sx
 EqXCy9dsg3QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174048843"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="174048843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 19:29:40 -0800
IronPort-SDR: 5xZ6MVb6QXMhP4gVW76yFUaeErYQVeDhl1EX6+RMwVnDHA0o8MU7fn7sufoRSxTdLaPoMLL6SF
 esGdQ2THQWVQ==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="331904563"
Received: from halkumax-mobl.gar.corp.intel.com ([10.215.133.181])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 19:29:34 -0800
Message-ID: <9e771f719f6519d2d9cf0ae2a152c426fd766a6f.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Implement the
 ->adjust_perf() callback
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Date:   Mon, 14 Dec 2020 19:29:18 -0800
In-Reply-To: <1770942.kMzID5dSeU@kreacher>
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
         <1770942.kMzID5dSeU@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-12-14 at 21:09 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make intel_pstate expose the ->adjust_perf() callback when it
> operates in the passive mode with HWP enabled which causes the
> schedutil governor to use that callback instead of ->fast_switch().
> 
> The minimum and target performance-level values passed by the
> governor to ->adjust_perf() are converted to HWP.REQ.MIN and
> HWP.REQ.DESIRED, respectively, which allows the processor to
> adjust its configuration to maximize energy-efficiency while
> providing sufficient capacity.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> 
> v1 -> v2:
>  - No changes.
> 
> ---
>  drivers/cpufreq/intel_pstate.c |   70
> +++++++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2526,20 +2526,19 @@ static void intel_cpufreq_trace(struct c
>                 fp_toint(cpu->iowait_boost * 100));
>  }
>  
> -static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32
> target_pstate,
> -                                    bool strict, bool fast_switch)
> +static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 min,
> u32 max,
> +                                    u32 desired, bool fast_switch)
>  {
>         u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
>  
>         value &= ~HWP_MIN_PERF(~0L);
> -       value |= HWP_MIN_PERF(target_pstate);
> +       value |= HWP_MIN_PERF(min);
>  
> -       /*
> -        * The entire MSR needs to be updated in order to update the
> HWP min
> -        * field in it, so opportunistically update the max too if
> needed.
> -        */
>         value &= ~HWP_MAX_PERF(~0L);
> -       value |= HWP_MAX_PERF(strict ? target_pstate : cpu-
> >max_perf_ratio);
> +       value |= HWP_MAX_PERF(max);
> +
> +       value &= ~HWP_DESIRED_PERF(~0L);
> +       value |= HWP_DESIRED_PERF(desired);
>  
>         if (value == prev)
>                 return;
> @@ -2569,11 +2568,15 @@ static int intel_cpufreq_update_pstate(s
>         int old_pstate = cpu->pstate.current_pstate;
>  
>         target_pstate = intel_pstate_prepare_request(cpu,
> target_pstate);
> -       if (hwp_active)
> -               intel_cpufreq_adjust_hwp(cpu, target_pstate,
> -                                        policy->strict_target,
> fast_switch);
> -       else if (target_pstate != old_pstate)
> +       if (hwp_active) {
> +               int max_pstate = policy->strict_target ?
> +                                       target_pstate : cpu-
> >max_perf_ratio;
> +
> +               intel_cpufreq_adjust_hwp(cpu, target_pstate,
> max_pstate, 0,
> +                                        fast_switch);
> +       } else if (target_pstate != old_pstate) {
>                 intel_cpufreq_adjust_perf_ctl(cpu, target_pstate,
> fast_switch);
> +       }
>  
>         cpu->pstate.current_pstate = target_pstate;
>  
> @@ -2634,6 +2637,47 @@ static unsigned int intel_cpufreq_fast_s
>         return target_pstate * cpu->pstate.scaling;
>  }
>  
> +static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +                                     unsigned long min_perf,
> +                                     unsigned long target_perf,
> +                                     unsigned long capacity)
> +{
> +       struct cpudata *cpu = all_cpu_data[cpunum];
> +       int old_pstate = cpu->pstate.current_pstate;
> +       int cap_pstate, min_pstate, max_pstate, target_pstate;
> +
> +       update_turbo_state();
> +       cap_pstate = global.turbo_disabled ? cpu->pstate.max_pstate :
> +                                            cpu-
> >pstate.turbo_pstate;
> +
> +       /* Optimization: Avoid unnecessary divisions. */
> +
> +       target_pstate = cap_pstate;
> +       if (target_perf < capacity)
> +               target_pstate = DIV_ROUND_UP(cap_pstate *
> target_perf, capacity);
> +
> +       min_pstate = cap_pstate;
> +       if (min_perf < capacity)
> +               min_pstate = DIV_ROUND_UP(cap_pstate * min_perf,
> capacity);
> +
> +       if (min_pstate < cpu->pstate.min_pstate)
> +               min_pstate = cpu->pstate.min_pstate;
> +
> +       if (min_pstate < cpu->min_perf_ratio)
> +               min_pstate = cpu->min_perf_ratio;
> +
> +       max_pstate = min(cap_pstate, cpu->max_perf_ratio);
> +       if (max_pstate < min_pstate)
> +               max_pstate = min_pstate;
> +
> +       target_pstate = clamp_t(int, target_pstate, min_pstate,
> max_pstate);
> +
> +       intel_cpufreq_adjust_hwp(cpu, min_pstate, max_pstate,
> target_pstate, true);
> +
> +       cpu->pstate.current_pstate = target_pstate;
> +       intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH,
> old_pstate);
> +}
> +
>  static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>         int max_state, turbo_max, min_freq, max_freq, ret;
> @@ -3032,6 +3076,8 @@ static int __init intel_pstate_init(void
>                         intel_pstate.attr = hwp_cpufreq_attrs;
>                         intel_cpufreq.attr = hwp_cpufreq_attrs;
>                         intel_cpufreq.flags |=
> CPUFREQ_NEED_UPDATE_LIMITS;
> +                       intel_cpufreq.fast_switch = NULL;
> +                       intel_cpufreq.adjust_perf =
> intel_cpufreq_adjust_perf;
>                         if (!default_driver)
>                                 default_driver = &intel_pstate;
>  
> 
> 
> 


