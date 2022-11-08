Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDE620768
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiKHDbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKHDbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC92F38A
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878281; x=1699414281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=m1mveA+UN7i4ZII/zbafiFNqxU35dkL4cX1iih/BCSA=;
  b=Q8oAEfaU64bOUxX6ysjZPEea+hnWTVrrndN7vgEZu8tB+0eplG4vFNbM
   VSqomC4YbTWgXkZA6S3IkrTGGYeIUd7fRmKrFr/dFAN/mwkjbFgkpMbXt
   TqEAuP9Bnx2/LwieVnsaP0uYMHiUoUuXXdYNQuVIOI/Y+u/pZRbhpWDtZ
   D/MK3lu+rvAwHneRLX1vMy2WVeh069dDRHhrLR/DrU927nCmloH2lvjNG
   zzj5jgK4qUQOfa3SgodOA4dVF6vlawkA8BzlvQIIU4EzS4lA2+3o5boa9
   JJT6KzknkWextlqhiR+NStTtTHarKPAeBsa1fz7c4839zCd0VpIlcLHfM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732523"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732523"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120227"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120227"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:19 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
Date:   Tue,  8 Nov 2022 11:33:27 +0800
Message-Id: <20221108033332.27760-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108033332.27760-1-rui.zhang@intel.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/intel/intel_tcc.c | 131 ++++++++++++++++++++++++++++++
 include/linux/intel_tcc.h         |  18 ++++
 4 files changed, 154 insertions(+)
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
index 000000000000..74b434914975
--- /dev/null
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -0,0 +1,131 @@
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
+ * @cpu: cpu that the MSR should be run on.
+ * @tjmax: a valid pointer to where to store the Tjmax value
+ *
+ * Get the TjMax value, which is the default thermal throttling or TCC
+ * activation temperature in degrees C.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
+
+int intel_tcc_get_tjmax(int cpu, int *tjmax)
+{
+	u32 eax, edx;
+	int err;
+
+	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
+					&eax, &edx);
+	if (err)
+		return err;
+
+	*tjmax = (eax >> 16) & 0xff;
+
+	return *tjmax ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, INTEL_TCC);
+
+/**
+ * intel_tcc_get_offset() - returns the TCC Offset value to Tjmax
+ * @cpu: cpu that the MSR should be run on.
+ * @offset: a valid pointer to where to store the offset value
+ *
+ * Get the TCC offset value to Tjmax. The effective thermal throttling or TCC
+ * activation temperature equals "Tjmax" - "TCC Offset", in degrees C.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
+
+int intel_tcc_get_offset(int cpu, int *offset)
+{
+	u32 eax, edx;
+	int err;
+
+	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
+					&eax, &edx);
+	if (err)
+		return err;
+
+	*offset = (eax >> 24) & 0x3f;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
+
+/**
+ * intel_tcc_set_offset() - set the TCC offset value to Tjmax
+ * @cpu: cpu that the MSR should be run on.
+ * @offset: TCC offset value in degree C
+ *
+ * Set the TCC Offset value to Tjmax. The effective thermal throttling or TCC
+ * activation temperature equals "Tjmax" - "TCC Offset", in degree C.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
+
+int intel_tcc_set_offset(int cpu, int offset)
+{
+	u32 eax, edx;
+	int err;
+
+	if (offset > 0x3f)
+		return -EINVAL;
+
+	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
+					&eax, &edx);
+	if (err)
+		return err;
+
+	if (eax & BIT(31))
+		return -EPERM;
+
+	eax &= ~(0x3f << 24);
+	eax |= (offset << 24);
+
+	return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, eax, edx);
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
+
+/**
+ * intel_tcc_get_temp() - returns the current temperature
+ * @cpu: cpu that the MSR should be run on.
+ * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
+ * @temp: a valid pointer to where to store the resulting temperature
+ *
+ * Get the current temperature returned by the CPU core/package level
+ * thermal sensor, in degrees C.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
+int intel_tcc_get_temp(int cpu, bool pkg, int *temp)
+{
+	u32 eax, edx;
+	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
+	int tjmax, err;
+
+	err = intel_tcc_get_tjmax(cpu, &tjmax);
+	if (err)
+		return err;
+
+	err = rdmsr_safe_on_cpu(cpu, msr, &eax, &edx);
+	if (err)
+		return err;
+
+	if (eax & 0x80000000) {
+		*temp = tjmax - ((eax >> 16) & 0x7f);
+		return 0;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
+
diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
new file mode 100644
index 000000000000..94f8ceab5dd0
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
+int intel_tcc_get_tjmax(int cpu, int *tjmax);
+int intel_tcc_get_offset(int cpu, int *offset);
+int intel_tcc_set_offset(int cpu, int offset);
+int intel_tcc_get_temp(int cpu, bool pkg, int *temp);
+
+#endif /* __INTEL_TCC_H__ */
-- 
2.25.1

