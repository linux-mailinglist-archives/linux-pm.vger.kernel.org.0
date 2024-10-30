Return-Path: <linux-pm+bounces-16777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D299B6EFB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69D61C21B32
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D421A710;
	Wed, 30 Oct 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx2BFkKr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F515219CBB;
	Wed, 30 Oct 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323864; cv=none; b=lij4wnEZLcEDD6Q4JcvbKckUgyYz+Teyp5hSNxJ/QSzGD20MwvwwkSm3Lz5m3AmdKSUPdgrZkqaF0uq2S4P97KRLNo6Gg9FhaBltcFjdEzSYzFVc5AaAslE3dK3ITne+rUIx6uWyvX2WON8gzbEVurYOFcKvrQHqfsayYOglCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323864; c=relaxed/simple;
	bh=TtolUFToQLvjN+1MKw9O6QOw3JMP6euhZQNjPcbws5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTYi5sZ9u4Ypjn7mAeyteKeYFEBJjMDjMdRJNE7knrh/aVOSFUQGllB7rrKW8i4jE7zoQH494fQa8FfmlntoWdaY6+RGLc0CXIfgG0nxDf3O0EmND68lQMqhDsGk7nDoYV1IGG60pLxkMdc+UgYChbp2rWTkbFw/X0oVp8HsbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx2BFkKr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso3151885e9.0;
        Wed, 30 Oct 2024 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323859; x=1730928659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOXDf5pSXjmqA3hw+YKSRVac8nthbz+as2AXECsjOII=;
        b=gx2BFkKrnhasaeN8Z51Moyte6NMFIZY4Yak/+Tt4J4J1LmWM3fhai7BPeOSEVJOjaI
         Ok5+XqJTdKUa4UoVM7hv2mwojv6ph8snyr8j9eogXvO4x0XeUgonJA9AWHab05GkeZmH
         0jib0Xo/MZ+8ERz9hWcmci7FvUGjm4kCROGKJ+WnF68uXSPxzsDur3KHl9CZSBbMDvFn
         aaF8yWl1Vvby70y56R6gO1ZwMA4ywruxBaRYIgEQ6nvdVhbS19xM/LZ6PjYycLI96Aup
         7KgL5y3xUsWQoi/N2WEPypWPqpgrpFqT9RqF8gLc8DyLUlU50h0ddSW/DWXRiPVMoHP2
         0kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323859; x=1730928659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOXDf5pSXjmqA3hw+YKSRVac8nthbz+as2AXECsjOII=;
        b=X0qitq130i6e0NH84ycr/3yNQxOdrhcig7+mdruxcBdrjm4fqOitqoP6o+xmmdD8uC
         UGfFn+01YspdTpfDa1ibP79ySmgys2VtCUIH/kPtWFZRG+0emlIvraB8xwEgYMA1/AmF
         dh8k6e4Htq8TNatmkjrz/UFSRQ4WTXi2UClb63a3mlEzdcugLWELPlG+lIolTv6Q+PZ8
         /RcRJLbDcO4+XgVmUWUc7P7bNbSjpQUXUHLSViaEPhxyM2kREMrl8zDJ56qTnLBjGmlj
         Pl86qoIat7WR6+G+I3k1Wg1183tEaq0YqNU2M9pbP7v5gqym8LDlKW0491Qp2kdSHp0/
         CqPg==
X-Forwarded-Encrypted: i=1; AJvYcCUA4rHRIc2GAFT5AnQFCWyIvevE0KfFFtzi0j5CG4QGJ0DUBppploOENi09wDMFBLM9gIAE7ncetSvF@vger.kernel.org, AJvYcCUng064Ts71fN3K5HgD+agt25Ty4mPoTZ5Qf9aYzq4Q7BcrqpURRdq8ZoH6vDKTBo7IKG7AA7uECn9u72Fd@vger.kernel.org, AJvYcCWg+ckmC5AvSukc6dQnvS7lLyAZEBbZK89AboCY+QxGl+PbV68MzpnaLttpiO8F5jv5BMl2B/H//sqMCw==@vger.kernel.org, AJvYcCWyAwdo7Ua3KyCQ/O97JxYqnCPY2MoDDJuITMtm4T8m4FWxmjqX3ZPFzwTeNuHpzx6vK88H/1MN4jyVO0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5z2lGCTURdEiz1jVwUyMqHBx6iZJa6qhbhpAwVzI9QlJ8v/4k
	qfVoaDVF2o4F2xK17KR3J2oz7ABGvzVXSeCJeZiR3snl69a7EZtf
