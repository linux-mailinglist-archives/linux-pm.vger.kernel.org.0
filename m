Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6811F1EF0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFHS1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFHS1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 14:27:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08094C08C5C2;
        Mon,  8 Jun 2020 11:27:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so18506890wru.6;
        Mon, 08 Jun 2020 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0p8G4jy7duBeFL/DgAvbOhr8owC3HKDZl127ElWut+c=;
        b=ocTUakuA7N3VGGSOJlEBp5m1eIh7M4/RrXzMhhfzP08XfN8LsahGTjEO2XRSr7H1sR
         TJR8AeXewZBh8UHJDIG3xii42JRjQAykg1ni0OV+ql7NVz+A9orAWoeJagAiKmRhqqR5
         5Ttx+wyENvcS3VIskzhm6zB2vp9ORPVtDDtPnS7eByjKzPCV1E/aj1Hxyph8S4mIWfQy
         50KwniK0pzoUVdFSokuinmBGEc6I2hrOyLpaY9M2DfvDOyy2hCoGoCOZMafH2tyybeDD
         ZUk+mnIFYfKsS2APkhcZUdYjHs2ju6YrMXiq+ltLGyx986gec8eB2OfGNIkWxlOKsoMs
         UvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0p8G4jy7duBeFL/DgAvbOhr8owC3HKDZl127ElWut+c=;
        b=S1orC1VCP3WsNUgN70/kcHFcz5EdosA8UWxiohgprHKqwhRi5xiCxKUsYSE7Tum7EU
         JSL565Z+uf0Qhiwa07swx56NoY1cBQTCHKw/GqQo0HxhJZFpwzdCeQH2MADeht6qIfhV
         M8Pb3OXOHv0ac61sxTiNoyPnity8uT+CvWWddu7GhaJHeKzFQMwFES1acYfsK+DTqDtc
         JqPaM9+eTd+EImhG6K+QFhKvkXw2kUf/SIf3c+5w6+jFvxJ1N1tx2vrvM3BfrSAuyxej
         7VcCzTELLa3DUf0dCIzDM0+INUalsbUYpbguAyt+vTcCJiu/nNlcep3Ki94F9rxUG9J1
         CAiw==
X-Gm-Message-State: AOAM530tnW9fA+dubvVejXuvc5O+5IUJRmQniFzi71tQ87GOj6nUY1rO
        byn0Jw2RLI7P9di03aye7oYqyjGe9uS/Jg==
X-Google-Smtp-Source: ABdhPJzFmBDrxtJS/bkoh3mRz31u8QqIOZU52shKxdtRUr0LUtJmKIzgZveRntfkOHlx6jP+OFTmHQ==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr147812wru.102.1591640827539;
        Mon, 08 Jun 2020 11:27:07 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id k64sm355091wmf.34.2020.06.08.11.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 11:27:06 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH 2/2] power: supply: max17040: Support compatible devices
Date:   Mon,  8 Jun 2020 21:26:42 +0300
Message-Id: <20200608182642.592848-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608182642.592848-1-iskren.chernev@gmail.com>
References: <20200608182642.592848-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The max17040 fuel gauge is part of a family of 8 chips that have very
similar mode of operations and registers.

This change adds:
- compatible strings for all supported devices and handles the minor
  differences between them;
- handling for devices reporting double capacity via maxim,double-soc;
- handling for setting rcomp, a compensation value for more accurate
  reading, affected by battery chemistry and operating temps;
- suppot for SOC alerts (capacity changes by +/- 1%), to prevent polling
  every second;
- redo i2c read/writes via regmap

The datasheets of the supported devices are linked [0] [1] [2] [3].

