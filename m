Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28461937E0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 06:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgCZFeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 01:34:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45978 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgCZFeo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 01:34:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 328CE1A0809;
        Thu, 26 Mar 2020 06:34:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76FA41A0813;
        Thu, 26 Mar 2020 06:34:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4451A40294;
        Thu, 26 Mar 2020 13:34:27 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx: Add missing of_node_put()
Date:   Thu, 26 Mar 2020 13:27:25 +0800
Message-Id: <1585200445-16461-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After finishing using cpu node got from of_get_cpu_node(), of_node_put()
needs to be called.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index e761c9b..f7b970d 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -649,7 +649,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 {
 	struct device_node *np;
-	int ret;
+	int ret = 0;
 
 	data->policy = cpufreq_cpu_get(0);
 	if (!data->policy) {
@@ -664,11 +664,15 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 		if (IS_ERR(data->cdev)) {
 			ret = PTR_ERR(data->cdev);
 			cpufreq_cpu_put(data->policy);
-			return ret;
+			goto put_node;
 		}
 	}
 
-	return 0;
+put_node:
+	if (np)
+		of_node_put(np);
+
+	return ret;
 }
 
 static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
-- 
2.7.4

