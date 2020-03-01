Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAF174DB2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 15:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCAOhD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 09:37:03 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42626 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAOhD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Mar 2020 09:37:03 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E3A42200C18;
        Sun,  1 Mar 2020 15:37:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AB4B200B50;
        Sun,  1 Mar 2020 15:36:56 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 28FC6402D5;
        Sun,  1 Mar 2020 22:36:49 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx_thermal: Use __maybe_unused instead of CONFIG_PM_SLEEP
Date:   Sun,  1 Mar 2020 22:30:56 +0800
Message-Id: <1583073056-32297-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use __maybe_unused for power management related functions instead
of #if CONFIG_PM_SLEEP to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb6754a..e75dda5 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -878,8 +878,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int imx_thermal_suspend(struct device *dev)
+static int __maybe_unused imx_thermal_suspend(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	struct regmap *map = data->tempmon;
@@ -900,7 +899,7 @@ static int imx_thermal_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx_thermal_resume(struct device *dev)
+static int __maybe_unused imx_thermal_resume(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	struct regmap *map = data->tempmon;
@@ -918,7 +917,6 @@ static int imx_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
 			 imx_thermal_suspend, imx_thermal_resume);
-- 
2.7.4

