Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7E207816
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404680AbgFXP46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404351AbgFXP4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:56:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697DC061573;
        Wed, 24 Jun 2020 08:56:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a6so4805671wmm.0;
        Wed, 24 Jun 2020 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nq5MutCQT0SiML9JL/q+gTxw20ECC/qdRqSpoL/QOE4=;
        b=bBwuVeiMbtYOEnr7NWJYW3tx8PAsZxUWwhCzmN+Ii4KQCN+6cS8VGRbHy0CSIPacr2
         u64PKHCw19gi3Ih4FX2f0TL7bIQXHXZ2zEXc4yaP53kT3ts5VuUq4HuL6kayDt9+gXUD
         UV47IFhhUBqFqDZy/fxAo420RhnaYRAGSZ9+m/qAHkDxuhzjuKf+OSAkNtfGgrlTj14W
         Bcu2QEHqk2NkNnznvEtOWOBJpomNqnU2SxHKZtNPOx2rZuWh+1zCUVhlNNUpkfQjNo9l
         vHE+PvyIT1bMcQNwpaKPxoi2wT5Rk/iGn9WYnEwPJzp0dxysEAw/8HicbuzaztCnPmBr
         5h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nq5MutCQT0SiML9JL/q+gTxw20ECC/qdRqSpoL/QOE4=;
        b=gKsjRNX/B9/vXvAaNKvenh/zBsLKBIZmnZ93AJcApx8dsvtG+QHKnWnCUq8HSEeFu9
         Zrsdy7T2XQ+vzYOHBYTFglrmWPGFUPt4Bn8Tff4NARHjXP722JO1l3JwOntzjtGXHLDo
         I1DJvDi+2NPBVbfjWhqgkuRB1Pz/3+CfLOqhGE9ixa/hRh2qmw3thjYL9E485fl5gzUg
         1piJq4IdIw0KX2TyuMnQ4COZ2HtLVVvJspV1mPaWEcstNEI6g2xGxwtcJTFrLHotGuMh
         xzuTo9xhNQFekc6fGmTEaAxxEifF68lp5pazARPPvoANATTJVfCq4s6uVyP1ax1nIv4A
         wn4g==
X-Gm-Message-State: AOAM5322Tr2Z87tf2ErXY5l1t4R+zYc+IMigyTePnzLJRiGcyqRfmHCQ
        j9yvFvbOYb81hD5CSk3lduw=
X-Google-Smtp-Source: ABdhPJz9Sdqj/WkQ7YmM1rn8Ol1ezkdlcvp+Y61As7lkTPxg3MWyUwe1nLRN8SDGHUWsXx9gtavj+Q==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr16898498wma.73.1593014213060;
        Wed, 24 Jun 2020 08:56:53 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id l14sm10966651wrn.18.2020.06.24.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:56:52 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 3/6] power: supply: max17040: Support compatible devices
Date:   Wed, 24 Jun 2020 18:56:30 +0300
Message-Id: <20200624155633.3557401-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624155633.3557401-1-iskren.chernev@gmail.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
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
---
 drivers/power/supply/Kconfig            |  10 +-
 drivers/power/supply/max17040_battery.c | 143 +++++++++++++++++++++---
 2 files changed, 135 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 12ca79952768f..0efdb282fea28 100644
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
index 678241fcc2548..a6ecd84194e51 100644
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
@@ -46,11 +127,13 @@ struct max17040_chip {
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
@@ -60,13 +143,21 @@ static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
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
@@ -125,6 +216,8 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
 		return -EINVAL;
 	}
+	chip->quirk_double_soc = device_property_read_bool(dev,
+							   "maxim,double-soc");
 
 	return 0;
 }
@@ -252,6 +345,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	enum chip_id chip_id;
 	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
@@ -264,9 +358,14 @@ static int max17040_probe(struct i2c_client *client,
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
@@ -283,11 +382,11 @@ static int max17040_probe(struct i2c_client *client,
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
@@ -350,16 +449,30 @@ static SIMPLE_DEV_PM_OPS(max17040_pm_ops, max17040_suspend, max17040_resume);
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
2.27.0

