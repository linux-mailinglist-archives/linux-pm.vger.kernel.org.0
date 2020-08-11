Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAA2416D9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHKHEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 03:04:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41798 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgHKHEo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 03:04:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CCDE1A1E73;
        Tue, 11 Aug 2020 09:04:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B1DC91A1E6D;
        Tue, 11 Aug 2020 09:04:38 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E4A8240243;
        Tue, 11 Aug 2020 09:04:32 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] thermal: imx: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 14:59:44 +0800
Message-Id: <1597129185-8460-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	- remove redundant return value print.
---
 drivers/thermal/imx_thermal.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 3f74ab4..2c7473d 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -716,14 +716,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
 		ret = imx_init_from_nvmem_cells(pdev);
-		if (ret) {
-			if (ret == -EPROBE_DEFER)
-				return ret;
-
-			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
-				ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to init from nvmem\n");
 	} else {
 		ret = imx_init_from_tempmon_data(pdev);
 		if (ret) {
@@ -746,14 +741,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		     data->socdata->power_down_mask);
 
 	ret = imx_thermal_register_legacy_cooling(data);
-	if (ret) {
-		if (ret == -EPROBE_DEFER)
-			return ret;
-
-		dev_err(&pdev->dev,
-			"failed to register cpufreq cooling device: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register cpufreq cooling device\n");
 
 	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
-- 
2.7.4

