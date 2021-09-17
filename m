Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEE40F333
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhIQH1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhIQH1I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 03:27:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C86C061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:25:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b21-20020a1c8015000000b003049690d882so9179304wmd.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKpMtPJV4c7fVpnQEhWgPVwySf6pvGBSBB6MRM4juX0=;
        b=vxlHtsI8MrgKZ1jumZbkHAT3aT1Ya8U+iG+fJzIab+KLF9G/6RvOl20OM2yQNQ/kuN
         LD8KJDmDZxrFUF8KgmcP020TCdPIuYetuF5AOmx8iM78iOqO6/dObgvZ9NBlKi/pogVc
         sA8Pg0WwKgohJ9/AZShFNbVKMt9AsXu6o/WDu5N4z5K7u13LN0XQo6NUvLdefnYKPLDO
         pUC5Fm5DOHUPnmSn/jojSXYsSWPNHYhXBmzlOv5a6PHtBXcvWW8GSDS3b9DTx6U4miUC
         CFvBRi3cGzglpBuyML/5MVCf0pP33v/ijoVjk3PL4ZZnB0skpkqcVOES3Ty0puxfS9zG
         i84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKpMtPJV4c7fVpnQEhWgPVwySf6pvGBSBB6MRM4juX0=;
        b=7L74Ziq4duE5Ua/RrxzFmrNfEOGvV8gwi6JGX0sRdhXCApBU/oNs73xr6XQcliq9UE
         2LWTrw/t2V5Fjc4Hv9HRCrJowJ6scL2v6tfyzkOPl5F6GAg36D9lXOSb/fV0+zQOc/uA
         ccEl7jzBRJTExNLXoHOMlMUB869ZbhLBT+J14un/jtfU4UieImQ8jRsCBvS07hpOth7V
         XSl6NEu1JRBlg4a9/rIIbkCAidK4HS0RUBTI3jDXeP+pA8DyL6XxyjTsuT8DQMTtHaxL
         Mg1ouEHwAYl1/Mf8VUUJ08W8LQ5bOMmHYD7YZqPT7y651UIzxwwBffvRtnaeFOc58BqO
         BfWg==
X-Gm-Message-State: AOAM531BAKlmN/wt7BftAD+MImLErRMvraAF84kSa/mCaTv3cjkiKNnv
        OtHNmab7N9pYAmAD3uS+7HlVGQ==
X-Google-Smtp-Source: ABdhPJy4G0wz2dgdPltmEPJRRfQq8LRjVdHP8NNZ81y2E/gbHcSs7OZ2aPO5tFT3tNRMzAGx96JBZw==
X-Received: by 2002:a1c:9888:: with SMTP id a130mr13771570wme.102.1631863545546;
        Fri, 17 Sep 2021 00:25:45 -0700 (PDT)
Received: from localhost.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z19sm11777565wma.0.2021.09.17.00.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:25:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] thermal: add a virtual sensor to aggregate temperatures
Date:   Fri, 17 Sep 2021 09:27:32 +0200
Message-Id: <20210917072732.611140-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917072732.611140-1-abailon@baylibre.com>
References: <20210917072732.611140-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a virtual thermal sensor that reads temperature from
hardware sensor and return an aggregated temperature.
Currently, this supports three operations:
the minimum, maximum and average temperature.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/Kconfig                  |   8 +
 drivers/thermal/Makefile                 |   1 +
 drivers/thermal/virtual-thermal-sensor.h |  54 ++++
 drivers/thermal/virtual_thermal_sensor.c | 350 +++++++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 drivers/thermal/virtual-thermal-sensor.h
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1d..20bc93c48f5b1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -228,6 +228,14 @@ config THERMAL_MMIO
 	  register or shared memory, is a potential candidate to work with this
 	  driver.
 
