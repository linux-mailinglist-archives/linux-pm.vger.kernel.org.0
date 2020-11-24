Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DE2C2199
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgKXJgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731380AbgKXJgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:42 -0500
Date:   Tue, 24 Nov 2020 09:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJfL2LsYMscoYyCDv7WQ70nL6AqMd/1N2MMnjyZmeVM=;
        b=YljscaKpVtJEMycfRuYGt6QAVfbpLEn2t2ZwKASFVmWk9EpkIPXLcFGhqP9+IxMZsw6Ihs
        2tgqsgWVHOj9XrCVI35iqiR3Ra0SSZ/Jznk3m9Ug34zT/EX0J5wsFE1t2LqsNEzvnrMkL/
        H/wpiJWmokylCpedwidDrTRecCN2X7pq97eg8O/hr1OaApob9rU2wV+dskco7JJNJmH73w
        BN6nrb9hqtXT+wRd5/JRy4j672YdCOVUXW49e4aKDSjdMnBV3ZPVKitzEkfVkbrjUz+LLg
        M49kdpnBEdDIs+EFhBZr+8rvyXsryTQO+eTEj1VQFlE+OukRWb6+TkruDpUBdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJfL2LsYMscoYyCDv7WQ70nL6AqMd/1N2MMnjyZmeVM=;
        b=ITnu1sy4FDCUlIGQvPZT5/9tt8YJG8CBW9hdwnnLjIWdOAWrzimgg73WoJyDYgnus4fEZa
        ytj9zZtNZSu7GEBg==
From:   "thermal-bot for Sumeet Pawnikar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: pch: fix S0ix failure due to
 PCH temperature above threshold
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20201106170633.20838-1-sumeet.r.pawnikar@intel.com>
References: <20201106170633.20838-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Message-ID: <160621059919.11115.10218760882582089616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ef63b043ac8645d2540d7b50dd3e09c53db3d504
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ef63b043ac8645d2540d7b50dd3e09c53db3d504
Author:        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
AuthorDate:    Fri, 06 Nov 2020 22:36:33 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 07 Nov 2020 19:02:31 +01:00

thermal: intel: pch: fix S0ix failure due to PCH temperature above threshold

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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201106170633.20838-1-sumeet.r.pawnikar@intel.com
---
 drivers/thermal/intel/intel_pch_thermal.c | 76 ++++++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 3b813eb..0a9e445 100644
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
