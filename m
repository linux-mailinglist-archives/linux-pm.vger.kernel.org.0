Return-Path: <linux-pm+bounces-22550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB44A3DE23
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1EC161C20
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008081FBC8A;
	Thu, 20 Feb 2025 15:17:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1861FBCB6
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064628; cv=none; b=hSf/ueemDhe1cNm33u8x1RL9g6WSaNx9w/FiPzPCh2PC4DqxfrDGycLEcV4pc4+9YYpcO7QYalmlxH+1HiYgW6fetTS6UQA8GVRnsQs48MwXlHm/Mn1W57PFLLxb7f900kKHm1I9/SVxk2M28Gd9aZJ9BMt7aFS2KgfRoq/x0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064628; c=relaxed/simple;
	bh=7AFwllYwWSJhDa7SNUXBkZXhvM7NaSAGRL9LqSQWRg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJbfktJ5jbs0BX/uS/CXiVOUURbs67freQAhjrStA6+tHHlJKbCpYmd1Zr039kdL3AEWyx4O+gj/K5z52lsUu9kILOkJMUp/05WyZMVzq1113oR1IcEIkbfAFt4fYjbeJmQnTf8nmSByICcoPB3yYqT+Z3ngivSnDgW/B4SgC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 4ImrKnMlTCOKK9m2h707Kw==
X-CSE-MsgGUID: 89hCiJThQiCcVaIiJofmxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40703680"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40703680"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:17:07 -0800
X-CSE-ConnectionGUID: 09ZL229xQNyuzna1to32RQ==
X-CSE-MsgGUID: wEdgf+acQgqBYzxC21WueA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145922160"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 07:17:05 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2 1/3] intel_idle: Add C1 demotion on/off sysfs knob
Date: Thu, 20 Feb 2025 17:17:00 +0200
Message-ID: <20250220151702.2153579-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220151702.2153579-1-dedekind1@gmail.com>
References: <20250220151702.2153579-1-dedekind1@gmail.com>
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
 drivers/idle/intel_idle.c | 103 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..8d2095078469 100644
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
 	unsigned long auto_demotion_disable_flags;
 	bool byt_auto_demotion_disable_flag;
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
 
@@ -1541,18 +1549,21 @@ static const struct idle_cpu idle_cpu_gmt __initconst = {
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
 
@@ -1591,12 +1602,14 @@ static const struct idle_cpu idle_cpu_snr __initconst = {
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
 
@@ -2291,6 +2304,89 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
 		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
 }
 
+static void intel_c1_demotion_toggle(void *info)
+{
+	unsigned long long msr_val;
+	bool enable = *(bool *)info;
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
+	int err;
+	bool enable;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	mutex_lock(&c1_demotion_mutex);
+	/* Enable/disable C1 demotion on all CPUs */
+	on_each_cpu(intel_c1_demotion_toggle, &enable, 1);
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
+	 * configureation would be a BIOS bug.
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
@@ -2337,6 +2433,8 @@ static int __init intel_idle_init(void)
 		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
 		if (icpu->disable_promotion_to_c1e)
 			c1e_promotion = C1E_PROMOTION_DISABLE;
+		if (icpu->c1_demotion_supported)
+			c1_demotion_supported = true;
 		if (icpu->use_acpi || force_use_acpi)
 			intel_idle_acpi_cst_extract();
 	} else if (!intel_idle_acpi_cst_extract()) {
@@ -2350,6 +2448,10 @@ static int __init intel_idle_init(void)
 	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
 
+	retval = intel_idle_sysfs_init();
+	if (retval)
+		pr_warn("failed to initialized sysfs");
+
 	intel_idle_cpuidle_driver_init(&intel_idle_driver);
 
 	retval = cpuidle_register_driver(&intel_idle_driver);
@@ -2374,6 +2476,7 @@ static int __init intel_idle_init(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 init_driver_fail:
+	intel_idle_sysfs_uninit();
 	free_percpu(intel_idle_cpuidle_devices);
 	return retval;
 
-- 
2.47.1


