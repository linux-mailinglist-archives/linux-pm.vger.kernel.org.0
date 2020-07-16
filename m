Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5116C222A24
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgGPRm3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 13:42:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46802 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGPRm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 13:42:27 -0400
Received: from 89-64-86-30.dynamic.chello.pl (89.64.86.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 54f48e5912de7bb2; Thu, 16 Jul 2020 19:42:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Thu, 16 Jul 2020 19:42:08 +0200
Message-ID: <14003341.m6ogLmtsG7@kreacher>
In-Reply-To: <4981405.3kqTVLv5tO@kreacher>
References: <4981405.3kqTVLv5tO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow intel_pstate to work in the passive mode with HWP enabled and
make it set the HWP minimum performance limit (HWP floor) to the
P-state value given by the target frequency supplied by the cpufreq
governor, so as to prevent the HWP algorithm and the CPU scheduler
from working against each other, at least when the schedutil governor
is in use, and update the intel_pstate documentation accordingly.

Among other things, this allows utilization clamps to be taken
into account, at least to a certain extent, when intel_pstate is
in use and makes it more likely that sufficient capacity for
deadline tasks will be provided.

After this change, the resulting behavior of an HWP system with
intel_pstate in the passive mode should be close to the behavior
of the analogous non-HWP system with intel_pstate in the passive
mode, except that in the frequency range below the base frequency
(ie. the frequency retured by the base_frequency cpufreq attribute
in sysfs on HWP systems) the HWP algorithm is allowed to go above
the floor P-state set by intel_pstate with or without hardware
coordination of P-states among CPUs in the same package.

Also note that the setting of the HWP floor may not be taken into
account by the processor in the following cases:

 * For the HWP floor in the range of P-states above the base
   frequency, referred to as the turbo range, the processor has a
   license to choose any P-state from that range, either below or
   above the HWP floor, just like a non-HWP processor in the case
   when the target P-state falls into the turbo range.

 * If P-states of the CPUs in the same package are coordinated
   at the hardware level, the processor may choose a P-state
   above the HWP floor, just like a non-HWP processor in the
   analogous case.

With this change applied, intel_pstate in the passive mode
assumes complete control over the HWP request MSR and concurrent
changes of that MSR (eg. via the direct MSR access interface) are
overridden by it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Avoid a race condition when updating the HWP request register while
     setting a new EPP value via sysfs.

---
 Documentation/admin-guide/pm/intel_pstate.rst |   89 ++++++-------
 drivers/cpufreq/intel_pstate.c                |  169 ++++++++++++++++++++------
 2 files changed, 175 insertions(+), 83 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -36,6 +36,7 @@
 #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
+#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP	5000
 #define INTEL_CPUFREQ_TRANSITION_DELAY		500
 
 #ifdef CONFIG_ACPI
@@ -220,6 +221,7 @@ struct global_params {
  *			preference/bias
  * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
  *			operation
+ * @epp_cached		Cached HWP energy-performance preference value
  * @hwp_req_cached:	Cached value of the last HWP Request MSR
  * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  * @last_io_update:	Last time when IO wake flag was set
@@ -257,6 +259,7 @@ struct cpudata {
 	s16 epp_policy;
 	s16 epp_default;
 	s16 epp_saved;
+	s16 epp_cached;
 	u64 hwp_req_cached;
 	u64 hwp_cap_cached;
 	u64 last_io_update;
@@ -689,6 +692,8 @@ static ssize_t show_energy_performance_a
 
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 
+static struct cpufreq_driver intel_pstate;
+
 static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
@@ -717,14 +722,34 @@ static ssize_t store_energy_performance_
 		raw = true;
 	}
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!intel_pstate_driver) {
+		mutex_unlock(&intel_pstate_driver_lock);
+		return -EAGAIN;
+	}
+
 	mutex_lock(&intel_pstate_limits_lock);
 
-	ret = intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
-	if (ret)
-		count = ret;
+	if (intel_pstate_driver == &intel_pstate) {
+		ret = intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
+		if (ret)
+			count = ret;
+	} else {
+		/*
+		 * In the passive mode simply update the cached EPP value and
+		 * rely on intel_cpufreq_adjust_hwp() to pick it up later.
+		 */
+		if (!raw)
+			epp = ret ? epp_values[ret - 1] : cpu_data->epp_default;
+
+		WRITE_ONCE(cpu_data->epp_cached, epp);
+	}
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return count;
 }
 
@@ -1137,8 +1162,6 @@ static ssize_t store_no_turbo(struct kob
 	return count;
 }
 
