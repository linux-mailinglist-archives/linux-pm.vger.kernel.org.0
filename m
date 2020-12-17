Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F12DD5C4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgLQRL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 12:11:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:45840 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbgLQRL1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 12:11:27 -0500
IronPort-SDR: AXqjJkMVmSod+YFuUk9H0QQcwG573Z+Hty7Gctr5M/OKdwu7DpKm5yQ00X/RfsdChmUfY39DWr
 paBgbD7DMXkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="155095028"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="155095028"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 09:09:40 -0800
IronPort-SDR: IIv2lq8TUBDy1DO7MKHYFV+wIVDzRw2TyyuZadvxxwV7eRLWrIfCtGYwKVFhGV6/ix7kPK/lhB
 qEf9OIlKbK4g==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="387646813"
Received: from ejmar-mobl.amr.corp.intel.com ([10.254.182.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 09:09:31 -0800
Message-ID: <16328b6c4531e676f829601e72dee4a5c2f802a7.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use the latest guaranteed freq
 during verify
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Dec 2020 09:09:19 -0800
In-Reply-To: <CAJZ5v0gfAZrW4jmEEb+h2UpYVoVMLd2P4f_P_R-_+uRytSJ6Pg@mail.gmail.com>
References: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com>
         <d581bfe77c2fc4ff266bb155cf610f176c786e2e.camel@linux.intel.com>
         <93d4eebb5121ad0497af555c55a6ad74b8a06e64.camel@linux.intel.com>
         <8153207.dYVdvtsJbe@kreacher>
         <6ef769aa04ee8e765863fd4af083eb85cdcb4827.camel@linux.intel.com>
         <CAJZ5v0gfAZrW4jmEEb+h2UpYVoVMLd2P4f_P_R-_+uRytSJ6Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-12-17 at 16:24 +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 17, 2020 at 4:21 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Thu, 2020-12-17 at 16:12 +0100, Rafael J. Wysocki wrote:
> > > On Thursday, December 17, 2020 3:23:44 PM CET Srinivas Pandruvada
> > > wrote:
> > > > On Thu, 2020-12-17 at 06:19 -0800, Srinivas Pandruvada wrote:
> > > > > On Thu, 2020-12-17 at 14:58 +0100, Rafael J. Wysocki wrote:
> > > > > > On Thu, Dec 17, 2020 at 11:44 AM Srinivas Pandruvada
> > > > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > > > 
> > > > > > > This change tries to address an issue, when BIOS disabled
> > > > > > > turbo
> > > > > > > but HWP_CAP guaranteed is changed later and user space
> > > > > > > wants
> > > > > > > to
> > > > > > > take
> > > > > > > advantage of this increased guaranteed performance.
> > > > > > > 
> > > > > > > The HWP_CAP.GUARANTEED value is not a static value. It
> > > > > > > can be
> > > > > > > changed
> > > > > > > by some out of band agent or during Intel Speed Select
> > > > > > > performance
> > > > > > > level change. The HWP_CAP.MAX still shows max possible
> > > > > > > performance
> > > > > > > when
> > > > > > > BIOS disabled turbo. So guaranteed can still change as
> > > > > > > long
> > > > > > > as
> > > > > > > this
> > > > > > > is
> > > > > > > same or below HWP_CAP.MAX.
> > > > > > > 
> > > > > > > When guaranteed is changed, the sysfs base_frequency
> > > > > > > attributes
> > > > > > > shows
> > > > > > > the latest guaranteed frequency. This attribute can be
> > > > > > > used
> > > > > > > by
> > > > > > > user
> > > > > > > space software to update scaling min/max frequency.
> > > > > > > 
> > > > > > > Currently the setpolicy callback already uses the latest
> > > > > > > HWP_CAP
> > > > > > > values when setting HWP_REQ. But the verify callback will
> > > > > > > still
> > > > > > > restrict
> > > > > > > the user settings to the to old guaranteed value. So if
> > > > > > > the
> > > > > > > guaranteed
> > > > > > > is increased, user space can't take advantage of it.
> > > > > > > 
> > > > > > > To solve this similar to setpolicy callback, read the
> > > > > > > latest
> > > > > > > HWP_CAP
> > > > > > > values and use it to restrict the maximum setting. This
> > > > > > > is
> > > > > > > done
> > > > > > > by
> > > > > > > calling intel_pstate_get_hwp_max(), which already
> > > > > > > accounts
> > > > > > > for
> > > > > > > user
> > > > > > > and BIOS turbo disable to get the current max
> > > > > > > performance.
> > > > > > > 
> > > > > > > This issue is side effect of fixing the issue of scaling
> > > > > > > frequency
> > > > > > > limits by the
> > > > > > >  'commit eacc9c5a927e ("cpufreq: intel_pstate:
> > > > > > >  Fix intel_pstate_get_hwp_max() for turbo disabled")'
> > > > > > > The fix resulted in correct setting of reduced scaling
> > > > > > > frequencies,
> > > > > > > but this resulted in capping HWP.REQ to
> > > > > > > HWP_CAP.GUARANTEED in
> > > > > > > this
> > > > > > > case.
> > > > > > > 
> > > > > > > Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> > > > > > > Signed-off-by: Srinivas Pandruvada <
> > > > > > > srinivas.pandruvada@linux.intel.com>
> > > > > > > ---
> > > > > > >  drivers/cpufreq/intel_pstate.c | 6 ++++++
> > > > > > >  1 file changed, 6 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > > > index 2a4db856222f..7081d1edb22b 100644
> > > > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > > > @@ -2199,6 +2199,12 @@ static void
> > > > > > > intel_pstate_clear_update_util_hook(unsigned int cpu)
> > > > > > > 
> > > > > > >  static int intel_pstate_get_max_freq(struct cpudata
> > > > > > > *cpu)
> > > > > > >  {
> > > > > > > +       if (hwp_active) {
> > > > > > > +               int turbo_max, max_state;
> > > > > > > +
> > > > > > > +               intel_pstate_get_hwp_max(cpu->cpu,
> > > > > > > &turbo_max,
> > > > > > > &max_state);
> > > > > > 
> > > > > > This would cause intel_pstate_get_hwp_max() to be called
> > > > > > twice
> > > > > > in
> > > > > > intel_pstate_update_perf_limits() which is not perfect.
> > > > > 
> > > > > We can optimize by using cached value.
> > > > > 
> > > > > 
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > index 7081d1edb22b..d345c9ef240c 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -2223,7 +2223,11 @@ static void
> > > > > intel_pstate_update_perf_limits(struct cpudata *cpu,
> > > > >          * rather than pure ratios.
> > > > >          */
> > > > >         if (hwp_active) {
> > > > > -               intel_pstate_get_hwp_max(cpu->cpu,
> > > > > &turbo_max,
> > > > > &max_state);
> > > > > +               if (global.no_turbo || global.turbo_disabled)
> > > > > +                       max_state = HWP_GUARANTEED_PERF(cpu-
> > > > > > hwp_cap_cached);
> > > > > +               else
> > > > > +                       max_state = HWP_HIGHEST_PERF(cpu-
> > > > > > hwp_cap_cached);
> > > > Can use  ternary operator instead of if..else. to further
> > > > simplify.
> > > > 
> > > > > +               turbo_max = HWP_HIGHEST_PERF(cpu-
> > > > > >hwp_cached);
> > > > >         } else {
> > > > >                 max_state = global.no_turbo ||
> > > > > global.turbo_disabled
> > > > > ?
> > > > >                         cpu->pstate.max_pstate : cpu-
> > > > > > pstate.turbo_pstate;
> > > 
> > > Well, would something like the patch below work?
> > > 
> > > ---
> > >  drivers/cpufreq/intel_pstate.c |   16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > > =================================================================
> > > ==
> > > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > > @@ -2207,9 +2207,9 @@ static void intel_pstate_update_perf_lim
> > >                                             unsigned int
> > > policy_min,
> > >                                             unsigned int
> > > policy_max)
> > >  {
> > > -       int max_freq = intel_pstate_get_max_freq(cpu);
> > >         int32_t max_policy_perf, min_policy_perf;
> > >         int max_state, turbo_max;
> > > +       int max_freq;
> > > 
> > >         /*
> > >          * HWP needs some special consideration, because on BDX
> > > the
> > > @@ -2223,6 +2223,7 @@ static void intel_pstate_update_perf_lim
> > >                         cpu->pstate.max_pstate : cpu-
> > > > pstate.turbo_pstate;
> > >                 turbo_max = cpu->pstate.turbo_pstate;
> > >         }
> > > +       max_freq = max_state * cpu->pstate.scaling;
> > > 
> > >         max_policy_perf = max_state * policy_max / max_freq;
> > >         if (policy_max == policy_min) {
> > > @@ -2325,9 +2326,18 @@ static void intel_pstate_adjust_policy_m
> > >  static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
> > >                                            struct
> > > cpufreq_policy_data
> > > *policy)
> > >  {
> > > +       int max_freq;
> > > +
> > >         update_turbo_state();
> > > -       cpufreq_verify_within_limits(policy, policy-
> > > > cpuinfo.min_freq,
> > > -                                   
> > > intel_pstate_get_max_freq(cpu));
> > > +       if (hwp_active) {
> > > +               int max_state, turbo_max;
> > > +
> > > +               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
> > > &max_state);
> > > +               max_freq = max_state * cpu->pstate.scaling;
> > > +       } else {
> > > +               max_freq = intel_pstate_get_max_freq(cpu);
> > > +       }
> > > +       cpufreq_verify_within_limits(policy, policy-
> > > > cpuinfo.min_freq, max_freq);
> > > 
> > >         intel_pstate_adjust_policy_max(cpu, policy);
> > >  }
> > > 
> > Should work.
> >  I will test this patch and let you know once I get the system.
> 
> Please do, thank you!

This works. Please check if you can submit a change for this.

Thanks,
Srinivas

