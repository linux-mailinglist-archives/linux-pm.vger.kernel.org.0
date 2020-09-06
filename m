Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8816925F0AE
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 23:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIFVbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgIFVb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 17:31:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4475C061574;
        Sun,  6 Sep 2020 14:31:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so13390107wrs.11;
        Sun, 06 Sep 2020 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTTRbJivtlQ5gt6j1KecF3BBWQzLJC72CCbJTpZ8lTM=;
        b=o2ep7BTdrSAH4Ej5X1k3X/M8zJlIHTL5c/LycFUCwTJ9JGt5uJY53vB8aQn4ThFW/S
         KnAvFWSt9LHJHyVDLX6pq6eoRWnCWr0fKKdhXVB3TuCXZ3IvZ80kLrILd2+PCQW33c0v
         usRg1pxjgN0gDCPRwlCYEzpbQeDtJ/95/2VDLYRlGHGLAdd1jRw3eUows+9UIWiLQf3B
         Tz5KwU+ft4iBMuUr46+EWiq6qjRK385NFzpA2jrxRmZYcdJiWks0mPgl3T1NsIiPTb0e
         8QHX1X6jk6o8Tg/4oFc6lp2aChN2th3kdE0biq3kbYvQEzdcKvcS4n0Dx1eTOzZKrW3t
         4/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTTRbJivtlQ5gt6j1KecF3BBWQzLJC72CCbJTpZ8lTM=;
        b=HvlY37BTbJYPhCtfvk2+lyEG2ErC8KLonFMAImcs1uQASslOFPIZpei89AV4P1P48A
         P1IolPL38BG7f0LlGmHUowJeYyXI5LpYYpowvE3BDfLUAkrm1DzNigMW3fVwjfFPkIWX
         KhJbdlpWeUDm1HeNJdmHRb7dGwgws1bC/CsGm7MWAkPuxlhj81CSkIPVJ7UIPsloHwlF
         jUup4OPNhvIyy0YTMgr6J+hAiyMobaII2DKrI0q8iwpknXNFnTXI7qwt81EGg+twOwfj
         dVO3++mTK+T2FEMuVLXorjHYz1IV6Hf+EixRDvGfBWrFKNrtCQ/iWVSUVnHoW/0THJOz
         zk1Q==
X-Gm-Message-State: AOAM530XfHwwnlX8iB3f+QCyCzc/e0FXG2AirEp5Zw+UVCGC41/svaPR
        o/1zaovfQnTG1YgsAp6+JR4=
X-Google-Smtp-Source: ABdhPJy81ZmlUskkLijdoJuZfemQIhhLX/P0IJYgQ5abidjeN8vc6z/94uovG5SVyp2LEUymr7L1jQ==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr18265444wrr.273.1599427885137;
        Sun, 06 Sep 2020 14:31:25 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id h17sm19982249wro.27.2020.09.06.14.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 14:31:24 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v4 4/7] power: supply: max17040: Support compatible devices
Date:   Mon,  7 Sep 2020 00:30:53 +0300
Message-Id: <20200906213056.2161410-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906213056.2161410-1-iskren.chernev@gmail.com>
References: <20200906213056.2161410-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The max17040 fuel gauge is part of a family of 8 chips that have very
similar mode of operations and registers.

This change adds:
- compatible strings for all supported devices and handling for the
  minor differences between them;
- handling for devices reporting double capacity via maxim,double-soc;

The datasheets of the supported devices are linked [0] [1] [2] [3].