[0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
[1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
[2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
[3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/power/supply/Kconfig            |  11 +-
 drivers/power/supply/max17040_battery.c | 458 +++++++++++++++++-------
 2 files changed, 330 insertions(+), 139 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 44d3c8512fb8d..c5580b858ce4b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -368,9 +368,14 @@ config BATTERY_MAX17040
 	tristate "Maxim MAX17040 Fuel Gauge"
 	depends on I2C
 	help
-	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
-	  in handheld and portable equipment. The MAX17040 is configured
-	  to operate with a single lithium cell
+	  Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
+	  (Li+) batteries in handheld and portable equipment, include max17040,
+	  max17041, max17043, max17044, max17048, max17049, max17058, max17059.
+	  It is also included in some mfd devices like max77836.
+
+	  Driver supports reporting SOC (State of Charge, i.e capacity),
+	  voltage and configurable low-SOC wakeup interrupt. For certain models
+	  a SOC change interrupt is also supported.
 
 config BATTERY_MAX17042
 	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 48aa44665e2f1..4fd6cf7b60c71 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -15,193 +15,336 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
+#include <linux/of_device.h>
 #include <linux/max17040_battery.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #define MAX17040_VCELL	0x02
 #define MAX17040_SOC	0x04
 #define MAX17040_MODE	0x06
 #define MAX17040_VER	0x08
-#define MAX17040_RCOMP	0x0C
+#define MAX17040_CONFIG	0x0C
+#define MAX17040_STATUS	0x1A
 #define MAX17040_CMD	0xFE
 
 
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95
+#define MAX17040_RCOMP_DEFAULT  0x9700
 
-#define MAX17040_ATHD_MASK		0xFFC0
+#define MAX17040_ATHD_MASK		0x3f
+#define MAX17040_ALSC_MASK		0x40
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
+#define MAX17040_STATUS_HD_MASK		0x1000
+#define MAX17040_STATUS_SC_MASK		0x2000
+#define MAX17040_CFG_RCOMP_MASK		0xff00
+
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
+	u8  rcomp_bytes;
+	u8  has_low_soc_alert;
+	u8  has_soc_alert;
+};
+
+struct chip_data max17040_family[] = {
+	[ID_MAX17040] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 1250,
+		.vcell_div = 1,
+		.rcomp_bytes = 2,
+		.has_low_soc_alert = 0,
+		.has_soc_alert = 0,
+	},
+	[ID_MAX17041] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 2500,
+		.vcell_div = 1,
+		.rcomp_bytes = 2,
+		.has_low_soc_alert = 0,
+		.has_soc_alert = 0,
+	},
+	[ID_MAX17043] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 1250,
+		.vcell_div = 1,
+		.rcomp_bytes = 1,
+		.has_low_soc_alert = 1,
+		.has_soc_alert = 0,
+	},
+	[ID_MAX17044] = {
+		.reset_val = 0x0054,
+		.vcell_shift = 4,
+		.vcell_mul = 2500,
+		.vcell_div = 1,
+		.rcomp_bytes = 1,
+		.has_low_soc_alert = 1,
+		.has_soc_alert = 0,
+	},
+	[ID_MAX17048] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 8,
+		.rcomp_bytes = 1,
+		.has_low_soc_alert = 1,
+		.has_soc_alert = 1,
+	},
+	[ID_MAX17049] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 4,
+		.rcomp_bytes = 1,
+		.has_low_soc_alert = 1,
+		.has_soc_alert = 1,
+	},
+	[ID_MAX17058] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 8,
+		.rcomp_bytes = 1,
+		.has_low_soc_alert = 1,
+		.has_soc_alert = 0,
+	},
+	[ID_MAX17059] = {
+		.reset_val = 0x5400,
+		.vcell_shift = 0,
+		.vcell_mul = 625,
+		.vcell_div = 4,
+		.rcomp_bytes = 1,
+		.has_low_soc_alert = 1,
+		.has_soc_alert = 0,
+	},
+};
 
 struct max17040_chip {
 	struct i2c_client		*client;
+	struct regmap			*regmap;
 	struct delayed_work		work;
 	struct power_supply		*battery;
 	struct max17040_platform_data	*pdata;
+	struct chip_data		data;
 
-	/* State Of Connect */
-	int online;
-	/* battery voltage */
-	int vcell;
 	/* battery capacity */
 	int soc;
 	/* State Of Charge */
 	int status;
+
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert;
+	/* some devices return twice the capacity */
+	bool quirk_double_soc;
+	/* higher 8 bits for 17043+, 16 bits for 17040,41 */
+	u16 rcomp;
 };
 
-static int max17040_get_property(struct power_supply *psy,
-			    enum power_supply_property psp,
-			    union power_supply_propval *val)
+static int max17040_reset(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = chip->status;
-		break;
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = chip->online;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = chip->vcell;
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = chip->soc;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
+	return regmap_write(chip->regmap, MAX17040_CMD, chip->data.reset_val);
 }
 