-static struct cpufreq_driver intel_pstate;
-
 static void update_qos_request(enum freq_qos_req_type type)
 {
 	int max_state, turbo_max, freq, i, perf_pct;
@@ -2040,6 +2063,7 @@ static int intel_pstate_init_cpu(unsigne
 		cpu->epp_default = -EINVAL;
 		cpu->epp_powersave = -EINVAL;
 		cpu->epp_saved = -EINVAL;
+		WRITE_ONCE(cpu->epp_cached, -EINVAL);
 	}
 
 	cpu = all_cpu_data[cpunum];
@@ -2238,7 +2262,10 @@ static int intel_pstate_verify_policy(st
 
 static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+	if (hwp_active)
+		intel_pstate_hwp_force_min_perf(policy->cpu);
+	else
+		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
 }
 
 static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
@@ -2246,12 +2273,10 @@ static void intel_pstate_stop_cpu(struct
 	pr_debug("CPU %d exiting\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
-	if (hwp_active) {
+	if (hwp_active)
 		intel_pstate_hwp_save_state(policy);
-		intel_pstate_hwp_force_min_perf(policy->cpu);
-	} else {
-		intel_cpufreq_stop_cpu(policy);
-	}
+
+	intel_cpufreq_stop_cpu(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
@@ -2381,13 +2406,82 @@ static void intel_cpufreq_trace(struct c
 		fp_toint(cpu->iowait_boost * 100));
 }
 
+static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
+				     bool fast_switch)
+{
+	u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
+	s16 epp;
+
+	value &= ~HWP_MIN_PERF(~0L);
+	value |= HWP_MIN_PERF(target_pstate);
+
+	/*
+	 * The entire MSR needs to be updated in order to update the HWP min
+	 * field in it, so opportunistically update the max too if needed.
+	 */
+	value &= ~HWP_MAX_PERF(~0L);
+	value |= HWP_MAX_PERF(cpu->max_perf_ratio);
+
+	/*
+	 * In case the EPP has been adjusted via sysfs, write the last cached
+	 * value of it to the MSR as well.
+	 */
+	epp = READ_ONCE(cpu->epp_cached);
+	if (epp >= 0) {
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+	}
+
+	if (value == prev)
+		return;
+
+	WRITE_ONCE(cpu->hwp_req_cached, value);
+	if (fast_switch)
+		wrmsrl(MSR_HWP_REQUEST, value);
+	else
+		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+}
+
+static void intel_cpufreq_adjust_perf_ctl(struct cpudata *cpu,
+					  u32 target_pstate, bool fast_switch)
+{
+	if (fast_switch)
+		wrmsrl(MSR_IA32_PERF_CTL,
+		       pstate_funcs.get_val(cpu, target_pstate));
+	else
+		wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+			      pstate_funcs.get_val(cpu, target_pstate));
+}
+
+static int intel_cpufreq_update_pstate(struct cpudata *cpu, int target_pstate,
+				       bool fast_switch)
+{
+	int old_pstate = cpu->pstate.current_pstate;
+
+	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	if (target_pstate != old_pstate) {
+		cpu->pstate.current_pstate = target_pstate;
+		if (hwp_active)
+			intel_cpufreq_adjust_hwp(cpu, target_pstate,
+						 fast_switch);
+		else
+			intel_cpufreq_adjust_perf_ctl(cpu, target_pstate,
+						      fast_switch);
+	}
+
+	intel_cpufreq_trace(cpu, fast_switch ? INTEL_PSTATE_TRACE_FAST_SWITCH :
+			    INTEL_PSTATE_TRACE_TARGET, old_pstate);
+
+	return target_pstate;
+}
+
 static int intel_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	struct cpufreq_freqs freqs;
-	int target_pstate, old_pstate;
+	int target_pstate;
 
 	update_turbo_state();
 
@@ -2395,6 +2489,7 @@ static int intel_cpufreq_target(struct c
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
+
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
 		target_pstate = DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
@@ -2406,15 +2501,11 @@ static int intel_cpufreq_target(struct c
 		target_pstate = DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
 		break;
 	}
-	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	old_pstate = cpu->pstate.current_pstate;
-	if (target_pstate != cpu->pstate.current_pstate) {
-		cpu->pstate.current_pstate = target_pstate;
-		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
-			      pstate_funcs.get_val(cpu, target_pstate));
-	}
+
+	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, false);
+
 	freqs.new = target_pstate * cpu->pstate.scaling;
-	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate);
+
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -2424,15 +2515,14 @@ static unsigned int intel_cpufreq_fast_s
 					      unsigned int target_freq)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	int target_pstate, old_pstate;
+	int target_pstate;
 
 	update_turbo_state();
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
-	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	old_pstate = cpu->pstate.current_pstate;
-	intel_pstate_update_pstate(cpu, target_pstate);
-	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
+
+	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, true);
+
 	return target_pstate * cpu->pstate.scaling;
 }
 
