Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3A2DD3E0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 16:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQPNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 10:13:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43572 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgLQPNa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 10:13:30 -0500
Received: from 89-64-78-63.dynamic.chello.pl (89.64.78.63) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 205a57d8fdab3123; Thu, 17 Dec 2020 16:12:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use the latest guaranteed freq during verify
Date:   Thu, 17 Dec 2020 16:12:43 +0100
Message-ID: <8153207.dYVdvtsJbe@kreacher>
In-Reply-To: <93d4eebb5121ad0497af555c55a6ad74b8a06e64.camel@linux.intel.com>
References: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com> <d581bfe77c2fc4ff266bb155cf610f176c786e2e.camel@linux.intel.com> <93d4eebb5121ad0497af555c55a6ad74b8a06e64.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, December 17, 2020 3:23:44 PM CET Srinivas Pandruvada wrote:
> On Thu, 2020-12-17 at 06:19 -0800, Srinivas Pandruvada wrote:
> > On Thu, 2020-12-17 at 14:58 +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 17, 2020 at 11:44 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > This change tries to address an issue, when BIOS disabled turbo
> > > > but HWP_CAP guaranteed is changed later and user space wants to
> > > > take
> > > > advantage of this increased guaranteed performance.
> > > > 
> > > > The HWP_CAP.GUARANTEED value is not a static value. It can be
> > > > changed
> > > > by some out of band agent or during Intel Speed Select
> > > > performance
> > > > level change. The HWP_CAP.MAX still shows max possible
> > > > performance
> > > > when
> > > > BIOS disabled turbo. So guaranteed can still change as long as
> > > > this
> > > > is
> > > > same or below HWP_CAP.MAX.
> > > > 
> > > > When guaranteed is changed, the sysfs base_frequency attributes
> > > > shows
> > > > the latest guaranteed frequency. This attribute can be used by
> > > > user
> > > > space software to update scaling min/max frequency.
> > > > 
> > > > Currently the setpolicy callback already uses the latest HWP_CAP
> > > > values when setting HWP_REQ. But the verify callback will still
> > > > restrict
> > > > the user settings to the to old guaranteed value. So if the
> > > > guaranteed
> > > > is increased, user space can't take advantage of it.
> > > > 
> > > > To solve this similar to setpolicy callback, read the latest
> > > > HWP_CAP
> > > > values and use it to restrict the maximum setting. This is done
> > > > by
> > > > calling intel_pstate_get_hwp_max(), which already accounts for
> > > > user
> > > > and BIOS turbo disable to get the current max performance.
> > > > 
> > > > This issue is side effect of fixing the issue of scaling
> > > > frequency
> > > > limits by the
> > > >  'commit eacc9c5a927e ("cpufreq: intel_pstate:
> > > >  Fix intel_pstate_get_hwp_max() for turbo disabled")'
> > > > The fix resulted in correct setting of reduced scaling
> > > > frequencies,
> > > > but this resulted in capping HWP.REQ to HWP_CAP.GUARANTEED in
> > > > this
> > > > case.
> > > > 
> > > > Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> > > > Signed-off-by: Srinivas Pandruvada <
> > > > srinivas.pandruvada@linux.intel.com>
> > > > ---
> > > >  drivers/cpufreq/intel_pstate.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c
> > > > index 2a4db856222f..7081d1edb22b 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -2199,6 +2199,12 @@ static void
> > > > intel_pstate_clear_update_util_hook(unsigned int cpu)
> > > > 
> > > >  static int intel_pstate_get_max_freq(struct cpudata *cpu)
> > > >  {
> > > > +       if (hwp_active) {
> > > > +               int turbo_max, max_state;
> > > > +
> > > > +               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
> > > > &max_state);
> > > 
> > > This would cause intel_pstate_get_hwp_max() to be called twice in
> > > intel_pstate_update_perf_limits() which is not perfect.
> > 
> > We can optimize by using cached value.
> > 
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 7081d1edb22b..d345c9ef240c 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2223,7 +2223,11 @@ static void
> > intel_pstate_update_perf_limits(struct cpudata *cpu,
> >          * rather than pure ratios.
> >          */
> >         if (hwp_active) {
> > -               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
> > &max_state);
> > +               if (global.no_turbo || global.turbo_disabled)
> > +                       max_state = HWP_GUARANTEED_PERF(cpu-
> > > hwp_cap_cached);
> > +               else
> > +                       max_state = HWP_HIGHEST_PERF(cpu-
> > > hwp_cap_cached);
> Can use  ternary operator instead of if..else. to further simplify.
> 
> > +               turbo_max = HWP_HIGHEST_PERF(cpu->hwp_cached);
> >         } else {
> >                 max_state = global.no_turbo || global.turbo_disabled
> > ?
> >                         cpu->pstate.max_pstate : cpu-
> > > pstate.turbo_pstate;

Well, would something like the patch below work?

---
 drivers/cpufreq/intel_pstate.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2207,9 +2207,9 @@ static void intel_pstate_update_perf_lim
 					    unsigned int policy_min,
 					    unsigned int policy_max)
 {
-	int max_freq = intel_pstate_get_max_freq(cpu);
 	int32_t max_policy_perf, min_policy_perf;
 	int max_state, turbo_max;
+	int max_freq;
 
 	/*
 	 * HWP needs some special consideration, because on BDX the
@@ -2223,6 +2223,7 @@ static void intel_pstate_update_perf_lim
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 		turbo_max = cpu->pstate.turbo_pstate;
 	}
+	max_freq = max_state * cpu->pstate.scaling;
 
 	max_policy_perf = max_state * policy_max / max_freq;
 	if (policy_max == policy_min) {
@@ -2325,9 +2326,18 @@ static void intel_pstate_adjust_policy_m
 static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
 					   struct cpufreq_policy_data *policy)
 {
+	int max_freq;
+
 	update_turbo_state();
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     intel_pstate_get_max_freq(cpu));
+	if (hwp_active) {
+		int max_state, turbo_max;
+
+		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);
+		max_freq = max_state * cpu->pstate.scaling;
+	} else {
+		max_freq = intel_pstate_get_max_freq(cpu);
+	}
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq, max_freq);
 
 	intel_pstate_adjust_policy_max(cpu, policy);
 }



