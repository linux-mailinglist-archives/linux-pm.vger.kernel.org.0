Return-Path: <linux-pm+bounces-25329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44DA871CB
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E02189ADF2
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E361AAA29;
	Sun, 13 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCaKqnjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8F1A5B85;
	Sun, 13 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744542662; cv=none; b=TRUFbTb9fN/KG1lWoZElE7DeJUr2770/ezp2f+1jjSM+ceQwpAmHeG6WUSmUHuVn4nXs0i5OBDQR8/ydPnBoYfq1dip7FGNxqsTvpwSS2P5as+hAJcxrJU1NHPCXf7EGv/iJ/izSFfQrgJVIrD5nn7BehNBEnC/tv3chHYijJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744542662; c=relaxed/simple;
	bh=WRrSA50y3u7WzP72Iuo1EO/GfQTRCZVJkp8p0OdO1lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTLmZpagKk5r79QEyNTqeyFkmTUzxB5ADzfax9YL8nrQvFxbo1WnLhPt/NwPIIShNZz2rs3Hcn2Q8laV4NUYNdXZ3+HSZ34t4rMlIT8SpKGJpLwa19FKaSnWM456SnGqDkHe5vcLFAFOhAeuRgImKs8F3J+UTZNfFDLm5+Syd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCaKqnjQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac297cbe017so800199066b.0;
        Sun, 13 Apr 2025 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744542658; x=1745147458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSg8v2veHrUXZxak/qhrNIhIgEeYWoo3lRbNC7Kvpd4=;
        b=mCaKqnjQEhqW4qqPXYnR5CAN2gLWHrdy23J0S7IicYB+Yf++MVI7bUORQysDVdqcM8
         RiN05dRQUHSGCBNwBFeoLEnVRNbj7bRTz1V7LX6y3XOQ7xOd6/OJvZS+tPGan6lcPyn2
         sWT+5iyqZOhRmtHxdIfhRTnoGUSCBLHXDtgZO4FNolDqi3k+MoaSWw3R4wH9+BqMH9xi
         fW7DDpY3NZv5sQEIbxIrqH+L8fnPg714HJaFFhctYhtSvrU/EN/3Yt2nOWr1336rBKB3
         7ZYOjK0+RiA3uUKVTEj8iYcTaKMAkc5zDr8J/3hCAu05JqocmJXWlSFZMBvvgyfwJYxE
         q4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744542658; x=1745147458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSg8v2veHrUXZxak/qhrNIhIgEeYWoo3lRbNC7Kvpd4=;
        b=dbMLqg+fwJXPv14F2fcsIRpzRKk4ds6TsbEchXT0RkEXOrgKW3xMqLXVcZKG0Zz4iS
         mAOfn0Lz9Z8zdK9cTzk6qhhaY3Ooh4+8s8WRjriwHmnIVMe87q/ygWcoI3pP6PCPvSJE
         Lx59tgF98w5q341LmvrsENSzmcONZsl0jbrRpnAcFmSSopcX96uK3dIBAjt6TJcUyCxu
         VzzsqtBo4YgOU39sBZRwtM74BRieRzBQ29OkKpQBSKBYur+oYOMnokWQxrhYrDDzHFxx
         v3k4RvBiHZ6ag95Cv+W1f8EUrvQbcMDe+pdFY7Uy21Y41V6Ihw5iD4DqkzOjBz9/8tLH
         A88Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHuBUXfHf5kDb4WAZBxEpRZKRLrJ5mF1S/+8/y2z+8EkqOjfW2CIYfpdaQl7jmB/aJE+ts/6gPC9wF7H0=@vger.kernel.org, AJvYcCXbToAqrveZluLB3iBn2Wy8RSFWQ8s07lGlSgbfTdaKjYqYaH54Faq/ydrv8wIDH+1IiO0Dl34L5sdbPP7q@vger.kernel.org, AJvYcCXy5X+mz1qRHMScqJDdS4vLAq4cMW2QOu6TJ8M5iujtYxIX9TwApqK2oMnrF7kciHUwxSs1eDDeRlwY@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLX5FaWr84dSCap47sVr7xcE87Zb/BIdcBvTkNyA+lW0kF2/s
	ljYrWtT4ykxFcXjzD03YsbofWi+xhqOxw75ZypweAUnHSmbpyJDk
X-Gm-Gg: ASbGncvYfrPyPkLia6viSuEBYBFGYYBF0LtbX+fDPsQlW9ipksmabdoBR1wEIWiFA1j
	G9OHjDSeSKdHewwh25PYuCKG17i/whz+wCcp+s+TDoOvmSUuOyZTYXihzJ2MSCu3DjhcCJkyxn7
	Uul4PvlPcchDniIgO5Lz92p7FMJehPMpetg0LrhTD2q5HKIf7VFP6R9FKyOvkh12WQB8q2OOYdO
	9WBSWHZzpRSbuFw4kZX5o+VIyBqWlF/U1pRNcsap+EGpH7BLsw+ck3v469Bwx7xqwUqHSutN7Ik
	BVGrIJbyqHi63AgycZE8SmX7qaerZnWb
