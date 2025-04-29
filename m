Return-Path: <linux-pm+bounces-26359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D57AA0316
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 08:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A263AC6D3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93C27F74D;
	Tue, 29 Apr 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA5/B+K7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4A279900;
	Tue, 29 Apr 2025 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907517; cv=none; b=iYM/oJikqOWsimeKxaz/ZYAfvwHzHg9zRHVFCJ6yqILNsei1xZsR2KEQn6ME46+m63LjhpTrS/9ZmJSdJZpZ5hy7vOwKpWDhguCz9p5R/Jh7Oa4LUS3LjA84GpQhgZl8lQ/7A3YEHknMwC51GCxsnJFc67laEQ2R1BwiELMeVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907517; c=relaxed/simple;
	bh=qSzrF+GM0QdMC5+nN2rZG1WjaixzxND+0IMhWcAX3Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZJ971QBXb+vgqFd7cl+YJiYc1DcR8CEx5hNrjX6Kcj5nUoOeKtNHWrFSiDetrcvDaGz8fk6kco0HNyXbgndllaRH09K5+b8bEKQEjrluJrS/6d9364YjVnBJcLKlpH4yE1L86txBTIj4db5UElVd42F2PZ5Kc37sw9uxDWgY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA5/B+K7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac345bd8e13so796026466b.0;
        Mon, 28 Apr 2025 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745907514; x=1746512314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHGMJDOyVsHu7ASH3UhH5fby5m2xZH+/EERiOLk7Q3k=;
        b=cA5/B+K7KLM/c/8KFIz+eVLCEu3HRjJDjcuth7aTbsQu7d+q2mCbVvjD9SN7I0g6CX
         fCkL6oQS4hKD6Q9U9oe5OV/KYs8ZVSyJ9MmYpMnh7HinGpdYHQSKNYX30XaymRqGecmW
         K2GbIjwGU2CNBy6/HrWtujva/ESmzNS0mvnZg4iW/xFQC4nDVKJq9k95a4TutqSsiisu
         VZmybMxmACyEm6I6MWi9Aj+BToqn1aWx4kPExg5CNHVIEYE8g28hNjG5iJIp1+VT4N0x
         OYgUlQ9OaZeJlfBh/hBsmOEn6muxmKIG4mQMm/0FJjYev6XpNWdnrGsifQWyJmstzLgY
         PW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745907514; x=1746512314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHGMJDOyVsHu7ASH3UhH5fby5m2xZH+/EERiOLk7Q3k=;
        b=sjyNJ1NjAMnwhS9KKzrrlIe4sa7aU283FxeeEAtaYugRJeVWg5YCWvzsIueUSnb0IN
         YWOfikyAs+Dr3o2E7vevQwUiswW94ZtPeGNPIgOmUlKbyjBFVw/GqNeWPbb4boUg43wT
         hP5xAr02RVeAOLbRNr3J02qGPvc8guOT7rX+b282CZXGYyyCyd1T88o8xUs5Wg48vGc7
         c3o/kA/UZSjulP/YS71LFyWoNPoU9x5vCIQHDrPVxfFSuCPzu2HMr2PJ46grbxSxefZz
         sLXBzN2X+3WCBHMgUtB4BRbhYA45IZv/iiiS6kX/RyLMhWd9jZbCKL15wbozlTbYzwrl
         9jjA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rgcxppoDdZXU6WgDryNrLkvQo4HJvT9mvqKHriuEPXEYefRZt61Etw2vxACkr/mgIGrZU6NQTwRGXny3@vger.kernel.org, AJvYcCWd1hDoSKNqKmSz9jusV+r+IwbSVWR1P05YCEy2F5Ud9UwGOyjaFXu2DBaNo7yAKQtRVoghhBPSCwjX@vger.kernel.org, AJvYcCWrONkUILTxLF5ww8i0jw2upQQZuo+/qmUd8bd5wqcNIT7dCmaa+Hru+7qg25s0NLA15oBckucx90xZh78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lHtKgaWMLSRP81UC8ngek6HvB4wu+TA/AmrECcB0QZUKtGNj
	Mcq55CHXOcbrOXayLdI02qhaEuwYEkgm+z9GNFAQb/JiZJwiKwbz
