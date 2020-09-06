Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B2925F0C0
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 23:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIFVcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgIFVbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 17:31:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1DC061574;
        Sun,  6 Sep 2020 14:31:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so13426014wrx.7;
        Sun, 06 Sep 2020 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkuoLunr5qUAIVwr2u2zhFnUsW+xsvoSG3v3TVA3M5A=;
        b=kLsGjjnhkw3s6lfY+YkRiwNUvD87PyhnuDVANRCi2tZoedbx1bRZ3TPlHaUMFfrqMh
         H8lnndMT3D3f5ayhH3uw77zprGn6vUAW1LhFhz2XhX2SeIkSSnObXmzn0NBKNdLzJ1wl
         Ckn8OLDCKR4d9zF67Hf2cD4OJEDYE76aIJjJ6IwiFxCla9a9cyl/H5tIph1VZFjHTRyh
         sYHstQWRTnEZFTKSthhB2w9Uj2c8pfsz4SKDV0T5Ep3nlSczgCTa1bmBs+dkOLxRrJnL
         uCvJJRFfVaXgWrdyI5rVGdpcWNjsBdg3KxYzbVH5mEwB6DfJ+zaJ9HQSNA/rwAu8BCje
         ejbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkuoLunr5qUAIVwr2u2zhFnUsW+xsvoSG3v3TVA3M5A=;
        b=uSDSqnaMJOXZ1NNaYj4Sz9D1/X0doKf4r9JHWDeHfNOr2HZTdaOqx0ghfXAJ+7qEGA
         4Dnr08G/2BTAdub28Nq8+HM08HxhzXmGztBGV9Tpm+hZCkRMbdj+Ue1qLrSftsmAjmGM
         vUaxToM0en3A9NrivAjzKYhnq+2+jMP7QgZrdoyN7zmMXLeDBxLX0xWzNGYqTL0/+U4/
         108TMLrOGMOYp1RXTc+4DuNEjJxEyy7jEMsNI0OSr7MRao761AdSvI/jVdVoQ8ATZ1QY
         PYX7R+6m1J+SyNy3BGHs8SC0DLxpJayTEmoSDFUcky+syJmhrYsC3uP3szfK4zO5ib2Y
         HJPg==
X-Gm-Message-State: AOAM532r62bmdOYD1fiELC9Gt8gPNqbHD1h3qlfIoI7UJfonPYxxLWDM
        6GMy7YyGjEzg6Ws7uR29gFw=
X-Google-Smtp-Source: ABdhPJyidfFrD+MsOr72WAzOKM8xn1NJrUU9bmk0ekU29Ro6Xmaoizy3zecKMPT3PVJvncnHrjOnKA==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr17975259wrt.290.1599427880865;
        Sun, 06 Sep 2020 14:31:20 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id q20sm22770208wmj.5.2020.09.06.14.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 14:31:20 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <me@iskren.info>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v4 2/7] power: supply: max17040: Use regmap i2c
Date:   Mon,  7 Sep 2020 00:30:51 +0300
Message-Id: <20200906213056.2161410-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906213056.2161410-1-iskren.chernev@gmail.com>
References: <20200906213056.2161410-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Iskren Chernev <me@iskren.info>

Rewrite i2c operations from i2c client read/write to regmap i2c. As
a result, most private functions now accept the private driver data
instead of an i2c client pointer.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Tested-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/Kconfig            |   1 +
 drivers/power/supply/max17040_battery.c | 219 ++++++++++--------------
 2 files changed, 93 insertions(+), 127 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index d1ccf17df42e9..1e11a44077dde 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -367,6 +367,7 @@ config AXP288_FUEL_GAUGE
 config BATTERY_MAX17040
 	tristate "Maxim MAX17040 Fuel Gauge"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
 	  in handheld and portable equipment. The MAX17040 is configured
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 19b9e710bbd2f..fae4217960761 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -16,32 +16,30 @@
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/max17040_battery.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #define MAX17040_VCELL	0x02
 #define MAX17040_SOC	0x04
 #define MAX17040_MODE	0x06
 #define MAX17040_VER	0x08
-#define MAX17040_RCOMP	0x0C
+#define MAX17040_CONFIG	0x0C
 #define MAX17040_CMD	0xFE
 
 
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95
 
-#define MAX17040_ATHD_MASK		0xFFC0
+#define MAX17040_ATHD_MASK		0x3f
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
 
 struct max17040_chip {
 	struct i2c_client		*client;
+	struct regmap			*regmap;
 	struct delayed_work		work;
 	struct power_supply		*battery;
 	struct max17040_platform_data	*pdata;
 
-	/* State Of Connect */
-	int online;
-	/* battery voltage */
-	int vcell;
 	/* battery capacity */
 	int soc;
 	/* State Of Charge */
@@ -50,138 +48,68 @@ struct max17040_chip {
 	u32 low_soc_alert;
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
-	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
-		val->intval = chip->low_soc_alert;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
+	return regmap_write(chip->regmap, MAX17040_CMD, 0x0054);
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
-
-	return ret;
-}
-
-static int max17040_read_reg(struct i2c_client *client, int reg)
-{
-	int ret;
-
-	ret = i2c_smbus_read_word_swapped(client, reg);
-
-	if (ret < 0)
-		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
-
-	return ret;
-}
-
-static void max17040_reset(struct i2c_client *client)
-{
-	max17040_write_reg(client, MAX17040_CMD, 0x0054);
-}
-
-static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
-{
-	int ret;
-	u16 data;
-
 	level = 32 - level;
-	data = max17040_read_reg(client, MAX17040_RCOMP);
-	/* clear the alrt bit and set LSb 5 bits */
-	data &= MAX17040_ATHD_MASK;
-	data |= level;
-	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
-
-	return ret;
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
+			MAX17040_ATHD_MASK, level);
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
+	return (vcell >> 4) * 1250;
 }
 
