Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA45295749
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 06:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgJVEaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 00:30:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56256 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbgJVEaK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 00:30:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE722201849;
        Thu, 22 Oct 2020 06:30:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C12F200CA1;
        Thu, 22 Oct 2020 06:30:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9DFF4402DD;
        Thu, 22 Oct 2020 06:29:58 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx: Do NOT return -EPROBE_DEFER when "#cooling-cells" is present
Date:   Thu, 22 Oct 2020 12:24:54 +0800
Message-Id: <1603340694-29826-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The legacy CPU cooling should ONLY be used when "#cooling-cells" is NOT
present in cpu node, current implementation for registering legacy cooling
always return -EPROBE_DEFER when cpufreq is NOT ready, that will cause
thermal driver probe failed when cpufreq failed to probe with a non
-EPROBE_DEFER reason. In such case, thermal driver should continue probe
and provide temperature monitor and other cooling methods.

So, for the case of "#cooling-cells" present in cpu node, no need to
return -EPROBE_DEFER even cpufreq is NOT ready, this is to make sure
thermal driver can continue probe.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 9f00182..df60dcb 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -630,17 +630,29 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 {
 	struct device_node *np;
+	struct device *cpu_dev;
 	int ret = 0;
 
-	data->policy = cpufreq_cpu_get(0);
-	if (!data->policy) {
-		pr_debug("%s: CPUFreq policy not found\n", __func__);
-		return -EPROBE_DEFER;
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("imx thermal: failed to get cpu0 device\n");
+		return -ENODEV;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_err("imx thermal: failed to find cpu0 node\n");
+		return -ENOENT;
 	}
 
-	np = of_get_cpu_node(data->policy->cpu, NULL);
+	if (!of_find_property(np, "#cooling-cells", NULL)) {
+		data->policy = cpufreq_cpu_get(0);
+		if (!data->policy) {
+			pr_debug("%s: CPUFreq policy not found\n", __func__);
+			ret = -EPROBE_DEFER;
+			goto put_node;
+		}
 
-	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
 		data->cdev = cpufreq_cooling_register(data->policy);
 		if (IS_ERR(data->cdev)) {
 			ret = PTR_ERR(data->cdev);
@@ -648,6 +660,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 		}
 	}
 
+put_node:
 	of_node_put(np);
 
 	return ret;
-- 
2.7.4