-static int max17040_write_reg(struct i2c_client *client, int reg, u16 value)
+static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
 {
-	int ret;
-
-	ret = i2c_smbus_write_word_swapped(client, reg, value);
-
-	if (ret < 0)
-		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+	level = 32 - level;
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
+			MAX17040_ATHD_MASK, level);
+}
 
-	return ret;
+static int max17040_set_soc_alert(struct max17040_chip *chip, bool enable)
+{
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
+			MAX17040_ALSC_MASK, enable ? MAX17040_ALSC_MASK : 0);
 }
 
-static int max17040_read_reg(struct i2c_client *client, int reg)
+/* Returns true iff alert cause was SOC change, not low SOC */
+static bool max17040_handle_soc_alert(struct max17040_chip *chip)
 {
-	int ret;
+	bool ret = true;
+	u32 data;
 
-	ret = i2c_smbus_read_word_swapped(client, reg);
+	regmap_read(chip->regmap, MAX17040_STATUS, &data);
 
-	if (ret < 0)
-		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+	if (data & MAX17040_STATUS_HD_MASK) {
+		// this alert was caused by low soc
+		ret = false;
+	}
+	if (data & MAX17040_STATUS_SC_MASK) {
+		// soc change bit -- deassert to mark as handled
+		regmap_write(chip->regmap, MAX17040_STATUS,
+				data & ~MAX17040_STATUS_SC_MASK);
+	}
 
 	return ret;
 }
 
-static void max17040_reset(struct i2c_client *client)
+static int max17040_set_rcomp(struct max17040_chip *chip, u16 rcomp)
 {
-	max17040_write_reg(client, MAX17040_CMD, 0x0054);
+	u16 mask = chip->data.rcomp_bytes == 2 ?
+		0xffff : MAX17040_CFG_RCOMP_MASK;
+
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG, mask, rcomp);
 }
 
-static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
+static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
 {
-	int ret;
-	u16 data;
-
-	level = 32 - level;
-	data = max17040_read_reg(client, MAX17040_RCOMP);
-	/* clear the alrt bit and set LSb 5 bits */
-	data &= MAX17040_ATHD_MASK;
-	data |= level;
-	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
+	struct chip_data *d = &chip->data;
 
-	return ret;
+	return (vcell >> d->vcell_shift) * d->vcell_mul / d->vcell_div;
 }
 
-static void max17040_get_vcell(struct i2c_client *client)
+static int max17040_get_vcell(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u16 vcell;
+	u32 vcell;
 
-	vcell = max17040_read_reg(client, MAX17040_VCELL);
+	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
 
-	chip->vcell = (vcell >> 4) * 1250;
+	return max17040_raw_vcell_to_uvolts(chip, vcell);
 }
 
-static void max17040_get_soc(struct i2c_client *client)
+static int max17040_raw_soc_to_percent(struct max17040_chip *chip, u16 soc)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u16 soc;
+	int shift = 8;
 
-	soc = max17040_read_reg(client, MAX17040_SOC);
+	if (chip->quirk_double_soc)
+		shift += 1;
 
-	chip->soc = (soc >> 8);
+	return soc >> shift;
 }
 
-static void max17040_get_version(struct i2c_client *client)
+static int max17040_get_soc(struct max17040_chip *chip)
 {
-	u16 version;
+	u32 soc;
 
-	version = max17040_read_reg(client, MAX17040_VER);
+	regmap_read(chip->regmap, MAX17040_SOC, &soc);
 
-	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
+	return max17040_raw_soc_to_percent(chip, soc);
 }
 
-static void max17040_get_online(struct i2c_client *client)
+static void max17040_get_version(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
+	u32 version;
 
-	if (chip->pdata && chip->pdata->battery_online)
-		chip->online = chip->pdata->battery_online();
-	else
-		chip->online = 1;
+	regmap_read(chip->regmap, MAX17040_VER, &version);
+
+	dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
 }
 
-static void max17040_get_status(struct i2c_client *client)
+static int max17040_get_online(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
+	return chip->pdata && chip->pdata->battery_online ?
+		chip->pdata->battery_online() : 1;
+}
 