[0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
[1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
[2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
[3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Tested-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/Kconfig            |  10 +-
 drivers/power/supply/max17040_battery.c | 154 +++++++++++++++++++++---
 2 files changed, 142 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 1e11a44077dde..f51ae86788ded 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -369,9 +369,13 @@ config BATTERY_MAX17040
 	depends on I2C
 	select REGMAP_I2C
 	help
-	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
-	  in handheld and portable equipment. The MAX17040 is configured
-	  to operate with a single lithium cell
+	  Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
+	  (Li+) batteries in handheld and portable equipment, including
+	  max17040, max17041, max17043, max17044, max17048, max17049, max17058,
+	  max17059. It is also included in some batteries like max77836.
+
+	  Driver supports reporting SOC (State of Charge, i.e capacity),
+	  voltage and configurable low-SOC wakeup interrupt.
 
 config BATTERY_MAX17042
 	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index fae4217960761..3d5003e3a277a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
+#include <linux/of_device.h>
 #include <linux/max17040_battery.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -33,12 +34,92 @@
 #define MAX17040_ATHD_MASK		0x3f
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
 
+enum chip_id {
+	ID_MAX17040,
+	ID_MAX17041,
+	ID_MAX17043,
+	ID_MAX17044,
+	ID_MAX17048,
+	ID_MAX17049,
+	ID_MAX17058,
+	ID_MAX17059,
+};
+
+/* values that differ by chip_id */
+struct chip_data {
+	u16 reset_val;
+	u16 vcell_shift;
+	u16 vcell_mul;
+	u16 vcell_div;
+	u8  has_low_soc_alert;
+};
+
+static struct chip_data max17040_family[] = {
+	[ID_MAX17040] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 1250,
+		.vcell_div = 1,
+		.has_low_soc_alert = 0,
+	},
+	[ID_MAX17041] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 2500,
+		.vcell_div = 1,
+		.has_low_soc_alert = 0,
+	},
+	[ID_MAX17043] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 1250,
+		.vcell_div = 1,
+		.has_low_soc_alert = 1,
+	},
+	[ID_MAX17044] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 2500,
+		.vcell_div = 1,
+		.has_low_soc_alert = 1,
+	},
+	[ID_MAX17048] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 8,
+		.has_low_soc_alert = 1,
+	},
+	[ID_MAX17049] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 4,
+		.has_low_soc_alert = 1,
+	},
+	[ID_MAX17058] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 8,
+		.has_low_soc_alert = 1,
+	},
+	[ID_MAX17059] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 4,
+		.has_low_soc_alert = 1,
+	},
+};
+
 struct max17040_chip {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
 	struct delayed_work		work;
 	struct power_supply		*battery;
 	struct max17040_platform_data	*pdata;
+	struct chip_data		data;
 
 	/* battery capacity */
 	int soc;
@@ -46,27 +127,37 @@ struct max17040_chip {
 	int status;
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert;
+	/* some devices return twice the capacity */
+	bool quirk_double_soc;
 };
 
 static int max17040_reset(struct max17040_chip *chip)
 {
-	return regmap_write(chip->regmap, MAX17040_CMD, 0x0054);
+	return regmap_write(chip->regmap, MAX17040_CMD, chip->data.reset_val);
 }
 
 static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
 {
-	level = 32 - level;
+	level = 32 - level * (chip->quirk_double_soc ? 2 : 1);
 	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
 			MAX17040_ATHD_MASK, level);
 }
 
+static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
+{
+	struct chip_data *d = &chip->data;
+
+	return (vcell >> d->vcell_shift) * d->vcell_mul / d->vcell_div;
+}
+
+
 static int max17040_get_vcell(struct max17040_chip *chip)
 {
 	u32 vcell;
 
 	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
 
-	return (vcell >> 4) * 1250;
+	return max17040_raw_vcell_to_uvolts(chip, vcell);
 }
 
 static int max17040_get_soc(struct max17040_chip *chip)
@@ -75,7 +166,7 @@ static int max17040_get_soc(struct max17040_chip *chip)
 
 	regmap_read(chip->regmap, MAX17040_SOC, &soc);
 
-	return soc >> 8;
+	return soc >> (chip->quirk_double_soc ? 9 : 8);
 }
 
 static int max17040_get_version(struct max17040_chip *chip)