X-Google-Smtp-Source: AGHT+IHekXYr+Efv0kHGOXxVG/E9noIFAUcpeI9neCG6qK8PTvQZamcuUEeiuiPqMzHY6aaskVoffA==
X-Received: by 2002:a05:600c:4e86:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-4319acacd75mr220949295e9.17.1730323859346;
        Wed, 30 Oct 2024 14:30:59 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5410sm687266b.57.2024.10.30.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:30:58 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 31 Oct 2024 00:30:41 +0300
Subject: [PATCH v8 6/7] power: supply: max77705: Add fuel gauge driver for
 Maxim 77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-starqltechn_integration_upstream-v8-6-2fa666c2330e@gmail.com>
References: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
In-Reply-To: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730323840; l=16197;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=TtolUFToQLvjN+1MKw9O6QOw3JMP6euhZQNjPcbws5I=;
 b=eXE6YPQBFHDI6ziG43ysiW2RH8Kpb098ORYiTSFZlUOLFykCeCG2eY4BYtH3Zo2OqLLvMaD8f
 mXULFPGeQYvB+EuwbaAjiO0wZZ+cG4Mpn1SvzICErN9DNxXtARx4pAS
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add driver for Maxim 77705 fuel gauge (part of max77705 PMIC)
providing power supply class information to userspace.

The driver is configured through DTS (battery and system related
settings).

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for v8:
- join line where possible to fit in 100 chars
- change comment style C++ -> C
- fix kernel-doc comments

Changes for v6:
- add i2c init in driver
- initialize unintialized ret value with 0
- remove unused CAPACITY_SCALE_* constants
- max77705_*_convert: replace multiplication and divison with
  mult_frac helper to fix https://lore.kernel.org/oe-kbuild-all/202410111913.5ADtNHNM-lkp@intel.com/
- max77705_battery_settings: move out battery settings gathering and rename function
- probe: do regmap setup last, because if power_supply_get_battery_info
  fails, we're going to probe again and fail with i2c bus busy error
- remove MFD from commit message

Changes for v5:
- fix license
- use same hardware name in Kconfig and module descriptions
- fix email, and module author

Changes for v4:
- rework driver from scratch
- change word delimiters in filenames to "_"
- remove debugfs code
- cleanup header
---
 drivers/power/supply/Kconfig               |   7 +++
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/max77705_fuel_gauge.c | 363 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_fuelgauge.h   |  71 +++++++++++++++++++++++++++
 4 files changed, 442 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 66264036b65d..9a3b17036ddc 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -589,6 +589,13 @@ config CHARGER_MAX77705
 	help
 	  Say Y to enable support for the Maxim MAX77705 battery charger.
 
+config FUEL_GAUGE_MAX77705
+	tristate "Maxim MAX77705 fuel gauge driver"
+	depends on MFD_MAX77705
+	default n
+	help
+	  Say Y to enable support for MAXIM MAX77705 fuel gauge driver.
+
 config CHARGER_MAX77976
 	tristate "Maxim MAX77976 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 85d65b7aee1c..997049fc1795 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
 obj-$(CONFIG_CHARGER_MAX77705)	+= max77705_charger.o
+obj-$(CONFIG_FUEL_GAUGE_MAX77705)	+= max77705_fuel_gauge.o
 obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
