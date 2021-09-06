Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA4E402039
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbhIFTGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbhIFTER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCDFC0612E7
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 12:03:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso117553wms.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrXv/wu5+2xz1OqU+KV03WZYjjYug3+71/FUae8j/xc=;
        b=Vcjx3Ovj92IS7H7bkD+k9aJ+gUrTIrUNJIy+njKrAu1r7X10anEiGicyINEdvlv94j
         qqyz8V1qpGt5rXovE7XjwYg+KQNs+0rAC4KnoFdo2Wa3NzZh7qbXjzrLwp4mwKMbo2zr
         pqm8qV3iLB/GgEJD12JsiE0UIR32tbsLYzBlqEb+6PNWHiBPqyg4ThtQ8ObZcyXHU4yl
         W8NAp8N4RGTUw60XA/unH/+3Fbe41oofQuSPisVs+dFEEZblgjM2AGT4/NE1MAj6vgd6
         tgn4np/CV2UFt54Nt2VPjJXUDro30ZtF0KqtqkaIOv29OOOAR3nzpRqman4dKnzNZEgT
         Nscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrXv/wu5+2xz1OqU+KV03WZYjjYug3+71/FUae8j/xc=;
        b=DWLn/hHpV1x4h8me+ZdA81iYmlxvm8UzFTmqAepygQ76HHiZMH/5aRf/T0XSGrO0VW
         8cKFJVeip8NXPomBV1UjOd4XVX+4HXDk1OOrDCl0a3quTATRJk7lon5js2TLW4p60rci
         xKC/hy4bkcFK3Tsd9AJybfKdAelqGXgjpmXKUVXFwi2uVNs7UTAQ5kHgGFGwc61vo4mF
         KNHNcSkOEXsS+QWOhstY7JDloqFEAxjgWig5xpCKncPDvsJK62490KD+JrDy6n1yXDwv
         dOiS6y5hZhugmvm+9dsrNq2Hzszeoz8VSou/jROtq/tMwH7k/Di62uuRCM3HIphtOT18
         OCdA==
X-Gm-Message-State: AOAM5327bcHkA1DzDYzkiFALCG2sq5wjUF00cZIic6Fri0XvIGfVOwpK
        gTUMg5vksPWZJNtoEchCV4goNw==
X-Google-Smtp-Source: ABdhPJzLXmw1GyIBqhyf2WiwirnYR4d3Jv3ImlNIm4Sz5EehflT5KrzNLpCDj171BjxB5chNCgFnZw==
X-Received: by 2002:a1c:7f84:: with SMTP id a126mr503692wmd.33.1630954991014;
        Mon, 06 Sep 2021 12:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id p4sm324750wmc.11.2021.09.06.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:10 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 2/2] thermal: add a virtual sensor to aggregate temperatures
Date:   Mon,  6 Sep 2021 21:04:54 +0200
Message-Id: <20210906190454.114751-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906190454.114751-1-abailon@baylibre.com>
References: <20210906190454.114751-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a virtual thermal sensor that reads temperature from
hardware sensor and return an aggregated temperature.
Currently, this only return the max temperature.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/Kconfig          |   8 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/virtual-sensor.h |  51 ++++
 drivers/thermal/virtual_sensor.c | 400 +++++++++++++++++++++++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 drivers/thermal/virtual-sensor.h
 create mode 100644 drivers/thermal/virtual_sensor.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7a4ba50ba97d0..23dc903da2fc5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -228,6 +228,14 @@ config THERMAL_MMIO
 	  register or shared memory, is a potential candidate to work with this
 	  driver.
 
