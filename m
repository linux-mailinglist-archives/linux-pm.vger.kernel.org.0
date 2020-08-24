Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7724FF25
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHXNk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 09:40:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64224 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgHXNk5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 09:40:57 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 8cbe13510595119e; Mon, 24 Aug 2020 15:40:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: [PATCH v2 3/4] cpufreq: intel_pstate: Add ->offline and ->online callbacks
Date:   Mon, 24 Aug 2020 15:40:54 +0200
Message-ID: <1620790.MIbp4yWDbA@kreacher>
In-Reply-To: <000501d6781d$c953def0$5bfb9cd0$@net>
References: <2283366.Lr8yYYnyev@kreacher> <1879185.C8Vd3vmt8n@kreacher> <000501d6781d$c953def0$5bfb9cd0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, August 22, 2020 2:47:16 AM CEST Doug Smythies wrote:
> Hi Rafael,
> 
> Just annoying typo type feedback.

Thanks!

Please find a corrected patch below.

Cheers!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Add ->offline and ->online callbacks

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
 drivers/cpufreq/intel_pstate.c |   38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(st
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
 
@@ -2398,6 +2421,8 @@ static struct cpufreq_driver intel_pstat
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",
 };
@@ -2652,7 +2677,8 @@ static struct cpufreq_driver intel_cpufr
 	.fast_switch	= intel_cpufreq_fast_switch,
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_cpufreq_cpu_exit,
-	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
 };