+config VIRTUAL_THERMAL
+	tristate "Virtual thermal sensor driver"
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
index 82fc3e616e54b..8bf55973059c5 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
diff --git a/drivers/thermal/virtual-thermal-sensor.h b/drivers/thermal/virtual-thermal-sensor.h
new file mode 100644
index 0000000000000..3bbf7c324dddc
--- /dev/null
+++ b/drivers/thermal/virtual-thermal-sensor.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 BayLibre
+ */
+
+#ifndef __THERMAL_VIRTUAL_SENSOR_H__
+#define __THERMAL_VIRTUAL_SENSOR_H__
+
+#include <linux/device.h>
+#include <linux/thermal.h>
+
+struct virtual_thermal_sensor;
+struct thermal_sensor_data;
+
+#if IS_ENABLED(CONFIG_VIRTUAL_THERMAL)
+struct thermal_sensor_data *
+thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				const struct thermal_zone_of_device_ops *ops);
+void thermal_virtual_sensor_unregister(struct device *dev,
+				       struct thermal_sensor_data *sensor_data);
+struct thermal_sensor_data *
+devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				     const struct thermal_zone_of_device_ops *ops);
+
+void devm_thermal_virtual_sensor_unregister(struct device *dev,
+					    struct virtual_thermal_sensor *sensor);
+#else
+static inline struct thermal_sensor_data *
+thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				const struct thermal_zone_of_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+void thermal_virtual_sensor_unregister(struct device *dev,
+				       struct thermal_sensor_data *sensor_data)
+{
+}
+
+static inline struct thermal_sensor_data *
+devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
+				     const struct thermal_zone_of_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline
+void devm_thermal_virtual_sensor_unregister(struct device *dev,
+					    struct virtual_thermal_sensor *sensor)
+{
+}
+#endif
+
+#endif /* __THERMAL_VIRTUAL_SENSOR_H__ */
diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
new file mode 100644
index 0000000000000..234563af6643e
--- /dev/null
+++ b/drivers/thermal/virtual_thermal_sensor.c
@@ -0,0 +1,350 @@
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
+#include "virtual-thermal-sensor.h"
+
+struct thermal_sensor_data {
+	struct list_head node;
+
+	/* sensor interface */
+	int id;
+	void *sensor_data;
+	const struct thermal_zone_of_device_ops *ops;
+};
+
+struct virtual_thermal_sensor {
+	int count;
+	struct thermal_sensor_data *sensors;
+	struct thermal_zone_device *tzd;
+	int (*aggr_temp)(int temp1, int temp2);
+
+	struct list_head node;
+};
+
+static LIST_HEAD(thermal_sensors);
+static LIST_HEAD(virtual_sensors);
+
+static int max_temp(int temp1, int temp2)
+{
+	return max(temp1, temp2);
+}
+
+static int min_temp(int temp1, int temp2)
+{
+	return min(temp1, temp2);
+}
+
+static int avg_temp(int temp1, int temp2)
+{
+	return ((temp1) / 2) + ((temp2) / 2) + (((temp1) % 2 + (temp2) % 2) / 2);
+}
+
+static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
+{
+	struct virtual_thermal_sensor *sensor = data;
+	int max_temp = INT_MIN;
+	int temp;
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		struct thermal_sensor_data *hw_sensor;
+
+		hw_sensor = &sensor->sensors[i];
+		if (!hw_sensor->ops)
+			return -ENODEV;
+
+		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
+		max_temp = sensor->aggr_temp(max_temp, temp);
+	}
+
+	*temperature = max_temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
+	.get_temp = virtual_thermal_sensor_get_temp,
+};
+
+static int virtual_sensor_add_sensor(struct virtual_thermal_sensor *sensor,
+				     struct of_phandle_args args,
+				     int index)
+{
+	struct thermal_sensor_data *sensor_data;
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
+static int virtual_thermal_sensor_probe(struct platform_device *pdev)
+{
+	struct virtual_thermal_sensor *sensor;
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
+		ret = virtual_sensor_add_sensor(sensor, args, i);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case VIRTUAL_THERMAL_SENSOR_MAX:
+		sensor->aggr_temp = max_temp;
+		break;
+	case VIRTUAL_THERMAL_SENSOR_MIN:
+		sensor->aggr_temp = min_temp;
+		break;
+	case VIRTUAL_THERMAL_SENSOR_AVG:
+		sensor->aggr_temp = avg_temp;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
+							   &virtual_thermal_sensor_ops);
+	if (IS_ERR(sensor->tzd))
+		return PTR_ERR(sensor->tzd);
+
+	platform_set_drvdata(pdev, sensor);
+	list_add(&sensor->node, &virtual_sensors);
+
+	return 0;
+}
+
+static int virtual_thermal_sensor_remove(struct platform_device *pdev)
+{
+	struct virtual_thermal_sensor *sensor;
+
+	sensor = platform_get_drvdata(pdev);
+	list_del(&sensor->node);
+
+	return 0;
+}
+
+static const struct of_device_id virtual_thermal_sensor_of_match[] = {
+	{
+		.compatible = "virtual,thermal-sensor",
+	},
+	{
+	},
+};
+MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
+
+static struct platform_driver virtual_thermal_sensor = {
+	.probe = virtual_thermal_sensor_probe,
+	.remove = virtual_thermal_sensor_remove,
+	.driver = {
+		.name = "virtual-thermal-sensor",
+		.of_match_table = virtual_thermal_sensor_of_match,
+	},
+};
+
+/**
+ * thermal_virtual_sensor_register - registers a sensor that could be a virtual
+ * sensor
+ * @dev: a valid struct device pointer of a sensor device. Must contain
+ *       a valid .of_node, for the sensor node.
+ * @sensor_id: a sensor identifier, in case the sensor IP has more
+ *             than one sensor
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
+struct thermal_sensor_data *thermal_virtual_sensor_register(
+	struct device *dev, int sensor_id, void *data,
+	const struct thermal_zone_of_device_ops *ops)
+{
+	struct thermal_sensor_data *sensor_data;
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
+ * @sensor_data: a pointer to struct thermal_sensor_data to unregister.
+ *
+ * This function removes the sensor from the list of available thermal sensors.
+ * If the sensor is in use, then the next call to .get_temp will return -ENODEV.
+ */
+void thermal_virtual_sensor_unregister(struct device *dev,
+				       struct thermal_sensor_data *sensor_data)
+{
+	struct thermal_sensor_data *sd;
+	struct virtual_thermal_sensor *sensor;
+	int i;
+
+	list_del(&sensor_data->node);
+
+	list_for_each_entry(sensor, &virtual_sensors, node) {
+		for (i = 0; i < sensor->count; i++) {
+			sd = &sensor->sensors[i];
+			if (sd->id == sensor_data->id &&
+				sd->sensor_data == sensor_data->sensor_data) {
+				sd->ops = NULL;
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(thermal_virtual_sensor_unregister);
+
+static void devm_thermal_virtual_sensor_release(struct device *dev, void *res)
+{
+	thermal_virtual_sensor_unregister(dev,
+					  *(struct thermal_sensor_data **)res);
+}
+
+static int devm_thermal_virtual_sensor_match(struct device *dev, void *res,
+					     void *data)
+{
+	struct thermal_sensor_data **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+/**
+ * devm_thermal_virtual_sensor_register - Resource managed version of
+ *				thermal_virtual_sensor_register()
+ * @dev: a valid struct device pointer of a sensor device. Must contain
+ *       a valid .of_node, for the sensor node.
+ * @sensor_id: a sensor identifier, in case the sensor IP has more
+ *	       than one sensor
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
+ * released when device is unbound.
+ */
+struct thermal_sensor_data *devm_thermal_virtual_sensor_register(
+	struct device *dev, int sensor_id,
+	void *data, const struct thermal_zone_of_device_ops *ops)
+{
+	struct thermal_sensor_data **ptr, *sensor_data;
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
+					    struct virtual_thermal_sensor *sensor)
+{
+	WARN_ON(devres_release(dev, devm_thermal_virtual_sensor_release,
+			       devm_thermal_virtual_sensor_match, sensor));
+}
+EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_unregister);
+
+module_platform_driver(virtual_thermal_sensor);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_DESCRIPTION("Virtual thermal sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

