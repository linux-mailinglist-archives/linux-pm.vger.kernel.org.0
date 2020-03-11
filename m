Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25D180F90
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 06:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCKFOC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 01:14:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33872 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgCKFOC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 01:14:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C858A1A08C2;
        Wed, 11 Mar 2020 06:13:59 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BBFD1A064A;
        Wed, 11 Mar 2020 06:13:56 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D851D4024E;
        Wed, 11 Mar 2020 13:13:51 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to handle all cleanups
Date:   Wed, 11 Mar 2020 13:07:31 +0800
Message-Id: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_add_action_or_reset() to handle all cleanups of failure in
.probe and .remove, then .remove callback can be dropped.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 874bc46..67a8d84 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -228,6 +228,14 @@ static const struct regmap_access_table qoriq_rd_table = {
 	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges),
 };
 
+static void qoriq_tmu_action(void *p)
+{
+	struct qoriq_tmu_data *data = p;
+
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
+	clk_disable_unprepare(data->clk);
+}
+
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -278,6 +286,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
+	if (ret)
+		return ret;
+
 	/* version register offset at: 0xbf8 on both v1 and v2 */
 	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
 	if (ret) {
@@ -290,35 +302,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
-		ret = -ENODEV;
-		goto err;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, data);
 
 	return 0;
-
-err:
-	clk_disable_unprepare(data->clk);
-
-	return ret;
-}
-
-static int qoriq_tmu_remove(struct platform_device *pdev)
-{
-	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
-
-	/* Disable monitoring */
-	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
-
-	clk_disable_unprepare(data->clk);
-
-	return 0;
 }
 
 static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
@@ -365,7 +359,6 @@ static struct platform_driver qoriq_tmu = {
 		.of_match_table	= qoriq_tmu_match,
 	},
 	.probe	= qoriq_tmu_probe,
-	.remove	= qoriq_tmu_remove,
 };
 module_platform_driver(qoriq_tmu);
 
-- 
2.7.4

