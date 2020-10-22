Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648BA295DDB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897712AbgJVL55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:57:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65220 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897701AbgJVL54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:57:56 -0400
Received: from 89-64-87-167.dynamic.chello.pl (89.64.87.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id a032c57bee7ada70; Thu, 22 Oct 2020 13:57:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Avoid missing HWP max updates in passive mode
Date:   Thu, 22 Oct 2020 13:57:02 +0200
Message-ID: <76352140.UXiy1LajID@kreacher>
In-Reply-To: <1666263.spd1I39WAV@kreacher>
References: <1666263.spd1I39WAV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the cpufreq policy max limit is changed when intel_pstate operates
in the passive mode with HWP enabled and the "powersave" governor is
used on top of it, the HWP max limit is not updated as appropriate.

Namely, in the "powersave" governor case, the target P-state
is always equal to the policy min limit, so if the latter does
not change, the "target_freq == policy->cur" check in
__cpufreq_driver_target() is "true" and the
"target_pstate != old_pstate" check in intel_cpufreq_update_pstate()
is "false", so intel_cpufreq_adjust_hwp() is not invoked to update
the HWP Request MSR and the HWP max limit is not updated as a result.

To prevent that from occurring, modify __cpufreq_driver_target()
to do the "target_freq == policy->cur" check only in the frequency
table case and change intel_cpufreq_update_pstate() to do the
"target_pstate != old_pstate" check only in the non-HWP case and
let intel_cpufreq_adjust_hwp() always run in the HWP case (it will
update HWP Request only if the cached value of the register is
different from the new one including the limits, so if neither the
target P-state value nor the max limit changes, the register write
will still be avoided).

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Reported-by: Zhang Rui <rui.zhang@intel.com>
Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c      |    6 +++---
 drivers/cpufreq/intel_pstate.c |   12 +++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2550,14 +2550,12 @@ static int intel_cpufreq_update_pstate(s
 	int old_pstate = cpu->pstate.current_pstate;
 
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	if (target_pstate != old_pstate) {
+	if (hwp_active) {
+		intel_cpufreq_adjust_hwp(cpu, target_pstate, fast_switch);
+		cpu->pstate.current_pstate = target_pstate;
+	} else if (target_pstate != old_pstate) {
+		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
 		cpu->pstate.current_pstate = target_pstate;
-		if (hwp_active)
-			intel_cpufreq_adjust_hwp(cpu, target_pstate,
-						 fast_switch);
-		else
-			intel_cpufreq_adjust_perf_ctl(cpu, target_pstate,
-						      fast_switch);
 	}
 
 	intel_cpufreq_trace(cpu, fast_switch ? INTEL_PSTATE_TRACE_FAST_SWITCH :
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2182,6 +2182,9 @@ int __cpufreq_driver_target(struct cpufr
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
 
+	if (cpufreq_driver->target)
+		return cpufreq_driver->target(policy, target_freq, relation);
+
 	/*
 	 * This might look like a redundant call as we are checking it again
 	 * after finding index. But it is left intentionally for cases where
@@ -2194,9 +2197,6 @@ int __cpufreq_driver_target(struct cpufr
 	/* Save last value to restore later on errors */
 	policy->restore_freq = policy->cur;
 
-	if (cpufreq_driver->target)
-		return cpufreq_driver->target(policy, target_freq, relation);
-
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 



