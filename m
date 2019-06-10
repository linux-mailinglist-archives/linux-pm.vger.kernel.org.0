Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6573AD48
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 04:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfFJCvn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Jun 2019 22:51:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44742 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfFJCvm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 Jun 2019 22:51:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBC421A0740;
        Mon, 10 Jun 2019 04:51:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DBFD1A029E;
        Mon, 10 Jun 2019 04:51:24 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 773EC4029A;
        Mon, 10 Jun 2019 10:51:10 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, peng.fan@nxp.com,
        mchehab+samsung@kernel.org, linux@roeck-us.net,
        daniel.baluta@nxp.com, maxime.ripard@bootlin.com, olof@lixom.net,
        jagan@amarulasolutions.com, horms+renesas@verge.net.au,
        leonard.crestez@nxp.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V14 2/5] thermal: of-thermal: add API for getting sensor ID from DT
Date:   Mon, 10 Jun 2019 10:52:51 +0800
Message-Id: <20190610025254.23940-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610025254.23940-1-Anson.Huang@nxp.com>
References: <20190610025254.23940-1-Anson.Huang@nxp.com>
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
Changes since V13:
	- add new API into the thermal API doc.
---
 Documentation/thermal/sysfs-api.txt |  8 +++++
 drivers/thermal/of-thermal.c        | 66 ++++++++++++++++++++++++++++---------
 include/linux/thermal.h             | 10 ++++++
 3 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index c3fa500..8d7f1b1 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -159,6 +159,14 @@ temperature) and throttle appropriate devices.
 	for the thermal zone device, which might be useful for platform
 	drivers for temperature calculations.
 
+1.1.9 int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+		struct device_node *sensor_np,
+		u32 *id)
+
+	This interface is used to get the sensor id from thermal sensor's
+	phandle argument, it might be necessary for some platforms which
+	have specific sensor ID rather than virtual ID from 0 - N.
+
 1.2 thermal cooling device interface
 1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
 		void *devdata, struct thermal_cooling_device_ops *)
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093b..a53792b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -449,6 +449,54 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 }
 
 /**
+ * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
+ * @tz_np: a valid thermal zone device node.
+ * @sensor_np: a sensor node of a valid sensor device.
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
@@ -499,36 +547,22 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
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
index 15a4ca5..5edffe6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -375,6 +375,9 @@ struct thermal_trip {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
+int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				  struct device_node *sensor_np,
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

