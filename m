Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0629726F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbgJWPgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:36:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48992 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbgJWPgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:36:48 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id fd4a279f45e740d9; Fri, 23 Oct 2020 17:36:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 2/4] cpufreq: intel_pstate: Avoid missing HWP max updates in passive mode
Date:   Fri, 23 Oct 2020 17:35:32 +0200
Message-ID: <3212190.yEXfVNHMLB@kreacher>
In-Reply-To: <2183878.gTFULuzKx9@kreacher>
References: <2183878.gTFULuzKx9@kreacher>
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
not change, intel_cpufreq_adjust_hwp() is not invoked to update
the HWP Request MSR due to the "target_pstate != old_pstate" check
in intel_cpufreq_update_pstate(), so the HWP max limit is not
updated as a result.

Also, if the CPUFREQ_NEED_UPDATE_LIMITS flag is not set for the
driver and the target frequency does not change along with the
policy max limit, the "target_freq == policy->cur" check in
__cpufreq_driver_target() prevents the driver's ->target() callback
from being invoked at all, so the HWP max limit is not updated.

To prevent that occurring, set the CPUFREQ_NEED_UPDATE_LIMITS flag
in the intel_cpufreq driver structure if HWP is enabled and modify
intel_cpufreq_update_pstate() to do the "target_pstate != old_pstate"
check only in the non-HWP case and let intel_cpufreq_adjust_hwp()
always run in the HWP case (it will update HWP Request only if the
cached value of the register is different from the new one including
the limits, so if neither the target P-state value nor the max limit
changes, the register write will still be avoided).

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Reported-by: Zhang Rui <rui.zhang@intel.com>
Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The v2 is just the intel_pstate changes (without the core changes) and setting
the new flag.

---
 drivers/cpufreq/intel_pstate.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

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
@@ -3014,6 +3012,7 @@ static int __init intel_pstate_init(void
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;
+			intel_cpufreq.flags |= CPUFREQ_NEED_UPDATE_LIMITS;
 			if (!default_driver)
 				default_driver = &intel_pstate;
 



