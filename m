Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983F42A6ED9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgKDUeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 15:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbgKDUeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 15:34:22 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E9C0613D3;
        Wed,  4 Nov 2020 12:34:22 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id v19so19473287lji.5;
        Wed, 04 Nov 2020 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77w4yjZmIJQHDCRHik6uDl4VQaZFvsvn77X3uS2Z2NE=;
        b=vZF/kCvAAmwwQdOK6gMtmu5LAcm/h47x2J8X+P8uXoOSHnJg32UswosivQqfzCglz4
         eCUW0a7niMJFemQZcLm33gi4RYE8Pe+HXv0hKPpOL1c1VxH4R9qGX0KMwOIAN80TLD5C
         q06es+HLNShcltGRYIWPwYwxMGR9h3e7jHEp3fdINyr+xG1iCOAInWj5NE6ASF3OIsQn
         EREG+rsNomj2AoP/u6sUH+SwU9hiNXfNmk1Yv0CFqn5mQU6GqYauRWbZg/5BkpUrCJwI
         +Swj7PF3+NBIfaMQXVknK4WzT964gppF8mA6YxSbwww7VVCfoBu9BjaBVzV+BgD7Zf8D
         WvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77w4yjZmIJQHDCRHik6uDl4VQaZFvsvn77X3uS2Z2NE=;
        b=Zjo0iA5ju203TYESnj7dlB5esJFjTZXcYBfz4UWy+nhRgat4eqiLbO2wmbXRTOi4Gd
         yTWl2LkcjR2pGMxrpEAYw5FhhU/byTP4PDe+NwIzKYFyzVjCA3PskuWE0i3zJymnBvuv
         i/pUiumr3HnuJPBFrILkFJUWyC0dS5H5L5eBib35VkHLrfpWjFF2M7hn+KW4OgMxHwDn
         SILvOP7IeciVL23Fs99QIii9FKSbZDfneAWDXFVWdsh1mvserWpdozaZuwj+svUTjtnb
         CNZL7sswVbmF9yKczkE15Faw7jgGFDqovL+urClBXHBEtFXTA5OLnbNp/D9w9QoVNlx+
         cURA==
X-Gm-Message-State: AOAM531Ug/nXQHEtdr5kmrR0V58JBqowAMUce3U5Rj+XmkSsXvUd0YiO
        mIJSJ6Xubs3Har7gLrJN7C8=
X-Google-Smtp-Source: ABdhPJzOf9+Pp8TkaqmJCi7g6QT9D8idgxMNMmEK/LFzzDP1dvvTd/pjesLbKEblsdwoY+rpb5I1WQ==
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr12074686ljo.40.1604522060529;
        Wed, 04 Nov 2020 12:34:20 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id u22sm615084ljk.45.2020.11.04.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] power: supply: Add battery gauge driver for Acer Iconia Tab A500
Date:   Wed,  4 Nov 2020 23:34:02 +0300
Message-Id: <20201104203403.24937-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104203403.24937-1-digetx@gmail.com>
References: <20201104203403.24937-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds battery gauge driver for Acer Iconia Tab A500 device.
The battery gauge function is provided via the Embedded Controller,
which is found on the Acer A500.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/Kconfig             |   6 +
 drivers/power/supply/Makefile            |   1 +
 drivers/power/supply/acer_a500_battery.c | 297 +++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/power/supply/acer_a500_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index eec646c568b7..bc493173ddbc 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -774,4 +774,10 @@ config RN5T618_POWER
 	  This driver can also be built as a module. If so, the module will be
 	  called rn5t618_power.
 
+config BATTERY_ACER_A500
+	tristate "Acer Iconia Tab A500 battery driver"
+	depends on MFD_ACER_A500_EC
+	help
+	  Say Y to include support for Acer Iconia Tab A500 battery fuel gauge.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index dd4b86318cd9..0607a3d64c0f 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -98,3 +98,4 @@ obj-$(CONFIG_CHARGER_BD70528)	+= bd70528-charger.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
 obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
+obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/supply/acer_a500_battery.c
new file mode 100644
index 000000000000..93135933c8af
--- /dev/null
+++ b/drivers/power/supply/acer_a500_battery.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Battery driver for Acer Iconia Tab A500.
+ *
+ * Copyright 2020 GRATE-driver project.
+ *
+ * Based on downstream driver from Acer Inc.
+ * Based on NVIDIA Gas Gauge driver for SBS Compliant Batteries.
+ *
+ * Copyright (c) 2010, NVIDIA Corporation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+enum {
+	REG_CAPACITY,
+	REG_VOLTAGE,
+	REG_CURRENT,
+	REG_DESIGN_CAPACITY,
+	REG_TEMPERATURE,
+};
+
+#define EC_DATA(_reg, _psp) {			\
+	.psp = POWER_SUPPLY_PROP_ ## _psp,	\
+	.reg = _reg,				\
+}
+
+static const struct battery_register {
+	enum power_supply_property psp;
+	unsigned int reg;
+} ec_data[] = {
+	[REG_CAPACITY]		= EC_DATA(0x00, CAPACITY),
+	[REG_VOLTAGE]		= EC_DATA(0x01, VOLTAGE_NOW),
+	[REG_CURRENT]		= EC_DATA(0x03, CURRENT_NOW),
+	[REG_DESIGN_CAPACITY]	= EC_DATA(0x08, CHARGE_FULL_DESIGN),
+	[REG_TEMPERATURE]	= EC_DATA(0x0a, TEMP),
+};
+
+static const enum power_supply_property a500_battery_properties[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+struct a500_battery {
+	struct delayed_work poll_work;
+	struct power_supply *psy;
+	struct regmap *rmap;
+	unsigned int capacity;
+};
+
+static bool a500_battery_update_capacity(struct a500_battery *bat)
+{
+	unsigned int capacity;
+	int err;
+
+	err = regmap_read(bat->rmap, ec_data[REG_CAPACITY].reg, &capacity);
+	if (err)
+		return false;
+
+	/* capacity can be >100% even if max value is 100% */
+	capacity = min(capacity, 100u);
+
+	if (bat->capacity != capacity) {
+		bat->capacity = capacity;
+		return true;
+	}
+
+	return false;
+}
+
+static int a500_battery_get_status(struct a500_battery *bat)
+{
+	if (bat->capacity < 100) {
+		if (power_supply_am_i_supplied(bat->psy))
+			return POWER_SUPPLY_STATUS_CHARGING;
+		else
+			return POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
+	return POWER_SUPPLY_STATUS_FULL;
+}
+
+static void a500_battery_unit_adjustment(struct device *dev,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	const unsigned int base_unit_conversion = 1000;
+	const unsigned int temp_kelvin_to_celsius = 2731;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval *= base_unit_conversion;
+		break;
+
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval -= temp_kelvin_to_celsius;
+		break;
+
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = !!val->intval;
+		break;
+
+	default:
+		dev_dbg(dev,
+			"%s: no need for unit conversion %d\n", __func__, psp);
+	}
+}
+
+static int a500_battery_get_ec_data_index(struct device *dev,
+					  enum power_supply_property psp)
+{
+	unsigned int i;
+
+	/*
+	 * DESIGN_CAPACITY register always returns a non-zero value if
+	 * battery is connected and zero if disconnected, hence we'll use
+	 * it for judging the battery presence.
+	 */
+	if (psp == POWER_SUPPLY_PROP_PRESENT)
+		psp = POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN;
+
+	for (i = 0; i < ARRAY_SIZE(ec_data); i++)
+		if (psp == ec_data[i].psp)
+			return i;
+
+	dev_dbg(dev, "%s: invalid property %u\n", __func__, psp);
+
+	return -EINVAL;
+}
+
+static int a500_battery_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct a500_battery *bat = power_supply_get_drvdata(psy);
+	struct device *dev = psy->dev.parent;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = a500_battery_get_status(bat);
+		break;
+
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		a500_battery_update_capacity(bat);
+		val->intval = bat->capacity;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = a500_battery_get_ec_data_index(dev, psp);
+		if (ret < 0)
+			break;
+
+		ret = regmap_read(bat->rmap, ec_data[ret].reg, &val->intval);
+		break;
+
+	default:
+		dev_err(dev, "%s: invalid property %u\n", __func__, psp);
+		return -EINVAL;
+	}
+
+	if (!ret) {
+		/* convert units to match requirements of power supply class */
+		a500_battery_unit_adjustment(dev, psp, val);
+	}
+
+	dev_dbg(dev, "%s: property = %d, value = %x\n",
+		__func__, psp, val->intval);
+
+	/* return NODATA for properties if battery not presents */
+	if (ret)
+		return -ENODATA;
+
+	return 0;
+}
+
+static void a500_battery_poll_work(struct work_struct *work)
+{
+	struct a500_battery *bat;
+	bool capacity_changed;
+
+	bat = container_of(work, struct a500_battery, poll_work.work);
+	capacity_changed = a500_battery_update_capacity(bat);
+
+	if (capacity_changed)
+		power_supply_changed(bat->psy);
+
+	/* continuously send uevent notification */
+	schedule_delayed_work(&bat->poll_work, 30 * HZ);
+}
+
+static const struct power_supply_desc a500_battery_desc = {
+	.name = "ec-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = a500_battery_properties,
+	.get_property = a500_battery_get_property,
+	.num_properties = ARRAY_SIZE(a500_battery_properties),
+	.external_power_changed = power_supply_changed,
+};
+
+static int a500_battery_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct a500_battery *bat;
+
+	bat = devm_kzalloc(&pdev->dev, sizeof(*bat), GFP_KERNEL);
+	if (!bat)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, bat);
+
+	psy_cfg.of_node = pdev->dev.parent->of_node;
+	psy_cfg.drv_data = bat;
+
+	bat->rmap = dev_get_regmap(pdev->dev.parent, "KB930");
+	if (!bat->rmap)
+		return -EINVAL;
+
+	bat->psy = devm_power_supply_register_no_ws(&pdev->dev,
+						    &a500_battery_desc,
+						    &psy_cfg);
+	if (IS_ERR(bat->psy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(bat->psy),
+				     "failed to register battery\n");
+
+	INIT_DELAYED_WORK(&bat->poll_work, a500_battery_poll_work);
+	schedule_delayed_work(&bat->poll_work, HZ);
+
+	return 0;
+}
+
+static int a500_battery_remove(struct platform_device *pdev)
+{
+	struct a500_battery *bat = dev_get_drvdata(&pdev->dev);
+
+	cancel_delayed_work_sync(&bat->poll_work);
+
+	return 0;
+}
+
+static int __maybe_unused a500_battery_suspend(struct device *dev)
+{
+	struct a500_battery *bat = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&bat->poll_work);
+
+	return 0;
+}
+
+static int __maybe_unused a500_battery_resume(struct device *dev)
+{
+	struct a500_battery *bat = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&bat->poll_work, HZ);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(a500_battery_pm_ops,
+			 a500_battery_suspend, a500_battery_resume);
+
+static struct platform_driver a500_battery_driver = {
+	.driver = {
+		.name = "acer-a500-iconia-battery",
+		.pm = &a500_battery_pm_ops,
+	},
+	.probe = a500_battery_probe,
+	.remove = a500_battery_remove,
+};
+module_platform_driver(a500_battery_driver);
+
+MODULE_DESCRIPTION("Battery gauge driver for Acer Iconia Tab A500");
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
+MODULE_ALIAS("platform:acer-a500-iconia-battery");
+MODULE_LICENSE("GPL");
-- 
2.27.0

