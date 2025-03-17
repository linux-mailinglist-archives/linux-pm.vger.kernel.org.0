Return-Path: <linux-pm+bounces-24174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A3A651EA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FF97A65E5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A423FC4E;
	Mon, 17 Mar 2025 13:55:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54923F397
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219747; cv=none; b=PG9TbnBIX2JB3qM4ZeOyKyfSK4KBFR+8/4hDM1T8RRYh2lJnz8qNBep/zw4EjWT/JJSFXnloANpV3qPvCzjHw1xpQWXPmdnZLoupHgn3ct9RhXAPUadkAh7huNwshG6MhnQNDGeixq7PPVdwdi0DdA3f76bsyHrp+yubSwe7ICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219747; c=relaxed/simple;
	bh=zlz96ppQyQeo6w1xmnt0diOWzXZo2TwVSkBvgukLcTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwaFyqeY5VDyIvEsifT8ghvuvXZYYueMPt97aBBaRAoaZGpROZW7LN6JuPmv/zhtDF+0a/VSl0m2S88WusNr6k9qtRaRech6IzZVlaf2alpHYVua1y1K4s5pzzTVRDvz4oEcfxnoqQOl6etCs8InxlhIXFQmhtxDQbRjk/YKiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: mFJyLtxmQumw3avs04Kd3w==
X-CSE-MsgGUID: JIDaYz+UTv6vMzAbFc7u+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43515485"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43515485"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:55:45 -0700
X-CSE-ConnectionGUID: XnB3t3JoRkWJzyy+4ZhTZg==
X-CSE-MsgGUID: szHwbw1cQJG4YivHBcxN9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127115525"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa005.jf.intel.com with ESMTP; 17 Mar 2025 06:55:43 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v3 1/3] intel_idle: Add C1 demotion on/off sysfs knob
Date: Mon, 17 Mar 2025 15:55:39 +0200
Message-ID: <20250317135541.1471754-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317135541.1471754-1-dedekind1@gmail.com>
References: <20250317135541.1471754-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add a sysfs knob to enable/disable C1 demotion for the following Intel
platforms: Sapphire Rapids Xeon, Emerald Rapids Xeon, Granite Rapids Xeon,
Sierra Forest Xeon, and Grand Ridge SoC.

This sysfs file shows up as
"/sys/devices/system/cpu/cpuidle/intel_c1_demotion".

The C1 demotion feature involves the platform firmware demoting deep
C-state requests from the OS (e.g., C6 requests) to C1. The idea is
that firmware monitors CPU wake-up rate, and if it is higher than a
platform-specific threshold, the firmware demotes deep C-state
requests to C1. For example, Linux requests C6, but firmware noticed
too many wake-ups per second, and it keeps the CPU in C1. When the
CPU stays in C1 long enough, the platform promotes it back to C6.

The default value for C1 demotion is whatever is configured by BIOS.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 348c49d50a967..da9da7cb27656 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -48,9 +48,11 @@
 #include <trace/events/power.h>
 #include <linux/sched.h>
 #include <linux/sched/smt.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/sysfs.h>
 #include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -91,9 +93,15 @@ struct idle_cpu {
 	 */
 	unsigned long auto_demotion_disable_flags;
 	bool disable_promotion_to_c1e;
+	bool c1_demotion_supported;
 	bool use_acpi;
 };
 
+static bool c1_demotion_supported;
+static DEFINE_MUTEX(c1_demotion_mutex);
+
+static struct device *sysfs_root __initdata;
+
 static const struct idle_cpu *icpu __initdata;
 static struct cpuidle_state *cpuidle_state_table __initdata;
 
