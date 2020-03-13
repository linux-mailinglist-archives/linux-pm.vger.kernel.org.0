Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68C1184566
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCMLBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 07:01:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49253 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMLBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 07:01:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jCi4T-00023f-3E; Fri, 13 Mar 2020 12:01:41 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH resend] thermal: imx: register as OF sensor
Date:   Fri, 13 Mar 2020 12:01:39 +0100
Message-Id: <20200313110139.28558-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To make the internal sensor usable with a thermal zone description
provided via DT, also register out device as a OF sensor.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/thermal/imx_thermal.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb6754a5342c..714be941fe6c 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -202,7 +202,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
 
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
-	struct thermal_zone_device *tz;
+	struct thermal_zone_device *tz, *sensor;
 	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
@@ -338,6 +338,13 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int imx_of_sensor_get_temp(void *data, int *temp)
+{
+	struct imx_thermal_data *thermal_data = data;
+
+	return imx_get_temp(thermal_data->tz, temp);
+}
+
 static int imx_get_mode(struct thermal_zone_device *tz,
 			enum thermal_device_mode *mode)
 {
@@ -482,6 +489,10 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 	.set_trip_temp = imx_set_trip_temp,
 };
 
+static const struct thermal_zone_of_device_ops imx_tz_of_ops = {
+	.get_temp = imx_of_sensor_get_temp,
+};
+
 static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
@@ -816,6 +827,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	data->sensor = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
+						       &imx_tz_of_ops);
+
 	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
 		 " critical:%dC passive:%dC\n", data->temp_grade,
 		 data->temp_max / 1000, data->temp_critical / 1000,
@@ -871,6 +885,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	if (!IS_ERR(data->thermal_clk))
 		clk_disable_unprepare(data->thermal_clk);
 
+	thermal_zone_of_sensor_unregister(&pdev->dev, data->sensor);
 	thermal_zone_device_unregister(data->tz);
 	cpufreq_cooling_unregister(data->cdev);
 	cpufreq_cpu_put(data->policy);
-- 
2.20.1

