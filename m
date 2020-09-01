Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16A2259D60
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgIARkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 13:40:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44346 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgIARjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 13:39:55 -0400
Received: from 89-64-88-247.dynamic.chello.pl (89.64.88.247) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id fc74d08505d9edea; Tue, 1 Sep 2020 19:39:51 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v4 4/5] cpufreq: intel_pstate: Add ->offline and ->online callbacks
Date:   Tue, 01 Sep 2020 19:37:38 +0200
Message-ID: <2066734.hWJzf1n7kE@kreacher>
In-Reply-To: <3748218.V0HrpZKF9g@kreacher>
References: <3748218.V0HrpZKF9g@kreacher>
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
not need that callback any more, so drop it from there.

Also modify the active mode ->suspend and ->resume callbacks to
prevent them from interfering with the new ->offline and ->online
ones in case the latter are invoked withing the system-wide suspend
and resume code flow and make the passive mode use them too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Rearrange intel_pstate_init_cpu() to restore some of the previous
       behavior of it to retain the current active-mode EPP management.

v2 -> v3:
   * Fold the previous [5/5] in, rework intel_pstate_resume(), add
     intel_pstate_suspend().
   * Drop intel_pstate_hwp_save_state() and drop epp_saved from struct cpudata.
   * Update the changelog.

v3 -> v4:
   * Re-enable HWP in "online" and "resume" (if "online" didn't do that).

---
 drivers/cpufreq/intel_pstate.c | 143 ++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b308c39b6204..8181a1f1dc79 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -219,14 +219,13 @@ struct global_params {
  * @epp_policy:		Last saved policy used to set EPP/EPB
  * @epp_default:	Power on default HWP energy performance
  *			preference/bias
- * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
- *			operation
  * @epp_cached		Cached HWP energy-performance preference value
  * @hwp_req_cached:	Cached value of the last HWP Request MSR
  * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  * @last_io_update:	Last time when IO wake flag was set
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
+ * @suspended:		Whether or not the driver has been suspended.
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -258,13 +257,13 @@ struct cpudata {
 	s16 epp_powersave;
 	s16 epp_policy;
 	s16 epp_default;
-	s16 epp_saved;
 	s16 epp_cached;
 	u64 hwp_req_cached;
 	u64 hwp_cap_cached;
 	u64 last_io_update;
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
+	bool suspended;
 };
 
 static struct cpudata **all_cpu_data;
@@ -871,12 +870,6 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 
 	cpu_data->epp_policy = cpu_data->policy;
 
-	if (cpu_data->epp_saved >= 0) {
-		epp = cpu_data->epp_saved;
-		cpu_data->epp_saved = -EINVAL;
-		goto update_epp;
-	}
-
 	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		epp = intel_pstate_get_epp(cpu_data, value);
 		cpu_data->epp_powersave = epp;
@@ -903,7 +896,6 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 
 		epp = cpu_data->epp_powersave;
 	}
-update_epp:
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
@@ -915,14 +907,24 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
-static void intel_pstate_hwp_force_min_perf(int cpu)
+static void intel_pstate_hwp_offline(struct cpudata *cpu)
 {
-	u64 value;
+	u64 value = READ_ONCE(cpu->hwp_req_cached);
 	int min_perf;
 
-	value = all_cpu_data[cpu]->hwp_req_cached;
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
+		/*
+		 * In case the EPP has been set to "performance" by the
+		 * active mode "performance" scaling algorithm, replace that
+		 * temporary value with the cached EPP one.
+		 */
+		value &= ~GENMASK_ULL(31, 24);
+		value |= HWP_ENERGY_PERF_PREFERENCE(cpu->epp_cached);
+		WRITE_ONCE(cpu->hwp_req_cached, value);
+	}
+
 	value &= ~GENMASK_ULL(31, 0);
-	min_perf = HWP_LOWEST_PERF(all_cpu_data[cpu]->hwp_cap_cached);
+	min_perf = HWP_LOWEST_PERF(cpu->hwp_cap_cached);
 
 	/* Set hwp_max = hwp_min */
 	value |= HWP_MAX_PERF(min_perf);
@@ -932,19 +934,7 @@ static void intel_pstate_hwp_force_min_perf(int cpu)
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
 
-	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
-}
-
-static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
-{
-	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
-
-	if (!hwp_active)
-		return 0;
-
-	cpu_data->epp_saved = intel_pstate_get_epp(cpu_data, 0);
-
-	return 0;
+	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 }
 
 #define POWER_CTL_EE_ENABLE	1
