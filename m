Return-Path: <linux-pm+bounces-33777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A0B42DDF
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 02:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37C21BC316B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 00:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61111185;
	Thu,  4 Sep 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKlZvOGe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3734C83;
	Thu,  4 Sep 2025 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944374; cv=none; b=SRh8Oldh1FgXH7D2maLYmPompHYFSoayOxlxCo23qf+FMJGlynvUnZGno5X5BQ4lYex14gTPN44GIlnE4t9frkPkBhpZBewfJbKpnByQBODmz68ms+2hgNeRJ91A653loSEdmZ8tshIZC0VfXnrkS9gOO2d1tzCk3KggkfQJDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944374; c=relaxed/simple;
	bh=ueQqSFAkz7inyl+gUZAJz0CtG/v1zHEcbuhSN35iGGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2AZ4WXjJnFAK0XwabOsXwvGrZJzbj617OYMXRyasNSe99lC/cI2fDi9Gmr2RK46FJlvNVWwIvXmBtaLw7Fsb7yAnnQkkjE3kTkUKIDNYvgfmG8sf9Wk+2w4IyY2EbCFq6eP5dHTvMVS/6CzQIIOEJgtJqlqPD64wruZdOYwO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKlZvOGe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756944372; x=1788480372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ueQqSFAkz7inyl+gUZAJz0CtG/v1zHEcbuhSN35iGGo=;
  b=dKlZvOGeuCvylj/mMoC1iaPt6UKZB9i5paO6IWZZlDr15Zz7FkLDaGDd
   E3BxswjfSHe0fD07W7Ooy0vgJOUXJUHk8gqs4a+s6jMVIHfums8sybFj5
   i3Ak6SLu+C8a4Y8nfbd4HmmB9JUwCAkPnmsmmkuTQlIco5kZE4pgWOcgO
   02TNweWxftZdulGeLpfs7Ka9tL2Bdy15zIjggSWXOLybn8NYmhV3Wn1dB
   HKG2ovSF0lwHu9a5iwcxwdUeHSoA+YPjKDPzftek/3NmXOMea3q9nGAZM
   Ht2HMZ2JbKm+I3+cBTPBr3JRMk1DKpNxSaRfzXhCDzKt2J2bgla+LUyNC
   A==;
X-CSE-ConnectionGUID: oHZ3Q1f3QTWAvpJy9yMdCQ==
X-CSE-MsgGUID: AmFDZtOLQBqQaqNcdGu0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="46847199"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="46847199"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 17:06:10 -0700
X-CSE-ConnectionGUID: SSs88hKHT6iVvkhM+Ra0rg==
X-CSE-MsgGUID: dqzO2MoDSzeH1wK6SEzLyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="172099997"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa008.fm.intel.com with ESMTP; 03 Sep 2025 17:06:09 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Enable HWP without EPP feature
Date: Wed,  3 Sep 2025 17:06:08 -0700
Message-ID: <20250904000608.260817-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
References: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When EPP feature is not available (CPUID CPUID.06H:EAX[10] is not set),
intel_pstate will not enable HWP.

Some processors support DEC feature (Dynamic Efficiency Control). But in
this case HWP must be enabled.

So, enable HWP even if EPP feature is not available but DEC feature is
present.

When EPP feature is not available don't publish sysfs attributes
"energy_performance_available_preferences" and
"energy_performance_preference", but continue to enable HWP.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c28454b16723..d74abe909fbc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -904,6 +904,11 @@ static struct freq_attr *hwp_cpufreq_attrs[] = {
 	NULL,
 };
 
+static struct freq_attr *hwp_cpufreq_default_attrs[] = {
+	&base_frequency,
+	NULL,
+};
+
 static bool no_cas __ro_after_init;
 
 static struct cpudata *hybrid_max_perf_cpu __read_mostly;
@@ -1370,6 +1375,9 @@ static void intel_pstate_hwp_offline(struct cpudata *cpu)
 #define POWER_CTL_EE_ENABLE	1
 #define POWER_CTL_EE_DISABLE	2
 
+/* Enable bit for Dynamic Efficiency Control (DEC) */
+#define POWER_CTL_DEC_ENABLE	27
+
 static int power_ctl_ee_state;
 
 static void set_power_ctl_ee_state(bool input)
@@ -3761,6 +3769,17 @@ static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	{}
 };
 
+static bool dec_enabled(void)
+{
+	u64 power_ctl;
+
+	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
+	if (power_ctl & BIT(POWER_CTL_DEC_ENABLE))
+		return true;
+
+	return false;
+}
+
 static int __init intel_pstate_init(void)
 {
 	static struct cpudata **_all_cpu_data;
@@ -3793,15 +3812,24 @@ static int __init intel_pstate_init(void)
 		 * Avoid enabling HWP for processors without EPP support,
 		 * because that means incomplete HWP implementation which is a
 		 * corner case and supporting it is generally problematic.
+		 * But when DEC enable bit is set (MSR 0x1FC bit 27), continue
+		 * to enable HWP.
 		 *
 		 * If HWP is enabled already, though, there is no choice but to
 		 * deal with it.
 		 */
-		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
+		if (!no_hwp || hwp_forced) {
+			if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
+				intel_pstate.attr = hwp_cpufreq_attrs;
+				intel_cpufreq.attr = hwp_cpufreq_attrs;
+			} else if (dec_enabled()) {
+				intel_pstate.attr = hwp_cpufreq_default_attrs;
+				intel_cpufreq.attr = hwp_cpufreq_default_attrs;
+			} else {
+				goto skip_hwp_enable;
+			}
 			hwp_active = true;
 			hwp_mode_bdw = id->driver_data;
-			intel_pstate.attr = hwp_cpufreq_attrs;
-			intel_cpufreq.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.flags |= CPUFREQ_NEED_UPDATE_LIMITS;
 			intel_cpufreq.adjust_perf = intel_cpufreq_adjust_perf;
 			if (!default_driver)
@@ -3811,6 +3839,7 @@ static int __init intel_pstate_init(void)
 
 			goto hwp_cpu_matched;
 		}
+skip_hwp_enable:
 		pr_info("HWP not enabled\n");
 	} else {
 		if (no_load)
-- 
2.51.0


