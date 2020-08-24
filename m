Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08682506DC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHXRsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 13:48:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59188 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHXRsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 13:48:14 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id cea15cfeb758298d; Mon, 24 Aug 2020 19:48:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2 3/5] cpufreq: intel_pstate: Add ->offline and ->online callbacks
Date:   Mon, 24 Aug 2020 19:43:31 +0200
Message-ID: <2786976.RHVxHup3hB@kreacher>
In-Reply-To: <4169555.5IIHXK4Dsd@kreacher>
References: <4169555.5IIHXK4Dsd@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add ->offline and ->online driver callbacks to prepare for taking a
CPU offline and to restore its working configuration when it goes
back online, respectively, to avoid invoking the ->init callback on
every CPU online which is quite a bit of unnecessary overhead.

Define ->offline and ->online so that they can be used in the
passive mode as well as in the active mode and because ->offline
will do the majority of ->stop_cpu work, the passive mode does
not need that callback any more, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Typo fixes and changelog edits (Doug).

---
 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3d18934fa975..98836ac299db 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
+	pr_debug("CPU %d going offline\n", policy->cpu);
+
+	intel_pstate_exit_perf_limits(policy);
+
+	/*
+	 * If the CPU is an SMT thread and it goes offline with the performance
+	 * settings different from the minimum, it will prevent its sibling
+	 * from getting to lower performance levels, so force the minimum
+	 * performance on CPU offline to prevent that from happening.
+	 */
 	if (hwp_active)
 		intel_pstate_hwp_force_min_perf(policy->cpu);
 	else
 		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+
+	return 0;
+}
+
+static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
+{
+	pr_debug("CPU %d going online\n", policy->cpu);
+
+	intel_pstate_init_acpi_perf_limits(policy);
+
+	if (hwp_active)
+		wrmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST,
+			      all_cpu_data[policy->cpu]->hwp_req_cached);
+
+	return 0;
 }
 
 static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 {
-	pr_debug("CPU %d exiting\n", policy->cpu);
+	pr_debug("CPU %d stopping\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
 	if (hwp_active)
 		intel_pstate_hwp_save_state(policy);
-
-	intel_cpufreq_stop_cpu(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	intel_pstate_exit_perf_limits(policy);
+	pr_debug("CPU %d exiting\n", policy->cpu);
 
 	policy->fast_switch_possible = false;
 
@@ -2398,6 +2421,8 @@ static struct cpufreq_driver intel_pstate = {
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",
 };
@@ -2652,7 +2677,8 @@ static struct cpufreq_driver intel_cpufreq = {
 	.fast_switch	= intel_cpufreq_fast_switch,
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_cpufreq_cpu_exit,
-	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
 };
-- 
2.26.2