+config VIRTUAL_THERMAL
+	tristate "Generic virtual thermal sensor driver"
+	depends on THERMAL_OF || COMPILE_TEST
+	help
+	  This option enables the generic thermal sensor aggregator.
+	  This driver creates a thermal sensor that reads the hardware sensors
+	  and aggregate the temperature.
+
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9729a2b089919..76dfa1d61bfc5 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_sensor.o
diff --git a/drivers/thermal/virtual-sensor.h b/drivers/thermal/virtual-sensor.h
new file mode 100644
index 0000000000000..e024d434856c7
--- /dev/null
+++ b/drivers/thermal/virtual-sensor.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 BayLibre
+ */
+
+#ifndef __THERMAL_VIRTUAL_SENSOR_H__
+#define __THERMAL_VIRTUAL_SENSOR_H__
+
+struct virtual_sensor;
+struct virtual_sensor_data;
+
+#ifdef CONFIG_VIRTUAL_THERMAL
+struct virtual_sensor_data *
+thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				const struct thermal_zone_of_device_ops *ops);
+void thermal_virtual_sensor_unregister(struct device *dev,
+				       struct virtual_sensor_data *sensor_data);
+struct virtual_sensor_data *
+devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				     const struct thermal_zone_of_device_ops *ops);
+
+void devm_thermal_virtual_sensor_unregister(struct device *dev,
+					    struct virtual_sensor *sensor);
+#else
+static inline struct virtual_sensor_data *
+thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				const struct thermal_zone_of_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+void thermal_virtual_sensor_unregister(struct device *dev,
+				       struct virtual_sensor_data *sensor_data)
+{
+}
+
+static inline struct virtual_sensor_data *
+devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				     const struct thermal_zone_of_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline
+void devm_thermal_virtual_sensor_unregister(struct device *dev,
+					    struct virtual_sensor *sensor)
+{
+}
+#endif
+
+#endif /* __THERMAL_VIRTUAL_SENSOR_H__ */
diff --git a/drivers/thermal/virtual_sensor.c b/drivers/thermal/virtual_sensor.c
new file mode 100644
index 0000000000000..e5bb0ef9adb39
--- /dev/null
+++ b/drivers/thermal/virtual_sensor.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 BayLibre
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <dt-bindings/thermal/virtual-sensor.h>
+
+#include "virtual-sensor.h"
+
+struct virtual_sensor_data {
+	struct list_head node;
+
+	/* sensor interface */
+	int id;
+	void *sensor_data;
+	const struct thermal_zone_of_device_ops *ops;
+};
+
+struct virtual_sensor {
+	int count;
+	struct virtual_sensor_data *sensors;
+	struct thermal_zone_device *tzd;
+
+	struct list_head node;
+};
+
+static LIST_HEAD(thermal_sensors);
+static LIST_HEAD(virtual_sensors);
+
+static int virtual_sensor_get_temp_max(void *data, int *temperature)
+{
+	struct virtual_sensor *sensor = data;
+	int max_temp = INT_MIN;
+	int temp;
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		struct virtual_sensor_data *hw_sensor;
+
+		hw_sensor = &sensor->sensors[i];
+		if (!hw_sensor->ops)
+			return -ENODEV;
+
+		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
+		max_temp = max(max_temp, temp);
+	}
+
+	*temperature = max_temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops virtual_sensor_max_ops = {
+	.get_temp = virtual_sensor_get_temp_max,
+};
+
+static int virtual_sensor_get_temp_min(void *data, int *temperature)
+{
+	struct virtual_sensor *sensor = data;
+	int min_temp = INT_MAX;
+	int temp;
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		struct virtual_sensor_data *hw_sensor;
+
+		hw_sensor = &sensor->sensors[i];
+		if (!hw_sensor->ops)
+			return -ENODEV;
+
+		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
+		min_temp = min(min_temp, temp);
+	}
+
+	*temperature = min_temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops virtual_sensor_min_ops = {
+	.get_temp = virtual_sensor_get_temp_min,
+};
+
+static int do_avg(int val1, int val2)
+{
+	return ((val1) / 2) + ((val2) / 2) + (((val1) % 2 + (val2) % 2) / 2);
+}
+
+static int virtual_sensor_get_temp_avg(void *data, int *temperature)
+{
+	struct virtual_sensor *sensor = data;
+	int avg_temp = 0;
+	int temp;
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		struct virtual_sensor_data *hw_sensor;
+
+		hw_sensor = &sensor->sensors[i];
+		if (!hw_sensor->ops)
+			return -ENODEV;
+
+		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
+		avg_temp = do_avg(avg_temp, temp);
+	}
+
+	*temperature = avg_temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops virtual_sensor_avg_ops = {
+	.get_temp = virtual_sensor_get_temp_avg,
+};
+
+static int register_virtual_sensor(struct virtual_sensor *sensor,
+				    struct of_phandle_args args,
+				    int index)
+{
+	struct virtual_sensor_data *sensor_data;
+	int id;
+
+	list_for_each_entry(sensor_data, &thermal_sensors, node) {
+		id = args.args_count ? args.args[0] : 0;
+		if (sensor_data->id == id) {
+			memcpy(&sensor->sensors[index], sensor_data,
+				sizeof(*sensor_data));
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int virtual_sensor_probe(struct platform_device *pdev)
+{
+	const struct thermal_zone_of_device_ops *ops;
+	struct virtual_sensor *sensor;
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args args;
+	u32 type;
+	int ret;
+	int i;
+
+	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	sensor->count = of_count_phandle_with_args(dev->of_node,
+						   "thermal-sensors",
+						   "#thermal-sensor-cells");
+	if (sensor->count <= 0)
+		return -EINVAL;
+
+	sensor->sensors = devm_kmalloc_array(dev, sensor->count,
+					     sizeof(*sensor->sensors),
+					     GFP_KERNEL);
+	if (!sensor->sensors)
+		return -ENOMEM;
+
+	for (i = 0; i < sensor->count; i++) {
+		ret = of_parse_phandle_with_args(dev->of_node,
+						 "thermal-sensors",
+						 "#thermal-sensor-cells",
+						 i,
+						 &args);
+		if (ret)
+			return ret;
+
+		ret = register_virtual_sensor(sensor, args, i);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "type", &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case VIRTUAL_SENSOR_MAX:
+		ops = &virtual_sensor_max_ops;
+		break;
+	case VIRTUAL_SENSOR_MIN:
+		ops = &virtual_sensor_min_ops;
+		break;
+	case VIRTUAL_SENSOR_AVG:
+		ops = &virtual_sensor_avg_ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor, ops);
+	if (IS_ERR(sensor->tzd))
+		return PTR_ERR(sensor->tzd);
+
+	platform_set_drvdata(pdev, sensor);
+	list_add(&sensor->node, &virtual_sensors);
+
+	return 0;
+}
+
+static int virtual_sensor_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct virtual_sensor *sensor;
+
+	sensor = platform_get_drvdata(pdev);
+	list_del(&sensor->node);
+
+	devm_thermal_zone_of_sensor_unregister(dev, sensor->tzd);
+	devm_kfree(dev, sensor->sensors);
+	devm_kfree(dev, sensor);
+
+	return 0;
+}
+
+static const struct of_device_id virtual_sensor_of_match[] = {
+	{
+		.compatible = "virtual,thermal-sensor",
+	},
+	{
+	},
+};
+MODULE_DEVICE_TABLE(of, thermal_aggr_of_match);
+
+static struct platform_driver virtual_sensor = {
+	.probe = virtual_sensor_probe,
+	.remove = virtual_sensor_remove,
+	.driver = {
+		.name = "virtual-sensor",
+		.of_match_table = virtual_sensor_of_match,
+	},
+};
+
+/**
+ * thermal_virtual_sensor_register - registers a sensor that could by a virtual
+ * sensor
+ * @dev: a valid struct device pointer of a sensor device. Must contain
+ *       a valid .of_node, for the sensor node.
+ * @sensor_id: a sensor identifier, in case the sensor IP has more
+ *             than one sensors
+ * @data: a private pointer (owned by the caller) that will be passed
+ *        back, when a temperature reading is needed.
+ * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
+ *
+ * This function will register a thermal sensor to make it available for later
+ * usage by a virtual sensor.
+ *
+ * The thermal zone temperature is provided by the @get_temp function
+ * pointer. When called, it will have the private pointer @data back.
+ *
+ * Return: On success returns a valid struct thermal_zone_device,
+ * otherwise, it returns a corresponding ERR_PTR(). Caller must
+ * check the return value with help of IS_ERR() helper.
+ */
+struct virtual_sensor_data *thermal_virtual_sensor_register(
+	struct device *dev, int sensor_id, void *data,
+	const struct thermal_zone_of_device_ops *ops)
+{
+	struct virtual_sensor_data *sensor_data;
+
+	sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
+	if (!sensor_data)
+		return ERR_PTR(-ENOMEM);
+
+	sensor_data->id = sensor_id;
+	sensor_data->sensor_data = data;
+	sensor_data->ops = ops;
+
+	list_add(&sensor_data->node, &thermal_sensors);
+
+	return sensor_data;
+}
+EXPORT_SYMBOL_GPL(thermal_virtual_sensor_register);
+
+/**
+ * thermal_virtual_sensor_unregister - unregisters a sensor
+ * @dev: a valid struct device pointer of a sensor device.
+ * @sensor_data: a pointer to struct virtual_sensor_data to unregister.
+ *
+ * This function removes the sensor from the list of available thermal sensors.
+ * If the sensor is in use, then the next call to .get_temp will return -ENODEV.
+ */
+void thermal_virtual_sensor_unregister(struct device *dev,
+				       struct virtual_sensor_data *sensor_data)
+{
+	struct virtual_sensor_data *temp;
+	struct virtual_sensor *sensor;
+	int i;
+
+	list_del(&sensor_data->node);
+
+	list_for_each_entry(sensor, &virtual_sensors, node) {
+		for (i = 0; i < sensor->count; i++) {
+			temp = &sensor->sensors[i];
+			if (temp->id == sensor_data->id &&
+				temp->sensor_data == sensor_data->sensor_data) {
+				temp->ops = NULL;
+			}
+		}
+	}
+	devm_kfree(dev, sensor_data);
+}
+EXPORT_SYMBOL_GPL(thermal_virtual_sensor_unregister);
+
+static void devm_thermal_virtual_sensor_release(struct device *dev, void *res)
+{
+	thermal_virtual_sensor_unregister(dev,
+					  *(struct virtual_sensor_data **)res);
+}
+
+static int devm_thermal_virtual_sensor_match(struct device *dev, void *res,
+					     void *data)
+{
+	struct virtual_sensor_data **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+
+/**
+ * devm_thermal_virtual_sensor_register - Resource managed version of
+ *				thermal_virtual_sensor_register()
+ * @dev: a valid struct device pointer of a sensor device. Must contain
+ *       a valid .of_node, for the sensor node.
+ * @sensor_id: a sensor identifier, in case the sensor IP has more
+ *	       than one sensors
+ * @data: a private pointer (owned by the caller) that will be passed
+ *	  back, when a temperature reading is needed.
+ * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
+ *
+ * Refer thermal_zone_of_sensor_register() for more details.
+ *
+ * Return: On success returns a valid struct virtual_sensor_data,
+ * otherwise, it returns a corresponding ERR_PTR(). Caller must
+ * check the return value with help of IS_ERR() helper.
+ * Registered virtual_sensor_data device will automatically be
+ * released when device is unbounded.
+ */
+struct virtual_sensor_data *devm_thermal_virtual_sensor_register(
+	struct device *dev, int sensor_id,
+	void *data, const struct thermal_zone_of_device_ops *ops)
+{
+	struct virtual_sensor_data **ptr, *sensor_data;
+
+	ptr = devres_alloc(devm_thermal_virtual_sensor_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	sensor_data = thermal_virtual_sensor_register(dev, sensor_id, data, ops);
+	if (IS_ERR(sensor_data)) {
+		devres_free(ptr);
+		return sensor_data;
+	}
+
+	*ptr = sensor_data;
+	devres_add(dev, ptr);
+
+	return sensor_data;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_register);
+
+/**
+ * devm_thermal_virtual_sensor_unregister - Resource managed version of
+ *				thermal_virtual_sensor_unregister().
+ * @dev: Device for which resource was allocated.
+ * @sensor: a pointer to struct thermal_zone_device where the sensor is registered.
+ *
+ * This function removes the sensor from the list of sensors registered with
+ * devm_thermal_virtual_sensor_register() API.
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_thermal_virtual_sensor_unregister(struct device *dev,
+					    struct virtual_sensor *sensor)
+{
+	WARN_ON(devres_release(dev, devm_thermal_virtual_sensor_release,
+			       devm_thermal_virtual_sensor_match, sensor));
+}
+EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_unregister);
+
+module_platform_driver(virtual_sensor);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_DESCRIPTION("Virtual thermal sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

