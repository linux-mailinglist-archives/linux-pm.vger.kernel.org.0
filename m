Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08032BD8F
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfE1DP3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 23:15:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56824 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfE1DP2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 May 2019 23:15:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E8DAC1A020A;
        Tue, 28 May 2019 05:15:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 724921A01F7;
        Tue, 28 May 2019 05:15:13 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A4FE6402CB;
        Tue, 28 May 2019 11:14:59 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will.deacon@arm.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        aisheng.dong@nxp.com, ulf.hansson@linaro.org, peng.fan@nxp.com,
        daniel.baluta@nxp.com, maxime.ripard@bootlin.com, olof@lixom.net,
        jagan@amarulasolutions.com, horms+renesas@verge.net.au,
        leonard.crestez@nxp.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V13 2/5] thermal: of-thermal: add API for getting sensor ID from DT
Date:   Tue, 28 May 2019 11:16:51 +0800
Message-Id: <20190528031654.43801-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528031654.43801-1-Anson.Huang@nxp.com>
References: <20190528031654.43801-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

On some platforms like i.MX8QXP, the thermal driver needs a
real HW sensor ID from DT thermal zone, the HW sensor ID is
used to get temperature from SCU firmware, and the virtual
sensor ID starting from 0 to N is NOT used at all, this patch
adds new API thermal_zone_of_get_sensor_id() to provide the
feature of getting sensor ID from DT thermal zone's node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V12:
	- allow the caller of thermal_zone_of_get_sensor_id() to pass NULL as second parameter
	  of_phandle_args structure, as some caller maybe ONLY need to read sensor ID.
---
 drivers/thermal/of-thermal.c | 59 +++++++++++++++++++++++++++++++++++---------
 include/linux/thermal.h      | 10 ++++++++
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093b..0466ab5 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -449,6 +449,52 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 }
 
 /**
+ * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
+ * @tz_np: a valid thermal zone device node.
+ * @sensor_specs: pointer to output arguments structure will be passed back,
+ *		  it can be NULL if the caller does NOT need the output
+ *		  arguments structure to be passed back.
+ * @id: a sensor ID pointer will be passed back.
+ *
+ * This function will get sensor ID from a given thermal zone node, use
+ * "thermal-sensors" as list name, and get sensor ID from first phandle's
+ * argument.
+ *
+ * Return: 0 on success, proper error code otherwise.
+ */
+
+int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				  struct of_phandle_args *sensor_specs,
+				  u32 *id)
+{
+	struct of_phandle_args tmp_sensor_specs;
+	int ret;
+
+	if (!sensor_specs)
+		sensor_specs = &tmp_sensor_specs;
+
+	ret = of_parse_phandle_with_args(tz_np,
+					 "thermal-sensors",
+					 "#thermal-sensor-cells",
+					 0,
+					 sensor_specs);
+	if (ret)
+		return ret;
+
+	if (sensor_specs->args_count >= 1) {
+		*id = sensor_specs->args[0];
+		WARN(sensor_specs->args_count > 1,
+		     "%pOFn: too many cells in sensor specifier %d\n",
+		     sensor_specs->np, sensor_specs->args_count);
+	} else {
+		*id = 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
+
+/**
  * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
  * @dev: a valid struct device pointer of a sensor device. Must contain
  *       a valid .of_node, for the sensor node.
@@ -503,21 +549,10 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		int ret, id;
 
 		/* For now, thermal framework supports only 1 sensor per zone */
-		ret = of_parse_phandle_with_args(child, "thermal-sensors",
-						 "#thermal-sensor-cells",
-						 0, &sensor_specs);
+		ret = thermal_zone_of_get_sensor_id(child, &sensor_specs, &id);
 		if (ret)
 			continue;
 
-		if (sensor_specs.args_count >= 1) {
-			id = sensor_specs.args[0];
-			WARN(sensor_specs.args_count > 1,
-			     "%pOFn: too many cells in sensor specifier %d\n",
-			     sensor_specs.np, sensor_specs.args_count);
-		} else {
-			id = 0;
-		}
-
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 15a4ca5..c994e3a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -375,6 +375,9 @@ struct thermal_trip {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
+int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				  struct of_phandle_args *sensor_specs,
+				  u32 *id);
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops);
@@ -386,6 +389,13 @@ struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 					    struct thermal_zone_device *tz);
 #else
+
+static int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+					 struct of_phandle_args *sensor_specs,
+					 u32 *id)
+{
+	return -ENOENT;
+}
 static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
-- 
2.7.4

