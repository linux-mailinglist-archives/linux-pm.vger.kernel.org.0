Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B646043FF1E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJ2PMR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhJ2PMP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 11:12:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF65C061570
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 08:09:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so16635531wrg.5
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCUD7wa/UfrImVYU2GRX/0pQIO55YFU0ILpNbfg7yjE=;
        b=I0z6ropag1QO0QDAkHx4XE8A8b+S+vIEOc4vVyXs+GlMZT/hpKP2qAY8FeEfgW+mXu
         QkDAUYHQPO8TRAa8ldvRJna+ure7x53hGhrZhCfmn3tPWmmWjBW4nCePhtdg4853hJ6I
         VHQ4RctOcF7G0un97tw+ZqMFmSl3vc04yLQ/3w2qGuLffzwCNXlgbaWfBLTkaBTs+kgq
         Xy/UPTnyEEA4pPGI3rctAE1sh3OuqZri4+KehAhfqHSzqGBZ2UUMm8pT9IgV7vUPCfGX
         ePtmfZs8HS1x2yXOWp4rc9UooI8Ig2cjp0Ipr/+TSUGxl37+80oSao6Gkf4VOqmEBgrU
         bD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCUD7wa/UfrImVYU2GRX/0pQIO55YFU0ILpNbfg7yjE=;
        b=Tbmyhae51SzVVD7noAG+JFer5vkx8xCHU4i+rRmUkQYueYLE3NwR8L8UZ9XeZAmZ/V
         bveH4nAdOotTJehZgPb08NNRfO0bITlQiFsJhg3D3wp2nJO/9wZy//dHE7f+xW52+zB/
         ALS0kRFHgDY1aal2Ff8BM9FJ1N8xNLOEyYqj0cQEg51AlgvgaKqOmZLKbZIA41cAf5Jo
         aawpEFDIVHxpprrSq8DtZd/Osxsnc4P041ojUucb87h8Y9usy9NWdls33FTkKmug2zre
         re69uIY/fL3jfDj4WfooChFUa1z/P5yWmyvUvtqEllAJ84JjMUZQVqhTiXI0EGtu5ppn
         9cJA==
X-Gm-Message-State: AOAM5308MJFze6lATTKOC0lfY8blyvZ01uFwcYGlfJi+1T4ciirdvUED
        /BWTjCuS0a7U4rbNg4hKtNFigw==
X-Google-Smtp-Source: ABdhPJz95KAmtvq0QkYsot71ch/wgrT/8tes8TY662sqa5a+Jwmt2yQ79oIMsTAx86ojKkgIcYNPGA==
X-Received: by 2002:adf:a1d4:: with SMTP id v20mr15236363wrv.168.1635520185673;
        Fri, 29 Oct 2021 08:09:45 -0700 (PDT)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b7sm7091906wrv.72.2021.10.29.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:09:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 2/2] thermal: add a virtual sensor to aggregate temperatures
Date:   Fri, 29 Oct 2021 17:08:57 +0200
Message-Id: <20211029150857.504891-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029150857.504891-1-abailon@baylibre.com>
References: <20211029150857.504891-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a virtual thermal sensor driver that reads temperature from
multiple hardware sensors and returns an aggregated temperature.
Currently, this supports three aggregations:
the minimum, maximum and average temperature.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/Kconfig                  |   8 +
 drivers/thermal/Makefile                 |   1 +
 drivers/thermal/virtual_thermal_sensor.c | 218 +++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..b326fae5ad1d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -228,6 +228,14 @@ config THERMAL_MMIO
 	  register or shared memory, is a potential candidate to work with this
 	  driver.
 
