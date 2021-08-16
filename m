Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2B3ECD5D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhHPDyc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Aug 2021 23:54:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:55425 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhHPDyb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Aug 2021 23:54:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="215788527"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="215788527"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 20:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="530165161"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2021 20:53:59 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, hdegoede@redhat.com,
        daniel.lezcano@linaro.org, hpa@redhat.com, mgross@linux.intel.com,
        alex.hung@canonical.com, sujith.thomas@intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal/drivers/intel: Move intel_menlow to thermal drivers
Date:   Sun, 15 Aug 2021 20:53:56 -0700
Message-Id: <20210816035356.1955982-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Moved drivers/platform/x86/intel_menlow.c to drivers/thermal/intel.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS                                            |  4 ++--
 drivers/platform/x86/Kconfig                           | 10 ----------
 drivers/platform/x86/Makefile                          |  1 -
 drivers/thermal/intel/Kconfig                          |  9 +++++++++
 drivers/thermal/intel/Makefile                         |  1 +
 drivers/{platform/x86 => thermal/intel}/intel_menlow.c |  0
 6 files changed, 12 insertions(+), 13 deletions(-)
 rename drivers/{platform/x86 => thermal/intel}/intel_menlow.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd25e4ecf0b9..4231aea31a6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9459,10 +9459,10 @@ F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
-L:	platform-driver-x86@vger.kernel.org
+L:	linux-pm@vger.kernel.org
 S:	Supported
 W:	https://01.org/linux-acpi
-F:	drivers/platform/x86/intel_menlow.c
+F:	drivers/thermal/intel/intel_menlow.c
 
 INTEL P-Unit IPC DRIVER
 M:	Zha Qipeng <qipeng.zha@intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index d12db6c316ea..da312426b4a5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -720,16 +720,6 @@ config INTEL_INT0002_VGPIO
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_int0002_vgpio.
 
-config INTEL_MENLOW
-	tristate "Thermal Management driver for Intel menlow platform"
-	depends on ACPI_THERMAL
-	select THERMAL
-	help
-	  ACPI thermal management enhancement driver on
-	  Intel Menlow platform.
-
-	  If unsure, say N.
-
 config INTEL_OAKTRAIL
 	tristate "Intel Oaktrail Platform Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 7ee369aab10d..0d3af23f1186 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -72,7 +72,6 @@ obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
-obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index e4299ca3423c..c83ea5d04a1d 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -90,3 +90,12 @@ config INTEL_TCC_COOLING
 	  Note that, on different platforms, the behavior might be different
 	  on how fast the setting takes effect, and how much the CPU frequency
 	  is reduced.
+
+config INTEL_MENLOW
+	tristate "Thermal Management driver for Intel menlow platform"
+	depends on ACPI_THERMAL
+	help
+	  ACPI thermal management enhancement driver on
+	  Intel Menlow platform.
+
+	  If unsure, say N.
diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
index 5ff2afa388f7..960b56268b4a 100644
--- a/drivers/thermal/intel/Makefile
+++ b/drivers/thermal/intel/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
 obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
+obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
similarity index 100%
rename from drivers/platform/x86/intel_menlow.c
rename to drivers/thermal/intel/intel_menlow.c
-- 
2.31.1

