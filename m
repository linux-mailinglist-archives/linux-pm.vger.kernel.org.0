Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2431BD2B5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgD2C60 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 22:58:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32902 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgD2C60 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 22:58:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECFD31A021F;
        Wed, 29 Apr 2020 04:58:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 616281A01F8;
        Wed, 29 Apr 2020 04:58:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 419B74032C;
        Wed, 29 Apr 2020 10:58:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3] thermal: imx: Add missing of_node_put()
Date:   Wed, 29 Apr 2020 10:49:30 +0800
Message-Id: <1588128570-12917-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After finishing using cpu node got from of_get_cpu_node(), of_node_put()
needs to be called, the cpufreq policy also needs to be put unconditionally.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- call cpufreq_cpu_put() unconditionally after cooling register done.
---
 drivers/thermal/imx_thermal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index e761c9b..8764cb5 100644
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
@@ -661,20 +661,19 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 
 	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
 		data->cdev = cpufreq_cooling_register(data->policy);
-		if (IS_ERR(data->cdev)) {
+		if (IS_ERR(data->cdev))
 			ret = PTR_ERR(data->cdev);
-			cpufreq_cpu_put(data->policy);
-			return ret;
-		}
 	}
 
-	return 0;
+	cpufreq_cpu_put(data->policy);
+	of_node_put(np);
+
+	return ret;
 }
 
 static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
 {
 	cpufreq_cooling_unregister(data->cdev);
-	cpufreq_cpu_put(data->policy);
 }
 
 #else
-- 
2.7.4

