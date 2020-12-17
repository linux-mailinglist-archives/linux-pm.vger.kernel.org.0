Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875962DD2EA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 15:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgLQOVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 09:21:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:50332 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgLQOVf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 09:21:35 -0500
IronPort-SDR: DPRK4vC76mlpRcImIyYo/w5I86O9bK1Q6a+4Mirc8/V3q+Z/k6GaBxfM2Vlb9eNeXWRmHLuxYE
 v2v0eAWsJFpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="193650969"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="193650969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 06:19:22 -0800
IronPort-SDR: fOAH7ukgB26MJsFvhANElmPwBaaoiLsDLhTTvLtxkCq8qNiEcBZRoQdlDOoDr3/LopDYw0CZkZ
 j8ZxR6ZQ/Icg==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="342505216"
Received: from apstasen-mobl.amr.corp.intel.com ([10.212.63.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 06:19:18 -0800
Message-ID: <d581bfe77c2fc4ff266bb155cf610f176c786e2e.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use the latest guaranteed freq
 during verify
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Dec 2020 06:19:13 -0800
In-Reply-To: <CAJZ5v0ghXA=mao_S-VH-x0_0uvGYK_oWj10f-A=u0w82tXDg5Q@mail.gmail.com>
References: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0ghXA=mao_S-VH-x0_0uvGYK_oWj10f-A=u0w82tXDg5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-12-17 at 14:58 +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 17, 2020 at 11:44 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > This change tries to address an issue, when BIOS disabled turbo
> > but HWP_CAP guaranteed is changed later and user space wants to
> > take
> > advantage of this increased guaranteed performance.
> > 
> > The HWP_CAP.GUARANTEED value is not a static value. It can be
> > changed
> > by some out of band agent or during Intel Speed Select performance
> > level change. The HWP_CAP.MAX still shows max possible performance
> > when
> > BIOS disabled turbo. So guaranteed can still change as long as this
> > is
> > same or below HWP_CAP.MAX.
> > 
> > When guaranteed is changed, the sysfs base_frequency attributes
> > shows
> > the latest guaranteed frequency. This attribute can be used by user
> > space software to update scaling min/max frequency.
> > 
> > Currently the setpolicy callback already uses the latest HWP_CAP
> > values when setting HWP_REQ. But the verify callback will still
> > restrict
> > the user settings to the to old guaranteed value. So if the
> > guaranteed
> > is increased, user space can't take advantage of it.
> > 
> > To solve this similar to setpolicy callback, read the latest
> > HWP_CAP
> > values and use it to restrict the maximum setting. This is done by
> > calling intel_pstate_get_hwp_max(), which already accounts for user
> > and BIOS turbo disable to get the current max performance.
> > 
> > This issue is side effect of fixing the issue of scaling frequency
> > limits by the
> >  'commit eacc9c5a927e ("cpufreq: intel_pstate:
> >  Fix intel_pstate_get_hwp_max() for turbo disabled")'
> > The fix resulted in correct setting of reduced scaling frequencies,
> > but this resulted in capping HWP.REQ to HWP_CAP.GUARANTEED in this
> > case.
> > 
> > Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 2a4db856222f..7081d1edb22b 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2199,6 +2199,12 @@ static void
> > intel_pstate_clear_update_util_hook(unsigned int cpu)
> > 
> >  static int intel_pstate_get_max_freq(struct cpudata *cpu)
> >  {
> > +       if (hwp_active) {
> > +               int turbo_max, max_state;
> > +
> > +               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
> > &max_state);
> 
> This would cause intel_pstate_get_hwp_max() to be called twice in
> intel_pstate_update_perf_limits() which is not perfect.

We can optimize by using cached value.


diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index 7081d1edb22b..d345c9ef240c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2223,7 +2223,11 @@ static void
intel_pstate_update_perf_limits(struct cpudata *cpu,
         * rather than pure ratios.
         */
        if (hwp_active) {
-               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
&max_state);
+               if (global.no_turbo || global.turbo_disabled)
+                       max_state = HWP_GUARANTEED_PERF(cpu-
>hwp_cap_cached);
+               else
+                       max_state = HWP_HIGHEST_PERF(cpu-
>hwp_cap_cached);
+               turbo_max = HWP_HIGHEST_PERF(cpu->hwp_cached);
        } else {
                max_state = global.no_turbo || global.turbo_disabled ?
                        cpu->pstate.max_pstate : cpu-
>pstate.turbo_pstate;


Thanks,
Srinivas


> 
> > +               return max_state * cpu->pstate.scaling;
> > +       }
> >         return global.turbo_disabled || global.no_turbo ?
> >                         cpu->pstate.max_freq : cpu-
> > >pstate.turbo_freq;
> >  }
> > --