+static int max17040_get_status(struct max17040_chip *chip)
+{
 	if (!chip->pdata || !chip->pdata->charger_online
 			|| !chip->pdata->charger_enable) {
-		chip->status = POWER_SUPPLY_STATUS_UNKNOWN;
-		return;
+		return POWER_SUPPLY_STATUS_UNKNOWN;
 	}
 
+	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
+		return POWER_SUPPLY_STATUS_FULL;
+
 	if (chip->pdata->charger_online()) {
 		if (chip->pdata->charger_enable())
-			chip->status = POWER_SUPPLY_STATUS_CHARGING;
+			return POWER_SUPPLY_STATUS_CHARGING;
 		else
-			chip->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			return POWER_SUPPLY_STATUS_NOT_CHARGING;
 	} else {
-		chip->status = POWER_SUPPLY_STATUS_DISCHARGING;
+		return POWER_SUPPLY_STATUS_DISCHARGING;
 	}
+}
 
-	if (chip->soc > MAX17040_BATTERY_FULL)
-		chip->status = POWER_SUPPLY_STATUS_FULL;
+static int max17040_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = max17040_get_status(chip);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = max17040_get_online(chip);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = max17040_get_vcell(chip);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = max17040_get_soc(chip);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
 }
 
+
 static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
+	int rcomp_len;
+	u8 rcomp[2];
 
 	chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
 	device_property_read_u32(dev,
 				 "maxim,alert-low-soc-level",
 				 &chip->low_soc_alert);
 
-	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
+	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
+		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
+		return -EINVAL;
+	}
+
+	chip->quirk_double_soc = device_property_read_bool(dev,
+							   "maxim,double-soc");
+	rcomp_len = device_property_count_u8(dev, "maxim,rcomp");
+	chip->rcomp = MAX17040_RCOMP_DEFAULT;
+	if (rcomp_len == chip->data.rcomp_bytes) {
+		device_property_read_u8_array(dev, "maxim,rcomp",
+					      rcomp, rcomp_len);
+		chip->rcomp = rcomp_len == 2 ?
+			rcomp[0] << 8 | rcomp[1] :
+			rcomp[0] << 8;
+	} else if (rcomp_len > 0) {
+		dev_err(dev, "maxim,rcomp has incorrect length\n");
 		return -EINVAL;
+	}
 
 	return 0;
 }
 
-static void max17040_check_changes(struct i2c_client *client)
+static void max17040_check_changes(struct max17040_chip *chip)
 {
-	max17040_get_vcell(client);
-	max17040_get_soc(client);
-	max17040_get_online(client);
-	max17040_get_status(client);
+	chip->soc = max17040_get_soc(chip);
+	chip->status = max17040_get_status(chip);
+}
+
+static void max17040_queue_work(struct max17040_chip *chip)
+{
+	queue_delayed_work(system_power_efficient_wq, &chip->work,
+			   MAX17040_DELAY);
 }
 
 static void max17040_work(struct work_struct *work)
@@ -214,35 +357,42 @@ static void max17040_work(struct work_struct *work)
 	/* store SOC and status to check changes */
 	last_soc = chip->soc;
 	last_status = chip->status;
-	max17040_check_changes(chip->client);
+	max17040_check_changes(chip);
 
 	/* check changes and send uevent */
 	if (last_soc != chip->soc || last_status != chip->status)
 		power_supply_changed(chip->battery);
 
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
+	max17040_queue_work(chip);
+}
+
+static void max17040_stop_work(void *data)
+{
+	struct max17040_chip *chip = data;
+
+	cancel_delayed_work_sync(&chip->work);
 }
 
 static irqreturn_t max17040_thread_handler(int id, void *dev)
 {
 	struct max17040_chip *chip = dev;
-	struct i2c_client *client = chip->client;
 
-	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	if (!(chip->data.has_soc_alert && max17040_handle_soc_alert(chip)))
+		dev_warn(&chip->client->dev, "IRQ: Alert battery low level\n");
+
 	/* read registers */
-	max17040_check_changes(chip->client);
+	max17040_check_changes(chip);
 
 	/* send uevent */
 	power_supply_changed(chip->battery);
 
-	/* reset alert bit */
-	max17040_set_low_soc_alert(client, chip->low_soc_alert);
+	/* reset low soc alert bit */
+	max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 
 	return IRQ_HANDLED;
 }
 
