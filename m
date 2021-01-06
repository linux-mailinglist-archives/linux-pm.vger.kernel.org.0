Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052712EBA4B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbhAFHBf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 02:01:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:8058 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhAFHBf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Jan 2021 02:01:35 -0500
IronPort-SDR: hKPlJKhJD/Vk5FnulSzpjg33L7ZzbkxcpNyInWVflyWuObSX0EOy8GZ21EpUgHtxT/zLBaTc4h
 0RVfunksFYzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="176458239"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="176458239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 22:59:49 -0800
IronPort-SDR: YkBOHaT7Bgo3kpotuQ8x7/w5WAiUGiP5LtwFpLbZhqW+VWzMIahl5UmJYz1IPkZ9cXvbguQmqV
 KUJ/pduk06Tg==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="462583520"
Received: from sabrinaa-mobl.amr.corp.intel.com ([10.213.162.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 22:59:47 -0800
Message-ID: <a232f29236ae1cc6ecd90495a2dc1c38c1488a04.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use HWP capabilities in
 intel_cpufreq_adjust_perf()
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Jan 2021 22:59:43 -0800
In-Reply-To: <1784464.uM0JrOW1fs@kreacher>
References: <1784464.uM0JrOW1fs@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-01-05 at 19:20 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If turbo P-states cannot be used, either due to the configuration of
> the processor, or because intel_pstate is not allowed to used them,
> the maximum available P-state with HWP enabled corresponds to the
> HWP_CAP.GUARANTEED value which is not static.  It can be adjusted by
> an out-of-band agent or during an Intel Speed Select performance
> level change, so long as it remains less than or equal to
> HWP_CAP.MAX.
> 
> However, if turbo P-states cannot be used,
> intel_cpufreq_adjust_perf()
> always uses pstate.max_pstate (set during the initialization of the
> driver only) as the maximum available P-state, so it may miss a
> change
> of the HWP_CAP.GUARANTEED value.
> 
> Prevent that from happening by modifyig intel_cpufreq_adjust_perf()
> to always read the "guaranteed" and "maximum turbo" performance
> levels from the cached HWP_CAP value.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2653,12 +2653,13 @@ static void intel_cpufreq_adjust_perf(un
>                                       unsigned long capacity)
>  {
>         struct cpudata *cpu = all_cpu_data[cpunum];
> +       u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>         int old_pstate = cpu->pstate.current_pstate;
>         int cap_pstate, min_pstate, max_pstate, target_pstate;
>  
>         update_turbo_state();
> -       cap_pstate = global.turbo_disabled ? cpu->pstate.max_pstate :
> -                                            cpu-
> >pstate.turbo_pstate;
> +       cap_pstate = global.turbo_disabled ?
> HWP_GUARANTEED_PERF(hwp_cap) :
> +                                           
> HWP_HIGHEST_PERF(hwp_cap);
>  
>         /* Optimization: Avoid unnecessary divisions. */
>  
> 
> 
> 