@@ -2452,7 +2542,6 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
-	policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
@@ -2464,10 +2553,17 @@ static int intel_cpufreq_cpu_init(struct
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (hwp_active)
+	if (hwp_active) {
+		u64 value;
+
 		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
-	else
+		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
+		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
+		WRITE_ONCE(cpu->hwp_req_cached, value);
+	} else {
 		turbo_max = cpu->pstate.turbo_pstate;
+		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
+	}
 
 	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
 	min_freq *= cpu->pstate.scaling;
@@ -2568,9 +2664,6 @@ static int intel_pstate_register_driver(
 
 static int intel_pstate_unregister_driver(void)
 {
-	if (hwp_active)
-		return -EBUSY;
-
 	cpufreq_unregister_driver(intel_pstate_driver);
 	intel_pstate_driver_cleanup();
 
@@ -2826,7 +2919,10 @@ static int __init intel_pstate_init(void
 			hwp_active++;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
-			default_driver = &intel_pstate;
+			intel_cpufreq.attr = hwp_cpufreq_attrs;
+			if (!default_driver)
+				default_driver = &intel_pstate;
+
 			goto hwp_cpu_matched;
 		}
 	} else {
@@ -2897,14 +2993,13 @@ static int __init intel_pstate_setup(cha
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable")) {
+	if (!strcmp(str, "disable"))
 		no_load = 1;
-	} else if (!strcmp(str, "active")) {
+	else if (!strcmp(str, "active"))
 		default_driver = &intel_pstate;
-	} else if (!strcmp(str, "passive")) {
+	else if (!strcmp(str, "passive"))
 		default_driver = &intel_cpufreq;
-		no_hwp = 1;
-	}
+
 	if (!strcmp(str, "no_hwp")) {
 		pr_info("HWP disabled\n");
 		no_hwp = 1;
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -54,10 +54,13 @@ registered (see `below <status_attr_>`_)
 Operation Modes
 ===============
 
-``intel_pstate`` can operate in three different modes: in the active mode with
-or without hardware-managed P-states support and in the passive mode.  Which of
-them will be in effect depends on what kernel command line options are used and
-on the capabilities of the processor.
+``intel_pstate`` can operate in two different modes, active or passive.  In the
+active mode, it uses its own internal preformance scaling governor algorithm or
+allows the hardware to do preformance scaling by itself, while in the passive
+mode it responds to requests made by a generic ``CPUFreq`` governor implementing
+a certain performance scaling algorithm.  Which of them will be in effect
+depends on what kernel command line options are used and on the capabilities of
+the processor.
 
 Active Mode
 -----------
@@ -194,10 +197,11 @@ This is the default operation mode of ``
 hardware-managed P-states (HWP) support.  It is always used if the
 ``intel_pstate=passive`` argument is passed to the kernel in the command line
 regardless of whether or not the given processor supports HWP.  [Note that the
-``intel_pstate=no_hwp`` setting implies ``intel_pstate=passive`` if it is used
-without ``intel_pstate=active``.]  Like in the active mode without HWP support,
-in this mode ``intel_pstate`` may refuse to work with processors that are not
-recognized by it.
+``intel_pstate=no_hwp`` setting causes the driver to start in the passive mode
+if it is not combined with ``intel_pstate=active``.]  Like in the active mode
+without HWP support, in this mode ``intel_pstate`` may refuse to work with
+processors that are not recognized by it if HWP is prevented from being enabled
+through the kernel command line.
 
 If the driver works in this mode, the ``scaling_driver`` policy attribute in
 ``sysfs`` for all ``CPUFreq`` policies contains the string "intel_cpufreq".
@@ -318,10 +322,9 @@ manuals need to be consulted to get to i
 
 For this reason, there is a list of supported processors in ``intel_pstate`` and
 the driver initialization will fail if the detected processor is not in that
-list, unless it supports the `HWP feature <Active Mode_>`_.  [The interface to
-obtain all of the information listed above is the same for all of the processors
-supporting the HWP feature, which is why they all are supported by
-``intel_pstate``.]
+list, unless it supports the HWP feature.  [The interface to obtain all of the
+information listed above is the same for all of the processors supporting the
+HWP feature, which is why ``intel_pstate`` works with all of them.]
 
 
 User Space Interface in ``sysfs``
@@ -425,22 +428,16 @@ argument is passed to the kernel in the
 	as well as the per-policy ones) are then reset to their default
 	values, possibly depending on the target operation mode.]
 
-	That only is supported in some configurations, though (for example, if
-	the `HWP feature is enabled in the processor <Active Mode With HWP_>`_,
-	the operation mode of the driver cannot be changed), and if it is not
-	supported in the current configuration, writes to this attribute will
-	fail with an appropriate error.
-
 ``energy_efficiency``
-	This attribute is only present on platforms, which have CPUs matching
-	Kaby Lake or Coffee Lake desktop CPU model. By default
-	energy efficiency optimizations are disabled on these CPU models in HWP
-	mode by this driver. Enabling energy efficiency may limit maximum
-	operating frequency in both HWP and non HWP mode. In non HWP mode,
-	optimizations are done only in the turbo frequency range. In HWP mode,
-	optimizations are done in the entire frequency range. Setting this
-	attribute to "1" enables energy efficiency optimizations and setting
-	to "0" disables energy efficiency optimizations.
+	This attribute is only present on platforms with CPUs matching the Kaby
+	Lake or Coffee Lake desktop CPU model. By default, energy-efficiency
+	optimizations are disabled on these CPU models if HWP is enabled.
+	Enabling energy-efficiency optimizations may limit maximum operating
+	frequency with or without the HWP feature.  With HWP enabled, the
+	optimizations are done only in the turbo frequency range.  Without it,
+	they are done in the entire available frequency range.  Setting this
+	attribute to "1" enables the energy-efficiency optimizations and setting
+	to "0" disables them.
 
 Interpretation of Policy Attributes
 -----------------------------------
@@ -484,8 +481,8 @@ Next, the following policy attributes ha
 	policy for the time interval between the last two invocations of the
 	driver's utilization update callback by the CPU scheduler for that CPU.
 
-One more policy attribute is present if the `HWP feature is enabled in the
-processor <Active Mode With HWP_>`_:
+One more policy attribute is present if the HWP feature is enabled in the
+processor:
 
 ``base_frequency``
 	Shows the base frequency of the CPU. Any frequency above this will be
@@ -526,11 +523,11 @@ on the following rules, regardless of th
 
  3. The global and per-policy limits can be set independently.
 
-If the `HWP feature is enabled in the processor <Active Mode With HWP_>`_, the
-resulting effective values are written into its registers whenever the limits
-change in order to request its internal P-state selection logic to always set
-P-states within these limits.  Otherwise, the limits are taken into account by
-scaling governors (in the `passive mode <Passive Mode_>`_) and by the driver
+In the `active mode with the HWP feature enabled <Active Mode With HWP_>`_, the
+resulting effective values are written into hardware registers whenever the
+limits change in order to request its internal P-state selection logic to always
+set P-states within these limits.  Otherwise, the limits are taken into account
+by scaling governors (in the `passive mode <Passive Mode_>`_) and by the driver
 every time before setting a new P-state for a CPU.
 
 Additionally, if the ``intel_pstate=per_cpu_perf_limits`` command line argument
@@ -541,12 +538,11 @@ at all and the only way to set the limit
 Energy vs Performance Hints
 ---------------------------
 
-If ``intel_pstate`` works in the `active mode with the HWP feature enabled
-<Active Mode With HWP_>`_ in the processor, additional attributes are present
-in every ``CPUFreq`` policy directory in ``sysfs``.  They are intended to allow
-user space to help ``intel_pstate`` to adjust the processor's internal P-state
-selection logic by focusing it on performance or on energy-efficiency, or
-somewhere between the two extremes:
+If the hardware-managed P-states (HWP) is enabled in the processor, additional
+attributes, intended to allow user space to help ``intel_pstate`` to adjust the
+processor's internal P-state selection logic by focusing it on performance or on
+energy-efficiency, or somewhere between the two extremes, are present in every
+``CPUFreq`` policy directory in ``sysfs``.  They are :
 
 ``energy_performance_preference``
 	Current value of the energy vs performance hint for the given policy
@@ -650,12 +646,14 @@ of them have to be prepended with the ``
 	Do not register ``intel_pstate`` as the scaling driver even if the
 	processor is supported by it.
 
+``active``
+	Register ``intel_pstate`` in the `active mode <Active Mode_>`_ to start
+	with.
+
 ``passive``
 	Register ``intel_pstate`` in the `passive mode <Passive Mode_>`_ to
 	start with.
 
-	This option implies the ``no_hwp`` one described below.
-
 ``force``
 	Register ``intel_pstate`` as the scaling driver instead of
 	``acpi-cpufreq`` even if the latter is preferred on the given system.
@@ -670,13 +668,12 @@ of them have to be prepended with the ``
 	driver is used instead of ``acpi-cpufreq``.
 
 ``no_hwp``
-	Do not enable the `hardware-managed P-states (HWP) feature
-	<Active Mode With HWP_>`_ even if it is supported by the processor.
+	Do not enable the hardware-managed P-states (HWP) feature even if it is
+	supported by the processor.
 
 ``hwp_only``
 	Register ``intel_pstate`` as the scaling driver only if the
-	`hardware-managed P-states (HWP) feature <Active Mode With HWP_>`_ is
-	supported by the processor.
+	hardware-managed P-states (HWP) feature is supported by the processor.
 
 ``support_acpi_ppc``
 	Take ACPI ``_PPC`` performance limits into account.



