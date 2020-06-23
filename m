Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766BB2048FD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 07:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFWFMk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 01:12:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:8579 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgFWFMj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 01:12:39 -0400
IronPort-SDR: XmhRzz8+TSgV2F7siaLj04i0VxG1JKRU4ZMSsxEZVnOH5sSuFJ/IXQG4IVPCvf16yxv62JgKC4
 Z1Ijqlityzyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="132378788"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="132378788"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 22:12:38 -0700
IronPort-SDR: /GR5SaCIvXV+LEaMY3PmkvvZujnIu1VD9y1RZcWXbSaWhvem7rDc3sIfZNFNyNsoOecxbZJUE1
 6v/lvRS/MpxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="311165676"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.228.38])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2020 22:12:37 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Allow raw energy performance preference value
Date:   Mon, 22 Jun 2020 22:12:33 -0700
Message-Id: <20200623051233.1419218-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200623051233.1419218-1-srinivas.pandruvada@linux.intel.com>
References: <20200623051233.1419218-1-srinivas.pandruvada@linux.intel.com>
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

These four values supposed to cover broad spectrum of use cases, but they
are not uniformly distributed in the range. There are number of cases,
where this is not enough. For example:

Suppose user wants more performance when connected to AC. Instead of using
default "balance performance", the "performance" setting can be used. This
changes EPP value from 0x80 to 0x00. But setting EPP to 0, results in
electrical and thermal issues on some platforms. This results in CPU to do
aggressive throttling, which causes drop in performance. But some value
between 0x80 and 0x00 results in better performance. But that value can't
be fixed as the power curve is not linear. In some cases just changing EPP
from 0x80 to 0x75 is enough to get significant performance gain.

Similarly on battery EPP 0x80 can be very aggressive in power consumption.
But picking up the next choice "balance power" results in too much loss
of performance, which cause bad user experience in use case like "Google
Hangout". It was observed that some value between these two EPP is
optimal.

This change allows fine grain EPP tuning for platform like Chromebooks.
Here based on the product and use cases, different EPP values can be set.
This change is similar to the change done for:
/sys/devices/system/cpu/cpu*/power/energy_perf_bias
where user has choice to write a predefined string or raw value.

The change itself is trivial. When user preference doesn't match
predefined string preferences and value is an unsigned integer and in
range, use that value for EPP/EPB.

Suggested-by: Len Brown <lenb@kernel.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |  4 +-
 drivers/cpufreq/intel_pstate.c                | 63 ++++++++++++++++---
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 939bfdc53f4f..1f4ef187f8a5 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -561,7 +561,9 @@ somewhere between the two extremes:
 Strings written to the ``energy_performance_preference`` attribute are
 internally translated to integer values written to the processor's
 Energy-Performance Preference (EPP) knob (if supported) or its
-Energy-Performance Bias (EPB) knob.
+Energy-Performance Bias (EPB) knob. It is also possible to write a positive
+integer value between 0 to 255 for EPP or 0 to 15 for EPB. Writing Invalid
+value results in error.
 
 [Note that tasks may by migrated from one CPU to another by the scheduler's
 load-balancing algorithm and if different energy vs performance hints are
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1cf6d06f2314..251813b7060b 100644
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
@@ -631,6 +634,13 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
 		 * value which can be set. Here only using top two bits
 		 * effectively.
 		 */
+
+		if (epp & 0x03) {
+			/* Raw value was set in EPB */
+			*raw_epp = epp;
+			return 0;
+		}
+
 		index = (epp >> 2) + 1;
 	}
 
@@ -638,7 +648,8 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
 }
 
 static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
-					      int pref_index)
+					      int pref_index, bool use_raw,
+					      u32 raw_epp)
 {
 	int epp = -EINVAL;
 	int ret;
@@ -657,12 +668,31 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 
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
 
 		value |= (u64)epp << 24;
 		ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
 	} else {
+		if (use_raw) {
+			if (raw_epp > 0x0f) {
+				ret = -EINVAL;
+				goto return_pref;
+			}
+			ret = intel_pstate_set_epb(cpu_data->cpu, epp);
+			goto return_pref;
+		}
+
 		if (epp == -EINVAL)
 			epp = (pref_index - 1) << 2;
 		ret = intel_pstate_set_epb(cpu_data->cpu, epp);
@@ -694,6 +724,8 @@ static ssize_t store_energy_performance_preference(
 {
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
 	char str_preference[21];
+	bool raw = false;
+	u32 epp;
 	int ret;
 
 	ret = sscanf(buf, "%20s", str_preference);
@@ -701,10 +733,18 @@ static ssize_t store_energy_performance_preference(
 		return -EINVAL;
 
 	ret = match_string(energy_perf_strings, -1, str_preference);
-	if (ret < 0)
+	if (ret < 0) {
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
 
@@ -712,13 +752,16 @@ static ssize_t show_energy_performance_preference(
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

