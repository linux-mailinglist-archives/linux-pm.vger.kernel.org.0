Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911692A9A69
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKFRGk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 12:06:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:42863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFRGk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Nov 2020 12:06:40 -0500
IronPort-SDR: PVCnqGXL3bWyj0dXupKEapOrQBuu4K5fb88r7C69g1PdQOl98AtAJdqSCGAEffJl4p9rPdk8uU
 trbWGI7CTbbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="169719679"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="169719679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 09:06:38 -0800
IronPort-SDR: aw961+66bp4xFmCt8iMoMDTNvQiEhOkBjn8RcoBRoaZjkge9GCNd0fKQF1LqRggHojrA4aOy8b
 VbcOyQaHuivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="337629876"
Received: from srpawnik.iind.intel.com ([10.223.107.18])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2020 09:06:36 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        andriy.shevchenko@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: intel: pch: fix S0ix failure due to PCH temperature above threshold
Date:   Fri,  6 Nov 2020 22:36:33 +0530
Message-Id: <20201106170633.20838-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When system tries to enter S0ix suspend state, just after active load
scenarios, it fails due to PCH current temperature is higher than set
threshold.
This patch introduces delay loop mechanism that allows PCH temperature
to go down below threshold during suspend so it won't fail to enter S0ix.
Add delay loop timeout and count as module parameters for user to tune it,
if required based on system design. This change notifies the different
warning messages like when PCH temperature above the threshold and
executing delay loop. Also, notify the messages when it success or
failure for S0ix entry.
Previously out of 1000 runs around 3 to 5 times it might fail to enter
S0ix just after heavy workload. With this change, S0ix failures reduced
as PCH cools down below threshold.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
Below are the different types of messages during various scenarios,
[1] PCH current temperature is higher than threshold and try to enter S0ix.
    Even after delay loop if current temperature stay higher than threshold
    temperature, notify the alert message that PCH still hot, S0ix might fail.

[  118.074398] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [54C] higher than the threshold temp [50C], sleep 1 times for 100 ms duration
[  118.175524] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [54C] higher than the threshold temp [50C], sleep 2 times for 100 ms duration
[  118.279798] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [54C] higher than the threshold temp [50C], sleep 3 times for 100 ms duration
[  118.383670] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [53C] higher than the threshold temp [50C], sleep 4 times for 100 ms duration
[  118.487799] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [53C] higher than the threshold temp [50C], sleep 5 times for 100 ms duration
[  118.591801] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [53C] higher than the threshold temp [50C], sleep 6 times for 100 ms duration
[  118.695804] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [53C] higher than the threshold temp [50C], sleep 7 times for 100 ms duration
[  118.799821] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [52C] higher than the threshold temp [50C], sleep 8 times for 100 ms duration
[  118.903801] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [52C] higher than the threshold temp [50C], sleep 9 times for 100 ms duration
[  119.007791] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [52C] higher than the threshold temp [50C], sleep 10 times for 100 ms duration
[  119.111791] intel_pch_thermal 0000:00:12.0: CPU-PCH is hot [52C] even after delay, continue to suspend. S0ix might fail

[2] PCH current temperature is higher than threshold and try to enter S0ix.
    After delay loop if current temperature goes below threshold temperature,
    notify the message that PCH is cool and continue to suspend.

[  180.272473] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [52C] higher than the threshold temp=50, sleep 1 times for 100 ms duration
[  180.377927] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [51C] higher than the threshold temp=50, sleep 2 times for 100 ms duration
[  180.481919] intel_pch_thermal 0000:00:12.0: CPU-PCH current temp [51C] higher than the threshold temp=50, sleep 3 times for 100 ms duration
[  180.585930] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [50C], continue
to suspend
---
 drivers/thermal/intel/intel_pch_thermal.c | 76 +++++++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 3b813ebb6ca1..0a9e4458bc3a 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -7,14 +7,16 @@
  *     Tushar Dave <tushar.n.dave@intel.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/module.h>
-#include <linux/types.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/acpi.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/thermal.h>
+#include <linux/types.h>
 #include <linux/units.h>
-#include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
 #define PCH_THERMAL_DID_HSW_1	0x9C24 /* Haswell PCH */