@@ -971,8 +961,28 @@ static void set_power_ctl_ee_state(bool input)
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata);
 
+static void intel_pstate_hwp_reenable(struct cpudata *cpu)
+{
+	intel_pstate_hwp_enable(cpu);
+	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, READ_ONCE(cpu->hwp_req_cached));
+}
+
+static int intel_pstate_suspend(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	pr_debug("CPU %d suspending\n", cpu->cpu);
+
+	cpu->suspended = true;
+
+	return 0;
+}
+
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	pr_debug("CPU %d resuming\n", cpu->cpu);
 
 	/* Only restore if the system default is changed */
 	if (power_ctl_ee_state == POWER_CTL_EE_ENABLE)
@@ -980,18 +990,16 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
 	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
 		set_power_ctl_ee_state(false);
 
-	if (!hwp_active)
-		return 0;
+	if (cpu->suspended && hwp_active) {
+		mutex_lock(&intel_pstate_limits_lock);
 
-	mutex_lock(&intel_pstate_limits_lock);
-
-	if (policy->cpu == 0)
-		intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
+		/* Re-enable HWP, because "online" has not done that. */
+		intel_pstate_hwp_reenable(cpu);
 
-	all_cpu_data[policy->cpu]->epp_policy = 0;
-	intel_pstate_hwp_set(policy->cpu);
+		mutex_unlock(&intel_pstate_limits_lock);
+	}
 
-	mutex_unlock(&intel_pstate_limits_lock);
+	cpu->suspended = false;
 
 	return 0;
 }
@@ -1440,7 +1448,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
-	cpudata->epp_policy = 0;
 	if (cpudata->epp_default == -EINVAL)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
@@ -2111,7 +2118,6 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 		cpu->epp_default = -EINVAL;
 		cpu->epp_powersave = -EINVAL;
-		cpu->epp_saved = -EINVAL;
 	}
 
 	cpu = all_cpu_data[cpunum];
@@ -2122,6 +2128,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		const struct x86_cpu_id *id;
 
 		intel_pstate_hwp_enable(cpu);
+		cpu->epp_policy = 0;
 
 		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
 		if (id && intel_pstate_acpi_pm_profile_server())
@@ -2308,28 +2315,61 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	pr_debug("CPU %d going offline\n", cpu->cpu);
+
+	if (cpu->suspended)
+		return 0;
+
+	/*
+	 * If the CPU is an SMT thread and it goes offline with the performance
+	 * settings different from the minimum, it will prevent its sibling
+	 * from getting to lower performance levels, so force the minimum
+	 * performance on CPU offline to prevent that from happening.
+	 */
 	if (hwp_active)
-		intel_pstate_hwp_force_min_perf(policy->cpu);
+		intel_pstate_hwp_offline(cpu);
 	else
-		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+		intel_pstate_set_min_pstate(cpu);
+
+	intel_pstate_exit_perf_limits(policy);
+
+	return 0;
+}
+
+static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	pr_debug("CPU %d going online\n", cpu->cpu);
+
+	intel_pstate_init_acpi_perf_limits(policy);
+
+	if (hwp_active) {
+		/*
+		 * Re-enable HWP and clear the "suspended" flag to let "resume"
+		 * know that it need not do that.
+		 */
+		intel_pstate_hwp_reenable(cpu);
+		cpu->suspended = false;
+	}
+
+	return 0;
 }
 
 static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 {
-	pr_debug("CPU %d exiting\n", policy->cpu);
+	pr_debug("CPU %d stopping\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
-	if (hwp_active)
-		intel_pstate_hwp_save_state(policy);
-
-	intel_cpufreq_stop_cpu(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	intel_pstate_exit_perf_limits(policy);
+	pr_debug("CPU %d exiting\n", policy->cpu);
 
 	policy->fast_switch_possible = false;
 
@@ -2403,11 +2443,13 @@ static struct cpufreq_driver intel_pstate = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
-	.suspend	= intel_pstate_hwp_save_state,
+	.suspend	= intel_pstate_suspend,
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",
 };
@@ -2662,7 +2704,10 @@ static struct cpufreq_driver intel_cpufreq = {
 	.fast_switch	= intel_cpufreq_fast_switch,
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_cpufreq_cpu_exit,
-	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
+	.suspend	= intel_pstate_suspend,
+	.resume		= intel_pstate_resume,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
 };
-- 
2.26.2