X-Google-Smtp-Source: AGHT+IEUyaSqL6aJK/Bk5g+YWAAxBTRamCCY1A2wzNn9aXdZX/dOkfVy8fX3ADb5Jb1gQmHmU6o9CQ==
X-Received: by 2002:a17:907:3d0f:b0:ac8:1e67:9474 with SMTP id a640c23a62f3a-acabbeb6eb1mr1207383466b.3.1744542657910;
        Sun, 13 Apr 2025 04:10:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be98d4sm728571266b.59.2025.04.13.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 04:10:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/4] power/supply: Add driver for Pegatron Chagall battery
Date: Sun, 13 Apr 2025 14:10:32 +0300
Message-ID: <20250413111033.11408-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413111033.11408-1-clamor95@gmail.com>
References: <20250413111033.11408-1-clamor95@gmail.com>
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
 drivers/power/supply/chagall-battery.c | 308 +++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
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
index 000000000000..1a278331efe7
--- /dev/null
+++ b/drivers/power/supply/chagall-battery.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+static void chagall_leds_status_update(struct chagall_battery_data *cg, int state)
+{
+	switch (state) {
+	case POWER_SUPPLY_STATUS_FULL:
+		led_set_brightness(&cg->amber_led, LED_OFF);
+		led_set_brightness(&cg->white_led,  LED_ON);
+		break;
+
+	case POWER_SUPPLY_STATUS_CHARGING:
+		led_set_brightness(&cg->white_led, LED_OFF);
+		led_set_brightness(&cg->amber_led,  LED_ON);
+		break;
+
+	default:
+		led_set_brightness(&cg->amber_led, LED_OFF);
+		led_set_brightness(&cg->white_led, LED_OFF);
+		break;
+	}
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
+	[POWER_SUPPLY_PROP_TEMP] = CHAGALL_REG_BATTERY_TEMPERATURE,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = CHAGALL_REG_BATTERY_VOLTAGE,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = CHAGALL_REG_BATTERY_CURRENT,
+	[POWER_SUPPLY_PROP_CAPACITY] = CHAGALL_REG_BATTERY_CAPACITY,
+	[POWER_SUPPLY_PROP_CURRENT_MAX] = CHAGALL_REG_BATTERY_CHARGING_CURRENT,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = CHAGALL_REG_BATTERY_CHARGING_VOLTAGE,
+	[POWER_SUPPLY_PROP_STATUS] = CHAGALL_REG_BATTERY_STATUS,
+	[POWER_SUPPLY_PROP_CHARGE_NOW] = CHAGALL_REG_BATTERY_REMAIN_CAPACITY,
+	[POWER_SUPPLY_PROP_CHARGE_FULL] = CHAGALL_REG_BATTERY_FULL_CAPACITY,
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
+			if (val->intval & BATTERY_FULL_CHARGED)
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else if (val->intval & BATTERY_FULL_DISCHARGED)
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			else if (val->intval & BATTERY_DISCHARGING)
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
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
+	if (state & BATTERY_FULL_CHARGED)
+		state = POWER_SUPPLY_STATUS_FULL;
+	else if (state & BATTERY_DISCHARGING)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+	else
+		state = POWER_SUPPLY_STATUS_CHARGING;
+
+	if (cg->last_state != state) {
+		cg->last_state = state;
+		power_supply_changed(cg->battery);
+	}
+
+	chagall_leds_status_update(cg, state);
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
+		return dev_err_probe(dev, PTR_ERR(cg->battery), "failed to register power supply\n");
+
+	cg->amber_led.name = "power::amber";
+	cg->amber_led.max_brightness = 1;
+	cg->amber_led.flags = LED_CORE_SUSPENDRESUME;
+	cg->amber_led.brightness_set = chagall_led_set_brightness_amber;
+
+	ret = devm_led_classdev_register(dev, &cg->amber_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register amber LED\n");
+
+	cg->white_led.name = "power::white";
+	cg->white_led.max_brightness = 1;
+	cg->white_led.flags = LED_CORE_SUSPENDRESUME;
+	cg->white_led.brightness_set = chagall_led_set_brightness_white;
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
+	return 0;
+}
+
+static int __maybe_unused chagall_battery_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct chagall_battery_data *cg = i2c_get_clientdata(client);
+
+	cancel_delayed_work_sync(&cg->poll_work);
+	return 0;
+}
+
+static int __maybe_unused chagall_battery_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct chagall_battery_data *cg = i2c_get_clientdata(client);
+
+	schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));
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
2.43.0


