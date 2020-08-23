Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465ED24ED94
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHWOK0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgHWOKH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 10:10:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F590C061575;
        Sun, 23 Aug 2020 07:10:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u23so716031lfl.10;
        Sun, 23 Aug 2020 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjpkV/460xf0TFgawt1/kH5qRAKcyuI0j4h8FTGZcLo=;
        b=Gw1J5Rax7mJMpIzKGjmaqqhesEGhtp6gkskCCEfxrvh/gppjY3f3sbDdpTKdv1ZtZn
         wgvJgbKVciQFsmI5VKvCWMqkQ41WsJ78vESJbJlsYu7xMuusgLsKL5pUftQenNWU7sud
         ikbVlFnwARwSE4Fbrap4YkVmfhz4hbdTCvfOxjlYpNAfdEPXUf3Tb+8DfgBQJryn2UnR
         LPtzavganVnSewa14+5l4npFNGaFZibpZjrM0K7anHHKXRQjMl6xuAHKpQkrPAP2Cok1
         PuwN1lLsANkFINVOHfld2vt7n/KhjDoR6GTnuX4BljUQd7Zn/SeKfS7zB2m30SAIz2Da
         HdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjpkV/460xf0TFgawt1/kH5qRAKcyuI0j4h8FTGZcLo=;
        b=MdCwgW8R7nncWRJuBHD4AVN81TwJS6zHpbHQ5Ot1pouS0dYHEtJLAIU5nXgSVzyJoa
         xoMRczwv0iU5HktaWYLLIFSsgrvbXslcpmjW3VMRnng5kXdkb8ZyrCtFMUj59yqbjkZp
         qtdRFNXXyeoNirf1Fs31A2G55XSrD9P5/yvFDQF072O9hfxdmQPps850dNtK7faBljKU
         xMG1WcgukRl10baldqF6xUcBlxezUVkSBptogRDwKla7Wf58kwjU8aSVHESuuOF3jfYe
         V0dmzmQH4yVtByyohKpKpT2HXKJphx+DBjp19LfGgL8qPClOaog1F5WJT31aK6kPizBR
         vBvw==
X-Gm-Message-State: AOAM531Bo4wB33c++4mPYEnSSXSv7uTR1nRtnlFgOZwrteFgkjiEpgPx
        WcntHv6f8bApsv3srz3ad44=
X-Google-Smtp-Source: ABdhPJzdnDTsw4lVxrnQv59TfqLArKITEvmSNtUVNIUG5CAHgmXN5ftO1IgabKG0s2TKzBzMLayCAA==
X-Received: by 2002:a19:102:: with SMTP id 2mr661938lfb.54.1598191801958;
        Sun, 23 Aug 2020 07:10:01 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b17sm1641342ljp.9.2020.08.23.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:10:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] power: supply: Add battery gauge driver for Acer Iconia Tab A500
Date:   Sun, 23 Aug 2020 17:08:42 +0300
Message-Id: <20200823140846.19299-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200823140846.19299-1-digetx@gmail.com>
References: <20200823140846.19299-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds battery gauge driver for Acer Iconia Tab A500 device.
The battery gauge function is provided via the Embedded Controller,
which is found on the Acer A500.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/Kconfig             |   6 +
 drivers/power/supply/Makefile            |   1 +
 drivers/power/supply/acer_a500_battery.c | 369 +++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 drivers/power/supply/acer_a500_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index faf2830aa152..dff5e5a7383f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -752,4 +752,10 @@ config CHARGER_WILCO
 	  information can be found in
 	  Documentation/ABI/testing/sysfs-class-power-wilco
 