+config VIRTUAL_THERMAL
+	tristate "DT-based virtual thermal sensor driver"
+	depends on THERMAL_OF || COMPILE_TEST
+	help
+	  This option enables the generic DT-based thermal sensor aggregator.
+	  This driver creates a thermal sensor that reads multiple hardware
+	  sensors and aggregates their output.
+
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e616e54..8bf55973059c 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
new file mode 100644
index 000000000000..b1c5ea308abb
--- /dev/null
+++ b/drivers/thermal/virtual_thermal_sensor.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * virtual_thermal_sensor.c - DT-based virtual thermal sensor driver.
+ *
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
+struct virtual_thermal_zone_device {
+	struct thermal_zone_device *zone;
+	struct module *owner;
+};
+
+struct virtual_thermal_sensor {
+	int count;
+	struct virtual_thermal_zone_device *zones;
+	struct thermal_zone_device *tzd;
+	int (*aggr_temp)(int temp1, int temp2);
+
+	struct list_head node;
+};
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
+	return (temp1 + temp2) / 2;
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
+		struct thermal_zone_device *zone;
+
+		zone = sensor->zones[i].zone;
+		zone->ops->get_temp(zone, &temp);
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
+int virtual_thermal_sensor_get_module(struct virtual_thermal_zone_device *zone,
+				      const char *name)
+{
+		struct platform_device *sensor_pdev;
+		struct device_node *node;
+
+		node = of_find_node_by_name(NULL, name);
+		if (!node)
+			return -ENODEV;
+
+		node = of_parse_phandle(node, "thermal-sensors", 0);
+		if (!node)
+			return -ENODEV;
+
+		sensor_pdev = of_find_device_by_node(node);
+		if (!sensor_pdev)
+			return -ENODEV;
+
+		if (!sensor_pdev->dev.driver)
+			return -EPROBE_DEFER;
+
+		if (!try_module_get(sensor_pdev->dev.driver->owner))
+			return -ENODEV;
+
+		zone->owner = sensor_pdev->dev.driver->owner;
+
+		return 0;
+}
+
+void virtual_thermal_sensor_put_modules(struct virtual_thermal_sensor *sensor)
+{
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		if (sensor->zones[i].zone)
+			module_put(sensor->zones[i].owner);
+	}
+}
+
+static int virtual_thermal_sensor_probe(struct platform_device *pdev)
+{
+	struct virtual_thermal_sensor *sensor;
+	struct device *dev = &pdev->dev;
+	struct property *prop;
+	const char *name;
+	u32 type;
+	int ret;
+	int i = 0;
+
+	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+	sensor->count = of_property_count_strings(dev->of_node, "thermal-sensors");
+	if (sensor->count <= 0)
+		return -EINVAL;
+
+	sensor->zones = devm_kmalloc_array(dev, sensor->count,
+					     sizeof(*sensor->zones),
+					     GFP_KERNEL);
+	if (!sensor->zones)
+		return -ENOMEM;
+
+	of_property_for_each_string(dev->of_node, "thermal-sensors", prop, name) {
+		struct virtual_thermal_zone_device *virtual_zone;
+		struct thermal_zone_device *zone;
+
+		virtual_zone = &sensor->zones[i++];
+
+		zone = thermal_zone_get_zone_by_name(name);
+		if (IS_ERR(zone))
+			return PTR_ERR(zone);
+
+		ret = virtual_thermal_sensor_get_module(virtual_zone, name);
+		if (ret)
+			goto err;
+
+		virtual_zone->zone = zone;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case VIRTUAL_THERMAL_SENSOR_MAX_VAL:
+		sensor->aggr_temp = max_temp;
+		break;
+	case VIRTUAL_THERMAL_SENSOR_MIN_VAL:
+		sensor->aggr_temp = min_temp;
+		break;
+	case VIRTUAL_THERMAL_SENSOR_AVG_VAL:
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
+
+	return 0;
+
+err:
+	virtual_thermal_sensor_put_modules(sensor);
+
+	return ret;
+}
+
+static int virtual_thermal_sensor_remove(struct platform_device *pdev)
+{
+	struct virtual_thermal_sensor *sensor;
+
+	sensor = platform_get_drvdata(pdev);
+	list_del(&sensor->node);
+
+	virtual_thermal_sensor_put_modules(sensor);
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
+module_platform_driver(virtual_thermal_sensor);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_DESCRIPTION("Virtual thermal sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

