Return-Path: <linux-pm+bounces-34460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AEB531AA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1C25621D5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851822E6CD4;
	Thu, 11 Sep 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKojiEf0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0E1A2387;
	Thu, 11 Sep 2025 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592156; cv=none; b=ayDgiHX8bWKavBg2t2/JIF9GwRkryrdkxLeLVtcZY+BxQRhYmCZ9WbgdIcOeuEN+jO+C0dpHX8wcLF9P4/N3D1F3rJNtgQBtdg+2x3fVBqo9+a7Qy2DyGf2nSSRADxwJ0GISHiik5SnUDLi5k0YR9uGaO3ea91MVEYJvJiNziYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592156; c=relaxed/simple;
	bh=zpM+DhWj9YA1TN35eXjLmbBj8/Oaj6d6nonmt/fS7vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iVD/rXcVWvgAYj8+iZBO76gYwq8W+x3JsYpqcBRQDqz2aEhl6pfd2H2kfINIWVuCdGKsT/HvwX7Js3+G7L6z7BNSg6v+oS3P7Qfw9Atl8hlkkGFjZo+ZTrGwXoV9iucZIg0m5rPJLEG1azmP7VziFSGQnt1iVulfil84LHkn5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKojiEf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325FDC4CEF0;
	Thu, 11 Sep 2025 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757592155;
	bh=zpM+DhWj9YA1TN35eXjLmbBj8/Oaj6d6nonmt/fS7vU=;
	h=From:To:Cc:Subject:Date:From;
	b=XKojiEf0wXIYGMnKK31tkYHyJWLDp7WB+ZpauArW9aR+PmsnUXkKkX6WFzI+fmR1n
	 KjqAYmyo5aP0Je16w/fETeZJUtpTuWO8AL2tzbmNy2KOoggrCEkQVa/rmWVVwf1WdX
	 LrHd1XVWGRC3aqkhyumBGvU/sXIuBF5AerGJG28GTlJTpz6iX4FyBlKZj4Pcjf6+Pp
	 X/fynI0Kkup6yW6jjf2MauOU8cGfqRpwUwr3BBuPZN0jo2H1Vu54SCF4WuctcgsOqH
	 TSD/dkDCXkXsRnrzlaj6TbOlAe2c8eYMFJdhe8BSCjXf+/K2E9P0SngeYBwmzqoXym
	 oHGq7X8bndMbw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Enable HWP without EPP if DEC is enabled
Date: Thu, 11 Sep 2025 14:02:33 +0200
Message-ID: <12744761.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

So far, HWP has never been enabled without EPP (Energy-Performance
Preference) interface support, since the lack of the latter indicates an
incomplete implementation of HWP, which was the case on early development
vehicle platforms.  However, HWP can be expected to work if DEC (Dynamic
Efficiency Control) is enabled as indicated by setting bit 27 in
MSR_IA32_POWER_CTL (DEC enable bit).

Accordingly, allow HWP to be enabled if the EPP interface is not
supported so long as DEC is enabled in the processor.

Still, the EPP control sysfs interface is useless when EPP is not
supported, so do not expose it in that case.

Link: https://lore.kernel.org/linux-pm/20250904000608.260817-2-srinivas.pandruvada@linux.intel.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   72 +++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 16 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -897,11 +897,19 @@ static ssize_t show_base_frequency(struc
 
 cpufreq_freq_attr_ro(base_frequency);
 
+enum hwp_cpufreq_attr_index {
+	HWP_BASE_FREQUENCY_INDEX = 0,
+	HWP_PERFORMANCE_PREFERENCE_INDEX,
+	HWP_PERFORMANCE_AVAILABLE_PREFERENCES_INDEX,
+	HWP_CPUFREQ_ATTR_COUNT,
+};
+
 static struct freq_attr *hwp_cpufreq_attrs[] = {
-	&energy_performance_preference,
-	&energy_performance_available_preferences,
-	&base_frequency,
-	NULL,
+	[HWP_BASE_FREQUENCY_INDEX] = &base_frequency,
+	[HWP_PERFORMANCE_PREFERENCE_INDEX] = &energy_performance_preference,
+	[HWP_PERFORMANCE_AVAILABLE_PREFERENCES_INDEX] =
+				&energy_performance_available_preferences,
+	[HWP_CPUFREQ_ATTR_COUNT] = NULL,
 };
 
 static bool no_cas __ro_after_init;
@@ -1370,6 +1378,9 @@ static void intel_pstate_hwp_offline(str
 #define POWER_CTL_EE_ENABLE	1
 #define POWER_CTL_EE_DISABLE	2
 
+/* Enable bit for Dynamic Efficiency Control (DEC) */
+#define POWER_CTL_DEC_ENABLE	27
+
 static int power_ctl_ee_state;
 
 static void set_power_ctl_ee_state(bool input)
@@ -3758,6 +3769,26 @@ static const struct x86_cpu_id intel_hyb
 	{}
 };
 
+static bool hwp_check_epp(void)
+{
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
+		return true;
+
+	/* Without EPP support, don't expose EPP-related sysfs attributes. */
+	hwp_cpufreq_attrs[HWP_PERFORMANCE_PREFERENCE_INDEX] = NULL;
+	hwp_cpufreq_attrs[HWP_PERFORMANCE_AVAILABLE_PREFERENCES_INDEX] = NULL;
+
+	return false;
+}
+
+static bool hwp_check_dec(void)
+{
+	u64 power_ctl;
+
+	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
+	return !!(power_ctl & BIT(POWER_CTL_DEC_ENABLE));
+}
+
 static int __init intel_pstate_init(void)
 {
 	static struct cpudata **_all_cpu_data;
@@ -3778,23 +3809,32 @@ static int __init intel_pstate_init(void
 
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
-		hwp_forced = intel_pstate_hwp_is_enabled();
+		bool epp_present = hwp_check_epp();
 
-		if (hwp_forced)
+		/*
+		 * If HWP is enabled already, there is no choice but to deal
+		 * with it.
+		 */
+		hwp_forced = intel_pstate_hwp_is_enabled();
+		if (hwp_forced) {
 			pr_info("HWP enabled by BIOS\n");
-		else if (no_load)
+			no_hwp = 0;
+		} else if (no_load) {
 			return -ENODEV;
+		} else if (!epp_present && !hwp_check_dec()) {
+			/*
+			 * Avoid enabling HWP for processors without EPP support
+			 * unless the Dynamic Efficiency Control (DEC) enable
+			 * bit (MSR_IA32_POWER_CTL, bit 27) is set because that
+			 * means incomplete HWP implementation which is a corner
+			 * case and supporting it is generally problematic.
+			 */
+			no_hwp = 1;
+		}
 
 		copy_cpu_funcs(&core_funcs);
-		/*
-		 * Avoid enabling HWP for processors without EPP support,
-		 * because that means incomplete HWP implementation which is a
-		 * corner case and supporting it is generally problematic.
-		 *
-		 * If HWP is enabled already, though, there is no choice but to
-		 * deal with it.
-		 */
-		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
+
+		if (!no_hwp) {
 			hwp_active = true;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;