+config BATTERY_ACER_A500
+	tristate "Acer Iconia Tab A500 battery driver"
+	depends on MFD_ACER_A500_EC
+	help
+	  Say Y to include support for Acer Iconia Tab A500 battery fuel gauge.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b3c694a65114..08a5b49e2936 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -96,3 +96,4 @@ obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD70528)	+= bd70528-charger.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
+obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/supply/acer_a500_battery.c
new file mode 100644
index 000000000000..933101e1261e
--- /dev/null
+++ b/drivers/power/supply/acer_a500_battery.c
@@ -0,0 +1,369 @@
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
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include <linux/mfd/acer-ec-a500.h>
+
+#define BATTERY_SERIAL_LEN	22
+
+enum {
+	REG_CAPACITY,
+	REG_VOLTAGE,
+	REG_CURRENT,
+	REG_DESIGN_CAPACITY,
+	REG_TEMPERATURE,
+	REG_SERIAL_NUMBER,
+};
+
+#define EC_DATA(_cmd, _delay, _psp) {		\
+	.psp = POWER_SUPPLY_PROP_ ## _psp,	\
+	.cmd = {				\
+		.cmd = _cmd,			\
+		.post_delay = _delay		\
+	},					\
+}
+
+static const struct chip_data {
+	enum power_supply_property psp;
+	struct a500_ec_cmd cmd;
+} ec_data[] = {
+	[REG_CAPACITY]		= EC_DATA(0x00,  0, CAPACITY),
+	[REG_VOLTAGE]		= EC_DATA(0x01,  0, VOLTAGE_NOW),
+	[REG_CURRENT]		= EC_DATA(0x03, 10, CURRENT_NOW),
+	[REG_DESIGN_CAPACITY]	= EC_DATA(0x08,  0, CHARGE_FULL_DESIGN),
+	[REG_TEMPERATURE]	= EC_DATA(0x0a,  0, TEMP),
+	[REG_SERIAL_NUMBER]	= EC_DATA(0x6a,  0, SERIAL_NUMBER),
+};
+
+static const enum power_supply_property a500_battery_properties[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+struct a500_battery {
+	struct delayed_work poll_work;
+	struct power_supply *psy;
+	struct a500_ec *ec_chip;
+	unsigned int capacity;
+	char serial[BATTERY_SERIAL_LEN + 1];
+};
+
+static int a500_battery_get_presence(struct a500_battery *bat,
+				     union power_supply_propval *val)
+{
+	s32 ret;
+
+	/*
+	 * DESIGN_CAPACITY register always returns a non-zero value if
+	 * battery is connected and zero if disconnected.
+	 */
+	ret = a500_ec_read(bat->ec_chip, &ec_data[REG_DESIGN_CAPACITY].cmd);
+	if (ret <= 0)
+		val->intval = 0;
+	else
+		val->intval = 1;
+
+	return 0;
+}
+
+static bool a500_battery_update_capacity(struct a500_battery *bat)
+{
+	unsigned int capacity;
+	s32 ret;
+
+	ret = a500_ec_read(bat->ec_chip, &ec_data[REG_CAPACITY].cmd);
+	if (ret < 0)
+		return false;
+
+	/* capacity can be >100% even if max value is 100% */
+	capacity = min(ret, 100);
+
+	if (bat->capacity != capacity) {
+		bat->capacity = capacity;
+		return true;
+	}
+
+	return false;
+}
+
+static void a500_battery_get_status(struct a500_battery *bat,
+				    union power_supply_propval *val)
+{
+	if (bat->capacity < 100) {
+		if (power_supply_am_i_supplied(bat->psy))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	} else {
+		val->intval = POWER_SUPPLY_STATUS_FULL;
+	}
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
+	default:
+		dev_dbg(dev,
+			"%s: no need for unit conversion %d\n", __func__, psp);
+	}
+}
+
+static int a500_battery_get_serial_number(struct a500_battery *bat,
+					  union power_supply_propval *val)
+{
+	unsigned int i;
+	s32 ret = 0;
+
+	if (bat->serial[0])
+		goto done;
+
+	a500_ec_lock(bat->ec_chip);
+	for (i = 0; i < BATTERY_SERIAL_LEN / 2; i++) {
+		ret = a500_ec_read_locked(bat->ec_chip,
+					  &ec_data[REG_SERIAL_NUMBER].cmd);
+		if (ret < 0) {
+			bat->serial[0] = '\0';
+			break;
+		}
+
+		bat->serial[i * 2 + 0] = (ret >> 0) & 0xff;
+		bat->serial[i * 2 + 1] = (ret >> 8) & 0xff;
+	}
+	a500_ec_unlock(bat->ec_chip);
+done:
+	val->strval = bat->serial;
+
+	return ret;
+}
+
+static int a500_battery_get_ec_data_index(struct device *dev,
+					  enum power_supply_property psp)
+{
+	unsigned int i;
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
+static int a500_battery_get_simple_property(struct a500_battery *bat,
+					    union power_supply_propval *val,
+					    unsigned int ec_idx)
+{
+	s32 ret;
+
+	ret = a500_ec_read(bat->ec_chip, &ec_data[ec_idx].cmd);
+	if (ret < 0)
+		return ret;
+
+	val->intval = (u16)ret;
+
+	return 0;
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
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		ret = a500_battery_get_serial_number(bat, val);
+		break;
+
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = a500_battery_get_presence(bat, val);
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		a500_battery_get_status(bat, val);
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
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = a500_battery_get_ec_data_index(dev, psp);
+		if (ret < 0)
+			break;
+
+		ret = a500_battery_get_simple_property(bat, val, ret);
+		break;
+
+	default:
+		dev_err(dev, "%s: invalid property %u\n", __func__, psp);
+		return -EINVAL;
+	}
+
+	if (!ret) {
+		/* convert units to match requirements for power supply class */
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
+static void a500_battery_delayed_work(struct work_struct *work)
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
+	int err;
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
+	bat->ec_chip = dev_get_drvdata(pdev->dev.parent);
+
+	bat->psy = devm_power_supply_register_no_ws(&pdev->dev,
+						    &a500_battery_desc,
+						    &psy_cfg);
+	err = PTR_ERR_OR_ZERO(bat->psy);
+	if (err) {
+		if (err == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev, "failed to register battery, deferring probe\n");
+		else
+			dev_err(&pdev->dev, "failed to register battery: %d\n",
+				err);
+		return err;
+	}
+
+	INIT_DELAYED_WORK(&bat->poll_work, a500_battery_delayed_work);
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
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

