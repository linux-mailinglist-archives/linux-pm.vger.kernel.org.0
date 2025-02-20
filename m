Return-Path: <linux-pm+bounces-22554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A9A3DF07
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E6B19C2EB0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEA1FDE26;
	Thu, 20 Feb 2025 15:43:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D391D5CD7
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066192; cv=none; b=R5tff5NNLwi5j6sKYjngfVu9PKXfgNzQ5iOQhpGN9KdvKj55nN14thpeA4fZ2w5PzfZZm28e6wsmC8moNyQTu71Qg4T5tSvu1Ej/B3jrD2f0hJraOtBhUXmv5nBnmGa5jDgJAu83Ebw0WvU3slKjwKidTha3BRWzDk1WnK13gD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066192; c=relaxed/simple;
	bh=mpK7xvCaIZeSnM644h0NkBL1KaB1rqNoJnuC3oVvU9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+pYi+oABAEJ6VUVSKXIr69cUNuk+h1dK+1tdKSARp+pX9rwz4IdPXh+z6LxhtKk9e/nS3B1/5tNbQ43CiEv94d17KlUtDF7InOyn/Fpd/5TnvgPQc9jgYhuC2JMEXMbWolUpuSkOOVhhM52V6bISIQCQK8ZMqxkg1x5jIx4f5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: x+o3h3m8T5S5BQMzvFMjBg==
X-CSE-MsgGUID: yg8LqaXjT8G1Hyaja6GB0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40775682"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40775682"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:43:10 -0800
X-CSE-ConnectionGUID: uUec2hy3TKSsKIZmlEKJJA==
X-CSE-MsgGUID: IX4mtYPLQ76UQ/kknT4zSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120173933"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2025 07:43:09 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 1/1] x86: msr: add new 'msr_pkg_cst_config_control.h' header
Date: Thu, 20 Feb 2025 17:43:06 +0200
Message-ID: <20250220154306.2166129-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220154306.2166129-1-dedekind1@gmail.com>
References: <20250220154306.2166129-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

There are now two users that modify the MSR_PKG_CST_CONFIG_CONTROL register:
1. The Intel PMC framework (cnp.c).
2. The intel_idle.c driver.

They do not interfere with each other because the former modifies it only
during suspend/resume.

Introduce common accessor functions for the MSR to make it more clear that
there is already more than one user. There is no other purpose at this point.
But if more users are introduced, the header file may be replaced with a small
MSR_PKG_CST_CONFIG_CONTROL subsystem, possibly implementing locking.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 .../include/asm/msr_pkg_cst_config_control.h  | 28 +++++++++++++++++++
 drivers/idle/intel_idle.c                     | 17 +++++------
 drivers/platform/x86/intel/pmc/cnp.c          | 13 +++++----
 3 files changed, 44 insertions(+), 14 deletions(-)
 create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.h

diff --git a/arch/x86/include/asm/msr_pkg_cst_config_control.h b/arch/x86/include/asm/msr_pkg_cst_config_control.h
new file mode 100644
index 000000000000..0d9dab4c20ef
--- /dev/null
+++ b/arch/x86/include/asm/msr_pkg_cst_config_control.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Accessors from MSR_PKG_CST_CONFIG_CONTROL (0xe2) MSR found on Intel CPUs.
+ *
+ * At this point provide only trival read/write functions. But this header file
+ * can be turned into a small library if there are more MSR users in the future.
+ */
+
+#ifndef _MSR_PKG_CST_CONFIG_CONTROL_H
+#define _MSR_PKG_CST_CONFIG_CONTROL_H
+
+#include <asm/msr-index.h>
+#include <asm/msr.h>
+
+static inline unsigned long long rdmsrl_pkg_cst_config_control(void)
+{
+	unsigned long long val;
+
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	return val;
+}
+
+static inline void wrmsrl_pkg_cst_config_control(unsigned long long val)
+{
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+}
+
+#endif /* _MSR_PKG_CST_CONFIG_CONTROL_H */
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8d2095078469..e5415e20e0e3 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -59,6 +59,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/msr_pkg_cst_config_control.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -1975,7 +1976,7 @@ static void __init sklh_idle_state_table_update(void)
 	if ((mwait_substates & (0xF << 28)) == 0)
 		return;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+	msr = rdmsrl_pkg_cst_config_control();
 
 	/* PC10 is not enabled in PKG C-state limit */
 	if ((msr & 0xF) != 8)