@@ -35,6 +37,7 @@
 #define WPT_TSREL	0x0A	/* Thermal Sensor Report Enable and Lock */
 #define WPT_TSMIC	0x0C	/* Thermal Sensor SMI Control */
 #define WPT_CTT	0x0010	/* Catastrophic Trip Point */
+#define WPT_TSPM	0x001C	/* Thermal Sensor Power Management */
 #define WPT_TAHV	0x0014	/* Thermal Alert High Value */
 #define WPT_TALV	0x0018	/* Thermal Alert Low Value */
 #define WPT_TL		0x00000040	/* Throttle Value */
@@ -55,6 +58,22 @@
 #define WPT_TL_T1L	0x1ff00000	/* T1 Level */
 #define WPT_TL_TTEN	0x20000000	/* TT Enable */
 
+/* Resolution of 1/2 degree C and an offset of -50C */
+#define PCH_TEMP_OFFSET	(-50)
+#define GET_WPT_TEMP(x)	((x) * MILLIDEGREE_PER_DEGREE / 2 + WPT_TEMP_OFFSET)
+#define WPT_TEMP_OFFSET	(PCH_TEMP_OFFSET * MILLIDEGREE_PER_DEGREE)
+#define GET_PCH_TEMP(x)	(((x) / 2) + PCH_TEMP_OFFSET)
+
+/* Amount of time for each cooling delay, 100ms by default for now */
+static unsigned int delay_timeout = 100;
+module_param(delay_timeout, int, 0644);
+MODULE_PARM_DESC(delay_timeout, "amount of time delay for each iteration.");
+
+/* Number of iterations for cooling delay, 10 counts by default for now */
+static unsigned int delay_cnt = 10;
+module_param(delay_cnt, int, 0644);
+MODULE_PARM_DESC(delay_cnt, "total number of iterations for time delay.");
+
 static char driver_name[] = "Intel PCH thermal driver";
 
 struct pch_thermal_device {
@@ -183,13 +202,58 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
+	u8 pch_delay_cnt = 1;
+	u16 pch_thr_temp, pch_cur_temp;
 
-	if (ptd->bios_enabled)
+	/* Shutdown the thermal sensor if it is not enabled by BIOS */
+	if (!ptd->bios_enabled) {
+		tsel = readb(ptd->hw_base + WPT_TSEL);
+		writeb(tsel & 0xFE, ptd->hw_base + WPT_TSEL);
+		return 0;
+	}
+
+	/* Do not check temperature if it is not a S0ix capable platform */
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		return 0;
 
-	tsel = readb(ptd->hw_base + WPT_TSEL);
+	/* Do not check temperature if it is not s2idle */
+	if (pm_suspend_via_firmware())
+		return 0;
+
+	/* Get the PCH temperature threshold value */
+	pch_thr_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TSPM));
+
+	/* Get the PCH current temperature value */
+	pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 
-	writeb(tsel & 0xFE, ptd->hw_base + WPT_TSEL);
+	/*
+	 * If current PCH temperature is higher than configured PCH threshold
+	 * value, run some delay loop with sleep to let the current temperature
+	 * go down below the threshold value which helps to allow system enter
+	 * lower power S0ix suspend state. Even after delay loop if PCH current
+	 * temperature stays above threshold, notify the warning message
+	 * which helps to indentify the reason why S0ix entry was rejected.
+	 */
+	while (pch_delay_cnt <= delay_cnt) {
+		if (pch_cur_temp <= pch_thr_temp)
+			break;
+
+		dev_warn(&ptd->pdev->dev,
+			"CPU-PCH current temp [%dC] higher than the threshold temp [%dC], sleep %d times for %d ms duration\n",
+			pch_cur_temp, pch_thr_temp, pch_delay_cnt, delay_timeout);
+		msleep(delay_timeout);
+		/* Read the PCH current temperature for next cycle. */
+		pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
+		pch_delay_cnt++;
+	}
+
+	if (pch_cur_temp > pch_thr_temp)
+		dev_warn(&ptd->pdev->dev,
+			"CPU-PCH is hot [%dC] even after delay, continue to suspend. S0ix might fail\n",
+			pch_cur_temp);
+	else
+		dev_info(&ptd->pdev->dev,
+			"CPU-PCH is cool [%dC], continue to suspend\n", pch_cur_temp);
 
 	return 0;
 }
-- 
2.17.1

