Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20574165419
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBTBQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 20:16:57 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55556 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgBTBQ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 20:16:57 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22C42204C8E;
        Thu, 20 Feb 2020 02:16:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79D892013D3;
        Thu, 20 Feb 2020 02:16:38 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 028CA402A0;
        Thu, 20 Feb 2020 09:16:12 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        aisheng.dong@nxp.com, linux@roeck-us.net,
        srinivas.kandagatla@linaro.org, krzk@kernel.org,
        fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com,
        bjorn.andersson@linaro.org, olof@lixom.net, dinguyen@kernel.org,
        leonard.crestez@nxp.com, marcin.juszkiewicz@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V15 RESEND 2/5] thermal: of-thermal: add API for getting sensor ID from DT
Date:   Thu, 20 Feb 2020 09:10:25 +0800
Message-Id: <1582161028-2844-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds new API thermal_zone_of_get_sensor_id() to
provide the feature of getting sensor ID from DT thermal
zone's node. It's useful for thermal driver to register the
specific thermal zone devices from DT in a common way.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes since V14:
	- improve the commit message and comment, no code change.
---
 drivers/thermal/of-thermal.c | 65 +++++++++++++++++++++++++++++++++-----------
 include/linux/thermal.h      | 10 +++++++
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index ef0baa9..0f57108 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -449,6 +449,53 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 }
 
 /**
+ * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
+ * @tz_np: a valid thermal zone device node.
+ * @sensor_np: a sensor node of a valid sensor device.
+ * @id: the sensor ID returned if success.
+ *
+ * This function will get sensor ID from a given thermal zone node and
+ * the sensor node must match the temperature provider @sensor_np.
+ *
+ * Return: 0 on success, proper error code otherwise.
+ */
+
+int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				  struct device_node *sensor_np,
+				  u32 *id)
+{
+	struct of_phandle_args sensor_specs;
+	int ret;
+
+	ret = of_parse_phandle_with_args(tz_np,
+					 "thermal-sensors",
+					 "#thermal-sensor-cells",
+					 0,
+					 &sensor_specs);
+	if (ret)
+		return ret;
+
+	if (sensor_specs.np != sensor_np) {
+		of_node_put(sensor_specs.np);
+		return -ENODEV;
+	}
+
+	if (sensor_specs.args_count >= 1) {
+		*id = sensor_specs.args[0];
+		WARN(sensor_specs.args_count > 1,
+		     "%pOFn: too many cells in sensor specifier %d\n",
+		     sensor_specs.np, sensor_specs.args_count);
+	} else {
+		*id = 0;
+	}
+
+	of_node_put(sensor_specs.np);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
+
+/**
  * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
  * @dev: a valid struct device pointer of a sensor device. Must contain
  *       a valid .of_node, for the sensor node.
@@ -499,36 +546,22 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 	sensor_np = of_node_get(dev->of_node);
 
 	for_each_available_child_of_node(np, child) {
-		struct of_phandle_args sensor_specs;
 		int ret, id;
 
 		/* For now, thermal framework supports only 1 sensor per zone */
-		ret = of_parse_phandle_with_args(child, "thermal-sensors",
-						 "#thermal-sensor-cells",
-						 0, &sensor_specs);
+		ret = thermal_zone_of_get_sensor_id(child, sensor_np, &id);
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
-		if (sensor_specs.np == sensor_np && id == sensor_id) {
+		if (id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
 			if (!IS_ERR(tzd))
 				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
 
-			of_node_put(sensor_specs.np);
 			of_node_put(child);
 			goto exit;
 		}
-		of_node_put(sensor_specs.np);
 	}
 exit:
 	of_node_put(sensor_np);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 126913c6..53e6f67 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -364,6 +364,9 @@ struct thermal_trip {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
+int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				  struct device_node *sensor_np,
+				  u32 *id);
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops);
@@ -375,6 +378,13 @@ struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 					    struct thermal_zone_device *tz);
 #else
+
+static int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+					 struct device_node *sensor_np,
+					 u32 *id)
+{
+	return -ENOENT;
+}
 static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
-- 
2.7.4

