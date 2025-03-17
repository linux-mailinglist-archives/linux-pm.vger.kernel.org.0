Return-Path: <linux-pm+bounces-24188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E331A65461
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086187A2A0F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B892441A0;
	Mon, 17 Mar 2025 14:54:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9DC2376E1
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223275; cv=none; b=XJvd9EyIJSuByD4gb1cUsjfgCKjoIwNkvznPCahXE6s4yGKXSHN/a7Vpfy42Qf6VlwDsgCgUYt9DrExCzRAzhYnWhv6imngHZ5vbKKXE6prGPlt9f2oXtRjPPyNt2C0jKP1uPdusz8pI0uYTERaePTzy4CehDybONaGTH+n7nL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223275; c=relaxed/simple;
	bh=eZxDvEcQ8edIWRCINUYtlnm6C++iRo81/deJLCjgGc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjVHhWRqRH3ZD9SfJeDUcy6PpZPYthP7BQ2APJunQBwqWg+dN21+HEmpJI6QAWydvYfgDpJyBw5RyMklILpWovIhiZygEDcEIbW2igDqli2mqlLGJ/n8OV4eajMvK/WmYRUp77dppOjnja3CUfY/g+Qbpuu/fAXspAqUtV4FzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: KbVCfiKbTLyFRYn5AoOpYw==
X-CSE-MsgGUID: kL4lcf7aRG6g2fuc4QNcfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="60711788"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="60711788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:54:33 -0700
X-CSE-ConnectionGUID: 0WU6zaLEST6m6I00dRd+NA==
X-CSE-MsgGUID: dt0L/MHUS/m0RwGOv1kbKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121682636"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2025 07:54:32 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [RFC PATCH v2 1/1] x86: msr: add 'msr_pkg_cst_config_control.h' header
Date: Mon, 17 Mar 2025 16:54:30 +0200
Message-ID: <20250317145430.2153013-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317145430.2153013-1-dedekind1@gmail.com>
References: <20250317145430.2153013-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

There are now two places where the C1 demotion feature gets
enabled/disabled using the read-modify-write semantics:
1. The Intel PMC framework (cnp.c).
2. The intel_idle.c driver.

Introduce a common helper function enabling/disabling C1 demotion bit of
the MSR_PKG_CST_CONFIG_CONTROL register.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 .../include/asm/msr_pkg_cst_config_control.h  | 41 +++++++++++++++++++
 drivers/idle/intel_idle.c                     | 10 +----
 drivers/platform/x86/intel/pmc/cnp.c          |  7 ++--
 3 files changed, 46 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.h

diff --git a/arch/x86/include/asm/msr_pkg_cst_config_control.h b/arch/x86/include/asm/msr_pkg_cst_config_control.h
new file mode 100644
index 0000000000000..3593e0fe650a7
--- /dev/null
+++ b/arch/x86/include/asm/msr_pkg_cst_config_control.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Accessor functions for the MSR_PKG_CST_CONFIG_CONTROL (0xE2) MSR, found on
+ * some Intel processors.
+ */
+
+#ifndef _MSR_PKG_CST_CONFIG_CONTROL_H
+#define _MSR_PKG_CST_CONFIG_CONTROL_H
+
+#include <asm/msr-index.h>
+#include <asm/msr.h>
+
+/**
+ * msr_pkg_cst_config_set_c1_demotion - Enable/disable C1 demotion.
+ * @set: Enable C1 demotion if true, disable it if false.
+ * @other_bits: Additional bits to set or clear in the register.
+ *
+ * Read-modify-write the MSR_PKG_CST_CONFIG_CONTROL register to enable or
+ * disable C1 demotion. The caller should take care of locking if necessary.
+ *
+ * Return: The new value of the MSR_PKG_CST_CONFIG_CONTROL register after
+ * modification.
+ */
+static inline unsigned long long
+msr_pkg_cst_config_set_c1_demotion(bool set, unsigned long long other_bits)
+{
+	unsigned long long val;
+
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+
+	if (set)
+		val |= NHM_C1_AUTO_DEMOTE | other_bits;
+	else
+		val &= ~(NHM_C1_AUTO_DEMOTE | other_bits);
+
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+
+	return val;
+}
+
+#endif /* _MSR_PKG_CST_CONFIG_CONTROL_H */
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index da9da7cb27656..0dee44b489064 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -60,6 +60,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/tsc.h>
 #include <asm/fpu/api.h>
+#include <asm/msr_pkg_cst_config_control.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -2325,18 +2326,11 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
 
 static void intel_c1_demotion_toggle(void *enable)
 {
-	unsigned long long msr_val;
-
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
 	/*
 	 * Enable/disable C1 undemotion along with C1 demotion, as this is the
 	 * most sensible configuration in general.
 	 */
-	if (enable)
-		msr_val |= NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
-	else
-		msr_val &= ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE);
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	msr_pkg_cst_config_set_c1_demotion(!!enable, SNB_C1_AUTO_UNDEMOTE);
 }
 
 static ssize_t intel_c1_demotion_store(struct device *dev,
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index fc5193fdf8a88..d4e0d02a690ff 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -10,6 +10,7 @@
 
 #include <linux/smp.h>
 #include <linux/suspend.h>
+#include <asm/msr_pkg_cst_config_control.h>
 #include "core.h"
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -227,10 +228,8 @@ static void disable_c1_auto_demote(void *unused)
 	int cpunum = smp_processor_id();
 	u64 val;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
-	per_cpu(pkg_cst_config, cpunum) = val;
-	val &= ~NHM_C1_AUTO_DEMOTE;
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	val = msr_pkg_cst_config_set_c1_demotion(false, 0)
+	per_cpu(pkg_cst_config, cpunum) = val
 
 	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
 }
-- 
2.48.1


