Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CADFF85
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfJVIgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 04:36:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54164 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfJVIgV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 04:36:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ECE052000C7;
        Tue, 22 Oct 2019 10:36:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B5A0200601;
        Tue, 22 Oct 2019 10:36:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 90A00402CB;
        Tue, 22 Oct 2019 16:36:08 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed grade value
Date:   Tue, 22 Oct 2019 16:33:19 +0800
Message-Id: <1571733199-17406-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8MN has different speed grade definition compared to
i.MX8MQ/i.MX8MM, when fuses are NOT written, the default
speed_grade should be set to minimum available OPP defined
in DT which is 1.2GHz, the corresponding speed_grade value
should be 0xb.

Fixes: 5b8010ba70d5 ("cpufreq: imx-cpufreq-dt: Add i.MX8MN support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Improve the coding style by removing the tab;
---
 drivers/cpufreq/imx-cpufreq-dt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 35db14c..85a6efd 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -44,19 +44,19 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
 
 	/*
-	 * Early samples without fuses written report "0 0" which means
-	 * consumer segment and minimum speed grading.
-	 *
-	 * According to datasheet minimum speed grading is not supported for
-	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
+	 * Early samples without fuses written report "0 0" which may NOT
+	 * match any OPP defined in DT. So clamp to minimum OPP defined in
+	 * DT to avoid warning for "no OPPs".
 	 *
 	 * Applies to i.MX8M series SoCs.
 	 */
-	if (mkt_segment == 0 && speed_grade == 0 && (
-			of_machine_is_compatible("fsl,imx8mm") ||
-			of_machine_is_compatible("fsl,imx8mn") ||
-			of_machine_is_compatible("fsl,imx8mq")))
-		speed_grade = 1;
+	if (mkt_segment == 0 && speed_grade == 0) {
+		if (of_machine_is_compatible("fsl,imx8mm") ||
+		    of_machine_is_compatible("fsl,imx8mq"))
+			speed_grade = 1;
+		if (of_machine_is_compatible("fsl,imx8mn"))
+			speed_grade = 0xb;
+	}
 
 	supported_hw[0] = BIT(speed_grade);
 	supported_hw[1] = BIT(mkt_segment);
-- 
2.7.4

