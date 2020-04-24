Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE211B6B74
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 04:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDXCiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 22:38:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47850 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgDXCiy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 22:38:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3543200214;
        Fri, 24 Apr 2020 04:38:52 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A174C2001F8;
        Fri, 24 Apr 2020 04:38:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 107D1402C7;
        Fri, 24 Apr 2020 10:38:38 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, linux@rempel-privat.de, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4] dt-bindings: firmware: imx: Move system control into dt-binding headfile
Date:   Fri, 24 Apr 2020 10:30:15 +0800
Message-Id: <1587695415-4441-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

i.MX8 SoCs DTS file needs system control macro definitions, so move them
into dt-binding headfile, then include/linux/firmware/imx/types.h can be
removed and those drivers using it should be changed accordingly.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- no code change, ONLY add the missing author's signed-off.
---
 drivers/firmware/imx/imx-scu.c          |  1 -
 drivers/thermal/imx_sc_thermal.c        |  2 +-
 include/dt-bindings/firmware/imx/rsrc.h | 84 +++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sci.h        |  1 -
 include/linux/firmware/imx/types.h      | 65 -------------------------
 5 files changed, 85 insertions(+), 68 deletions(-)
 delete mode 100644 include/linux/firmware/imx/types.h

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index f71eaa5..f3340fa 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/firmware/imx/types.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index b2b68c9..b01d28e 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -3,9 +3,9 @@
  * Copyright 2018-2020 NXP.
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/sci.h>
-#include <linux/firmware/imx/types.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 4e61f64..51906b9 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -547,4 +547,88 @@
 #define IMX_SC_R_ATTESTATION		545
 #define IMX_SC_R_LAST			546
 
+/*
+ * Defines for SC PM CLK
+ */
+#define IMX_SC_PM_CLK_SLV_BUS		0	/* Slave bus clock */
+#define IMX_SC_PM_CLK_MST_BUS		1	/* Master bus clock */
+#define IMX_SC_PM_CLK_PER		2	/* Peripheral clock */
+#define IMX_SC_PM_CLK_PHY		3	/* Phy clock */
+#define IMX_SC_PM_CLK_MISC		4	/* Misc clock */
+#define IMX_SC_PM_CLK_MISC0		0	/* Misc 0 clock */
+#define IMX_SC_PM_CLK_MISC1		1	/* Misc 1 clock */
+#define IMX_SC_PM_CLK_MISC2		2	/* Misc 2 clock */
+#define IMX_SC_PM_CLK_MISC3		3	/* Misc 3 clock */
+#define IMX_SC_PM_CLK_MISC4		4	/* Misc 4 clock */
+#define IMX_SC_PM_CLK_CPU		2	/* CPU clock */
+#define IMX_SC_PM_CLK_PLL		4	/* PLL */
+#define IMX_SC_PM_CLK_BYPASS		4	/* Bypass clock */
+
+/*
+ * Defines for SC CONTROL
+ */
+#define IMX_SC_C_TEMP                       0U
+#define IMX_SC_C_TEMP_HI                    1U
+#define IMX_SC_C_TEMP_LOW                   2U
+#define IMX_SC_C_PXL_LINK_MST1_ADDR         3U
+#define IMX_SC_C_PXL_LINK_MST2_ADDR         4U
+#define IMX_SC_C_PXL_LINK_MST_ENB           5U
+#define IMX_SC_C_PXL_LINK_MST1_ENB          6U
+#define IMX_SC_C_PXL_LINK_MST2_ENB          7U
+#define IMX_SC_C_PXL_LINK_SLV1_ADDR         8U
+#define IMX_SC_C_PXL_LINK_SLV2_ADDR         9U
+#define IMX_SC_C_PXL_LINK_MST_VLD           10U
+#define IMX_SC_C_PXL_LINK_MST1_VLD          11U
+#define IMX_SC_C_PXL_LINK_MST2_VLD          12U
+#define IMX_SC_C_SINGLE_MODE                13U
+#define IMX_SC_C_ID                         14U
+#define IMX_SC_C_PXL_CLK_POLARITY           15U
+#define IMX_SC_C_LINESTATE                  16U
+#define IMX_SC_C_PCIE_G_RST                 17U
+#define IMX_SC_C_PCIE_BUTTON_RST            18U
+#define IMX_SC_C_PCIE_PERST                 19U
+#define IMX_SC_C_PHY_RESET                  20U
+#define IMX_SC_C_PXL_LINK_RATE_CORRECTION   21U
+#define IMX_SC_C_PANIC                      22U
+#define IMX_SC_C_PRIORITY_GROUP             23U
+#define IMX_SC_C_TXCLK                      24U
+#define IMX_SC_C_CLKDIV                     25U
+#define IMX_SC_C_DISABLE_50                 26U
+#define IMX_SC_C_DISABLE_125                27U
+#define IMX_SC_C_SEL_125                    28U
+#define IMX_SC_C_MODE                       29U
+#define IMX_SC_C_SYNC_CTRL0                 30U
+#define IMX_SC_C_KACHUNK_CNT                31U
+#define IMX_SC_C_KACHUNK_SEL                32U
+#define IMX_SC_C_SYNC_CTRL1                 33U
+#define IMX_SC_C_DPI_RESET                  34U
+#define IMX_SC_C_MIPI_RESET                 35U
+#define IMX_SC_C_DUAL_MODE                  36U
+#define IMX_SC_C_VOLTAGE                    37U
+#define IMX_SC_C_PXL_LINK_SEL               38U
+#define IMX_SC_C_OFS_SEL                    39U
+#define IMX_SC_C_OFS_AUDIO                  40U
+#define IMX_SC_C_OFS_PERIPH                 41U
+#define IMX_SC_C_OFS_IRQ                    42U
+#define IMX_SC_C_RST0                       43U
+#define IMX_SC_C_RST1                       44U
+#define IMX_SC_C_SEL0                       45U
+#define IMX_SC_C_CALIB0                     46U
+#define IMX_SC_C_CALIB1                     47U
+#define IMX_SC_C_CALIB2                     48U
+#define IMX_SC_C_IPG_DEBUG                  49U
+#define IMX_SC_C_IPG_DOZE                   50U
+#define IMX_SC_C_IPG_WAIT                   51U
+#define IMX_SC_C_IPG_STOP                   52U
+#define IMX_SC_C_IPG_STOP_MODE              53U
+#define IMX_SC_C_IPG_STOP_ACK               54U
+#define IMX_SC_C_SYNC_CTRL                  55U
+#define IMX_SC_C_OFS_AUDIO_ALT              56U
+#define IMX_SC_C_DSP_BYP                    57U
+#define IMX_SC_C_CLK_GEN_EN                 58U
+#define IMX_SC_C_INTF_SEL                   59U
+#define IMX_SC_C_RXC_DLY                    60U
+#define IMX_SC_C_TIMER_SEL                  61U
+#define IMX_SC_C_LAST                       62U
+
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 17ba4e4..3fa418a 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -11,7 +11,6 @@
 #define _SC_SCI_H
 
 #include <linux/firmware/imx/ipc.h>
