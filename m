Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC83F194C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Aug 2021 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhHSMb3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Aug 2021 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbhHSMbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Aug 2021 08:31:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E735C061756
        for <linux-pm@vger.kernel.org>; Thu, 19 Aug 2021 05:30:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so8951453wrs.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Aug 2021 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/WKvB1VI4vM6pe2e95RFfcySWVrkDhonAyBFFWmQa8=;
        b=gSd69I3EpqoMcenCzLmcnoLLEKBqbR1RtEj30JxZ35+9Rl7w4qdENpciAdwDekKXmo
         wWRrm9C2yMx0VBm8eI1Oyw8+pPaamw0Q8mnT6SbJpiQQqORcoBRxV4yYX6h3nd2TeKrb
         TUtMLmKHoq5kgt2xJZz+pwge6x+LCh8HLwNsVwfGTweKwUdPMblq6kTRmHSJ+oHTBfZ9
         zfWJapXWAD64QzJgXkE/UxnAXmFUtMAnVIQQqEcf81ozxiMLtB7TB52ir55C5rxDT9lz
         inU36xsvKsmdPf2333nBsT7vkaLe/DJtwFnIQUCrGIqlgW+FWihTc8wf7wzEchEjDv6x
         BRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/WKvB1VI4vM6pe2e95RFfcySWVrkDhonAyBFFWmQa8=;
        b=AHOBfOVldVZTJWYjq5wWhPUE4fFnfp2tNS2mET5G8ynRPYjvFFabCBOlLnx3K5L6Wr
         Qu+CFqoF9WWaob1C87u1NiM7uXKfVf5bPo4MBzWCYxIDcUvoPPwsKc00Dau3Kp9K+KJi
         5fy9eX5Z4CtXNomYMFu9uoDfC8f1F+CG+OSw6lWtvYU3QwQiN55TM/cXhzWhOe9jVWcA
         +EhgqD81OSHdxmcmavp8TPH//2zP61NlvjJJKc1kifkchbZmCavDyAAWVXIJ8zT6r1bG
         8oY/pgqxOYkxByFjwdt5Jj/YsDhTca6qBK0OkugoBljfmcgynCc78hsgwmWp7aWYNfJd
         7DZQ==
X-Gm-Message-State: AOAM533vCcavUhEShHfDtsfN/spGrg2RjxJhUFYtiIJYE+84JHCOjLYe
        1q8NWQA28AlnLnwN2xcp3bCnNg==
X-Google-Smtp-Source: ABdhPJylz9TOPxhpZf4AyuRNTDd2HXaYZYAo1L9bHp5Lo3Y0JKfwF+ZIQ0ddYiLaz/VVYI0dkjAfew==
X-Received: by 2002:a5d:6301:: with SMTP id i1mr3466077wru.423.1629376245008;
        Thu, 19 Aug 2021 05:30:45 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y10sm8146814wmo.18.2021.08.19.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:30:44 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 2/2] thermal: add a virtual sensor to aggregate temperatures
Date:   Thu, 19 Aug 2021 14:32:15 +0200
Message-Id: <20210819123215.591593-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819123215.591593-1-abailon@baylibre.com>
References: <20210819123215.591593-1-abailon@baylibre.com>
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
 drivers/thermal/Kconfig              |   8 ++
 drivers/thermal/Makefile             |   1 +
 drivers/thermal/thermal_aggregator.c | 134 +++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/thermal/thermal_aggregator.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7a4ba50ba97d0..f9c152cfb95bc 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -228,6 +228,14 @@ config THERMAL_MMIO
 	  register or shared memory, is a potential candidate to work with this
 	  driver.
 
