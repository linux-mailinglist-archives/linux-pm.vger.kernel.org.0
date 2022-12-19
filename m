Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F77650EBF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 16:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiLSPjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiLSPjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 10:39:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35AA11178
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 07:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671464351; x=1703000351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+upwQwze58+VXG+39ATg90l00WT7gm0SqCvuLlxgE3E=;
  b=fugq2C28dNIt3SjEuyhkICIyDYAEie6iDVdPdtrgG8Fxct7fCUG2T83a
   EDPEzZrQzsAse1dqY1XdEnsibfd599foMqAEYS+hdg3pBcQ2mO9gyOhXn
   oTCZUBlUuYflJLGDkw+1CgSYy+VjZhMapMsqf9M4uMdpa8Zz/PQdUeSDe
   bPSNYPgc+4nd9XtW8TRZyKgiv4wBY7LwkxEcwhkvDqlHbUGh7Mmcm/ExT
   uNybNwgcA+UCJj+Xi6rTcERVZ2oEEJ60M53TcWNAtGDm9btJhxqPvJrFn
   QoJ5HPLWxrr2CWtM3air16vRoL21KZuO0jhQqt4aoygbkElFxq7dHeWhH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307051207"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="307051207"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 07:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="774960313"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774960313"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 07:39:09 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 1/6] thermal/intel: Introduce Intel TCC library
Date:   Mon, 19 Dec 2022 23:46:15 +0800
Message-Id: <20221219154620.3630-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219154620.3630-1-rui.zhang@intel.com>
References: <20221219154620.3630-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are several different drivers that accesses the Intel TCC
(thermal control circuitry) MSRs, and each of them has its own
implementation for the same functionalities, e.g. getting the current
temperature, getting the tj_max, and getting/setting the tj_max offset.

Introduce a library to unify the code for Intel CPU TCC MSR access.

At the same time, ensure the temperature is got based on the updated
tjmax value because tjmax can be changed at runtime for cases like
the Intel SST-PP (Intel Speed Select Technology - Performance Profile)
level change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/Kconfig     |   4 +
 drivers/thermal/intel/Makefile    |   1 +
 drivers/thermal/intel/intel_tcc.c | 139 ++++++++++++++++++++++++++++++
 include/linux/intel_tcc.h         |  18 ++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/thermal/intel/intel_tcc.c
 create mode 100644 include/linux/intel_tcc.h

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index f0c845679250..6b938c040d6e 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -12,6 +12,10 @@ config X86_THERMAL_VECTOR
 	def_bool y
 	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
 
+config INTEL_TCC
+	bool
+	depends on X86
+
 config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
index 9a8d8054f316..5d8833c82ab6 100644
--- a/drivers/thermal/intel/Makefile
+++ b/drivers/thermal/intel/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for various Intel thermal drivers.
 
+obj-$(CONFIG_INTEL_TCC)	+= intel_tcc.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
 obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
 obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
new file mode 100644
index 000000000000..2e5c741c41ca
--- /dev/null
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * intel_tcc.c - Library for Intel TCC (thermal control circuitry) MSR access
+ * Copyright (c) 2022, Intel Corporation.
+ */
+
+#include <linux/errno.h>
+#include <linux/intel_tcc.h>
+#include <asm/msr.h>
+
+/**
+ * intel_tcc_get_tjmax() - returns the default TCC activation Temperature
+ * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ *
+ * Get the TjMax value, which is the default thermal throttling or TCC
+ * activation temperature in degrees C.
+ *
+ * Return: Tjmax value in degrees C on success, negative error code otherwise.
+ */
+int intel_tcc_get_tjmax(int cpu)
+{
+	u32 low, high;
+	int val, err;
+
+	if (cpu < 0)
+		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+	else
+		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+	if (err)
+		return err;
+
+	val = (low >> 16) & 0xff;
+
+	return val ? val : -ENODATA;
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, INTEL_TCC);
+
+/**
+ * intel_tcc_get_offset() - returns the TCC Offset value to Tjmax
+ * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ *
+ * Get the TCC offset value to Tjmax. The effective thermal throttling or TCC
+ * activation temperature equals "Tjmax" - "TCC Offset", in degrees C.
+ *
+ * Return: Tcc offset value in degrees C on success, negative error code otherwise.
+ */
+int intel_tcc_get_offset(int cpu)
+{
+	u32 low, high;
+	int err;
+
+	if (cpu < 0)
+		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+	else
+		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+	if (err)
+		return err;
+
+	return (low >> 24) & 0x3f;
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
+
+/**
+ * intel_tcc_set_offset() - set the TCC offset value to Tjmax
+ * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @offset: TCC offset value in degree C
+ *
+ * Set the TCC Offset value to Tjmax. The effective thermal throttling or TCC
+ * activation temperature equals "Tjmax" - "TCC Offset", in degree C.
+ *
+ * Return: On success returns 0, negative error code otherwise.
+ */
+
+int intel_tcc_set_offset(int cpu, int offset)
+{
+	u32 low, high;
+	int err;
+
+	if (offset < 0 || offset > 0x3f)
+		return -EINVAL;
+
+	if (cpu < 0)
+		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+	else
+		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+	if (err)
+		return err;
+
+	/* MSR Locked */
+	if (low & BIT(31))
+		return -EPERM;
+
+	low &= ~(0x3f << 24);
+	low |= offset << 24;
+
+	if (cpu < 0)
+		return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, low, high);
+	else
+		return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, low, high);
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
+
+/**
+ * intel_tcc_get_temp() - returns the current temperature
+ * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
+ *
+ * Get the current temperature returned by the CPU core/package level
+ * thermal sensor, in degrees C.
+ *
+ * Return: Temperature in degrees C on success, negative error code otherwise.
+ */
+int intel_tcc_get_temp(int cpu, bool pkg)
+{
+	u32 low, high;
+	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
+	int tjmax, temp, err;
+
+	tjmax = intel_tcc_get_tjmax(cpu);
+	if (tjmax < 0)
+		return tjmax;
+
+	if (cpu < 0)
+		err = rdmsr_safe(msr, &low, &high);
+	else
+		err = rdmsr_safe_on_cpu(cpu, msr, &low, &high);
+	if (err)
+		return err;
+
+	/* Temperature is beyond the valid thermal sensor range */
+	if (!(low & BIT(31)))
+		return -ENODATA;
+
+	temp = tjmax - ((low >> 16) & 0x7f);
+
+	/* Do not allow negative CPU temperature */
+	return temp >= 0 ? temp : -ENODATA;
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
new file mode 100644
index 000000000000..f422612c28d6
--- /dev/null
+++ b/include/linux/intel_tcc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  header for Intel TCC (thermal control circuitry) library
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ */
+
+#ifndef __INTEL_TCC_H__
+#define __INTEL_TCC_H__
+
+#include <linux/types.h>
+
+int intel_tcc_get_tjmax(int cpu);
+int intel_tcc_get_offset(int cpu);
+int intel_tcc_set_offset(int cpu, int offset);
+int intel_tcc_get_temp(int cpu, bool pkg);
+
+#endif /* __INTEL_TCC_H__ */
-- 
2.25.1

