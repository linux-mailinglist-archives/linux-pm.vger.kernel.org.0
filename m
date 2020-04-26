Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838C81B8DDA
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDZIUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 04:20:34 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42210 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgDZIUc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Apr 2020 04:20:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A881200BB8;
        Sun, 26 Apr 2020 10:20:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 802C8200BA2;
        Sun, 26 Apr 2020 10:20:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 258AD402E6;
        Sun, 26 Apr 2020 16:20:17 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, linux@rempel-privat.de, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 2/2] dt-bindings: firmware: imx: Add more system controls and PM clock types
Date:   Sun, 26 Apr 2020 16:11:44 +0800
Message-Id: <1587888704-7158-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
References: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add more system controls and PM clock types for usage.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch.
---
 include/dt-bindings/firmware/imx/rsrc.h | 35 ++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index cdcda00..54278d5 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -548,6 +548,23 @@
 #define IMX_SC_R_LAST			546
 
 /*
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
  * Defines for SC CONTROL
  */
 #define IMX_SC_C_TEMP				0
@@ -596,6 +613,22 @@
 #define IMX_SC_C_RST0				43
 #define IMX_SC_C_RST1				44
 #define IMX_SC_C_SEL0				45
-#define IMX_SC_C_LAST				46
+#define IMX_SC_C_CALIB0				46
+#define IMX_SC_C_CALIB1				47
+#define IMX_SC_C_CALIB2				48
+#define IMX_SC_C_IPG_DEBUG			49
+#define IMX_SC_C_IPG_DOZE			50
+#define IMX_SC_C_IPG_WAIT			51
+#define IMX_SC_C_IPG_STOP			52
+#define IMX_SC_C_IPG_STOP_MODE			53
+#define IMX_SC_C_IPG_STOP_ACK			54
+#define IMX_SC_C_SYNC_CTRL			55
+#define IMX_SC_C_OFS_AUDIO_ALT			56
+#define IMX_SC_C_DSP_BYP			57
+#define IMX_SC_C_CLK_GEN_EN			58
+#define IMX_SC_C_INTF_SEL			59
+#define IMX_SC_C_RXC_DLY			60
+#define IMX_SC_C_TIMER_SEL			61
+#define IMX_SC_C_LAST				62
 
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
-- 
2.7.4