@@ -2006,7 +2007,7 @@ static void __init skx_idle_state_table_update(void)
 {
 	unsigned long long msr;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+	msr = rdmsrl_pkg_cst_config_control();
 
 	/*
 	 * 000b: C0/C1 (no package C-state support)
@@ -2059,7 +2060,7 @@ static void __init spr_idle_state_table_update(void)
 	 * C6. However, if PC6 is disabled, we update the numbers to match
 	 * core C6.
 	 */
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+	msr = rdmsrl_pkg_cst_config_control();
 
 	/* Limit value 2 and above allow for PC6. */
 	if ((msr & 0x7) < 2) {
@@ -2221,9 +2222,9 @@ static void auto_demotion_disable(void)
 {
 	unsigned long long msr_bits;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
+	msr_bits = rdmsrl_pkg_cst_config_control();
 	msr_bits &= ~auto_demotion_disable_flags;
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
+	wrmsrl_pkg_cst_config_control(msr_bits);
 }
 
 static void c1e_promotion_enable(void)
@@ -2309,7 +2310,7 @@ static void intel_c1_demotion_toggle(void *info)
 	unsigned long long msr_val;
 	bool enable = *(bool *)info;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	msr_val = rdmsrl_pkg_cst_config_control();
 	/*
 	 * Enable/disable C1 undemotion along with C1 demotion, as this is the
 	 * most sensible configuration in general.
@@ -2318,7 +2319,7 @@ static void intel_c1_demotion_toggle(void *info)
 		msr_val |= NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
 	else
 		msr_val &= ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE);
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	wrmsrl_pkg_cst_config_control(msr_val);
 }
 
 static ssize_t intel_c1_demotion_store(struct device *dev,
@@ -2349,7 +2350,7 @@ static ssize_t intel_c1_demotion_show(struct device *dev,
 	 * Read the MSR value for a CPU and assume it is the same for all CPUs. Any other
 	 * configureation would be a BIOS bug.
 	 */
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	msr_val = rdmsrl_pkg_cst_config_control();
 	return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOTE));
 }
 static DEVICE_ATTR_RW(intel_c1_demotion);
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index fc5193fdf8a8..4ef8dfe07664 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -10,6 +10,7 @@
 
 #include <linux/smp.h>
 #include <linux/suspend.h>
+#include <asm/msr_pkg_cst_config_control.h>
 #include "core.h"
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -225,12 +226,12 @@ static DEFINE_PER_CPU(u64, pkg_cst_config);
 static void disable_c1_auto_demote(void *unused)
 {
 	int cpunum = smp_processor_id();
-	u64 val;
+	unsigned long long val;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	val = rdmsrl_pkg_cst_config_control();
 	per_cpu(pkg_cst_config, cpunum) = val;
 	val &= ~NHM_C1_AUTO_DEMOTE;
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	wrmsrl_pkg_cst_config_control(val);
 
 	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
 }
@@ -238,11 +239,11 @@ static void disable_c1_auto_demote(void *unused)
 static void restore_c1_auto_demote(void *unused)
 {
 	int cpunum = smp_processor_id();
+	unsigned long long val = per_cpu(pkg_cst_config, cpunum);
 
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
+	wrmsrl_pkg_cst_config_control(val);
 
-	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
-		 per_cpu(pkg_cst_config, cpunum));
+	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
 }
 
 static void s2idle_cpu_quirk(smp_call_func_t func)
-- 
2.47.1