X-Gm-Gg: ASbGncszniBj6cgrX4D8MzC2InaW+jtzFX0Lrtqf9YhKwo35jVZV/9iDg/ZYfWy/h/5
	6HGHe2npG6m6wcQfiJ2MkQea3YNdr4+VSU9H3E7fueQ8y09evmXECXpqZEbggPa+cVjgdwNX2kG
	GsHWOeggT4Af4cs6HNfQD0FGtyUWLVF5LvOYgZwCrf/xeCa2AVEHOxjLzmCtmQsXMl1+A5L35fZ
	5jlNdhoG33Dm8nMic/dKbVDDGpw2fskKij2fbFX8aiQfBCA2/FYIXgoec2xdSPMiVJYXLDWkiJS
	iHIqDrCTeHvBcLrYoJrpJOvskb035z97
X-Google-Smtp-Source: AGHT+IEKLaYZ+8PckWjPrgPDN5jVCc6vSNqJSq93uHOndAVFVzpOEQjdzTJBCvN2oIOGSl/xu1gIRA==
X-Received: by 2002:a17:907:748:b0:ace:4ed6:2690 with SMTP id a640c23a62f3a-acec8551733mr141165166b.28.1745907513507;
        Mon, 28 Apr 2025 23:18:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff9c5sm6996570a12.28.2025.04.28.23.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:18:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 3/4] power: supply: Add driver for Pegatron Chagall battery
Date: Tue, 29 Apr 2025 09:18:01 +0300
Message-ID: <20250429061803.9581-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429061803.9581-1-clamor95@gmail.com>
References: <20250429061803.9581-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pegatron Chagall is an Android tablet utilizing a customized Cypress
CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
single-cell battery and features a dual-color charging LED.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/Kconfig           |  12 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/chagall-battery.c | 291 +++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/power/supply/chagall-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..d0fc9db524bd 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -107,6 +107,18 @@ config BATTERY_ACT8945A
 	  Say Y here to enable support for power supply provided by
 	  Active-semi ActivePath ACT8945A charger.
 
+config BATTERY_CHAGALL
+	tristate "Pegatron Chagall battery driver"
+	depends on I2C
+	depends on LEDS_CLASS
+	help
+	  Say Y to include support for Cypress CG7153AM IC based battery
+	  fuel gauge with custom firmware found in Pegatron Chagall based
+	  tablet line.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called chagall-battery.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..4ecf48a33fdd 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
+obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
 obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
 obj-$(CONFIG_BATTERY_CW2015)	+= cw2015_battery.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