-static void max17040_get_soc(struct i2c_client *client)
+static int max17040_get_soc(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u16 soc;
+	u32 soc;
 
-	soc = max17040_read_reg(client, MAX17040_SOC);
+	regmap_read(chip->regmap, MAX17040_SOC, &soc);
 
-	chip->soc = (soc >> 8);
+	return soc >> 8;
 }
 
-static void max17040_get_version(struct i2c_client *client)
+static int max17040_get_version(struct max17040_chip *chip)
 {
-	u16 version;
+	int ret;
+	u32 version;
 
-	version = max17040_read_reg(client, MAX17040_VER);
+	ret = regmap_read(chip->regmap, MAX17040_VER, &version);
 
-	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
+	return ret ? ret : version;
 }
 
-static void max17040_get_online(struct i2c_client *client)
+static int max17040_get_online(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-
-	if (chip->pdata && chip->pdata->battery_online)
-		chip->online = chip->pdata->battery_online();
-	else
-		chip->online = 1;
+	return chip->pdata && chip->pdata->battery_online ?
+		chip->pdata->battery_online() : 1;
 }
 
-static void max17040_get_status(struct i2c_client *client)
+static int max17040_get_status(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-
 	if (!chip->pdata || !chip->pdata->charger_online
-			|| !chip->pdata->charger_enable) {
-		chip->status = POWER_SUPPLY_STATUS_UNKNOWN;
-		return;
-	}
+			|| !chip->pdata->charger_enable)
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+
+	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
+		return POWER_SUPPLY_STATUS_FULL;
 
-	if (chip->pdata->charger_online()) {
+	if (chip->pdata->charger_online())
 		if (chip->pdata->charger_enable())
-			chip->status = POWER_SUPPLY_STATUS_CHARGING;
+			return POWER_SUPPLY_STATUS_CHARGING;
 		else
-			chip->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	} else {
-		chip->status = POWER_SUPPLY_STATUS_DISCHARGING;
-	}
-
-	if (chip->soc > MAX17040_BATTERY_FULL)
-		chip->status = POWER_SUPPLY_STATUS_FULL;
+			return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	else
+		return POWER_SUPPLY_STATUS_DISCHARGING;
 }
 
 static int max17040_get_of_data(struct max17040_chip *chip)
@@ -193,18 +121,18 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 				 "maxim,alert-low-soc-level",
 				 &chip->low_soc_alert);
 
-	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
+	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
+		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
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
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -230,7 +158,7 @@ static void max17040_work(struct work_struct *work)
 	/* store SOC and status to check changes */
 	last_soc = chip->soc;
 	last_status = chip->status;
-	max17040_check_changes(chip->client);
+	max17040_check_changes(chip);
 
 	/* check changes and send uevent */
 	if (last_soc != chip->soc || last_status != chip->status)
@@ -242,17 +170,17 @@ static void max17040_work(struct work_struct *work)
 static irqreturn_t max17040_thread_handler(int id, void *dev)
 {
 	struct max17040_chip *chip = dev;
-	struct i2c_client *client = chip->client;
 
-	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	dev_warn(&chip->client->dev, "IRQ: Alert battery low level");
+
 	/* read registers */
-	max17040_check_changes(chip->client);
+	max17040_check_changes(chip);
 
 	/* send uevent */
 	power_supply_changed(chip->battery);
 
 	/* reset alert bit */
-	max17040_set_low_soc_alert(client, chip->low_soc_alert);
+	max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 
 	return IRQ_HANDLED;
 }
@@ -296,7 +224,7 @@ static int max17040_set_property(struct power_supply *psy,
 			ret = -EINVAL;
 			break;
 		}
-		ret = max17040_set_low_soc_alert(chip->client, val->intval);
+		ret = max17040_set_low_soc_alert(chip, val->intval);
 		chip->low_soc_alert = val->intval;
 		break;
 	default:
@@ -306,6 +234,41 @@ static int max17040_set_property(struct power_supply *psy,
 	return ret;
 }
 
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
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+		val->intval = chip->low_soc_alert;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
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
@@ -340,13 +303,11 @@ static int max17040_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->client = client;
+	chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
 	chip->pdata = client->dev.platform_data;
 	ret = max17040_get_of_data(chip);
-	if (ret) {
-		dev_err(&client->dev,
-			"failed: low SOC alert OF data out of bounds\n");
+	if (ret)
 		return ret;
-	}
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -358,13 +319,17 @@ static int max17040_probe(struct i2c_client *client,
 		return PTR_ERR(chip->battery);
 	}
 
-	max17040_reset(client);
-	max17040_get_version(client);
+	ret = max17040_get_version(chip);
+	if (ret < 0)
+		return ret;
+	dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", ret);
+
+	max17040_reset(chip);
 
 	/* check interrupt */
 	if (client->irq && of_device_is_compatible(client->dev.of_node,
 						   "maxim,max77836-battery")) {
-		ret = max17040_set_low_soc_alert(client, chip->low_soc_alert);
+		ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 		if (ret) {
 			dev_err(&client->dev,
 				"Failed to set low SOC alert: err %d\n", ret);
-- 
2.28.0