+config THERMAL_AGGREGATOR
+	tristate "Generic thermal aggregator driver"
+	depends on TERMAL_OF || COMPILE_TEST
+	help
+	  This option enables the generic thermal sensor aggregator.
+	  This driver creates a thermal sensor that reads the hardware sensors
+	  and aggregate the temperature.
+
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9729a2b089919..5b20ef15aebbe 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_THERMAL_AGGREGATOR) += thermal_aggregator.o
diff --git a/drivers/thermal/thermal_aggregator.c b/drivers/thermal/thermal_aggregator.c
new file mode 100644
index 0000000000000..76f871dbfee9e
--- /dev/null
+++ b/drivers/thermal/thermal_aggregator.c
@@ -0,0 +1,134 @@
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
+const char *aggr_types[] = {
+	"min",
+	"max",
+	"avg",
+};
+
+struct thermal_aggr;
+
+typedef int (*aggregate_fn)(struct thermal_aggr *aggr);
+
+struct thermal_aggr_sensor {
+	struct thermal_sensor *sensor;
+
+	struct list_head node;
+};
+
+struct thermal_aggr {
+	struct list_head sensors;
+	aggregate_fn *aggregate;
+	//struct thermal_zone_device *tz;
+};
+
+static int thermal_aggr_read_temp(void *data, int *temperature)
+{
+	struct thermal_aggr *aggr = data;
+	struct thermal_aggr_sensor *sensor;
+	int max_temp = 0;
+	int temp;
+
+	list_for_each_entry(sensor, &aggr->sensors, node) {
+		if (!sensor->sensor) {
+			return -ENODEV;
+		}
+
+		sensor->sensor->ops->get_temp(sensor->sensor->sensor_data, &temp);
+		max_temp = max(max_temp, temp);
+	}
+
+	*temperature = max_temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops thermal_aggr_max_ops = {
+	.get_temp = thermal_aggr_read_temp,
+};
+
+static int thermal_aggr_probe(struct platform_device *pdev)
+{
+	struct thermal_aggr *aggr;
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args args;
+	int count;
+	int ret;
+	int i;
+
+	count = of_count_phandle_with_args(dev->of_node,
+					   "thermal-sensors",
+					   "#thermal-sensor-cells");
+	if (count <= 0)
+		return -EINVAL;
+
+	aggr = kzalloc(sizeof(*aggr), GFP_KERNEL);
+	INIT_LIST_HEAD(&aggr->sensors);
+
+	for (i = 0; i < count; i++) {
+		struct thermal_sensor *sensor;
+		struct thermal_aggr_sensor *aggr_sensor;
+		int id;
+
+		ret = of_parse_phandle_with_args(dev->of_node,
+						 "thermal-sensors",
+						 "#thermal-sensor-cells",
+						 i,
+						 &args);
+		if (ret) {
+			return ret;
+		}
+
+		id = args.args_count ? args.args[0] : 0;
+		sensor = thermal_of_get_sensor(args.np, id);
+		if (sensor == NULL) {
+			return -EPROBE_DEFER;
+		}
+
+		aggr_sensor = kzalloc(sizeof(*aggr_sensor), GFP_KERNEL);
+		aggr_sensor->np = args.np;
+		aggr_sensor->id = id;
+		aggr_sensor->sensor = sensor;
+		list_add(&aggr_sensor->node, &aggr->sensors);
+	}
+
+	/*tzdev = */devm_thermal_zone_of_sensor_register(dev, 0, aggr, &thermal_aggr_max_ops);
+
+	return 0;
+}
+
+static int thermal_aggr_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id thermal_aggr_of_match[] = {
+	{
+		.compatible = "generic,thermal-aggregator",
+	},
+	{
+	},
+};
+MODULE_DEVICE_TABLE(of, thermal_aggr_of_match);
+
+static struct platform_driver thermal_aggr = {
+	.probe = thermal_aggr_probe,
+	.remove = thermal_aggr_remove,
+	.driver = {
+		.name = "thermal-aggregator",
+		.of_match_table = thermal_aggr_of_match,
+	},
+};
+
+module_platform_driver(thermal_aggr);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_DESCRIPTION("Thermal sensor aggregator");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