diff --git a/drivers/power/supply/chagall-battery.c b/drivers/power/supply/chagall-battery.c
new file mode 100644
index 000000000000..9d858d93e244
--- /dev/null
+++ b/drivers/power/supply/chagall-battery.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define CHAGALL_REG_LED_AMBER				0x60
+#define CHAGALL_REG_LED_WHITE				0x70
+#define CHAGALL_REG_BATTERY_TEMPERATURE			0xa2
+#define CHAGALL_REG_BATTERY_VOLTAGE			0xa4
+#define CHAGALL_REG_BATTERY_CURRENT			0xa6
+#define CHAGALL_REG_BATTERY_CAPACITY			0xa8
+#define CHAGALL_REG_BATTERY_CHARGING_CURRENT		0xaa
+#define CHAGALL_REG_BATTERY_CHARGING_VOLTAGE		0xac
+#define CHAGALL_REG_BATTERY_STATUS			0xae
+#define   BATTERY_DISCHARGING				BIT(6)
+#define   BATTERY_FULL_CHARGED				BIT(5)
+#define   BATTERY_FULL_DISCHARGED			BIT(4)
+#define CHAGALL_REG_BATTERY_REMAIN_CAPACITY		0xb0
+#define CHAGALL_REG_BATTERY_FULL_CAPACITY		0xb2
+#define CHAGALL_REG_MAX_COUNT				0xb4
+
+#define CHAGALL_BATTERY_DATA_REFRESH			5000
+#define TEMP_CELSIUS_OFFSET				2731
+
+static const struct regmap_config chagall_battery_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = CHAGALL_REG_MAX_COUNT,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+struct chagall_battery_data {
+	struct regmap *regmap;
+	struct led_classdev amber_led;
+	struct led_classdev white_led;
+	struct power_supply *battery;
+	struct delayed_work poll_work;
+	u16 last_state;
+};
+
+static void chagall_led_set_brightness_amber(struct led_classdev *led,
+					     enum led_brightness brightness)
+{
+	struct chagall_battery_data *cg =
+		container_of(led, struct chagall_battery_data, amber_led);
+
+	regmap_write(cg->regmap, CHAGALL_REG_LED_AMBER, brightness);
+}
+
+static void chagall_led_set_brightness_white(struct led_classdev *led,
+					     enum led_brightness brightness)
+{
+	struct chagall_battery_data *cg =
+		container_of(led, struct chagall_battery_data, white_led);
+
+	regmap_write(cg->regmap, CHAGALL_REG_LED_WHITE, brightness);
+}
+
+static const enum power_supply_property chagall_battery_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+};
+
+static const unsigned int chagall_battery_prop_offs[] = {
+	[POWER_SUPPLY_PROP_STATUS] = CHAGALL_REG_BATTERY_STATUS,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = CHAGALL_REG_BATTERY_VOLTAGE,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = CHAGALL_REG_BATTERY_CHARGING_VOLTAGE,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = CHAGALL_REG_BATTERY_CURRENT,
+	[POWER_SUPPLY_PROP_CURRENT_MAX] = CHAGALL_REG_BATTERY_CHARGING_CURRENT,
+	[POWER_SUPPLY_PROP_CAPACITY] = CHAGALL_REG_BATTERY_CAPACITY,
+	[POWER_SUPPLY_PROP_TEMP] = CHAGALL_REG_BATTERY_TEMPERATURE,
+	[POWER_SUPPLY_PROP_CHARGE_FULL] = CHAGALL_REG_BATTERY_FULL_CAPACITY,
+	[POWER_SUPPLY_PROP_CHARGE_NOW] = CHAGALL_REG_BATTERY_REMAIN_CAPACITY,
+};
+
+static int chagall_battery_get_value(struct chagall_battery_data *cg,
+				     enum power_supply_property psp, u32 *val)
+{
+	if (psp >= ARRAY_SIZE(chagall_battery_prop_offs))
+		return -EINVAL;
+	if (!chagall_battery_prop_offs[psp])
+		return -EINVAL;
+
+	/* Battery data is stored in 2 consecutive registers with little-endian */
+	return regmap_bulk_read(cg->regmap, chagall_battery_prop_offs[psp], val, 2);
+}
+
+static int chagall_battery_get_status(u32 status_reg)
+{
+	if (status_reg & BATTERY_FULL_CHARGED)
+		return POWER_SUPPLY_STATUS_FULL;
+	else if (status_reg & BATTERY_DISCHARGING)
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+	else
+		return POWER_SUPPLY_STATUS_CHARGING;
+}
+
+static int chagall_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct chagall_battery_data *cg = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+
+	default:
+		ret = chagall_battery_get_value(cg, psp, &val->intval);
+		if (ret)
+			return ret;
+
+		switch (psp) {
+		case POWER_SUPPLY_PROP_TEMP:
+			val->intval -= TEMP_CELSIUS_OFFSET;
+			break;
+
+		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		case POWER_SUPPLY_PROP_CURRENT_MAX:
+		case POWER_SUPPLY_PROP_CURRENT_NOW:
+		case POWER_SUPPLY_PROP_CHARGE_FULL:
+		case POWER_SUPPLY_PROP_CHARGE_NOW:
+			val->intval *= 1000;
+			break;
+
+		case POWER_SUPPLY_PROP_STATUS:
+			val->intval = chagall_battery_get_status(val->intval);
+			break;
+
+		default:
+			break;
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
+static void chagall_battery_poll_work(struct work_struct *work)
+{
+	struct chagall_battery_data *cg =
+		container_of(work, struct chagall_battery_data, poll_work.work);
+	u32 state;
+	int ret;
+
+	ret = chagall_battery_get_value(cg, POWER_SUPPLY_PROP_STATUS, &state);
+	if (ret)
+		return;
+
+	state = chagall_battery_get_status(state);
+
+	if (cg->last_state != state) {
+		cg->last_state = state;
+		power_supply_changed(cg->battery);
+	}
+
+	/* continuously send uevent notification */
+	schedule_delayed_work(&cg->poll_work,
+			      msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));
+}
+
+static const struct power_supply_desc chagall_battery_desc = {
+	.name = "chagall-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = chagall_battery_properties,
+	.num_properties = ARRAY_SIZE(chagall_battery_properties),
+	.get_property = chagall_battery_get_property,
+	.external_power_changed = power_supply_changed,
+};
+
+static int chagall_battery_probe(struct i2c_client *client)
+{
+	struct chagall_battery_data *cg;
+	struct device *dev = &client->dev;
+	struct power_supply_config cfg = { };
+	int ret;
+
+	cg = devm_kzalloc(dev, sizeof(*cg), GFP_KERNEL);
+	if (!cg)
+		return -ENOMEM;
+
+	cfg.drv_data = cg;
+	cfg.fwnode = dev_fwnode(dev);
+
+	i2c_set_clientdata(client, cg);
+
+	cg->regmap = devm_regmap_init_i2c(client, &chagall_battery_regmap_config);
+	if (IS_ERR(cg->regmap))
+		return dev_err_probe(dev, PTR_ERR(cg->regmap), "cannot allocate regmap\n");
+
+	cg->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+	cg->battery = devm_power_supply_register(dev, &chagall_battery_desc, &cfg);
+	if (IS_ERR(cg->battery))
+		return dev_err_probe(dev, PTR_ERR(cg->battery),
+				     "failed to register power supply\n");
+
+	cg->amber_led.name = "power::amber";
+	cg->amber_led.max_brightness = 1;
+	cg->amber_led.flags = LED_CORE_SUSPENDRESUME;
+	cg->amber_led.brightness_set = chagall_led_set_brightness_amber;
+	cg->amber_led.default_trigger = "chagall-battery-charging";
+
+	ret = devm_led_classdev_register(dev, &cg->amber_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register amber LED\n");
+
+	cg->white_led.name = "power::white";
+	cg->white_led.max_brightness = 1;
+	cg->white_led.flags = LED_CORE_SUSPENDRESUME;
+	cg->white_led.brightness_set = chagall_led_set_brightness_white;
+	cg->amber_led.default_trigger = "chagall-battery-full";
+
+	ret = devm_led_classdev_register(dev, &cg->white_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register white LED\n");
+
+	led_set_brightness(&cg->amber_led, LED_OFF);
+	led_set_brightness(&cg->white_led, LED_OFF);
+
+	ret = devm_delayed_work_autocancel(dev, &cg->poll_work, chagall_battery_poll_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));
+
+	return 0;
+}
+
+static int __maybe_unused chagall_battery_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct chagall_battery_data *cg = i2c_get_clientdata(client);
+
+	cancel_delayed_work_sync(&cg->poll_work);
+
+	return 0;
+}
+
+static int __maybe_unused chagall_battery_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct chagall_battery_data *cg = i2c_get_clientdata(client);
+
+	schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(chagall_battery_pm_ops,
+			 chagall_battery_suspend, chagall_battery_resume);
+
+static const struct of_device_id chagall_of_match[] = {
+	{ .compatible = "pegatron,chagall-ec" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, chagall_of_match);
+
+static struct i2c_driver chagall_battery_driver = {
+	.driver = {
+		.name = "chagall-battery",
+		.pm = &chagall_battery_pm_ops,
+		.of_match_table = chagall_of_match,
+	},
+	.probe = chagall_battery_probe,
+};
+module_i2c_driver(chagall_battery_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("Pegatron Chagall fuel gauge driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