diff --git a/drivers/power/supply/max77705_fuel_gauge.c b/drivers/power/supply/max77705_fuel_gauge.c
new file mode 100644
index 000000000000..43feeb77b47a
--- /dev/null
+++ b/drivers/power/supply/max77705_fuel_gauge.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail>
+ *
+ * Fuel gauge driver for MAXIM 77705 charger/power-supply.
+ */
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max77693-common.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/power/max77705_fuelgauge.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define I2C_ADDR_FG     0x36
+
+static const char *max77705_fuelgauge_model		= "max77705";
+static const char *max77705_fuelgauge_manufacturer	= "Maxim Integrated";
+
+static const struct regmap_config max77705_fg_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77705_FG_END,
+};
+
+static enum power_supply_property max77705_fuelgauge_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+};
+
+static int max77705_fg_read_reg(struct max77705_fuelgauge_data *fuelgauge,
+				unsigned int reg, unsigned int *val)
+{
+	struct regmap *regmap = fuelgauge->regmap;
+	u8 data[2];
+	int ret;
+
+	ret = regmap_noinc_read(regmap, reg, data, sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	*val = (data[1] << 8) + data[0];
+
+	return 0;
+}
+
+static int max77705_fg_read_temp(struct max77705_fuelgauge_data *fuelgauge,
+				 int *val)
+{
+	struct regmap *regmap = fuelgauge->regmap;
+	u8 data[2] = { 0, 0 };
+	int ret, temperature = 0;
+
+	ret = regmap_noinc_read(regmap, TEMPERATURE_REG, data, sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	if (data[1] & BIT(7))
+		temperature = ((~(data[1])) & 0xFF) + 1;
+	else
+		temperature = data[1] & 0x7f;
+
+	temperature *= 10;
+	temperature += data[0] * 10 / 256;
+	*val = temperature;
+
+	return 0;
+}
+
+static int max77705_fg_check_battery_present(struct max77705_fuelgauge_data
+					     *fuelgauge, int *val)
+{
+	struct regmap *regmap = fuelgauge->regmap;
+	u8 status_data[2];
+	int ret;
+
+	ret = regmap_noinc_read(regmap, STATUS_REG, status_data, sizeof(status_data));
+	if (ret < 0)
+		return ret;
+
+	*val = !(status_data[0] & MAX77705_BAT_ABSENT_MASK);
+
+	return 0;
+}
+
+static int max77705_battery_get_status(struct max77705_fuelgauge_data *fuelgauge,
+					int *val)
+{
+	int current_now;
+	int am_i_supplied;
+	int ret;
+	unsigned int soc_rep;
+
+	am_i_supplied = power_supply_am_i_supplied(fuelgauge->psy_fg);
+	if (am_i_supplied) {
+		if (am_i_supplied == -ENODEV) {
+			dev_err(fuelgauge->dev,
+				"power supply not found, fall back to current-based method\n");
+		} else {
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+			return 0;
+		}
+	}
+	ret = max77705_fg_read_reg(fuelgauge, SOCREP_REG, &soc_rep);
+	if (ret)
+		return ret;
+
+	if (soc_rep < 100) {
+		ret = max77705_fg_read_reg(fuelgauge, CURRENT_REG, &current_now);
+		if (ret)
+			return ret;
+
+		if (current_now > 0)
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+		else if (current_now < 0)
+			*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	} else {
+		*val = POWER_SUPPLY_STATUS_FULL;
+	}
+
+	return 0;
+}
+
+static void max77705_unit_adjustment(struct max77705_fuelgauge_data *fuelgauge,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	const unsigned int base_unit_conversion = 1000;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		val->intval = max77705_fg_vs_convert(val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = max77705_fg_cs_convert(val->intval,
+						     fuelgauge->rsense_conductance);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval *= base_unit_conversion;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = min(val->intval, 100);
+		break;
+	default:
+		dev_dbg(fuelgauge->dev,
+			"%s: no need for unit conversion %d\n", __func__, psp);
+	}
+}
+
+static int max77705_fg_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct max77705_fuelgauge_data *fuelgauge =
+	    power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = max77705_battery_get_status(fuelgauge, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = max77705_fg_check_battery_present(fuelgauge, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, VCELL_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		ret = max77705_fg_read_reg(fuelgauge, VFOCV_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		ret = max77705_fg_read_reg(fuelgauge, AVR_VCELL_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, CURRENT_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		ret = max77705_fg_read_reg(fuelgauge, AVG_CURRENT_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, REMCAP_REP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = max77705_fg_read_reg(fuelgauge, FULLCAP_REP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = max77705_fg_read_reg(fuelgauge, DESIGNCAP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = max77705_fg_read_reg(fuelgauge, SOCREP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = max77705_fg_read_temp(fuelgauge, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, TIME_TO_EMPTY_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, TIME_TO_FULL_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		ret = max77705_fg_read_reg(fuelgauge, CYCLES_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = max77705_fuelgauge_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max77705_fuelgauge_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	max77705_unit_adjustment(fuelgauge, psp, val);
+
+	return 0;
+}
+
+static const struct power_supply_desc max77705_fg_desc = {
+	.name = "max77705-fuel-gauge",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = max77705_fuelgauge_props,
+	.num_properties = ARRAY_SIZE(max77705_fuelgauge_props),
+	.get_property = max77705_fg_get_property,
+};
+
+static int max77705_fg_set_charge_design(struct regmap *regmap, int value)
+{
+	u8 data[2];
+	int value_mah;
+
+	value_mah = value / 1000;
+	data[0] = value_mah & 0xFF;
+	data[1] = (value_mah >> 8) & 0xFF;
+
+	return regmap_noinc_write(regmap, DESIGNCAP_REG, data, sizeof(data));
+}
+
+static int max77705_write_bat_info(struct max77705_fuelgauge_data *fuelgauge)
+{
+	struct power_supply_battery_info *info = fuelgauge->bat_info;
+
+	if (info->energy_full_design_uwh != info->charge_full_design_uah) {
+		if (info->charge_full_design_uah == -EINVAL)
+			dev_warn(fuelgauge->dev, "missing battery:charge-full-design-microamp-hours\n");
+		return max77705_fg_set_charge_design(fuelgauge->regmap,
+						info->charge_full_design_uah);
+	}
+
+	return 0;
+}
+
+static int max77705_fuelgauge_parse_dt(struct max77705_fuelgauge_data
+				       *fuelgauge)
+{
+	struct device *dev = fuelgauge->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+	unsigned int rsense;
+
+	if (!np) {
+		dev_err(dev, "no fuelgauge OF node\n");
+		return -EINVAL;
+	}
+	ret = of_property_read_u32(np, "shunt-resistor-micro-ohms",
+				   &rsense);
+	if (ret < 0) {
+		dev_warn(dev, "No shunt-resistor-micro-ohms property, assume default\n");
+		fuelgauge->rsense_conductance = 100;
+	} else
+		fuelgauge->rsense_conductance = 1000000 / rsense; /* rsense conductance in Ohm^-1 */
+
+	return 0;
+}
+
+static int max77705_fuelgauge_probe(struct platform_device *pdev)
+{
+	struct i2c_client *i2c_fg;
+	struct max77693_dev *max77705 = dev_get_drvdata(pdev->dev.parent);
+	struct max77705_fuelgauge_data *fuelgauge;
+	struct power_supply_config fuelgauge_cfg = { };
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+
+	fuelgauge = devm_kzalloc(dev, sizeof(*fuelgauge), GFP_KERNEL);
+	if (!fuelgauge)
+		return -ENOMEM;
+
+	fuelgauge->dev = dev;
+
+	ret = max77705_fuelgauge_parse_dt(fuelgauge);
+	if (ret < 0)
+		return ret;
+
+	fuelgauge_cfg.drv_data = fuelgauge;
+	fuelgauge_cfg.of_node = fuelgauge->dev->of_node;
+
+	fuelgauge->psy_fg = devm_power_supply_register(&pdev->dev,
+							&max77705_fg_desc,
+							&fuelgauge_cfg);
+
+	if (IS_ERR(fuelgauge->psy_fg))
+		return PTR_ERR(fuelgauge->psy_fg);
+
+	ret = power_supply_get_battery_info(fuelgauge->psy_fg,
+					&fuelgauge->bat_info);
+
+	if (ret)
+		return ret;
+
+	i2c_fg = devm_i2c_new_dummy_device(max77705->dev, max77705->i2c->adapter, I2C_ADDR_FG);
+
+	if (IS_ERR(i2c_fg))
+		return PTR_ERR(i2c_fg);
+
+	fuelgauge->regmap = devm_regmap_init_i2c(i2c_fg, &max77705_fg_regmap_config);
+
+	return max77705_write_bat_info(fuelgauge);
+}
+
+static const struct of_device_id max77705_fg_of_match[] = {
+	{ .compatible = "maxim,max77705-fuel-gauge" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77705_fg_of_match);
+
+static struct platform_driver max77705_fuelgauge_driver = {
+	.driver = {
+		.name = "max77705-fuel-gauge",
+		.of_match_table = max77705_fg_of_match,
+	},
+	.probe = max77705_fuelgauge_probe,
+};
+module_platform_driver(max77705_fuelgauge_driver);
+
+MODULE_DESCRIPTION("Maxim MAX77705 Fuel Gauge Driver");
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/power/max77705_fuelgauge.h b/include/linux/power/max77705_fuelgauge.h
new file mode 100644
index 000000000000..4c9f0f38f773
--- /dev/null
+++ b/include/linux/power/max77705_fuelgauge.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
+ *
+ * Fuel gauge driver header for MAXIM 77705 charger/power-supply.
+ */
+
+#ifndef __MAX77705_FUELGAUGE_H
+#define __MAX77705_FUELGAUGE_H __FILE__
+
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+
+#define ALERT_EN			4
+/*
+ * Current and capacity values are displayed as a voltage
+ * and must be divided by the sense resistor to determine Amps or Amp-hours.
+ * This should be applied to all current, charge, energy registers,
+ * except ModelGauge m5 Algorithm related ones.
+ * current sense resolution
+ */
+#define MAX77705_FG_CS_ADC_RESOLUTION	15625 /* 1.5625 microvolts */
+/* voltage sense resolution */
+#define MAX77705_FG_VS_ADC_RESOLUTION	78125 /* 78.125 microvolts */
+/* CONFIG_REG register */
+#define MAX77705_SOC_ALERT_EN_MASK	BIT(2)
+/* When set to 1, external temperature measurements should be written from the host */
+#define MAX77705_TEX_MASK		BIT(8)
+/* Enable Thermistor */
+#define MAX77705_ETHRM_MASK		BIT(5)
+/* CONFIG2_REG register */
+#define MAX77705_AUTO_DISCHARGE_EN_MASK BIT(9)
+/* STATUS_REG register */
+#define MAX77705_BAT_ABSENT_MASK	BIT(3)
+
+/**
+ * max77705_fg_vs_convert() - Convert voltage register value to micro volts.
+ *
+ * @reg_val: Register value.
+ *
+ * Return: Voltage in micro Volts.
+ */
+inline u64 max77705_fg_vs_convert(u16 reg_val)
+{
+	return mult_frac(reg_val, MAX77705_FG_VS_ADC_RESOLUTION, 1000);
+}
+
+/**
+ * max77705_fg_cs_convert() - Convert current register value to micro volts.
+ *
+ * @reg_val: Register value.
+ * @rsense_conductance: Current sense resistor conductance in Ohm^-1.
+ *
+ * Return: Current in micro Volts.
+ */
+inline s32 max77705_fg_cs_convert(s16 reg_val, u32 rsense_conductance)
+{
+	return mult_frac(reg_val * rsense_conductance, MAX77705_FG_CS_ADC_RESOLUTION,
+			 10000);
+}
+
+struct max77705_fuelgauge_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy_fg;
+	struct power_supply_battery_info *bat_info;
+	u32 rsense_conductance;
+};
+
+#endif /* __MAX77705_FUELGAUGE_H */

-- 
2.39.2


