Return-Path: <linux-pm+bounces-24433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3CA6CE3A
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 08:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB03B6664
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65532036FB;
	Sun, 23 Mar 2025 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/k7iy2+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B0202C39;
	Sun, 23 Mar 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714098; cv=none; b=fKO21J/3NYpdlJ5ZYV9l7KtB30lHstZOC/x4ArofzxTFxe3NyAyJBvtx7pzcw07LWUwaIFiHeJF+EaUkwG8ZhdGfsmB/XmOkqHruycY7YXBvh7ErZ+Iz2pA6tRVRzrwI9+MchYZZMnbYqMkneQ3p6uys8L1866oM2CVOu2LnJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714098; c=relaxed/simple;
	bh=WRrSA50y3u7WzP72Iuo1EO/GfQTRCZVJkp8p0OdO1lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urbHf3eu08uIGvAcinSZricVfFdNkwK4wbn+Z/tps+6FRhlV17V9lCmMt5fxMI9SFeXZTptdjPVyAe0sZRnjwxA/Pf9fZec+XeBoe/osUgb2wblSk2oj0FlRY+EDUmGJc2EoyWdFvPA1ztoWHjBH3cw54WcNvGHpxOjRai6aHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/k7iy2+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so5935512a12.2;
        Sun, 23 Mar 2025 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742714094; x=1743318894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSg8v2veHrUXZxak/qhrNIhIgEeYWoo3lRbNC7Kvpd4=;
        b=i/k7iy2+tluknrGB+eB8FoJIxaGPi7glmpgFn2reYrsVSqinhZX0IOIA7BHQAkdKJS
         oQLB8QBrENJSq3LdtDZwm2jRb58UL7nVhOS7ikSlYGHnWbjgP+bI7Klk86evTU6XbWRS
         xTVvVFuXp1I3p19NdGGvSnk2acvZD5Gqq3b0Vjak8PLwlFcHngqgyXguUeLW0JmzCmLL
         RZDtWP76mqIU2pmRVQaf3XRi9fbDKwlyiQilSsGKimqVBBq2QB69xLFMbv7r11mV59xH
         LP5dKCu4NjkKabpjQgtLuAhQcnLamj1kOBErJrNaCKg1q0F0+99DMdn/Sx2ofBHxvwqh
         9Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742714094; x=1743318894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSg8v2veHrUXZxak/qhrNIhIgEeYWoo3lRbNC7Kvpd4=;
        b=NuAqlyCjkdTGLdSToBrSmhjjMBF48oVafaMz3hm/57rqIX62NFb17vIVQkJVwwjb5Q
         7rmNpom0Y0zonpT2WFjMpQq6SQEPBlhRJoqj7G/eimIuJ/lPEBiYvRsTXjf+BwRH4okA
         qBbp9ksduIoHu3pRJXQ6Lg31ZjMcFFcTuK17A/Ao/+HKSHB50q5tCdxa3oIrdt276gZJ
         LUBsARyw7tmItM+fkyKC3AONUQpPke+vJRpxdUB/1cdcsGXxT7IhpMj+0GMhraq6qGQ1
         p4RB7jiKEPLZJmGpM+30VrZCCvljQNfUud6S6Egb54xVJCV1ngrZjiKqAArC48/R6h3B
         rqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+fVHSTHRCAgK7SHeoxRIZJd/i81+/P0BBOajWIuJMd/Rm3D+4gN7wlTITd6GAZ5HSM+VSFxIwIBYYSI0=@vger.kernel.org, AJvYcCVioyVD3l5526vVVFcZojoKYCJz7ouPTubdzqJ43ZF1KKq3c+9sgUkBmGwfL5wJXkpcOPRJH4QVnKQ=@vger.kernel.org, AJvYcCXrnG7U6gq6Wk+g1T/dK4SdziJzR14gaZ8NtxlZklfXaM4c5TgCvc3RyrFnWhpnhZYhX0cbY3Slgf3ayiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADnoH749z4DoBbilhxkCdh2szg6S43AvBWZb0otGywUkfHbrh
	h1IK5zLJFgZ4AT4COcxYrEtgfB+AXGYFBDhdPrTPQqse/gg7RidF
X-Gm-Gg: ASbGncsRmtWbgpYWdibZafVQQhd+9x1TCbY7tCDJFCLLutvC7/PbCgGlheqLLB/P/Po
	bD68BF7/iJp+MrIYeLQCfNHlqsoVeViF7JBPvfXuQyqv8tK4c7g4OaDxgj0eApfmT8i7nQ8iyua
	vNYc3TwJdTLIZuzQahhM3C9atDxkIolPEfy2dGCuelifXjsv7bBgYfRrlI0AbFg7Fv6RithD6eJ
	lgOPID6P1YBTkWTdmD33mEVQ/eta5CNSfRNu51Xh9+2Ansq3mXuMLfAr+zwIb26l4dh/h/78Ojk
	TPfilf0LOZl7sHrVEIwd84VAIsYy2QFFWLEB
X-Google-Smtp-Source: AGHT+IFApD761jQAXGhTGK/msqA+/A3HLe3e4xYkIn4DzR8q3nCb9rTaSF7rKsiPu2i5ZLE6Nn0ljA==
X-Received: by 2002:a05:6402:42cb:b0:5e4:c026:2d7a with SMTP id 4fb4d7f45d1cf-5ebcd474182mr6877637a12.16.1742714094241;
        Sun, 23 Mar 2025 00:14:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfaecfbsm4218283a12.41.2025.03.23.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:14:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 3/4] power/supply: Add driver for Pegatron Chagall battery
Date: Sun, 23 Mar 2025 09:14:23 +0200
Message-ID: <20250323071424.48779-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323071424.48779-1-clamor95@gmail.com>
References: <20250323071424.48779-1-clamor95@gmail.com>
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


