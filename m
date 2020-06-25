Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A272209B65
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbgFYIhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 04:37:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:38613 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390671AbgFYIhs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 04:37:48 -0400
IronPort-SDR: ldtGgFhXt4x1xPJfDnS7FHI5DnG0qCcfJ9HSk+Ma5TsTgRm63vTMK0P7lDTBVcow68qCiilRgy
 M/lzX4opXQhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="209926280"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="209926280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 01:37:46 -0700
IronPort-SDR: b1K5RDWZ9KPNOBCJmz4vdGzc+5L3dUiIBlST/nMhEE7BVZ0AJx4hOD1bZqBRXj3MvqVxl/J7Ty
 3RruaRi9TeZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="265298128"
Received: from unknown (HELO spandruv-mobl.amr.corp.intel.com) ([10.251.17.249])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2020 01:37:46 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/2] cpufreq: intel_pstate: Allow raw energy performance preference value
Date:   Thu, 25 Jun 2020 01:37:40 -0700
Message-Id: <20200625083740.1445342-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200625083740.1445342-1-srinivas.pandruvada@linux.intel.com>
References: <20200625083740.1445342-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently using attribute "energy_performance_preference", user space can
write one of the four per-defined preference string. These preference
strings gets mapped to a hard-coded Energy-Performance Preference (EPP) or
Energy-Performance Bias (EPB) knob.

These four values are supposed to cover broad spectrum of use cases, but
are not uniformly distributed in the range. There are number of cases,
where this is not enough. For example:

Suppose user wants more performance when connected to AC. Instead of using
default "balance performance", the "performance" setting can be used. This
changes EPP value from 0x80 to 0x00. But setting EPP to 0, results in
electrical and thermal issues on some platforms. This results in
aggressive throttling, which causes a drop in performance. But some value
between 0x80 and 0x00 results in better performance. But that value can't
be fixed as the power curve is not linear. In some cases just changing EPP
from 0x80 to 0x75 is enough to get significant performance gain.

Similarly on battery EPP 0x80 can be very aggressive in power consumption.
But picking up the next choice "balance power" results in too much loss
of performance, which cause bad user experience in use case like "Google
Hangout". It was observed that some value between these two EPP is
optimal.

This change allows fine grain EPP tuning for platform like Chromebook.
Here based on the product and use cases, different EPP values can be set.
This change is similar to the change done for:
/sys/devices/system/cpu/cpu*/power/energy_perf_bias
where user has choice to write a predefined string or raw value.

The change itself is trivial. When user preference doesn't match
predefined string preferences and value is an unsigned integer and in
range, use that value for EPP. When the EPP feature is not present
writing raw value is not supported.

Suggested-by: Len Brown <lenb@kernel.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |  6 ++-
 drivers/cpufreq/intel_pstate.c                | 50 +++++++++++++++----
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 939bfdc53f4f..5e209926e0ed 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -561,7 +561,11 @@ somewhere between the two extremes:
 Strings written to the ``energy_performance_preference`` attribute are
 internally translated to integer values written to the processor's
 Energy-Performance Preference (EPP) knob (if supported) or its
-Energy-Performance Bias (EPB) knob.
+Energy-Performance Bias (EPB) knob. It is also possible to write a positive
+integer value between 0 to 255, if the EPP feature is present. If the EPP
+feature is not present, writing integer value to this attribute is not
+supported. In this case, user can use
+ "/sys/devices/system/cpu/cpu*/power/energy_perf_bias" interface.
 
 [Note that tasks may by migrated from one CPU to another by the scheduler's
 load-balancing algorithm and if different energy vs performance hints are
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1cf6d06f2314..d8f195c7a428 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -602,11 +602,12 @@ static const unsigned int epp_values[] = {
 	HWP_EPP_POWERSAVE
 };
 
-static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
+static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
 {
 	s16 epp;
 	int index = -EINVAL;
 
+	*raw_epp = 0;
 	epp = intel_pstate_get_epp(cpu_data, 0);
 	if (epp < 0)
 		return epp;
@@ -614,12 +615,14 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		if (epp == HWP_EPP_PERFORMANCE)
 			return 1;
-		if (epp <= HWP_EPP_BALANCE_PERFORMANCE)
+		if (epp == HWP_EPP_BALANCE_PERFORMANCE)
 			return 2;
-		if (epp <= HWP_EPP_BALANCE_POWERSAVE)
+		if (epp == HWP_EPP_BALANCE_POWERSAVE)
 			return 3;
-		else
+		if (epp == HWP_EPP_POWERSAVE)
 			return 4;
+		*raw_epp = epp;
+		return 0;
 	} else if (boot_cpu_has(X86_FEATURE_EPB)) {
 		/*
 		 * Range:
@@ -638,7 +641,8 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
 }
 
 static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
-					      int pref_index)
+					      int pref_index, bool use_raw,
+					      u32 raw_epp)
 {
 	int epp = -EINVAL;
 	int ret;
@@ -657,6 +661,16 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 
 		value &= ~GENMASK_ULL(31, 24);
 
+		if (use_raw) {
+			if (raw_epp > 255) {
+				ret = -EINVAL;
+				goto return_pref;
+			}
+			value |= (u64)raw_epp << 24;
+			ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
+			goto return_pref;
+		}
+
 		if (epp == -EINVAL)
 			epp = epp_values[pref_index - 1];
 
@@ -694,6 +708,8 @@ static ssize_t store_energy_performance_preference(
 {
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
 	char str_preference[21];
+	bool raw = false;
+	u32 epp;
 	int ret;
 
 	ret = sscanf(buf, "%20s", str_preference);
@@ -701,10 +717,21 @@ static ssize_t store_energy_performance_preference(
 		return -EINVAL;
 
 	ret = match_string(energy_perf_strings, -1, str_preference);
-	if (ret < 0)
+	if (ret < 0) {
+		if (!boot_cpu_has(X86_FEATURE_HWP_EPP))
+			return ret;
+
+		ret = kstrtouint(buf, 10, &epp);
+		if (ret)
+			return ret;
+
+		raw = true;
+	}
+
+	ret = intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
+	if (ret)
 		return ret;
 
-	intel_pstate_set_energy_pref_index(cpu_data, ret);
 	return count;
 }
 
@@ -712,13 +739,16 @@ static ssize_t show_energy_performance_preference(
 				struct cpufreq_policy *policy, char *buf)
 {
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
-	int preference;
+	int preference, raw_epp;
 
-	preference = intel_pstate_get_energy_pref_index(cpu_data);
+	preference = intel_pstate_get_energy_pref_index(cpu_data, &raw_epp);
 	if (preference < 0)
 		return preference;
 
-	return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
+	if (raw_epp)
+		return  sprintf(buf, "%d\n", raw_epp);
+	else
+		return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
 }
 
 cpufreq_freq_attr_rw(energy_performance_preference);
-- 
2.25.4