-#include <linux/firmware/imx/types.h>
 
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
diff --git a/include/linux/firmware/imx/types.h b/include/linux/firmware/imx/types.h
deleted file mode 100644
index 8082110..0000000
--- a/include/linux/firmware/imx/types.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017~2018 NXP
- *
- * Header file containing types used across multiple service APIs.
- */
-
-#ifndef _SC_TYPES_H
-#define _SC_TYPES_H
-
-/*
- * This type is used to indicate a control.
- */
-enum imx_sc_ctrl {
-	IMX_SC_C_TEMP = 0,
-	IMX_SC_C_TEMP_HI = 1,
-	IMX_SC_C_TEMP_LOW = 2,
-	IMX_SC_C_PXL_LINK_MST1_ADDR = 3,
-	IMX_SC_C_PXL_LINK_MST2_ADDR = 4,
-	IMX_SC_C_PXL_LINK_MST_ENB = 5,
-	IMX_SC_C_PXL_LINK_MST1_ENB = 6,
-	IMX_SC_C_PXL_LINK_MST2_ENB = 7,
-	IMX_SC_C_PXL_LINK_SLV1_ADDR = 8,
-	IMX_SC_C_PXL_LINK_SLV2_ADDR = 9,
-	IMX_SC_C_PXL_LINK_MST_VLD = 10,
-	IMX_SC_C_PXL_LINK_MST1_VLD = 11,
-	IMX_SC_C_PXL_LINK_MST2_VLD = 12,
-	IMX_SC_C_SINGLE_MODE = 13,
-	IMX_SC_C_ID = 14,
-	IMX_SC_C_PXL_CLK_POLARITY = 15,
-	IMX_SC_C_LINESTATE = 16,
-	IMX_SC_C_PCIE_G_RST = 17,
-	IMX_SC_C_PCIE_BUTTON_RST = 18,
-	IMX_SC_C_PCIE_PERST = 19,
-	IMX_SC_C_PHY_RESET = 20,
-	IMX_SC_C_PXL_LINK_RATE_CORRECTION = 21,
-	IMX_SC_C_PANIC = 22,
-	IMX_SC_C_PRIORITY_GROUP = 23,
-	IMX_SC_C_TXCLK = 24,
-	IMX_SC_C_CLKDIV = 25,
-	IMX_SC_C_DISABLE_50 = 26,
-	IMX_SC_C_DISABLE_125 = 27,
-	IMX_SC_C_SEL_125 = 28,
-	IMX_SC_C_MODE = 29,
-	IMX_SC_C_SYNC_CTRL0 = 30,
-	IMX_SC_C_KACHUNK_CNT = 31,
-	IMX_SC_C_KACHUNK_SEL = 32,
-	IMX_SC_C_SYNC_CTRL1 = 33,
-	IMX_SC_C_DPI_RESET = 34,
-	IMX_SC_C_MIPI_RESET = 35,
-	IMX_SC_C_DUAL_MODE = 36,
-	IMX_SC_C_VOLTAGE = 37,
-	IMX_SC_C_PXL_LINK_SEL = 38,
-	IMX_SC_C_OFS_SEL = 39,
-	IMX_SC_C_OFS_AUDIO = 40,
-	IMX_SC_C_OFS_PERIPH = 41,
-	IMX_SC_C_OFS_IRQ = 42,
-	IMX_SC_C_RST0 = 43,
-	IMX_SC_C_RST1 = 44,
-	IMX_SC_C_SEL0 = 45,
-	IMX_SC_C_LAST
-};
-
-#endif /* _SC_TYPES_H */
-- 
2.7.4