@@ -1539,18 +1547,21 @@ static const struct idle_cpu idle_cpu_gmt __initconst = {
 static const struct idle_cpu idle_cpu_spr __initconst = {
 	.state_table = spr_cstates,
 	.disable_promotion_to_c1e = true,
+	.c1_demotion_supported = true,
 	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_gnr __initconst = {
 	.state_table = gnr_cstates,
 	.disable_promotion_to_c1e = true,
+	.c1_demotion_supported = true,
 	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_gnrd __initconst = {
 	.state_table = gnrd_cstates,
 	.disable_promotion_to_c1e = true,
+	.c1_demotion_supported = true,
 	.use_acpi = true,
 };
 
@@ -1589,12 +1600,14 @@ static const struct idle_cpu idle_cpu_snr __initconst = {
 static const struct idle_cpu idle_cpu_grr __initconst = {
 	.state_table = grr_cstates,
 	.disable_promotion_to_c1e = true,
+	.c1_demotion_supported = true,
 	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_srf __initconst = {
 	.state_table = srf_cstates,
 	.disable_promotion_to_c1e = true,
+	.c1_demotion_supported = true,
 	.use_acpi = true,
 };
 
@@ -2310,6 +2323,88 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
 		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
 }
 
+static void intel_c1_demotion_toggle(void *enable)
+{
+	unsigned long long msr_val;
+
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	/*
+	 * Enable/disable C1 undemotion along with C1 demotion, as this is the
+	 * most sensible configuration in general.
+	 */
+	if (enable)
+		msr_val |= NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
+	else
+		msr_val &= ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE);
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+}
+
+static ssize_t intel_c1_demotion_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	bool enable;
+	int err;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	mutex_lock(&c1_demotion_mutex);
+	/* Enable/disable C1 demotion on all CPUs */
+	on_each_cpu(intel_c1_demotion_toggle, (void *)enable, 1);
+	mutex_unlock(&c1_demotion_mutex);
+
+	return count;
+}
+
+static ssize_t intel_c1_demotion_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	unsigned long long msr_val;
+
+	/*
+	 * Read the MSR value for a CPU and assume it is the same for all CPUs. Any other
+	 * configuration would be a BIOS bug.
+	 */
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOTE));
+}
+static DEVICE_ATTR_RW(intel_c1_demotion);
+
+static int __init intel_idle_sysfs_init(void)
+{
+	int err;
+
+	if (!c1_demotion_supported)
+		return 0;
+
+	sysfs_root = bus_get_dev_root(&cpu_subsys);
+	if (!sysfs_root)
+		return 0;
+
+	err = sysfs_add_file_to_group(&sysfs_root->kobj,
+				      &dev_attr_intel_c1_demotion.attr,
+				      "cpuidle");
+	if (err) {
+		put_device(sysfs_root);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __init intel_idle_sysfs_uninit(void)
+{
+	if (!sysfs_root)
+		return;
+
+	sysfs_remove_file_from_group(&sysfs_root->kobj,
+				     &dev_attr_intel_c1_demotion.attr,
+				     "cpuidle");
+	put_device(sysfs_root);
+}
+
 static int __init intel_idle_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -2360,6 +2455,8 @@ static int __init intel_idle_init(void)
 		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
 		if (icpu->disable_promotion_to_c1e)
 			c1e_promotion = C1E_PROMOTION_DISABLE;
+		if (icpu->c1_demotion_supported)
+			c1_demotion_supported = true;
 		if (icpu->use_acpi || force_use_acpi)
 			intel_idle_acpi_cst_extract();
 	} else if (!intel_idle_acpi_cst_extract()) {
@@ -2373,6 +2470,10 @@ static int __init intel_idle_init(void)
 	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
 
+	retval = intel_idle_sysfs_init();
+	if (retval)
+		pr_warn("failed to initialized sysfs");
+
 	intel_idle_cpuidle_driver_init(&intel_idle_driver);
 
 	retval = cpuidle_register_driver(&intel_idle_driver);
@@ -2397,6 +2498,7 @@ static int __init intel_idle_init(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 init_driver_fail:
+	intel_idle_sysfs_uninit();
 	free_percpu(intel_idle_cpuidle_devices);
 	return retval;
 
-- 
2.48.1