@@ -116,12 +207,16 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
 
+	chip->quirk_double_soc = device_property_read_bool(dev,
+							   "maxim,double-soc");
+
 	chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
 	device_property_read_u32(dev,
 				 "maxim,alert-low-soc-level",
 				 &chip->low_soc_alert);
 
-	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
+	if (chip->low_soc_alert <= 0 ||
+	    chip->low_soc_alert > (chip->quirk_double_soc ? 16 : 32)) {
 		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
 		return -EINVAL;
 	}
@@ -219,8 +314,9 @@ static int max17040_set_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
-		/* alert threshold can be programmed from 1% up to 32% */
-		if ((val->intval < 1) || (val->intval > 32)) {
+		/* alert threshold can be programmed from 1% up to 16/32% */
+		if ((val->intval < 1) ||
+		    (val->intval > (chip->quirk_double_soc ? 16 : 32))) {
 			ret = -EINVAL;
 			break;
 		}
@@ -293,6 +389,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	enum chip_id chip_id;
 	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
@@ -305,9 +402,14 @@ static int max17040_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
 	chip->pdata = client->dev.platform_data;
-	ret = max17040_get_of_data(chip);
-	if (ret)
-		return ret;
+	chip_id = (enum chip_id) id->driver_data;
+	if (client->dev.of_node) {
+		ret = max17040_get_of_data(chip);
+		if (ret)
+			return ret;
+		chip_id = (enum chip_id) of_device_get_match_data(&client->dev);
+	}
+	chip->data = max17040_family[chip_id];
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -324,11 +426,11 @@ static int max17040_probe(struct i2c_client *client,
 		return ret;
 	dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", ret);
 
-	max17040_reset(chip);
+	if (chip_id == ID_MAX17040 || chip_id == ID_MAX17041)
+		max17040_reset(chip);
 
 	/* check interrupt */
-	if (client->irq && of_device_is_compatible(client->dev.of_node,
-						   "maxim,max77836-battery")) {
+	if (client->irq && chip->data.has_low_soc_alert) {
 		ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 		if (ret) {
 			dev_err(&client->dev,
@@ -391,16 +493,30 @@ static SIMPLE_DEV_PM_OPS(max17040_pm_ops, max17040_suspend, max17040_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id max17040_id[] = {
-	{ "max17040" },
-	{ "max77836-battery" },
-	{ }
+	{ "max17040", ID_MAX17040 },
+	{ "max17041", ID_MAX17041 },
+	{ "max17043", ID_MAX17043 },
+	{ "max77836-battery", ID_MAX17043 },
+	{ "max17044", ID_MAX17044 },
+	{ "max17048", ID_MAX17048 },
+	{ "max17049", ID_MAX17049 },
+	{ "max17058", ID_MAX17058 },
+	{ "max17059", ID_MAX17059 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, max17040_id);
 
 static const struct of_device_id max17040_of_match[] = {
-	{ .compatible = "maxim,max17040" },
-	{ .compatible = "maxim,max77836-battery" },
-	{ },
+	{ .compatible = "maxim,max17040", .data = (void *) ID_MAX17040 },
+	{ .compatible = "maxim,max17041", .data = (void *) ID_MAX17041 },
+	{ .compatible = "maxim,max17043", .data = (void *) ID_MAX17043 },
+	{ .compatible = "maxim,max77836-battery", .data = (void *) ID_MAX17043 },
+	{ .compatible = "maxim,max17044", .data = (void *) ID_MAX17044 },
+	{ .compatible = "maxim,max17048", .data = (void *) ID_MAX17048 },
+	{ .compatible = "maxim,max17049", .data = (void *) ID_MAX17049 },
+	{ .compatible = "maxim,max17058", .data = (void *) ID_MAX17058 },
+	{ .compatible = "maxim,max17059", .data = (void *) ID_MAX17059 },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, max17040_of_match);
 
-- 
2.28.0