-static int max17040_enable_alert_irq(struct max17040_chip *chip)
+static int max17040_setup_irq(struct max17040_chip *chip)
 {
 	struct i2c_client *client = chip->client;
 	unsigned int flags;
@@ -256,6 +406,13 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
 	return ret;
 }
 
+static const struct regmap_config max17040_regmap = {
+	.reg_bits	= 8,
+	.reg_stride	= 2,
+	.val_bits	= 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -277,6 +434,8 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	enum chip_id chip_id;
+	bool enable_irq = false;
 	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
@@ -287,38 +446,61 @@ static int max17040_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->client = client;
+	chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
 	chip->pdata = client->dev.platform_data;
-	ret = max17040_get_of_data(chip);
-	if (ret) {
-		dev_err(&client->dev,
-			"failed: low SOC alert OF data out of bounds\n");
-		return ret;
+	chip_id = (enum chip_id) id->driver_data;
+	if (client->dev.of_node) {
+		ret = max17040_get_of_data(chip);
+		if (ret)
+			return ret;
+		chip_id = (enum chip_id) of_device_get_match_data(&client->dev);
 	}
+	chip->data = max17040_family[chip_id];
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
 
-	chip->battery = power_supply_register(&client->dev,
-				&max17040_battery_desc, &psy_cfg);
+	chip->battery = devm_power_supply_register(&client->dev,
+					&max17040_battery_desc, &psy_cfg);
 	if (IS_ERR(chip->battery)) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return PTR_ERR(chip->battery);
 	}
 
-	max17040_reset(client);
-	max17040_get_version(client);
+	max17040_reset(chip);
+	max17040_get_version(chip);
+	max17040_set_rcomp(chip, chip->rcomp);
 
 	/* check interrupt */
-	if (client->irq && of_device_is_compatible(client->dev.of_node,
-						   "maxim,max77836-battery")) {
-		ret = max17040_set_low_soc_alert(client, chip->low_soc_alert);
+	if (client->irq && chip->data.has_low_soc_alert) {
+		ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 		if (ret) {
 			dev_err(&client->dev,
 				"Failed to set low SOC alert: err %d\n", ret);
 			return ret;
 		}
+		enable_irq = true;
+	}
+
+	if (client->irq && chip->data.has_soc_alert) {
+		ret = max17040_set_soc_alert(chip, 1);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to set SOC alert: err %d\n", ret);
+			return ret;
+		}
+		enable_irq = true;
+	} else {
+		/* soc alerts negate the need for polling */
+		INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
+		ret = devm_add_action(&client->dev, max17040_stop_work, chip);
+		if (ret)
+			return ret;
+		max17040_queue_work(chip);
+	}
 
-		ret = max17040_enable_alert_irq(chip);
+	if (enable_irq) {
+		ret = max17040_setup_irq(chip);
 		if (ret) {
 			client->irq = 0;
 			dev_warn(&client->dev,
@@ -326,19 +508,6 @@ static int max17040_probe(struct i2c_client *client,
 		}
 	}
 
-	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
-
-	return 0;
-}
-
-static int max17040_remove(struct i2c_client *client)
-{
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-
-	power_supply_unregister(chip->battery);
-	cancel_delayed_work(&chip->work);
 	return 0;
 }
 
@@ -349,10 +518,13 @@ static int max17040_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	cancel_delayed_work(&chip->work);
-
 	if (client->irq && device_may_wakeup(dev))
 		enable_irq_wake(client->irq);
+	if (client->irq && chip->data.has_soc_alert)
+		// disable soc alert to prevent wakeup
+		max17040_set_soc_alert(chip, 0);
+	else
+		cancel_delayed_work(&chip->work);
 
 	return 0;
 }
@@ -362,11 +534,12 @@ static int max17040_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
-
 	if (client->irq && device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
+	if (client->irq && chip->data.has_soc_alert)
+		max17040_set_soc_alert(chip, 1);
+	else
+		max17040_queue_work(chip);
 
 	return 0;
 }
@@ -381,16 +554,30 @@ static SIMPLE_DEV_PM_OPS(max17040_pm_ops, max17040_suspend, max17040_resume);
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
 
@@ -401,7 +588,6 @@ static struct i2c_driver max17040_i2c_driver = {
 		.pm	= MAX17040_PM_OPS,
 	},
 	.probe		= max17040_probe,
-	.remove		= max17040_remove,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
-- 
2.27.0

